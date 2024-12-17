Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAFAE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEl-0007te-6m; Tue, 17 Dec 2024 12:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEi-0007sH-HF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEa-00069N-Ep
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1992508f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455983; x=1735060783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3YD6YV4WlQDZBnY8Dkjl2MqG+rfrDomogT/cpe8SvJk=;
 b=EErKLSITuroKZL4FyhZO3d4ctMvlMarz3WIXgzTSuTbzcTscS14quC6VWpvF5VvCFU
 3e06efjeqW9jlzH9505omsHTwQw1nbcFFGDJgsGbBUhO04E0ukP3fPocbZExq+mq17af
 Vms8wMTlkA8rrDp+0q9OM6ec1aXV6Km1rqZlNivVPScwnnVxzYK+ZM2vOeb8b7PZjxmb
 IUIvBaYn7441Alc5SWZA49dKIHztmmoJGzffX4JGpqZ8Nr/C7Xnar8t48X8XOS2LLgrY
 4IDtSShoq/QQrV7CQLIFc0oNem2S+mzDraqqVgXJwZyhC7i09XRz/+RFI5yebrptOFQM
 2E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455983; x=1735060783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YD6YV4WlQDZBnY8Dkjl2MqG+rfrDomogT/cpe8SvJk=;
 b=a5FFxVYddPCo2G3K/C2Pm5OgFN6bNcgIGZ625cGEqmCX78QjvU96q9vfvXKNyJK4U1
 6EiukP9tmInMGvxHSsMlfn+ZL+TNPBpokwkCNayHYhzi8DI2+vyZFReV3kxHtj/uvYsa
 708IPi4dTrxxxmV95Isj2lc3p9GBnBQc2Cywl5em5xf+1lmUY0OYmx/LtoEbRsozqC4X
 ZfKl77ohv8Vyk2Azb8dvA26sVsLLZQjRN517SQhL8JOSR1FnjHNFKjXTTyU450CGCSOE
 KJxmsjWG3dfN474iy0zkrDRqC/Eu/0ly2kO39WdJREEmBAOwmdp6UXWpmg1ZDmzINHQJ
 DtGw==
X-Gm-Message-State: AOJu0Yw/eRFN/xmQaG1zaje5iZYX7mepR/86D+S8Ot7qwpoAe/cuUv8B
 bq31+qGXopIiXR5XwFTqqCFgETucqZm2I0vYDRbjBnWr7UfT0kxb5dxyKmto+cXwMhLc417bmL6
 N
X-Gm-Gg: ASbGnctXW7MVpusc0mG56siZdqvWx4HP7Oid7ydF1T2JHbF4KO8KNyZ8fAj5tiQcV0L
 sy2IkkHBiTLU/OzALi7vDhidlumcqW/1COWKYIkeowZ3aW/31DsCoSdsPmA8dVjK+10xNuBIl9U
 bG2KaWHj/JSSSdUe/dfXE5HqG8sxql6jERL2g746tXrblItcZRF1Dm+JN3Iu9YUpZn074AFqgXX
 J2QAa1ORx8jHVBW3VHZtYpewnroh3e0DVHoU7x2VOowfXimeg4tkXK8V1fYuv0=
X-Google-Smtp-Source: AGHT+IGGVmftKYecIyMGiC+E3CBlhhtZ8Am20NhVGkQ/ljqihv7QUuVyVouUzq6RHMPUOKZC0vpxNQ==
X-Received: by 2002:a05:6000:1544:b0:386:2bac:139 with SMTP id
 ffacd0b85a97d-3888e0c088amr12388280f8f.54.1734455981981; 
 Tue, 17 Dec 2024 09:19:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] target/arm: Convert vfp_helper.c to fpst alias
Date: Tue, 17 Dec 2024 17:19:20 +0000
Message-Id: <20241217171937.3899947-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h     | 268 ++++++++++++++++++++--------------------
 target/arm/vfp_helper.c | 120 ++++++++----------
 2 files changed, 186 insertions(+), 202 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9919b1367b7..5f7bb88067c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -109,33 +109,33 @@ DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
-DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_2(vfp_sqrth, f16, f16, ptr)
-DEF_HELPER_2(vfp_sqrts, f32, f32, ptr)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, ptr)
+DEF_HELPER_3(vfp_addh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_adds, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_addd, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_subh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_subs, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_subd, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_mulh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_muls, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_muld, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_divh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_divs, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_divd, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_maxh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_maxs, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_maxd, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_minh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_mins, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_mind, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_maxnums, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_minnumh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_minnums, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_minnumd, f64, f64, f64, fpst)
+DEF_HELPER_2(vfp_sqrth, f16, f16, fpst)
+DEF_HELPER_2(vfp_sqrts, f32, f32, fpst)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, fpst)
 DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
@@ -145,110 +145,110 @@ DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
 
 DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
 DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
-DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, ptr)
-DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, ptr)
+DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, fpst)
+DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, fpst)
 
-DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
-DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
+DEF_HELPER_2(vfp_uitoh, f16, i32, fpst)
+DEF_HELPER_2(vfp_uitos, f32, i32, fpst)
+DEF_HELPER_2(vfp_uitod, f64, i32, fpst)
+DEF_HELPER_2(vfp_sitoh, f16, i32, fpst)
+DEF_HELPER_2(vfp_sitos, f32, i32, fpst)
+DEF_HELPER_2(vfp_sitod, f64, i32, fpst)
 
-DEF_HELPER_2(vfp_touih, i32, f16, ptr)
-DEF_HELPER_2(vfp_touis, i32, f32, ptr)
-DEF_HELPER_2(vfp_touid, i32, f64, ptr)
-DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
-DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
-DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
-DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
-DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
+DEF_HELPER_2(vfp_touih, i32, f16, fpst)
+DEF_HELPER_2(vfp_touis, i32, f32, fpst)
+DEF_HELPER_2(vfp_touid, i32, f64, fpst)
+DEF_HELPER_2(vfp_touizh, i32, f16, fpst)
+DEF_HELPER_2(vfp_touizs, i32, f32, fpst)
+DEF_HELPER_2(vfp_touizd, i32, f64, fpst)
+DEF_HELPER_2(vfp_tosih, s32, f16, fpst)
+DEF_HELPER_2(vfp_tosis, s32, f32, fpst)
+DEF_HELPER_2(vfp_tosid, s32, f64, fpst)
+DEF_HELPER_2(vfp_tosizh, s32, f16, fpst)
+DEF_HELPER_2(vfp_tosizs, s32, f32, fpst)
+DEF_HELPER_2(vfp_tosizd, s32, f64, fpst)
 
-DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosqd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touqd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_shtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
+DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tosqd_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_touqd_round_to_zero, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_touhh, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toshh, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toulh, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_toslh, i32, f16, i32, fpst)
+DEF_HELPER_3(vfp_touqh, i64, f16, i32, fpst)
+DEF_HELPER_3(vfp_tosqh, i64, f16, i32, fpst)
+DEF_HELPER_3(vfp_toshs, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_tosls, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_tosqs, i64, f32, i32, fpst)
+DEF_HELPER_3(vfp_touhs, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_touls, i32, f32, i32, fpst)
+DEF_HELPER_3(vfp_touqs, i64, f32, i32, fpst)
+DEF_HELPER_3(vfp_toshd, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tosld, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tosqd, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_touhd, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_tould, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_touqd, i64, f64, i32, fpst)
+DEF_HELPER_3(vfp_shtos, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_sltos, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_sqtos, f32, i64, i32, fpst)
+DEF_HELPER_3(vfp_uhtos, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_ultos, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_uqtos, f32, i64, i32, fpst)
+DEF_HELPER_3(vfp_shtod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_sltod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_sqtod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_uhtod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_ultod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_uqtod, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_shtoh, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_sltoh, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_ultoh, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, fpst)
+DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, fpst)
 
-DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, fpst)
+DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, fpst)
+DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, fpst)
+DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, fpst)
 
-DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
+DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, fpst)
 
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, fpst, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, fpst, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, fpst, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, fpst, i32)
 
-DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
-DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
-DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
+DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, fpst)
+DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, fpst)
+DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, fpst)
 
-DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
+DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
+DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
+DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
@@ -258,15 +258,15 @@ DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
-DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, fpst)
+DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, fpst)
+DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, fpst)
+DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, fpst)
 
 DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
-DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
+DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, fpst)
 
 DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
 
@@ -867,10 +867,10 @@ DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, fpst)
+DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, fpst)
 
 DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index df4ff464792..8a56936751b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -289,19 +289,16 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val)
 #define VFP_HELPER(name, p) HELPER(glue(glue(vfp_,name),p))
 
 #define VFP_BINOP(name) \
-dh_ctype_f16 VFP_HELPER(name, h)(dh_ctype_f16 a, dh_ctype_f16 b, void *fpstp) \
+dh_ctype_f16 VFP_HELPER(name, h)(dh_ctype_f16 a, dh_ctype_f16 b, float_status *fpst) \
 { \
-    float_status *fpst = fpstp; \
     return float16_ ## name(a, b, fpst); \
 } \
-float32 VFP_HELPER(name, s)(float32 a, float32 b, void *fpstp) \
+float32 VFP_HELPER(name, s)(float32 a, float32 b, float_status *fpst) \
 { \
-    float_status *fpst = fpstp; \
     return float32_ ## name(a, b, fpst); \
 } \
-float64 VFP_HELPER(name, d)(float64 a, float64 b, void *fpstp) \
+float64 VFP_HELPER(name, d)(float64 a, float64 b, float_status *fpst) \
 { \
-    float_status *fpst = fpstp; \
     return float64_ ## name(a, b, fpst); \
 }
 VFP_BINOP(add)
@@ -314,19 +311,19 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
-dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, void *fpstp)
+dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, float_status *fpst)
 {
-    return float16_sqrt(a, fpstp);
+    return float16_sqrt(a, fpst);
 }
 
-float32 VFP_HELPER(sqrt, s)(float32 a, void *fpstp)
+float32 VFP_HELPER(sqrt, s)(float32 a, float_status *fpst)
 {
-    return float32_sqrt(a, fpstp);
+    return float32_sqrt(a, fpst);
 }
 
-float64 VFP_HELPER(sqrt, d)(float64 a, void *fpstp)
+float64 VFP_HELPER(sqrt, d)(float64 a, float_status *fpst)
 {
-    return float64_sqrt(a, fpstp);
+    return float64_sqrt(a, fpst);
 }
 
 static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
@@ -371,16 +368,14 @@ DO_VFP_cmp(d, float64, float64, fp_status)
 /* Integer to float and float to integer conversions */
 
 #define CONV_ITOF(name, ftype, fsz, sign)                           \
-ftype HELPER(name)(uint32_t x, void *fpstp)                         \
+ftype HELPER(name)(uint32_t x, float_status *fpst)                  \
 {                                                                   \
-    float_status *fpst = fpstp;                                     \
     return sign##int32_to_##float##fsz((sign##int32_t)x, fpst);     \
 }
 
 #define CONV_FTOI(name, ftype, fsz, sign, round)                \
