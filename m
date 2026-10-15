Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269ADCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLnf-0001f7-PH; Thu, 15 Oct 2026 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLnc-0001eZ-Fk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:47:12 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLnY-0000LV-Q9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792072024; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=243Btl5UmKM/dRPYAxN1/G+ygppLrhOrXkZGq8YqmRk=;
 b=nByogJBFnQACvByC89zDihEtHYJDDbll6DtJPSO76JP59o5vvFXvPj8i34VEFrkTQOfW/E
 ie1rMbB1t7FW/bt0FoKgAqCjLyZ22h1vb+p0mte4gznH8DjYpGA3s0bplraqjnBr10GznT
 3EWKNEZgIiTTObZ3Eg/yMEbOIh0eXA/BBnn2ldZpvnE3S/YQ57dmcZcsu9BP2PNDNk+hG2
 MJ6CJ+DblAJ/e05kK5ZJqmc9G1z89zvticH/m3VtPV9xJof/8QAzld/xpLhvxOPL4FPno6
 dBZC3d8NvA5kgqKjCLLHxuMkJYuOHQgNKWCI/vOEjH9xnH7GyBM2aCril4inxQ==
Subject: Re: [PULL 13/52] tests/tcg/riscv64: Add Zvabd extension tests
From: "Mingliang Liu" <liumingliang.dev@bytedance.com>
Content-Type: multipart/alternative;
 boundary=8d8db24a7c4b18362562ebba3019e1805e355269ef21a27be37974790420
Message-Id: <ee7ee3a1f02a7e7cbb15b78aec59fd82060d2306.d26d8a5f.9cd0.4f67.b275.dc0453cc54f7@bytedance.com>
To: "Richard Henderson" <richard.henderson@linaro.org>
Mime-Version: 1.0
In-Reply-To: <3cf4014b-12ce-4252-a593-0f230b45619f@linaro.org>
X-Lms-Return-Path: <lba+16ad0d956+d6dba3+nongnu.org+liumingliang.dev@bytedance.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
 <20261014033907.3332383-14-alistair.francis@wdc.com>
 <3cf4014b-12ce-4252-a593-0f230b45619f@linaro.org>
Date: Thu, 15 Oct 2026 21:46:59 +0800
Cc: <qemu-devel@nongnu.org>, <alistair23@gmail.com>
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-1-113.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--8d8db24a7c4b18362562ebba3019e1805e355269ef21a27be37974790420
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Richard,

Thanks for pointing this out. I have updated the patch and sent a revised v=
ersion.
> From: "Richard Henderson"<richard.henderson@linaro.org>
> Date:=C2=A0 Thu, Oct 15, 2026, 14:08
> Subject:=C2=A0 Re: [PULL 13/52] tests/tcg/riscv64: Add Zvabd extension te=
sts
> To: <qemu-devel@nongnu.org>, <alistair23@gmail.com>, <liumingliang.dev@by=
tedance.com>
> On 10/14/26 05:38, alistair23@gmail.com=C2=A0wrote:
> > From: Mingliang Liu<liumingliang.dev@bytedance.com>
> >=C2=A0
> > Add a RV64 TCG test covering the masked and unmasked vector-vector
> > and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.
> >=C2=A0
> > Assemblers do not yet support the version 0.9 instruction mnemonics,
> > so the instruction encodings are hardcoded for the time being.
> >=C2=A0
> > GNU binutils 2.47 supports the incompatible version 0.7 instruction
> > encodings. Therefore, this test must not be built with that version,
> > even after it is converted to use instruction mnemonics.
> >=C2=A0
> > Reviewed-by: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> > Co-Author: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> > Signed-off-by: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> > Signed-off-by: Mingliang Liu<liumingliang.dev@bytedance.com>
> > Message-ID:<20260907152301.1701394-4-liumingliang.dev@bytedance.com>
> > Signed-off-by: Alistair Francis<alistair.francis@wdc.com>
> > ---
> > =C2=A0 tests/tcg/riscv64/Makefile.softmmu-target | =C2=A0 9 +
> > =C2=A0 tests/tcg/riscv64/test-zvabd.S =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 | 659 ++++++++++++++++++++++
> > =C2=A0 2 files changed, 668 insertions(+)
> > =C2=A0 create mode 100644 tests/tcg/riscv64/test-zvabd.S
>=20
>=20
> tests/tcg/riscv64/Makefile.softmmu-target no longer exists.
> This should be rewritten to update tests/tcg/riscv64/meson.build.
>=20
>=20
>=20
>=20
> r~
>=20
>=20
--8d8db24a7c4b18362562ebba3019e1805e355269ef21a27be37974790420
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div id=3D"editor_version_7.72.1_HbPS7Jqe" style=
=3D"word-break:break-word;"><div data-zone-id=3D"0" data-line-index=3D"0" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">Hi Richard,</div></div=
><div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" style=3D"=
margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" s=
tyle=3D"font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-lin=
e-index=3D"2" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4=
px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">Thanks =
for pointing this out. I have updated the patch and sent a revised version.=
</div></div></div><div class=3D"history-quote-wrapper" id=3D"lark-mail-quot=
e-179207200" style=3D"word-break: break-word;"><div id=3D"lark-mail-quote-1=
72f5b460db2cf3dc04ab7b44c2a844c"><div class=3D"history-quote-meta-wrapper a=
dit-html-block__attr history-quote-gap-tag" style=3D"padding: 12px; backgro=
und: rgb(245, 246, 247); color: rgb(31, 35, 41); border-radius: 4px; margin=
-top: 24px; margin-bottom: 12px;" id=3D"lark-mail-meta-jJE2Hl7eN"><div data=
-zone-id=3D"0" data-line-index=3D"3" data-line=3D"true" style=3D"margin: 0p=
x;" class=3D"history-quote-line quote-head-meta-line"><div class=3D"" dir=
=3D"auto">From: &#34;Richard Henderson&#34;&lt;<a class=3D"quote-head-meta-=
mailto" target=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto:richar=
d.henderson@linaro.org" style=3D"cursor: pointer; text-decoration: none; co=
lor: inherit;">richard.henderson@linaro.org</a>&gt;</div></div><div data-zo=
ne-id=3D"0" data-line-index=3D"4" data-line=3D"true" style=3D"margin: 0px;"=
 class=3D"history-quote-line quote-head-meta-line"><div class=3D"" dir=3D"a=
