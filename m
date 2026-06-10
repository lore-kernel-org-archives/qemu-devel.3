Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB138CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYZ-0002t6-Le; Wed, 10 Jun 2026 12:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYV-0002hH-EH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYS-0006Gh-QN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso3692545f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108003; x=1781712803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E7sTj5GGvMXsa58aM6RuD2LvPBXO6b0NVjqEMZ4vVUI=;
 b=ZYecxsqOisyd33wDEEqKonP502F0YLc3G3lg2uEJK3IdK1NG8sYv5syHdW6MEoSOW1
 oBZvktGRii7au40QqDyE6uXstbPhbko9BSIt0nAeLt2llrpXzTbXdAvvPYM60XfitgZm
 t/itz4hl72W5eoX9+DD5vbxNCb5zARt+1Pbh2ImvcO8tTx5d3Oxb2dDbkT0P7uiqD5wF
 FeC3t4ad7unAm3RlhrtQ85dUEXiKwzY8VBalCMruIj4Vp6EhSFNI2ip1DJJFsHmeTq2m
 3+50Awfh7/49KYocwUAqAuGYe1Mb07mnh48YON8uyTUEfAUbKUTLxwKfaK7eEYXMZF5D
 NVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108003; x=1781712803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E7sTj5GGvMXsa58aM6RuD2LvPBXO6b0NVjqEMZ4vVUI=;
 b=J/5htww7RB/1JWOn2Mn2qrzNJLQMZ3K3cwWR8i1UWw/iUWQ/XcaqTE4iMe8wbhO+kP
 hYvEMNrmjiNlXKDwf6BxZBRxUuBsRvge13jmU73xlWRWdRfTVC+JRzsgn34X4z6BNmNt
 UZo5gVsFVwIpFzOC4NUxUQFBIDsrkawlRAiPWULDWmiO11PCmmOeNCAc2a+tMxEkE60d
 dzMk4stvcgvFZUhK7x6NUzyKqgyxWiKY206J0hRsVoH35aFtCCfUV9zTy7fB1IlO54FB
 P3dMkR26UOZNRM+8u6XcgqXrj66l8ekZtxg3TVDYuebkIlQtPlYCLZ67e5mom3W6SFdX
 cIVg==
X-Gm-Message-State: AOJu0YymXM61CJCaicbVRaa4NPBbaFhyp3UpIxiLjSgmplksA11UUh22
 pK7JDzoQnEpwpwQuM0su8xyYdqOpWF0pb+AVt3DD+prisOqeRI/gZLFNHBWifmqSDVpGlSw6WDx
 imyAK
X-Gm-Gg: Acq92OHsp6c/KiImX+RB7g52GxeO43A9gk65Qmnj6rQwPUTCaXcALTHNihXxpg0qX4E
 9S80e0xxxqZs1OWgt8lDGysE5ZV3XTheg0dWUJmGBHI3Cyqp2vmgw+PHtkTCG7Rca9xo2Ygojbc
 Oo6JgLGhIVvd2yl7xZVl2PIrD5XG2QpLCdBedDL1GevAFfAyjYeNkOaSoP2YviG0R4d0sm+Xz9O
 QwnnqtrzvdiQ7b0qYh9VdbHLv7+f+H0tQ7MsUUjIKdUA43zO14XrnDRPMGDhLajRnnEg34iboOt
 Z+g+zWPjD7DpdzemwtwdarC13yIR+UYg9BRfPSGVpiBFmFeAg9LBpl1gR1Jk/kT2kQsuaXBKxEX
 2BbZiTfLBPfOoox3jvwWGxKhM2BjRncCsnU8O6Dw7SPxQNGRd07s5E7RdsTZzyd1UInOaXK5F4F
 NSeIzaURVc5u0gtJESFj6lB6ZyPhcTI1SCGdUvK56/Lo9i7q9YJoXldXhTxCmlrxUozqghxBy1m
 IIq7A9COzRPwQlqZKSVfT45eKOjg51Zv6RHhM7e754=
X-Received: by 2002:adf:fe01:0:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-460304fae00mr32249911f8f.11.1781108003333; 
 Wed, 10 Jun 2026 09:13:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/71] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Wed, 10 Jun 2026 17:11:49 +0100
Message-ID: <20260610161202.2235298-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 5 +++++
 target/arm/tcg/translate-sve.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 453bae3a0e..9f207a32b9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8388,3 +8388,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
-- 
2.43.0


