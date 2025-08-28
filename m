Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD374CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraud-0003z2-7t; Thu, 28 Aug 2025 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauI-0003bM-7g
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauF-0005tH-Tg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso4395145e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380902; x=1756985702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=reoWPBYk3yQmUnLtz/TOxOWd9zM5TyHFM2hf1Ap4HwM=;
 b=Db785Euk1GnhVayisNKq63497/j8bNtkM5whvnAtfk1+eMCkFIQebX64tKc62IlOIt
 GYUkXSZc+VBqh2RIxUmaI50QZC96dMNi6rlHJUID+l1piMqdbkL89xRLX8W5ILyHdKQw
 IacQI+oVw79q0vmzyXtJydIp3vuIOAgcoNQjxwceatZiF7ImrP5lCi8u216AACs3GODW
 kCywj7yKtDt4AEkFEMUY3ypWcDPHz9iT4hxGsbavTlgqjgJhNhYnLzH/oGtqCfv5PCRm
 t4mEwF2L+HxSx+XJZuRfdXUkai9fvufReDmIjcUwyHOeLjLnmpRFedN/0Xuj3ue6R/jQ
 FULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380902; x=1756985702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reoWPBYk3yQmUnLtz/TOxOWd9zM5TyHFM2hf1Ap4HwM=;
 b=DCLZ8mb1KfBlNK0bCdiTYgdbRdhxgf4Z7jrl8UAp7PNW3gncJU7z1WcnB+6nCSdawQ
 wiU7RVbvxGoHYh9jQDYdcqchGAiJKfHO9RABgWzQScjMFUzBwzAEswONHO22/QBXABAx
 JzmNyIvKHDlent9gLOsAsp17psWy7J5BLTAVzpIMlPwet0EYbNv153wsrSiylcJdo4VN
 gTGkeNUa8k8ZJyw7q7IWN0mPgMKtk+BjMkPKtgSknULtd7kpAeFbKnjWhjWUFwNQ6Crk
 MYIhNitlvJ7Gf9wvEcd7pcOOcileoLQpsKqBfflqAd+2OegGopbfaOOVJSlC5q9X5kbB
 SCfQ==
X-Gm-Message-State: AOJu0YxzrtqcILFID3Ko4OkaH1ah56C3cMyZNFeDjr2lC7di4T1AoDOg
 ewQAT3diJZ5ffKgksr+hwM4OltCmE4LjavsuOWbBkWni1jfXSP0pEM5EOxhOAPBvr3fRaQ+mr4q
 ui9/t
X-Gm-Gg: ASbGncur4QQ2qvR0ImAqAX76qBi3CwhlTQ7k2klinU8ri8FFFEifjk+CJ+C4NNl1Vw7
 0dsQhfV39YDMLjC2Pw5itqMNO29KsLY835y60SFK3kFbhNwZ7G1Xz4Fk8sGycSrjs+CD7+zazbI
 J1ggEs3k5ToCxsX/P9Os5KWraAS32X0oAMMTay23Y5lGq6yO+AvgOqio0FradU24aDFZC6lqGrt
 ONb62OlhH0Mnov8GBSBOSxlRdEAK0ypob78DloKGh7CjWm0MD1R2tPYE/OBtLICzNWMSrUMbU1n
 D/Fs5UyAzJe4xvufZOWVoMJzo7s9/2rV9+0TkojozYR5/vgXqdVYkKifdnV+Ms3UEb70mFqhzja
 LkKBL4gQsOzlb9wU1ii3Ujlb2+SMr+thxednaR88=
X-Google-Smtp-Source: AGHT+IHwiQ5e25nEi2TGkP+n1taHfTWcppGZcybeRALka+QJraJUDyuNvr5MT162/NgapmRgo2M9qg==
X-Received: by 2002:a05:600c:b96:b0:45b:725e:6acc with SMTP id
 5b1f17b1804b1-45b74359d7dmr44635055e9.31.1756380902214; 
 Thu, 28 Aug 2025 04:35:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg,
 fetch_and, fetch_or