-sign##int32_t HELPER(name)(ftype x, void *fpstp)                \
+sign##int32_t HELPER(name)(ftype x, float_status *fpst)         \
 {                                                               \
-    float_status *fpst = fpstp;                                 \
     if (float##fsz##_is_any_nan(x)) {                           \
         float_raise(float_flag_invalid, fpst);                  \
         return 0;                                               \
@@ -415,12 +410,12 @@ float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
     return float64_to_float32(x, &env->vfp.fp_status);
 }
 
-uint32_t HELPER(bfcvt)(float32 x, void *status)
+uint32_t HELPER(bfcvt)(float32 x, float_status *status)
 {
     return float32_to_bfloat16(x, status);
 }
 
-uint32_t HELPER(bfcvt_pair)(uint64_t pair, void *status)
+uint32_t HELPER(bfcvt_pair)(uint64_t pair, float_status *status)
 {
     bfloat16 lo = float32_to_bfloat16(extract64(pair, 0, 32), status);
     bfloat16 hi = float32_to_bfloat16(extract64(pair, 32, 32), status);
@@ -436,26 +431,25 @@ uint32_t HELPER(bfcvt_pair)(uint64_t pair, void *status)
  */
 #define VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)            \
 ftype HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift,      \
-                                     void *fpstp) \
-{ return itype##_to_##float##fsz##_scalbn(x, -shift, fpstp); }
+                                float_status *fpst)                    \
+{ return itype##_to_##float##fsz##_scalbn(x, -shift, fpst); }
 
 #define VFP_CONV_FIX_FLOAT_ROUND(name, p, fsz, ftype, isz, itype)      \
     ftype HELPER(vfp_##name##to##p##_round_to_nearest)(uint##isz##_t  x, \
                                                      uint32_t shift,   \
-                                                     void *fpstp)      \
+                                                     float_status *fpst) \
     {                                                                  \
         ftype ret;                                                     \
-        float_status *fpst = fpstp;                                    \
         FloatRoundMode oldmode = fpst->float_rounding_mode;            \
         fpst->float_rounding_mode = float_round_nearest_even;          \
-        ret = itype##_to_##float##fsz##_scalbn(x, -shift, fpstp);      \
+        ret = itype##_to_##float##fsz##_scalbn(x, -shift, fpst);       \
         fpst->float_rounding_mode = oldmode;                           \
         return ret;                                                    \
     }
 
 #define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype, ROUND, suff) \
 uint##isz##_t HELPER(vfp_to##name##p##suff)(ftype x, uint32_t shift,      \
-                                            void *fpst)                   \
+                                            float_status *fpst)           \
 {                                                                         \
     if (unlikely(float##fsz##_is_any_nan(x))) {                           \
         float_raise(float_flag_invalid, fpst);                            \
@@ -508,10 +502,8 @@ VFP_CONV_FLOAT_FIX_ROUND(uq, d, 64, float64, 64, uint64,
 /* Set the current fp rounding mode and return the old one.
  * The argument is a softfloat float_round_ value.
  */
-uint32_t HELPER(set_rmode)(uint32_t rmode, void *fpstp)
+uint32_t HELPER(set_rmode)(uint32_t rmode, float_status *fp_status)
 {
-    float_status *fp_status = fpstp;
-
     uint32_t prev_rmode = get_float_rounding_mode(fp_status);
     set_float_rounding_mode(rmode, fp_status);
 
@@ -519,12 +511,12 @@ uint32_t HELPER(set_rmode)(uint32_t rmode, void *fpstp)
 }
 
 /* Half precision conversions.  */
-float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, void *fpstp, uint32_t ahp_mode)
+float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, float_status *fpst,
+                                    uint32_t ahp_mode)
 {
     /* Squash FZ16 to 0 for the duration of conversion.  In this case,
      * it would affect flushing input denormals.
      */
-    float_status *fpst = fpstp;
     bool save = get_flush_inputs_to_zero(fpst);
     set_flush_inputs_to_zero(false, fpst);
     float32 r = float16_to_float32(a, !ahp_mode, fpst);
@@ -532,12 +524,12 @@ float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
+uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, float_status *fpst,
+                                     uint32_t ahp_mode)
 {
     /* Squash FZ16 to 0 for the duration of conversion.  In this case,
      * it would affect flushing output denormals.
      */
-    float_status *fpst = fpstp;
     bool save = get_flush_to_zero(fpst);
     set_flush_to_zero(false, fpst);
     float16 r = float32_to_float16(a, !ahp_mode, fpst);
@@ -545,12 +537,12 @@ uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, void *fpstp, uint32_t ahp_mode)
+float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, float_status *fpst,
+                                    uint32_t ahp_mode)
 {
     /* Squash FZ16 to 0 for the duration of conversion.  In this case,
      * it would affect flushing input denormals.
      */
-    float_status *fpst = fpstp;
     bool save = get_flush_inputs_to_zero(fpst);
     set_flush_inputs_to_zero(false, fpst);
     float64 r = float16_to_float64(a, !ahp_mode, fpst);
@@ -558,12 +550,12 @@ float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
+uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, float_status *fpst,
+                                     uint32_t ahp_mode)
 {
     /* Squash FZ16 to 0 for the duration of conversion.  In this case,
      * it would affect flushing output denormals.
      */
-    float_status *fpst = fpstp;
     bool save = get_flush_to_zero(fpst);
     set_flush_to_zero(false, fpst);
     float16 r = float64_to_float16(a, !ahp_mode, fpst);
@@ -664,9 +656,8 @@ static bool round_to_inf(float_status *fpst, bool sign_bit)
     }
 }
 
