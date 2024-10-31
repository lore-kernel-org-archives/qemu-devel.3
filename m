Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAFAD5CCAC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 12:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6U6v-0004Yy-6V; Thu, 31 Oct 2024 08:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1t6U6t-0004Yo-Nb
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:17:07 -0400
Received: from mx.astralinux.ru ([89.232.161.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1t6U6r-0005cP-4h
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:17:07 -0400
Received: from gca-yc-ruca-srv-mail05.astralinux.ru ([10.177.185.111]
 helo=new-mail.astralinux.ru)
 by mx.astralinux.ru with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <abelova@astralinux.ru>)
 id 1t6U6a-005Z0O-5U; Thu, 31 Oct 2024 15:16:48 +0300
Received: from smtpclient.apple (unknown [10.198.45.243])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XfNK24pD9z1c0mR;
 Thu, 31 Oct 2024 15:16:54 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
Message-Id: <73CD4EAC-F520-4062-AD35-F4657D7649C7@astralinux.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_881A7665-AB5F-452A-BCFD-40EE80585EE5"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] monitor: fix cases in switch in memory_dump
Date: Thu, 31 Oct 2024 14:26:38 +0300
In-Reply-To: <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
To: Phil Dennis-Jordan <lists@philjordan.eu>
References: <20241030140656.36540-1-abelova@astralinux.ru>
 <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffktgggufffjgevvfhfofesrgdtmherhhdtjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepfedvteeiheeihfelfeekveffhfehhffgtdfhhfetffefgfelleejhfejvdfhueetnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrdeghedrvdegfeenucfrrghrrghmpehhvghlohepshhmthhptghlihgvnhhtrdgrphhplhgvpdhinhgvthepuddtrdduleekrdeghedrvdegfeemhedvuddtjedpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhishhtshesphhhihhljhhorhgurghnrdgvuhdprhgtphhtthhopegurghvvgesthhrvggslhhighdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepshgulhdrqhgvmhhusehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.8.202410220#1730372906
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12231671,
 Updated: 2024-Oct-31 10:53:31 UTC]
Received-SPF: pass client-ip=89.232.161.68; envelope-from=abelova@astralinux.ru;
 helo=mx.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_881A7665-AB5F-452A-BCFD-40EE80585EE5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 30 =D0=BE=D0=BA=D1=82. 2024=E2=80=AF=D0=B3., =D0=B2 22:03, Phil =
Dennis-Jordan <lists@philjordan.eu> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB(=D0=B0):
>=20
>=20
> On Wed 30. Oct 2024 at 15:09, Anastasia Belova <abelova@astralinux.ru> =
wrote:
> default case has no condition. So if it is placed
> higher that other cases, they are unreachable.
>=20
> Move dafult case down.
>=20
> The stylistic merits might be debatable, but: the order of cases in a =
switch block in C does not matter, the default case can appear anywhere. =
The other cases are still reachable. So at minimum, the commit message =
is incorrect.
>=20

You=E2=80=99re right, I didn=E2=80=99t know about this. Thank you for =
reply and patience!

Anastasia Belova

> Found by Linux Verification Center (linuxtesting.org)
>=20
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> monitor/hmp-cmds-target.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index ff01cf9d8d..eea8ca047b 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -189,7 +189,6 @@ static void memory_dump(Monitor *mon, int count, =
int format, int wsize,
>       i =3D 0;
>       while (i < l) {
>           switch(wsize) {
> -            default:
>           case 1:
>               v =3D ldub_p(buf + i);
>               break;
> @@ -202,6 +201,9 @@ static void memory_dump(Monitor *mon, int count, =
int format, int wsize,
>           case 8:
>               v =3D ldq_p(buf + i);
>               break;
> +            default:
> +                v =3D ldub_p(buf + i);
> +                break;
>           }
>           monitor_printf(mon, " ");
>           switch(format) {
> --=20
> 2.47.0

--Apple-Mail=_881A7665-AB5F-452A-BCFD-40EE80585EE5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta charset=3D"UTF-8"><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none; caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">30 =D0=BE=D0=BA=D1=
=82. 2024=E2=80=AF=D0=B3., =D0=B2 22:03, Phil Dennis-Jordan =
&lt;lists@philjordan.eu&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=
=B0):<br><br><br>On Wed 30. Oct 2024 at 15:09, Anastasia Belova =
&lt;abelova@astralinux.ru&gt; wrote:<br>default case has no condition. =
So if it is placed<br>higher that other cases, they are =
unreachable.<br><br>Move dafult case down.<br><br>The stylistic merits =
might be debatable, but: the order of cases in a switch block in C does =
not matter, the default case can appear anywhere. The other cases are =
still reachable. So at minimum, the commit message is =
incorrect.<br><br></blockquote><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><span style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none; caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); float: none; display: inline =
!important;">You=E2=80=99re right, I didn=E2=80=99t know about this. =
Thank you for reply and patience!</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none; caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
float: none; display: inline !important;">Anastasia Belova</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Found by Linux Verification Center =
(linuxtesting.org)<br><br>Signed-off-by: Anastasia Belova =
&lt;abelova@astralinux.ru&gt;<br>---<br>monitor/hmp-cmds-target.c | 4 =
+++-<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br>diff --git =
a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c<br>index =
ff01cf9d8d..eea8ca047b 100644<br>--- a/monitor/hmp-cmds-target.c<br>+++ =
b/monitor/hmp-cmds-target.c<br>@@ -189,7 +189,6 @@ static void =
memory_dump(Monitor *mon, int count, int format, int =
wsize,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i =3D =
0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;while (i &lt; l) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch(ws=
ize) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default:=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;v =3D ldub_p(buf + =
i);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;break;<br>@@ -202,6 +201,9 @@ static void =
memory_dump(Monitor *mon, int count, int format, int =
wsize,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case=
 =
8:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;v =3D ldq_p(buf + =
i);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default:=
<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;v =3D ldub_p(buf + i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;monitor_printf(mon, " =
");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch(=
format) {<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.47.0</blockquote></body=
></html>=

--Apple-Mail=_881A7665-AB5F-452A-BCFD-40EE80585EE5--

