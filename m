Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A2EC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHY4-0007Kh-Qz; Thu, 23 May 2024 19:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXr-0007Gu-VM; Thu, 23 May 2024 19:08:24 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXo-0005gp-0k; Thu, 23 May 2024 19:08:22 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f855b2499cso607320a34.1; 
 Thu, 23 May 2024 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505697; x=1717110497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOYa88zJpP72crJzEB2v01f1J/T+USUgPwf97B3UqHM=;
 b=UgMfHXyZT8AHZS/ybnm33fQZCNzG4gNnrHu984XvYa1JHZhIzHxwUI7i41fzEdDlWj
 F6BkX//zbi7T1014Z2ErYqFZzsMlIhUxqY/6AhqJBK2loDYO5KDi+tz0eTnAOClj9DQr
 NmtSElyahgPHyfdevRsZbHBglDZq1/cU0V6xzCOmrdGvLE9IxTeeUAxiGAlQZ8mZRYkP
 qUgq414Ur7GZCoRKap2TOq075EbuX9PBHTdQ/ZCqPUBEA50w0oPoP51sSKesnUYVdHbs
 Rt1xwyMBa5nXwvZfpWnScc1xJ06H0+lDscrjnNqLPN7baTc5oQ8si+jRaxtxVuC/v0HV
 2x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505697; x=1717110497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOYa88zJpP72crJzEB2v01f1J/T+USUgPwf97B3UqHM=;
 b=pF7Qmepx7DCXtkQENLs75FRWuXWbkJ28aaj1vZJ4GLMTlE/mY2BImeGBomTNE+xf3B
 6EimU28plpiBhs5z3qIJu0bWVfwxPAKxDwm5qDj0eY2k5dNkcInRypDqfQgMjjCkXCcQ
 YqR5pCK+3goqROeqlJok+SqXsMFGolQYh5ExBWofUd+wc76YGXuQ+1zveHUNgGAU2hMS
 atHAIOtaRBR7YHAtHQYvpP6qprlHCy8GkBKINT+2WSMTJbmASziN9gAT46Mz6amUvydo
 SZV/x4nr+T5D3a0FTJ9gsWnIpv5ihfqBg1JkUuGp1Zh6xfM5RRsc3mcv32bitT5+zEwo
 rnMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZVx1NzGIeY/GQpMjdNQIeUoC304WPsbPI+HCcdOMRSmpR9n5SSsA111BZM5elp62SKFH0DQl1ltDmw/CoErJ9vVM/
X-Gm-Message-State: AOJu0Yyw9pqN5Ydig/mzddDydyUWc54V7Tanip+arPs6CRURRXt0QOFI
 U9T7HQQetempZEC94U0olzQFWdglrqOrxDbBtIAtUzla39BDlD/I8jLNsg==
X-Google-Smtp-Source: AGHT+IHYQJEzhbpYG/xeyDJh+piQo33e1hUbbA5HZO2L3gHnlXmxaaDEqGpQzcniRUOXFIT5x/RTdg==
X-Received: by 2002:a05:6358:7242:b0:197:c159:fc99 with SMTP id
 e5c5f4694b2df-197e5219072mr108206955d.17.1716505696643; 
 Thu, 23 May 2024 16:08:16 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 06/72] target/ppc: Move sync instructions to decodetree
Date: Fri, 24 May 2024 09:06:39 +1000
Message-ID: <20240523230747.45703-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This tries to faithfully reproduce the odd BookE logic. Note the
e206 check in gen_msync_4xx() is always false, so not carried over.

It does change the handling of non-zero reserved bits outside the
defined fields from being illegal to being ignored, which the
architecture specifies ot help with backward compatibility of new
fields. The existing behaviour causes illegal instruction exceptions
when using new POWER10 sync variants that add new fields, after this
the instructions are accepted and are implemented as supersets of
the new behaviour, as intended.

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode             |   7 ++
 target/ppc/translate.c               | 102 +--------------------
 target/ppc/translate/misc-impl.c.inc | 130 +++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 100 deletions(-)
 create mode 100644 target/ppc/translate/misc-impl.c.inc

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index eada59f59f..6b89804b15 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -998,3 +998,10 @@ MSGSND          011111 ----- ----- ..... 0011001110 -   @X_rb
 MSGCLRP         011111 ----- ----- ..... 0010101110 -   @X_rb
 MSGSNDP         011111 ----- ----- ..... 0010001110 -   @X_rb
 MSGSYNC         011111 ----- ----- ----- 1101110110 -
