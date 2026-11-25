Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97950606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx1ChU4Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8VA-00009T-Fa; Wed, 25 Nov 2026 03:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW8V3-00008W-HQ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:37:09 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW8V1-0004Zq-3n
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:37:08 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3b413d04c93so3203144a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795595826; x=1796200626; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pBGdOaoCqcbgRwmoUAayveLAK2PspDh+9+88Eyi2Gi0=;
 b=Jx1ChU4QvzXk/GRyK48NZGXX8qqy+nAFNTzqkcfk204qg1CnlObkd5+WKxq+Ylv0+X
 5Udld6lsyuKEdbkG3jnSVXuddoCcG+H4v/fY6IqBLglSPPJxvrOXmJu/2w32Z2KSDOlq
 mpuWFOm/bHBBlK/aSbc2LUMdYtrRvhUqzcauWXBZxJzmqSlMSmAL/5W3gLt+WNiVtPAl
 8uzdMN4Hp4sjH9jJPopDIDHfzRVtDzcEH+jL2SOx/ToxETelcNJRB2KqXdZ9WHkx75SW
 2n4yycUF/sHeEM7VBhL2FZheX2bmMxzk0e58CE1O+z3W6GDSRpnKg2WFF7EzOseuzVEl
 qNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795595826; x=1796200626;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pBGdOaoCqcbgRwmoUAayveLAK2PspDh+9+88Eyi2Gi0=;
 b=fs/oyUltRKHjM+L+mC3uzyRQZ8UVI7QlM4xacMR1pKF+/Z99X4g0bRgYMOEMZaj8e+
 Xt+Zl7ZmTTM7RCPvQM9fyWlcxcEGCtgRHjTdYugxbsYekjELxgRez8/YXw/MDjXuStN5
 zDeeLLkLswJuMyX/YjEXvTShe4CYSTKZXxyel79BCtQ8uhgDDkLI15k+WbgEB555Iqqb
 1B5wyDU9qcL/rmMk69+4BeP5Bg2S1PGZvOCmZF8AnIX9luMkNRMAJNDFKniJyqSY/Nty
 UEk6VcohHrIRYQm1JsubM4hFWRTscFF1m2LDHfUvVK2UQr106a39u1VVrQoceEBfAZgs
 5Q/w==
X-Gm-Message-State: APuU4Z/N/Syojnli1e0FjVKb1Gp2g1VALY/HCeoSbVzSr3/eJCot84kc
 x/R4f0qFfoGyviuZRrQN29CP2g+gWz1zKlORRXjw04XDRgGE8IlvOHpw
X-Gm-Gg: AZFdTZcMiyCPpSYIF1IHYC1vBLxdB88S9cnVHqDP5DSV0YERmlFo8phIYVuTt6jpHsG
 iTl8vFdSVIHjGXFuoiw77RxHmMhaugLlDR8l2C9w7gtM6N38CbkqM84nOlUa2TAkuMlASaBDDtl
 a5C6yL8ykG46pK5MJCocIr942c59L7/iKGvdF5HoE/GXk+67VhLtE4IJRRwrbl2sCjXpW/+yWDN
 jFtsQvFBYFJB9rs21krqP70axfrLd3GBmhRYkte48VaiULcdZLXg7AytbSDXbUINdhK+k1Bm0FT
 JH58+osMjHRCNXH2+XBIiD3S/ffOmb6HNYn0kuvRfz+0K+bKFTWiI42sEcwcYuzOT4iJOXwhkN0
 hLdkpzykCDtv5/VXi8PNeIqXvoq7eP3eta0pgO4ud0ushbEihs5iFLsjFmvcukNL3V6+jnEOycM
 lwFi54QCq9pIcsRvwQJtAPoPgTivQvzXHcVACUtn78O0Lhb5XCSW2u94ddeoc4bADpkcFwf94jU
 uc/Mxl7F+hkhBY9c9P+bgvwHbdGW3uomPXM/Mb9YUyGUf1n92m7i58K6xUSNa2lPnDnTL7n+OZs
 gVTpfqnD9oWR6VXaTHmWmn6W
X-Received: by 2002:a17:90b:388c:b0:3ac:e6a:1b2b with SMTP id
 98e67ed59e1d1-3b41c5585femr16943774a91.0.1795595824799; 
 Wed, 25 Nov 2026 00:37:04 -0800 (PST)
