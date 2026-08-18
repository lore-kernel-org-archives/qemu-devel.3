Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80811C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCm-0007Vj-4x; Tue, 18 Aug 2026 13:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCk-0007VD-Ho
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCf-0004n8-MI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so160598b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072540; x=1787677340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DBQIgGtWyeogo0/WHlWkw9M6+qGOO5XHe2Ea+hps8cA=;
 b=jBRm+itrBDPnnC/zXYwCyhyi8WFrd/wB7rRZiyJ3HXzB4nrIjP0P1NcyyiUFV0lVBH
 D501xtnz8RIee4OHeQXMSvyv1j5J5I0ZN4tP8Z5xBrLr37BEFgGIXQ6zHq4T6OWywote
 27/2/fK0vkwX7sIBcNuhnjS/TKxgfgt430WoYPxaq7ySPg/o0g9i4Lw4JJMu/pYDr8QR
 DW0vitdsnpGOHhdj6Jo0Rq4SF/sJfcBujJxQx+ZK/wXHFL10Tmro+GAI2SZCycrZ91Oj
 YfkCNuko6Qfw89F5XpgEvpu4ahvZgWYamXqwrh87BQnCwP+woCdLBBFzXQMVBq6nYFMW
 YvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072540; x=1787677340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DBQIgGtWyeogo0/WHlWkw9M6+qGOO5XHe2Ea+hps8cA=;
 b=VELn9YijDme9v9EHA42rCIqzMSbiB7/tPVVow7mtf5kP7KOwNzoryWYsZY2geLfZPd
 pmqW800Tv54TZcweTKA+J4WVtlme7H0lJFSxRFFF3MJR2FeK4QrPU7FCTy2yMY1X05jr
 V+5J7udDPlCVAx3DTqfqREG6tuFaUNYsyVjL9K3WETqoGTH14q7mD+o19ggfGl9wKjpP
 23R/zxDQ1VWz9fua+E1DMGmTv8OGjDaJjb8QyQuyUvw70jy7LufdL6hKk/9x4LuY9G5t
 rPRb1KoEQbX8eql2hlCmQmSQRnbqntGxiAELyBg9VD+W62tA6hXDZ6mW8WKvuoYZ0x5q
 uFYQ==
X-Gm-Message-State: AOJu0YwcfPCUOogN1a4aJLdm/eMNtSSPn911m/dpACQ95ptI8N93s4MO
 DqoQnQiZHoD0FXDa3PM5L7zsNR+9YB4MEu1e2KPYs95qlY9ec7uaNOE7ZxlVPf6hsX7IpQ0XGXr
 th/aiWds=
X-Gm-Gg: AR+sD1340vI1bk8xG1gXvbbDX9Mywj50MRXlePAvHYyddEfMLn7vHSFFb2oSDBFZ+wn
 Xu7Cv2NLtZP9No9iOQD0HzLMq/gVHD+1iI/+gd93h9CAG5xt7GEV01vQaXiTPYHZB3ULbxI05D1
 STsdloTPkdPQyrJ9Z+qjew/Jwxcctnaa99jOwrJBHqQaWwgGghATyk0KUv2yiMwHA8D7P8Qxu0s
 RM/ZwCoLVy97KDnzoZI84AnRk5HOulH0pVnapYXDL5FI9wS5KAJR8eNrH28dtGzGCkLpOUD615Y
 0itETLlHn8yku8dMhakoxMWfxIVAwmz/ufIT/k+cK4bAOMUm54DcerVL/NqDWYOeSe4ldsw0on0
 3ShxNaxCaL8AJhKgJngcicU+61jbgaFB8qMxZhPknaZyjV4PshEfmDzppd9MBm9BPihj4Yu2VuI
 DMIMQx8hSkYXd1rDuUoOYg9NeO5jtXfBwRz2f/BK2dGZCkQ1EmZrvfQ7DrzXxHCbjeyZ2WCw3EE
 0MB2/7DvrXLJlwXvAISNbEoaMF6OESch+0=
X-Received: by 2002:a05:6a00:a244:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-84fde15f198mr33638033b3a.9.1787072538551; 
 Tue, 18 Aug 2026 10:02:18 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] tcg/loongarch64: Import REVBIT insns
Date: Tue, 18 Aug 2026 10:01:34 -0700
Message-ID: <20260818170155.1907006-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 960 +++++++++++++++-------------
 1 file changed, 503 insertions(+), 457 deletions(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index 6bb8656fd8..e907fc755f 100644
--- a/tcg/loongarch64/tcg-insn-defs.c.inc
+++ b/tcg/loongarch64/tcg-insn-defs.c.inc
@@ -4,7 +4,7 @@
  *
  * This file is auto-generated by genqemutcgdefs from
  * https://github.com/loongson-community/loongarch-opcodes,
- * from commit 7f353fb69bd99ce6edfad7ad63948c4bb526f0bf.
+ * from commit 1b95bb8c443ad71e266120fd97bd227df2d8ecfc.
  * DO NOT EDIT.
  */
 
@@ -18,6 +18,10 @@ typedef enum {
     OPC_REVB_2H = 0x00003000,
     OPC_REVB_2W = 0x00003800,
     OPC_REVB_D = 0x00003c00,
+    OPC_REVBIT_4B = 0x00004800,
+    OPC_REVBIT_8B = 0x00004c00,
+    OPC_REVBIT_W = 0x00005000,
+    OPC_REVBIT_D = 0x00005400,
     OPC_SEXT_H = 0x00005800,
     OPC_SEXT_B = 0x00005c00,
     OPC_ADD_W = 0x00100000,
@@ -545,14 +549,14 @@ typedef enum {
     OPC_XVLDI = 0x77e00000,
 } LoongArchInsn;
 
-static int32_t __attribute__((unused))
-encode_d_slot(LoongArchInsn opc, uint32_t d)
+static int32_t __attribute__((unused)) encode_d_slot(LoongArchInsn opc,
+                                                     uint32_t d)
 {
     return opc | d;
 }
 
-static int32_t __attribute__((unused))
-encode_dj_slots(LoongArchInsn opc, uint32_t d, uint32_t j)
+static int32_t __attribute__((unused)) encode_dj_slots(LoongArchInsn opc,
+                                                       uint32_t d, uint32_t j)
 {
     return opc | d | j << 5;
 }
@@ -563,43 +567,43 @@ encode_djk_slots(LoongArchInsn opc, uint32_t d, uint32_t j, uint32_t k)
     return opc | d | j << 5 | k << 10;
 }
 
-static int32_t __attribute__((unused))
-encode_djka_slots(LoongArchInsn opc, uint32_t d, uint32_t j, uint32_t k,
-                  uint32_t a)
+static int32_t __attribute__((unused)) encode_djka_slots(LoongArchInsn opc,
+                                                         uint32_t d, uint32_t j,
+                                                         uint32_t k, uint32_t a)
 {
     return opc | d | j << 5 | k << 10 | a << 15;
 }
 
-static int32_t __attribute__((unused))
-encode_djkm_slots(LoongArchInsn opc, uint32_t d, uint32_t j, uint32_t k,
-                  uint32_t m)
+static int32_t __attribute__((unused)) encode_djkm_slots(LoongArchInsn opc,
+                                                         uint32_t d, uint32_t j,
+                                                         uint32_t k, uint32_t m)
 {
     return opc | d | j << 5 | k << 10 | m << 16;
 }
 
-static int32_t __attribute__((unused))
-encode_djkn_slots(LoongArchInsn opc, uint32_t d, uint32_t j, uint32_t k,
-                  uint32_t n)
+static int32_t __attribute__((unused)) encode_djkn_slots(LoongArchInsn opc,
+                                                         uint32_t d, uint32_t j,
+                                                         uint32_t k, uint32_t n)
 {
     return opc | d | j << 5 | k << 10 | n << 18;
 }
 
-static int32_t __attribute__((unused))
-encode_dk_slots(LoongArchInsn opc, uint32_t d, uint32_t k)
+static int32_t __attribute__((unused)) encode_dk_slots(LoongArchInsn opc,
+                                                       uint32_t d, uint32_t k)
 {
     return opc | d | k << 10;
 }
 
-static int32_t __attribute__((unused))
-encode_dfj_insn(LoongArchInsn opc, TCGReg d, TCGReg fj)
+static int32_t __attribute__((unused)) encode_dfj_insn(LoongArchInsn opc,
+                                                       TCGReg d, TCGReg fj)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(fj >= 0x20 && fj <= 0x3f);
     return encode_dj_slots(opc, d, fj & 0x1f);
 }
 
