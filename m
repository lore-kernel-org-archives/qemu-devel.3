Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB68CD4F52
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFWj-0002Jb-Bj; Tue, 19 May 2026 04:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wPFWd-0002JG-Id
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:10:04 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wPFWQ-0001Td-GN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:09:52 -0400
Received: from ehlo.thunderbird.net (unknown
 [IPv6:240e:404:1920:4202:9cce:7cff:fe97:9168])
 by krgm.moe (Postfix) with ESMTPSA id 8DC552430982
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 16:09:39 +0800 (CST)
Date: Tue, 19 May 2026 16:09:32 +0800
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] target/loongarch: add LVZ support for TCG
User-Agent: K-9 Mail for Android
In-Reply-To: <cover.1779171125.git.prcups@krgm.moe>
References: <cover.1779171125.git.prcups@krgm.moe>
Message-ID: <CE549524-76AA-4ACD-BA9A-89A288FECD27@krgm.moe>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----R7TD1P9EFW067QL5ADNU3NM5CLS5UJ
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------R7TD1P9EFW067QL5ADNU3NM5CLS5UJ
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please disregard my previous patch series[1][2][3][4][5][6]=2E This was my =
first time using git send-email and my provider messed up the threads (the =
cover letter also accidentally reused a previous Message-ID, causing it to =
be grouped into the wrong thread[7])=2E

I sincerely apologize for the noise and confusion=2E

=2E=2E=2E=2E

[1]: https://lore=2Ekernel=2Eorg/qemu-devel/734d561d-4a8c-4235-b55d-138702=
0f8a62@mtasv=2Enet/T/#t
[2]: https://lore=2Ekernel=2Eorg/qemu-devel/ff838e8c-8f44-446d-915d-cfb2ce=
869a5c@mtasv=2Enet/T/#u
[3]: https://lore=2Ekernel=2Eorg/qemu-devel/ac715039-55b0-400d-bd78-32ff7e=
c889c8@mtasv=2Enet/T/#t
[4]: https://lore=2Ekernel=2Eorg/qemu-devel/75d2c4d9-aa2e-4660-9a47-1cf0f8=
a23f7b@mtasv=2Enet/T/#u
[5]: https://lore=2Ekernel=2Eorg/qemu-devel/28e575ca-c2bc-4ff5-b686-0459f7=
43ec65@mtasv=2Enet/T/#u
[6]: https://lore=2Ekernel=2Eorg/qemu-devel/f9750959-4b07-45b5-a834-89c4f8=
25184b@mtasv=2Enet/T/#t
[7]: https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1779171125=2Egit=2Eprc=
ups@krgm=2Emoe/T/#t

=E4=BA=8E 2026=E5=B9=B45=E6=9C=8819=E6=97=A5 GMT+08:00 14:30:39=EF=BC=8CSi=
gnKirigami <prcups@krgm=2Emoe> =E5=86=99=E9=81=93=EF=BC=9A
>This patch implements Loongson VirtualiZation (LVZ) extension support for=
 LoongArch's TCG target=2E With this patch, it is now possible to start a n=
