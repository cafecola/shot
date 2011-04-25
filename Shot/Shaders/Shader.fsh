//
//  Shader.fsh
//  Shot
//
//  Created by moonyoung on 11. 4. 25..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
