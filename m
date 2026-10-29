Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9DDWZj+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUi1-0000UW-5a; Thu, 29 Oct 2026 14:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMUhn-0000Tg-DU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:18:29 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMUhk-0007aB-CX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:18:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 872BC6012A;
 Thu, 29 Oct 2026 18:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F431F01816;
 Thu, 29 Oct 2026 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793297902;
 bh=SBQgSoASz0h0Rm/cTnfLRhxlqaui/xk8gwWAk//LVVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=k9DDWZj+ksZVdaC+7zoG6haUcQSm7WzoZXKm82vOfaUmXSzwkgD0gjhpTitSm1au3
 KCmgMn5uRiy6QvfMhQirTzd07H/BBA/xKKOjkoV+JAvtnc9xcZ8WtPw9cz5lMe+Tfu
 tyr7MfOkIqawoN34fXB/RpZHP39oHYDlg+xLMJGCtbWLQqWR5G/S76cQ8yz2KVrtez
 P6lDlwjKJDOufWDBxDJqxyx07pxLgPbndZDg/uHrxpeQzHfoEJ9uKfzr0J8l1DuhSl
 gXxWFYUInSEVJEuxO39+TsIX3jjQUYOtWa9E9b76d1MHJa667xIgCpb62KFQn9jf4S
 JLyyTWApQZraQ==
Date: Thu, 29 Oct 2026 19:18:17 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Keith Monahan <keith@techtravels.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: Re: [PULL v2 0/9] Hppa 715 2 patches
Message-ID: <auON6QwRA3wawcDO@carbonx1>
References: <20261028190701.17272-1-deller@kernel.org>
 <61c1cd23-8097-4356-8797-f270a79e68df@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c1cd23-8097-4356-8797-f270a79e68df@linaro.org>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-25.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Richard Henderson <richard.henderson@linaro.org>:
> On 10/28/26 14:06, Helge Deller wrote:
> > From: Helge Deller <deller@gmx.de>
> > 
> > The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:
> > 
> >    Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/hdeller/qemu-hppa.git tags/hppa-715-2-pull-request
> > 
> > for you to fetch changes up to 4d5bc20de77152cecb4acdf63afe0db761b2abcf:
> > 
> >    target/hppa: Update SeaBIOS-hppa to version 27 (2026-10-28 20:00:56 +0100)
> > 
> > ----------------------------------------------------------------
> > HPPA architecture patches for HP-UX 9 and 715 machine
> > 
> > A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
> > Includes a graphics/artist fix, adjustment to 15 bits for protection IDs on
> > the 32-bit CPUs and various other parts which were missing up to now.
> > Included is also the FPU patche from Kirill A. Korinsky.
> 
> The new hppa-fpu-test fails on big-endian.

The patch below will fix the issue.
I'll include it in this patch series and resend.
Thanks!
Helge


From e0c80f0b9ca5792a91a0d14d09c3da05641d8402 Mon Sep 17 00:00:00 2001
From: Keith Monahan <keith@techtravels.org>
Date: Thu, 29 Oct 2026 17:02:33 +0100
Subject: [PATCH] target/hppa: Use 32-bit load of PSW in rsm and ssm

Since commit ebc9401a4067 ("target/hppa: Split PSW X and B into their
own field") env->psw is a uint32_t followed by psw_xb, but trans_rsm()
and trans_ssm() still read it with a 64-bit load.

On a big-endian host the low half of that load is psw_xb, so the value
passed to swap_system_mask() has none of the current system mask bits.
SSM and RSM therefore clear every PSW system mask bit except those named
in the instruction. For example, "ssm 2,r0" with PSW_Q set clears Q, and
the next interruption does not record IIR, ISR and IOR. This makes the
hppa-fpu-test dtlb-load case fail on s390x hosts.

Load only the 32-bit psw field.

Fixes: ebc9401a4067 ("target/hppa: Split PSW X and B into their own field")
Cc: qemu-stable@nongnu.org  # v9.1+
Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd7..46c0408846 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2367,7 +2367,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
@@ -2387,7 +2387,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
> 
> 
> r~