Received: from [127.0.1.1] ([14.19.9.16]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b40578d771sm29247245a91.1.2026.11.25.00.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:37:04 -0800 (PST)
From: WX Chen <wxchen0913@gmail.com>
Date: Wed, 25 Nov 2026 16:11:05 +0800
Subject: [PATCH v2] target/riscv: add RVTSO memory ordering for vector
 memory accesses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fix-rvtso-vector-stride-v2-1-4aa58066e0b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIABiYBmsC/4WOQQ6DIBBFr9KwLg0DIthV79G4AByUpEoDhrQx3
 r3oBZq/esmfN38jGVPATO6XjSQsIYe4VODXC3GTWUakYahMOOMtAAfqw4emsuZIC7o1JprXFAa
 kovND65mQHhSp1++EtXqan31lazJSm8zipsPHNA6dckI4oUGjl2CU05KLRhmusfNtq5my8lBNI
 ddH33NjgUP4f04BWuMaCazhlln5GGcTXjcXZ9Lv+/4DLTmMO/kAAAA=
X-Change-ID: 20261121-fix-rvtso-vector-stride-39fd6f035f17
To: qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795595820; l=6482;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=2KfzBroKq6ABOBfo4xXullswpVOj3yegZavDjjWUly8=;
 b=9DjY8cGK5Yvy189u7c9c5+nT6stAQvAB5rS+I90Qa4rcGxOpqA6vuPjtIpjpdclO52aYjuWJ3
 jfXRbCKF/cpBxe/DdS6mTrmEFD9I3++ZMZBGs+4yc8SU5Ix/ABq695b
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wxchen0913@gmail.com; helo=mail-pj1-x1035.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RISC-V Ztso extension provides default memory ordering of:
    R -> R,  R -> W,  W -> W,  without W -> R,
but ldst_stride_trans, ldst_index_trans, ldff_trans and ldst_whole_trans
currently lack the ordering listed above. This may not satisfy the guest
requirements on hosts with weak memory ordering.
This patch adds the above ordering in these functions.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
Changes in v2:
- Handle ldst_index_trans, ldff_trans, ldst_whole_trans.
- Add references to the Ztso comment in ldst_us_trans.
- Link to v1: https://lore.kernel.org/qemu-devel/20261121-fix-rvtso-vector-stride-v1-1-1c451042b0b5@gmail.com
---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 56 +++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 7e1295f33e7d4b7a2ff26cbf428f6b5d9eb682ff..0949884b426b7d0995c76d11c1fde9445a9dcac9 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -880,7 +880,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
                               uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s)
+                              DisasContext *s, bool is_store)
 {
     TCGv_ptr dest, mask;
     TCGv base, stride;
@@ -896,10 +896,22 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
+    /*
+     * See ztso comment in ldst_us_trans for more info on why
+     * the barriers are put around the loop.
+     */
+    if (is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
+    }
+
     mark_vs_dirty(s);
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
+    if (!is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
+    }
+
     finalize_rvv_inst(s);
     return true;
 }
@@ -924,7 +936,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -958,7 +970,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
         return false;
     }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -981,7 +993,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
-                             DisasContext *s)
+                             DisasContext *s, bool is_store)
 {
     TCGv_ptr dest, mask, index;
     TCGv base;
@@ -998,10 +1010,22 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
+    /*
+     * See ztso comment in ldst_us_trans for more info on why
+     * the barriers are put around the loop.
+     */
+    if (is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
+    }
+
     mark_vs_dirty(s);
 
     fn(dest, mask, base, index, tcg_env, desc);
 
+    if (!is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
+    }
+
     finalize_rvv_inst(s);
     return true;
 }
@@ -1045,7 +1069,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
 
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1098,7 +1122,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1135,6 +1159,14 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
+    /*
+     * See ztso comment in ldst_us_trans for more info on why
+     * the barriers are put around the loop.
+     */
+    if (s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
+    }
+
     finalize_rvv_inst(s);
 
     /* vector unit-stride fault-only-first load may modify vl CSR */
@@ -1193,6 +1225,14 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      */
     bool use_helper_fn = !s->vstart_eq_zero;
 
+    /*
+     * See ztso comment in ldst_us_trans for more info on why
+     * the barriers are put around the loop.
+     */
+    if (!is_load && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
+    }
+
     if (!use_helper_fn) {
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
@@ -1244,6 +1284,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
         fn(dest, base, tcg_env, desc);
     }
 
+    if (is_load && s->ztso) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
+    }
+
     finalize_rvv_inst(s);
     return true;
 }

---
base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
change-id: 20261121-fix-rvtso-vector-stride-39fd6f035f17

Best regards,
-- 
WX Chen <wxchen0913@gmail.com>


