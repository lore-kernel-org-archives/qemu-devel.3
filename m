Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82157C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJU-00010u-P5; Wed, 16 Sep 2026 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJM-00010E-SX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:30 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJL-0000Hc-7I
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:28 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d440939f0so6995947b3.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563866; x=1790168666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mi9YGCK/K8L2XG8JyWU5uLRVdpLLn+xOvd+M5yNzz/8=;
 b=XzR8HxH3PSiiULOX8/LHnikiRNpi/o6+Z8P7wM1qtOfqLdwgPfiQwdEaBK6tuyQNWc
 IYFxXS/yNemCzFn6TeEs2MsemP6VJZBjmyd0nlKt8wNhnMPD61p/dxnUghTbHPGAD0Fp
 L8pzhxJV73piIXi6VDRITBK9FzBJUlo7N6UoSgVJ5A41m9yeGc7VlhC0vjtRd8qBDcSP
 TrlQHXtq8MgtiSrQxr3N1C9osZTBqlRzr4ArkjgsmX1C5MbfrNSSMUmUght4hiX1G8uh
 oRB4zkoJZO/dHqbzLQQ9yJ9a1vYzbOqXRGwSm//h7tC2YYKP0q6Q+HdV7f4jrmJapRzc
 w2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563866; x=1790168666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mi9YGCK/K8L2XG8JyWU5uLRVdpLLn+xOvd+M5yNzz/8=;
 b=WnG46xJc9UhwvVG3u0pPq2WtAam4XTuPuVfgSa+7boOIFxJZLrtUYzIxU4tqxw2gbA
 hvMjwm9i0XhtbwEtHlbjKHFY5rJzDx0K/erXnRkxOZ9UP6jUJlS3pWHfHSaFG+ECDgtv
 KfsPg7q975LLZyiTk2o5h2uGwiagUTXvRh85DRyr05x3B37BVedVqkFs7vo4MPAkba0l
 Wdh4NlUY9RmMxPj4LJUCtivXpCySgFVLv+CNMWHZus4HQgqyrAb+2tVjKhyRuKPBMUjd
 ed9WazT0QyTOricS0SuAUgC1C3ABkQQSOMnbOi+7APYCRizbRZytvWlYK5zwzUZs+71O
 B3iw==
X-Gm-Message-State: AFuF++n3gG3ljVmgo+cTlllhIkDlPrdc14oslmPQwdTbse9JIvydDDkI
 ionHdm4feSI/ST412+qjJofVeogxrUMRWiy2uoJjvYxbXziuHujGoYcTCJY6gmeuC33F6movLhx
 ublPuPFA=
X-Gm-Gg: AYBFou3KloAV1X5mhusr8E7hRuhENFinSIJno/sOh/B0xiuVOpC6y5ou8uUP2lBi4wc
 3BHqN9hS0/iTyIOA55y9AY7bfmfV3Ak8wu/p0TUatmetTAbTj1nGDH35twHwWXreslCynL2OIuB
 Zy8uomv7K8nrPXV3JQjChLU8BOXCoQCXanP3HHCAP1HMHp2I7svM5VGfv16u0QMiqKeiurIA6eR
 B3B5kmywPPehgA4UifGDcI2IHJ1BFlXYQjgOzBf9h4fKVlLvdySs5GyDfaFxlWf5uI35KHYX+G4
 jvXpr+rpaL4k6BEnKj2lWZBleWseOk/SzqbMP5eO08r9i7NNTfC+2MyfqhlQQwPDteDKYcGS9Xs
 sXfVLnviQHYEc7s1VSSDTBf6jNQI9yzdoTCJ9XU+Y1Ri0NOT7e7fzNPDmCM0oYJgT6i1KqRiXhz
 2qnJeYSM0XKSDiZ72+zjTEMhnyZcvtNTGgYeuz1v2GZFms+eEGC36kSoy43WAmKOB3LmS3VUfF6
 eNlgMs=
X-Received: by 2002:a05:690c:6e84:b0:881:ea14:415 with SMTP id
 00721157ae682-892245bbb47mr6844537b3.35.1789563865730; 
 Wed, 16 Sep 2026 06:04:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/92] tcg: Generic expansion of tcg_gen_movi_*
Date: Wed, 16 Sep 2026 03:02:42 -1000
Message-ID: <20260916130409.3382710-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 69331928bd5..f54b3618e8d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -117,7 +117,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -224,7 +223,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ebfaf0b8188..5de7648ed48 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,3 +1,4 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6fc75b9286e..3b3bd5cdfa1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -392,6 +392,11 @@ static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -399,11 +404,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1466,11 +1466,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


