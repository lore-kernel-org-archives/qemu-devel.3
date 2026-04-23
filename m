Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7FF99362
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFr9N-0007Cc-6R; Thu, 23 Apr 2026 06:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFr9K-0007CG-P9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:19:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFr9J-0000Kb-09
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:19:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so80093035e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776939547; x=1777544347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NqZwIhNcYPFJ01x/Xep8E5pGxu2NM8phfGxkRyM4Nm0=;
 b=zOCmj2YZmAdflU8obAOy6wHEB0oS9PsFXADj6SeJeOimbOGc1dcQd8nqqle5mD9+XS
 Plg2LHaHdJdB/XQES9ACUsG+yvTNi4F444BpeLVx2CN2uj84hmOgVHkM/KZbYHNZRFoQ
 hdJRWASShSJ/JNSH7R0b/6180HwA3lECVBBM0HgZRwTkzpzadqpAGqDxRz5SbCdiJWor
 /Op0qGcWU7tOlWkaLzdjq7j2w6qoZhKovFUUmPbbTw+n2PQBVPGPU0W0Wk/iGzg9JJyY
 plzHsKlsfPyWWUqA8wFbZsS/DGTiGR/MvBAqy/hGdlwimiCWVC847JmCakeebp9jyMnZ
 RxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776939547; x=1777544347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqZwIhNcYPFJ01x/Xep8E5pGxu2NM8phfGxkRyM4Nm0=;
 b=Y0MLtBpIUPlXKCNdNOZtI0LrEwTMaR2Goh5hDhbU+ook1Wrli3bL+fyDuizqg9S3IZ
 /DgfKEPaIkVOMbkCVsnII5HtjjKTR9/wzt3xQEqoJncxZ3oPpZ2dxVKBSWFT98T9BuXJ
 Pq1+tM7FS3Dq9HXBvNmT0BgVpL7Jdl5g7/oxEIx3W/hhh6Uf/dw+J9TmKcoYnURW6P+T
 Y9Ugw1dXiHsfE9UGJYFh0JgH8gSaiyy6Cj0j3Utws4qBigWO7OWRan6o/rGXD0DtHuFq
 gMk04MljdGBYj1MEqvq/jf9rL/77yhzXB2ESNn/7HxAswDPLddQRkRA4C/TewET/Oud4
 7pjw==
X-Gm-Message-State: AOJu0YxceFrIBDZah8ZkTghj6oJzVqZcrGOfG73sCl9LICxR5PyfuRGm
 eHIsgiJutoXrQd9ytiNKearcSx2yq6NAJtqtX48nTbgVCMkq1BrvD4PawYsI46mr4bH449k8cHG
 TP7rqg/o=
X-Gm-Gg: AeBDietZqq/62MmVNl+Luj5iio1XXkpSFIMFO0FEBwF76U0iEGhI/3ONovdz3eWClV1
 wOc2hjxYHrPr0tAzWiR4X+9yFf7PkUXCB7M7KuDDw5fW4v6aP2czapFcUDjjpOAi1TjNvo/+Ngi
 cbTL/HeISz2MDVgJJ1JT/iJRLcbczT7bbvuBsdvj6UnGYysZ8S9dignE9ENIGnmz7tTI3LXKT+F
 dQzDYmJLRplFPjMOGKSNtXW/uf5r1keudWyYZlZMdXED/q0jMRB/ys3AL+U9sar6HTzSfSRKQCz
 Z8r30zujVoMKOSl+toZfhCD8HHDmfO+lqkuUSQT3JRdWgvql2PA0Kot0+qZrAKapb9XA5O/7R/R
 mHjuHABT1gDA7Tj8d1DQIYMmAoazeyuBlysJzPipi2qnIGPBd962bvBPD/5MDnapz3srmbLJ3IU
 mFl1yrwOSEVmR5kNt5WoZbPfwUq8v+OixWWcdhEfc9CmAsJJjdISA9p2UyH66eL6w8XPSfVT2HE
 jMQ7w3rWQc=
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id
 5b1f17b1804b1-4896c28dd4emr218183075e9.31.1776939546945; 
 Thu, 23 Apr 2026 03:19:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891b46cffasm332925055e9.13.2026.04.23.03.19.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:19:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH] tcg: Remove unused tcg_gen_vec_*_tl() API
Date: Thu, 23 Apr 2026 12:19:04 +0200
Message-ID: <20260423101904.36131-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

No code uses the tcg_gen_vec_*_tl() API. Better to
remove it now, since to compile as translation unit
files once we need to avoid target_ulong uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Now this file only defines tcg_gen_gvec_dup_tl(), which
is used only once in target/riscv/insn_trans/trans_rvv.c.inc:

2156 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
2157 {
2158     if (require_rvv(s) &&
2159         vext_check_isa_ill(s) &&
2160         /* vmv.v.x has rs2 = 0 and vm = 1 */
2161         vext_check_ss(s, a->rd, 0, 1)) {
2162         TCGv s1;
2163
2164         s1 = get_gpr(s, a->rs1, EXT_SIGN);
2165
2166         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
2167             if (get_xl(s) == MXL_RV32 && s->sew == MO_64) {
2168                 TCGv_i64 s1_i64 = tcg_temp_new_i64();
2169                 tcg_gen_ext_tl_i64(s1_i64, s1);
2170                 tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
2171                                      MAXSZ(s), MAXSZ(s), s1_i64);
2172             } else {
2173                 tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
                     ^^^^^^^^^^^^^^^^^^^
2174                                     MAXSZ(s), MAXSZ(s), s1);
2175             }
2176         } else {

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-riscv@nongnu.org
---
 include/tcg/tcg-op-gvec.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index b0a81ad4bf4..d82ba6dfaac 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -16,32 +16,8 @@
 
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
-#define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
-#define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
-#define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i64
-#define tcg_gen_vec_sub16_tl tcg_gen_vec_sub16_i64
-#define tcg_gen_vec_add32_tl tcg_gen_vec_add32_i64
-#define tcg_gen_vec_sub32_tl tcg_gen_vec_sub32_i64
-#define tcg_gen_vec_shl8i_tl tcg_gen_vec_shl8i_i64
-#define tcg_gen_vec_shr8i_tl tcg_gen_vec_shr8i_i64
-#define tcg_gen_vec_sar8i_tl tcg_gen_vec_sar8i_i64
-#define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
-#define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
-#define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
 #elif TARGET_LONG_BITS == 32
 #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
-#define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
-#define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
-#define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i32
-#define tcg_gen_vec_sub16_tl tcg_gen_vec_sub16_i32
-#define tcg_gen_vec_add32_tl tcg_gen_add_i32
-#define tcg_gen_vec_sub32_tl tcg_gen_sub_i32
-#define tcg_gen_vec_shl8i_tl tcg_gen_vec_shl8i_i32
-#define tcg_gen_vec_shr8i_tl tcg_gen_vec_shr8i_i32
-#define tcg_gen_vec_sar8i_tl tcg_gen_vec_sar8i_i32
-#define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
-#define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
-#define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
 #else
 # error
 #endif
-- 
2.53.0


