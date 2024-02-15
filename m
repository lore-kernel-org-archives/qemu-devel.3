Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FFFC48BEC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahPz-0001io-IU; Thu, 15 Feb 2024 14:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPx-0001iC-Sz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPg-0004hX-Jc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:09 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1db640fc901so11587705ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708025322; x=1708630122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqJOdAFlOLuV8CILgRx55cvxXityDOLPppAKVjprA0M=;
 b=SR+6R8q8d+O9K5ZjJsH/LxdGOsB2RRGKTAifaG9fnl01MF8NA/sQvi1NngGKD/ff3k
 fRRYwD3wD3sgBfjR8zytGwS4UEt4z94w6AyY7mUrYyy++FAUr3pOJQ1o7XYI5vBF66wr
 /MEYXaIqXobrAJfW632Fk63vHNtsvYg4agNxeSSkhYJVt7DSai1vwAqbCSGdX9uml9/7
 PuvbISa2ocHkOOPqgL3LpKAT9s81nymchZxbxLA6mx/KPMEuPqA6YQcd8HmU+Bbss3DL
 iK95ul/aS4b9vyTKSiKDOLGx5NwGJW0eBH+AlJo+q01O8OrFZ21HHtKpH+gYuiV7SwHX
 bzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025322; x=1708630122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqJOdAFlOLuV8CILgRx55cvxXityDOLPppAKVjprA0M=;
 b=kJTMGRuSP64afwWexBnkCqHMA7LoGE2MP9ich39T597qOvKHNMembFXQzi9YfTnRFz
 VcSovY2PZZimag9mTHOZ9ylKtcEl03d+bWIIEi/6xskQWtjkzbync78a3VobIiCrp8sx
 4TJ3wwsxvmAkiCriqJS3ICD/4YQ4Pkza9jwlj/cKuv4TiSeOTCUMPmibErXG/veyMgXW
 Xt72S4O6VfK2gOr6k92aSEsFlsivY6AKTnkG/46O0Wyv2AVoBRUra7ugEZ1Q0qVmIWyx
 VK8Ejs10a+vTgaySaMQwK2cOaJF6SQcL/ilR+Gvf2m1/7TkJjR9mVxlaSYxFj1e7JMaR
 +/vg==
X-Gm-Message-State: AOJu0Yzqb0CNu0zm73f8enMyn0hM+V9OBYPjMXWp1/jxpwwfOhjJdjio
 QiT6Mk/0Xug8m85fvsF2uubVogYbJJ0G7vrsThXz9wEnNpf5YYU32IPsWexstTBFTpFTQ18WIFa
 CFqsRrUpzGi/KlrvX+W7nBI9f9I6UFQ/t499XFMqqX/F5qPwhQA8B4lxYl2DawB71FhLiAEg/SV
 e34uXTFgnfhuYSzInU+s6whMo7Wrj7zIKdS47iv7ec
X-Google-Smtp-Source: AGHT+IGG99BIj2DOfKEYVErGN6NYizRM/krbGTsBNJ/Cse47yT3eBsPe+SAt74cbFA/GMmDjybeAuw==
X-Received: by 2002:a17:902:8a96:b0:1d8:d5b0:aadb with SMTP id
 p22-20020a1709028a9600b001d8d5b0aadbmr2168871plo.66.1708025321984; 
 Thu, 15 Feb 2024 11:28:41 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902a60800b001db5ee73fe9sm1618653plq.114.2024.02.15.11.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 11:28:41 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [RFC PATCH 3/6] target/riscv: Inline vext_ldst_us and coressponding
 function for performance
Date: Fri, 16 Feb 2024 03:28:14 +0800
Message-Id: <20240215192823.729209-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215192823.729209-1-max.chou@sifive.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In the vector unit-stride load/store helper functions. the vext_ldst_us
function corresponding most of the execution time. Inline the functions
can avoid the function call overhead to imperove the helper function
performance.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e8fbb921449..866f77d321d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -149,25 +149,27 @@ static inline void vext_set_elem_mask(void *v0, int index,
 typedef void vext_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
                                uint32_t idx, void *vd, uintptr_t retaddr);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
-}                                                          \
+#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
+static inline QEMU_ALWAYS_INLINE                        \
+void NAME(CPURISCVState *env, abi_ptr addr,             \
+          uint32_t idx, void *vd, uintptr_t retaddr)    \
+{                                                       \
+    ETYPE *cur = ((ETYPE *)vd + H(idx));                \
+    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);   \
+}                                                       \
 
 GEN_VEXT_LD_ELEM(lde_b, int8_t,  H1, ldsb)
 GEN_VEXT_LD_ELEM(lde_h, int16_t, H2, ldsw)
 GEN_VEXT_LD_ELEM(lde_w, int32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(lde_d, int64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)            \
-static void NAME(CPURISCVState *env, abi_ptr addr,         \
-                 uint32_t idx, void *vd, uintptr_t retaddr)\
-{                                                          \
-    ETYPE data = *((ETYPE *)vd + H(idx));                  \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);       \
+#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)         \
+static inline QEMU_ALWAYS_INLINE                        \
+void NAME(CPURISCVState *env, abi_ptr addr,             \
+          uint32_t idx, void *vd, uintptr_t retaddr)    \
+{                                                       \
+    ETYPE data = *((ETYPE *)vd + H(idx));               \
+    cpu_##STSUF##_data_ra(env, addr, data, retaddr);    \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, int8_t,  H1, stb)
@@ -289,7 +291,7 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d)
  */
 
 /* unmasked unit-stride load and store operation */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
              uintptr_t ra)
-- 
2.34.1


