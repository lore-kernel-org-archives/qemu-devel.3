Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7253C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEN-0000Qy-7V; Fri, 04 Jul 2025 12:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEL-0000M5-8i
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEI-0006EK-Mm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso9178265e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646337; x=1752251137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CmZvbRAjfYsxJw4vSJC6fHJnVMyo6ne2Pmf7hBvBows=;
 b=IsgKQ8ggR6LxlI6yUrO35T44epKO0+31PzudS8Q0P1am5JVYMKRkG7xKtlcx6WHRix
 kS2vF+wuGYaenpMOF/VDg5Bs43M56QQnE93/kvG7BiKohEXeFjk7RmAe1B0ZzWX+fw+n
 IHBPzUEj1EKOh85XBr2I3IbSuAktVnrdRbAEMJ2lR3yShKwiGEDpkyZ7ySVyFlsqd+PQ
 pBjlEuTydyTq3tuexiky61J8FS0g1md5qPRXaoolbmNeDerRoaC/WgvgXvtvEY3B+xtm
 XgOlYYQsT//wEAe87lcAZhoDvMNC2rjTJZlYHTJzGD5UQy3UGXS17CTjOJ9WDXJxMDOi
 ReNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646337; x=1752251137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmZvbRAjfYsxJw4vSJC6fHJnVMyo6ne2Pmf7hBvBows=;
 b=SoJNv9UEUZSlHUcgghop1fuH2WPYG3vhFOmKLf3icvS/02Qit7MhcN9bCP/4Ii0wFr
 RIaYGmkYckjXHppQxkiy9oN6t5JlUfw3fmxp4ot2qeUg3FrvgvJCiDDBnm9WdOEYUOXz
 U+FwxvOBIVQsUD0l4Fw/z2pGGxXLEp0CgfOeBneik80AVL2k1ZTt5f4eNRKaRLlEYlwH
 OhGRRIXEDwACtrYcyqDPb89tfvl5U2gIpkLV3hHwc9IMF6NDRylDTsjsYGNazpb6ANb5
 /nPOMvSSDZ+MXH7Ehvr1oS0dq3dbbO6UbmCUUD9Cj6ZqvMGsvqpIywJ3nO01Ara/+CAK
 90rw==
X-Gm-Message-State: AOJu0Yxe11cJLoPXJQbZWICGNbPfXt02ieg+aV3wnd1SmxxC6tZ+L0YQ
 8zZhR54mKe08WGHIZV8D6htVuUlC1baXRQF77ptG8onnpeQH8Avs6TnRkFRxhtxBdrKIpOTXt6G
 0Kpz5
X-Gm-Gg: ASbGnctT6KVk8kda4G06ECQAVCVghuWu2CjLf+920b4VVC7+cRZC8ZhWmOR6SPGmWxc
 bI4wNI8Ouuv12jGfJpiE5GTf9jGg10KnytWPlQo5YiYY2bHwgQTybcxkLjfEGdhBO6b0xjJmQEo
 pNxRgYcj6L2TD817rWU5rSF7g084RRIfSwUXdGbnPxsaXdtQr9VWY97Rr6mwf5o7DbMdrSS0gMP
 gpiMvAaMxVVp5V8I/Z/t4/cvOynBIRmw9nLTssAjGrkPAVT07Bt0TGvp7itgKELczdlCrqP2WEU
 Vv2lhGUocW2YvTGCzMrMRI1RL8bM/1ffUySeIqz7BAF5ol2oz95yyZDtBrgDaKeKnpXT
X-Google-Smtp-Source: AGHT+IFx9p3DzOlMTmRokbUsEENtKonLFa9GLkRP16AXa1ffsFcGhRDuV/JgeGwRl919gydvr/JbZw==
X-Received: by 2002:a05:600c:83cd:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-454b4eb8333mr24698445e9.28.1751646337027; 
 Fri, 04 Jul 2025 09:25:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 037/119] target/arm: Implement SME2 MOVA to/from tile,
 multiple registers
