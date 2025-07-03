Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CBCC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkF-0002Yf-SM; Thu, 03 Jul 2025 04:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkC-0002WE-17; Thu, 03 Jul 2025 04:56:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFk9-00080b-Sq; Thu, 03 Jul 2025 04:56:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so8294540b3a.0; 
 Thu, 03 Jul 2025 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532991; x=1752137791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEzEahgnaMEVhNEBoKt7NK9A09hysKMBO9xMURSLdOA=;
 b=Fg7p36NAGOU/j83HHZnrmoZo+nKFEZxN2HPv4QVMsYh0pF4OLisWd1CNEAp8KBU5As
 muyevLL5EbwXAdgWFT6Ws0ex9GPllTsfsEWJShVfINHR/TMBVcUJXMf6oq5/eUSF0+e8
 Le/QHy8hVP700jQesJL/K6u1VbE1pbEvOxtZwxYYXdRF2PO4C9AIle7ILF/EkFYzysFP
 a3jczhRjc7xcX/WqjiFgTxuO6IPj0JEBraxdHDHk+8/G79x08rWMooIeyfQdtrTAL0Fd
 tb1r2xKuYYuomxtMdk4SpQqpGHacHgePoYxio1Qvotjoj/fM7W3cl2r3cvIlqwVD/Tbc
 VuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532991; x=1752137791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEzEahgnaMEVhNEBoKt7NK9A09hysKMBO9xMURSLdOA=;
 b=mF27SwEr+17MIh+Zjt82AT44XTZGA76wlKu1iJPmo8zG3yXUlvOj41y2xlhpW7pR3s
 RfKtZSiqNbN5laEcQyjmwHR1mOdiklZYLKRuhFA41csySUEcxF43UU8ofRsyFajB7L0z
 BvNF3rKEwyXjYhQ19c1gL4W/bGxNxacvC/g2QpA7pBazwrQ2sqEnm8thJyG78howXu6p
 13rzNIpXvsbtvJUjHsGCNYXacAl45HCMX8MopXhJ1uqKA0WpKimOoT8/ZAe8yrAxkHd5
 jd6RUwoZXV32Odm+Rc+tiGdwtsb4x7DCh00PZezfwXsxKG2+/J8xle///UG8Z9Or8cmd
 X05Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqN8QfL57Hev3VyDunSzDDcxhIZaTu3LKh0Osc1MaL7ONnkChjA0YzzkvYPjxGaki6pcr16BoEIA==@nongnu.org
X-Gm-Message-State: AOJu0YxBXkPJVmJbfDDN7oEA5YuFUGaf2mbelUMbqF0VqZu7JZ7/HMQo
 9TiQgPEcdWMpmYj1GgeStfusjPLsSVuY2f2IVJl/VpfhrcdSNqP+AX0KT4LB2G/4EOU=
X-Gm-Gg: ASbGncstlgTJwbwPkrwOZzSizNTGEmOgBm8Gs+vf1ZjTnDzHbJxbibKFEmxA1mflgeY
 MXEVOIpgk/nnU7spKFJrO7Zx0cO+zWXe22SUEeJywGRE6h5adHJHJFl+jYEjhfAzw0+SgCj3fjv
 h6YOWXvKiNfGzWnmyf8s/UNTqo9jfdI4K9BqbMjoXnlsA82DS8R5/Fb4H4MtFAuAmj9BdnHUfZu
 eeBSFO5fsM9oiC6kUk9lNiKftzEXPf2b8pANN2yZKcp/4zC4BOkPegBKaxTdubqiNHZ5bImMcfI
 mJD9b1EBaQnpFYYayrcTwjeflHvs6RcBhbcpWkrnqG/PW29or0h/YYEI9rJtVfQMS+mavhv4jAn
 92eSZ5Emg9pwzslTLWpjHx7AiqXoCbkjs6/28/NOwrQ0=
X-Google-Smtp-Source: AGHT+IEvMHHgFaaytalz6UQbvUPncZajrApGFHUekdfKCZRo5eVGwOep335jVCVn4k2EGcykuKBUBw==
X-Received: by 2002:a05:6a20:3ca1:b0:1f5:8c05:e8f8 with SMTP id
 adf61e73a8af0-222d7e9bfc7mr9085863637.25.1751532991529; 
 Thu, 03 Jul 2025 01:56:31 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b34e302378bsm13967901a12.23.2025.07.03.01.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:31 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 04/11] target/arm: Fix VLDR helper load alignment checks
Date: Thu,  3 Jul 2025 18:25:57 +0930
Message-ID: <20250703085604.154449-5-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLDR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 506d1c3475..8834523c23 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -148,13 +148,15 @@ static void mve_advance_vpt(CPUARMState *env)
 }
 
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
-#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
+#define DO_VLDR(OP, MFLAG, MSIZE, MTYPE, LDTYPE, ESIZE, TYPE)           \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
     {                                                                   \
         TYPE *d = vd;                                                   \
         uint16_t mask = mve_element_mask(env);                          \
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
          * beats so we don't care if we update part of the dest and     \
@@ -163,7 +165,7 @@ static void mve_advance_vpt(CPUARMState *env)
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (eci_mask & (1 << b)) {                                  \
                 d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
+                    (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;\
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -185,20 +187,20 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
-DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
-DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
+DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
+DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
+DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
 
 DO_VSTR(vstrb, 1, stb, 1, uint8_t)
 DO_VSTR(vstrh, 2, stw, 2, uint16_t)
 DO_VSTR(vstrw, 4, stl, 4, uint32_t)
 
-DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
-DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
-DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
-DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
-DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
-DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
+DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
+DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
+DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
+DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
+DO_VLDR(vldrh_sw, MO_TESW, 2, int16_t, ldw, 4, int32_t)
+DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
 
 DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-- 
2.48.1


