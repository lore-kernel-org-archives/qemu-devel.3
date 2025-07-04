Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B4EC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLE-0002aN-Js; Fri, 04 Jul 2025 10:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIW-0005Vp-2I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:52 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIT-00068V-Qp
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:51 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eacb421554so352550fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638908; x=1752243708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQf/TObpoRHlubh31JKaROZXrhMyeMqBNp1Pj+KLbEk=;
 b=q0fvqTfAW03hxiFdt+xg/jpWZH4UTMi4mWSSEpAIPmyR5Cdq+oGuzQ1IZeodRkj1DW
 WG4iL5scMOGnpzNMxg2RL/jeIlQXrV7Qf4SIPZpcsJfCMztrkKdC6Gk5MQBGhBddxivW
 /IcQzdZvNQ87Fnom/a2xBE0gX00Q+0Eu+kaB9xxPSHA8WZoEb7/PA0uTOl4RaLe/pvMv
 WUn1LttssPJKeUYOETGv9C1ifWakoEJcQRfhku+Wbye8ob0hGU4D9Lh/tACWuXDYuYQ3
 6ybHGQkpRTFLQc/6s37+00y3AybJSER4WNY+fTn7uG17Z6d2gIaPkl8hYFhL4JaMdX1n
 edSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638908; x=1752243708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQf/TObpoRHlubh31JKaROZXrhMyeMqBNp1Pj+KLbEk=;
 b=wmDyEJTsf9DDBzhh1Jgr9xaGpv2PBa5VL/EcA/PTCbr5kmjk/gcW9LCmJI7NWX1y0p
 JnJnYrRzRF9UbM8mQ71WnBwH37UwHs9t88nbwto5Vx8ZB9r74DE/fkNkJfS/n1Yl0w70
 K3tH44DOrVCzVZ/j+mb88qXieMmfHPZnKG3/d0IlS7ZtN07yvy9E+G/QYVdkfzFeS2bJ
 jJ83tNw0W+5Q1NI0BW5N2mZ7OQoO2uQa02NO4HdL+9H5GhxKsmCWh8LCirrvS3I9ETgK
 a3RnTETXAa7jBHSpYm8hn3joCC7oXN9aTk41oyzz2p1oe4YBMgAbdhylANxZUAoc359E
 ryOw==
X-Gm-Message-State: AOJu0Yxo8gZrT/4TfofAa15Qtmh6qb++U4DayuEdQhrV3Ojml5VHcgXM
 KNTmPmQu2gNYkLSn0BeeFTkDCfQimRvQx6wiHPgShM7O5ywEFKqdNEskTvhxRQyf0sp1TK6dN8/
 2chGq54Y=
X-Gm-Gg: ASbGncuHJ4XuUWooVpjdObyHYKQBmBCjJ5zsCx17DiM9xK63SI1WEqWMpCBu6PZpSTQ
 8D5VdT+Z7hWCd9AYulyXS2t4nXGVSELUTLNI8Q21wFxUtkt+y7enaKkwJv0sKvu2pqFjqcipDuS
 AYUOx1Yiej+j/WPlOLlVwtjrzm6GOk57y13QFbethe29hhVRlzWg0/LLeBznDdiGNPI4re7bajG
 Bsx55d+YB1uSxK8Iu+6LkbccbaC0glDayoRZskGNko08ZptBMojzh49rwjiAvjOvqHN9XPRvKk2
 /ymOwOB6se7OZdZgeQ4xMfFtdav4jxyihb2B7/l4lhziC6pbMeKjLKEzthCNwzcwIG0roVfbhzm
 9pqFyeOQSDpeAKMbg198/uizRMNeSJ9+OfpTRrkzGm87KiUuq
X-Google-Smtp-Source: AGHT+IHyESVmGj7O0Oq7Qt/mEVraOuO7zGJwCjrPX8wvdDpgLHuCV/9jT88AIbbw+yqgRCfg2chjNw==
X-Received: by 2002:a05:6871:8790:b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2f791d8dedamr2380889fac.1.1751638908410; 
 Fri, 04 Jul 2025 07:21:48 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 033/108] target/arm: Implement SME2 ADD/SUB (array results,
 multiple vectors)
Date: Fri,  4 Jul 2025 08:19:56 -0600
Message-ID: <20250704142112.1018902-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4bb880d9ef..aabdb96675 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -775,3 +775,33 @@ TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
+
+/* Add/Sub each vector Z[m*N] to each Z[n*N] with result in ZA[d*N]. */
+static bool do_azz_nn(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 1);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, a->zn + i);
+        int o_zm = vec_full_reg_offset(s, a->zm + i);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8b81c0a0ce..a6dee08661 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -260,3 +260,23 @@ SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+
+### SME2 Multi-vector Multiple Array Vectors
+
+%zn_ax2         6:4 !function=times_2
+%zn_ax4         7:3 !function=times_4
+
+@azz_2x2_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2
+@azz_4x4_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4
+
+ADD_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+ADD_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+
+SUB_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
+SUB_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
-- 
2.43.0


