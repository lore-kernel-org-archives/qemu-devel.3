Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1iF-0002uh-Mw; Wed, 19 Jun 2024 16:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1iE-0002tY-9o
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1iC-0001pA-NU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4217d808034so1765265e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828118; x=1719432918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfBlhlKJNBiXVGnmXKNokqgloJowB7odFyWS6IGw2Bs=;
 b=aFmzLnTf1sgzWDGc/xHZ7dCqsW0Blsk7zE67eTOskRDFH42f3pc3pOyvhcyy92bKvP
 AXjTV30OU7PloIfmcH4iz+QfkBEVVIpM6AyweqysaKxIpGEEqMzaqQ8ejWlwNVL/3P5I
 xXVyKG1ZpG5GrzRI9Buin1v6BIv/qcYMT89AJlf/axc6Psct2NcAY/V+QAaCQR3WQgTt
 mqqKojD0gxpNzrIl66vq2A2VQFeW1u4eLv5/9A5qrotm74ndyn/FzQ5H3AnlojVRfyWb
 4lzzwm3Pdlo4l9uEq95cH5Wo1fMQuToit1ySDyzVYvymbp0Z2hnnJb5JxYxoO4xwOcbK
 mbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828118; x=1719432918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfBlhlKJNBiXVGnmXKNokqgloJowB7odFyWS6IGw2Bs=;
 b=QdaYQnemUBfdIdKJPxkTwi/Z31py2OayuGfx+bH10aOtmhJblrbPrPOUxm4sqFhxdl
 AgAVjdIL9GGYqfXMLlXSL8VTLzSxfr0PeafvZ3GHPaqiiF+/uSLBPclXt8IvPgNCcHut
 t0dSUqGeaNbq6xKoIx7xw42Km+Z/z720uNFaTLm01aAw0ldhiLRTx4L8S71PcQJh2c5U
 86ZotzookOFqK60isDiTNBDLtSXD2RwoWlxUFQSMUriLg4p3Ga3v9V0N6nYBM5n3zzGA
 g/ys/bUOUHqt6hqasX9rx744FdJuzrfDSUMW4+Xsm1eWpzJpPbS3HWc4UyI6pwdcRwkv
 i2xQ==
X-Gm-Message-State: AOJu0YyYUCZN/1OGPvEkIMkT/EEmA8jS0VNwnamFozwZEXqarqDDJJyN
 jwqGoIu9imtLjbRLIjnoYS/Wvnh65SahbQhACRv4xlB0OJzEz9T4Hqj71ka+etj0JMIyyX/QQOS
 HoyQ=
X-Google-Smtp-Source: AGHT+IFwh4Cg8fzxeEz6lV14WhbpQxy3K3e724v6u9ffOUFEWfQZU+O8YDORo10T7H+BZi+vCZIZnQ==
X-Received: by 2002:a05:600c:3503:b0:422:1a82:3ebf with SMTP id
 5b1f17b1804b1-4247529bdb6mr26227915e9.35.1718828118374; 
 Wed, 19 Jun 2024 13:15:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-103.37.6.162.tellas.gr.
 [37.6.162.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101aac6sm45623235e9.0.2024.06.19.13.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:15:18 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust
 in arm virt machine
Date: Wed, 19 Jun 2024 23:14:02 +0300
Message-ID: <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convenience patch for testing the rust device.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..f33b58ae0d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
+#ifdef CONFIG_WITH_RUST
+    DeviceState *dev = qdev_new("x-pl011-rust");
+#else
     DeviceState *dev = qdev_new(TYPE_PL011);
+#endif
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
-- 
γαῖα πυρί μιχθήτω


