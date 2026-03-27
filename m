Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9B710ED679
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67hi-0003h1-4C; Fri, 27 Mar 2026 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linhuang@ruijie.com.cn>)
 id 1w61ne-0008HX-Hd
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:40:12 -0400
Received: from va-2-18.ptr.blmpb.com ([209.127.231.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linhuang@ruijie.com.cn>)
 id 1w61nc-0006tY-2y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2311081108; d=ruijie.com.cn; t=1774597178; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=W8WRaTNy69rr2t9xYXSgxGev8HHcrDAAnhL2X97DTr4=;
 b=iS8XTSCySSvBMlBrdQHHZYaixzFMgDhPbPpnATFcSz190qfTVDNmsoPtH4lVpGiea3c79/
 s6sdKe5OsgEJVevHSW0jNTUuxHC5K7/nx9K3WErPXwwlOBDKi2tHkHH8wnZye2Revt83sW
 Pm2Aqz82+Jd+9AuX1lC/PtM5zRQwVYfcBxpbB2sx2cYHb83YCTqlLV/2GXHsvtik7OP+yX
 B1fWMfuURUibXFI3YHZGEh1AWbc3dLtDTRashjFZ/VpUQuWccUuGCkyQzVa1APYouW8t4a
 gaY1vbfJFyjboDxZulXjMxE+A4eAbqOpEfiMyBlTpqGOz8WBIlhsaSZGmFiVdw==
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] net/ftgmac100: preserve full VLAN TCI in TX tag insertion
From: "linhuang" <linhuang@ruijie.com.cn>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+169c63438+3edb96+nongnu.org+linhuang@ruijie.com.cn>
Content-Type: multipart/alternative;
 boundary=bf2b1559142a3ed132ffbb83440f0186e7995240419e3b991980ffef6744
Date: Fri, 27 Mar 2026 15:39:35 +0800
Message-Id: <1471e413d3589b6734819bda2b59b725b74f273a.d551129b.99fc.47f6.86dc.0759227268a2@feishu.cn>
Cc: "philmd@linaro.org" <philmd@linaro.org>
Received-SPF: pass client-ip=209.127.231.18;
 envelope-from=linhuang@ruijie.com.cn; helo=va-2-18.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Mar 2026 09:58:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--bf2b1559142a3ed132ffbb83440f0186e7995240419e3b991980ffef6744
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8


The VLAN tag insertion helper took vlan_tci as an 8-bit value, while
the=C2=A0descriptor provides a 16-bit VLAN TCI. This truncated egress tags
and caused VLAN ID corruption (for example, 4088/0x0ff8 became
248/0x00f8 at the receiver).

Change vlan_tci to uint16_t=C2=A0in the TX VLAN insertion path so the full
802.1Q TCI is preserved and transmitted correctly.

Signed-off-by: linhuang <linhuang@ruijie.com.cn>
---
=C2=A0hw/net/ftgmac100.c | 2 +-
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2f05bba11d..b3da48c343 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -498,7 +498,7 @@ static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_ad=
dr_t addr)
=C2=A0}

