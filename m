Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CEFC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb7R-0002jP-32; Thu, 01 May 2025 17:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb71-0002IT-Po
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:31 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6z-0006hb-Tm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:31 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d57143ee39so12492415ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133588; x=1746738388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMeOw16G5YJoFKNLKg7ffX48/cP4PPOz2cimaZ7eFnY=;
 b=uJeoy0Toqw1Sx0ZbDY69SUTez5FKtpyUF/vyXj0MMLRfTIbNUAWD5KPxww22tlrgmP
 hoNoM4d2eAlu48pK4j1k+yMG1aX1vt8lQSjJiNoJtN4TE5P+Zey/epSS+yTPXcS/JZAj
 y0TsoZorucbgUTEVtmqht+JUs5PvqoSQgfs0ZLNkRgWxRTzFKUfb7k8fmyDcjiP0+QR6
 UPA4tFbB01kbZOJ44UXjO3+Ot5NxZlSZz8a5dIQ+tbNNVnEvkYchdLvq+V46JVjLPKgk
 xdnI2aYqdCBeXBOiCBZpNI6MpgkJNDkb8pcQVsNd86pYMJWr/3bynfRrNzln/HYh6mYA
 GRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133588; x=1746738388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMeOw16G5YJoFKNLKg7ffX48/cP4PPOz2cimaZ7eFnY=;
 b=cD/f/BKN6Jsv+cOCsOrFpmyGDK3Y+znvaTrjn5HTAmJB6Ta6oXQW7IHevq6njlXLxo
 ClbZ7wZkWEJylh18+ufc9dIjkkgjQAFle7DXesB9LfvwZDTnpNcHd2mO9jkTVw2hKbR2
 r3Wa5wU3W4Yo2fVJYBSSjr4P+mcMjS9/Df9KfObKlqt9NoMhNXmpg4oZCtWylHLj0rba
 p19eRCzBiAgUI09JhM1+7idQKhFUP0GiqKbaQpV4gPpbB42laSOKGmbOM/bFHfpZnJaK
 v4uQv7IacwGhWZx4QRwfin+Udf5hEZ1CMAwmQ2p/wz2mYJSSWd6XgZE+tob3zZByxx3p
 D+fA==
X-Gm-Message-State: AOJu0YxoOZ5xQbWcyVaL/2c8cyxO6tzKT15z2edx2Enb6OiwwJFmxReI
 ty1ccrQWkkBJAfa0r1qFx+DL4Af2BYnafzKSq/UlSoZJcjgLHbJVH13yQgOKxvSovk99PWG9QL0
 4
X-Gm-Gg: ASbGnctO3hLZo1v+MNBbONg5Cgdq1FCTbZ/E21eCOdmUyqFuXmE7yv6c+h0eJLvKL6W
 MzfthAYsGkhpZAPLu+kp1/Bmb87yWH4QGlfei6d+D7QWG4QAa4UBRA3dfHhBrQE5Tln4oTWoNvJ
 RsJmcnBJNhK5Qx054AqswrWb6N3ZkZuROR1zwkRHmKRO4QRDCS8F9P5IHxLNCXP9c6bSWQYUNig
 povTIhyDbQNWHfunRoYTuyBnYsINj5/psbteCHy6lIdLp2f02FxUJmVDi33BvAvP5CTOSgBF93t
 7oe/CT8UJpIXc0mKWzXdukevz1el6jks/vsiG7A9D90Pvtrm5YZ9Cn0lXpTmS+pa9hfl16+FiZi
 F9fxIFI8UxeWvcB2GjuKgvj6jKA==
X-Google-Smtp-Source: AGHT+IGiykznDY7kCV1tAHoOQmSa859e6UjlvbN5+afJVtfJd9G586VEFeRwWLG9CW/ZmPIDInfXKg==
X-Received: by 2002:a05:6e02:19cf:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d97c22820emr4819675ab.16.1746133588571; 
 Thu, 01 May 2025 14:06:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa588afsm45456173.75.2025.05.01.14.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 10/18] hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_INIT_PM
 definition
Date: Thu,  1 May 2025 23:04:48 +0200
Message-ID: <20250501210456.89071-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-il1-x135.google.com
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

VIRTIO_PCI_FLAG_INIT_PM was only used by the hw_compat_2_8[]
array, via the 'x-pcie-pm-init=off' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_INIT_PM (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h |  4 ----
 hw/virtio/virtio-pci.c         | 19 +++++--------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index a8dd613ffbc..d1f7403cbdf 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -34,7 +34,6 @@ enum {
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
@@ -60,9 +59,6 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
-/* Init Power Management */
-#define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
-
 /* Init The No_Soft_Reset bit of Power Management */
 #define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
   (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5b86a9a447c..9ec92d5a736 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2226,11 +2226,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                          PCI_PM_CTRL_NO_SOFT_RESET);
         }
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
-            /* Init Power Management Control Register */
-            pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
-                         PCI_PM_CTRL_STATE_MASK);
-        }
+        /* Init Power Management Control Register */
+        pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
+                     PCI_PM_CTRL_STATE_MASK);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
             pcie_ats_init(pci_dev, last_pcie_cap_offset,
@@ -2323,16 +2321,11 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
-        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
-
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
-            pci_word_test_and_clear_mask(
-                dev->config + dev->pm_cap + PCI_PM_CTRL,
-                PCI_PM_CTRL_STATE_MASK);
-        }
+        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
+                                     PCI_PM_CTRL_STATE_MASK);
     }
 }
 
@@ -2345,8 +2338,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
-    DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
-- 
2.47.1


