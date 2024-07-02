Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F360C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEh-0000is-5j; Tue, 02 Jul 2024 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEe-0000KJ-3F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEW-00016r-DG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN0cTm8m+n/A4V5Tgbpm0TUAfWebEt6LcyWQbTcpz4g=;
 b=HWoTbjCoAMeyc5SVp8lpry52HFIurU/P8MaRgInvYe8PqRmXqH525ccjzkkmBtdI1YQCD9
 a3zpfOzNx9SZ6oVnhaB6cbR/Oe1BlcPa8j0Jj/OMSskKC+FLC41yrMW1LAVO4Vbw4J9AEK
 GzZXtLU/MmHISIu6EUARPOB4OUSeoU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-z9VTgEQgO5m9JpyaJg50Ug-1; Tue, 02 Jul 2024 10:11:45 -0400
X-MC-Unique: z9VTgEQgO5m9JpyaJg50Ug-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso19250555e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929504; x=1720534304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bN0cTm8m+n/A4V5Tgbpm0TUAfWebEt6LcyWQbTcpz4g=;
 b=ihU4cNmjvDSe8WBsd6eF/2IBC492KFA2oIIgRKFY7XAiBOySnJzEmCjjvhm2MO2EF6
 bfjTu6C6r1SMmXiNE7ZWOvRk804q4hOfCpj3n2oLlnudXpG3M4kaWJj+43ZZg+V3xP+7
 ZvmqwFj75tO4Ry4s9d8EWLPDaCi3YVAXXkOjD8mF9l5tYWVkmc5NNOpeIU8/olNUbkJ5
 wlb0NbmRP0qh1bCDehDxzFLFOtdxGW85FrvXI1WCNr4eS3yCqINRJ+DuRPHMKfmv4VSb
 nK197LYSXUxPuafA5cq0YM0TBGSncvwPyUaNGBRa0bf17WK1Oo2yhtBS0u/m7y0TcRiW
 O9ow==
X-Gm-Message-State: AOJu0YwomhCROTt9nuS+nJLL9Urq/mG10jYGsCvrgMMlbEkNr/wAzguK
 0p2AYc6YNnlEyeYpx2LA3x76SbXpD+HLxH44Po1qlCqtVPRVWXKqUIbjg2r56yN/4U40Chbh+hi
 53r3o+z2ybgfYh0kV9tIJJ/Cxvv6cIsR6ETpA4MNjUOw2M66NH7EckaDVH1bcNzpab6Qwbz/qaE
 FxnDUVtSl0zDLhW92Nd3T78t5ZQJEHyg==
X-Received: by 2002:a05:600c:47cf:b0:425:7c18:df9f with SMTP id
 5b1f17b1804b1-4257c18e0dfmr38909175e9.40.1719929503731; 
 Tue, 02 Jul 2024 07:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+bg8BPn83l1dihyVUeV27Pe6P0ZNHE/VD3ClUbZT2uoj6UcFuruOQIL6CEMxWRsrxnjA+g==
X-Received: by 2002:a05:600c:47cf:b0:425:7c18:df9f with SMTP id
 5b1f17b1804b1-4257c18e0dfmr38908905e9.40.1719929503038; 
 Tue, 02 Jul 2024 07:11:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061006sm197706495e9.22.2024.07.02.07.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org
Subject: [PULL 91/91] hw/pci: Replace -1 with UINT32_MAX for romsize
Message-ID: <a323ad3c8a8f12ee180d0582d7fffa8098b1a962.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

romsize is an uint32_t variable. Specifying -1 as an uint32_t value is
obscure way to denote UINT32_MAX.

Worse, if int is wider than 32-bit, it will change the behavior of a
construct like the following:
romsize = -1;
if (romsize != -1) {
    ...
}

When -1 is assigned to romsize, -1 will be implicitly casted into
uint32_t, resulting in UINT32_MAX. On contrary, when evaluating
romsize != -1, romsize will be casted into int, and it will be a
comparison of UINT32_MAX and -1, and result in false.

Replace -1 with UINT32_MAX for statements involving the variable to
clarify the intent and prevent potential breakage.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240627-reuse-v10-10-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c             | 8 ++++----
 hw/xen/xen_pt_load_rom.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fa85f87b1c..4c7be52951 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -70,7 +70,7 @@ static bool pcie_has_upstream_port(PCIDevice *dev);
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
-    DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
+    DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
     DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
@@ -2073,7 +2073,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
                                  g_cmp_uint32, NULL);
     }
 
-    if (pci_dev->romsize != -1 && !is_power_of_2(pci_dev->romsize)) {
+    if (pci_dev->romsize != UINT32_MAX && !is_power_of_2(pci_dev->romsize)) {
         error_setg(errp, "ROM size %u is not a power of two", pci_dev->romsize);
         return;
     }
@@ -2359,7 +2359,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
-    if (load_file || pdev->romsize == -1) {
+    if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {
             path = g_strdup(pdev->romfile);
@@ -2378,7 +2378,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
                        pdev->romfile);
             return;
         }
-        if (pdev->romsize != -1) {
+        if (pdev->romsize != UINT_MAX) {
             if (size > pdev->romsize) {
                 error_setg(errp, "romfile \"%s\" (%u bytes) "
                            "is too large for ROM size %u",
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 03422a8a71..6bc64acd33 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -53,7 +53,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     }
     fseek(fp, 0, SEEK_SET);
 
-    if (dev->romsize != -1) {
+    if (dev->romsize != UINT_MAX) {
         if (st.st_size > dev->romsize) {
             error_report("ROM BAR \"%s\" (%ld bytes) is too large for ROM size %u",
                          rom_file, (long) st.st_size, dev->romsize);
-- 
MST