ested KVM-accelerated virtual machine on a TCG-emulated virtual machine=2E
>
>Cc: Bibo Mao <maobibo@loongson=2Ecn>
>Cc: xianglai li <lixianglai@loongson=2Ecn>
>Signed-off-by: SignKirigami <prcups@krgm=2Emoe>
>Signed-off-by: Hengyu Yu <yuhengyu25@mails=2Eucas=2Eac=2Ecn>
>
>SignKirigami (4):
>  target/loongarch: add LVZ CPU state and CSR metadata
>  target/loongarch: add LVZ guest runtime support
>  target/loongarch: translate LVZ CSR and trap instructions
>  target/loongarch: virtualize guest TLB and address translation
>
> target/loongarch/cpu-csr=2Eh                    |  42 ++
> target/loongarch/cpu-mmu=2Eh                    |  37 +-
> target/loongarch/cpu=2Ec                        | 132 ++++
> target/loongarch/cpu=2Eh                        | 125 +++-
> target/loongarch/cpu_helper=2Ec                 | 119 ++--
> target/loongarch/csr=2Ec                        | 122 ++++
> target/loongarch/csr=2Eh                        |   3 +
> target/loongarch/disas=2Ec                      |  10 +
> target/loongarch/insns=2Edecode                 |  17 +
> target/loongarch/internals=2Eh                  |   8 +-
> target/loongarch/kvm/kvm=2Ec                    |   1 +
> target/loongarch/machine=2Ec                    | 249 ++++---
> target/loongarch/tcg/constant_timer=2Ec         |  62 +-
> target/loongarch/tcg/csr_helper=2Ec             | 127 +++-
> target/loongarch/tcg/helper=2Eh                 |  30 +-
> =2E=2E=2E/tcg/insn_trans/trans_privileged=2Ec=2Einc     | 353 +++++++++-
> target/loongarch/tcg/op_helper=2Ec              |  83 ++-
> target/loongarch/tcg/tcg_cpu=2Ec                | 182 +++--
> target/loongarch/tcg/tcg_loongarch=2Eh          |   6 +-
> target/loongarch/tcg/tlb_helper=2Ec             | 629 +++++++++++++-----
> target/loongarch/tcg/translate=2Ec              |   6 +-
> target/loongarch/translate=2Eh                  |   2 +
> 22 files changed, 1909 insertions(+), 436 deletions(-)
>
>--=20
>2=2E52=2E0
>

------R7TD1P9EFW067QL5ADNU3NM5CLS5UJ
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Please disregard my previous pat=
ch series[1][2][3][4][5][6]=2E This was my first time using git send-email =
and my provider messed up the threads (the cover letter also accidentally r=
eused a previous Message-ID, causing it to be grouped into the wrong thread=
[7])=2E<br><br>I sincerely apologize for the noise and confusion=2E<br><br>=
=2E=2E=2E=2E<br><br>[1]: <a href=3D"https://lore=2Ekernel=2Eorg/qemu-devel/=
734d561d-4a8c-4235-b55d-1387020f8a62@mtasv=2Enet/T/#t">https://lore=2Ekerne=
l=2Eorg/qemu-devel/734d561d-4a8c-4235-b55d-1387020f8a62@mtasv=2Enet/T/#t</a=
><br>[2]: <a href=3D"https://lore=2Ekernel=2Eorg/qemu-devel/ff838e8c-8f44-4=
46d-915d-cfb2ce869a5c@mtasv=2Enet/T/#u">https://lore=2Ekernel=2Eorg/qemu-de=
vel/ff838e8c-8f44-446d-915d-cfb2ce869a5c@mtasv=2Enet/T/#u</a><br>[3]: <a hr=
ef=3D"https://lore=2Ekernel=2Eorg/qemu-devel/ac715039-55b0-400d-bd78-32ff7e=
c889c8@mtasv=2Enet/T/#t">https://lore=2Ekernel=2Eorg/qemu-devel/ac715039-55=
b0-400d-bd78-32ff7ec889c8@mtasv=2Enet/T/#t</a><br>[4]: <a href=3D"https://l=
ore=2Ekernel=2Eorg/qemu-devel/75d2c4d9-aa2e-4660-9a47-1cf0f8a23f7b@mtasv=2E=
net/T/#u">https://lore=2Ekernel=2Eorg/qemu-devel/75d2c4d9-aa2e-4660-9a47-1c=
f0f8a23f7b@mtasv=2Enet/T/#u</a><br>[5]: <a href=3D"https://lore=2Ekernel=2E=
org/qemu-devel/28e575ca-c2bc-4ff5-b686-0459f743ec65@mtasv=2Enet/T/#u">https=
://lore=2Ekernel=2Eorg/qemu-devel/28e575ca-c2bc-4ff5-b686-0459f743ec65@mtas=
v=2Enet/T/#u</a><br>[6]: <a href=3D"https://lore=2Ekernel=2Eorg/qemu-devel/=
f9750959-4b07-45b5-a834-89c4f825184b@mtasv=2Enet/T/#t">https://lore=2Ekerne=
l=2Eorg/qemu-devel/f9750959-4b07-45b5-a834-89c4f825184b@mtasv=2Enet/T/#t</a=
><br>[7]: <a href=3D"https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1779171=
125=2Egit=2Eprcups@krgm=2Emoe/T/#t">https://lore=2Ekernel=2Eorg/qemu-devel/=
cover=2E1779171125=2Egit=2Eprcups@krgm=2Emoe/T/#t</a></div><br><br><div cla=
ss=3D"gmail_quote"><div dir=3D"auto">=E4=BA=8E 2026=E5=B9=B45=E6=9C=8819=E6=
=97=A5 GMT+08:00 14:30:39=EF=BC=8CSignKirigami &lt;prcups@krgm=2Emoe&gt; =
=E5=86=99=E9=81=93=EF=BC=9A</div><blockquote class=3D"gmail_quote" style=3D=
"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); pa=
dding-left: 1ex;">
<pre class=3D"com-fsck-k9__plain-text-message-pre"><div dir=3D"auto">This =
patch implements Loongson VirtualiZation (LVZ) extension support for LoongA=
rch's TCG target=2E With this patch, it is now possible to start a nested K=
VM-accelerated virtual machine on a TCG-emulated virtual machine=2E<br><br>=
Cc: Bibo Mao &lt;maobibo@loongson=2Ecn&gt;<br>Cc: xianglai li &lt;lixiangla=
i@loongson=2Ecn&gt;<br>Signed-off-by: SignKirigami &lt;prcups@krgm=2Emoe&gt=
;<br>Signed-off-by: Hengyu Yu &lt;yuhengyu25@mails=2Eucas=2Eac=2Ecn&gt;<br>=
<br>SignKirigami (4):<br>  target/loongarch: add LVZ CPU state and CSR meta=
data<br>  target/loongarch: add LVZ guest runtime support<br>  target/loong=
arch: translate LVZ CSR and trap instructions<br>  target/loongarch: virtua=
lize guest TLB and address translation<br><br> target/loongarch/cpu-csr=2Eh=
                    |  42 ++<br> target/loongarch/cpu-mmu=2Eh              =
      |  37 +-<br> target/loongarch/cpu=2Ec                        | 132 ++=
