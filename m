Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17277C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiF4G-0004mG-HK; Wed, 12 Feb 2025 10:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF4C-0004i0-Oz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF4B-0000t2-2R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so26651445e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375660; x=1739980460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Vn4jQMdtR/P+0AJ2AwebyY6ZejIqv+DTnLMTFiQonU=;
 b=ITfPq81i8XHGdMjmihXaRggNwmRwm4tQlPCo0U0LIb1AWy/3L+3RxfzSsb8jBMll4k
 HIirzTofHdnS0ET3yhL3cikjxDRlNVScQeSlRBqtiyb9nn1XQ0bVccx0oyOLG1ijEHB3
 Fv1xNLiwNjXjs2+bL54V641PleN2Bl2YWBa+5FhkNooAVdy92GCU03h9FpjWDxzjTdb5
 d4T6SIMx1a2XMAOmFvxOvvzNF+XlOZXYpr2zeKD5TKZ2PJMnXSmaAEGvgwucUOsHW8wY
 2RKuefs/E+w7f+v1pVM0O2IqS/aBMbrreVZNYEFSG/1vk1u2QwMcgURwA6kB5uyLfKaA
 yZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375660; x=1739980460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Vn4jQMdtR/P+0AJ2AwebyY6ZejIqv+DTnLMTFiQonU=;
 b=P2tfgJvO8KoNf+K2U4Mg0clvfFg9Aa+Tej3zyG9aB/LCl1tmQpWQg1N+UOdry6KaF5
 DdIAW5romwTwZ/STO+O83OV3ExX0xsQWtprEhaPXyPbpjUBsOa6MfcunBBUF6+QD+VPE
 w6dU5m2ivwRBTntAxMO4pYujgI0lKrYK9SKa51UqP9UkR70n30Nzpa4A8RzeB1QXerCY
 gXm2MGcFt3EkPyIVgN+ir3Eh+m7UNSQUHktDU2sc+HgdSWuEb9RjBfpe7xAJs3ToodD4
 XmBNXT+8ZHfbO1wULw6RF7tsKx4vbd+0+MXznuGAP2fuEvYkAR36CEUSUQewWHCOpcrd
 X9Pw==
X-Gm-Message-State: AOJu0YwJAuj4h0NvqqUySgf9rhd2ojz9g0WJu6iDcbAc3TcRYXjFQXpO
 OnjA4co5b1bXTM+v3ezEVSFBGCDqSxGSP/Xt1tJCDiqilfm8amaxpf/FFxRc2Ey80NQwhoA3leh
 BfRU=
X-Gm-Gg: ASbGncsM1fpip4roXwzTunZKB7x7ADN3lNfJm/psZa7L1FxL1sK0l2Le7Egh9bfkHrG
 xYrSU4iT6TKdnJAZTb6CWO0RsVM1QAB4tHNs/yGV1Ugx2XlH5gVtzXxbwS9fEmMZY5pRJM4fqh/
 AIMe57UG3EQBJl3hc3HJ5ZUyv0X+2Dmbe0k/h9EWHHa3k6tFn3R4Conh3GtzCcZINxnwddcRiVk
 vSWI/nNClOn6A91YPcEj1LVHPjm7Yl/t3o9CpsYLUiUjYhbbkmMxS1vED1vQGZhzBOomY8BKL3b
 3tS4ymil0VWz4yS0e+wzUYZ3MNTexy3/kfFsezJYVX1mRqW8ZMB8ZlJsFlikR6uX3D1xLXY=
X-Google-Smtp-Source: AGHT+IE5+3mHZzXGyHF6hc/b9GgZOvIwZYOSryJ8HlXMy0kaC20RfIAuXTPjz2VcxKyXStF7hos2ug==
X-Received: by 2002:a05:600c:3b84:b0:439:488b:985d with SMTP id
 5b1f17b1804b1-43958165f46mr37758345e9.4.1739375660178; 
 Wed, 12 Feb 2025 07:54:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055c7esm23921045e9.14.2025.02.12.07.54.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:54:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/29] hw: Make class data 'const'
Date: Wed, 12 Feb 2025 16:54:08 +0100
Message-ID: <20250212155408.29502-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212155408.29502-1-philmd@linaro.org>
References: <20250212155408.29502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When the %data argument is not modified, we can declare it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210133134.90879-8-philmd@linaro.org>
---
 hw/sd/sdhci-internal.h   | 2 +-
 hw/sd/sdhci.c            | 2 +-
 hw/sensor/emc141x.c      | 2 +-
 hw/sensor/isl_pmbus_vr.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 5f3765f12d2..9f768c418e0 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -322,6 +322,6 @@ void sdhci_initfn(SDHCIState *s);
 void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
 void sdhci_common_unrealize(SDHCIState *s);
-void sdhci_common_class_init(ObjectClass *klass, void *data);
+void sdhci_common_class_init(ObjectClass *klass, const void *data);
 
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 99dd4a4e952..1f45a77566c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1542,7 +1542,7 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-void sdhci_common_class_init(ObjectClass *klass, void *data)
+void sdhci_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index aeccd2a3c94..33c1bd330fd 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -265,7 +265,7 @@ static void emc141x_initfn(Object *obj)
                         emc141x_set_temperature, NULL, NULL);
 }
 
-static void emc141x_class_init(ObjectClass *klass, void *data)
+static void emc141x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 304a66ea8b0..c60282cfe77 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -233,7 +233,7 @@ static void raa228000_init(Object *obj)
     isl_pmbus_vr_add_props(obj, flags, 1);
 }
 
-static void isl_pmbus_vr_class_init(ObjectClass *klass, void *data,
+static void isl_pmbus_vr_class_init(ObjectClass *klass, const void *data,
                                     uint8_t pages)
 {
     PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
-- 
2.47.1


