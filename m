Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B4DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEh-00013h-Je; Fri, 04 Jul 2025 12:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEc-0000oL-Dc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEa-0006Oz-Md
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so1014987f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646355; x=1752251155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fVDc3p3jv4yhzpySWv3CyUmaJfMI96VhimJBf6J5LIo=;
 b=noW6Z7WiaEaKj2+MgnPmCxQLEfihW1OIup/SZzCjj7LqfY+r4mYVJr2qUAy7TZ1Nlb
 eONTU1+QfvY22+RiV/m7RQoXUvsMnMpPfTMDpVxwe51kp/Nw4bF6Hloqev3X81MYclw4
 svMP8zNF1OywUc8t9o89oeG9UVh9VOVMJ2HacjTjB16bU710cVj3Vh8nVj2Ni8taSo/k
 vv0ytynMb8xpwe19YJrv6cdxF+e6hmflcrPYbOcjioN6Tcuuh7LKod7MwxgqvDPbf765
 dXA7CMo4DxiYTIy0c6Xk1BxZg/31vm2rGRxp3eZdRnxTDnJfcbxwkjnEwhCSPpjavylm
 GWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646355; x=1752251155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVDc3p3jv4yhzpySWv3CyUmaJfMI96VhimJBf6J5LIo=;
 b=DlzEWzoCYPYAavesd8xQlB0H6F4afHII6hT2rmmy6BeLK9Hmpp2AWkN3b9PCbtVM3Y
 vsP9FDwIWkzYBGkOhAODXdob8Jrp45+XT1eVg4u1WBcH3XoNBSAy1bXbuLt6YNIDS3HR
 ziVN8uxo2rrQKuP2ZbGN6ayJBc/D/aIdfhICkPaJQOdLAIJgW9oCQjpHEzg/o0dar86L
 EboPmwzMR0d0r4cOQIj+zhT2QZz1TLsmdkg84WFY2ZU5eGCpVscMdKeM83vIb3HDdzEF
 2patJ3abwWmwjUIpP/+Y+6iXs54HnOJLsMJcAJDQpCFwFNlYEilWD861eMEOVKdADzMM
 SQ3g==
X-Gm-Message-State: AOJu0Yz5MY5tU6tVcCg0XduG6FgzLcggQPqbCx89qU+O4ne5UpGXMAQl
 NY7ZvxmvrnpxJZjc7nOr391c60QpyebeVvcOuMuyWxclJs95bh+xsrUKGxTvxrf2XUCR46uFASb
 HNB8P
X-Gm-Gg: ASbGnct7TNAvZOEY+33lhdoG8ouHgT6h+hG5BG27wAyVxKDt4Sw1Z+Z5FKw0Bmj0Ndi
 Lj055gk8wrJdrF/U37wkk8ADFFlEhAAeNkVSbj8l+rMrg+mVXPB0ROc+7k9NJZSGGpk+gU/y/zh
 n/cKCDTUWyI4QGXWyASw0Dm5eiWvN9pGxRxocd/o0qEoJi02jwj1Av558bgGqGclODtAZkVQYPw
 sF5OrDeq5kIfIzaGwF3gY94EGX7hg52I75nHhYX5XVDkCp91hyhMmx6o9a4+kEC9J0cvMq/1W3F
 780jHyYu9PdhTOlzpKaqGcF9ZA8l1pVl+a3rgRABZADDq/Vh1oUrXfwgl9DVb2X55xGLY8e4Mox
 66yo=
X-Google-Smtp-Source: AGHT+IE8IpVZbnlgvRgxThA6PiixBaw2TvzuOG6oS2cjRg8Sj2a9W3eDUNxiI5gWim+GT63h7z/qxw==
X-Received: by 2002:a05:6000:11d2:b0:3a5:39d5:d962 with SMTP id
 ffacd0b85a97d-3b496604c41mr2605343f8f.41.1751646355082; 
 Fri, 04 Jul 2025 09:25:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 056/119] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
Date: Fri,  4 Jul 2025 17:23:56 +0100
Message-ID: <20250704162501.249138-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Message-id: 20250704142112.1018902-45-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  8 +++++++-
 target/arm/tcg/translate-sve.c | 10 ++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 401c0258527..83c259def6e 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -856,6 +856,9 @@ SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
 UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
 UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
+SDOT_zzxw_2s    01000100 10 0 ..... 110010 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_2s    01000100 10 0 ..... 110011 ..... .....   @rrxr_2 esz=2
+
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
 MLA_zzxz_s      01000100 10 1 ..... 000010 ..... .....   @rrxr_2 esz=2
@@ -1597,7 +1600,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
-## SVE mixed sign dot product
+## SVE dot product
+
+SDOT_zzzz_2s    01000100 00 0 ..... 110 010 ..... .....  @rda_rn_rm_ex esz=2
+UDOT_zzzz_2s    01000100 00 0 ..... 110 011 ..... .....  @rda_rn_rm_ex esz=2
 
 USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c82a0f771db..10261e25f92 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3426,6 +3426,11 @@ TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
+TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_sdot_idx_2h, a)
+TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_udot_idx_2h, a)
+
 #define DO_SVE2_RRX(NAME, FUNC) \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
@@ -7154,6 +7159,11 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
 TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
+TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_sdot_2h, a, 0)
+TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_udot_2h, a, 0)
+
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
 TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
-- 
2.43.0


