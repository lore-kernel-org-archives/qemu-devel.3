Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B996D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbD-00025v-Rz; Thu, 29 Jan 2026 11:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUar-0000gT-D5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUap-0006ov-Df
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so717958f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703001; x=1770307801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4G9TaBDcJtKUE+2eI7zOEpG9xRehne4XFIMepLbMDs8=;
 b=nCdDTb2YqTTQ5ryGwxH3hKFvtI0z8hp+ADFMUU7GbcS2N/WhVfkMSZn20FmpXSMlZ+
 kBgcF+m0MfY0qj2/6mdytQMzppIuNntKEDrHB+hTp1ajEIQdKFo3wBAm8NGwnvR729aF
 cN7OMGxOqBvqLXx4GNY3yrMBsarc5E2H+vSi7bpamuYBN2+xWd70Kh6/xgv2+vrqL5+7
 1PBj8oI5d8npnz8UsFq174mWFL5QF9C6nUiO/PLQIYNK2+4kfnqozAFmsGSvNd2wwNSl
 8LTCBSl43GtPw64yYO9qsd1CLs0mQAWpMekVzCXPGC14iLEIL7eR0r1b5+yJlNGROXV6
 X8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703001; x=1770307801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4G9TaBDcJtKUE+2eI7zOEpG9xRehne4XFIMepLbMDs8=;
 b=cq989IEOft1qZQgKF1IBVXW+Z44A/wg5mzxVvdDMGchWO8J/OMCBnGT1Y9SSuyWTpC
 ygkezGhLWWCBw+qx/5gkoUgnZwaBuD8OK142eLCWABmWZ7cTigPGQFhvhI3BkrxrfZKn
 hQ5jgI7iEeV3p3Xx9kG5dZw7yKztg7NvvluENmtdUoP8NWJjmxHWlRQu5PlwDGwPYhWp
 OvcSeDC6WXX9mY4DFoj5ISWL/jFNNnOGb+aYk21/gU2YBwV/GQYgp+Msus+ZXPifiT4N
 7F/lfRHa4Q19lVxugbtja6PsOrn4xwWkwgedQLAKUREde4OPGHZKvi8T6cKJ5B9JkyB9
 ZrIg==
X-Gm-Message-State: AOJu0Yz3D2xzBXpQ8+YG9Uksl5sJ40qmM8Teqg/LsjjcBRJglAlWmXJN
 jwazxYj8Va6/Oot8jWbILlzgRwaRIZpTKWpiemjTEY2UtTlaa5Ediibw0isvRfN3AesSMEEcIhK
 lWn+Z2iY=
X-Gm-Gg: AZuq6aLdMx8bXDSnxew8xRI3SVubVcoOwXF4Qa/zZTWj6rFqzmS8EWOsgvmC11ITQNX
 dw35jKynvq/itzNBRrRxTy4dYN57tMIt1bHbklCmcgyfOMwkf/VWTqHq6n9yppQNrf1evCx4NAV
 ACmv1oCdQkS5mahOXRQhQWuUnDmKaSQk2VD6cR+jiK3eD2yK9iCHh1BqD4fD14OkTPIUHvMecpv
 xtCk+0hQXo7oTlKfeXLV7Ju8aNV2W78el7DnaayTxJSj0JKXOt/T1jf//N488iGYnmNRnt6xYyn
 rUc1dl3D/oV65j5VBK4YA5jqG/Lj50zn6LuIGfvrPpsXX/XYObHC0Y/muyKehgXjmIzGrBEdHpG
 pyzjb0Kk2MdlcbGTZ9zmMsL6DBlc6ulNvjvoGmLGYwvVgblKErgtP6dVglxmj5vXH3f+Grgwijr
 2NXoPmIcwacX9tred3T73AfnGA9ibtoA==
X-Received: by 2002:a5d:5f82:0:b0:435:97ff:7d35 with SMTP id
 ffacd0b85a97d-435ea064626mr5437391f8f.4.1769703000661; 
 Thu, 29 Jan 2026 08:10:00 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] hw/pci: Factor out common PASID capability initialization
Date: Thu, 29 Jan 2026 16:09:09 +0000
Message-ID: <20260129160917.1415092-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

Refactor PCIe PASID capability initialization by moving the common
register init into a new helper, pcie_pasid_common_init().

Subsequent patch to synthesize a vPASID will make use of this
helper.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-36-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pcie.c         | 19 ++++++++++++-------
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index aa9024e532..c481c16c0f 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1284,18 +1284,13 @@ void pcie_acs_reset(PCIDevice *dev)
     }
 }
 
-/* PASID */
-void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
-                     bool exec_perm, bool priv_mod)
+void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
+                            uint8_t pasid_width, bool exec_perm, bool priv_mod)
 {
     static const uint16_t control_reg_rw_mask = 0x07;
     uint16_t capability_reg;
 
     assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
-
-    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
-                        PCI_EXT_CAP_PASID_SIZEOF);
-
     capability_reg = ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIFT;
     capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
     capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
@@ -1307,6 +1302,16 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
     pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
 
     dev->exp.pasid_cap = offset;
+
+}
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+    pcie_pasid_common_init(dev, offset, pasid_width, exec_perm, priv_mod);
 }
 
 /* PRI */
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index d68bfa6257..fc02aeb169 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -155,6 +155,8 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
 
+void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
+                            uint8_t pasid_width, bool exec_perm, bool priv_mod);
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
-- 
2.43.0