-static int32_t __attribute__((unused))
-encode_dj_insn(LoongArchInsn opc, TCGReg d, TCGReg j)
+static int32_t __attribute__((unused)) encode_dj_insn(LoongArchInsn opc,
+                                                      TCGReg d, TCGReg j)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -669,9 +673,10 @@ encode_djuk5_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk5)
     return encode_djk_slots(opc, d, j, uk5);
 }
 
-static int32_t __attribute__((unused))
-encode_djuk5um5_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk5,
-                     uint32_t um5)
+static int32_t __attribute__((unused)) encode_djuk5um5_insn(LoongArchInsn opc,
+                                                            TCGReg d, TCGReg j,
+                                                            uint32_t uk5,
+                                                            uint32_t um5)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -689,9 +694,10 @@ encode_djuk6_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk6)
     return encode_djk_slots(opc, d, j, uk6);
 }
 
-static int32_t __attribute__((unused))
-encode_djuk6um6_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk6,
-                     uint32_t um6)
+static int32_t __attribute__((unused)) encode_djuk6um6_insn(LoongArchInsn opc,
+                                                            TCGReg d, TCGReg j,
+                                                            uint32_t uk6,
+                                                            uint32_t um6)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -700,16 +706,16 @@ encode_djuk6um6_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk6,
     return encode_djkm_slots(opc, d, j, uk6, um6);
 }
 
-static int32_t __attribute__((unused))
-encode_dsj20_insn(LoongArchInsn opc, TCGReg d, int32_t sj20)
+static int32_t __attribute__((unused)) encode_dsj20_insn(LoongArchInsn opc,
+                                                         TCGReg d, int32_t sj20)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(sj20 >= -0x80000 && sj20 <= 0x7ffff);
     return encode_dj_slots(opc, d, sj20 & 0xfffff);
 }
 
-static int32_t __attribute__((unused))
-encode_dtj_insn(LoongArchInsn opc, TCGReg d, TCGReg tj)
+static int32_t __attribute__((unused)) encode_dtj_insn(LoongArchInsn opc,
+                                                       TCGReg d, TCGReg tj)
 {
     tcg_debug_assert(d >= 0 && d <= 0x1f);
     tcg_debug_assert(tj >= 0 && tj <= 0x3);
@@ -770,16 +776,16 @@ encode_dxjuk3_insn(LoongArchInsn opc, TCGReg d, TCGReg xj, uint32_t uk3)
     return encode_djk_slots(opc, d, xj & 0x1f, uk3);
 }
 
-static int32_t __attribute__((unused))
-encode_fdfj_insn(LoongArchInsn opc, TCGReg fd, TCGReg fj)
+static int32_t __attribute__((unused)) encode_fdfj_insn(LoongArchInsn opc,
+                                                        TCGReg fd, TCGReg fj)
 {
     tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
     tcg_debug_assert(fj >= 0x20 && fj <= 0x3f);
     return encode_dj_slots(opc, fd & 0x1f, fj & 0x1f);
 }
 
-static int32_t __attribute__((unused))
-encode_fdj_insn(LoongArchInsn opc, TCGReg fd, TCGReg j)
+static int32_t __attribute__((unused)) encode_fdj_insn(LoongArchInsn opc,
+                                                       TCGReg fd, TCGReg j)
 {
     tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -804,37 +810,37 @@ encode_fdjsk12_insn(LoongArchInsn opc, TCGReg fd, TCGReg j, int32_t sk12)
     return encode_djk_slots(opc, fd & 0x1f, j, sk12 & 0xfff);
 }
 
-static int32_t __attribute__((unused))
-encode_sd10k16_insn(LoongArchInsn opc, int32_t sd10k16)
+static int32_t __attribute__((unused)) encode_sd10k16_insn(LoongArchInsn opc,
+                                                           int32_t sd10k16)
 {
     tcg_debug_assert(sd10k16 >= -0x2000000 && sd10k16 <= 0x1ffffff);
     return encode_dk_slots(opc, (sd10k16 >> 16) & 0x3ff, sd10k16 & 0xffff);
 }
 
-static int32_t __attribute__((unused))
-encode_sd5k16_insn(LoongArchInsn opc, int32_t sd5k16)
+static int32_t __attribute__((unused)) encode_sd5k16_insn(LoongArchInsn opc,
+                                                          int32_t sd5k16)
 {
     tcg_debug_assert(sd5k16 >= -0x100000 && sd5k16 <= 0xfffff);
     return encode_dk_slots(opc, (sd5k16 >> 16) & 0x1f, sd5k16 & 0xffff);
 }
 
-static int32_t __attribute__((unused))
-encode_tdj_insn(LoongArchInsn opc, TCGReg td, TCGReg j)
+static int32_t __attribute__((unused)) encode_tdj_insn(LoongArchInsn opc,
+                                                       TCGReg td, TCGReg j)
 {
     tcg_debug_assert(td >= 0 && td <= 0x3);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
     return encode_dj_slots(opc, td, j);
 }
 
-static int32_t __attribute__((unused))
-encode_ud15_insn(LoongArchInsn opc, uint32_t ud15)
+static int32_t __attribute__((unused)) encode_ud15_insn(LoongArchInsn opc,
+                                                        uint32_t ud15)
 {
     tcg_debug_assert(ud15 <= 0x7fff);
     return encode_d_slot(opc, ud15);
 }
 
