Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD57C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp75-0001UN-7o; Tue, 25 Aug 2026 07:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp72-0001No-K9; Tue, 25 Aug 2026 07:14:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp70-0000FS-JX; Tue, 25 Aug 2026 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=xWft4FHoOlZE5dZ+ceiOsF5nkpYFKpDqd+HNMlkqs2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ceyWm8khpvfggmvBdv+l13fhsr31tI+SwbKl6ziAEpQMe4GG+i/I4QCzKj64mphkI
 a/Y17VzjI3N1syp1wDjOnhJA6z5Pqe/hi0Se3Ugn6Tt/F30zP6I6KXzIMBtD8v7yMi
 phoMp28g6fmET7dkI5LoNzie4mq57AKgJI7kjZx9HAXTDbdnqHMgIph9e0bvI8bOX5
 0viHksQegKhT8uJaazSD347Uq4b0JFngMYN6WyTRCu/vpc3g5fSG1MXO6t7AnAsoSF
 NmQ+ldcd3n1S2RPI+z50dWsLtBPq5hXeFJyuZsTPLgfd2qM3EBr63N6tW/RbkiNbtn
 oAX6v3YjH6c+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46D9F1CE4B1;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D96141627D;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8BE2B325A5; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 149/166] tcg: Export tcg_gen_ussub_i{32,64,tl}
Date: Tue, 25 Aug 2026 14:11:45 +0300
Message-ID: <20260825111206.482723-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Move from tcg-op-gvec.c to tcg-op.c.
Use a temporary, to cover the possibility of operand overlap.

(Cc for stable as this is a prerequisite for the bug fix
in the next commit.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260811191540.79882-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b4f6f672a3e100706ddc249c26c2c149cdac1636)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 009e2778c5f..01d2ac71181 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -150,6 +150,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -258,6 +259,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583bd..389b8545d64 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -259,6 +259,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_umin_tl tcg_gen_umin_i64
 #define tcg_gen_smax_tl tcg_gen_smax_i64
 #define tcg_gen_umax_tl tcg_gen_umax_i64
+#define tcg_gen_ussub_tl tcg_gen_ussub_i64
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i64
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i64
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i64
@@ -377,6 +378,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_umin_tl tcg_gen_umin_i32
 #define tcg_gen_smax_tl tcg_gen_smax_i32
 #define tcg_gen_umax_tl tcg_gen_umax_i32
+#define tcg_gen_ussub_tl tcg_gen_ussub_i32
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i32
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i32
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i32
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index d32a4f146dc..bd750509ada 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2304,20 +2304,6 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
-static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 min = tcg_constant_i32(0);
-    tcg_gen_sub_i32(d, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-}
-
-static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 min = tcg_constant_i64(0);
-    tcg_gen_sub_i64(d, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-}
-
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fec6d678a29..29aa59429fd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1421,6 +1421,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_ebb_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i32(t);
+}
+
 void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -3148,6 +3158,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_ebb_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i64(t);
+}
+
 void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.47.3


