Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84041C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLi-0002qf-QQ; Thu, 03 Sep 2026 00:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLh-0002qU-0N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:53 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLe-0006WY-SB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:52 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so2086871a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410809; x=1789015609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnRjqUvuxbPjuZO7YdnutdWizBVmUQWo0boyEFmZtt4=;
 b=colxmeE/iHJeL+KAbMtE82uUWL88KwDgeLKIZPp0hHQLdORaNi9rILfcuIqoeoi+EA
 CClvRzfEx2PoT1rnMcOC4H4wybsOWTtrRZmb+uLqJxD72kADGZHqytPLxmUobkGdxJaR
 Uyu9xg26IWJHRUv0f8IX5goB8INyRvmA+Ixuw8BlVVyOyPpmwXyacHi3bPDACaPUVK6f
 9UyQkaPP6WiAbs5Rx1SuYx5kW0UpNO4YmUz8PbMvEYEMewMwuL/t+RmIvjnYAm2wmCHn
 CCII10fcrUEn3o4ypyQhPYVJwMuzMRBTdhYDvOXMoQhA1Ig24Fe/bjsbOoduNsLrusaj
 eeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410809; x=1789015609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pnRjqUvuxbPjuZO7YdnutdWizBVmUQWo0boyEFmZtt4=;
 b=NgL/hSrlFk/pXh3I+qkBlH4DEBkIngZb4skcIIg0C6iQ9eliXNr9i9oCKEAgfeFS7Q
 pNC9nHkW7aG2cEJGZ4rHxWoyzbkQjvVuqWDUSSEHExq93TTF4yhGYgwredgwUDAslLCm
 5l0h6u0TpOP9tqpwHg5gS/qiIUmDuh/hjrGQj3PoF2BAhjGILjtZaC91LewPRjc4mYOj
 u37MeB3AnfKZWWNLTQUC44BZHNKrfhw5gj/x19s5dykHM8Oe8tYYVlL/t/7BUDsuv5E4
 HJjkxBguuYUZFnJ9mbkgbURpj29W7eSV1wMkcNECGWxuKOEMsGtEf2KCP1NpTwkZGXr6
 NlxQ==
X-Gm-Message-State: AFuF++nvk69lqXHlYj9YsjdYnkWWHdHzSYY1ug5a7IpaJHL11m46kszq
 1s5D2G6MUSM8Kkn/CHscsHs2JKI2rCHUMNcoswsD5COFO4H8aA2WijRsSaSMOKUB
X-Gm-Gg: AYBFou2MurTv1b3Z+wjjr7BFR0o4K1foOslVYjWUABOQzjd9Io4fWxaK+wk+A3BihBO
 YJ6EE0p5w/YULVL0g0sBlG29Xf6zft1f7hqVL8HD4NeVHakNjHJ7laPAanNm2wxEiOwY/miI3UN
 AZ8Qc/u/iOzrnKxedfK6/mr8fTgchw1v4RcbnPgaOsa4i5whbBRYRGsfPEgTcPxlngyVNuS135A
 TW15u6JRKKk8mq4GIH531fhdODkVDWxWswVWkIB1VJqheBeMMM+BDSa7bWSTLbFRxBMVWaukgH2
 E3zyQzIrWmdssL3KmbVqr/A74UzxQi4CbtdXdBjVleEVuSMMEE/4MnXe92hD99FEYt/M+Snrz9P
 vZAoPNwpFwJjJnou3b27rK7j76klP+E6fXmxVaVtD0I9u0n4Zr8nvZNjTz1nvKrvtKehSEnUYLw
 WXZgz2tddvMkxOviftnxOEFPhsLs6n9xJNIetaIuxKmtCzG63YuscRHhNbxWWxDE7FT5LuYZPbN
 NVBMyPRbqKdf3Cs7A==
X-Received: by 2002:a05:6a21:6da9:b0:3d0:88f5:f806 with SMTP id
 adf61e73a8af0-3d9af9ff7b4mr13915122637.15.1788410809252; 
 Wed, 02 Sep 2026 21:46:49 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:48 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 4/6] target/m68k: Extract Function Codes during TLB fills
Date: Wed,  2 Sep 2026 21:45:17 -0700
Message-ID: <20260903044626.24453-5-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
References: <20260903044626.24453-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x534.google.com
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

Why this change is made & How it will be used:
The Motorola 68020 architecture utilizes 3-bit Function Codes (FC0-FC2) to distinguish between User/Supervisor Data and Program memory spaces during MMU translation. Previously, QEMU's TLB fills did not explicitly extract or pass these codes down to the translation hooks. This patch extracts the explicit Function Codes (either natively or via the `moves` instruction) and packs them into the `access_type` field. This is required for the upcoming Sun-3 emulation, whose external MMU hardware maps entirely different physical address spaces depending on the Function Code asserted on the bus.

Impact on existing functionality:
This change introduces no functional impact to existing ColdFire or Mac/Quadra m68k emulation targets. The extraction logic gracefully defaults to standard mapping modes for platforms that do not implement a custom MMU intercept hook, preserving existing TLB behavior.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/cpu.c       |  4 ++--
 target/m68k/cpu.h       | 10 ++++++----
 target/m68k/helper.c    | 26 ++++++++++++++++++++++++++
 target/m68k/translate.c | 10 ++++++----
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 6012dc3186..5d90bb075e 100644
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
index 8f4dec4a40..aadaea770a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -604,12 +604,14 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
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
index c89ef213ed..5ca25a4881 100644
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


