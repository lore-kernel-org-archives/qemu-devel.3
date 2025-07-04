Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78556C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhP3-0002HZ-Cv; Fri, 04 Jul 2025 10:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM6-0004Yl-Ux
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:37 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLz-00086H-Ta
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:33 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c47631b4cso863654a34.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639126; x=1752243926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94yRyXv/a+r27FH2Y4vjXt8+mpChSefv37z2JQXcfow=;
 b=M28/845E4wBW6Ck+Oz6WeAtrj/gZsJv9oqWxrDdLJE+p7vUfBnxa9BaRC74t9yi3l8
 zZxNvmmQPRZ5KKqtAzWO4aOzS/oTQU4jlxwmSlUP9bBjsQ6lZ2VjZdfHa/zBaWjv87hP
 xqEHgAggS3Sb0SN5N6EF8Z2NPCdLZG35oY8C3rLc6MUYDsqosdHmgqCds2g+L+WY+Aie
 l28+hI+SdqF5+5u//vTchLmE9vMvYbXc8hF5a3lC7TrNVlrzGc7Biv1x+8tKWw4ld/8u
 yu7knF2kprq2vXTtwSFROtoIjQkbsWQd+fzoJhaIMogdKuhMuUd03kgI9wusjU8S9qSC
 sdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639126; x=1752243926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94yRyXv/a+r27FH2Y4vjXt8+mpChSefv37z2JQXcfow=;
 b=UQJth4UhqGpaqYNb1oI64i3mt++YcJCGdQO9fze2xonu69A5oyhRIZh15WPHWFL3tF
 SE/H8FhACTGHShOs4w5glc9NYsIIRCi2vt3QGZJp/H0Wsr9FA2LDL6h+lQzyAj8KMtp0
 d3dJTMFSH5hjUtBH/hSGDscwWxalCsL87+J8A1GVwCEhbMIpWRG6Fp3Hlb5jJJo6ZEeo
 ES9p+qNGoluQIhu/GxZdZ1w02C7gfYzIZhbOUq4kSZHP+P+WVeujKAI4fkvubiG/y0E5
 bTLKWI0Pu6SRgeQegUq5JlWskVu9d9kOqfkl9uVTYiXitz41yAdFYXjJ7xirhW0GkA91
 R1zg==
X-Gm-Message-State: AOJu0YyLANPMuEy8l6RO0t8ialfOvivX2gdesV7simVTbTLWARnF2V7q
 eCm9xpNNO0Gh1VBC796MgpKCHdEGG8aMmLAdVkDn1WDed4NEqSYMlg5uLUn1yOP1nyS1iBaAtp2
 3Aj3JNNE=
X-Gm-Gg: ASbGncvfXxOmSHDr+m8xZuf1LJZrglZ5cGgYLd36xQ0ntcYSo0P1m9VrIrfs9XBcTDP
 PSIJKmfNRsxk9oGK5HNfeKP1qUqHQhGzgJq1+ExmDRsiKPnXnj501lPdg1YZs9LFaF9FcLCnwbT
 6AFtHwYXAFm48Z5Zm1YCEu3XwdD04xkp/d1vQWE01s/JTn+NcFylrzVNCzkMpMlND42C2xH/DOV
 FSHyqX7xyzwqU+kDzUKbhgOQBXHN3kjk3XnvNswtgdIISJNJo4dOoOFD2s0Rk6uHkM8lSrOtfdM
 RJeNw6H3SJNzvnbCymwfCDl5D6uODJ5ye0Arc7Y4UNudVOc0zQoO5e9ReSXdudDYfECEoS5SLnU
 K48fba9UJu5Z8A194Qmd3jWR9uc4XIyB9vJ6+FHvqx0L9rVbJ
X-Google-Smtp-Source: AGHT+IEfox0T3kKhZ1LD3ZXgcQR+pSgdZ7UmHnn8OSv1rzVSpM2MXbawUrrDdCgQaSZUCbkJmt/Hww==
X-Received: by 2002:a05:6830:914:b0:739:fe86:9dfc with SMTP id
 46e09a7af769-73ca676d742mr1517409a34.23.1751639126421; 
 Fri, 04 Jul 2025 07:25:26 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 068/108] target/arm: Implement FCLAMP for SME2, SVE2p1
Date: Fri,  4 Jul 2025 08:20:31 -0600
Message-ID: <20250704142112.1018902-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

This is the single vector version within SVE decode space.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff70bf27b0..210a029ab8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7428,6 +7428,28 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 
 TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
+static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
+{
+    static gen_helper_gvec_3_ptr * const fn[] = {
+        gen_helper_sme2_bfclamp,
+        gen_helper_sme2_fclamp_h,
+        gen_helper_sme2_fclamp_s,
+        gen_helper_sme2_fclamp_d,
+    };
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8
+        ? !dc_isar_feature(aa64_sve_b16b16, s)
+        : !dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+
+    /* So far we never optimize rda with MOVPRFX */
+    assert(a->rd == a->ra);
+    return gen_gvec_fpst_zzz(s, fn[a->esz], a->rd, a->rn, a->rm, 1,
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
 TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f808362f23..dcfc40ef44 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1721,3 +1721,5 @@ PSEL            00100101 .1 1 000 .. 01 .... 0 .... 0 ....  \
 
 SCLAMP          01000100 .. 0 ..... 110000 ..... .....          @rda_rn_rm
 UCLAMP          01000100 .. 0 ..... 110001 ..... .....          @rda_rn_rm
+
+FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
-- 
2.43.0