-uint32_t HELPER(recpe_f16)(uint32_t input, void *fpstp)
+uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float16 f16 = float16_squash_input_denormal(input, fpst);
     uint32_t f16_val = float16_val(f16);
     uint32_t f16_sign = float16_is_neg(f16);
@@ -714,9 +705,8 @@ uint32_t HELPER(recpe_f16)(uint32_t input, void *fpstp)
     return make_float16(f16_val);
 }
 
-float32 HELPER(recpe_f32)(float32 input, void *fpstp)
+float32 HELPER(recpe_f32)(float32 input, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float32 f32 = float32_squash_input_denormal(input, fpst);
     uint32_t f32_val = float32_val(f32);
     bool f32_sign = float32_is_neg(f32);
@@ -764,9 +754,8 @@ float32 HELPER(recpe_f32)(float32 input, void *fpstp)
     return make_float32(f32_val);
 }
 
-float64 HELPER(recpe_f64)(float64 input, void *fpstp)
+float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float64 f64 = float64_squash_input_denormal(input, fpst);
     uint64_t f64_val = float64_val(f64);
     bool f64_sign = float64_is_neg(f64);
@@ -865,9 +854,8 @@ static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
     return extract64(estimate, 0, 8) << 44;
 }
 
-uint32_t HELPER(rsqrte_f16)(uint32_t input, void *fpstp)
+uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
 {
-    float_status *s = fpstp;
     float16 f16 = float16_squash_input_denormal(input, s);
     uint16_t val = float16_val(f16);
     bool f16_sign = float16_is_neg(f16);
@@ -880,7 +868,7 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, void *fpstp)
         if (float16_is_signaling_nan(f16, s)) {
             float_raise(float_flag_invalid, s);
             if (!s->default_nan_mode) {
-                nan = float16_silence_nan(f16, fpstp);
+                nan = float16_silence_nan(f16, s);
             }
         }
         if (s->default_nan_mode) {
@@ -911,9 +899,8 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, void *fpstp)
     return make_float16(val);
 }
 
