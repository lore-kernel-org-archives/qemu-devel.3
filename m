Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184B3C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICq-0001Zj-BN; Wed, 28 Feb 2024 06:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICn-0001Xg-0v
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:33 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICl-0007Gx-7N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:32 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so4737700b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120067; x=1709724867;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YPSiR6IwHlPrV1jxSt9NcR1fgHWl/R9keZ4bHjE5Nwo=;
 b=Nd5s4j1WTpEsffUDxXZkwwg8nGpxPL6LLdxNwSUHtofJwEjn812evSH+CimBSZn8Zz
 AzZ2VXlTeA5H4SY0sf8G+nDOsn5PJodj0pWiBZZhgowfnIwAKN+fX2iuP55AseEG1WJa
 8+sSGZhLqY01Ng0Np6mteGGb1iroUg56Hokczt07u7VExSqNpGpbE5ePRRIkq5PCGJWk
 AaX9mimsfQ+RH4jzvi99/u+ec5rx0NtdCie3Lpwxo2+Lxsp+Wr8nWGnSqcLnye+Zbzwy
 4PE5Wst2u1RCeoGr9RQ1Q8mDaYUhQ3IQzv1ckIqvc2qgPz6Wou/1+49SL9+oVsjmhXMc
 IJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120067; x=1709724867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPSiR6IwHlPrV1jxSt9NcR1fgHWl/R9keZ4bHjE5Nwo=;
 b=uZrkLoUjwoKxeKV2rsPO8jb5z1x3Hrj0wa6WGsG1GcoDnCEwLqcdcpTtI3YBHTiq5v
 ziHl2bobRnh5SzJkJGuID0vK9ae33kWycAKFPndX6aehCdyjVG/HZANHwN82B829u2U9
 RjW+qenbtf16DuJTglc6fw9uLdC+uNEJMP3ujyEQI13me+NnTik0k/0O6ZdEvgs68/b4
 eFOX5ApyH5PV4/uKmQLY0jqxqWO6reFYutvoUoRu0l0vcCk9NnC5neqCSehqDpTqwZlP
 O5/MOQyHcpvGQEMsWN7JPppNt/S1ZHdwiF/Ob/pKyHitgkn2jcyJf2/zrIxgor9tt1wG
 Ew5Q==
X-Gm-Message-State: AOJu0YwX0h5pCTSuaDLT1oIEti1jHbR+jhNbrgoyYtpZsLgikMVbhEGW
 Zkc+qnr7mw24aC/rvU2jcjIOkyYjk4z3iSmrym03bmWM7vPQXRnQGclKmfnNpUM=
X-Google-Smtp-Source: AGHT+IGkKI+Y235zLvt/oRSPJKcfgRKk4cd7NSzr36e6vIhB15SK4lWgj/53BKggjB1qeoq8qPJuHw==
X-Received: by 2002:a05:6a20:b209:b0:1a0:e647:5d58 with SMTP id
 eh9-20020a056a20b20900b001a0e6475d58mr4426049pzb.23.1709120067473; 
 Wed, 28 Feb 2024 03:34:27 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 v14-20020a1709028d8e00b001db81640315sm3078458plo.91.2024.02.28.03.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:23 +0900
Subject: [PATCH v8 12/15] hw/pci: Replace -1 with UINT32_MAX for romsize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-12-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 hw/pci/pci.c             | 8 ++++----
 hw/xen/xen_pt_load_rom.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 54b375da2d26..84df07a2789b 100644
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
index 03422a8a7148..6bc64acd3352 100644
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
2.43.2


