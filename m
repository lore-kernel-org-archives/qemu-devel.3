Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD62D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaI-0008Rw-OJ; Thu, 29 Jan 2026 11:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaG-0008Qs-KY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaE-0006XY-Gn
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so894641f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702965; x=1770307765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L9xXgSAQQ0ho77YnxVcq3hL9FgFenk/Ub66527/ohzQ=;
 b=C2EU9eRwQy+7Q7+UmYE9Ih/TqCfYZvEtdZXDkHLHJKygP3R9wOxlbmSKCEjdBH5byO
 71MgqXAojYaYjQdvGtgoFBXpcoYupO7sD7SwiDYl2GRqEBuTdZfWRvS73ypBRZXPiFvM
 ORuygTXBEeCJZQm4zsc0avE99ZIkgbz6zxMcxSBk5uMBQOu5d13jCknlw2DRVlEdVwdu
 VX5qpzrNgn0TJI1o7z4Nt9XhIpZX6U1MBZ68umPJLjqoDUAOP22JEncaKCCljh1siU/4
 021YFKMsm9U2wSDxgDQIjag/szTakwfZRpvPtn9epV555qhiAPIoDaxb9PD59HClccfc
 AdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702965; x=1770307765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L9xXgSAQQ0ho77YnxVcq3hL9FgFenk/Ub66527/ohzQ=;
 b=tNFIkmb1YXjpbjSC/BjN5R+QdEgJKpAEJQ9qj+P2QRzvA5+oEwiEywuPtR99OFa9dV
 nzSjKrxhEzchcOTUU3aZsbtR9NUDki18UytwvDbFw5v2zxEq1eVnTicMdILWZDzN3rt3
 +gUdpHC7L9fbYoH9Li0yo0NKjSqJ2KgReHIybDlWVvB408SICM818Nf/LVV4AqNqDsW1
 RbdMVcds7MD2QJkKJqhMJc2Y1c1P82v7P+H2E/PY9EuELUX0MQHZC1D4MMlhCPckYWTk
 3bzp6V2QLd/4vWSKZBQteUG5jiSM48yuwhg7lB+QcH1nYNI5URaS+rqIJzSpjDLCFuDo
 W39Q==
X-Gm-Message-State: AOJu0YxKE8WLbR3OxBZ7yIaec0aJyyBoP0Cls7pBnUtnJPIWxu1jwHTC
 tWuE2NglnE3GUJWX8LSkzvgz1dBo6qn5cVHgdZQcm1f1XA2SMMWAzh7EhtDG+LIxDnKwu+ATqHw
 VjN6gM0Y=
X-Gm-Gg: AZuq6aKHgd8GUyEHlxQr9qsQKe6VdA8hqLUWT5qZ76lms3UL4ZHcnP/LxKrLm00sl5z
 oC59j+COdJ7itH/YgefTPaV86GbPOfAS/lcOsczfuoQC5qMM5QS0eeI4cEj38X0jr3kjdNeSv49
 wb1XNcEpJOGd70HZ0XKgV3yHTkfazNrolDVGNmnpzyFWcMRwGNSiq4zNLlpZJ5K2n63Z1iqxTvK
 lI6atgWDuSGgGdv2BK97lj47he1cZ0oJG69HacK8PObejnTLNLUl5ju2vv/kmxtpU+MC0PuFBtb
 gca1orl9BYSpnTVMobvoYSKu7JOh2BcQwH/ZqS2oJ4gih08QXZPHAQozzvaDuXdJLew10Ll1lcB
 j3xCh8EC/qrQtcdB7vVWjXak6I4g8vD56utIX2AgEilGYEUrquQ/RYLGFf4EJ85E7VkT7fHRFZ0
 b5kTZ+IYjq1ZHM7bu16hJAlHWfpDZYjw==
X-Received: by 2002:a05:6000:26cd:b0:430:f7c9:94c3 with SMTP id
 ffacd0b85a97d-435f3a864dcmr188130f8f.25.1769702964597; 
 Thu, 29 Jan 2026 08:09:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/43] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Thu, 29 Jan 2026 16:08:38 +0000
Message-ID: <20260129160917.1415092-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Make iommu ops part of SMMUState and set to the current default smmu_ops.
No functional change intended. This will allow SMMUv3 accel implementation
to set a different iommu ops later.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-5-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1492d7dd95..58c4452b1f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -959,6 +959,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                            "smmu-secure-memory-view");
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -978,9 +981,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f5060cf36f..7b975abc25 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -166,6 +166,7 @@ struct SMMUState {
     AddressSpace memory_as;
     MemoryRegion *secure_memory;
     AddressSpace secure_memory_as;
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


