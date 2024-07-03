Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C946CC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8oR-00088t-18; Wed, 03 Jul 2024 18:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oP-0007sn-5J
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oN-0007aG-Ao
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN0cTm8m+n/A4V5Tgbpm0TUAfWebEt6LcyWQbTcpz4g=;
 b=Eui+RqHgA0+BA8StBatp5vu1upqwU4ECUHdd1Y+hSk0AKYvga7GeSdkB4cYKKKOvxgxOLo
 R+5ZVnP6dUvYEHyEXJ8nvw1bhamFteiv2VAzxqw1t4pOcmsZNG8SHbhcJR952MOG0woVM0
 rym91oxT+yyy/KaRN5RbSn5RPr8b4s4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-0aFcczPxOBumtE8voqanJw-1; Wed, 03 Jul 2024 18:50:48 -0400
X-MC-Unique: 0aFcczPxOBumtE8voqanJw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257c42f035so31563265e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047046; x=1720651846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bN0cTm8m+n/A4V5Tgbpm0TUAfWebEt6LcyWQbTcpz4g=;
 b=YmxK1ChFTWiZXaSzcUKdkOQznq7LXh5San4VZpGKqakM4fs+Td2wPbCoEUSOL7crJW
 BM0916w4huw2OHlxk4WryQwS3UD11GRG3W3B8V8aQBh/sc7BjY58a7KBmA+2LDn5A4Vw
 wiSUfoUvmgiLX5cG3cr0run7x8j7R96PE2tRYoaFmo04sIbtLl9eREZcCB9a7Zsup9/e
 TbY6ZxYleb9lC46fWj46Z9AkzJ7XsZtgl8cZQlLMLCcuqhAK612yM2YJz4x/iN7SM1MI
 MZrG42OmIWK376ixGWrAbErxHPH9Wpp9AfJyjNcWUh9CjdMFdtOQ04b5JrzreQoF6g4x
 ArlA==
X-Gm-Message-State: AOJu0YzW0AcIws4VBr5B1wB3UiY+YvNdQp6Qb9IQ1BoyRWsYOMgPK3kp
 EhintXVLgO62M3FMXnhbiyRoJ6hk+/wHReU502AF4JHg4VMb6ukhM1hz2Cn/rmVfIajr39zw4iJ
 IeuXtDLSvcEkaO+5Z0r/O9rnKFZPCfdMMCI6PZmShGaN6OA9RNLlKuKjm38DAYy+LMwRHMO+3Tf
 6L2aBmXOOk4v7KPNlbZ7MSdJNA0pYYtA==
X-Received: by 2002:a7b:cd95:0:b0:425:6dce:8c54 with SMTP id
 5b1f17b1804b1-4264a48c4e0mr219965e9.33.1720047046520; 
 Wed, 03 Jul 2024 15:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSRByIk9k3rv668VG4ZZgH3goxRYz4rLRrmCDty5VxwTtGnPAQNDI+3zjtturXDoaidQjDg==
X-Received: by 2002:a7b:cd95:0:b0:425:6dce:8c54 with SMTP id
 5b1f17b1804b1-4264a48c4e0mr219825e9.33.1720047046024; 
 Wed, 03 Jul 2024 15:50:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd634sm17094726f8f.9.2024.07.03.15.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:45 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org
Subject: [PULL v3 85/85] hw/pci: Replace -1 with UINT32_MAX for romsize
Message-ID: <6a67577d8003428bdbeba61d32a9f8158f12624b.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


