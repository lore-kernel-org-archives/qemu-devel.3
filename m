Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FDDCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAQ-0007fM-FM; Sun, 14 Jun 2026 15:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAN-0007c3-Ea
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAL-0001lN-Jl
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DTZcjvGrhpU8cSCRg3WrNcpfoJuqAX9m2jfTl4jhFUg=;
 b=M1+epTvolcr+YaN+BxZdENO9bxVrRLEKUKlDs/bLgmOUlrqrgyxrzbotpgIMo3vs6FRd0E
 NJHWjJ9bVD7FFyFa1LjTt/KSU0KC3VkTMHabACIKLeQmkut1X1xk4sE8j+NaqyweYesWmi
 2JOcA554pm7g66IAgzOnrsNAm6r1JHo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-l-1oNAg8OTO0uf6YEhOK0w-1; Sun, 14 Jun 2026 15:06:39 -0400
X-MC-Unique: l-1oNAg8OTO0uf6YEhOK0w-1
X-Mimecast-MFC-AGG-ID: l-1oNAg8OTO0uf6YEhOK0w_1781463998
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so18037355e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463998; x=1782068798; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DTZcjvGrhpU8cSCRg3WrNcpfoJuqAX9m2jfTl4jhFUg=;
 b=lUPq5vWP4uZ2RAbS6ysGKJC0gevSe9oJPjSfwEApamj34367KEgTnENbMggB5hCXTW
 CgRbrQlDzmyASSec+MBB6EOw9LcRa14TvnAAlkclN012M5deHOrc+r6P55f/81XGQX0j
 GbNBY2UjV7bXuc/Zi6Dq+qKvdreUCk3VS0YjaDSqOVQWNUOd+gdITjS3G90sXe+4qawP
 be0BqTUFFarrOT7fXuBkJBu+0pVb8Ed7jy3ZqG6aroeMJf0ZURF9qNeuy/VmgLpIfrXl
 Lf+ERdHO+dN4EfPpLvnROOVy+C87/STChh9Kr94/ZKkGI9pik+jtBj75rai5+6U1ee+B
 G6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463998; x=1782068798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTZcjvGrhpU8cSCRg3WrNcpfoJuqAX9m2jfTl4jhFUg=;
 b=NgUbxhrcrqCaH2C6eMVn/+yLK5fFkLHA2w3IwGNG+DSbczu1sGzskurP5WWmLvxqqN
 cSbvqAHDRqttsc08wspbfDiYifJnKBWTBhv/vdBujQs/FP6jsCi3iQLl2VpZDphJciDy
 dudxa9/EslRi4Z8kaferpGIwXaXKu/3gYlQL64K1CfJ/cXmROmYnbZ9y2VPQdXTiPb7c
 ku1+jEgAzD5xCGdjt3PFNxakQxe908B5ngEotLRh2lMYW+fbSHscJUmUrieIJLbJ7ORM
 3zIXrOocYchIshCK3O77g2LalYbAgapja3g/XStCOIvkfGsA56+Dw7OFrLGQ7Loqa0Re
 bU3Q==
X-Gm-Message-State: AOJu0Yy+hJFhoByzOziA1IpvRLVlzbAsDOypxVkf3n3Cu5Lsu1FKAPMG
 F/XR4QsTd6eJdCO6SWb6XrlztfENMV+J3BdjFD9oNzjPRAYE2sEwk/IaBeXX7hmQ7mm8X1+nage
 nicUNPXkoPPWqMO+QnunMo7Nt9nYR33ezZoH90qC2DKXuAyZfbbifh/x80LzGopV9fEb9jAgYOB
 lQENY21lEiftzqNLFdURJ3Z5h1tBmMHnbWxQ==
X-Gm-Gg: Acq92OF/RdlPFBYyFDSBvJOV2qJgwLz5InIr4yB6ICQyY1l6wGCouBJEKoTErly8QNV
 4QaOI+OgJaQKWkoR+lajwBHjVNljTfeyTKfmqFnYbfeTzC9kDR4tDBZNcrGGFS6b3rQI3FagMpZ
 y2P8bnXOVPSu7S5ciluwM+TuvZP2fIdCUcIofTrVJsfp/hU7K0Bkn2yPtoEEBuxUGLJfkrFpfVB
 r266/k8PLWhQxCSDRU11U6e42bVBrPGUFrNDCK9VGveEUOMTXHkGSQS9kPQjYhxOIZTsaNUsvsq
 /3FTOmqHp9OcTQR3k9EhdEycxwIr6yh1k6Xl01U2qL1UNssvY1K/QhkE3Lzs/iSmi2IzR1Uide9
 KcbxVr6OEKBUwfA7+3FYe4C4AnLY/JskF98H/KUMOwvA=
X-Received: by 2002:a05:600c:8b5b:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-490ec49f2bemr128210905e9.8.1781463997748; 
 Sun, 14 Jun 2026 12:06:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5b:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-490ec49f2bemr128210365e9.8.1781463997253; 
 Sun, 14 Jun 2026 12:06:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm23342100f8f.26.2026.06.14.12.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 021/106] intel_iommu_accel: Add pasid bits size check
Message-ID: <fa1ce94ea83d857bd541818ff7bdbb0f95eed998.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-17-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 97991fc0d9..c03435f8a2 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -22,6 +22,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
     HostIOMMUDevice *hiod = vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    uint8_t hpasid = VTD_ECAP_GET_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus = vtd_hiod->bus;
     PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
@@ -42,6 +43,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
         return false;
     }
 
+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size %d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when fsts=on");
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 64a38afa85..924e91cb8a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -196,6 +196,7 @@
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
+#define VTD_ECAP_GET_PSS(ecap)      extract64(ecap, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
-- 
MST


