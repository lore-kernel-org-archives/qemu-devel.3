Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780F3CEB2CA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOcx-00039y-LB; Mon, 30 Sep 2024 18:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOcv-000392-NQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:21 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOct-0002eU-Jp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so716929366b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734338; x=1728339138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYZS2o413t5NEWqhqyvJRLT8+V/Algd2PuxZZg9wbeU=;
 b=mG2tj/ValrGJJuWgAGmFoQHkedMOcpOP7WAVKwquaBrqyFgR/WyLXhDZ8tyXOA48cL
 +SKrjfkHm52lX2x3sJ68FSeg/1urgcgYhWxswbAs341886T6Xg3Mfo87zJOXeHwT4Cac
 rPbfqPmrrEPViPxoQRfpQulR8tpwzqsX9Z5gdEuCmqHNdVjAwMrS6Nv/laEplSrjjW1R
 VMeir8cUg7U49euieU0I7BpoTIVXRkYWQcPCFUJelovtuXflKbOUdlAGtMBW1klshzFG
 pkmFxvxj1/ZdEKgZOAXuDv+yfLlFqEH80zjr8Jzb2JKal5eRvtLNerhLVXB8bUgK87tq
 4zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734338; x=1728339138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYZS2o413t5NEWqhqyvJRLT8+V/Algd2PuxZZg9wbeU=;
 b=tZR/fW98pnuI5cwQ5G4KA+x/6YgACcdj0q3yaZ5d/lJmuLy1q3D9PGmolIV4c/GA1M
 wGnI5re/+EzmsYVdVEY4t98mya1cxOXOATV/datjHOtYL0CJUxf37ADD638EmPzwRzyB
 bjbvv1srtxaj7cd2iHRRduX3vs9+kzlRqkcKih+2SBZADmq+x04khThVLNzQGvSXXlmF
 QCMxDTpUdy4bFZr7DXiDjGLHCTrdtxYB0x3WzYgK1sumwWfyVhA2cvAgvNL2A7JHep6k
 cOnisZH1/Rhgbg+yTqMoEvGpG0wy8Mc39jCZsJ3GdistEQDaHLTAjLO8iITlc1YmWqin
 RGPA==
X-Gm-Message-State: AOJu0Yx13SOiHRY1vx32T4iLD0WqFNqhD6NbhUCzH0cHbp8oD9gtdyWr
 PUWchYsSldHWTQpuafAZ87HW7MdoTynWpwZ1gkhHw3n07wWKVtYRF24xrLhn99EzDyqFl6KWpgi
 8d1I=
X-Google-Smtp-Source: AGHT+IExdxcYq81zX9FJW1somPfFXnJrlrB3XUOVOuJ5BuFtV0StTj0KDem5UMjns62Iq90Ng7Rz4g==
X-Received: by 2002:a17:907:3f25:b0:a8a:926a:d002 with SMTP id
 a640c23a62f3a-a93c48f5b97mr1500610166b.12.1727734337632; 
 Mon, 30 Sep 2024 15:12:17 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2947fbesm593809866b.128.2024.09.30.15.12.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:12:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Laurent Vivier <laurent@vivier.eu>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 1/3] target/arm: Expose arm_cpu_code_is_big_endian() prototype
 in 'cpu.h'
Date: Tue,  1 Oct 2024 00:12:02 +0200
Message-ID: <20240930221205.59101-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930221205.59101-1-philmd@linaro.org>
References: <20240930221205.59101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Expose arm_cpu_code_is_big_endian() so it can be used by hw/ code.
Use it in few places where it was open coded.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h              | 7 +++++++
 linux-user/aarch64/cpu_loop.c | 4 ++--
 linux-user/arm/cpu_loop.c     | 4 ++--
 target/arm/cpu.c              | 6 ++----
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f065756c5c..da8f2b2ec8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3057,6 +3057,13 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     }
 }
 
+static inline bool bswap_code(bool sctlr_b);
+
+static inline bool arm_cpu_code_is_big_endian(CPUARMState *env)
+{
+    return bswap_code(arm_sctlr_b(env));
+}
+
 #include "exec/cpu-all.h"
 
 /*
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 71cdc8be50..68ff3c14f8 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -29,7 +29,7 @@
 
 #define get_user_code_u32(x, gaddr, env)                \
     ({ abi_long __r = get_user_u32((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+        if (!__r && arm_cpu_code_is_big_endian(env)) {  \
             (x) = bswap32(x);                           \
         }                                               \
         __r;                                            \
@@ -37,7 +37,7 @@
 
 #define get_user_code_u16(x, gaddr, env)                \
     ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+        if (!__r && arm_cpu_code_is_big_endian(env)) {  \
             (x) = bswap16(x);                           \
         }                                               \
         __r;                                            \
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index ec665862d9..0cc056be31 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -29,7 +29,7 @@
 
 #define get_user_code_u32(x, gaddr, env)                \
     ({ abi_long __r = get_user_u32((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+        if (!__r && arm_cpu_code_is_big_endian(env)) {  \
             (x) = bswap32(x);                           \
         }                                               \
         __r;                                            \
@@ -37,7 +37,7 @@
 
 #define get_user_code_u16(x, gaddr, env)                \
     ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+        if (!__r && arm_cpu_code_is_big_endian(env)) {  \
             (x) = bswap16(x);                           \
         }                                               \
         __r;                                            \
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..f3198ee2f2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1167,7 +1167,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
     CPUARMState *env = &ac->env;
-    bool sctlr_b;
 
     if (is_a64(env)) {
         info->cap_arch = CS_ARCH_ARM64;
@@ -1194,8 +1193,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->cap_mode = cap_mode;
     }
 
-    sctlr_b = arm_sctlr_b(env);
-    if (bswap_code(sctlr_b)) {
+    if (arm_cpu_code_is_big_endian(env)) {
 #if TARGET_BIG_ENDIAN
         info->endian = BFD_ENDIAN_LITTLE;
 #else
@@ -1204,7 +1202,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-    if (sctlr_b) {
+    if (arm_sctlr_b(env)) {
         info->flags |= INSN_ARM_BE32;
     }
 #endif
-- 
2.45.2


