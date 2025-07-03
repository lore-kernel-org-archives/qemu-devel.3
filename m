Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1694FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkY-0002wM-Vv; Thu, 03 Jul 2025 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkM-0002gy-Id; Thu, 03 Jul 2025 04:56:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkK-00083n-F0; Thu, 03 Jul 2025 04:56:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-235ea292956so50617185ad.1; 
 Thu, 03 Jul 2025 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533001; x=1752137801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95N5DHUFYR/urUJHPiqmxEqBz3CfWOqz9EM3HMn4/jk=;
 b=FiL4O+pDxf3OsHCww9NO9C4/e083TW0V0OiuoJpjVQ7i2FWVenkMO+dMjTbq8bj/tT
 RMp2WY7ZEWcG1jC6JIwTTT1DxRaZBAjMuIMShWQPFz16e3kP3u1f8oMom1eRpyPfGrJY
 FxKMKz3v5Gm4x8xt1L9y7VrO7cG/lY+PIF0GLAkKThJ17g+2quNXmSTaGj83yQtUQTno
 JYZyQfvEWOP83UxV1Fl3V8xlrbHNmXauSLLFqHQWTlVsrD0EHE5DktwplpYSXLFAIK/f
 663FWvr6FGt0SJCbn7O0nzBx8+4nb8e6m0GxdeC/us/WcMy6fx6B50umXhBgeNV9rKxC
 vsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533001; x=1752137801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95N5DHUFYR/urUJHPiqmxEqBz3CfWOqz9EM3HMn4/jk=;
 b=ud+jMh55szu5yYZsFD4gf56bAMClI15l41Y1QyQhFvkgA2acB3MIt/UiImJuQcKVZy
 qbshMIFEC/8+FHn6/5NrU0N/zNSaa28fZH5G+LPJIdVaoD2kqeT5OH2uN8bZ78A+ccvq
 jhihSue5IsXi6CttaqJt7jqmXSLUEWeSDlejc3gCXlomXiSUWmGB4W/iOBOeUEFghV80
 ba36mjOtW3phD9D2hgw8Ecg1cIMO0WLHl7l56+vMVtIrxUH0yZfP0cPlSNXf/rIShJwA
 89RXhfUHdivd6/3iEYbtjsk75lKW+7qxVW/Z/cPcAcyyd9GY33n9am4/cDCAMjA2MpWM
 NVcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU+bzpT0BJbDDIOTtsBdGtr3lR8eaEukh6w+EaYAEP+ZRHaiofeoNdxPvzaCLYQYfetiM2FCBCVw==@nongnu.org
X-Gm-Message-State: AOJu0YyfY4/yw1Kk6/rOdovof/0Sz0Z6oVgGwKIA8L3Ob47od0RGpmpg
 x10ITUxdAJzygc6twD4GYpn8JX7ymz3kRTv4r8wK9CBb0PX7e/ZZwGUcb76GEBeglWk=
X-Gm-Gg: ASbGncse6ppCipieZq8NPaX8wTTgXzpQJJwv3TguMl1BIxyHem6pPX7su04Q6hXOxxk
 NQKzL5p8ox12I9EDevryU/cx3mYbCsZrZ55yN/BqctYwdbm2TT5V+xlzG4zs81WOj3fYnwN4qbM
 gS6sti8te0IcqVMJDAhmFdCxJNdpTYfkk1cotHilA9iiIiQ/oaJ9tBQ7NbPVq/Je+IL0/blHvFG
 C4ZQhQQtyU9eNL4GQ+pMWSOBeKWJrapjnUfHner7djwz1rRTM6H/p/u8bZ6PtmXKoJ9WYaEvJcJ
 ZjLTqC06G3tRvLLgGcHI4OhmkBOXLMNiC21DP1cDwS9yc28mewMW/7MhGb1PBbqNarEBpTwX2X9
 0Le5OyapNoWWt3XBXMR07ItUeXEkFTGUNPf3KkB2slWY=
