Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8060C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82x-00040r-Sd; Sat, 21 Jun 2025 19:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00022w-9L
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82A-0004uP-TF
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2101846b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550045; x=1751154845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZSLBhgJh7gyAPJ4SzRuq9SK6xpy7DpbA9oPtrsNHzU=;
 b=rUUcSTVBR4PI0mBGUpcUflbONdPehYJIB3C2qedOU2hVbQ+MPcd0WZTyd2qP2zNyOJ
 WGVs0lFuheMneIB3Inj6TVZqrWaEv0/dCeZipTiGkIAEGKPNNOuNI8Lx4LDM+8ZszZpZ
 6+//VbLGzILGpyDtzxrU3ZpSAsSKIXNLaBSgIsI2u1fyfqJx24ZG8MELfidpvuQl/ORt
 hOyeN4Qx1Gu4+Qo2IdJ2RalMz6ZnazEeEYdQOABOHrEpIQkNi1tFGNMushkTlmGd3/3z
 J9NnhqV7N++0MAUXiRv/mZqSTrsPyt4x2pk9SHUTbd2Wz4uqRTr0wWAfF/vsz7+wjz+j
 U7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550045; x=1751154845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZSLBhgJh7gyAPJ4SzRuq9SK6xpy7DpbA9oPtrsNHzU=;
 b=cTy3un1vot86+T28DsyeWu6rqL3XpID3eO6iH7I3E3G+MUYMvKvVCTl/F/rYtIoPlE
 rgF/p5HZo4SoJZLJtUnTmOMZPUsTnu9bXFjHhaCm3RTSDlIAyquRQqndnDgNn4l6quk6
 DXgFF7n+php5fjegUu+EQjRr+sp7IJNk0QAW5YFT6Ok6LLHTFBUH/4cFtIV9LY23KKx7
 ue9R131NrdRW003IrD4qjFIC2qb7320BL/9V32jSb8jjkESylJPWwrMQUOI7BO49/sF5
 2gVXpQyl9FZdKhCtQYtG2ELPmyQOPlvkn+fxFYU/Zh843R3DVKNadgm0LLyseDDzngcS
 Kehw==
X-Gm-Message-State: AOJu0YwKrAQnOZBUfw9ix4bIfvj8tDn32au7cr0PV6gP5EbM9jDGZfA1
 cd0YDlEoXv4Hx5BOktlK/z4EXpnP0ytD3p3Xt4mXU7tpX6ZQ/TsPSQBPR5Bg92kWrs7UNBURnQ8
 tRO1jSLI=
X-Gm-Gg: ASbGncvt1RFXG7nJvy2PG8sHWSSxu+0rTrDjPwfqlhmKmqh37tGVupVdfJFZpbHSY5Y
 zv0MKkICvTtfLMmIxSqJ8+0orZMEj6faZPrqKUQxABHkeAad2GvMPiW68hHDulVpaYh5cTi1GOB
 XQEhYsYBcJCtEWOhKCUmsiUeYIKhCJBHj9jZ0OxuAZO+C0VeI5mhCmeHWhM3XgBgs81c/bOM+4L
 17HmMXpp0W1stiPQUle+I3GvUARqo8U9EyIkEihqqoba2yxOLMf/lzBtpxUV87gqx6hdjYUvF5N
 9ZQdIOFA24S3BCmRCmgIdNgjaGh1rFw+GksQ77/va9I+4GMv0gWLG0asbI1/VJ26EIdsVofULvU
 4Q1TCcMx6ylicW36Pmq/l
X-Google-Smtp-Source: AGHT+IF8FonP2Jnr/sK9zO8esNRCjnWS8dsGXIgQd9ASFZXHFW7sQteiFZMoINLdQ0aqBZv734c6hA==
X-Received: by 2002:a05:6a20:729d:b0:21f:5409:32f4 with SMTP id
 adf61e73a8af0-22026be01f0mr12517044637.8.1750550045550; 
 Sat, 21 Jun 2025 16:54:05 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 041/101] target/arm: Rename SVE SDOT and UDOT patterns
Date: Sat, 21 Jun 2025 16:49:37 -0700
Message-ID: <20250621235037.74091-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Emphasize the 4-way nature of these dot products.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 12 ++++++------
 target/arm/tcg/sve.decode      | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 867acb36ec..20b73cd572 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3395,18 +3395,18 @@ TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
  * SVE Multiply - Indexed
  */
 
-TRANS_FEAT(SDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4b, a)
-TRANS_FEAT(SDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4h, a)
-TRANS_FEAT(UDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4b, a)
-TRANS_FEAT(UDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
-TRANS_FEAT(SUDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sudot_idx_4b, a)
-TRANS_FEAT(USDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3a0ee429a8..bd06a1bdf0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -851,10 +851,10 @@ CDOT_zzzz       01000100 esz:2 0 rm:5 0001 rot:2 rn:5 rd:5  ra=%reg_movprfx
 #### SVE Multiply - Indexed
 
 # SVE integer dot product (indexed)
-SDOT_zzxw_s     01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
-SDOT_zzxw_d     01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
-UDOT_zzxw_s     01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
-UDOT_zzxw_d     01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
+SDOT_zzxw_4s    01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
+SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
+UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
@@ -873,8 +873,8 @@ SQRDMLSH_zzxz_s 01000100 10 1 ..... 000101 ..... .....   @rrxr_2 esz=2
 SQRDMLSH_zzxz_d 01000100 11 1 ..... 000101 ..... .....   @rrxr_1 esz=3
 
 # SVE mixed sign dot product (indexed)
-USDOT_zzxw_s    01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
-SUDOT_zzxw_s    01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
+USDOT_zzxw_4s   01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
+SUDOT_zzxw_4s   01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
 
 # SVE2 saturating multiply-add (indexed)
 SQDMLALB_zzxw_s 01000100 10 1 ..... 0010.0 ..... .....   @rrxr_3a esz=2
-- 
2.43.0