+
+# Memory Barrier Instructions
+
+&X_sync         l
+@X_sync         ...... ... l:2 ..... ..... .......... .           &X_sync
+SYNC            011111 --- ..  ----- ----- 1001010110 -           @X_sync
+EIEIO           011111 ----- ----- ----- 1101010110 -
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 24461c2d1b..a70c5ed951 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3422,59 +3422,6 @@ static void gen_stswx(DisasContext *ctx)
     gen_helper_stsw(tcg_env, t0, t1, t2);
 }
 
-/***                        Memory synchronisation                         ***/
-/* eieio */
-static void gen_eieio(DisasContext *ctx)
-{
-    TCGBar bar = TCG_MO_ALL;
-
-    /*
-     * eieio has complex semanitcs. It provides memory ordering between
-     * operations in the set:
-     * - loads from CI memory.
-     * - stores to CI memory.
-     * - stores to WT memory.
-     *
-     * It separately also orders memory for operations in the set:
-     * - stores to cacheble memory.
-     *
-     * It also serializes instructions:
-     * - dcbt and dcbst.
-     *
-     * It separately serializes:
-     * - tlbie and tlbsync.
-     *
-     * And separately serializes:
-     * - slbieg, slbiag, and slbsync.
-     *
-     * The end result is that CI memory ordering requires TCG_MO_ALL
-     * and it is not possible to special-case more relaxed ordering for
-     * cacheable accesses. TCG_BAR_SC is required to provide this
-     * serialization.
-     */
-
-    /*
-     * POWER9 has a eieio instruction variant using bit 6 as a hint to
-     * tell the CPU it is a store-forwarding barrier.
-     */
-    if (ctx->opcode & 0x2000000) {
-        /*
-         * ISA says that "Reserved fields in instructions are ignored
-         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
-         * as this is not an instruction software should be using,
-         * complain to the user.
-         */
-        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
-            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at @"
-                          TARGET_FMT_lx "\n", ctx->cia);
-        } else {
-            bar = TCG_MO_ST_LD;
-        }
-    }
-
-    tcg_gen_mb(bar | TCG_BAR_SC);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 {
@@ -3883,31 +3830,6 @@ static void gen_stqcx_(DisasContext *ctx)
 }
 #endif /* defined(TARGET_PPC64) */
 
-/* sync */
-static void gen_sync(DisasContext *ctx)
-{
-    TCGBar bar = TCG_MO_ALL;
-    uint32_t l = (ctx->opcode >> 21) & 3;
-
-    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
-        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
-    }
-
-    /*
-     * We may need to check for a pending TLB flush.
-     *
-     * We do this on ptesync (l == 2) on ppc64 and any sync pn ppc32.
-     *
-     * Additionally, this can only happen in kernel mode however so
-     * check MSR_PR as well.
-     */
-    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
-        gen_check_tlb_flush(ctx, true);
-    }
-
-    tcg_gen_mb(bar | TCG_BAR_SC);
-}
-
 /* wait */
 static void gen_wait(DisasContext *ctx)
 {
@@ -6016,23 +5938,6 @@ static void gen_dlmzb(DisasContext *ctx)
                      cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0);
 }
 
