Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC345C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlb-0003ga-S9; Mon, 12 May 2025 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjX-0000Hw-Tn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjV-0001pM-TW
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a0bdcd7357so2829548f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039316; x=1747644116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm74PrW1PtvYLNFl6+XPtcJ/DOMNe0H9WpC4Rf0Ae0s=;
 b=K/ksHgrCoz+mj5AjjLIC94e2i1cv/iQRbL3tSUdq+03ztX7XUcxLi19C2dDZjUCmHO
 PT2Bzq9NZlWFWOEoQ3l6AcmhEShfF6Lz9lYbmihMGdjaV2ZIZ/3HgYHbqX1MqksMpj4n
 NM8SeAv4vHfnDRBF0uyw9H9+1Dpg3EQjEICQKcYrxLigLawYIKL1Wo2iCfpE9ECU4qAR
 zCcf/4QA6A+tTl+aM0Rl/lf/k32hOg2o/qXntt8AS4awxvDg4bdkn0c3AAs4ooH0829U
 BAytiWFaIICqo39Q5nCUK7iWaUeUgxyeEf3lYwbtC/JdBK1TsuuPqdnsh4IiTcLxguEc
 HvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039316; x=1747644116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rm74PrW1PtvYLNFl6+XPtcJ/DOMNe0H9WpC4Rf0Ae0s=;
 b=Qjmp6oylvE/nUcHFXUUQxCIjLeDWZLyzrEnVaAcx6a6KpX4O6oB6nMiNKvsyLN6+F4
 kucu+o+o9edavMJMKcG+h/U+AjsHCn7IWgH6aRa2lO2RWiPF2G6xh8BrFfxefo2oGTKE
 8Orbasfqj4jB4wrDcyRJtXwbL/qLWylxyExdzDgxk7cCA4leFrGMW2sWYZFpLXC7FIUr
 cAP7V5je3QbjuyOheCFgSkrwhZe+0CnQlnKfkmcm+wV/m4uidwtrJVGPqQUnZQFYHhIA
 e2kdV02iJsQuILIYXu+eN3OkFq8LnrnieLDo9HiGdKc2teD9siKM4GqAtBAhRn+9dQEM
 etrA==
X-Gm-Message-State: AOJu0YycISEwiPF25SG1WtcnMpTtnLbtGHNmRPMmlzlM6SUeAMuiYiw/
 C04Oy7ULiHLr7w5RS9aaZZsBqWWPLjFeMXYRBeOSZGeehXzT1wp6mYAQatYpXVSYEV+KCqegVXq
 g1GWh1A==
X-Gm-Gg: ASbGnctln+rvZtO+sYFl5iI6DecRh9k+mCLUX2LOGNL4Pwv4VGDBF1K21QyF5BDvWhC
 iGhPMqkkFx5pqhzXHSKDHecD/s553oGH7eI2EcWObs0c3DtRQdK5R7jcHzP6zeVitUdW5UMZgNA
 UnsqMh4/sjX4Qe753+9aryo/fU+9zmAjEF7em0D/0qewZSwYftL7/jdsofaT93Owv2JMbDz+WqW
 xyvZYsZ/lugk4C/IA8XkOCfJ/Qgkj7FX322XOyOXbJcE/a861ejIABLBUeyDGyAWCkABHR5VmQ+
 ys4fL7TPsLS0rrIo6CT0kHqcetbusS6//Glcm+cLCbP99lShBdpU1JKsZgkaxDEoyjO7+S9ilpD
 v6aB/bsyLuqyC2DmKZUOdRqQ=
X-Google-Smtp-Source: AGHT+IHOvxp5PWodlRrYrd7HkwKanZWHT0N5VYlXzjODG19TjaIXD8v3LKPWQNqpN0qMNKOq3gPilg==
X-Received: by 2002:a05:6000:2289:b0:3a0:6c62:8169 with SMTP id
 ffacd0b85a97d-3a1f646a66amr9345580f8f.25.1747039316005; 
 Mon, 12 May 2025 01:41:56 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddfd6sm11498123f8f.4.2025.05.12.01.41.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 14/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Date: Mon, 12 May 2025 10:39:43 +0200
Message-ID: <20250512083948.39294-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
property. We removed all machines using that array, lets remove
all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/scsi/vmw_pvscsi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d5825b67868..34de59a7cf6 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
 /* Compatibility flags for migration */
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
-    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
 #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
 #define PVSCSI_COMPAT_DISABLE_PCIE \
     (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
 
-#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
-    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
-#define PVSCSI_MSI_OFFSET(s) \
-    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
+#define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
 typedef struct PVSCSIRingInfo {
@@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
     int res;
     PCIDevice *d = PCI_DEVICE(s);
 
-    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
+    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
                    PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
     if (res < 0) {
         trace_pvscsi_init_msi_fail(res);
@@ -1158,15 +1152,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     trace_pvscsi_state("init");
 
     /* PCI subsystem ID, subsystem vendor ID, revision */
-    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
-    } else {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
-                     PCI_VENDOR_ID_VMWARE);
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
-                     PCI_DEVICE_ID_VMWARE_PVSCSI);
-        pci_config_set_revision(pci_dev->config, 0x2);
-    }
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
+                 PCI_VENDOR_ID_VMWARE);
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
+                 PCI_DEVICE_ID_VMWARE_PVSCSI);
+    pci_config_set_revision(pci_dev->config, 0x2);
 
     /* PCI latency timer = 255 */
     pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
@@ -1298,8 +1288,6 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
-- 
2.47.1


