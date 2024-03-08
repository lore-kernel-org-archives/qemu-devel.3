Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB898C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAZ-0001Lz-6R; Fri, 08 Mar 2024 06:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAX-00014f-QU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAV-0001kf-IT
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:41 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd6412da28so7890825ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896418; x=1710501218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAWta+Jzv7NiikMtjRiNI+4OqxTM1Bzzl8PeXTNimdg=;
 b=EOXcwqDrYhkdEujQ+lOdrHpDt1nzrre09S1+uEwoDLEx0yfkLJ3UlSi1GbdMdrbrJZ
 Fgru1cRhz2k7E1XiQm/P6GQKJaHRigIu4H/jj5/fUEw+YFw1KGX9PY/IqZxlp1sWLLRn
 1d8O7xJHNP5oONEPsBoPdPJC2c5dJH1lDOjXOF+O1O0gZWQuWlewsQMD3cWAidi6ZDzb
 XbdD/NszODRqScXUq/OPjmlFqZ4wATIpI6QOAcW0d/gW0Jhu1uxmrTzSfCq3zQRdyKYv
 VsbJ1yJBnFejVzZP7AERFlIg0l7Z5X2yUCz4ckFRchHX7PaHCUcUujVKhuQZcNJSbOyp
 UWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896418; x=1710501218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAWta+Jzv7NiikMtjRiNI+4OqxTM1Bzzl8PeXTNimdg=;
 b=a6J0Bv6pC8V8Kbrnv2JodpPcn1+lTCcfLAEzixiaVvhLFMlZRUlb/IhognEt+PIpXT
 LtOO4slOYiTlkVZjjTFaeyiCwmrIJKRtDByj+kqDTiiBaGmmIXvABvjd79L+WHMPoeY5
 oGQxnE9hfqQbP/rdRNtaTqu2nGoFHUNpqJOKB4sWOvENPRkwwbrjDuyRdzXffRmB0WSY
 v8mLq24JtMLgHH6N/WVnSvm9yJtxnXjQEJESWIjzrid7uIWtHPLjUVjkFwtwYxrhGhq8
 /YAf97bGQHS0ZtUe+5fBrV97bjpj6ZQi+M1kjqWXXr7B4NBvU56J332n2WOCbGJ2HzM+
 6aAg==
X-Gm-Message-State: AOJu0YzNHNMbTmQmX2ihzla154bE7aYFUNd5Xbr+50LIBCTLzhq7tjhP
 1nOXc6//j4TeCVFkDkLksVnM/ts1l1Wpzj402abrd4qQXmCBVDXGrv7FvRuPsuYsWg==
X-Google-Smtp-Source: AGHT+IFOoSK6fPCg/wxhxK5gLfReRPBXhFvxnFOb4zyu2eQt9WDLySZcScXqpYrTgzQDkAG1aeoQ0g==
X-Received: by 2002:a17:903:1112:b0:1dd:607e:852c with SMTP id
 n18-20020a170903111200b001dd607e852cmr3618459plh.27.1709896417789; 
 Fri, 08 Mar 2024 03:13:37 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/34] trans_rvv.c.inc: remove 'is_store' bool from load/store
 fns
Date: Fri,  8 Mar 2024 21:11:47 +1000
Message-ID: <20240308111152.2856137-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

After the 'mark_vs_dirty' changes from the previous patch the 'is_store'
bool is unused in some load/store functions that were changed. Remove it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240306171932.549549-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 58 ++++++++++++-------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b838b8ea5b..e42728990e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -796,7 +796,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
                               uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s, bool is_store)
+                              DisasContext *s)
 {
     TCGv_ptr dest, mask;
     TCGv base, stride;
@@ -843,7 +843,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -877,7 +877,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
         return false;
     }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -900,7 +900,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     TCGv_ptr dest, mask, index;
     TCGv base;
@@ -967,7 +967,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1019,7 +1019,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1098,7 +1098,7 @@ typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     uint32_t evl = s->cfg_ptr->vlenb * nf / width;
     TCGLabel *over = gen_new_label();
@@ -1129,42 +1129,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH, IS_STORE)               \
+#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
 static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
 {                                                                         \
     if (require_rvv(s) &&                                                 \
         QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
         return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,             \
-                                gen_helper_##NAME, s, IS_STORE);          \
+                                gen_helper_##NAME, s);                    \
     }                                                                     \
     return false;                                                         \
 }
 
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1, false)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2, false)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4, false)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8, false)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1, false)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2, false)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4, false)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8, false)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1, false)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2, false)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4, false)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8, false)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1, false)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2, false)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4, false)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8, false)
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1, true)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1, true)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1, true)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
+GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
+GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
+GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
+GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.44.0


