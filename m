Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28A1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29dy-00021e-FE; Wed, 01 May 2024 09:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dw-00021M-Pn; Wed, 01 May 2024 09:05:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dj-0005su-JC; Wed, 01 May 2024 09:05:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so63188365ad.3; 
 Wed, 01 May 2024 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714568687; x=1715173487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5SgQcvAQIPE36cTNApEcTXL3uwK8T1BF7Xdw0ArM00=;
 b=AffuW+B0RAV8d9sUFbGw/hNu6WBLH8Aillku9DqG0gnjrUpDcsB9Us20kecw72Llpa
 HT+erFpuwN4RWaEwKYh3qw9ovZDF4LPYppnbThPW4iTNz07/moR0lBwU/gzBAh+lomKz
 qAVlRXo1ONCm6YvGs3hIheW5FhABbpQF0pAZI2+jBIf6J8oILnhOyhr3r9XOJL5TSz/f
 CrGu4T/bw59z7WueJcyOTAnmSH7EnuSrNVW0guEfx8r/+0ITt2iQJQBOLISQ02EFVIdE
 Dt7cwymJvOzshDaGOvRjrrKBn8C8yhzPsNyNtf0+/iKVM7yXZY5tMxwSz9cT9Nzm9ojG
 puJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714568687; x=1715173487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5SgQcvAQIPE36cTNApEcTXL3uwK8T1BF7Xdw0ArM00=;
 b=sAX6De+kf+ewzGO8KaH9HhYUAwMZid3wEq+Plv1vibjEBLX/muPwgkn/sLUWKTDl51
 EWxOed1rds9K/ykTgoqKQAg2ICYRqEIs2sGvc1X20YIJ7XDVByqb6SRdaYXDIII1X3yi
 5M3K+BLjsf6R8B4HxqzywePf4BYYvFlYn8pesgXfK1kcwT6pvPkp4uhjr2cNWo3Tslc2
 MdxQfc4Gn7eG/6ZR0h1EZxfOcNfScG/AIG+Fu3jsqPj7YLF3E92uoykS1Ne5NWVp3UwV
 Jk6bMhW9Qlh16M6vu+AKMH6l0CwpZyxIAaF5se8gXV2wCIsDBtTVsT3TlJA1UrFYENbV
 aokw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfjZ3xlB/DfUmg4empBZwN1sILdYVfPi3r9UU+V420nPsItNHfi+r9Gow9MF9lHF2dTMNvW0HdWb+h6g5kjR6E4Ln/DM=
X-Gm-Message-State: AOJu0Yykae1rRBnvGRj3qEMzSItogMyRIsOrpttv0VwhWwaJJRB9YaOc
 FRoUBS6tl4mQGuTGCqlOXFpuEXRmVVh7hs/UHOar6uTtQvrxorsEo0x6dQ==
X-Google-Smtp-Source: AGHT+IGaQtgRA1QJN7dEB+p9HJl+m25Ikk9dgJHxWs2WE2uJ3D/3x4iuRB0eL+6KylxEnNTDOyEyXw==
X-Received: by 2002:a17:902:b90c:b0:1e8:5cf9:37fc with SMTP id
 bf12-20020a170902b90c00b001e85cf937fcmr2399989plb.35.1714568687461; 
 Wed, 01 May 2024 06:04:47 -0700 (PDT)
Received: from wheely.local0.net ([1.146.40.196])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a17090276cc00b001e41f1dda43sm24064471plt.75.2024.05.01.06.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 06:04:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
Subject: [PATCH 1/3] target/ppc: Move sync instructions to decodetree
Date: Wed,  1 May 2024 23:04:32 +1000
Message-ID: <20240501130435.941189-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501130435.941189-1-npiggin@gmail.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

This tries to faithfully reproduce the odd BookE logic.

It does change the handling of non-zero reserved bits outside the
defined fields from being illegal to being ignored, which the
architecture specifies ot help with backward compatibility of new
fields. The existing behaviour causes illegal instruction exceptions
when using new POWER10 sync variants that add new fields, after this
the instructions are accepted and are implemented as supersets of
the new behaviour, as intended.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode             |   7 ++
 target/ppc/translate.c               | 102 +-------------------
 target/ppc/translate/misc-impl.c.inc | 135 +++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 100 deletions(-)
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
index 93ffec787c..bb2cabae10 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3423,59 +3423,6 @@ static void gen_stswx(DisasContext *ctx)
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
@@ -3877,31 +3824,6 @@ static void gen_stqcx_(DisasContext *ctx)
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
@@ -6010,23 +5932,6 @@ static void gen_dlmzb(DisasContext *ctx)
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
@@ -6364,6 +6269,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/storage-ctrl-impl.c.inc"
 
+#include "translate/misc-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
@@ -6492,7 +6399,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
@@ -6510,7 +6416,6 @@ GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
 GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
 #endif
-GEN_HANDLER(sync, 0x1F, 0x16, 0x12, 0x039FF801, PPC_MEM_SYNC),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
@@ -6633,9 +6538,6 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
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
index 0000000000..f58bf8b848
--- /dev/null
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -0,0 +1,135 @@
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
+    /* e500 family seems to treat reserved bits as invalid, this enforces l=0 */
+    if ((ctx->insns_flags2 & PPC2_BOOKE206) && (ctx->opcode & 0x03FFF801)) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
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


