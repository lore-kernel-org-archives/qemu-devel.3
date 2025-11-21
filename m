Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E23ECFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcrI-00060W-9S; Fri, 21 Nov 2025 20:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbdW-0004Hc-4s
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:37:59 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbdM-0006Dx-M3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:37:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso4295347a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763771846; x=1764376646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=O7KVRf9KkjuzWXhxWUAELGpGWnMWSDWsbCmgLUBiLbAS82EUYX4Hx6VC/TPmPVDnsE
 xKu5Zko/posqxCn8Qrk/yFNJIgeMOUBYudiDF6fR0wQqBgbbMRGbknXKoKF/T5OLK3mB
 R87AQz1YXH2KKJ6iyQLJrNTbcYl3NV2DUuy+7W272p/tlYar7LiWSsm8Wo/o1hcH1zil
 BRvBQsl9jM2+wVcUfMCjQb4QUhLNpVxl5xHVciBsYPFjiNc1qAQXOzuHf9ucwk13dFKJ
 vTxeLLmpXNxhVQCrdq5MF6mQLJQ1gIZ2qk4LkILX60AridyDDkxgbWTjyJBj6ByJH3RZ
 1/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771846; x=1764376646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=PpTiOGuBblNE0Exm4Qcaylu27asBEb+JjQ2bGiwdy+/A+tXFpfVhjQeXFhaoyYO6cd
 KVWbjSGV4GOtp9AwZOIlLDYzrZbFpWxkUYZcTYOK0S8Pjvpp/JzG+WXzvrflSxN2dALN
 bSAKQ4U4Ji6n6ng9ZQtfAlNzTMjzRn00qdroCyecs2XNdBhgcPJFmVyyo7wI/f/Wrbg3
 NzCk6GSVGwFOeQ+ol6gDbne2GeoCHj15ZFEC8qwCv3bqfe3JPiDt3TqwUYuAqyWwUT6U
 4Tm4Zc4hsr/vDbVbJV01RmMnBES+mHzEYFx3KUPO7Nzp+OJcIwmiUMXP5c7qazINuoOz
 8YMw==
X-Gm-Message-State: AOJu0YxwLT2adQd1+kD0gev/SAeXh8rJFkBr1iUke4sd23sEtRv4SBvn
 QQiO38JTvGXMVZPBlPaJig4ZNEgsZhq6JpDzjCOvhrIhaq0E65d6+VEaLWIsx/SUK1Pqz/QmtWl
 d4nLbQE7wYQ==
X-Gm-Gg: ASbGnct0EJiSKuK45KMwH8Pm2z+lpAd0kC1RUHdazB3fy6LJ4DKEznqGaBNz+iUTElF
 nILpQtXvCNJK5FdCkcts8T0PritHCkIsDdL+7Ojk9vOOEy0FUERyE6dCsL1UFlhe/jepN0+K25q
 jViBaEw1hFAX5iecVmw1cICgy9GIep1xQAnEvgFPaXE6ulQ+txxu133QfGRyFa9XNA17aUgj1dn
 rj71DNdQI7XI8RvknPbrMQ/PzCsAdsZ4BxUOqvh/rdG4bA1pV5c/DmrJrpxMkCdyD9TUNFKgI39
 wFSdWC6I4iEJQN49wt4VNh/nQKy0kknWzRSLfAW0Hk7hPlyAbaAn0cMnzbzisueVCbb5AkFLINe
 kiVZyEgBFfp95ne0guXwfh3vSy6RJngw13LeKEF3Jq1ZJ0HoaZyls0S8WqWhQiBuIBvEBXY+U8e
 XbRr6WTSwS5X4AcI8EPs/Bd+fT7Qk+C7/+gjLfdExgwOAdq2uKN+mh7Tn/GFFO
X-Google-Smtp-Source: AGHT+IFGyrbXIQA/mWcfwBA3/DPi2Xn3k/tzNEZtqSYygwo+ZK2frzyKGRo+I3+b+Ow2xi4/97VfGg==
X-Received: by 2002:a05:6000:40dc:b0:42b:39ee:2889 with SMTP id
 ffacd0b85a97d-42cc1d520d7mr2510492f8f.48.1763732711689; 
 Fri, 21 Nov 2025 05:45:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a81sm11468220f8f.26.2025.11.21.05.45.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 01/21] accel/tcg: Add endianness variants of
 cpu_ld{uw, l, q}_code()
Date: Fri, 21 Nov 2025 14:44:43 +0100
Message-ID: <20251121134503.30914-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Allow target with fixed-endianness to not use the MO_TE definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 43 +++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..e4ec4e7d367 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -481,25 +481,56 @@ static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldb_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_lduw_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUW, cpu_mmu_index(cs, true));
     return cpu_ldw_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_ldl_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
+static inline uint64_t cpu_ldq_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
+static inline uint32_t cpu_lduw_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_ldl_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint64_t cpu_ldq_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUQ, cpu_mmu_index(cs, true));
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
+}
+
+#if TARGET_BIG_ENDIAN
+# define cpu_lduw_code        cpu_lduw_be_code
+# define cpu_ldl_code         cpu_ldl_be_code
+# define cpu_ldq_code         cpu_ldq_be_code
+#else
+# define cpu_lduw_code        cpu_lduw_le_code
+# define cpu_ldl_code         cpu_ldl_le_code
+# define cpu_ldq_code         cpu_ldq_le_code
+#endif
+
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.51.0


