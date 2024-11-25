Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CA4D58D4B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZkH-0002vq-Lz; Mon, 25 Nov 2024 09:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjp-0002Xq-OL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjn-0006dW-2m
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a1833367so3479915e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543609; x=1733148409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwOFcDol4u8ZIeIm4VbuTBCsXEbth7QSSqvQY7JvfPk=;
 b=r8cgP8liI7HuD70/D/hzuwcvXQPS7oGNmwLaDP91pLh0Bn80692c7KOjKppwpTMGs1
 ebJ2xVOJfr3mBavOHbh/CvRZvIOVJ8oPj1a1nPLuQBKvujf/8FYim22XGfN2p4w9rioW
 9kiks7lxf8ZYosa2UjwB21r9JeDuPNzEvBJxUzlz3pvHUg3nNSszWx+fMiZIlG2gnVEo
 9qGqJP0EIFPE+dSMhVhVEH2K3P3lcbCyTPXXYFAEdl2zynSNqJMGBasH9Fh1ULWwPv26
 SZ/Glw000ixHmGOsyPQgWwTcJQn6wpdvWj8LDy+HXZRBSuE3fW/24TrBSJAx727fRDxs
 8Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543609; x=1733148409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwOFcDol4u8ZIeIm4VbuTBCsXEbth7QSSqvQY7JvfPk=;
 b=XPQdcyGHGUlNhJEoqondvTZ/CvswrVesWpnAtHSpa8z5/64E/cc8Z5nMv4VRCWlsmh
 wUbiyz6tsfvkd7FViH6sz3Fpf4SVByzgV6yBLbqOHvoT06vmus4mdzuRuer0iRocujgz
 kp9Tsp+UrdROUFxdd2SK2ryujQLSZlS+9Uer3NvJusHTGurZSaQN9sWUCssFm6Z+CXoc
 EyvFKANFGDfnY1ddlU6jOJT2+PDE2QpVE6Izj23o/y8IuJjXhM1Y0M8SBeU3L58pI4Lh
 WtgPpefPB0TaGi6CGVQJmZY1hnYIqi5uy5ZQkBgCv6gzw7n+NEjZG03TuBDn1d16m8xP
 8pSQ==
X-Gm-Message-State: AOJu0YwxdWRd4klN81ZKGuQOkXHquetxpJIrW01CXBeFsW9Yew6w9evd
 Zr5i0KxHOZdqmk7wyRvjyPaxkE1G6zWyb7RVN+JXtp5ghmCkdmZbEWb8b5BjxEDaNUKEgmkwZav
 s
X-Gm-Gg: ASbGncvI14r6OE10xeTJ3tW0ej1UL5pDGn4y2bwFc+K1pbTCjTtZjP4RevkO+gWWZk3
 gIt51hj2xGJO307eeK9NGSVoNziNXUHUk0vTcdSp5ZXowDSlLmFMMlJBrrWczngqxRCKyySmFUC
 Lmon7zohSXJspoCioTtNpurLtfsobu9JQSAv1L8Yx/M/tu1wYk5WrSCri4XO6vpx1Mf+Q6LrRa8
 TPkifLY1MdOzVwtOMwcpBwBoZLvgKBShOEP7FmtO8jlmWNFqr2oTonzpEbtMsPX3uQWTV0v
X-Google-Smtp-Source: AGHT+IHueUgZ5dfvvnsaTax+Tcm7lAWU8gj6AQiJ4jiKzYjtvhxK2RCPGGpq5pRAQvBX+KADlSNm7g==
X-Received: by 2002:a05:600c:3b27:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-433cdb0b3b6mr102923075e9.9.1732543599641; 
 Mon, 25 Nov 2024 06:06:39 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d40basm199474065e9.21.2024.11.25.06.06.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:06:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 3/8] hw/pci-host/gpex: Allow machines to set
 PCI_BUS_IO_ADDR0_ALLOWED flag
Date: Mon, 25 Nov 2024 15:05:30 +0100
Message-ID: <20241125140535.4526-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
References: <20241125140535.4526-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Expose the "allow-io-addr0-accesses" property so machines
using a GPEX host bridge can set this flag on the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci-host/gpex.h | 1 +
 hw/pci-host/gpex.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index dce883573b..8c990bff5f 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -64,6 +64,7 @@ struct GPEXHost {
     int irq_num[GPEX_NUM_IRQS];
 
     bool allow_unmapped_accesses;
+    bool allow_io_addr0_accesses;
 
     struct GPEXConfig gpex_cfg;
 };
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf5..635467016f 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
@@ -136,6 +137,9 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
     pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
                                      pci_swizzle_map_irq_fn, s, &s->io_mmio,
                                      &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
+    if (s->allow_io_addr0_accesses) {
+        pci->bus->flags |= PCI_BUS_IO_ADDR0_ALLOWED;
+    }
 
     pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
     qdev_realize(DEVICE(&s->gpex_root), BUS(pci->bus), &error_fatal);
@@ -154,6 +158,8 @@ static Property gpex_host_properties[] = {
      */
     DEFINE_PROP_BOOL("allow-unmapped-accesses", GPEXHost,
                      allow_unmapped_accesses, true),
+    DEFINE_PROP_BOOL("allow-io-addr0-accesses", GPEXHost,
+                     allow_io_addr0_accesses, false),
     DEFINE_PROP_UINT64(PCI_HOST_ECAM_BASE, GPEXHost, gpex_cfg.ecam.base, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ECAM_SIZE, GPEXHost, gpex_cfg.ecam.size, 0),
     DEFINE_PROP_UINT64(PCI_HOST_PIO_BASE, GPEXHost, gpex_cfg.pio.base, 0),
-- 
2.45.2


