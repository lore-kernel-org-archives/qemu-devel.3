Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB65C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiat8-0002H0-0C; Thu, 13 Feb 2025 10:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tiat5-0002DN-DI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:12:23 -0500
Received: from smtp.forwardemail.net ([121.127.44.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tiat3-0006E5-Ka
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID:
 References: In-Reply-To: Subject: CC: To: From: Date; q=dns/txt;
 s=fe-257304d8b2; t=1739459537;
 bh=UR82S2K6EFzSIwxw718HLM1RbVbxoOEqCwMiRkyBwyI=;
 b=GbH17xUpJtCtUbD1iZ5Hrhdqg85mCFcSq9Z6tE8SQYjLV4Jbs6rh+yVPVLhkJlw61g+1OlcB+
 RI/0OZe84IJTGKard6WTmxkE7dt8MBwcPyE4c0CDeFyfmGxi2yxiS+C3UFAlTrB3yeA/j7xSYH7
 lGOsgS4X9e7jAVhT9VOPlWs=
X-Forward-Email-ID: 67ae0bcdb0aa57712a24b5bc
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Date: Thu, 13 Feb 2025 16:12:06 +0100
From: Mikael Szreder <git@miszr.win>
To: qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_target/sparc=3A_Fix_gdbstub_?=
 =?US-ASCII?Q?incorrectly_handling_registers_f32-f62?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250203145056.83567-1-git@miszr.win>
References: <20250203145056.83567-1-git@miszr.win>
Message-ID: <D2CA2465-42B0-4D49-AA22-A1DE8BA1CD33@miszr.win>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=121.127.44.59;
 envelope-from=SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM14=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping

On February 3, 2025 3:50:56 PM GMT+01:00, Mikael Szreder <git@miszr=2Ewin>=
 wrote:
>The gdbstub implementation for the Sparc architecture would incorectly
> calculate the the floating point register offset=2E
>This would cause register pairs(eg f32,f33) to point to the same value=2E
>
>Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles=
=2E")
>Signed-off-by: Mikael Szreder <git@miszr=2Ewin>
>---
> target/sparc/gdbstub=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/target/sparc/gdbstub=2Ec b/target/sparc/gdbstub=2Ec
>index ec0036e9ef=2E=2E5578fa9813 100644
>--- a/target/sparc/gdbstub=2Ec
>+++ b/target/sparc/gdbstub=2Ec
>@@ -80,7 +80,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>     }
>     if (n < 80) {
>         /* f32-f62 (double width, even numbers only) */
>-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2]=2Ell);
>+        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16]=2Ell);
>     }
>     switch (n) {
>     case 80:
>@@ -174,7 +174,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>         return 4;
>     } else if (n < 80) {
>         /* f32-f62 (double width, even numbers only) */
>-        env->fpr[(n - 32) / 2]=2Ell =3D tmp;
>+        env->fpr[(n - 64) + 16]=2Ell =3D tmp;
>     } else {
>         switch (n) {
>         case 80:

