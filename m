Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C33C83F0C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZP-0004Lo-3X; Fri, 04 Jul 2025 10:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPQ-00030W-6j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:03 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPM-0001gn-An
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:59 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so851520fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639335; x=1752244135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/y6ae8MFtHgdri3B/hfnDJLsIID9R8RxmBlWT9Y9/4M=;
 b=xEJZEzQ+2ractfUc8ROuAGifbDV7hDlHIF57lACNxDpOUVxSKkp9qKKwJBQkRlgbNL
 enefb9WquFXVhAM8uE7cM601okabF0Wj3Bp/bmmZViIvohkE6/JpmPpz6wlwMuR90Gt2
 5zcmiu+9Ym8KRdc9yk5SiZIdPXhzuQa1tjtdR5iTuUkLGoKfMob5Ib8sCDAIzx+xgAnH
 RIfWK+vcbRLrhl9PGWGagIfp0q1BFtgjkptzRM34CaMPFr+Z0i6G6WZ7MyY5EnvD/Ijl
 MYZJOx0d9mv6Y4FL0p2vizaToei16xrComXw5wRU4W6X/kx12nWqnbkM8Q/RFfoB3Fhs
 rh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639335; x=1752244135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/y6ae8MFtHgdri3B/hfnDJLsIID9R8RxmBlWT9Y9/4M=;
 b=aYvycXTMwKRfYG35YX4yRkuWCG7tDLxLoBjOsIMdaZVmh+hU3r/4LkGLuz2s/hJibM
 Ljyh2LCVq6dcFFi2YltQeMiWmPOfipXl8vdN72VXTXt0y8bVspvgxZoBmcbkJbfv8GPq
 CVeaYb0FJl+LHhaMk/leTmm+7TGxLgcbK7OZ5OOwRsK4ztpTmmY/mdcmEZv+VbNcIZ+q
 4Y7Udw7du5cWb5NVeVa5SeU/hY+9By2wRB5zdaF8uxdH6QP1326sepUaODpm8pEMYud6
 asEBT3nW0aVO3SBINLebKMjc96iYMvVjqbvOTqv3mmtDynrBtZy8lz1uWy0PyXN/YzOG
 oAyg==
X-Gm-Message-State: AOJu0YxOaanju7nAyeUwLmWvMVmi5zyMTkqP+wVDLlxf4CXqG6M1NDoB
 Ql6GCVAcFtdf+TUebegh0RIiDUZoUQstrxtdKnm/uGUzLsQY1prZ+7Z9gidlsupuL8WcUpsX3dx
 wHYnfT2A=
X-Gm-Gg: ASbGncvl4Bc8eVmguQvkr9oJjAInG/hbuJRRSejAD2HgwvtxpVSopgsEipwdxpCLC5Q
 CdaGXkfzDr23GSpD+9y3uWifzKrR8aSuZGdAAt2RYwoXwoJm3J7OlSMsOQ2UqpJdLIJZ3J/21bn
 7PyexPTRmE/2nPwHNGvCM6tSBfASsL3vNQGrjXR7rtzyfPyyfv6ZuaSVqzPwLlahqQpuBDO7oCB
 oel7hQSHd7hRKbiQnzFvwtGigFss6aBN4WBudlQQ6BAyK4UOXIaFkk3v4Vvl/Hp7SbIk+6QNn9T
 11nOR3ggtvkJ5MmRdXd1CpGlmJ3T7HExsNJ9Wy6FWmgcyfJvqyxT6o5sOfjlXgLGcqTNt6y+Q2T
 fErVE+ZrTxT/Zo9mCPofJ/pwxsHkVa7+xPgcaniV0JOUscwdJ
X-Google-Smtp-Source: AGHT+IHgnqO+DkDMrMm+Rn7hUSH6P72TTWpBMEjvQy3i+NOoSdDhhDfGHpRrBDolrVyY3I1fzPAXlQ==
X-Received: by 2002:a05:6870:79e:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-2f796cae8d2mr2117805fac.29.1751639334864; 
 Fri, 04 Jul 2025 07:28:54 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 096/108] target/arm: Move ld1qq and st1qq primitives to
 sve_ldst_internal.h
Date: Fri,  4 Jul 2025 08:20:59 -0600
Message-ID: <20250704142112.1018902-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Move from sme_helper.c to the shared header.
Add a comment noting the lack of atomicity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_ldst_internal.h | 63 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c        | 44 +++------------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index e87beba435..c67cda9d3b 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -141,6 +141,69 @@ DO_LD_PRIM_3(ld1dqu_le, ld1dd_le)
 #define sve_st1dq_be_tlb   sve_st1dd_be_tlb
 #define sve_st1dq_le_tlb   sve_st1dd_le_tlb
 
+/*
+ * The ARMVectorReg elements are stored in host-endian 64-bit units.
+ * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
+ * corresponds to storing the two 64-bit pieces in little-endian order.
+ */
+/* FIXME: Nothing in this file makes any effort at atomicity. */
+
+static inline void sve_ld1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_be_host(vd, reg_off + 8, host);
+    sve_ld1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_ld1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_le_host(vd, reg_off, host);
+    sve_ld1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_ld1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_ld1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_ld1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_ld1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
+static inline void sve_st1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_be_host(vd, reg_off + 8, host);
+    sve_st1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_st1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_le_host(vd, reg_off, host);
+    sve_st1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_st1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_st1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_st1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_st1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
 #undef DO_LD_TLB
 #undef DO_ST_TLB
 #undef DO_LD_HOST
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c1166e4ffa..df16bb2f9c 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -415,54 +415,22 @@ static inline void sme_##NAME##_v_tlb(CPUARMState *env, void *za,           \
     TLB(env, useronly_clean_ptr(addr), val, ra);                            \
 }
 
-/*
- * The ARMVectorReg elements are stored in host-endian 64-bit units.
- * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
- * corresponds to storing the two 64-bit pieces in little-endian order.
- */
-#define DO_LDQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t val0 = HOST(host), val1 = HOST(host + 8);                      \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
+#define DO_LDQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t val0 = TLB(env, useronly_clean_ptr(addr), ra);                 \
-    uint64_t val1 = TLB(env, useronly_clean_ptr(addr + 8), ra);             \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
     HNAME##_tlb(env, za, tile_vslice_offset(off), addr, ra);                \
 }
 
-#define DO_STQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    HOST(host, ptr[BE]);                                                    \
-    HOST(host + 8, ptr[!BE]);                                               \
-}                                                                           \
+#define DO_STQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    TLB(env, useronly_clean_ptr(addr), ptr[BE], ra);                        \
-    TLB(env, useronly_clean_ptr(addr + 8), ptr[!BE], ra);                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
@@ -477,8 +445,8 @@ DO_LD(ld1s_le, uint32_t, ldl_le_p, cpu_ldl_le_data_ra)
 DO_LD(ld1d_be, uint64_t, ldq_be_p, cpu_ldq_be_data_ra)
 DO_LD(ld1d_le, uint64_t, ldq_le_p, cpu_ldq_le_data_ra)
 
-DO_LDQ(sve_ld1qq_be, sme_ld1q_be, 1, ldq_be_p, cpu_ldq_be_data_ra)
-DO_LDQ(sve_ld1qq_le, sme_ld1q_le, 0, ldq_le_p, cpu_ldq_le_data_ra)
+DO_LDQ(sve_ld1qq_be, sme_ld1q_be)
+DO_LDQ(sve_ld1qq_le, sme_ld1q_le)
 
 DO_ST(st1b, uint8_t, stb_p, cpu_stb_data_ra)
 DO_ST(st1h_be, uint16_t, stw_be_p, cpu_stw_be_data_ra)
@@ -488,8 +456,8 @@ DO_ST(st1s_le, uint32_t, stl_le_p, cpu_stl_le_data_ra)
 DO_ST(st1d_be, uint64_t, stq_be_p, cpu_stq_be_data_ra)
 DO_ST(st1d_le, uint64_t, stq_le_p, cpu_stq_le_data_ra)
 
-DO_STQ(sve_st1qq_be, sme_st1q_be, 1, stq_be_p, cpu_stq_be_data_ra)
-DO_STQ(sve_st1qq_le, sme_st1q_le, 0, stq_le_p, cpu_stq_le_data_ra)
+DO_STQ(sve_st1qq_be, sme_st1q_be)
+DO_STQ(sve_st1qq_le, sme_st1q_le)
 
 #undef DO_LD
 #undef DO_ST
-- 
2.43.0