=C2=A0static int ftgmac100_insert_vlan(FTGMAC100State *s, int frame_size,
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 uint8_t vlan_tci)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t vlan_tci)
=C2=A0{
=C2=A0=C2=A0 =C2=A0 uint8_t *vlan_hdr =3D s->frame + (ETH_ALEN * 2);
=C2=A0=C2=A0 =C2=A0 uint8_t *payload =3D vlan_hdr + sizeof(struct=C2=A0vlan=
_header);
--
2.34.1
--bf2b1559142a3ed132ffbb83440f0186e7995240419e3b991980ffef6744
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<div id=3D"editor_version_7.63.0_CNnjZIC4" style=3D"word-break:break-word;"=
><div data-zone-id=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"=
margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" s=
tyle=3D"font-size: 14px;"><br></div></div><div data-zone-id=3D"0" data-line=
-index=3D"1" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span st=
yle=3D"font-family: serif, TimesNewRoman;">The VLAN tag insertion helper to=
ok vlan_tci as an 8-bit value, while</span></div></div><div data-zone-id=3D=
"0" data-line-index=3D"2" data-line=3D"true" style=3D"margin-top: 4px; marg=
in-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14=
px;"><span style=3D"font-family: serif, TimesNewRoman;">the</span><span sty=
le=3D"font-family: serif, TimesNewRoman;">&nbsp;descriptor provides a 16-bi=
t VLAN TCI. This truncated egress tags</span></div></div><div data-zone-id=
=3D"0" data-line-index=3D"3" data-line=3D"true" style=3D"margin-top: 4px; m=
argin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size:=
 14px;"><span style=3D"font-family: serif, TimesNewRoman;">and caused VLAN =
ID corruption (for example, 4088/0x0ff8 became</span></div></div><div data-=
zone-id=3D"0" data-line-index=3D"4" data-line=3D"true" style=3D"margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"fon=
t-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">248/0x00f=
8 at the receiver).</span></div></div><div data-zone-id=3D"0" data-line-ind=
ex=3D"5" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; l=
ine-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><br></div></=
div><div data-zone-id=3D"0" data-line-index=3D"6" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"aut=
o" style=3D"font-size: 14px;"><span style=3D"font-family: serif, TimesNewRo=
man;">Change vlan_tci to </span><span style=3D"font-family: serif, TimesNew=
Roman;">uint16_t</span><span style=3D"font-family: serif, TimesNewRoman;">&=
nbsp;in the TX VLAN insertion path so the full</span></div></div><div data-=
zone-id=3D"0" data-line-index=3D"7" data-line=3D"true" style=3D"margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"fon=
t-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">802.1Q TC=
I is preserved and transmitted correctly.</span></div></div><div data-zone-=
id=3D"0" data-line-index=3D"8" data-line=3D"true" style=3D"margin-top: 4px;=
 margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-siz=
e: 14px;"><br></div></div><div data-zone-id=3D"0" data-line-index=3D"9" dat=
a-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: =
1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-fami=
ly: serif, TimesNewRoman;">Signed-off-by: linhuang &lt;</span><span style=
=3D"font-family: serif, TimesNewRoman;"><a class=3D"not-doclink" href=3D"ma=
ilto:linhuang@ruijie.com.cn" linkid=3D"NGasVxUzOZ" target=3D"_blank" rel=3D=
"noopener noreferrer" style=3D"transition: color 0.3s; cursor: pointer; tex=
t-decoration: none; color: rgb(20, 86, 240);">linhuang@ruijie.com.cn</a></s=
pan><span style=3D"font-family: serif, TimesNewRoman;">&gt;</span></div></d=
iv><div data-zone-id=3D"0" data-line-index=3D"10" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"aut=
o" style=3D"font-size: 14px;"><span style=3D"font-family: serif, TimesNewRo=
man;">---</span></div></div><div data-zone-id=3D"0" data-line-index=3D"11" =
data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-f=
amily: serif, TimesNewRoman;">&nbsp;hw/net/ftgmac100.c | 2 +-</span></div><=
/div><div data-zone-id=3D"0" data-line-index=3D"12" data-line=3D"true" styl=
e=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"au=
to" style=3D"font-size: 14px;"><span style=3D"font-family: serif, TimesNewR=
oman;">&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)</span></div></di=
v><div data-zone-id=3D"0" data-line-index=3D"13" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"aut=
o" style=3D"font-size: 14px;"><br></div></div><div data-zone-id=3D"0" data-=
line-index=3D"14" data-line=3D"true" style=3D"margin-top: 4px; margin-botto=
m: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><sp=
an style=3D"font-family: serif, TimesNewRoman;">diff --git a/hw/net/ftgmac1=
00.c b/hw/net/ftgmac100.c</span></div></div><div data-zone-id=3D"0" data-li=
ne-index=3D"15" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom:=
 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span=
 style=3D"font-family: serif, TimesNewRoman;">index 2f05bba11d..b3da48c343 =
100644</span></div></div><div data-zone-id=3D"0" data-line-index=3D"16" dat=
a-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: =
1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-fami=
ly: serif, TimesNewRoman;">--- a/hw/net/ftgmac100.c</span></div></div><div =
data-zone-id=3D"0" data-line-index=3D"17" data-line=3D"true" style=3D"margi=
n-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=
=3D"font-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">++=
+ b/hw/net/ftgmac100.c</span></div></div><div data-zone-id=3D"0" data-line-=
index=3D"18" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><span st=
yle=3D"font-family: serif, TimesNewRoman;">@@ -498,7 +498,7 @@ static int f=
tgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)</span></div></div><di=
v data-zone-id=3D"0" data-line-index=3D"19" data-line=3D"true" style=3D"mar=
gin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" styl=
e=3D"font-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">&=
nbsp;}</span></div></div><div data-zone-id=3D"0" data-line-index=3D"20" dat=
a-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: =
1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><br></div></div><div dat=
a-zone-id=3D"0" data-line-index=3D"21" data-line=3D"true" style=3D"margin-t=
op: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"=
font-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">&nbsp;=
static int ftgmac100_insert_vlan(FTGMAC100State *s, int frame_size,</span><=
/div></div><div data-zone-id=3D"0" data-line-index=3D"22" data-line=3D"true=
" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=
=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-family: serif, Tim=
esNewRoman;">- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; uint8_t vlan_tci)=
</span></div></div><div data-zone-id=3D"0" data-line-index=3D"23" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">=
<div dir=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-family: se=
rif, TimesNewRoman;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint16_t vlan_t=
ci)</span></div></div><div data-zone-id=3D"0" data-line-index=3D"24" data-l=
ine=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6=
;"><div dir=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-family:=
 serif, TimesNewRoman;">&nbsp;{</span></div></div><div data-zone-id=3D"0" d=
ata-line-index=3D"25" data-line=3D"true" style=3D"margin-top: 4px; margin-b=
ottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"=
><span style=3D"font-family: serif, TimesNewRoman;">&nbsp;&nbsp; &nbsp; uin=
t8_t *vlan_hdr =3D s-&gt;frame + (ETH_ALEN * 2);</span></div></div><div dat=
a-zone-id=3D"0" data-line-index=3D"26" data-line=3D"true" style=3D"margin-t=
op: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"=
font-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">&nbsp;=
&nbsp; &nbsp; uint8_t *payload =3D vlan_hdr + </span><span style=3D"font-fa=
mily: serif, TimesNewRoman;">sizeof(struct</span><span style=3D"font-family=
: serif, TimesNewRoman;">&nbsp;vlan_header);</span></div></div><div data-zo=
ne-id=3D"0" data-line-index=3D"27" data-line=3D"true" style=3D"margin-top: =
4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font=
-size: 14px;"><span style=3D"font-family: serif, TimesNewRoman;">--</span><=
/div></div><div data-zone-id=3D"0" data-line-index=3D"28" data-line=3D"true=
" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=
=3D"auto" style=3D"font-size: 14px;"><span style=3D"font-family: serif, Tim=
esNewRoman;">2.34.1</span></div></div></div>
--bf2b1559142a3ed132ffbb83440f0186e7995240419e3b991980ffef6744--

