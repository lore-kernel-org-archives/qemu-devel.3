Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFC9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFM-0006Dm-L5; Tue, 16 Jun 2026 15:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Y-0004l2-88
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-00013e-Q4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso32558095e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636845; x=1782241645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DW5PvP0d6kR8ug90l3JDujZwID8eIhrnAyO6bY33H8Q=;
 b=fYvKZYqPdeZLd7bxXw1I+qsBPYALD/cSQmD9wjut0/ZyLMPzKhZeiBXoSbELFHJE8a
 PL0xb3PHmPEfZdgO51VC7XxWYHYF/KWousjKrlwXsTdEx+FF65GbNHceHhbOvOFH9nBC
 RGCjLJ86yQ6E49dB1mYg8IWmlwbgRiBVq7kNh1SmnETjfIrGC/aHqZpWCL4rNe/D7vU8
 8KekzIbKtdFWR4sSIHef+oxyRALizZZXvKmq2TiCzX9IIVo1lPTfuj51w6cI0diAyyjr
 z69S03R1USuFpuNr9ltzBhi8F/c9zQXGa8xdew7fFnd7ZTT1r7F3Rain2W/X2f4L9fnt
 Ng2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636845; x=1782241645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DW5PvP0d6kR8ug90l3JDujZwID8eIhrnAyO6bY33H8Q=;
 b=Iat6QiWXFCFsICGn6QHIdiMtyzJ40iwpH6zld+Xbr6EYlBgns2V4tvIpdzWiVsktVS
 A9NzP1zq1u2PJTydua/3h0kl7BQFwAp4dOt5P7iHou0rUcPciK7ecVlizf8qoKNTXeRI
 YeXZGS9loX+J/Nnmqnb3S6oV/vfToPckcf4IVLi5QlmVMXU3OAAvWn6ua985sRAfkNuk
 ZYTScchTWtB0AawxIL2B0go24BhRcIbFaN1dQ3kNAec6vKCZfYDBM7yiuq5kmDjuZzSt
 TuDj1KsVmQoeg2Y0EHJ2HYnZGF+LPAnEYZaBw4W7rBEVUQRQ+93m+mILDvp4YD0VyM/t
 8yOQ==
X-Gm-Message-State: AOJu0Yx/qeDyqXAhlfshEUoYVCLKZ7gsN5qIRUdk9KgKTHI5YcQZM/fH
 BGbE2Lh/M+0qR2pjh1ftdzxiWeYKCdcvxbxpXdEhZoliT85onjbNBweTPP/OUwF/ZAiBX9fuhhe
 z3wms
X-Gm-Gg: Acq92OHyLJTR3e8YO7Cwr6QZbh3rPKSlHU80ZFxMxUDCmQvn86Uo/lNsYF48EHoq8E8
 +g/hOHZP4j7Do8Eqqy7UJB/L80c3wju2Onhi5WHBxsIA0bZNwfcss8oDT3La4jNbppJ5WL41OnX
 nW8ldov/vTzFDIAXlIKC3FsG/iQZ8mGHhjjT27KnvCMogG0Ii9xfPHl4+wEIoIikap7lw8i0s3/
 W6TLkamenJl7D5+DWXdMwB8Dq9g/9suxI7k3oUg/GGYvl8tRd7h8SHXuZz+GIkAweuO4ZnI3HeN
 xDr8Qv77hf/F4leIzEbYwdWBEzhWtBE74b9eblElUGEUl40RlyU7Zdzm/W4uwABMiSIju4yQXYY
 Bz8SYBR/wmUwjQs8l7nrTbXPca7tVUrfiHH2NIweOroF7Q15VasKseHHS1qiTLdRpcGBkj2FlKt
 NdL4UgtxEOB0NUI80s+i/Xa2OLWItneZmkDU8QxmtWMgX0G044ogn0OQCvisWRHdkbrNpr46MPb
 aBKJtB6UskraZhg/BM6bohrb/UbuRtb
X-Received: by 2002:a7b:cc8e:0:b0:490:bd66:db49 with SMTP id
 5b1f17b1804b1-492333f5ff0mr7076835e9.12.1781636845236; 
 Tue, 16 Jun 2026 12:07:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/61] hw/arm/smmuv3-accel: Enforce viommu association when
 CMDQV is active
Date: Tue, 16 Jun 2026 20:06:16 +0100
Message-ID: <20260616190639.3462006-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

When CMDQV is active, the first cold-plugged VFIO device establishes
the viommu to host SMMUv3 association, and the guest's boot-time CMDQV
configuration (VINTFs, VCMDQs) is built on top of that association.

Hot-unplugging that device would release the viommu and tear down all
CMDQV state. Hot-plugging another device behind a different host
SMMUv3+CMDQV would then re-bind the same vSMMUv3 to new host hardware,
while the guest keeps using its boot-time configuration and ends up
issuing commands to the wrong host. Block hot-unplug of the
establishing device to avoid this; retaining the binding across unplug
is non-trivial and not required by any current use case.

Also abort at machine_done if cmdqv=on is requested but no cold-plugged
VFIO device was present to initialize it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-30-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++++
 hw/arm/smmuv3-accel.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c3bd4413d..80900c2521 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -759,6 +759,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    /*
+     * CMDQV is active: block hot-unplug of the device that established the
+     * viommu association. Removing it would cause the vIOMMU to host SMMUv3
+     * association be changed via device hot-plug.
+     */
+    if (s->s_accel->cmdqv_ops) {
+        PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+        error_setg(&accel_dev->unplug_blocker,
+                   "CMDQV is active: removing the device that established the "
+                   "viommu association would break the guest CMDQV");
+        qdev_add_unplug_blocker(DEVICE(pdev), accel_dev->unplug_blocker);
+    }
 done:
     accel_dev->hiodi = hiodi;
     accel_dev->s_accel = s->s_accel;
@@ -1082,6 +1094,12 @@ static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
                      "at least one cold-plugged VFIO device");
         exit(1);
     }
+
+    if (s->cmdqv == ON_OFF_AUTO_ON && !accel->cmdqv) {
+        error_report("arm-smmuv3 cmdqv=on requires at least one cold-plugged "
+                     "VFIO device");
+        exit(1);
+    }
 }
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 5fc85fb89d..dd755c394d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -84,6 +84,7 @@ typedef struct SMMUv3AccelDevice {
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
+    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
 } SMMUv3AccelDevice;
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
-- 
2.43.0


