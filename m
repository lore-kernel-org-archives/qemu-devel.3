Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C6BCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2u-00024n-Sp; Sat, 17 Oct 2026 16:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2e-0001AH-Hh; Sat, 17 Oct 2026 16:30:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2c-00045p-KB; Sat, 17 Oct 2026 16:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268860; bh=kSy8qByZo5EpHZO7ddzsJPghDf9UBDQl6HJfLiE4c6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w2TT3chkvHTnjPaRiNfEAWVPwV0debw/BgQG93SYhIEeeaHneVykn5WOzmA/ydowI
 gUOYXfjcM1//b2s2UcxGLWTdHX7hEOXBLM34bPk6XVlZvWvm4nj4hDufQkX1XcYWR6
 1VTtOPOplSIJtWHO1lRSXjXNQCFsCE2KdcnBrmhTsWJGm/m3lVzdPrkzOr4LnPeoiZ
 Mp+cRpJnKpzlhuCCQ+nL72mFnsOTVAxn7unU19HQOiEnm+Rvdqr3jZz1YKQBPX5b4y
 DaQaRF+1whN3N1vKkZ83lFiLCA9zG8fMMxVA8jCKpH/3TIIGP9oFk4jf4ffilAvN4i
 guSCH0PLRVcJw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C4A51DE760;
 Sat, 17 Oct 2026 23:27:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21AF5443434;
 Sat, 17 Oct 2026 23:27:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 34/73] target/i386: Don't clear C1 for
 FCOMI/FCOMIP/FUCOMI/FUCOMIP
Date: Sat, 17 Oct 2026 23:25:52 +0300
Message-ID: <20261017202638.728621-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Simon Scherer <scherer.simon89@gmail.com>

Commit 6802a4b23919 ("target/i386: clear C1 for all x87 compare
instructions") added an unconditional C1 clear to helper_fcomi_ST0_FT0()
and helper_fucomi_ST0_FT0(), based on the SDM listing "C1 Set to 0" under
FPU Flags Affected for FCOMI/FCOMIP/FUCOMI/FUCOMIP.

Testing on real x86-64 Intel and AMD hardware shows these instructions leave
C1 unchanged, unlike FCOM/FUCOM/FICOM. The SDM text appears to have been
carried over from the FCOM/FUCOM description.

Revert that part of the commit. The FCOM/FUCOM/FICOM changes are kept.

Fixes: 6802a4b23919 ("target/i386: clear C1 for all x87 compare instructions")
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260911105811.16854-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6d5fb14d36a6d11e88f04878021b2d99ce6c07e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 2149f4b1d2..62f1c110e2 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -565,8 +565,6 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -579,8 +577,6 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.47.3


