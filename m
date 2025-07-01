Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A22C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSg-0005jU-Ec; Tue, 01 Jul 2025 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSc-0005hj-9K
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSY-0003eG-VN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so2659673f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389673; x=1751994473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SK6A8clbB22J0MzblVefPn0yu0hM761EUxAP6vsqlrI=;
 b=W6v+t8Hqwzi0uPyPdMBoj4fE8Y3LJSHMsdQj1LPX3yHJOpCpdc3Mu+5VGVbLGNGD2X
 9pMH0i9ufAJ90TklGyUAbWbqQS1Pl1obphKPOOSgYTX0zVilCC2NJ6JWunWFOl0QK02f
 vRNPM8BTVQ9zn2Ee7XF5UModkBLx57oAjDwZjps6gnG6ie+R6tOqViHDVKIqEcwZpHqx
 7Y4By+y7b92JAMMAlEh/F5y0idNpLxN+lv/KxS2BE4Rd/65wQas0DJxPFM8yqt2IzSyO
 USifhILI0VfLwe4viDFNGeQaSPP91LMOBhkafEsptLYnCAwSVFyCVvs/6kFPsvu3UzaN
 TA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389673; x=1751994473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SK6A8clbB22J0MzblVefPn0yu0hM761EUxAP6vsqlrI=;
 b=vS6XD3FM+qq3joetHAD96aOY7lVVhVxoMWySlOeSI68vLNzpX5e48craWVDm+Muc9/
 7WkEegplW6CBaMTzhE3dUs51UUSeqsp9Yc9TEOX48+yZ/Y/s8AxPrYpY4DK9oBeNzu3q
 JKifQUwKUyROyPX0i6g9K+vwIGdfjI67CS7mLA+pUBsdMqQPCnX6sOilyayZ12LT6m9X
 On+7LiNnvjITtgTutUGOj/WcVjrvNg6KqdPwlhFdAWJBgKW1zVU1fUXU1WXkduo+tnKQ
 Hl4wphlq3gbcfwpYu/f5iIz2JQgT6cyNU2xE3rgNtC1ptCUZln1IgCNJYfKa0XzmN+EO
 qn1Q==
X-Gm-Message-State: AOJu0YyRU4Su3g1Xxh0KpBBSRZjfq7A5O4MLPKibXa9nGhqpKQ7rrih/
 lJagczaR1ck4h6gCG0RWulaSgXH/CqtdEJUPhgwcEsLuivIHqh18mhfWtzoPy+3yp5fjLMP4Xib
 k7bhX
X-Gm-Gg: ASbGnctDVgiojHZcX1sqzOJEtskgM4V/ZU97hzCwtbz4UpkPuKaWXFew7pWM+MNxjDv
 qU48HrB2dAyEzswjC4QHG2gXDkH/jZ1oRG62jFdIONkNYJ5GSwv9xhp8OZvoViDlNA/Fd/1Y1o+
 tzQ2S9Xe5yBxmOwBScDDLBLton1VZe135IuUNs23bkHd6mhg2sHKzHQwOZj/ruElaytvTiWVgHF
 mBMqNy/tRV0Mk/qZ1Xz0wULBJIU5DNXxCvVQblatIs/qAMPoH2JVv6dUH7AN75lsNW05hQ8lcM8
 kdYSR/AVC32lx0hjfCWW0XyMZieHqaqG1MvQTkJKKz90rfx/kfRZDIi9tIh0sphmyW3X
X-Google-Smtp-Source: AGHT+IH+nUKcV7dcFCdWh8V1SAwwkrk/oD/Hrb0FSK16CKo87eY9/stOHfAfAv3XL5WbDTgRl4V3UA==
X-Received: by 2002:adf:fccb:0:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3a9004801acmr13424825f8f.51.1751389673232; 
 Tue, 01 Jul 2025 10:07:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/43] target/arm: Correct KVM & HVF dtb_compatible value
Date: Tue,  1 Jul 2025 18:07:07 +0100
Message-ID: <20250701170720.4072660-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".

See arch/arm64/boot/dts/foundation-v8.dts:

  https://github.com/torvalds/linux/commit/90556ca1ebdd

Cc: qemu-stable@nongnu.org
Fixes: 26861c7ce06 ("target-arm: Add minimal KVM AArch64 support")
Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 target/arm/kvm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f36973a32eb..ebde4c6f183 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -883,7 +883,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     hv_vcpu_exit_t *exit;
     int i;
 
-    ahcf->dtb_compatible = "arm,arm-v8";
+    ahcf->dtb_compatible = "arm,armv8";
     ahcf->features = (1ULL << ARM_FEATURE_V8) |
                      (1ULL << ARM_FEATURE_NEON) |
                      (1ULL << ARM_FEATURE_AARCH64) |
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 70919aedd0a..426f8b159e8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -289,7 +289,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,arm-v8";
+    ahcf->dtb_compatible = "arm,armv8";
     int fd = fdarray[2];
 
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
-- 
2.43.0