-float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
+float32 HELPER(rsqrte_f32)(float32 input, float_status *s)
 {
-    float_status *s = fpstp;
     float32 f32 = float32_squash_input_denormal(input, s);
     uint32_t val = float32_val(f32);
     uint32_t f32_sign = float32_is_neg(f32);
@@ -926,7 +913,7 @@ float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
         if (float32_is_signaling_nan(f32, s)) {
             float_raise(float_flag_invalid, s);
             if (!s->default_nan_mode) {
-                nan = float32_silence_nan(f32, fpstp);
+                nan = float32_silence_nan(f32, s);
             }
         }
         if (s->default_nan_mode) {
@@ -957,9 +944,8 @@ float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
     return make_float32(val);
 }
 
-float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
+float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
 {
-    float_status *s = fpstp;
     float64 f64 = float64_squash_input_denormal(input, s);
     uint64_t val = float64_val(f64);
     bool f64_sign = float64_is_neg(f64);
@@ -971,7 +957,7 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
         if (float64_is_signaling_nan(f64, s)) {
             float_raise(float_flag_invalid, s);
             if (!s->default_nan_mode) {
-                nan = float64_silence_nan(f64, fpstp);
+                nan = float64_silence_nan(f64, s);
             }
         }
         if (s->default_nan_mode) {
@@ -1026,41 +1012,40 @@ uint32_t HELPER(rsqrte_u32)(uint32_t a)
 
 /* VFPv4 fused multiply-accumulate */
 dh_ctype_f16 VFP_HELPER(muladd, h)(dh_ctype_f16 a, dh_ctype_f16 b,
-                                   dh_ctype_f16 c, void *fpstp)
+                                   dh_ctype_f16 c, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return float16_muladd(a, b, c, 0, fpst);
 }
 
-float32 VFP_HELPER(muladd, s)(float32 a, float32 b, float32 c, void *fpstp)
+float32 VFP_HELPER(muladd, s)(float32 a, float32 b, float32 c,
+                              float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return float32_muladd(a, b, c, 0, fpst);
 }
 
-float64 VFP_HELPER(muladd, d)(float64 a, float64 b, float64 c, void *fpstp)
+float64 VFP_HELPER(muladd, d)(float64 a, float64 b, float64 c,
+                              float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return float64_muladd(a, b, c, 0, fpst);
 }
 
 /* ARMv8 round to integral */
-dh_ctype_f16 HELPER(rinth_exact)(dh_ctype_f16 x, void *fp_status)
+dh_ctype_f16 HELPER(rinth_exact)(dh_ctype_f16 x, float_status *fp_status)
 {
     return float16_round_to_int(x, fp_status);
 }
 
-float32 HELPER(rints_exact)(float32 x, void *fp_status)
+float32 HELPER(rints_exact)(float32 x, float_status *fp_status)
 {
     return float32_round_to_int(x, fp_status);
 }
 
-float64 HELPER(rintd_exact)(float64 x, void *fp_status)
+float64 HELPER(rintd_exact)(float64 x, float_status *fp_status)
 {
     return float64_round_to_int(x, fp_status);
 }
 
-dh_ctype_f16 HELPER(rinth)(dh_ctype_f16 x, void *fp_status)
+dh_ctype_f16 HELPER(rinth)(dh_ctype_f16 x, float_status *fp_status)
 {
     int old_flags = get_float_exception_flags(fp_status), new_flags;
     float16 ret;
@@ -1076,7 +1061,7 @@ dh_ctype_f16 HELPER(rinth)(dh_ctype_f16 x, void *fp_status)
     return ret;
 }
 
-float32 HELPER(rints)(float32 x, void *fp_status)
+float32 HELPER(rints)(float32 x, float_status *fp_status)
 {
     int old_flags = get_float_exception_flags(fp_status), new_flags;
     float32 ret;
@@ -1092,7 +1077,7 @@ float32 HELPER(rints)(float32 x, void *fp_status)
     return ret;
 }
 
-float64 HELPER(rintd)(float64 x, void *fp_status)
+float64 HELPER(rintd)(float64 x, float_status *fp_status)
 {
     int old_flags = get_float_exception_flags(fp_status), new_flags;
     float64 ret;
@@ -1122,9 +1107,8 @@ const FloatRoundMode arm_rmode_to_sf_map[] = {
  * Implement float64 to int32_t conversion without saturation;
  * the result is supplied modulo 2^32.
  */
-uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
+uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 {
-    float_status *status = vstatus;
     uint32_t frac, e_old, e_new;
     bool inexact;
 
@@ -1196,12 +1180,12 @@ static float32 frint_s(float32 f, float_status *fpst, int intsize)
     return (0x100u + 126u + intsize) << 23;
 }
 
-float32 HELPER(frint32_s)(float32 f, void *fpst)
+float32 HELPER(frint32_s)(float32 f, float_status *fpst)
 {
     return frint_s(f, fpst, 32);
 }
 
-float32 HELPER(frint64_s)(float32 f, void *fpst)
+float32 HELPER(frint64_s)(float32 f, float_status *fpst)
 {
     return frint_s(f, fpst, 64);
 }
@@ -1244,12 +1228,12 @@ static float64 frint_d(float64 f, float_status *fpst, int intsize)
     return (uint64_t)(0x800 + 1022 + intsize) << 52;
 }
 
-float64 HELPER(frint32_d)(float64 f, void *fpst)
+float64 HELPER(frint32_d)(float64 f, float_status *fpst)
 {
     return frint_d(f, fpst, 32);
 }
 
-float64 HELPER(frint64_d)(float64 f, void *fpst)
+float64 HELPER(frint64_d)(float64 f, float_status *fpst)
 {
     return frint_d(f, fpst, 64);
 }
-- 
2.34.1


