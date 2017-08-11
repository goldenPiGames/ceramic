import * as React from 'react';
import { observer } from 'mobx-react';
import { project } from 'app/model';
import { context } from 'app/context';
import { EditScene, AddVisual, MenuInfo } from 'app/components';
import MdImage from 'react-icons/lib/md/image';
import MdGridOn from 'react-icons/lib/md/grid-on';

@observer class App extends React.Component {

/// Lifecycle

    render() {

        const navHeight = 22;
        const leftSideWidth = 44;

        return (
            <div
                style={{
                    position: 'relative',
                    left: 0,
                    top: 0,
                    width: context.width,
                    height: context.height
                }}
            >
                <div
                    style={{
                        width: context.width,
                        height: context.height,
                        position: 'absolute',
                        left: 0,
                        top: 0
                    }}
                >
                    <div>
                        {project.ui.addingVisual ?
                            <AddVisual />
                        :
                            null
                        }
                    </div>
                    <div
                        style={{
                            position: 'absolute',
                            left: 0,
                            top: 0,
                            width: '100%',
                            zIndex: 500,
                            lineHeight: navHeight + 'px',
                            height: navHeight,
                            WebkitAppRegion: 'drag',
                            textAlign: 'center'
                        }}
                        className="topnav"
                    >
                        Ceramic Editor
                    </div>
                    <div
                        className="leftside"
                        style={{
                            width: leftSideWidth - 1,
                            height: context.height - navHeight,
                            position: 'absolute',
                            left: 0,
                            top: navHeight
                        }}
                    >
                        <img src="icon-nobg.svg" draggable={false} className="ceramic-icon" />
                        <div className="ceramic-separator" />
                        <div
                            className="leftside-button selected"
                            onMouseOver={(e) => { project.ui.menuInfo = {
                                y: (e.currentTarget as HTMLElement).getClientRects()[0].top,
                                text: 'Scene Editor'
                            }; }}
                            onMouseOut={() => { project.ui.menuInfo = null; }}
                        >
                            <MdImage size={22} style={{ position: 'relative', left: 0.5, top: 2 }} />
                        </div>
                        <div
                            className="leftside-button"
                            onMouseOver={(e) => { project.ui.menuInfo = {
                                y: (e.currentTarget as HTMLElement).getClientRects()[0].top,
                                text: 'Texture Atlas Editor'
                            }; }}
                            onMouseOut={() => { project.ui.menuInfo = null; }}
                        >
                            <MdGridOn size={20} style={{ position: 'relative', left: 0.5, top: 2.5 }} />
                        </div>
                    </div>
                    <div
                        style={{
                            width: context.width - leftSideWidth,
                            height: context.height - navHeight,
                            position: 'absolute',
                            left: leftSideWidth,
                            top: navHeight
                        }}
                    >
                        <div>
                            <MenuInfo />
                        </div>
                        <EditScene width={context.width - leftSideWidth} height={context.height - navHeight} />
                    </div>
                </div>
            </div>
        );

    } //render
    
}

export default App;