X-Google-Smtp-Source: AGHT+IEbFgIYugWhe19qxSjOlXu4R2lYhdw4Y6xunbEVMmcLWzvF0M1Lf9EFiEB4NFVk9agjKYBOKA==
X-Received: by 2002:a17:902:c94f:b0:234:a139:11e7 with SMTP id
 d9443c01a7336-23c6e56c268mr93591235ad.35.1751533001105; 
 Thu, 03 Jul 2025 01:56:41 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb3b7bafsm149171255ad.167.2025.07.03.01.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:40 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 06/11] target/arm: Fix VLDR_SG helper load alignment checks
Date: Thu,  3 Jul 2025 18:25:59 +0930
Message-ID: <20250703085604.154449-7-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x62d.google.com
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

This patch adds alignment checks in the load operations in the VLDR_SG
instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 9587f2da7d..633f511a7e 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -218,7 +218,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
  * For loads, predicated lanes are zeroed instead of retaining
  * their previous values.
  */
-#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)        \
+#define DO_VLDR_SG(OP, MFLAG, MTYPE, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)\
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
                           uint32_t base)                                \
     {                                                                   \
@@ -228,13 +228,15 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
             }                                                           \
             addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
             d[H##ESIZE(e)] = (mask & 1) ?                               \
-                cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;         \
+                (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;  \
             if (WB) {                                                   \
                 m[H##ESIZE(e)] = addr;                                  \
             }                                                           \
@@ -286,13 +288,15 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
             }                                                           \
             addr = ADDRFN(base, m[H4(e & ~1)]);                         \
             addr += 4 * (e & 1);                                        \
-            d[H4(e)] = (mask & 1) ? cpu_ldl_data_ra(env, addr, GETPC()) : 0; \
+            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0; \
             if (WB && (e & 1)) {                                        \
                 m[H4(e & ~1)] = addr - 4;                               \
             }                                                           \
@@ -331,22 +335,26 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 #define ADDR_ADD_OSW(BASE, OFFSET) ((BASE) + ((OFFSET) << 2))
 #define ADDR_ADD_OSD(BASE, OFFSET) ((BASE) + ((OFFSET) << 3))
 
-DO_VLDR_SG(vldrb_sg_sh, ldsb, 2, int16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_sw, ldsb, 4, int32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sh, MO_SB, int8_t, ldb, 2, int16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sw, MO_SB, int8_t, ldb, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_sw, MO_TESW, int16_t, ldw, 4, int32_t, uint32_t, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrb_sg_ub, ldub, 1, uint8_t, uint8_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uh, ldub, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uw, ldub, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrw_sg_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_ub, MO_UB, uint8_t, ldb, 1, uint8_t, uint8_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uh, MO_UB, uint8_t, ldb, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uw, MO_UB, uint8_t, ldb, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uh, MO_TEUW, uint16_t, ldw, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uw, MO_TEUW, uint16_t, ldw, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrw_sg_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
 DO_VLDR64_SG(vldrd_sg_ud, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrh_sg_os_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrw_sg_os_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD_OSW, false)
+DO_VLDR_SG(vldrh_sg_os_sw, MO_TESW, int16_t, ldw, 4,
+           int32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uh, MO_TEUW, uint16_t, ldw, 2,
+           uint16_t, uint16_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uw, MO_TEUW, uint16_t, ldw, 4,
+           uint32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrw_sg_os_uw, MO_TEUL, uint32_t, ldl, 4,
+           uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VSTR_SG(vstrb_sg_ub, stb, 1, uint8_t, ADDR_ADD, false)
@@ -362,7 +370,7 @@ DO_VSTR_SG(vstrh_sg_os_uw, stw, 4, uint32_t, ADDR_ADD_OSH, false)
 DO_VSTR_SG(vstrw_sg_os_uw, stl, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VLDR_SG(vldrw_sg_wb_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
+DO_VLDR_SG(vldrw_sg_wb_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
 DO_VSTR_SG(vstrw_sg_wb_uw, stl, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
-- 
2.48.1


