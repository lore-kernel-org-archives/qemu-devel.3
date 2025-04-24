Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7CC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kpa-0000Tz-9L; Wed, 23 Apr 2025 20:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmt-0005LV-Kv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmr-0004Ma-Fo
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73972a54919so354074b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455796; x=1746060596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj/uYgShChkHdccTvFGCpCr1FhgqEsUyeN3aymTPxRo=;
 b=s23/HOvVu1NX1cpSQ+4s+xkGYBYtkEp4mwTcN1NpiitBEqdz7WeL/R2fnSz2ZH/U1O
 XtBzNRrU/sxRyT1vKL1X9C3HCxa8yKJ2X6lD4NRQIYnj0pDbu1VKGUSdw6x4khh5i5ou
 /y1IsftWlIspPhIX9xMIPFfozALDP8VHE0GgjKk2mCKKZJ2nsRMDpw1cOq/0wkEazeLc
 WALCDj2sfCwX4+xfOZJ1reLb7KiSqemWgqabRL1eyvHAxr8xKyjuDj3U8hAXjWwCgWTL
 1E7laWutlmQR7kFsKeY5XRnUN/T2u6MJFhNjBDQK0yzx8xjCLHtg1xI0EWdUc3HQfrME
 mTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455796; x=1746060596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj/uYgShChkHdccTvFGCpCr1FhgqEsUyeN3aymTPxRo=;
 b=TMmq8Cbc4oVNXYMTtrGpAl7joU+yMCaCGFKa380oVZ08p9ro3xuChWXZ9vx+1ZId+p
 x+t65lQxchHIK7ev5Hi/HfKFutRTwRNbiQ9OiL12pIkE0v+2uGqaVbPjU0JF2K3MGlEr
 vMTxQo5LSTetlpL8yfB3U/QMPAyrrggh7F6Uabetk1ukHGFTUi+f5BHBP2LE1pEV8f+l
 KMF5tKHoUXnFonkUWrxsPh9eySVzIXh4l1PrOnJP6z1rHESmD3NjNYV8Ve3cGwJVo8BN
 xQ+2gNRGiTnexwCn6LSTDOdcVJEwX8XeaxsxTxZiFEmaHlx606B1aYhBY81PjnKZlcpY
 YCQg==
X-Gm-Message-State: AOJu0YynswxBLpoHcR1lxw7TNQd69eAyhgf/gUbktrBrkZWZxLkvFE/g
 ZzNPJaCHDSVrCN155t57aRIT0rFkud6jYTHXIlhA7zpd0LOiVc3RuCcGH6ge4cG2iVEAYEm29q3
 7
X-Gm-Gg: ASbGncu0z0g+8E6X56ykfCloE8w1ALBGLCyUw03OlZBdBsEiKCUkJRQKFQ2ltfiEIEJ
 s8EutdAE38aGypvAa3UlhCHVUTIZL5E7+3lE3sJbkCfWnwdM3gDL6VWSrZITz0IngWPPbpxHFIf
 jGGIdIyqX8EMK6NxbwO2GBWuT5ePyqf4oW3p/NCyy15EQy+0P+uAAl60e1DryDmIBgq4Bn1Kxgi
 N6JRYFw2LQybgheOnnPMXgxAB+v+Kz0LOJNVMLnqbjprLiR6Qz4WYmabnokvr2p2JxQkN3Yqu+E
 MAJBDEaDaLRoznYIhXlGwIFROInfu8SdxDWbMtIPY5tmoAi1c7DOPWBZLlq4Bojl4s+OAKfQ7gg
 =
X-Google-Smtp-Source: AGHT+IG9qDzYX7qLjXuTCyu6euSxI87jEZ00O2yfEgOlXx0CbP5OAEx0SNu5toRWnAGhjMECwXU73g==
X-Received: by 2002:a05:6a00:8f0c:b0:730:75b1:7219 with SMTP id
 d2e1a72fcca58-73e2465c0e9mr1108469b3a.12.1745455796093; 
 Wed, 23 Apr 2025 17:49:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 027/148] include/exec: Inline *_data memory operations
Date: Wed, 23 Apr 2025 17:47:32 -0700
Message-ID: <20250424004934.598783-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

These need to be per-target for 'abi_ptr'.  Expand inline to
the *_data_ra api with ra == 0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
 accel/tcg/ldst_common.c.inc |  89 --------------------------
 2 files changed, 104 insertions(+), 108 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 2eda652a38..0054508eda 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -74,25 +74,6 @@
 #include "user/guest-host.h"
 #endif /* CONFIG_USER_ONLY */
 
-uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
-uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
-uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
-
-void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
-void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
@@ -342,6 +323,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
     cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
+/*--------------------------*/
+
+static inline uint32_t
+cpu_ldub_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldub_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int8_t)cpu_ldub_data(env, addr);
+}
+
+static inline uint32_t
+cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_lduw_be_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_be_data(env, addr);
+}
+
+static inline uint32_t
+cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldl_be_data_ra(env, addr, 0);
+}
+
+static inline uint64_t
+cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldq_be_data_ra(env, addr, 0);
+}
+
+static inline uint32_t
+cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_lduw_le_data_ra(env, addr, 0);
+}
+
+static inline int
+cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_le_data(env, addr);
+}
+
+static inline uint32_t
+cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldl_le_data_ra(env, addr, 0);
+}
+
+static inline uint64_t
+cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
+{
+    return cpu_ldq_le_data_ra(env, addr, 0);
+}
+
+static inline void
+cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stb_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stw_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stl_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
+{
+    cpu_stq_be_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stw_le_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
+{
+    cpu_stl_le_data_ra(env, addr, val, 0);
+}
+
+static inline void
+cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
+{
+    cpu_stq_le_data_ra(env, addr, val, 0);
+}
+
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 2f203290db..9791a4e9ef 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -243,92 +243,3 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
 }
-
-/*
- * Wrappers of the above
- */
-
-uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldub_data_ra(env, addr, 0);
-}
-
-int cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int8_t)cpu_ldub_data(env, addr);
-}
-
-uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_lduw_be_data_ra(env, addr, 0);
-}
-
-int cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_be_data(env, addr);
-}
-
-uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldl_be_data_ra(env, addr, 0);
-}
-
-uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldq_be_data_ra(env, addr, 0);
-}
-
-uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_lduw_le_data_ra(env, addr, 0);
-}
-
-int cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_le_data(env, addr);
-}
-
-uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldl_le_data_ra(env, addr, 0);
-}
-
-uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
-{
-    return cpu_ldq_le_data_ra(env, addr, 0);
-}
-
-void cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stb_data_ra(env, addr, val, 0);
-}
-
-void cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stw_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stl_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
-{
-    cpu_stq_be_data_ra(env, addr, val, 0);
-}
-
-void cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stw_le_data_ra(env, addr, val, 0);
-}
-
-void cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
-{
-    cpu_stl_le_data_ra(env, addr, val, 0);
-}
-
-void cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
-{
-    cpu_stq_le_data_ra(env, addr, val, 0);
-}
-- 
2.43.0