++<br> target/loongarch/cpu=2Eh                        | 125 +++-<br> targe=
t/loongarch/cpu_helper=2Ec                 | 119 ++--<br> target/loongarch/=
csr=2Ec                        | 122 ++++<br> target/loongarch/csr=2Eh     =
                   |   3 +<br> target/loongarch/disas=2Ec                  =
    |  10 +<br> target/loongarch/insns=2Edecode                 |  17 +<br>=
 target/loongarch/internals=2Eh                  |   8 +-<br> target/loonga=
rch/kvm/kvm=2Ec                    |   1 +<br> target/loongarch/machine=2Ec=
                    | 249 ++++---<br> target/loongarch/tcg/constant_timer=
=2Ec         |  62 +-<br> target/loongarch/tcg/csr_helper=2Ec             |=
 127 +++-<br> target/loongarch/tcg/helper=2Eh                 |  30 +-<br> =
=2E=2E=2E/tcg/insn_trans/trans_privileged=2Ec=2Einc     | 353 +++++++++-<br=
> target/loongarch/tcg/op_helper=2Ec              |  83 ++-<br> target/loon=
garch/tcg/tcg_cpu=2Ec                | 182 +++--<br> target/loongarch/tcg/t=
cg_loongarch=2Eh          |   6 +-<br> target/loongarch/tcg/tlb_helper=2Ec =
            | 629 +++++++++++++-----<br> target/loongarch/tcg/translate=2Ec=
              |   6 +-<br> target/loongarch/translate=2Eh                  =
|   2 +<br> 22 files changed, 1909 insertions(+), 436 deletions(-)<br><br><=
/div></pre></blockquote></div></body></html>
------R7TD1P9EFW067QL5ADNU3NM5CLS5UJ--

