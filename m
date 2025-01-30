Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE9C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUbr-0004iN-2W; Thu, 30 Jan 2025 08:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbo-0004hh-Um
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:28 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbn-0001Pa-FK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 98B255C03F5;
 Thu, 30 Jan 2025 13:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA64C4CED2;
 Thu, 30 Jan 2025 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738243766;
 bh=EdUmbIHS6wsR+QKUpjXCHpozaxkbBLR0Vx1ZIKvUOQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GW2nmuwaG7u68z50KfCKJGTsZPi+mPl0vSZTHkxWya2QuMFW1iavQZqSJ4zCR0NmY
 Vs/H0sXg3RMcOQtEI0GNIqUQGz9dIHVdsQINLo9henL8OHRoEIX4YRmvU2uS9MVicb
 WRS/duEPIIO1v29/dwriY0FS6yFdy8iGJE1C0l8KJWS8IKiF0xqA/Dpgf1qHUKS084
 jVLpatEBnFvCGjbQGwmGeAYAvs6xQQue128Nh+QjWpzEheFDQ1D+hOehu2RWb8tm7l
 3otLger7RwcoGRk5jerBxPIjBpKGbMmRaLa84J2I5jU1weWu7992IcZYfRJoBV/uis
 yqQR+hXX1838g==
From: deller@kernel.org
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 5/9] target/hppa: Drop diag_getshadowregs_pa2 and
 diag_putshadowregs_pa2
Date: Thu, 30 Jan 2025 14:29:10 +0100
Message-ID: <20250130132915.16846-6-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130132915.16846-1-deller@kernel.org>
References: <20250130132915.16846-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

diag_getshadowregs_pa2() and diag_putshadowregs_pa2() were added in
commit 3bdf20819e68 based on some analysis of ODE code, but now they
conflict with the generic mfdiag/mtdiag instructions. I believe the
former analysis was wrong, so remove them again. Note that all diag
instructions are badly documented, so most things are based on reverse
engineering and thus may be wrong.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3bdf20819e68 ("target/hppa: Add diag instructions to set/restore shadow registers")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  2 --
 target/hppa/translate.c  | 10 ----------
 2 files changed, 12 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 71074a64c1..527c453443 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -646,8 +646,6 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
     diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
 
     # For 64-bit PA8700 (PCX-W2)
-    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
-    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
   ]
   diag_unimp                000101 i:26
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc04f9f3c0..30fba5297a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4593,21 +4593,11 @@ static bool trans_diag_getshadowregs_pa1(DisasContext *ctx, arg_empty *a)
     return !ctx->is_pa20 && do_getshadowregs(ctx);
 }
 
-static bool trans_diag_getshadowregs_pa2(DisasContext *ctx, arg_empty *a)
-{
-    return ctx->is_pa20 && do_getshadowregs(ctx);
-}
-
 static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
 {
     return !ctx->is_pa20 && do_putshadowregs(ctx);
 }
 
-static bool trans_diag_putshadowregs_pa2(DisasContext *ctx, arg_empty *a)
-{
-    return ctx->is_pa20 && do_putshadowregs(ctx);
-}
-
 static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-- 
2.47.0


