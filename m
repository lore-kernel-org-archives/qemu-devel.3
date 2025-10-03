Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D4CCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jKT-00058l-Aj; Fri, 03 Oct 2025 13:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIe-0002kB-6v
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:33 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGp-0006LC-Kh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-781997d195aso1820735b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511315; x=1760116115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Udj6PKMWss3gAj/aDsAeuXVpPjUstV9aXJRzk0zFyVA=;
 b=OMDfDVBKkGjCEgLZh7ELf01ZRok9qZfkXbEaSJ3RrFzPGgS3+HeoAcBbM858oXEdwn
 SUlu/MIng8I7P6nP3S+FbxQ9sPRgG2iOLXnFzMxExTUbO/uXdQGdIL3CjlKgtkAIVsfM
 FyOD3ElU8NojT5Z+oJX9//0WlhXBeHrGF/MJJo/X1qRiNT/JlpeOYWLQODeh6uYKuWZ+
 qVtfl7Umih6PJiFJbAEWMwd1nJ+bDSZgZ46/cRme872StC2o6+2m752QXWjRQC4N9PHw
 NPiyolKiaM8Kiha3y7UkjdqCxK13eiuP3GddFKyROFScQlRYL+AvmSxxkxQX+0XAebOi
 C/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511315; x=1760116115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Udj6PKMWss3gAj/aDsAeuXVpPjUstV9aXJRzk0zFyVA=;
 b=ocXD6Hd5KXtKrXjMLCkpqxgV/zLAGhj6hZvF1Dnhdnb7XQ4QRqMKfd+1nBhhc7Ve0Z
 O2ZRpKBuJDgKIt3CUzIKMYRGCRLZBUI9Md2a9VzfagWb8oFaMajC4Van0qCeaYa6wSzB
 aA2nYQeA65GTwaqcdu0WAJ14K2GTHXNbiclvwal1+x0Qz4Wp5ickIKPQECgcwOu1gPwV
 /2y/J6dKyNC7HSXtURfV13oRL0xys5jYeyLRk31+6AIceQe8xSsphIUsfr9CAtCqzo/O
 hJD6E0YeRU59HXSyuicdebg+uHd7Cg4JFiPg7ZNu4LsH0vI2XfwmbpBCq5qcos7QdzK3
 URcQ==
X-Gm-Message-State: AOJu0YyrH1jqu00p/nbeE34+t0wB4zCmy7TolutG+EnxCuIGp2XPvjyh
 UydQ/48URqznk5C86+eHKTN7HafHVf2chXElfrVU5VNW0Yw47Zfvw95Gx2H4QYCgOwLQbfSymvt
 snVoQ6QY=
X-Gm-Gg: ASbGncuh+UnKVOiJ5VHPWxEjnOk6HyFpdnC0qsoGFgw/EDRY9zQUbk73TU5aAFEQplA
 qoFseOaYGDkCQHkYiHY7pqzyDx1pwc206Zn6yQZhvlGkUyK0bhiseo7QsgNmVlqjltP9lzZWR0v
 blYxbvVjsAZ8GjY3K77VuJL9+FLgOWuy3GaFhNeOLl3fcIBYEI27iuRnFmOAxHQDZNkKhixolPz
 mTNbD3X8WBpDIxxbdy2N+2lR3guILpiU0jb1THNvhtuccIs+ICiIcUZqseNRRev5n+cLwjT32/W
 mfgveyz6M2IX42HIDLnbmazrDht7QtAeh0SI3AEJEb7nfF22RXqkMaLn673ocLquz4/tdsYEtbP
 cpc5Fh5whbwzYaa+/VqXwN7/EmzZn04SZ+ux5rYWCUJfRlBJrnPu1Bzfn
X-Google-Smtp-Source: AGHT+IHh+H6EHwbEgaDfxeRjMYrAkc+apM7slvgcMy5DvKqCdkZMBkryth9/MUiOJFWaCXBdP6hXHQ==
X-Received: by 2002:a17:902:e883:b0:24e:81d2:cfda with SMTP id
 d9443c01a7336-28e9a3068d5mr41436235ad.0.1759511314860; 
 Fri, 03 Oct 2025 10:08:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 38/73] target/arm: Add arm_hcr_el2_nvx_eff
Date: Fri,  3 Oct 2025 10:07:25 -0700
Message-ID: <20251003170800.997167-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Implement the pseudocode function EffectiveHCR_EL2_NVx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1f9042c7ef..5adb8bb33a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2229,6 +2229,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  */
 uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ffb6ab63ed..4d66143f46 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3903,6 +3903,16 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+
+    if (!(hcr & HCR_NV)) {
+        return 0; /* CONSTRAINED UNPREDICTABLE wrt NV1 */
+    }
+    return hcr & (HCR_NV2 | HCR_NV1 | HCR_NV);
+}
+
 /*
  * Corresponds to ARM pseudocode function ELIsInHost().
  */
-- 
2.43.0