Date: Fri,  4 Jul 2025 17:23:37 +0100
Message-ID: <20250704162501.249138-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  9 +++++
 target/arm/tcg/translate.h     |  1 +
 target/arm/tcg/sme.decode      | 37 ++++++++++++++++++
 target/arm/tcg/sme_helper.c    | 64 ++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 target/arm/tcg/translate-sme.c | 71 ++++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 858d69188fb..8246ce774ca 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -33,6 +33,15 @@ DEF_HELPER_FLAGS_4(sme_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_cz_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sme2_mova_cz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_cz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b03956a7937..7336b7db721 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -73,6 +73,7 @@ typedef struct DisasContext {
     int zt0_excp_el; /* ZT0 exception EL or 0 if enabled */
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
+    int max_svl;     /* maximum implemented streaming vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int vec_len;
     int vec_stride;
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 459b96805f9..5eca5f4acff 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -28,6 +28,7 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 
 %mova_rs        13:2 !function=plus_12
 &mova_p         esz rs pg zr za off v:bool
+&mova_t         esz rs zr za off v:bool
 
 MOVA_tz         11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
                 &mova_p rs=%mova_rs esz=0 za=0
@@ -51,6 +52,42 @@ MOVA_zt         11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
 MOVA_zt         11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
                 &mova_p rs=%mova_rs esz=4 off=0
 
+MOVA_tz2        11000000 00 00010 0 v:1 .. 000  zr:4 0 00      off:3  \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_tz2        11000000 01 00010 0 v:1 .. 000  zr:4 0 00 za:1 off:2  \
+                &mova_t rs=%mova_rs esz=1
+MOVA_tz2        11000000 10 00010 0 v:1 .. 000  zr:4 0 00 za:2 off:1  \
+                &mova_t rs=%mova_rs esz=2
+MOVA_tz2        11000000 11 00010 0 v:1 .. 000  zr:4 0 00 za:3        \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_zt2        11000000 00 00011 0 v:1 .. 000 00      off:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_zt2        11000000 01 00011 0 v:1 .. 000 00 za:1 off:2 zr:4 0 \
+                &mova_t rs=%mova_rs esz=1
+MOVA_zt2        11000000 10 00011 0 v:1 .. 000 00 za:2 off:1 zr:4 0 \
+                &mova_t rs=%mova_rs esz=2
+MOVA_zt2        11000000 11 00011 0 v:1 .. 000 00 za:3       zr:4 0 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_tz4        11000000 00 00010 0 v:1 .. 001 zr:3 00 000      off:2  \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_tz4        11000000 01 00010 0 v:1 .. 001 zr:3 00 000 za:1 off:1  \
+                &mova_t rs=%mova_rs esz=1
+MOVA_tz4        11000000 10 00010 0 v:1 .. 001 zr:3 00 000 za:2        \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVA_tz4        11000000 11 00010 0 v:1 .. 001 zr:3 00 00 za:3         \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVA_zt4        11000000 00 00011 0 v:1 .. 001 000      off:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVA_zt4        11000000 01 00011 0 v:1 .. 001 000 za:1 off:1 zr:3 00 \
+                &mova_t rs=%mova_rs esz=1
+MOVA_zt4        11000000 10 00011 0 v:1 .. 001 000 za:2       zr:3 00 \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVA_zt4        11000000 11 00011 0 v:1 .. 001 00 za:3        zr:3 00 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7b0bc1b17c0..baeaa3e0690 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -206,6 +206,50 @@ void HELPER(sme_mova_zc_q)(void *vd, void *za, void *vg, uint32_t desc)
 
 #undef DO_MOVA_Z
 
+void HELPER(sme2_mova_zc_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint8_t *src = vsrc;
+    uint8_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc);
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint16_t *src = vsrc;
+    uint16_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 2;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint32_t *src = vsrc;
+    uint32_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 4;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
+void HELPER(sme2_mova_zc_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    const uint64_t *src = vsrc;
+    uint64_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 8;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+    }
+}
+
 /*
  * Clear elements in a tile slice comprising len bytes.
  */
@@ -314,6 +358,26 @@ static void copy_vertical_q(void *vdst, const void *vsrc, size_t len)
     }
 }
 
+void HELPER(sme2_mova_cz_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_b(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_h(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_s(vdst, vsrc, simd_oprsz(desc));
+}
+
+void HELPER(sme2_mova_cz_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    copy_vertical_d(vdst, vsrc, simd_oprsz(desc));
+}
+
 /*
  * Host and TLB primitives for vertical tile slice addressing.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ad293c08858..d823036c96f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10142,6 +10142,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
+    dc->max_svl = arm_cpu->sme_max_vq * 16;
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ea0e5a7cb5b..7d4c7d7e855 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -227,6 +227,77 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
 TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
 
+static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
+{
+    static gen_helper_gvec_2 * const cz_fns[] = {
+        gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
+        gen_helper_sme2_mova_cz_s, gen_helper_sme2_mova_cz_d,
+    };
+    static gen_helper_gvec_2 * const zc_fns[] = {
+        gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
+        gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
+    };
+    TCGv_ptr t_za;
+    int svl, bytes_per_op = n << a->esz;
+
+    /*
+     * The MaxImplementedSVL check happens in the decode pseudocode,
+     * before the SM+ZA enabled check in the operation pseudocode.
+     * This will (currently) only fail for NREG=4, ESZ=MO_64.
+     */
+    if (s->max_svl < bytes_per_op) {
+        unallocated_encoding(s);
+        return true;
+    }
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    svl = streaming_vec_reg_size(s);
+
+    /*
+     * The CurrentVL check happens in the operation pseudocode,
+     * after the SM+ZA enabled check.
+     */
+    if (svl < bytes_per_op) {
+        unallocated_encoding(s);
+        return true;
+    }
+
+    if (a->v) {
+        TCGv_i32 t_desc = tcg_constant_i32(simd_desc(svl, svl, 0));
+
+        for (int i = 0; i < n; ++i) {
+            TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
+            t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
+                                   a->off * n + i, 1, n, a->v);
+            if (to_vec) {
+                zc_fns[a->esz](t_zr, t_za, t_desc);
+            } else {
+                cz_fns[a->esz](t_za, t_zr, t_desc);
+            }
+        }
+    } else {
+        for (int i = 0; i < n; ++i) {
+            int o_zr = vec_full_reg_offset(s, a->zr * n + i);
+            t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
+                                   a->off * n + i, 1, n, a->v);
+            if (to_vec) {
+                tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
+            } else {
+                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
+            }
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false)
+TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
+TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
+TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
-- 
2.43.0


