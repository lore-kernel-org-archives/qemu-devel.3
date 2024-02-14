Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0CFC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7ao-0005ot-7k; Wed, 14 Feb 2024 00:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7am-0005oc-WD
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:57 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7al-0007pZ-IO
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:56 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e09493eb8eso353186b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887634; x=1708492434;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AMJKf0v/M+FFicTJu/HiSNXQGXhiRqdJXUW8dIKkkgw=;
 b=ZdctagRL7KFhnweQSnfiDEr91LJucWbw1BetMw7UHAghBNSqIEfYbOxghtCWryqop/
 fvXQB3ZAI7yHdSk8FDd5KY8mCuG3h4NSM/g0qlb9BJFOCU0/SqskAMlRk1IujZt6shli
 caykxWGT6OxYDSsjCikAvl4JPXikI07MkkQpKGLzQa+bM0pA2WUe9Zl0l706ua1ZQlbh
 Y4ehN6cfWjX7OtFHzW8Z0kRQMv3YHtkIIKPdLrq3a9p3c8tGLXVBN0X7qj/APc7Yar3K
 4BZMvQXXIOTvZDuUItXLIzRj7Dy/AepoxtJGQfPHmwdSQmx95RS2i+Xp0318Q/ZwcRzD
 gsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887634; x=1708492434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMJKf0v/M+FFicTJu/HiSNXQGXhiRqdJXUW8dIKkkgw=;
 b=IWOsf5y0byTUVRCZZxlBynEtOdGzauHzGRB/NZJobZRtPi2EpIMsFXcaozuzteLHzZ
 GH2K2IZGUUX6sozX6c+GVlgkFh6ScK/GonbfXmsR/GIeXRxLGwTIH9YKLxFLTmbnpvvK
 RPg8nkOCqnSgLFh/DykdyjaP1p5hcLzDetyhrK9o98P9XwgAkRTLvFX/15cVSYKWRAWk
 62Cwq2vaPWkicdEDPSFFCUT4zFpdPx2Y3PC63GFBQGtK4SvXLGm5hSMQhsrnmTkAbnyI
 6+KDiMD5fY8zbc+3cD72YFjmABp/GimOoj1szSi47wUUYlcpP6cU2tj/Oiw7t/vyJVj2
 ux/Q==
X-Gm-Message-State: AOJu0YzRya2nGpCUc6tuq/1y2Rjl/sRssnQlsHXsy7rIs2G84xu69VkO
 WFaPvLWXDBm5tHXaCB8/4xPHz5HWc23pFBSx8MhcQ2B+4mIfUTPqTqgK8qh/ZJY=
X-Google-Smtp-Source: AGHT+IEkABjnERuYiGH+MKfqwmoIwC+4yd/WPG+EO8ooQA6EpkLNyMbKvwllFSlvbcVYBBN9/X72kQ==
X-Received: by 2002:a05:6a20:43a2:b0:19e:4ab2:c362 with SMTP id
 i34-20020a056a2043a200b0019e4ab2c362mr1423478pzl.14.1707887634206; 
 Tue, 13 Feb 2024 21:13:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUrsfXnd8sOujh39hlWsakF+8H3UF+75cXdFu6d7D4+fXN5+FOL933E811oM5roRicpwsjyqLA2aNuwHlMhWJJI8Kxtv0CtC4PEYmg3CeNILXfdkER/ifPHaMk5E8Z8xKS31nUG1eXkKiPrWSAFataBKJ2s2XoqCqhDQiE28xab7Fyjtc1ayF+/7rbnyUiskG0dzWX/tWGL47UR1nA6LqoRd2qzdn8x9gNJtwCj8istPanjUpGiONs/7hIc6h2dXRyWHuNvfgshNy2vQRYjh/FCt32r4PEBE8jFr4uN96G9G5K3prqwfpAtdDaHto6Bp88zXO03vgK/HbgmbLpr2bm8wRZR/TiUQRUWYkEn3WR54VrKWksiwMWLLZKTiOlhJTw3AWqvWFAaUDaB9/qRisYPzRmkJ8bKCKhbixkf/WKZbY8jSUjzZdlB1pphm+Q=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 b18-20020aa78ed2000000b006e0a4022fa2sm7452600pfr.189.2024.02.13.21.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:13:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:40 +0900
Subject: [PATCH v4 2/9] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-2-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b273..54fa0676abf1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != -1;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */

-- 
2.43.0