Date: Thu, 28 Aug 2025 12:34:24 +0100
Message-ID: <20250828113430.3214314-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/atomic_template.h         | 80 +++++++++++++++++++++++++++--
 include/accel/tcg/cpu-ldst-common.h | 13 +++--
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 08a475c10ca..ae5203b4390 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -100,7 +100,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
     return ret;
 }
 
-#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -108,7 +107,11 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                                          DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
+#if DATA_SIZE == 16
+    ret = atomic16_xchg(haddr, val);
+#else
     ret = qatomic_xchg__nocheck(haddr, val);
+#endif
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
                           VALUE_LOW(ret),
@@ -119,6 +122,39 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
     return ret;
 }
 
+#if DATA_SIZE == 16
+ABI_TYPE ATOMIC_NAME(fetch_and)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                                MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_and(haddr, val);
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return ret;
+}
+
+ABI_TYPE ATOMIC_NAME(fetch_or)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                               MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_or(haddr, val);
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return ret;
+}
+#else
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
@@ -188,7 +224,7 @@ GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA SIZE < 16 */
+#endif /* DATA SIZE == 16 */
 
 #undef END
 
@@ -225,7 +261,6 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
     return BSWAP(ret);
 }
 
-#if DATA_SIZE < 16
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
@@ -233,7 +268,11 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
                                          DATA_SIZE, retaddr);
     ABI_TYPE ret;
 
+#if DATA_SIZE == 16
+    ret = atomic16_xchg(haddr, BSWAP(val));
+#else
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
+#endif
     ATOMIC_MMU_CLEANUP;
     atomic_trace_rmw_post(env, addr,
                           VALUE_LOW(ret),
@@ -244,6 +283,39 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
     return BSWAP(ret);
 }
 
+#if DATA_SIZE == 16
+ABI_TYPE ATOMIC_NAME(fetch_and)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                                MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_and(haddr, BSWAP(val));
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return BSWAP(ret);
+}
+
+ABI_TYPE ATOMIC_NAME(fetch_or)(CPUArchState *env, vaddr addr, ABI_TYPE val,
+                               MemOpIdx oi, uintptr_t retaddr)
+{
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
+    DATA_TYPE ret = atomic16_fetch_or(haddr, BSWAP(val));
+    ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
+    return BSWAP(ret);
+}
+#else
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
@@ -317,7 +389,7 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef ADD
 
 #undef GEN_ATOMIC_HELPER_FN
-#endif /* DATA_SIZE < 16 */
+#endif /* DATA_SIZE == 16 */
 
 #undef END
 #endif /* DATA_SIZE > 1 */
diff --git a/include/accel/tcg/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
index 8bf17c2fab0..17a3250deda 100644
--- a/include/accel/tcg/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -100,9 +100,6 @@ GEN_ATOMIC_HELPER_ALL(umax_fetch)
 
 GEN_ATOMIC_HELPER_ALL(xchg)
 
-#undef GEN_ATOMIC_HELPER_ALL
-#undef GEN_ATOMIC_HELPER
-
 Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
@@ -110,6 +107,16 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
+GEN_ATOMIC_HELPER(xchg, Int128, o_le)
+GEN_ATOMIC_HELPER(xchg, Int128, o_be)
+GEN_ATOMIC_HELPER(fetch_and, Int128, o_le)
+GEN_ATOMIC_HELPER(fetch_and, Int128, o_be)
+GEN_ATOMIC_HELPER(fetch_or, Int128, o_le)
+GEN_ATOMIC_HELPER(fetch_or, Int128, o_be)
+
+#undef GEN_ATOMIC_HELPER_ALL
+#undef GEN_ATOMIC_HELPER
+
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra);
 uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
-- 
2.43.0


