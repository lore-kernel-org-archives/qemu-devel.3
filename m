Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICz3-0002Td-P5; Wed, 29 Apr 2026 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICz0-0002Sk-1w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICyy-0006ZB-9k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso1883585ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777500131; x=1778104931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSCkSYg+gVUI+kxKRbjdbanWG3cbWKAj2Z7DGHe+Yco=;
 b=yLtM4+oD4hGqSe6/eZl03D9BOjo6yOeEaliBQKA6hpimzHkroPiQQOApmDnRF9lm0I
 jB18MCrGJsXeARSwmxDBJYnJ1zqzLrzMyg0thBAkGixUHTxtSGKCzaf1jICLgEIPZTLF
 EdGs7arfCBfITsLL7qMPRXfrcKMKyRBZaFU+g/rRiIiSkqMLNS7bDT+6gKmDYLci32Sf
 TF67SJP+/3tD/uZxCGcBQREr0NXq0FzUE03egIroEhWNHFt2kTpGTTzJXaSwO6MmY3UU
 o1kd8dcRLAgNNAt5n9T5cIAuazHjO7iDrJwqoYBeRfzdlhEvAn71j2yiHucTEoVWO6QV
 h8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777500131; x=1778104931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cSCkSYg+gVUI+kxKRbjdbanWG3cbWKAj2Z7DGHe+Yco=;
 b=L/AHndMxlYBL8qHEF3ktD+5WTk1wAiB1GTQ+waGMY+v7KAeNFXRFHW1Eh4LpC8KB7w
 HrPV1zDRJdMgOspShpYMDujxekJJui9DsT5yvtSxj8fi28O8ywCTSWi+dYSD/dL7I9CL
 Blbv6edgs+h4+Wap+bu9ZFTYrnoeA1qwOgvkj8woCIwZhqnjhg4iFhNgRPKOnO/EIXE/
 qRyfqDcs5U9nvnt6gAWQbbJRyYIbQCSWxFphoKy7Ca1KZP61E2alNFZ238hvrhAanaUJ
 QWciPNjJkC+/xWWOaq8hzdVL8HmxlTvGqaks8JUvnGH9EqKsTjP2m8x+kMFoq0toCLQa
 w8LQ==
X-Gm-Message-State: AOJu0YyY4+6tfQbjTV2OWl5SIMRREaGty8M9avKghSDUg34N5fwiOHEU
 ZfGu1QIRRpndnyq5jJW4VxuA9rIKA7/kG80pnaX+/tnFHqJ72nnpBQGYqFDs4hsi/Ui1DZFw1O9
 sfp/pDR8=
X-Gm-Gg: AeBDietll4okicRH1H2zl8lvlS16KTVTg6o+cAzH0j5CHWEBMBBbceoJrbAzGaz+KJZ
 p0/9EWGqdjTzLic2aPuHpOx+1ZwycOvtB0AQzSyjynXYTZpbXSbIjygitCOAU0Wm9SvMESPxDg8
 NAzFz5drdvuaODc1CTj6nHO1NY5zVpKRWfX2aKuIcixP51D9n+EvAvM/wpJMd9EZTDojrUVV3dy
 hyzux2qZ39RRaX1ecSqTK8Kaoczk78chQHDJLL595D0yubn9lFai+tbNJDDhyw5tc2mk5xSd93R
 BYXbwjRFSOX9QHrHdJ/PLHo9T87drJ2NJ//fBbgqbhYved00WQam7ROnHJem2kLKFvYkxGIpxIi
 fbPXuim6ainxYfTW/8xDaasXg3svhOo2ciSCPELktTjzsYmQ0GpWpK5KUqJpZpdQiVo3T0Fs/zL
 5xdS2p9eqL6aNiz7Ch/sF3I4T68GM7ccxjLrH8BXM2ayr0fbbJnQs=
X-Received: by 2002:a17:903:24e:b0:2ae:5eee:7a5 with SMTP id
 d9443c01a7336-2b9a231de9dmr1920915ad.12.1777500130239; 
 Wed, 29 Apr 2026 15:02:10 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895ca58sm32162095ad.60.2026.04.29.15.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:02:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 3/3] tcg: Remove unused tcg_gen_vec_*_tl() API
Date: Thu, 30 Apr 2026 08:01:55 +1000
Message-ID: <20260429220155.24546-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429220155.24546-1-richard.henderson@linaro.org>
References: <20260429220155.24546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No code uses the tcg_gen_vec_*_tl() API. Better to
remove it now, since to compile as translation unit
files once we need to avoid target_ulong uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260423101904.36131-1-philmd@linaro.org>
---
 include/tcg/tcg-op-gvec.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index b0a81ad4bf..d82ba6dfaa 100644
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
2.43.0


