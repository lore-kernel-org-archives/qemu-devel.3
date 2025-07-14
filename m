Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE84C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHy-000175-0V; Mon, 14 Jul 2025 19:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGz-0005p8-EN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGx-0005bE-Qg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aX8PwjZ6oBQhpAKZNBDNaO0YS+5HfJ6iXi58366fCfo=;
 b=i8mciDo135HeNXXO3dhNmJp9c4/eRq3AsLHbe4j9T03gVZUY6qqlawFNHNXEeDwr1fmIgu
 +vk1pDofN0b/Asvb7if4E+1O6jOq5dHWC8OYrDSUOhhphwVpPOyFOTJOvPh0hUg+PKoV4l
 ETNTSK/euq14WbonfMd/Fq9wnpF43lU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-g37Ed-SkOOOJ00ZjWxZL3w-1; Mon, 14 Jul 2025 19:07:45 -0400
X-MC-Unique: g37Ed-SkOOOJ00ZjWxZL3w-1
X-Mimecast-MFC-AGG-ID: g37Ed-SkOOOJ00ZjWxZL3w_1752534465
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so14810585e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534464; x=1753139264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aX8PwjZ6oBQhpAKZNBDNaO0YS+5HfJ6iXi58366fCfo=;
 b=iAT+xOu6cENW2iyLbS9BRFkD2+J7O55wsq264XsmqPmZgIOQO2/4myZr4ou9UnlHAU
 lZZmM+n9tq4SntrEQAJqxg9S8f70js0Qy3mKmdO2uecghN4+/SW/H4h650c+RJ84r2jM
 S4xKDJIReLpIZofzHMxBwWvYjFItln6M01SzaBpFB6NHiQnGzIFmxjsluyBvww4h9nIj
 Oj+lIui/t9NG1CGkc3UrBWlpViPxxeYHghv8qKnYYhMY3IJFxdb0lryCjkD965GnbmjO
 tlU13i3Bw3BsvdxhWwmI/Q7GS/nx9+84exNvsvFK1SIRZqngx6Ub8cVejnxyVbHn97Kh
 pwFQ==
X-Gm-Message-State: AOJu0YzKxFR9Wj1MOQ4P8uxBh20Lk5enZXCp3krTCXwpIMikO1oBveKx
 Z4cafQloWcPVEcic6QU3nXrCWgXE34TN3GsWHMf/v/EbgVfDo/OOZMrVjwc4dxoCf1WiCkOrdXv
 FhQboiBPlgbOyuuYydvIxdPqPZaGw4mfivwibkWv88ghx/b0uEoCXxw3gu1C15wjmMYej98u1qY
 nhN1WbwQ7Yy8TyRMw8onvLkaoNrGFS0DshRw==
X-Gm-Gg: ASbGncsSDhQvbMf4drr5QoBFVm9CmwXIvxV7ENhxu58zitcgHS+IsYTDsybhB8pC0C0
 xuI8+Qm229k3qw6nFqjhY5rESp+1YT3RKHyhGzM5TV1Y2buGzKd/wNgh8wR0r+w3/Zel+DHn2qq
 emS2PoJQv8+t5kLuYB2ITohQnMPUP+/qt71bRhU03LqnGaSq1RdVxbeBoQl7apNn9+l6Z7+jjqE
 cTWvjYMv3QetS4qZDnGsdt+Uv6Q5fGtlyr83fszvWjkswL+MYn7VsGsP3iDx655TrVLjK6250yN
 BDHMz5G5rphZKPlGFLw66IkS2cZ4GNtl
X-Received: by 2002:a05:600c:c056:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45610a814b4mr42572205e9.28.1752534464338; 
 Mon, 14 Jul 2025 16:07:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnieEq7OObwcn9Acpatn02P90R1cHIKg2RQXQkhRHSBmRIByIDfwy0/+uIwdOnTQeNv+Jdhg==
X-Received: by 2002:a05:600c:c056:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45610a814b4mr42572045e9.28.1752534463803; 
 Mon, 14 Jul 2025 16:07:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd55b1absm145273575e9.40.2025.07.14.16.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:43 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 35/97] intel_iommu: Implement the PCIIOMMUOps callbacks
 related to invalidations of device-IOTLB
Message-ID: <1fa16d5c3a81bc6434cbc7afe483b3791b295ac6.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-8-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index affa7768e6..234c452849 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4733,6 +4733,15 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
+                                    IOMMUNotifier *n, IOMMUNotify fn,
+                                    void *user_opaque)
+{
+    n->opaque = user_opaque;
+    iommu_notifier_init(n, fn, IOMMU_NOTIFIER_DEVIOTLB_EVENTS, 0,
+                        HWADDR_MAX, 0);
+}
+
 static void vtd_get_iotlb_info(void *opaque, uint8_t *addr_width,
                                uint32_t *min_page_size)
 {
@@ -4742,11 +4751,37 @@ static void vtd_get_iotlb_info(void *opaque, uint8_t *addr_width,
     *min_page_size = VTD_PAGE_SIZE;
 }
 
+static void vtd_register_iotlb_notifier(PCIBus *bus, void *opaque,
+                                        int devfn, uint32_t pasid,
+                                        IOMMUNotifier *n)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+    memory_region_register_iommu_notifier(MEMORY_REGION(&vtd_as->iommu), n,
+                                          &error_fatal);
+}
+
+static void vtd_unregister_iotlb_notifier(PCIBus *bus, void *opaque,
+                                          int devfn, uint32_t pasid,
+                                          IOMMUNotifier *n)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+    memory_region_unregister_iommu_notifier(MEMORY_REGION(&vtd_as->iommu), n);
+}
+
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
     .set_iommu_device = vtd_dev_set_iommu_device,
     .unset_iommu_device = vtd_dev_unset_iommu_device,
     .get_iotlb_info = vtd_get_iotlb_info,
+    .init_iotlb_notifier = vtd_init_iotlb_notifier,
+    .register_iotlb_notifier = vtd_register_iotlb_notifier,
+    .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
MST


