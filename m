Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A67C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJj-0004rc-BY; Sat, 02 Aug 2025 19:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJe-0004TN-E8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:02 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJc-0001Cs-RY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:02 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-619a915c65fso28906eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176019; x=1754780819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7yJ2dOzXEPF3L/bLWXq6zElOhyfMDM32daynhfDIlI=;
 b=mNse4WA+dB9JP4SUrkmcqqMvGConahtdT606xj7yyh4lZl5deiadoHmlo9hTsqO2iE
 9zO6RrWBuy6AGDJk8KTZMq7tjxXY/ni96mDWt5pq14kbIRs1GYxQSOK3aI9oRki4iZ0n
 4wX/+30Ku2x4AqMZCR12zQhSEs7uGuf/BvkNfGIgCOEJtcV9ofPjO1ES54vJME2389Gn
 GceA0XonSFPLZn8LB5wQ7POvUI8/hkZde6Fa3M7NM+wJQQCeK5GUVg9bHLIl1Lghib72
 0JfFlDnDeJ9ZESVpW6PV0NsrHzk27tQRcD5vRyUsAclOPEe1+y7hNuEUxsViwvWPd00k
 Tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176019; x=1754780819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7yJ2dOzXEPF3L/bLWXq6zElOhyfMDM32daynhfDIlI=;
 b=L3cU0Va7frxIakLNM5KRoy30ZDCnD7l+TRBmHTF0vQ+hp0k7Dz07M7uDq4svQPeGcf
 SeKof4VifzhHzi4/oWuetd8M6Fj3TKIh6f1BhnmMWFrPRkbNXZRTwGmmwUlEW3YiNdxt
 e4tC5YyOIe/0UCQDShvwbRhxFUQrGq3EFFo/TlmHIkS48pwsbv9A87qE0XulB81dvwE5
 bmBsPXPWpbuMvbOlvT6TotKm88WCr7oQIYrgULE/XHmp/nK8D5v4ZG+Wj4d/TM8Ats/f
 SQK+Ygf2qWKcuY03a/7qqp/RUD1wszU4HoQ1A0v2BGvchBtXBkxmY8W8U08MW9ezhyxn
 KfKQ==
X-Gm-Message-State: AOJu0YwTnr7KZqUO0VDIyxFcGitjjjFi5KQ6tgqRhiRRdeTRUN2bKvXb
 +MEoM1L5UhczKyaYAvodc3u9xmuM1t+rpZdIxiM1DiA8tOXQtfo3C7DswXuYwE6WbRLiCPNIGMK
 M8CvGeHY=
X-Gm-Gg: ASbGncucAAz5mqo/SrbAFLSX9rfRng2MpPvu5ZQ+niezg3mS+0yt/OiYnZh5Ic3Ll9Q
 knxz8e80izXn0Mcc55jgeYp9QoFSrJ+9xMw+yE8RoE2+U9Jr0IxcYcUPKhPSfR8IOhU668dhmMx
 Ii4zQD+djn+35QveoVPidBr4nU0u6Z5INE+lxtb5xyeQkEitGxlTlAA2/FhbWFV+0fayxwTPLQN
 sQ/NhSFPrWdugmUlVzm8P3nuMhhUYeBKPOna27LA2RRQc74il9oqYoWSaUW0y94dPfXPw63mtJh
 UYuNxT6OML/QfKqQ5qToUQjXmCbf6Eu2EA8aDTx2GB4VO0QORjBNybGSqD2WVZT949wlogA1iHN
 ug/TgNL/ewV52/awK512ahIeiA5RwLWYUfXqA/5RMGRgqxmfV2LnHmqCjBthqlE4=
X-Google-Smtp-Source: AGHT+IF5FUVlDW6HcZzEXEyT6FeZTfEuKcCcFavOStpiTLdBYpNZaLJChrdmkN3DLg7sQrsoweM+CA==
X-Received: by 2002:a05:6820:4de5:b0:619:8541:defa with SMTP id
 006d021491bc7-6198f28d26cmr2307711eaf.6.1754176019676; 
 Sat, 02 Aug 2025 16:06:59 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 31/95] linux-user/ppc: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:55 +1000
Message-ID: <20250802230459.412251-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      | 17 +----------------
 linux-user/ppc/cpu_loop.c | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 887a3a1cb2..a30431c7a2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -485,22 +485,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-static inline void init_thread(struct target_pt_regs *_regs, struct image_info *infop)
-{
-    _regs->gpr[1] = infop->start_stack;
-#if defined(TARGET_PPC64)
-    if (get_ppc64_abi(infop) < 2) {
-        uint64_t val;
-        get_user_u64(val, infop->entry + 8);
-        _regs->gpr[2] = val + infop->load_bias;
-        get_user_u64(val, infop->entry);
-        infop->entry = val + infop->load_bias;
-    } else {
-        _regs->gpr[12] = infop->entry;  /* r12 set to global entry address */
-    }
-#endif
-    _regs->nip = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 2a0efaffcd..22885ffd90 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -378,21 +378,31 @@ void cpu_loop(CPUPPCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
+    abi_ptr entry = info->entry;
+
+    env->gpr[1] = info->start_stack;
+
+#ifdef TARGET_PPC64
+    if (get_ppc64_abi(info) < 2) {
+        uint64_t val;
+        get_user_u64(val, entry + 8);
+        env->gpr[2] = val + info->load_bias;
+        get_user_u64(val, entry);
+        entry = val + info->load_bias;
+    } else {
+        env->gpr[12] = entry;  /* r12 set to global entry address */
+    }
 
-#if defined(TARGET_PPC64)
     int flag = (env->insns_flags2 & PPC2_BOOKE206) ? MSR_CM : MSR_SF;
 #if defined(TARGET_ABI32)
     ppc_store_msr(env, env->msr & ~((target_ulong)1 << flag));
 #else
     ppc_store_msr(env, env->msr | (target_ulong)1 << flag);
 #endif
-#endif
+#endif /* TARGET_PPC64 */
 
-    env->nip = regs->nip;
-    for(i = 0; i < 32; i++) {
-        env->gpr[i] = regs->gpr[i];
-    }
+    env->nip = entry;
 }
-- 
2.43.0


