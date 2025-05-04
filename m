Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D9C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLT-0007Wi-Uh; Sun, 04 May 2025 17:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLR-0007Vq-Ql
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLQ-0005Cm-DO
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2260c91576aso33276035ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395875; x=1747000675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4IkZ6rX56LKQaeRF12GcjWtnMJwwMH7mXS6+CURuUmU=;
 b=Af4ooutyageaA+AS8szEtxgGcs7sFYLyBiX4iSq3vxxCF9lZs0rc7aut5t7dhzCuUD
 jve0dFcm8ObnXuVTjHCng8lT8eG1C2EEx7EEkNRKE/5SpNHv0pMG9Q+XONXXQsQkrHPI
 eNyEJl+RGgszU2t8BjBLVntoIaKv9xuubX1jN2c7v8GGDF1X0CCKSXkf8UKmKRUTKi7I
 r3N5YeurCpa2KyrzEgNihHVl8ke8Pag6yQRPKUKwneOkwyfUV1qCIBsiVhfTF1qB7Rwj
 uivSX5vqWVTXhnxXKtYPN2Sy6R28rqh/pZ8lfi+eUAd+DqcKzhS3i+9kOZlxV2ONvTWX
 SGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395875; x=1747000675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4IkZ6rX56LKQaeRF12GcjWtnMJwwMH7mXS6+CURuUmU=;
 b=fDqxOoKfOjIb+sRk48gXHoWs0vT5Yvd5wGgnog0YbvgzFBwmrCDGY+BQcIkSzGjOBY
 WTNz3VDGsODOZ5UNDdX9WHz/Z34lZGtJxettKvOfPdaHKcHgK5IatW2XtwcW3J3tmXe+
 8MgINXTpQzoCWznVbW0Q07V9jBVQw3cEcb49sAOE1i7pz8AGXlaTLAbP+jyW9MgaOxto
 BW01+9lN8k/iraKWvrqW/p5pbJ2SjWh4LYSm+U2KwtZl8zMZbM0Y8QeJKJo/S0Vke1kC
 N2m2feTnXDgs9RQCnrJLOgP8F2DevMTfkMt0V4oOyB1AGbHbSlj85An0bKLZDXsrk7YB
 FROw==
X-Gm-Message-State: AOJu0Yyjb7sjULN/zAna/7Kq78i8TGqloVsvIDrIxOXvXLDIyK569h37
 5Iolc5e6gXiKpCXjmMZbWRnfI1VCghRxwDe+Eb0BVAfE7mAJt4fdqnkCGVZZePFVadj1PikdyOE
 KFCE=
X-Gm-Gg: ASbGncs1bhlRHZcOlZOr9syXYNLO6F02oJylbnjB9cgcUip7R+XavL5b4K22zqo+wep
 vwTL3GSoU8WRmHp0FZjV0RM72fYmhkMkAmeLOjfJwhcFEoU1hk8jLbOsL+KLDAhNsqVPk3yx5BX
 FBOk3cJJbsLZYfNXrM5eBTctVI2i5Fi4KEFhbb5OTihK1zlmpzLOoevvh0kq9DUVioQ8kFM26o4
 XleWBokH/nznjcseg0X4qO/Qqrr6Y2F8P1K6f/GXdZlROKOfk9JDL2tlR+F+WrWvVWrKcY3pMmR
 wT3AzVXPN909YlCecTeefgg4DM8tjUv6Nrf1BN+Jqr5ZKp5W
X-Google-Smtp-Source: AGHT+IH3Dy6ZWpC1LCQVSAT5pW0VCitpjDb+UBJtRpZwdsHcgCtkN8WOEsYnwb/qSI0lPJ99iNC9Pw==
X-Received: by 2002:a17:902:e750:b0:227:e7c7:d451 with SMTP id
 d9443c01a7336-22e1eaa4478mr76337595ad.29.1746395874851; 
 Sun, 04 May 2025 14:57:54 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:54 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/i386/acpi-build: Fix typo and grammar in comment
Date: Sun,  4 May 2025 21:56:35 +0000
Message-Id: <20250504215639.54860-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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

Fix typo and verb conjugation in a comment about FADT initialization.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a332..b5836417a0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -139,7 +139,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
     /*
      * "ICH9-LPC" or "PIIX4_PM" has "smm-compat" property to keep the old
      * behavior for compatibility irrelevant to smm_enabled, which doesn't
-     * comforms to ACPI spec.
+     * conform to the ACPI spec.
      */
     bool smm_enabled = object_property_get_bool(o, "smm-compat", NULL) ?
         true : x86_machine_is_smm_enabled(x86ms);
-- 
2.34.1


