Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1ECC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9Tz-0007VK-Pm; Mon, 17 Aug 2026 22:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Ty-0007UV-0t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tt-0008L9-TV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:15 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so430665a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019792; x=1787624592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HhJoO4/xR3OHq4n8jQsS/DwR0a2h9k9Ytg5OxG8RSFI=;
 b=cP1g9hqt3tJAfOz5+Z0kd6FbKhrijhSPTqnhYZ8J2O9P4XptfvRyH0vsnOFpLntGID
 eOZ3M0dPOrOcbY/NRQWQGmGfI1tEr9KvGnxGB8J6smQK0pq99sGOB82/GMH5qvLtuhhF
 0qTGDmad0/a/hm3hN32aJ4rdp8aHEcCzyPdE4izNc+U098/4VmD/LsXewA4vfhKupkKd
 Wm00nhU8fO0LY/ERcwBQrZ75YQz+89zMSGvzX3maDL2fHDGlDXTQzNDSpyljR+ECialM
 GWIW5pd+UAdUKUsn9rx9IcTIeUuuVcsMIygeHmxh7ywSySvbeiz5G++1ryPyMlYMq7jp
 NF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019792; x=1787624592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HhJoO4/xR3OHq4n8jQsS/DwR0a2h9k9Ytg5OxG8RSFI=;
 b=LkQTMlesWP2fkTWGfXKn2r7MkmHyxENXrU/HDqZDIN4UmHHIeg5X5S66zVf7o3jRdg
 THFs4C8561r3eHEyJC3BGzPeSIlQZBFuQLuRZMbLrzlBYQWK+vZWmVqBdOEYQm/qU08Q
 CdKTT0a/9cgjZo2z8f2VHSxmI9xGNuhmVFZjlDpwi4H/DrTFsVBHq5ciyonXqbO9bef8
 xnifTxzqkR2cXJFd7ifXVn178I8afCFVPy2FPy4S20QXeMs/BeCWUmNmVL9Rc96qYejA
 +T++d0sOGQqzjERmLBIy5MYrOqGPH9VCacCtBT3d25vc30ePpZGG/EZLWSV3RAMbb54L
 35dg==
X-Gm-Message-State: AOJu0YxabnLGFuMKZRSiRvBwOAJQbVaGNtnip50id+yTvb9wjbR9MSuU
 c7EkFA7ooQIUSIlRkr2EB1S4bmwQDMsubF4F1HI7ZBY2ulS3SM0v3x40H0gXCA==
X-Gm-Gg: AR+sD12TK6ynEvRvn/PikbOtG0yt55ADpR8lX4zBJZQCGMXx/jE2oRF/nFxKGMuTXNR
 ERiFUtEKQW24Ehf9zWiEwWPrdV97x65SZqECP5ylbgzVQqa71qcxE+gawbIoNIgx5Z4HKN+j04p
 ProhvHBXfooKEPi/s6qQdAYs4puecyg/BAvpNjO558spbBhUsrnbo2UPFqnc1fXHM1X4m2snkPm
 Dv7M+JLhOTBTJkEUulxuNwc3rIMq1oIheekddOTTowaKv4K42Jz15aFX8YWZr7ZzeTZoSN0EBWj
 8tMw9J36o0Op2Yg9yvfWW4qriTHd6OyK+dqf6CV7s17yoTy51GaXkYASyBql3YGPpJHp1t3gCvO
 RhFQA7C3ULTNm/LXTfWO/DYFqja/rIpWUqH1L1Dwmw63CJuoXr4WmNQBb5HtqsbtlFVIpZUoZ7e
 2EH5WTpSLVEVmbWHpyJHkj++/BTKsed2IxB80/Xg70tFoU5ixjanAA56Ny64EPeGOF1y6E6RMIg
 Z3p
X-Received: by 2002:a17:90b:2e42:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-395638b424amr1821729a91.8.1787019792339; 
 Mon, 17 Aug 2026 19:23:12 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:12 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 4/6] target/m68k: Extract Function Codes during TLB fills
Date: Mon, 17 Aug 2026 19:22:20 -0700
Message-ID: <20260818022225.31801-5-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=54weasels@gmail.com; helo=mail-pj1-x102f.google.com
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

High level description:
The Motorola 68020 architecture utilizes 3-bit Function Codes (FC0-FC2) to distinguish between User/Supervisor Data and Program memory spaces during MMU translation. Previously, QEMU's TLB fills did not explicitly extract or pass these codes down to the translation hooks. This patch extracts the explicit Function Codes (either natively or via the `moves` instruction) and packs them into the `access_type` field. This is required for the upcoming Sun-3 emulation, whose external MMU hardware maps entirely different physical address spaces depending on the Function Code asserted on the bus.