-/* mbar replaces eieio on 440 */
-static void gen_mbar(DisasContext *ctx)
-{
-    /* interpreted as no-op */
-}
-
-/* msync replaces sync on 440 */
-static void gen_msync_4xx(DisasContext *ctx)
-{
-    /* Only e500 seems to treat reserved bits as invalid */
-    if ((ctx->insns_flags2 & PPC2_BOOKE206) &&
-        (ctx->opcode & 0x03FFF801)) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-    }
-    /* otherwise interpreted as no-op */
-}
-
 /* icbt */
 static void gen_icbt_440(DisasContext *ctx)
 {
@@ -6370,6 +6275,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/storage-ctrl-impl.c.inc"
 
+#include "translate/misc-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
@@ -6498,7 +6405,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
@@ -6516,7 +6422,6 @@ GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
 GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
 #endif
-GEN_HANDLER(sync, 0x1F, 0x16, 0x12, 0x039FF801, PPC_MEM_SYNC),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
@@ -6639,9 +6544,6 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
-GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
-              PPC_BOOKE, PPC2_BOOKE206),
-GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x039FF801, PPC_BOOKE),
 GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
new file mode 100644
index 0000000000..cb1a2b707e
--- /dev/null
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -0,0 +1,130 @@
+/*
+ * Power ISA decode for misc instructions
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Memory Barrier Instructions
+ */
+
+static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
+{
+    TCGBar bar = TCG_MO_ALL;
+    uint32_t l = a->l;
+
+    /*
+     * BookE uses the msync mnemonic. This means hwsync, except in the
+     * 440, where it an execution serialisation point that requires all
+     * previous storage accesses to have been performed to memory (which
+     * doesn't matter for TCG).
+     */
+    if (!(ctx->insns_flags & PPC_MEM_SYNC)) {
+        if (ctx->insns_flags & PPC_BOOKE) {
+            /* msync replaces sync on 440, interpreted as nop */
+            /* XXX: this also catches e200 */
+            return true;
+        }
+
+        return false;
+    }
+
+    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
+        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
+    }
+
+    /*
+     * We may need to check for a pending TLB flush.
+     *
+     * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
+     *
+     * Additionally, this can only happen in kernel mode however so
+     * check MSR_PR as well.
+     */
+    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
+        gen_check_tlb_flush(ctx, true);
+    }
+
+    tcg_gen_mb(bar | TCG_BAR_SC);
+
+    return true;
+}
+
+static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
+{
+    TCGBar bar = TCG_MO_ALL;
+
+    /*
+     * BookE uses the mbar instruction instead of eieio, which is basically
+     * full hwsync memory barrier, but is not execution synchronising. For
+     * the purpose of TCG the distinction is not relevant.
+     */
+    if (!(ctx->insns_flags & PPC_MEM_EIEIO)) {
+        if ((ctx->insns_flags & PPC_BOOKE) ||
+            (ctx->insns_flags2 & PPC2_BOOKE206)) {
+            return true;
+        }
+        return false;
+    }
+
+    /*
+     * eieio has complex semanitcs. It provides memory ordering between
+     * operations in the set:
+     * - loads from CI memory.
+     * - stores to CI memory.
+     * - stores to WT memory.
+     *
+     * It separately also orders memory for operations in the set:
+     * - stores to cacheble memory.
+     *
+     * It also serializes instructions:
+     * - dcbt and dcbst.
+     *
+     * It separately serializes:
+     * - tlbie and tlbsync.
+     *
+     * And separately serializes:
+     * - slbieg, slbiag, and slbsync.
+     *
+     * The end result is that CI memory ordering requires TCG_MO_ALL
+     * and it is not possible to special-case more relaxed ordering for
+     * cacheable accesses. TCG_BAR_SC is required to provide this
+     * serialization.
+     */
+
+    /*
+     * POWER9 has a eieio instruction variant using bit 6 as a hint to
+     * tell the CPU it is a store-forwarding barrier.
+     */
+    if (ctx->opcode & 0x2000000) {
+        /*
+         * ISA says that "Reserved fields in instructions are ignored
+         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
+         * as this is not an instruction software should be using,
+         * complain to the user.
+         */
+        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at @"
+                          TARGET_FMT_lx "\n", ctx->cia);
+        } else {
+            bar = TCG_MO_ST_LD;
+        }
+    }
+
+    tcg_gen_mb(bar | TCG_BAR_SC);
+
+    return true;
+}
-- 
2.43.0


