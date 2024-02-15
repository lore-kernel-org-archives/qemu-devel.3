Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B312C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahPw-0001f6-Ai; Thu, 15 Feb 2024 14:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPt-0001dr-AK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPZ-0004hF-71
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:03 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso12737315ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708025318; x=1708630118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KR/e7xd2t/WfUhq1nU3nYx+Y5DrBWOVXBN9h9UKvfc=;
 b=RjVJwxAdZRI1wo40etlhF1Ffh0FaC5Eutzl9iHNbDcox3hjElCl5OZdAnojTDOU93c
 i2STawdRueljR01Pttx+pztyy1Ddx8yf2aAHvyp80wvlkRBtZ8e55jYJH8yguGS1015p
 ZCne2UufDLVif8tHNbMSMDseCE6TGmjuuBqJtNa9cynltNPN/nmzSIFC4TwoOxxOjQKt
 aIKMYdrjTFVFiv2mltNIXVzwUhRPOvhu5C7jRTebUnVRCrGPlMGeTZRgpsoWPuGDWosC
 1IfEO8K7+MFrfF1WOUu3ZYWnQSOGb7/lP7LBoW0PWe9o6Rg4DGMH5mIy8GPSR7bJfFyZ
 xhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025318; x=1708630118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KR/e7xd2t/WfUhq1nU3nYx+Y5DrBWOVXBN9h9UKvfc=;
 b=Lp8zTnqb8wiKCkd3tnqs0Scl2WRZO4iQePTm92yuMNPMy+v7RXn9IWAkhSsb+Ek2A/
 Hgeaz/2pFfOwh2C8cuZpnrM/8GDHA1baCpJtor1ZXQE+I3TFqwVGuOGnXA2KVPzkP/QE
 JWTJcWzzO7XspbaxUVGTeOqGoSZbAghs8SqqUP3PSMys8esilsJ69o3U35wCc0jMbIo1
 Q8tJPy6NuUX+i71CQixQyaQqbmUmASLmg2fswjR4N3YSNI4tPoT0At6zL8GfjFG6c3Wf
 r1oMDZTX1Yg9ekg3tpI0ON2Jo5MWKCBWk227RrMIKB8/wpAwomuEHv8Wq7rNKVqZMmqE
 M89g==
X-Gm-Message-State: AOJu0YwgK8SyBmG5Rag5rJFoexdnyEwZJ1iAQT616b8IviDGsYTv+4R5
 lQTKHl7OoCxkTuf8CYidYELZv7KgiFb/GVBf0erDfWl9hozth2HvGfSLwLU3eTM6pCo6rzX+IWz
 W2hcT/WgVgO2k0UmE5Zjr23SyOfHXSN13BlmJOJ0UKRhPq4EOBNnHoeJvegUKk7nz4ZOmveyCal
 d89+mcWYZixtnr6NUaAggXILnHxULDAAnX+T/Qa9JH
X-Google-Smtp-Source: AGHT+IHH07zKpvDk6lvEZgaiG7tRGZgTkNUFnN8TiRSiVQbRRAR2azynSv/UhmuI4NuIotPhoe4okg==
X-Received: by 2002:a17:902:8218:b0:1db:5eaa:e9a2 with SMTP id
 x24-20020a170902821800b001db5eaae9a2mr2529567pln.64.1708025317939; 
 Thu, 15 Feb 2024 11:28:37 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902a60800b001db5ee73fe9sm1618653plq.114.2024.02.15.11.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 11:28:37 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 2/6] accel/tcg: Avoid uncessary call overhead from
 qemu_plugin_vcpu_mem_cb
Date: Fri, 16 Feb 2024 03:28:13 +0800
Message-Id: <20240215192823.729209-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215192823.729209-1-max.chou@sifive.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If there are not any QEMU plugin memory callback functions, checking
before calling the qemu_plugin_vcpu_mem_cb function can reduce the
function call overhead.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 accel/tcg/ldst_common.c.inc | 40 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index c82048e377e..bf24986c562 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -134,7 +134,9 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
     ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_load_cb(env, addr, oi);
+    }
     return ret;
 }
 
@@ -145,7 +147,9 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_load_cb(env, addr, oi);
+    }
     return ret;
 }
 
@@ -156,7 +160,9 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_load_cb(env, addr, oi);
+    }
     return ret;
 }
 
@@ -167,7 +173,9 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_load_cb(env, addr, oi);
+    }
     return ret;
 }
 
@@ -178,7 +186,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_load_cb(env, addr, oi);
+    }
     return ret;
 }
 
@@ -195,7 +205,9 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_store_cb(env, addr, oi);
+    }
 }
 
 void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
@@ -203,7 +215,9 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_store_cb(env, addr, oi);
+    }
 }
 
 void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
@@ -211,7 +225,9 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_store_cb(env, addr, oi);
+    }
 }
 
 void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
@@ -219,7 +235,9 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_store_cb(env, addr, oi);
+    }
 }
 
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
@@ -227,7 +245,9 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        plugin_store_cb(env, addr, oi);
+    }
 }
 
 /*
-- 
2.34.1


