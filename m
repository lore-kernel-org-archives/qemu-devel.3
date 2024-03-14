Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A855C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpKl-0005TL-Rx; Thu, 14 Mar 2024 13:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKj-0005SJ-OL
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKg-0005YB-U8
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d944e8f367so10091635ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710439048; x=1711043848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5Gr03KDR8W8zLLO2gIJakof8sfxcHeyxFszbVTmuNg=;
 b=aUypBBdx1BtSze8tt5HuAlmZMX7pwwXiQnaaa3pkkR9EDGGhufT8A0UJ+LT8xJsod+
 xcLhAiDdxpgZeQJewAn11d5pBPWlSgCReY7FuArcVjajd/ZXZ5FhcQkUd7dzsPxwFwYo
 eERAeezFPL6K82EF3BJzkwTMWU8wV6FAn60wP4jbal43GRjgyysRooUkbiDVpycE/gm9
 tyzDAqVaPbKPFVTSu6ZMynlUPyXu1D2EzIVU/86CWBEmLuinVybOKhoJ0fe78TLx4Vwf
 2mS7cqPFY3w9/H6JV9spt+p5WtlLFb6EZXPyGgPnrE7G7mtmGTiKuGPfliYyRgG/NCkK
 ujSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439048; x=1711043848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5Gr03KDR8W8zLLO2gIJakof8sfxcHeyxFszbVTmuNg=;
 b=q3/ele4MIcmaeg92rfBZi+POC72WP/WDC9mJC1GLRgBnpqeTXq6uLeiqCIcX1B168D
 sggP0BRD4WJPUmNP6TOt4BazVHtNBM2cpZTlQ2zzDMMPpgaCmQoRE0xZzF5S6i0XOsyG
 SWiGnQSZUsxbf/IJujlV3V7Lr5lC8WHrm+uOvRnzc0VOMrpJrhNqqKpENj1olPR/Hmoc
 MdAS/6qq3LltObVmhLj2oicGEC/K0wgxBOJDeoWgahDtScX10tjF6kHmeSKkIoLqO/8h
 yIT5yvGict2t7og2J/enWtk32s7leeQqa0iJxZJVbH0KAXt1r9aVuHoizMIumzpE0cz6
 iPOg==
X-Gm-Message-State: AOJu0YxCfKKqp3aqectKv4t0svVqZ/eGcF04xhVAUYwg/WtPHjNX2L/Z
 7mXxLYy2x2WALS9hWeGSkWRUhEZRgDoTqAoT0a3pybmrCChsOcehGcYReWFag3yPAuEZECrmppv
 r
X-Google-Smtp-Source: AGHT+IHHk7j5PdCEgYIG5irVAbeUNAksuiAyzS4zx9M/VgqDRN9dO3Yp0t9/+tJ9A5RcY6z11kV3YA==
X-Received: by 2002:a17:903:245:b0:1dd:a34e:84aa with SMTP id
 j5-20020a170903024500b001dda34e84aamr2593954plh.48.1710439047713; 
 Thu, 14 Mar 2024 10:57:27 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001db717d2dbbsm1991776pla.210.2024.03.14.10.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:57:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for 9.0 v15 05/10] target/riscv: always clear vstart for
 ldst_whole insns
Date: Thu, 14 Mar 2024 14:56:59 -0300
Message-ID: <20240314175704.478276-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314175704.478276-1-dbarboza@ventanamicro.com>
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 8ff8ac6329 added a conditional to guard the vext_ldst_whole()
helper if vstart >= evl. But by skipping the helper we're also not
setting vstart = 0 at the end of the insns, which is incorrect.

We'll move the conditional to vext_ldst_whole(), following in line with
the removal of all brconds vstart >= vl that the next patch will do. The
idea is to make the helpers responsible for their own vstart management.

Fix ldst_whole isns by:

- remove the brcond that skips the helper if vstart is >= evl;

- vext_ldst_whole() now does an early exit with the same check, where
  evl = (vlenb * nf) >> log2_esz, but the early exit will also clear
  vstart.

The 'width' param is now unneeded in ldst_whole_trans() and is also
removed. It was used for the evl calculation for the brcond and has no
other use now.  The 'width' is reflected in vext_ldst_whole() via
log2_esz, which is encoded by GEN_VEXT_LD_WHOLE() as
"ctzl(sizeof(ETYPE))".

Suggested-by: Max Chou <max.chou@sifive.com>
Fixes: 8ff8ac6329 ("target/riscv: rvv: Add missing early exit condition for whole register load/store")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 52 +++++++++++--------------
 target/riscv/vector_helper.c            |  5 +++
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 52c26a7834..1366445e1f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1097,13 +1097,9 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
-                             uint32_t width, gen_helper_ldst_whole *fn,
+                             gen_helper_ldst_whole *fn,
                              DisasContext *s)
 {
-    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
-
     TCGv_ptr dest;
     TCGv base;
     TCGv_i32 desc;
@@ -1120,8 +1116,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
-    gen_set_label(over);
-
     return true;
 }
 
@@ -1129,42 +1123,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
+#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
 {                                                                         \
     if (require_rvv(s) &&                                                 \
         QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
-        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,             \
+        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
                                 gen_helper_##NAME, s);                    \
     }                                                                     \
     return false;                                                         \
 }
 
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
+GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
+GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
+GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
+GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
 
 /*
  *** Vector Integer Arithmetic Instructions
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bcc553c0e2..1f4c276b21 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -572,6 +572,11 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
 
+    if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
+        env->vstart = 0;
+        return;
+    }
+
     k = env->vstart / max_elems;
     off = env->vstart % max_elems;
 
-- 
2.44.0