Impact on existing functionality:
This change introduces no functional impact to existing ColdFire or Mac/Quadra m68k emulation targets. The extraction logic gracefully defaults to standard mapping modes for platforms that do not implement a custom MMU intercept hook, preserving existing TLB behavior.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/cpu.c       |  4 ++--
 target/m68k/cpu.h       | 10 ++++++----
 target/m68k/helper.c    | 26 ++++++++++++++++++++++++++
 target/m68k/translate.c | 10 ++++++----
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index ce2707dee5..f97f20e999 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -52,8 +52,8 @@ static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
     flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
     if (env->sr & SR_S) {
         flags |= TB_FLAGS_MSR_S;
-        flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+        flags |= (env->sfc << TB_FLAGS_SFC_S_BIT) & TB_FLAGS_SFC_S;
+        flags |= (env->dfc << TB_FLAGS_DFC_S_BIT) & TB_FLAGS_DFC_S;
     }
     if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
         flags |= TB_FLAGS_TRACE;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 058777b891..42d34502fc 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -601,12 +601,14 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_MSR_S_BIT      13
 #define TB_FLAGS_MSR_S          (1 << TB_FLAGS_MSR_S_BIT)
 #define TB_FLAGS_SFC_S_BIT      14
-#define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
-#define TB_FLAGS_DFC_S_BIT      15
-#define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
-#define TB_FLAGS_TRACE          16
+#define TB_FLAGS_SFC_S          (7 << TB_FLAGS_SFC_S_BIT) /* 3 Bits reserved */
+#define TB_FLAGS_DFC_S_BIT      17
+#define TB_FLAGS_DFC_S          (7 << TB_FLAGS_DFC_S_BIT) /* 3 Bits reserved */
+#define TB_FLAGS_TRACE          20
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
+#define MMU_MOVES_FC_BASE       2 /* mmu_idx 2-9 correspond to FC 0-7 */
+
 void dump_mmu(CPUM68KState *env);
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 93739ccda7..f3ee95441a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -975,6 +975,32 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret;
     target_ulong page_size;
 
+    if (qemu_access_type == MMU_INST_FETCH) {
+        access_type = ACCESS_CODE;
+    } else {
+        access_type = ACCESS_DATA;
+        if (qemu_access_type == MMU_DATA_STORE) {
+            access_type |= ACCESS_STORE;
+        }
+    }
+
+    /* Decode explicit Function Codes from moves instructions */
+    if (mmu_idx >= MMU_MOVES_FC_BASE) {
+        uint8_t fc = mmu_idx - MMU_MOVES_FC_BASE;
+        access_type |= (fc << 8); /* Pack explicit FC into access type */
+        if (fc != 1 && fc != 2) {
+            access_type |= ACCESS_SUPER;
+        }
+    } else {
+        /* Standard memory accesses map logically to normal M68K FCs */
+        if (mmu_idx == MMU_KERNEL_IDX) {
+            access_type |= ACCESS_SUPER;
+            access_type |= ((qemu_access_type == MMU_INST_FETCH ? 6 : 5) << 8);
+        } else {
+            access_type |= ((qemu_access_type == MMU_INST_FETCH ? 2 : 1) << 8);
+        }
+    }
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bdf619883c..6aa4c5fafd 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -163,10 +163,12 @@ static void do_writebacks(DisasContext *s)
 #define IS_USER(s) 1
 #else
 #define IS_USER(s)   (!(s->base.tb->flags & TB_FLAGS_MSR_S))
-#define SFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_SFC_S) ? \
-                      MMU_KERNEL_IDX : MMU_USER_IDX)
-#define DFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_DFC_S) ? \
-                      MMU_KERNEL_IDX : MMU_USER_IDX)
+#define SFC_INDEX(s) (MMU_MOVES_FC_BASE + \
+                     (((s)->base.tb->flags & TB_FLAGS_SFC_S) >> \
+                      TB_FLAGS_SFC_S_BIT))
+#define DFC_INDEX(s) (MMU_MOVES_FC_BASE + \
+                     (((s)->base.tb->flags & TB_FLAGS_DFC_S) >> \
+                      TB_FLAGS_DFC_S_BIT))
 #endif
 
 typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
-- 
2.50.1 (Apple Git-155)


