Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD23C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sZ-0007GU-38; Sat, 08 Mar 2025 16:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rV-0005fK-1l
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rL-0003xr-6u
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so17392815e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469845; x=1742074645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHs4NJBzCmz72Qc75GTHjI0bhqCkUEPaPLmnD21pmMM=;
 b=hPCBLUfYPgeO/DLjboYd1twX2XWTPpbzUf/PHAYviZlZ8ePn7mFBrXubNQdmojpumT
 CRCdo8WtmuRkyQkc59uArFEk4Dggwp0RuneZw1wCgBjR2KH0shvOEaWJ9Pnwa4cEnpSZ
 FE2B/npBHq+3SscQ80525oKvdNu1GNcosUWBP4AdQYngc5kONGr+FgcmrIj6f6o5Wrm8
 ZetW4w2rmKjNUfnlr3/WVZn0JTYR0CZhKjggZZrg58W5aKAvoqJG4Ewv2puDNiubtMFe
 cLP6JT2hbO48m5vaDfCwvrcbaZ2rYshxjnCCueqmZYT5nXy1PH8KyJjP6tkFO4Ql+d7q
 XmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469845; x=1742074645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHs4NJBzCmz72Qc75GTHjI0bhqCkUEPaPLmnD21pmMM=;
 b=Aw83QLFW7FDzXFSfgSDPAfS7lKK8H2mj4Lf+Jfd27wEmyDl9PP2B0Sodo7FKmnX+0o
 LeZ8oQ7tvSqBkV6l6EnwHYxuvKiGzgAKjewLfWu6u606tzZCf//n/AJE8Sae6M1g9hlr
 7QSWxmNRH8IoNqh14WX7RozhdAj7GIC6dtBAPHzR08deMVkKmW6Rf4sR7tFw/9hwRHnM
 a5oygwTgzK24XH0Z5SRWI+RmqAdkDhhl8mMK8UvijGfJmS8OZ6/4aSSGzZ9HJ6QuD/UG
 3M6q/uk1koE2Pw8VT4lhXs7R8NG+dxfJjQwtxq4KwpN7ejZxvDSfj8L5F4rCZj6dibTq
 zvQw==
X-Gm-Message-State: AOJu0YyCzIVTGkJFVLhPsNlb0P/syMt7JihyLMbUjmGUtLBHSAFJU3VB
 64/A/cwRW+AXgDlUl6GLnugMV7SBOfyTelvqDP1RFI7FiKLLzhvmOLjF40eEydhlfDMThpCijis
 LWhM=
X-Gm-Gg: ASbGncv5kjklRgBOewjmRpjXlKsZ9AqKYuRrUbPk7dnq+k1fqT6tWSkh9kmA84yimQh
 cG0USeTND/9+HY+esS64p6uJW8vr813ZdKtcjqAMnc18L8s/v7zWT0d4Ym9eD8ctgUUL/v4FRHV
 J7zzNxFIg+rQR0MFtKC61VE2hxPHgf077nxTe3CJHxYhvfUedPlPhYdfFhgwak8s+6dPc8g8doQ
 s7PHCnBj1OMo8prafX9twAccYOO3bSKNXOIUVSb7RnWKWydLWJk54ykVgcyiQJndUi05HVoPqN/
 XCXh9jzPBWJ5c7vIINEIfh9D9GWCs/9PVOErR+hUMFaiZhMnlgDSi+7QUnGVoXJBtqTseSmDw+m
 hEJa68+aeDKW7wlLaqrQ=
X-Google-Smtp-Source: AGHT+IGwXR1wra0TM+Bg4xLCAmVHTQ5nhkXDSC/470LZXydxPwzuLM/Y/a64ByLtoO4hlYLL/xKqyg==
X-Received: by 2002:a5d:64c3:0:b0:391:31c8:ba58 with SMTP id
 ffacd0b85a97d-39132d16dd6mr6040899f8f.10.1741469845617; 
 Sat, 08 Mar 2025 13:37:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d2cdsm10044042f8f.57.2025.03.08.13.37.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 08/14] hw/sd/sdhci: Simplify MemoryRegionOps endianness
 check
Date: Sat,  8 Mar 2025 22:36:34 +0100
Message-ID: <20250308213640.13138-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

While little endianness is the default, ome controllers
might be only implemented in big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ae485f90dfe..a2e7162e289 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1444,20 +1444,10 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
     const char *class_name = object_get_typename(OBJECT(s));
 
-    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
-    switch (s->endianness) {
-    case DEVICE_LITTLE_ENDIAN:
-        /* s->io_ops is little endian by default */
-        break;
-    case DEVICE_BIG_ENDIAN:
-        if (s->io_ops != &sdhci_mmio_le_ops) {
-            error_setg(errp, "SD controller doesn't support big endianness");
-            return;
-        }
-        s->io_ops = &sdhci_mmio_be_ops;
-        break;
-    default:
-        error_setg(errp, "Incorrect endianness");
+    s->io_ops = sc->io_ops ?: (s->endianness == DEVICE_BIG_ENDIAN ?
+                               &sdhci_mmio_be_ops : &sdhci_mmio_le_ops);
+    if (s->io_ops->endianness != s->endianness) {
+        error_setg(errp, "Invalid endianness for SD controller");
         return;
     }
 
-- 
2.47.1


