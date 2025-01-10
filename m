Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043CAE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTp-0007ie-CT; Fri, 10 Jan 2025 11:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSt-0007GS-UV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSo-0004DD-MY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:25 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso16641315e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524940; x=1737129740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f63ecg0nif+jK+DGCLVe+u7mEjni/luwZDTHSRxVLnk=;
 b=K6NlI/3LfsFjXpj7n1dvjxw9nJ0wR6RQ6h1cmakTekEknBKEBgY2mG9wX9rrN9AKaF
 BhgQd+o5lY6j/YuTpyKopSTBpfEwN/ZOiB942Yq+Xow0goFaM3w/eY2wHXC1L5aNbxZa
 JQDQ8gZVOu8mQO/MxiuBKQnJsgFiS02EVLtYUmQLSlKKIuCqnf/bNIFSKmYYSQICvqPs
 YhKoq4ky/odDjektYA4KZBneeP+E8YJxyO4xBLOcH0j4vaJfxvkW2+HWWjjHFiCLBChB
 mRq9MmNRIB2zvPBd66qk5kmqZTQa+WDPbxaFCybDIV5sy8mKwL6MXFlLq8tk8WZsCkGi
 sa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524940; x=1737129740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f63ecg0nif+jK+DGCLVe+u7mEjni/luwZDTHSRxVLnk=;
 b=qVAElYiYMhaNHeCrUcGi+NcA9ZpWZYXLRTsPVdX5+FrGp22ZdvwxiULGRKSvxcKcv0
 na92yroUeHSx5MEFE2MgkWuCS1E+hw0WrKyJg3QpG03/0jrV7U+u+E/UL+b/gYw7zHUA
 /UnJcDXdGs4htxTmgGfORfOtsAlLUA5NUQreMJUF/kkvGURjoyBQmjtEQteE/hVEQR1s
 47WrLx6LfF8vaJN1Aewvc1DxmRA7TKnM7m0FqGwTnvH/NbFvXf90rV2x4R+EsczepPZ0
 7Vfems46pwxv9Z88SbKTAOB4TpC8Iqp4rCWPWlIyT4KPiSwbTEfVBTmO4S9krt6GcQHZ
 h8Zg==
X-Gm-Message-State: AOJu0YyDvLbNyjM8momJ9dnCgB7T9D6O1i4VAYFFjk4gq7xgEopXx6Nx
 Uzt786Xm8sNb5YB5k+RrD3r2rAHtHOHLmPZEDdrp9ckWjVx+DoWpn/e83njpcVYyeYFHmBkbvAd
 cSJY=
X-Gm-Gg: ASbGncsL4TJBj1WCZgXTa1WldOYpQBRGhAbFq5YxAmqT9E0L1FjhwP0QvPB9ea/IiH+
 reiTVpCSacKTnnAlhozLL7QlLQAAQNNe7FcW5Ymb8HP0oytiRZ1mHhabHBAmoD6x69m5mC/no06
 cab3VY/XougsQDMVhHXu3HgSWrQHj+6v7FpO4JdeZehmfEoeBiUQGZ+zrMtTbxAvS5C/onlXMQN
 E1S7d9bXl5jZANuPcSJY/PpJELTLMpk72gH4REQrun7BxxUmIbZoVa3wdstaqz3q+hBxZMOHqq2
 S+EfjmthYFV0NGNU/rbUhZVOmsuyvLo=
X-Google-Smtp-Source: AGHT+IHtxnjxgKA8nlpo7bMxA67/vxmyyp6LnO8nbiySraPe1AGbiiavtg5PUWrfIks1ezUxeteojQ==
X-Received: by 2002:a05:600c:3b02:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-436e26d971emr94638765e9.23.1736524939809; 
 Fri, 10 Jan 2025 08:02:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da63eesm90389005e9.3.2025.01.10.08.02.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] hw/arm/stellaris: Remove incorrect unimplemented i2c-0 at
 0x40002000
Date: Fri, 10 Jan 2025 17:01:58 +0100
Message-ID: <20250110160204.74997-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

There is nothing mapped at 0x40002000.

I2C#0 is already mapped at 0x40021000.

Remove the invalid mapping added in commits aecfbbc97a2 & 394c8bbfb7a.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7c9e7e6c15b..254f7a234bf 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1001,7 +1001,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
      *
      * 40000000 wdtimer
-     * 40002000 i2c (unimplemented)
      * 40004000 GPIO
      * 40005000 GPIO
      * 40006000 GPIO
@@ -1356,7 +1355,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
     create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
     create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
-- 
2.47.1