uto">Date:=C2=A0 Thu, Oct 15, 2026, 14:08</div></div><div data-zone-id=3D"0=
" data-line-index=3D"5" data-line=3D"true" style=3D"margin: 0px;" class=3D"=
history-quote-line quote-head-meta-line"><div class=3D"" dir=3D"auto">Subje=
ct:=C2=A0 Re: [PULL 13/52] tests/tcg/riscv64: Add Zvabd extension tests</di=
v></div><div data-zone-id=3D"0" data-line-index=3D"6" data-line=3D"true" st=
yle=3D"margin: 0px;" class=3D"history-quote-line quote-head-meta-line"><div=
 class=3D"" dir=3D"auto">To: &lt;<a class=3D"quote-head-meta-mailto" target=
=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto:qemu-devel@nongnu.or=
g" style=3D"cursor: pointer; text-decoration: none; color: inherit;">qemu-d=
evel@nongnu.org</a>&gt;, &lt;<a class=3D"quote-head-meta-mailto" target=3D"=
_blank" rel=3D"noopener noreferrer" href=3D"mailto:alistair23@gmail.com" st=
yle=3D"cursor: pointer; text-decoration: none; color: inherit;">alistair23@=
gmail.com</a>&gt;, &lt;<a class=3D"quote-head-meta-mailto" target=3D"_blank=
" rel=3D"noopener noreferrer" href=3D"mailto:liumingliang.dev@bytedance.com=
" style=3D"cursor: pointer; text-decoration: none; color: inherit;">liuming=
liang.dev@bytedance.com</a>&gt;</div></div></div><div data-zone-id=3D"0" da=
ta-line-index=3D"7" data-line=3D"true" style=3D"margin-top: 4px; margin-bot=
tom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" d=
ir=3D"auto" style=3D"font-size: 14px;"><span>On 10/14/26 05:38, <a href=3D"=
mailto:alistair23@gmail.com" target=3D"_blank" ref=3D"noopener noreferrer">=
alistair23@gmail.com</a>=C2=A0wrote:</span></div></div><div data-zone-id=3D=
"0" data-line-index=3D"8" data-line=3D"true" style=3D"margin-top: 4px; marg=
in-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=
=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; From: Mingliang Li=
u&lt;<a href=3D"mailto:liumingliang.dev@bytedance.com" target=3D"_blank" re=
f=3D"noopener noreferrer">liumingliang.dev@bytedance.com</a>&gt;</span></di=
v></div><div data-zone-id=3D"0" data-line-index=3D"9" data-line=3D"true" st=
yle=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"his=
tory-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">&g=
t;=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=3D"10" data-lin=
e=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"=
 class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-si=
ze: 14px;">&gt; Add a RV64 TCG test covering the masked and unmasked vector=
-vector</div></div><div data-zone-id=3D"0" data-line-index=3D"11" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" =
class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-siz=
e: 14px;">&gt; and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.=
</div></div><div data-zone-id=3D"0" data-line-index=3D"12" data-line=3D"tru=
e" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=
=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14=
px;">&gt;=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=3D"13" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"=
font-size: 14px;">&gt; Assemblers do not yet support the version 0.9 instru=
ction mnemonics,</div></div><div data-zone-id=3D"0" data-line-index=3D"14" =
data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D=
"font-size: 14px;">&gt; so the instruction encodings are hardcoded for the =
time being.</div></div><div data-zone-id=3D"0" data-line-index=3D"15" data-=
line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.=
6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font=
-size: 14px;">&gt;=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=
=3D"16" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; li=
ne-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" =
style=3D"font-size: 14px;">&gt; GNU binutils 2.47 supports the incompatible=
 version 0.7 instruction</div></div><div data-zone-id=3D"0" data-line-index=
