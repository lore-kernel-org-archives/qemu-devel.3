Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F49D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUad-0000Hd-S3; Thu, 29 Jan 2026 11:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaW-00009T-Iq
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:45 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaU-0006dY-Vg
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:44 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2670932so1130949f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702981; x=1770307781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nY2Fqtl39Acb1I/wBKQSDHm7rQ3asaK1/sWbD/R/7bc=;
 b=sSBT605K9xObTml+iLU2QgtrTD4QTbKD7x/NwBluUSGUJJBKZDH4CVzkGV1qZ/h2Gc
 FSI/HHUUcKR0hiWtWLNujkjdylVVX+Njs0WqJA2TWm5ojegmLmKZ3l+eCTFzJGMdWKeX
 IhhZ6FIRhIK5uON6O8LRqq6x05lp7TJW1wre4B5Qk85l1oCXJLpWIl2bG/LixKAJrPRj
 Mbm2vYCAaIDOaRv3ns2DspNy0Bk3a8S/yaMHbWebqeCH4Xm7NZGJW8JObbYCAe9n45Jm
 BDmVxgpQec2SL4uy9gOrYuPPJhI9B2owSuP/INmMOpJprdLCa1D1n8ihKZdTyIItbiAv
 U/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702981; x=1770307781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nY2Fqtl39Acb1I/wBKQSDHm7rQ3asaK1/sWbD/R/7bc=;
 b=jVhDYizgvzGmjuYIOCmdwv+oQ20kIx+am/yUkVUHmSFZW5a+X2I6g2ss+TaISzqUQ8
 pWo+I71mup7UtYeLs7/Gckc6uczgwDP3D9rEc6E1xgk+mO79nhI4PFi90NtSM2fPso0J
 FNI+otVKeKvoghCHKQc2W4qbbpX8WrAeiE2ZYXQ7oIcBQkXcKoooVW1XbuJjJ3iHvJd7
 5BDOyFu4Bq0Neny2/A1NSg+7wp9KX6SIU4bMVUXzyXvCdng5L3Ue3i7RgBH/CBaruJFJ
 HwQMMTxNW7PhQsQsDRLYXvHkkXMMFSh9YZxIf4xh1AgdIZ4BUBrZ4GFFcrRmWqGCJ3j0
 vpCg==
X-Gm-Message-State: AOJu0YxU1BKhmXHK4+OJCfbJ8ESAD9XltVvG+QrDLUuSsrYKRTzmgeUw
 bFlupm4ernSOAX2mDN8oXW6e1DEH2hvyeSJRP49LRFOeK8WY+h6hzRGrWsxSuWTl/pcbFxJG7Vc
 54wJPd5Y=
X-Gm-Gg: AZuq6aJLrGF2JqtwcIT3dcDdMIH5ls6AyS5Qj454htF9uypttdCtakREkzGdnjDMqYf
 0dm7KGscoQSoOLiSqmPxkFLDD+qQ7+wtWLHE7J+sk+oqqPusmKvYzEE8WPJY3pC13qdH5BpVj/H
 KEByci2G2IeL5pjraapEfrIAWbOj7B7aFifnIYDyc/7rWbTWTi0WBDIY/3b3zZNYrd9ZNtA8dJE
 j8Ho9lfgCfXo7j3ZEkdt3vKoEyjk3SGZT4vL0QZL6RcX3zzHFQRVRbcZlVeyx1K7xl6jSog40Xg
 KkEsghd7Fe4JNz649BHvRIc5g+/hTHlqWqCooCrRxFxS4lMDX4ikW0n1cSsMsnEAMjGGJjS4xCC
 m6tWz6yAlDF7+2g19/A6dOOMp446LD+Zipq9HV67TJvAsqKI5tZ7Tqy49voJCe7JDAKCFIj6+gc
 juwxFW8LaU0Ru8mhKqJxoWGpTVNwvhlQ==
X-Received: by 2002:a05:6000:1786:b0:435:dd81:4f4d with SMTP id
 ffacd0b85a97d-435f3a7bf2fmr203159f8f.26.1769702981438; 
 Thu, 29 Jan 2026 08:09:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/43] hw/arm/virt: Set msi-gpa property
Date: Thu, 29 Jan 2026 16:08:52 +0000
Message-ID: <20260129160917.1415092-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Set the MSI doorbell GPA property for accelerated SMMUv3 devices for use
by KVM MSI setup. Also, since any meaningful use of vfio-pci devices with
an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
those are specified when accel=on is selected.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-19-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..91fec582ed 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3061,6 +3061,26 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
         }
+        if (object_property_find(OBJECT(dev), "accel") &&
+            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            hwaddr db_start = 0;
+
+            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
+                error_setg(errp, "SMMUv3 accel=on requires KVM with "
+                           "kernel-irqchip=on support");
+                return;
+            }
+
+            if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+                /* GITS_TRANSLATER page + offset */
+                db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
+            } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
+                /* MSI_SETSPI_NS page + offset */
+                db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
+            }
+            object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
+                                     &error_abort);
+        }
     }
 }
 
-- 
2.43.0