-static int32_t __attribute__((unused))
-encode_vdj_insn(LoongArchInsn opc, TCGReg vd, TCGReg j)
+static int32_t __attribute__((unused)) encode_vdj_insn(LoongArchInsn opc,
+                                                       TCGReg vd, TCGReg j)
 {
     tcg_debug_assert(vd >= 0x20 && vd <= 0x3f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -974,8 +980,8 @@ encode_vdsj13_insn(LoongArchInsn opc, TCGReg vd, int32_t sj13)
     return encode_dj_slots(opc, vd & 0x1f, sj13 & 0x1fff);
 }
 
-static int32_t __attribute__((unused))
-encode_vdvj_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj)
+static int32_t __attribute__((unused)) encode_vdvj_insn(LoongArchInsn opc,
+                                                        TCGReg vd, TCGReg vj)
 {
     tcg_debug_assert(vd >= 0x20 && vd <= 0x3f);
     tcg_debug_assert(vj >= 0x20 && vj <= 0x3f);
@@ -1083,8 +1089,8 @@ encode_vdvjvkva_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj, TCGReg vk,
     return encode_djka_slots(opc, vd & 0x1f, vj & 0x1f, vk & 0x1f, va & 0x1f);
 }
 
-static int32_t __attribute__((unused))
-encode_xdj_insn(LoongArchInsn opc, TCGReg xd, TCGReg j)
+static int32_t __attribute__((unused)) encode_xdj_insn(LoongArchInsn opc,
+                                                       TCGReg xd, TCGReg j)
 {
     tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
     tcg_debug_assert(j >= 0 && j <= 0x1f);
@@ -1206,8 +1212,8 @@ encode_xdsj13_insn(LoongArchInsn opc, TCGReg xd, int32_t sj13)
     return encode_dj_slots(opc, xd & 0x1f, sj13 & 0x1fff);
 }
 
