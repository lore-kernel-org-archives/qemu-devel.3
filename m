Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A173C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIHM-0006SM-7Y; Tue, 04 Feb 2025 07:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfIHF-0006RM-Go
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:43:42 -0500
Received: from smtp.forwardemail.net ([207.246.76.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfIHB-0001E3-4a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID:
 References: In-Reply-To: Subject: CC: To: From: Date; q=dns/txt;
 s=fe-257304d8b2; t=1738673012;
 bh=/HYDgdnZ6CJl2+LyZsyTsgioeVwGzdxyaswGzhlH2XE=;
 b=WK0TqpdV8UYRf2ZoBC2M1C29zBSxN0NghKU/C35sT/MoqJ5/JWRNdcgsv0zTt0T5H9QYNFTOA
 kFc0Aacaf8xL+NlY+9K07fkg9uzBwultnhKy63FvMFsEIkiuX1hcx4meEIlm1shjIrJzJQ0RdXM
 ZtAlVgkSaIjjMYakb+/kLiY=
X-Forward-Email-ID: 67a20b6f7b9aa93e6fd272f4
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Date: Tue, 04 Feb 2025 13:43:24 +0100
From: Git <git@miszr.win>
To: qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_target/sparc=3A_Fix_register_sel?=
 =?US-ASCII?Q?ection_for_the_fdtox_and_fqtox_instructions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250203140130.78240-1-git@miszr.win>
References: <20250203140130.78240-1-git@miszr.win>
Message-ID: <653F9E2D-61AE-4954-A161-D1347D1336C5@miszr.win>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----JXTIZH1BPVUPXMCKS3V7UK8U8NH48N
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.246.76.47;
 envelope-from=SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------JXTIZH1BPVUPXMCKS3V7UK8U8NH48N
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you Richard for noticing the issue=2E

I have been able to create tests that show the malfunction of the FsTOx in=
struction as well=2E I am however not yet able to prove(through tests) the =
malfunction of the FxTO{s,d,q} instructions=2E

Based on the fact that the source registers are 64 bit, a similar pattern =
should be used=2E

I also noticed a mistake I made in the patch with the FqTOx instruction, u=
sing q_q2, instead of d_q2(since the destination registers are 64 bits)=2E

I will resubmit this patch with corrections once I have managed to write t=
ests which show the issues=2E

Best regards=20
Mikael Szreder

On February 3, 2025 3:01:30 PM GMT+01:00, Mikael Szreder <git@miszr=2Ewin>=
 wrote:
>A bug was introduced in commit 0bba7572d40d which causes the fdtox and
> fqtox instructions to incorrectly select the destination registers=2E
>More information and a test program can be found in issue #2802=2E
>
>Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2802
>Signed-off-by: Mikael Szreder <git@miszr=2Ewin>
>---
> target/sparc/insns=2Edecode | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/target/sparc/insns=2Edecode b/target/sparc/insns=2Edecode
>index 989c20b44a=2E=2E694a28d88c 100644
>--- a/target/sparc/insns=2Edecode
>+++ b/target/sparc/insns=2Edecode
>@@ -322,8 +322,8 @@ FNHADDs     10 =2E=2E=2E=2E=2E 110100 =2E=2E=2E=2E=2E=
 0 0111 0001 =2E=2E=2E=2E=2E        @r_r_r
> FNHADDd     10 =2E=2E=2E=2E=2E 110100 =2E=2E=2E=2E=2E 0 0111 0010 =2E=2E=
=2E=2E=2E        @d_d_d
> FNsMULd     10 =2E=2E=2E=2E=2E 110100 =2E=2E=2E=2E=2E 0 0111 1001 =2E=2E=
=2E=2E=2E        @d_r_r
> FsTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0001 =2E=2E=2E=2E=2E =
       @r_r2
>-FdTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0010 =2E=2E=2E=2E=2E =
       @r_d2
>-FqTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0011 =2E=2E=2E=2E=2E =
       @r_q2
>+FdTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0010 =2E=2E=2E=2E=2E =
       @d_d2
>+FqTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0011 =2E=2E=2E=2E=2E =
       @q_q2
> FxTOs       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0100 =2E=2E=2E=2E=2E =
       @r_r2
> FxTOd       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 1000 =2E=2E=2E=2E=2E =
       @d_r2
> FxTOq       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 1100 =2E=2E=2E=2E=2E =
       @q_r2
>--=20
>2=2E48=2E1
>

Git
------JXTIZH1BPVUPXMCKS3V7UK8U8NH48N
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Thank you Richard for noticing t=
he issue=2E<br><br>I have been able to create tests that show the malfuncti=
on of the FsTOx instruction as well=2E I am however not yet able to prove(t=
hrough tests) the malfunction of the FxTO{s,d,q} instructions=2E<br><br>Bas=
ed on the fact that the source registers are 64 bit, a similar pattern shou=
ld be used=2E<br><br>I also noticed a mistake I made in the patch with the =
FqTOx instruction, using q_q2, instead of d_q2(since the destination regist=
ers are 64 bits)=2E<br><br>I will resubmit this patch with corrections once=
 I have managed to write tests which show the issues=2E<br><br>Best regards=
 <br>Mikael Szreder</div><br><br><div class=3D"gmail_quote"><div dir=3D"aut=
o">On February 3, 2025 3:01:30 PM GMT+01:00, Mikael Szreder &lt;git@miszr=
=2Ewin&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-left=
: 1ex;">
<pre class=3D"k9mail"><div dir=3D"auto">A bug was introduced in commit 0bb=
a7572d40d which causes the fdtox and<br> fqtox instructions to incorrectly =
select the destination registers=2E<br>More information and a test program =
can be found in issue #2802=2E<br><br>Fixes: 0bba7572d40d ("target/sparc: P=
erform DFPREG/QFPREG in decodetree")<br>Resolves: <a href=3D"https://gitlab=
=2Ecom/qemu-project/qemu/-/issues/2802">https://gitlab=2Ecom/qemu-project/q=
emu/-/issues/2802</a><br>Signed-off-by: Mikael Szreder &lt;git@miszr=2Ewin&=
gt;<hr> target/sparc/insns=2Edecode | 4 ++--<br> 1 file changed, 2 insertio=
ns(+), 2 deletions(-)<br><br>diff --git a/target/sparc/insns=2Edecode b/tar=
get/sparc/insns=2Edecode<br>index 989c20b44a=2E=2E694a28d88c 100644<br>--- =
a/target/sparc/insns=2Edecode<br>+++ b/target/sparc/insns=2Edecode<br>@@ -3=
22,8 +322,8 @@ FNHADDs     10 =2E=2E=2E=2E=2E 110100 =2E=2E=2E=2E=2E 0 0111=
 0001 =2E=2E=2E=2E=2E        @r_r_r<br> FNHADDd     10 =2E=2E=2E=2E=2E 1101=
00 =2E=2E=2E=2E=2E 0 0111 0010 =2E=2E=2E=2E=2E        @d_d_d<br> FNsMULd   =
  10 =2E=2E=2E=2E=2E 110100 =2E=2E=2E=2E=2E 0 0111 1001 =2E=2E=2E=2E=2E    =
    @d_r_r<br> FsTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0001 =2E=
=2E=2E=2E=2E        @r_r2<br>-FdTOx       10 =2E=2E=2E=2E=2E 110100 00000 0=
 1000 0010 =2E=2E=2E=2E=2E        @r_d2<br>-FqTOx       10 =2E=2E=2E=2E=2E =
110100 00000 0 1000 0011 =2E=2E=2E=2E=2E        @r_q2<br>+FdTOx       10 =
=2E=2E=2E=2E=2E 110100 00000 0 1000 0010 =2E=2E=2E=2E=2E        @d_d2<br>+F=
qTOx       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0011 =2E=2E=2E=2E=2E     =
   @q_q2<br> FxTOs       10 =2E=2E=2E=2E=2E 110100 00000 0 1000 0100 =2E=2E=
=2E=2E=2E        @r_r2<br> FxTOd       10 =2E=2E=2E=2E=2E 110100 00000 0 10=
00 1000 =2E=2E=2E=2E=2E        @d_r2<br> FxTOq       10 =2E=2E=2E=2E=2E 110=
100 00000 0 1000 1100 =2E=2E=2E=2E=2E        @q_r2<br></div></pre></blockqu=
ote></div><div dir=3D"auto">Git</div></body></html>
------JXTIZH1BPVUPXMCKS3V7UK8U8NH48N--

