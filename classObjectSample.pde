int eNum = 50;//作成、描画する円の数(初期値）

ArrayList<circleObject> co;//クラスオブジェクトの動的配列 co を宣言


void setup() {
  size( 512, 512, P2D );
  colorMode( HSB, 360, 100, 100, 100);
  noStroke();
  ellipseMode(CENTER);//この命令で、円の描画をellipse(中心X,中心Y,横サイズ,縦サイズ)の形式に変更

  //クラスオブジェクトの動的配列関連の処理
  co = new ArrayList<circleObject>();
  for ( int i = 0; i< eNum; i++ ) {
    //設定した初期値の分だけ、クラスオブジェクトを作成 ＆ 配列に追加
    co.add( new circleObject());
    // new circleObject() で、クラスcircleObjectのインスタンスを作成している
    //クラスのコンストラクタで位置とか移動方向とかをランダムに決定している
  }
}

void draw() {
  if ( frameCount==1 ) {
    background(0);
    //描画の最初だけ、背景を黒く塗る
    //実際には、各フレームで描画されるのは円なのだが、
    //途中で背景の塗り直しをしないため、線が延びていくような絵になる
  }
  for ( int i=0; i<co.size(); i++ ) {
    circleObject t = co.get( i );
    //動的配列内の各要素にアクセスするには、このように書く
    //段取りとしては、動的配列内の各要素と同じデータ型の変数（ここではt）に、要素を個別に呼び出し、
    //この変数を使ってやりたいことをやる。
    t.draw();
    t.update();
  }
}

void mousePressed() {
  //マウスボタンが押されたら、円を追加
  co.add( new circleObject());
}


////以下、上で利用しているクラス
class circleObject {
  int initMargin=50;//初期配置の際、描画領域に対して設定する隙間（マージン）
  float eSize = 10.0;//円の大きさ。
  float velSize = 0.2;//移動量
  float ang;//移動方向を角度で
  PVector pos, vel;
  color col;
  circleObject() {
    //この関数（クラス名と全く同じ名前の関数）は
    //コンストラクタと呼ばれる「最初に実行される」関数
    //変数の初期化が主な任務

    pos =new PVector(random(initMargin, width-initMargin), random( initMargin, height-initMargin));
    ang = random(0, 2.0*PI);//移動方向（角度）を、ランダムに、かつ、ラジアンで決定
    vel = new PVector( cos( ang ), sin(ang));//昔懐かし（？）三角関数。これで、角度に対応したx、y方向の移動量になる。なるのです。ちなみに、この段階ではベクトルvelの大きさは1（単位ベクトル）ｌ
    vel.mult(velSize);//移動方向の大きさを1からvelSizeに変更（ベクトルのｘ、ｙ成分をvelSize倍）。1のままだと速すぎる。と、思う。
    col = color( random(360), random(30, 70), random( 30, 70), random(0.1, 10) );//それぞれの円の塗り色をランダムに決定
  }

  void draw() {
    //描画処理。それぞれの円に、その瞬間設定されている位置に円を描画
    fill( col );
    ellipse(pos.x, pos.y, eSize, eSize);
  }

  void update() {
    //更新処理 円の位置を表すベクトルにに、移動量のベクトルを
    pos.add( vel );
    //本来ならば、壁に当たったら消去するなり、跳ね返るなりの処理が必要だが、今回はサボる
  }
};