-static int32_t __attribute__((unused))
-encode_xdxj_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj)
+static int32_t __attribute__((unused)) encode_xdxj_insn(LoongArchInsn opc,
+                                                        TCGReg xd, TCGReg xj)
 {
     tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
     tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
@@ -1316,523 +1322,555 @@ encode_xdxjxkxa_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, TCGReg xk,
 }
 
 /* Emits the `movgr2scr td, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_movgr2scr(TCGContext *s, TCGReg td, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_movgr2scr(TCGContext *s,
+                                                          TCGReg td, TCGReg j)
 {
     tcg_out32(s, encode_tdj_insn(OPC_MOVGR2SCR, td, j));
 }
 
 /* Emits the `movscr2gr d, tj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_movscr2gr(TCGContext *s, TCGReg d, TCGReg tj)
+static void __attribute__((unused)) tcg_out_opc_movscr2gr(TCGContext *s,
+                                                          TCGReg d, TCGReg tj)
 {
     tcg_out32(s, encode_dtj_insn(OPC_MOVSCR2GR, d, tj));
 }
 
 /* Emits the `clz.w d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_clz_w(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_clz_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_CLZ_W, d, j));
 }
 
 /* Emits the `ctz.w d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ctz_w(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_ctz_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_CTZ_W, d, j));
 }
 
 /* Emits the `clz.d d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_clz_d(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_clz_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_CLZ_D, d, j));
 }
 
 /* Emits the `ctz.d d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ctz_d(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_ctz_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_CTZ_D, d, j));
 }
 
 /* Emits the `revb.2h d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_revb_2h(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_revb_2h(TCGContext *s, TCGReg d,
+                                                        TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_REVB_2H, d, j));
 }
 
 /* Emits the `revb.2w d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_revb_2w(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_revb_2w(TCGContext *s, TCGReg d,
+                                                        TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_REVB_2W, d, j));
 }
 
 /* Emits the `revb.d d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_revb_d(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_revb_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_REVB_D, d, j));
 }
 
+/* Emits the `revbit.4b d, j` instruction.  */
+static void __attribute__((unused)) tcg_out_opc_revbit_4b(TCGContext *s,
+                                                          TCGReg d, TCGReg j)
+{
+    tcg_out32(s, encode_dj_insn(OPC_REVBIT_4B, d, j));
+}
+
+/* Emits the `revbit.8b d, j` instruction.  */
+static void __attribute__((unused)) tcg_out_opc_revbit_8b(TCGContext *s,
+                                                          TCGReg d, TCGReg j)
+{
+    tcg_out32(s, encode_dj_insn(OPC_REVBIT_8B, d, j));
+}
+
+/* Emits the `revbit.w d, j` instruction.  */
+static void __attribute__((unused)) tcg_out_opc_revbit_w(TCGContext *s,
+                                                         TCGReg d, TCGReg j)
+{
+    tcg_out32(s, encode_dj_insn(OPC_REVBIT_W, d, j));
+}
+
+/* Emits the `revbit.d d, j` instruction.  */
+static void __attribute__((unused)) tcg_out_opc_revbit_d(TCGContext *s,
+                                                         TCGReg d, TCGReg j)
+{
+    tcg_out32(s, encode_dj_insn(OPC_REVBIT_D, d, j));
+}
+
 /* Emits the `sext.h d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sext_h(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_sext_h(TCGContext *s, TCGReg d,
+                                                       TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_SEXT_H, d, j));
 }
 
 /* Emits the `sext.b d, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sext_b(TCGContext *s, TCGReg d, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_sext_b(TCGContext *s, TCGReg d,
+                                                       TCGReg j)
 {
     tcg_out32(s, encode_dj_insn(OPC_SEXT_B, d, j));
 }
 
 /* Emits the `add.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_add_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_add_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ADD_W, d, j, k));
 }
 
 /* Emits the `add.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_add_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_add_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ADD_D, d, j, k));
 }
 
 /* Emits the `sub.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sub_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sub_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SUB_W, d, j, k));
 }
 
 /* Emits the `sub.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sub_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sub_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SUB_D, d, j, k));
 }
 
 /* Emits the `slt d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_slt(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_slt(TCGContext *s, TCGReg d,
+                                                    TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SLT, d, j, k));
 }
 
 /* Emits the `sltu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sltu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sltu(TCGContext *s, TCGReg d,
+                                                     TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SLTU, d, j, k));
 }
 
 /* Emits the `maskeqz d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_maskeqz(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_maskeqz(TCGContext *s, TCGReg d,
+                                                        TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MASKEQZ, d, j, k));
 }
 
 /* Emits the `masknez d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_masknez(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_masknez(TCGContext *s, TCGReg d,
+                                                        TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MASKNEZ, d, j, k));
 }
 
 /* Emits the `nor d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_nor(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_nor(TCGContext *s, TCGReg d,
+                                                    TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_NOR, d, j, k));
 }
 
 /* Emits the `and d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_and(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_and(TCGContext *s, TCGReg d,
+                                                    TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_AND, d, j, k));
 }
 
 /* Emits the `or d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_or(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_or(TCGContext *s, TCGReg d,
+                                                   TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_OR, d, j, k));
 }
 
 /* Emits the `xor d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xor(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_xor(TCGContext *s, TCGReg d,
+                                                    TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_XOR, d, j, k));
 }
 
 /* Emits the `orn d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_orn(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_orn(TCGContext *s, TCGReg d,
+                                                    TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ORN, d, j, k));
 }
 
 /* Emits the `andn d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_andn(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_andn(TCGContext *s, TCGReg d,
+                                                     TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ANDN, d, j, k));
 }
 
 /* Emits the `sll.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sll_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sll_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SLL_W, d, j, k));
 }
 
 /* Emits the `srl.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srl_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_srl_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SRL_W, d, j, k));
 }
 
 /* Emits the `sra.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sra_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sra_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SRA_W, d, j, k));
 }
 
 /* Emits the `sll.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sll_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sll_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SLL_D, d, j, k));
 }
 
 /* Emits the `srl.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srl_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_srl_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SRL_D, d, j, k));
 }
 
 /* Emits the `sra.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sra_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_sra_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_SRA_D, d, j, k));
 }
 
 /* Emits the `rotr.b d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotr_b(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_rotr_b(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ROTR_B, d, j, k));
 }
 
 /* Emits the `rotr.h d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotr_h(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_rotr_h(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ROTR_H, d, j, k));
 }
 
 /* Emits the `rotr.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotr_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_rotr_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ROTR_W, d, j, k));
 }
 
 /* Emits the `rotr.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotr_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_rotr_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_ROTR_D, d, j, k));
 }
 
 /* Emits the `mul.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mul_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mul_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MUL_W, d, j, k));
 }
 
 /* Emits the `mulh.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mulh_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mulh_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MULH_W, d, j, k));
 }
 
 /* Emits the `mulh.wu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mulh_wu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mulh_wu(TCGContext *s, TCGReg d,
+                                                        TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MULH_WU, d, j, k));
 }
 
 /* Emits the `mul.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mul_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mul_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MUL_D, d, j, k));
 }
 
 /* Emits the `mulh.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mulh_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mulh_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MULH_D, d, j, k));
 }
 
 /* Emits the `mulh.du d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mulh_du(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mulh_du(TCGContext *s, TCGReg d,
+                                                        TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MULH_DU, d, j, k));
 }
 
 /* Emits the `div.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_div_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_div_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_DIV_W, d, j, k));
 }
 
 /* Emits the `mod.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mod_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mod_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MOD_W, d, j, k));
 }
 
 /* Emits the `div.wu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_div_wu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_div_wu(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_DIV_WU, d, j, k));
 }
 
 /* Emits the `mod.wu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mod_wu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mod_wu(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MOD_WU, d, j, k));
 }
 
 /* Emits the `div.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_div_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_div_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_DIV_D, d, j, k));
 }
 
 /* Emits the `mod.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mod_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mod_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MOD_D, d, j, k));
 }
 
 /* Emits the `div.du d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_div_du(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_div_du(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_DIV_DU, d, j, k));
 }
 
 /* Emits the `mod.du d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_mod_du(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_mod_du(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_MOD_DU, d, j, k));
 }
 
 /* Emits the `slli.w d, j, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_slli_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5)
+static void __attribute__((unused)) tcg_out_opc_slli_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk5)
 {
     tcg_out32(s, encode_djuk5_insn(OPC_SLLI_W, d, j, uk5));
 }
 
 /* Emits the `slli.d d, j, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_slli_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6)
+static void __attribute__((unused)) tcg_out_opc_slli_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk6)
 {
     tcg_out32(s, encode_djuk6_insn(OPC_SLLI_D, d, j, uk6));
 }
 
 /* Emits the `srli.w d, j, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srli_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5)
+static void __attribute__((unused)) tcg_out_opc_srli_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk5)
 {
     tcg_out32(s, encode_djuk5_insn(OPC_SRLI_W, d, j, uk5));
 }
 
 /* Emits the `srli.d d, j, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srli_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6)
+static void __attribute__((unused)) tcg_out_opc_srli_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk6)
 {
     tcg_out32(s, encode_djuk6_insn(OPC_SRLI_D, d, j, uk6));
 }
 
 /* Emits the `srai.w d, j, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srai_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5)
+static void __attribute__((unused)) tcg_out_opc_srai_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk5)
 {
     tcg_out32(s, encode_djuk5_insn(OPC_SRAI_W, d, j, uk5));
 }
 
 /* Emits the `srai.d d, j, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_srai_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6)
+static void __attribute__((unused)) tcg_out_opc_srai_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, uint32_t uk6)
 {
     tcg_out32(s, encode_djuk6_insn(OPC_SRAI_D, d, j, uk6));
 }
 
 /* Emits the `rotri.b d, j, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotri_b(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk3)
+static void __attribute__((unused)) tcg_out_opc_rotri_b(TCGContext *s, TCGReg d,
+                                                        TCGReg j, uint32_t uk3)
 {
     tcg_out32(s, encode_djuk3_insn(OPC_ROTRI_B, d, j, uk3));
 }
 
 /* Emits the `rotri.h d, j, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotri_h(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk4)
+static void __attribute__((unused)) tcg_out_opc_rotri_h(TCGContext *s, TCGReg d,
+                                                        TCGReg j, uint32_t uk4)
 {
     tcg_out32(s, encode_djuk4_insn(OPC_ROTRI_H, d, j, uk4));
 }
 
 /* Emits the `rotri.w d, j, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotri_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5)
+static void __attribute__((unused)) tcg_out_opc_rotri_w(TCGContext *s, TCGReg d,
+                                                        TCGReg j, uint32_t uk5)
 {
     tcg_out32(s, encode_djuk5_insn(OPC_ROTRI_W, d, j, uk5));
 }
 
 /* Emits the `rotri.d d, j, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_rotri_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6)
+static void __attribute__((unused)) tcg_out_opc_rotri_d(TCGContext *s, TCGReg d,
+                                                        TCGReg j, uint32_t uk6)
 {
     tcg_out32(s, encode_djuk6_insn(OPC_ROTRI_D, d, j, uk6));
 }
 
 /* Emits the `bstrins.w d, j, uk5, um5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bstrins_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5,
-                      uint32_t um5)
+static void __attribute__((unused)) tcg_out_opc_bstrins_w(TCGContext *s,
+                                                          TCGReg d, TCGReg j,
+                                                          uint32_t uk5,
+                                                          uint32_t um5)
 {
     tcg_out32(s, encode_djuk5um5_insn(OPC_BSTRINS_W, d, j, uk5, um5));
 }
 
 /* Emits the `bstrpick.w d, j, uk5, um5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bstrpick_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5,
-                       uint32_t um5)
+static void __attribute__((unused)) tcg_out_opc_bstrpick_w(TCGContext *s,
+                                                           TCGReg d, TCGReg j,
+                                                           uint32_t uk5,
+                                                           uint32_t um5)
 {
     tcg_out32(s, encode_djuk5um5_insn(OPC_BSTRPICK_W, d, j, uk5, um5));
 }
 
 /* Emits the `bstrins.d d, j, uk6, um6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bstrins_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6,
-                      uint32_t um6)
+static void __attribute__((unused)) tcg_out_opc_bstrins_d(TCGContext *s,
+                                                          TCGReg d, TCGReg j,
+                                                          uint32_t uk6,
+                                                          uint32_t um6)
 {
     tcg_out32(s, encode_djuk6um6_insn(OPC_BSTRINS_D, d, j, uk6, um6));
 }
 
 /* Emits the `bstrpick.d d, j, uk6, um6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bstrpick_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6,
-                       uint32_t um6)
+static void __attribute__((unused)) tcg_out_opc_bstrpick_d(TCGContext *s,
+                                                           TCGReg d, TCGReg j,
+                                                           uint32_t uk6,
+                                                           uint32_t um6)
 {
     tcg_out32(s, encode_djuk6um6_insn(OPC_BSTRPICK_D, d, j, uk6, um6));
 }
 
 /* Emits the `fmov.d fd, fj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fmov_d(TCGContext *s, TCGReg fd, TCGReg fj)
+static void __attribute__((unused)) tcg_out_opc_fmov_d(TCGContext *s, TCGReg fd,
+                                                       TCGReg fj)
 {
     tcg_out32(s, encode_fdfj_insn(OPC_FMOV_D, fd, fj));
 }
 
 /* Emits the `movgr2fr.d fd, j` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_movgr2fr_d(TCGContext *s, TCGReg fd, TCGReg j)
+static void __attribute__((unused)) tcg_out_opc_movgr2fr_d(TCGContext *s,
+                                                           TCGReg fd, TCGReg j)
 {
     tcg_out32(s, encode_fdj_insn(OPC_MOVGR2FR_D, fd, j));
 }
 
 /* Emits the `movfr2gr.d d, fj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_movfr2gr_d(TCGContext *s, TCGReg d, TCGReg fj)
+static void __attribute__((unused)) tcg_out_opc_movfr2gr_d(TCGContext *s,
+                                                           TCGReg d, TCGReg fj)
 {
     tcg_out32(s, encode_dfj_insn(OPC_MOVFR2GR_D, d, fj));
 }
 
 /* Emits the `slti d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_slti(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_slti(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_SLTI, d, j, sk12));
 }
 
 /* Emits the `sltui d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_sltui(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_sltui(TCGContext *s, TCGReg d,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_SLTUI, d, j, sk12));
 }
 
 /* Emits the `addi.w d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_addi_w(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_addi_w(TCGContext *s, TCGReg d,
+                                                       TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ADDI_W, d, j, sk12));
 }
 
 /* Emits the `addi.d d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_addi_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_addi_d(TCGContext *s, TCGReg d,
+                                                       TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ADDI_D, d, j, sk12));
 }
 
 /* Emits the `cu52i.d d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_cu52i_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_cu52i_d(TCGContext *s, TCGReg d,
+                                                        TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_CU52I_D, d, j, sk12));
 }
 
 /* Emits the `andi d, j, uk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_andi(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk12)
+static void __attribute__((unused)) tcg_out_opc_andi(TCGContext *s, TCGReg d,
+                                                     TCGReg j, uint32_t uk12)
 {
     tcg_out32(s, encode_djuk12_insn(OPC_ANDI, d, j, uk12));
 }
 
 /* Emits the `ori d, j, uk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ori(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk12)
+static void __attribute__((unused)) tcg_out_opc_ori(TCGContext *s, TCGReg d,
+                                                    TCGReg j, uint32_t uk12)
 {
     tcg_out32(s, encode_djuk12_insn(OPC_ORI, d, j, uk12));
 }
 
 /* Emits the `xori d, j, uk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xori(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk12)
+static void __attribute__((unused)) tcg_out_opc_xori(TCGContext *s, TCGReg d,
+                                                     TCGReg j, uint32_t uk12)
 {
     tcg_out32(s, encode_djuk12_insn(OPC_XORI, d, j, uk12));
 }
@@ -1845,9 +1883,9 @@ tcg_out_opc_vbitsel_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
 }
 
 /* Emits the `xvbitsel.v xd, xj, xk, xa` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvbitsel_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk,
-                       TCGReg xa)
+static void __attribute__((unused)) tcg_out_opc_xvbitsel_v(TCGContext *s,
+                                                           TCGReg xd, TCGReg xj,
+                                                           TCGReg xk, TCGReg xa)
 {
     tcg_out32(s, encode_xdxjxkxa_insn(OPC_XVBITSEL_V, xd, xj, xk, xa));
 }
@@ -1874,22 +1912,22 @@ tcg_out_opc_addu16i_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
 }
 
 /* Emits the `lu12i.w d, sj20` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_lu12i_w(TCGContext *s, TCGReg d, int32_t sj20)
+static void __attribute__((unused)) tcg_out_opc_lu12i_w(TCGContext *s, TCGReg d,
+                                                        int32_t sj20)
 {
     tcg_out32(s, encode_dsj20_insn(OPC_LU12I_W, d, sj20));
 }
 
 /* Emits the `cu32i.d d, sj20` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_cu32i_d(TCGContext *s, TCGReg d, int32_t sj20)
+static void __attribute__((unused)) tcg_out_opc_cu32i_d(TCGContext *s, TCGReg d,
+                                                        int32_t sj20)
 {
     tcg_out32(s, encode_dsj20_insn(OPC_CU32I_D, d, sj20));
 }
 
 /* Emits the `pcaddu2i d, sj20` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_pcaddu2i(TCGContext *s, TCGReg d, int32_t sj20)
+static void __attribute__((unused)) tcg_out_opc_pcaddu2i(TCGContext *s,
+                                                         TCGReg d, int32_t sj20)
 {
     tcg_out32(s, encode_dsj20_insn(OPC_PCADDU2I, d, sj20));
 }
@@ -1916,134 +1954,134 @@ tcg_out_opc_pcaddu18i(TCGContext *s, TCGReg d, int32_t sj20)
 }
 
 /* Emits the `ld.b d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_b(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_b(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_B, d, j, sk12));
 }
 
 /* Emits the `ld.h d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_h(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_h(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_H, d, j, sk12));
 }
 
 /* Emits the `ld.w d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_w(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_w(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_W, d, j, sk12));
 }
 
 /* Emits the `ld.d d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_d(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_D, d, j, sk12));
 }
 
 /* Emits the `st.b d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_st_b(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_st_b(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ST_B, d, j, sk12));
 }
 
 /* Emits the `st.h d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_st_h(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_st_h(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ST_H, d, j, sk12));
 }
 
 /* Emits the `st.w d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_st_w(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_st_w(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ST_W, d, j, sk12));
 }
 
 /* Emits the `st.d d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_st_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_st_d(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_ST_D, d, j, sk12));
 }
 
 /* Emits the `ld.bu d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_bu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_bu(TCGContext *s, TCGReg d,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_BU, d, j, sk12));
 }
 
 /* Emits the `ld.hu d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_hu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_hu(TCGContext *s, TCGReg d,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_HU, d, j, sk12));
 }
 
 /* Emits the `ld.wu d, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ld_wu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_ld_wu(TCGContext *s, TCGReg d,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_djsk12_insn(OPC_LD_WU, d, j, sk12));
 }
 
 /* Emits the `fld.s fd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fld_s(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_fld_s(TCGContext *s, TCGReg fd,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_fdjsk12_insn(OPC_FLD_S, fd, j, sk12));
 }
 
 /* Emits the `fst.s fd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fst_s(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_fst_s(TCGContext *s, TCGReg fd,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_fdjsk12_insn(OPC_FST_S, fd, j, sk12));
 }
 
 /* Emits the `fld.d fd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fld_d(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_fld_d(TCGContext *s, TCGReg fd,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_fdjsk12_insn(OPC_FLD_D, fd, j, sk12));
 }
 
 /* Emits the `fst.d fd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fst_d(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_fst_d(TCGContext *s, TCGReg fd,
+                                                      TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_fdjsk12_insn(OPC_FST_D, fd, j, sk12));
 }
 
 /* Emits the `vld vd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vld(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_vld(TCGContext *s, TCGReg vd,
+                                                    TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_vdjsk12_insn(OPC_VLD, vd, j, sk12));
 }
 
 /* Emits the `vst vd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vst(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_vst(TCGContext *s, TCGReg vd,
+                                                    TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_vdjsk12_insn(OPC_VST, vd, j, sk12));
 }
 
 /* Emits the `xvld xd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvld(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_xvld(TCGContext *s, TCGReg xd,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_xdjsk12_insn(OPC_XVLD, xd, j, sk12));
 }
 
 /* Emits the `xvst xd, j, sk12` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvst(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
+static void __attribute__((unused)) tcg_out_opc_xvst(TCGContext *s, TCGReg xd,
+                                                     TCGReg j, int32_t sk12)
 {
     tcg_out32(s, encode_xdjsk12_insn(OPC_XVST, xd, j, sk12));
 }
@@ -2077,33 +2115,37 @@ tcg_out_opc_vldrepl_b(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk12)
 }
 
 /* Emits the `vstelm.d vd, j, sk8, un1` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vstelm_d(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk8,
-                     uint32_t un1)
+static void __attribute__((unused)) tcg_out_opc_vstelm_d(TCGContext *s,
+                                                         TCGReg vd, TCGReg j,
+                                                         int32_t sk8,
+                                                         uint32_t un1)
 {
     tcg_out32(s, encode_vdjsk8un1_insn(OPC_VSTELM_D, vd, j, sk8, un1));
 }
 
 /* Emits the `vstelm.w vd, j, sk8, un2` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vstelm_w(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk8,
-                     uint32_t un2)
+static void __attribute__((unused)) tcg_out_opc_vstelm_w(TCGContext *s,
+                                                         TCGReg vd, TCGReg j,
+                                                         int32_t sk8,
+                                                         uint32_t un2)
 {
     tcg_out32(s, encode_vdjsk8un2_insn(OPC_VSTELM_W, vd, j, sk8, un2));
 }
 
 /* Emits the `vstelm.h vd, j, sk8, un3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vstelm_h(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk8,
-                     uint32_t un3)
+static void __attribute__((unused)) tcg_out_opc_vstelm_h(TCGContext *s,
+                                                         TCGReg vd, TCGReg j,
+                                                         int32_t sk8,
+                                                         uint32_t un3)
 {
     tcg_out32(s, encode_vdjsk8un3_insn(OPC_VSTELM_H, vd, j, sk8, un3));
 }
 
 /* Emits the `vstelm.b vd, j, sk8, un4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vstelm_b(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk8,
-                     uint32_t un4)
+static void __attribute__((unused)) tcg_out_opc_vstelm_b(TCGContext *s,
+                                                         TCGReg vd, TCGReg j,
+                                                         int32_t sk8,
+                                                         uint32_t un4)
 {
     tcg_out32(s, encode_vdjsk8un4_insn(OPC_VSTELM_B, vd, j, sk8, un4));
 }
@@ -2137,306 +2179,310 @@ tcg_out_opc_xvldrepl_b(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
 }
 
 /* Emits the `xvstelm.d xd, j, sk8, un2` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvstelm_d(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
-                      uint32_t un2)
+static void __attribute__((unused)) tcg_out_opc_xvstelm_d(TCGContext *s,
+                                                          TCGReg xd, TCGReg j,
+                                                          int32_t sk8,
+                                                          uint32_t un2)
 {
     tcg_out32(s, encode_xdjsk8un2_insn(OPC_XVSTELM_D, xd, j, sk8, un2));
 }
 
 /* Emits the `xvstelm.w xd, j, sk8, un3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvstelm_w(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
-                      uint32_t un3)
+static void __attribute__((unused)) tcg_out_opc_xvstelm_w(TCGContext *s,
+                                                          TCGReg xd, TCGReg j,
+                                                          int32_t sk8,
+                                                          uint32_t un3)
 {
     tcg_out32(s, encode_xdjsk8un3_insn(OPC_XVSTELM_W, xd, j, sk8, un3));
 }
 
 /* Emits the `xvstelm.h xd, j, sk8, un4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvstelm_h(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
-                      uint32_t un4)
+static void __attribute__((unused)) tcg_out_opc_xvstelm_h(TCGContext *s,
+                                                          TCGReg xd, TCGReg j,
+                                                          int32_t sk8,
+                                                          uint32_t un4)
 {
     tcg_out32(s, encode_xdjsk8un4_insn(OPC_XVSTELM_H, xd, j, sk8, un4));
 }
 
 /* Emits the `xvstelm.b xd, j, sk8, un5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvstelm_b(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
-                      uint32_t un5)
+static void __attribute__((unused)) tcg_out_opc_xvstelm_b(TCGContext *s,
+                                                          TCGReg xd, TCGReg j,
+                                                          int32_t sk8,
+                                                          uint32_t un5)
 {
     tcg_out32(s, encode_xdjsk8un5_insn(OPC_XVSTELM_B, xd, j, sk8, un5));
 }
 
 /* Emits the `ldx.b d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_b(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_b(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_B, d, j, k));
 }
 
 /* Emits the `ldx.h d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_h(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_h(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_H, d, j, k));
 }
 
 /* Emits the `ldx.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_W, d, j, k));
 }
 
 /* Emits the `ldx.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_D, d, j, k));
 }
 
 /* Emits the `stx.b d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_stx_b(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_stx_b(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_STX_B, d, j, k));
 }
 
 /* Emits the `stx.h d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_stx_h(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_stx_h(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_STX_H, d, j, k));
 }
 
 /* Emits the `stx.w d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_stx_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_stx_w(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_STX_W, d, j, k));
 }
 
 /* Emits the `stx.d d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_stx_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_stx_d(TCGContext *s, TCGReg d,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_STX_D, d, j, k));
 }
 
 /* Emits the `ldx.bu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_bu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_bu(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_BU, d, j, k));
 }
 
 /* Emits the `ldx.hu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_hu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_hu(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_HU, d, j, k));
 }
 
 /* Emits the `ldx.wu d, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ldx_wu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_ldx_wu(TCGContext *s, TCGReg d,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_djk_insn(OPC_LDX_WU, d, j, k));
 }
 
 /* Emits the `fldx.s fd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fldx_s(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_fldx_s(TCGContext *s, TCGReg fd,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_fdjk_insn(OPC_FLDX_S, fd, j, k));
 }
 
 /* Emits the `fldx.d fd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fldx_d(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_fldx_d(TCGContext *s, TCGReg fd,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_fdjk_insn(OPC_FLDX_D, fd, j, k));
 }
 
 /* Emits the `fstx.s fd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fstx_s(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_fstx_s(TCGContext *s, TCGReg fd,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_fdjk_insn(OPC_FSTX_S, fd, j, k));
 }
 
 /* Emits the `fstx.d fd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_fstx_d(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_fstx_d(TCGContext *s, TCGReg fd,
+                                                       TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_fdjk_insn(OPC_FSTX_D, fd, j, k));
 }
 
 /* Emits the `vldx vd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vldx(TCGContext *s, TCGReg vd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_vldx(TCGContext *s, TCGReg vd,
+                                                     TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_vdjk_insn(OPC_VLDX, vd, j, k));
 }
 
 /* Emits the `vstx vd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vstx(TCGContext *s, TCGReg vd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_vstx(TCGContext *s, TCGReg vd,
+                                                     TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_vdjk_insn(OPC_VSTX, vd, j, k));
 }
 
 /* Emits the `xvldx xd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvldx(TCGContext *s, TCGReg xd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_xvldx(TCGContext *s, TCGReg xd,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_xdjk_insn(OPC_XVLDX, xd, j, k));
 }
 
 /* Emits the `xvstx xd, j, k` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvstx(TCGContext *s, TCGReg xd, TCGReg j, TCGReg k)
+static void __attribute__((unused)) tcg_out_opc_xvstx(TCGContext *s, TCGReg xd,
+                                                      TCGReg j, TCGReg k)
 {
     tcg_out32(s, encode_xdjk_insn(OPC_XVSTX, xd, j, k));
 }
 
 /* Emits the `dbar ud15` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_dbar(TCGContext *s, uint32_t ud15)
+static void __attribute__((unused)) tcg_out_opc_dbar(TCGContext *s,
+                                                     uint32_t ud15)
 {
     tcg_out32(s, encode_ud15_insn(OPC_DBAR, ud15));
 }
 
 /* Emits the `jiscr0 sd5k16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_jiscr0(TCGContext *s, int32_t sd5k16)
+static void __attribute__((unused)) tcg_out_opc_jiscr0(TCGContext *s,
+                                                       int32_t sd5k16)
 {
     tcg_out32(s, encode_sd5k16_insn(OPC_JISCR0, sd5k16));
 }
 
 /* Emits the `jiscr1 sd5k16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_jiscr1(TCGContext *s, int32_t sd5k16)
+static void __attribute__((unused)) tcg_out_opc_jiscr1(TCGContext *s,
+                                                       int32_t sd5k16)
 {
     tcg_out32(s, encode_sd5k16_insn(OPC_JISCR1, sd5k16));
 }
 
 /* Emits the `jirl d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_jirl(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_jirl(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_JIRL, d, j, sk16));
 }
 
 /* Emits the `b sd10k16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_b(TCGContext *s, int32_t sd10k16)
+static void __attribute__((unused)) tcg_out_opc_b(TCGContext *s,
+                                                  int32_t sd10k16)
 {
     tcg_out32(s, encode_sd10k16_insn(OPC_B, sd10k16));
 }
 
 /* Emits the `bl sd10k16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bl(TCGContext *s, int32_t sd10k16)
+static void __attribute__((unused)) tcg_out_opc_bl(TCGContext *s,
+                                                   int32_t sd10k16)
 {
     tcg_out32(s, encode_sd10k16_insn(OPC_BL, sd10k16));
 }
 
 /* Emits the `beq d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_beq(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_beq(TCGContext *s, TCGReg d,
+                                                    TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BEQ, d, j, sk16));
 }
 
 /* Emits the `bne d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bne(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_bne(TCGContext *s, TCGReg d,
+                                                    TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BNE, d, j, sk16));
 }
 
 /* Emits the `bgt d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bgt(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_bgt(TCGContext *s, TCGReg d,
+                                                    TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BGT, d, j, sk16));
 }
 
 /* Emits the `ble d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_ble(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_ble(TCGContext *s, TCGReg d,
+                                                    TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BLE, d, j, sk16));
 }
 
 /* Emits the `bgtu d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bgtu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_bgtu(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BGTU, d, j, sk16));
 }
 
 /* Emits the `bleu d, j, sk16` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_bleu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
+static void __attribute__((unused)) tcg_out_opc_bleu(TCGContext *s, TCGReg d,
+                                                     TCGReg j, int32_t sk16)
 {
     tcg_out32(s, encode_djsk16_insn(OPC_BLEU, d, j, sk16));
 }
 
 /* Emits the `vseq.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vseq_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vseq_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSEQ_B, vd, vj, vk));
 }
 
 /* Emits the `vseq.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vseq_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vseq_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSEQ_H, vd, vj, vk));
 }
 
 /* Emits the `vseq.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vseq_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vseq_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSEQ_W, vd, vj, vk));
 }
 
 /* Emits the `vseq.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vseq_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vseq_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSEQ_D, vd, vj, vk));
 }
 
 /* Emits the `vsle.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsle_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsle_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLE_B, vd, vj, vk));
 }
 
 /* Emits the `vsle.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsle_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsle_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLE_H, vd, vj, vk));
 }
 
 /* Emits the `vsle.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsle_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsle_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLE_W, vd, vj, vk));
 }
 
 /* Emits the `vsle.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsle_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsle_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLE_D, vd, vj, vk));
 }
@@ -2470,29 +2516,29 @@ tcg_out_opc_vsle_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
 }
 
 /* Emits the `vslt.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vslt_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vslt_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLT_B, vd, vj, vk));
 }
 
 /* Emits the `vslt.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vslt_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vslt_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLT_H, vd, vj, vk));
 }
 
 /* Emits the `vslt.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vslt_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vslt_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLT_W, vd, vj, vk));
 }
 
 /* Emits the `vslt.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vslt_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vslt_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLT_D, vd, vj, vk));
 }
@@ -2526,57 +2572,57 @@ tcg_out_opc_vslt_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
 }
 
 /* Emits the `vadd.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadd_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vadd_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VADD_B, vd, vj, vk));
 }
 
 /* Emits the `vadd.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadd_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vadd_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VADD_H, vd, vj, vk));
 }
 
 /* Emits the `vadd.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadd_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vadd_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VADD_W, vd, vj, vk));
 }
 
 /* Emits the `vadd.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vadd_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VADD_D, vd, vj, vk));
 }
 
 /* Emits the `vsub.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsub_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsub_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_B, vd, vj, vk));
 }
 
 /* Emits the `vsub.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsub_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsub_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_H, vd, vj, vk));
 }
 
 /* Emits the `vsub.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsub_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsub_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_W, vd, vj, vk));
 }
 
 /* Emits the `vsub.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsub_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_D, vd, vj, vk));
 }
@@ -2694,57 +2740,57 @@ tcg_out_opc_vssub_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
 }
 
 /* Emits the `vmax.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmax_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmax_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMAX_B, vd, vj, vk));
 }
 
 /* Emits the `vmax.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmax_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmax_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMAX_H, vd, vj, vk));
 }
 
 /* Emits the `vmax.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmax_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmax_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMAX_W, vd, vj, vk));
 }
 
 /* Emits the `vmax.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmax_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmax_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMAX_D, vd, vj, vk));
 }
 
 /* Emits the `vmin.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmin_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmin_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMIN_B, vd, vj, vk));
 }
 
 /* Emits the `vmin.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmin_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmin_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMIN_H, vd, vj, vk));
 }
 
 /* Emits the `vmin.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmin_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmin_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMIN_W, vd, vj, vk));
 }
 
 /* Emits the `vmin.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmin_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmin_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMIN_D, vd, vj, vk));
 }
@@ -2806,113 +2852,113 @@ tcg_out_opc_vmin_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
 }
 
 /* Emits the `vmul.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmul_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmul_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMUL_B, vd, vj, vk));
 }
 
 /* Emits the `vmul.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmul_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmul_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMUL_H, vd, vj, vk));
 }
 
 /* Emits the `vmul.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmul_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmul_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMUL_W, vd, vj, vk));
 }
 
 /* Emits the `vmul.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmul_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vmul_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMUL_D, vd, vj, vk));
 }
 
 /* Emits the `vsll.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsll_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsll_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLL_B, vd, vj, vk));
 }
 
 /* Emits the `vsll.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsll_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsll_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLL_H, vd, vj, vk));
 }
 
 /* Emits the `vsll.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsll_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsll_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLL_W, vd, vj, vk));
 }
 
 /* Emits the `vsll.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsll_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsll_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSLL_D, vd, vj, vk));
 }
 
 /* Emits the `vsrl.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrl_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsrl_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRL_B, vd, vj, vk));
 }
 
 /* Emits the `vsrl.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrl_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsrl_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRL_H, vd, vj, vk));
 }
 
 /* Emits the `vsrl.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrl_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsrl_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRL_W, vd, vj, vk));
 }
 
 /* Emits the `vsrl.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrl_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsrl_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRL_D, vd, vj, vk));
 }
 
 /* Emits the `vsra.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsra_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsra_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRA_B, vd, vj, vk));
 }
 
 /* Emits the `vsra.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsra_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsra_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRA_H, vd, vj, vk));
 }
 
 /* Emits the `vsra.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsra_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsra_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRA_W, vd, vj, vk));
 }
 
 /* Emits the `vsra.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsra_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vsra_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSRA_D, vd, vj, vk));
 }
@@ -2974,29 +3020,29 @@ tcg_out_opc_vreplve_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg k)
 }
 
 /* Emits the `vand.v vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vand_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vand_v(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VAND_V, vd, vj, vk));
 }
 
 /* Emits the `vor.v vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vor_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vor_v(TCGContext *s, TCGReg vd,
+                                                      TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VOR_V, vd, vj, vk));
 }
 
 /* Emits the `vxor.v vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vxor_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vxor_v(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VXOR_V, vd, vj, vk));
 }
 
 /* Emits the `vnor.v vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vnor_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vnor_v(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VNOR_V, vd, vj, vk));
 }
@@ -3009,8 +3055,8 @@ tcg_out_opc_vandn_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
 }
 
 /* Emits the `vorn.v vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vorn_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
+static void __attribute__((unused)) tcg_out_opc_vorn_v(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, TCGReg vk)
 {
     tcg_out32(s, encode_vdvjvk_insn(OPC_VORN_V, vd, vj, vk));
 }
@@ -3324,29 +3370,29 @@ tcg_out_opc_vmini_du(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
 }
 
 /* Emits the `vneg.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vneg_b(TCGContext *s, TCGReg vd, TCGReg vj)
+static void __attribute__((unused)) tcg_out_opc_vneg_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj)
 {
     tcg_out32(s, encode_vdvj_insn(OPC_VNEG_B, vd, vj));
 }
 
 /* Emits the `vneg.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vneg_h(TCGContext *s, TCGReg vd, TCGReg vj)
+static void __attribute__((unused)) tcg_out_opc_vneg_h(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj)
 {
     tcg_out32(s, encode_vdvj_insn(OPC_VNEG_H, vd, vj));
 }
 
 /* Emits the `vneg.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vneg_w(TCGContext *s, TCGReg vd, TCGReg vj)
+static void __attribute__((unused)) tcg_out_opc_vneg_w(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj)
 {
     tcg_out32(s, encode_vdvj_insn(OPC_VNEG_W, vd, vj));
 }
 
 /* Emits the `vneg.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vneg_d(TCGContext *s, TCGReg vd, TCGReg vj)
+static void __attribute__((unused)) tcg_out_opc_vneg_d(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj)
 {
     tcg_out32(s, encode_vdvj_insn(OPC_VNEG_D, vd, vj));
 }
@@ -3702,8 +3748,8 @@ tcg_out_opc_vandi_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
 }
 
 /* Emits the `vori.b vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vori_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
+static void __attribute__((unused)) tcg_out_opc_vori_b(TCGContext *s, TCGReg vd,
+                                                       TCGReg vj, uint32_t uk8)
 {
     tcg_out32(s, encode_vdvjuk8_insn(OPC_VORI_B, vd, vj, uk8));
 }
@@ -3723,8 +3769,8 @@ tcg_out_opc_vnori_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
 }
 
 /* Emits the `vldi vd, sj13` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vldi(TCGContext *s, TCGReg vd, int32_t sj13)
+static void __attribute__((unused)) tcg_out_opc_vldi(TCGContext *s, TCGReg vd,
+                                                     int32_t sj13)
 {
     tcg_out32(s, encode_vdsj13_insn(OPC_VLDI, vd, sj13));
 }
@@ -4325,8 +4371,8 @@ tcg_out_opc_xvand_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
 }
 
 /* Emits the `xvor.v xd, xj, xk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvor_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+static void __attribute__((unused)) tcg_out_opc_xvor_v(TCGContext *s, TCGReg xd,
+                                                       TCGReg xj, TCGReg xk)
 {
     tcg_out32(s, encode_xdxjxk_insn(OPC_XVOR_V, xd, xj, xk));
 }
@@ -4668,29 +4714,29 @@ tcg_out_opc_xvmini_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
 }
 
 /* Emits the `xvneg.b xd, xj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvneg_b(TCGContext *s, TCGReg xd, TCGReg xj)
+static void __attribute__((unused)) tcg_out_opc_xvneg_b(TCGContext *s,
+                                                        TCGReg xd, TCGReg xj)
 {
     tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_B, xd, xj));
 }
 
 /* Emits the `xvneg.h xd, xj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvneg_h(TCGContext *s, TCGReg xd, TCGReg xj)
+static void __attribute__((unused)) tcg_out_opc_xvneg_h(TCGContext *s,
+                                                        TCGReg xd, TCGReg xj)
 {
     tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_H, xd, xj));
 }
 
 /* Emits the `xvneg.w xd, xj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvneg_w(TCGContext *s, TCGReg xd, TCGReg xj)
+static void __attribute__((unused)) tcg_out_opc_xvneg_w(TCGContext *s,
+                                                        TCGReg xd, TCGReg xj)
 {
     tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_W, xd, xj));
 }
 
 /* Emits the `xvneg.d xd, xj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvneg_d(TCGContext *s, TCGReg xd, TCGReg xj)
+static void __attribute__((unused)) tcg_out_opc_xvneg_d(TCGContext *s,
+                                                        TCGReg xd, TCGReg xj)
 {
     tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_D, xd, xj));
 }
@@ -5060,8 +5106,8 @@ tcg_out_opc_xvnori_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
 }
 
 /* Emits the `xvldi xd, sj13` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_xvldi(TCGContext *s, TCGReg xd, int32_t sj13)
+static void __attribute__((unused)) tcg_out_opc_xvldi(TCGContext *s, TCGReg xd,
+                                                      int32_t sj13)
 {
     tcg_out32(s, encode_xdsj13_insn(OPC_XVLDI, xd, sj13));
 }
-- 
2.43.0


