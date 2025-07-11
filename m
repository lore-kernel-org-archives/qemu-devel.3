Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B9CC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBaW-0002Qq-Gk; Fri, 11 Jul 2025 07:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaK-00029q-OS
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:33 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaJ-0004NJ-5H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:32 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a77ffcb795so18838251cf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752231990; x=1752836790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpS4F45tgv4WA5Fs6hkBjdWSJ3CkjaOSvCIGC5DQE5c=;
 b=kOFKEBY+meK2WAV7Ku+I12XM5HbW15cguIaGN+xNO7rTRjMQ2bacFLwgf6cSOKMJgm
 NAB77xRHrcboRix0O51NKPPDkRNW4JZmTcXzutgsfQn1NCLPgGotLpYH5HbTERNHdQhV
 FP44ejwZV3T7dGK9fkvECTOxKd5+BsVJtjnsjlex4UDgmMx1UY0ylGxNBckdJ124ip/t
 TLqwoPOkSkISA3Ih0oOSmpu3LnL8iCe9rLHibucOtTwwpSCZH3s1HGNW+pUZRlw+3Z39
 S6P1jFJdmlulqo+YW8A00/qHcS5xXAGu5StL2nOPhfDbmtBLEoh6c2bW0yBmLX8DPsnp
 NfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752231990; x=1752836790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpS4F45tgv4WA5Fs6hkBjdWSJ3CkjaOSvCIGC5DQE5c=;
 b=OJs4g2nc+y8JywxoIhr4ETraM2VOZ3dOJFC3UA0URbCam38gDoPBib0wcE2ujiydEp
 7he0quhHDROoqGvpd/ZeCyuOAsvPlIQdJAi/C0YEZ6B/Q2dru90oCIRz0HGVGdtBW7bU
 eciXg6GRv+sEepxaaKVHUzzN6uRPTTti9wIdstVmb4AmnhvXxg9HhFtn4XCypcYy2g94
 dBez+1vknajwGhHADU+RrMxbdg1URIVF9KEL9CgusxEAiPLYB+eb7PdElCwlbAYx2j7R
 RgyPS2kvMc1XJYIeJl1ffiVSIMCYhrGDAl9RzqoDknmOMRb+CIoLhUpXpiw/o8WzAwKm
 2Vnw==
X-Gm-Message-State: AOJu0YygIs4Zm2asc85+R11ufukD6fSaT2Hm5ezLNSy13sRwSeR928bN
 sO/rMVrAZaWI/eOSZ9uuev3d12el4JM8BeC+b5GWHUKWPCLLCkAEvN8eSkpwmQ==
X-Gm-Gg: ASbGnctsAaWjE5rpiq6WuRbWJmTw2Ut6uaDwyQHFAhnPMByEl6yDdSB5n6hGoZx3QgD
 trkxUp/UNqafVeH/OWiF5uyNekqLs49KSLvp3udluKb5rG5Q+ih3Zi3Xt010LGLjZ9/BApt9vxP
 9wzTIKRR2u65ZKvqXBl1zPb4vEtXfJUVN0FiOmwgt3sfCa0P1jTqMuCvUoQ/fMUVxrM18Ywl5VS
 DNSNJ+TARogLKCIpQVEDhzzV3so00mU7Pf3RLja94yLNohqAzjUWIwtHCg8PirJmH2ppK30b91Y
 8nJDuQ/kt8Wazbcv4Cm0LJlJ0aZ3EB4QqiKI5mUR0AHPo4/4GqnPEQ2fuekuWyN2cZZQlyUdtXK
 SqPluUz130ZddaIV/iyQ/QAkyN5eI0ht/4/W7sH2xVOeGz2I=
X-Google-Smtp-Source: AGHT+IHistfpRLyjBXk6h1GuatSvxoYXr9ZTmd9JaVU8aCLtFK1pVB1kr4EIyqZa7PKZ/H89wDEXnQ==
X-Received: by 2002:ac8:5a51:0:b0:4a9:a75d:3310 with SMTP id
 d75a77b69052e-4aaaf269184mr23342551cf.42.1752231989495; 
 Fri, 11 Jul 2025 04:06:29 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:9684:12c5:c8ed:6d59])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edcafb3csm20238471cf.34.2025.07.11.04.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 04:06:29 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 1/2] docs/system: arm: Add max78000 board description
Date: Fri, 11 Jul 2025 07:06:25 -0400
Message-Id: <20250711110626.624534-2-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711110626.624534-1-jcksn@duck.com>
References: <20250711110626.624534-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This adds the target guide for the max78000FTHR

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 docs/system/arm/max78000.rst | 35 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst   |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 docs/system/arm/max78000.rst

diff --git a/docs/system/arm/max78000.rst b/docs/system/arm/max78000.rst
new file mode 100644
index 0000000000..8ebd1f7de8
--- /dev/null
+++ b/docs/system/arm/max78000.rst
@@ -0,0 +1,35 @@
+Analog Devices max78000 board (``max78000fthr``)
+===============================================================================================================
+
+The max78000 is a Cortex-M4 based SOC with a RISC-V coprocessor. The RISC-V coprocessor is not supported.
+
+Supported devices
+----------------------------------
+
+ * Instruction Cache Controller
+ * UART
+ * Global Control Register
+ * True Random Number Generator
+ * AES
+
+Notable unsupported devices
+----------------------------------
+
+ * I2C
+ * CNN
+ * CRC
+ * SPI
+
+Boot options
+----------------------------------
+
+The max78000 can be started using the ``-kernel`` option to load a
+firmware at address 0 as the ROM. As the ROM normally jumps to software loaded
+from the internal flash at address 0x10000000, loading your program there is
+generally advisable. If you don't have a copy of the ROM, the interrupt
+vector table from user firmware will do.
+Example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine max78000fthr -kernel max78000.bin -device loader,file=max78000.bin,addr=0x10000000
\ No newline at end of file
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index b96a05a920..8a62a6f688 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -88,6 +88,7 @@ Board-specific documentation
    arm/emcraft-sf2
    arm/exynos
    arm/fby35
+   arm/max78000
    arm/musicpal
    arm/kzm
    arm/nrf
-- 
2.34.1