=3D"17" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; li=
ne-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" =
style=3D"font-size: 14px;">&gt; encodings. Therefore, this test must not be=
 built with that version,</div></div><div data-zone-id=3D"0" data-line-inde=
x=3D"18" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; l=
ine-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto"=
 style=3D"font-size: 14px;">&gt; even after it is converted to use instruct=
ion mnemonics.</div></div><div data-zone-id=3D"0" data-line-index=3D"19" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"f=
ont-size: 14px;">&gt;=C2=A0</div></div><div data-zone-id=3D"0" data-line-in=
dex=3D"20" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px;=
 line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"aut=
o" style=3D"font-size: 14px;"><span>&gt; Reviewed-by: Daniel Henrique Barbo=
za&lt;<a href=3D"mailto:daniel.barboza@oss.qualcomm.com" target=3D"_blank" =
ref=3D"noopener noreferrer">daniel.barboza@oss.qualcomm.com</a>&gt;</span><=
/div></div><div data-zone-id=3D"0" data-line-index=3D"21" data-line=3D"true=
" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D=
"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;=
"><span>&gt; Co-Author: Daniel Henrique Barboza&lt;<a href=3D"mailto:daniel=
.barboza@oss.qualcomm.com" target=3D"_blank" ref=3D"noopener noreferrer">da=
niel.barboza@oss.qualcomm.com</a>&gt;</span></div></div><div data-zone-id=
=3D"0" data-line-index=3D"22" data-line=3D"true" style=3D"margin-top: 4px; =
margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div cl=
ass=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; Signed-off-by: =
Daniel Henrique Barboza&lt;<a href=3D"mailto:daniel.barboza@oss.qualcomm.co=
m" target=3D"_blank" ref=3D"noopener noreferrer">daniel.barboza@oss.qualcom=
m.com</a>&gt;</span></div></div><div data-zone-id=3D"0" data-line-index=3D"=
23" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-h=
eight: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" styl=
e=3D"font-size: 14px;"><span>&gt; Signed-off-by: Mingliang Liu&lt;<a href=
=3D"mailto:liumingliang.dev@bytedance.com" target=3D"_blank" ref=3D"noopene=
r noreferrer">liumingliang.dev@bytedance.com</a>&gt;</span></div></div><div=
 data-zone-id=3D"0" data-line-index=3D"24" data-line=3D"true" style=3D"marg=
in-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-=
line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; Me=
ssage-ID:&lt;<a href=3D"mailto:20260907152301.1701394-4-liumingliang.dev@by=
tedance.com" target=3D"_blank" ref=3D"noopener noreferrer">20260907152301.1=
701394-4-liumingliang.dev@bytedance.com</a>&gt;</span></div></div><div data=
-zone-id=3D"0" data-line-index=3D"25" data-line=3D"true" style=3D"margin-to=
p: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"=
><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; Signed-=
off-by: Alistair Francis&lt;<a href=3D"mailto:alistair.francis@wdc.com" tar=
get=3D"_blank" ref=3D"noopener noreferrer">alistair.francis@wdc.com</a>&gt;=
</span></div></div><div data-zone-id=3D"0" data-line-index=3D"26" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" =
class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-siz=
e: 14px;">&gt; ---</div></div><div data-zone-id=3D"0" data-line-index=3D"27=
" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-hei=
ght: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=
=3D"font-size: 14px;">&gt; =C2=A0 tests/tcg/riscv64/Makefile.softmmu-target=
 | =C2=A0 9 +</div></div><div data-zone-id=3D"0" data-line-index=3D"28" dat=
a-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: =
1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"fo=
nt-size: 14px;">&gt; =C2=A0 tests/tcg/riscv64/test-zvabd.S =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 | 659 ++++++++++++++++++++++</div></div><div dat=
a-zone-id=3D"0" data-line-index=3D"29" data-line=3D"true" style=3D"margin-t=
op: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line=
"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">&gt; =C2=A0 2 fil=
es changed, 668 insertions(+)</div></div><div data-zone-id=3D"0" data-line-=
index=3D"30" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"a=
uto" style=3D"font-size: 14px;">&gt; =C2=A0 create mode 100644 tests/tcg/ri=
scv64/test-zvabd.S</div></div><div data-zone-id=3D"0" data-line-index=3D"31=
" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-hei=
ght: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=
=3D"font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-in=
dex=3D"32" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px;=
 line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"aut=
o" style=3D"font-size: 14px;">tests/tcg/riscv64/Makefile.softmmu-target no =
longer exists.</div></div><div data-zone-id=3D"0" data-line-index=3D"33" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"f=
ont-size: 14px;">This should be rewritten to update tests/tcg/riscv64/meson=
.build.</div></div><div data-zone-id=3D"0" data-line-index=3D"34" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" =
class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-siz=
e: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=3D"35" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"=
font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=
=3D"36" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; li=
ne-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" =
style=3D"font-size: 14px;">r~</div></div><div data-zone-id=3D"0" data-line-=
index=3D"37" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><br/></d=
iv></div></div></div></body></html>
--8d8db24a7c4b18362562ebba3019e1805e355269ef21a27be37974790420--

