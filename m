Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5381AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb7R-0002m1-2q; Thu, 01 May 2025 17:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6m-0001d6-J8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:19 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6i-0006eG-Vq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:16 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d91db4f0c3so7471395ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133571; x=1746738371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrPNr0Aj9fn0eddJzV+2Kcwv9eRua4WW4O8jcqwzOW4=;
 b=cOMx2CDvkQSjjXA6Et2HTSy0eIvhbetCnvRCHp4WB/JnV9ZxNziKmkE8kR5q6u97rU
 cd45lCvdBZrMjUAt9NwzLXYY8u5J2qcvOsVZToBbjZt5rslkzQN8ldpUZTxc6XMByrGY
 FLe7Ru0C/Q7HTfdJVWvhoXiu0ECf8+5eCayYZYBG29clWviObq1sNlR7jM2b789O8ZFF
 52oXfGLQGp+tIZKlf7fp3mMW1uyLvj8KVQWZDL5eXS/yoZ9IJ7dKiwKVjdPWGYQn3V8a
 z13n/loOk53k0BHNSogpJ5C0tvX/wnW1ZDnbXq/LeOEisQK2cWioWMY/0PHg07+3mclh
 KbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133571; x=1746738371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrPNr0Aj9fn0eddJzV+2Kcwv9eRua4WW4O8jcqwzOW4=;
 b=JUKgSzrkgWkbM/Zb20heoAQtISpklFO+etvim8qDZRi6BdFR+zEXLLc21MxfA5TTvt
 sJmZzuTuUbLzVn9LSkd5JiaD0jiTPiaXKonxuXc/qouXnVuc3WGEO/2Z92XK/nWYYYRd
 9DWs6ZFXRS4YhP59eq8eT44U0BS/bSs84yUNHyB8+eP4s7USOf+y0vGUHAU3/ElzUx6h
 kHTQrJ8b5XbGmeQZoLeubTeASEVfhyXwVQdDfrl0WGpSnITUjEB4SQKU1qAZRynlxe8N
 mXKy0hPgqf2lUcWWQP2o0dM8oBwxmU0EheXWI/3qon/nGPgx2QJ4ZHWK2OPv5R1uO2CD
 5aMA==
X-Gm-Message-State: AOJu0YxqFY6FcshTkAbPKLI9Q4K2GsFrk11UQTY3lOLysW89Puo9tB05
 xL7Fg4cgZlaYfmA0TQFm91wi3HQvwHLv2XeKz5J3sqES9tvkM9yX5/SXt3auYFRTUbcqDlTfPii
 M
X-Gm-Gg: ASbGncv/LWUofzj1q1yjMOL5dvprS8MzACqhFkZ2rTG2+T7NF3IeejQjNfiT4giWhPD
 vbFmKOGt7aBXz4+L4nujY9LHhTyAvSUHfweXPjzttXWok1zf5mwbEzRpyoArRl+yDLiOx6RyEe2
 al7t2AGG3s8dqGEZxQwyPiKLcqgaBd1H9O7HMkBcum0CxgkYlYW0gznafvL44Ic7G8U6Wr1a/Zy
 rIHqdy8wteXgScZ6IJREO/3ylPT7JlhyYFXwuBjTUF/SRLww9PHzCLSp0UAv1xuY8WNIWZ86d4b
 bQ/OBKU753rI8mNuxuM1ueVQdicSozUhBiHGNXtoKbEZ67+2aau3zVYe5ZJRetmxwDhSHItwYcZ
 u7ubkRksLkjgAGaw=
X-Google-Smtp-Source: AGHT+IGacAzQMWgI/LEam+U9zfxt7TyjpF2feQ63IFLhoXJ2ZySmggQRPvskD9DNBjzgWmUilmnVmQ==
X-Received: by 2002:a05:6e02:12e7:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3d97c18897bmr5250535ab.10.1746133571433; 
 Thu, 01 May 2025 14:06:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac80f6sm43264173.141.2025.05.01.14.06.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:11 -0700 (PDT)
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
Subject: [PATCH 08/18] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_INIT_DEVERR definition
Date: Thu,  1 May 2025 23:04:46 +0200
Message-ID: <20250501210456.89071-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VIRTIO_PCI_FLAG_INIT_DEVERR was only used by the hw_compat_2_8[]
array, via the 'x-pcie-deverr-init=off' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_INIT_DEVERR (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 8abc5f8f20d..ed142932f7b 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -34,7 +34,6 @@ enum {
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
@@ -62,9 +61,6 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
-/* Init error enabling flags */
-#define VIRTIO_PCI_FLAG_INIT_DEVERR (1 << VIRTIO_PCI_FLAG_INIT_DEVERR_BIT)
-
 /* Init Link Control register */
 #define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT)
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4e0d4bda6ed..0075ae590db 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2215,10 +2215,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
-            /* Init error enabling flags */
-            pcie_cap_deverr_init(pci_dev);
-        }
+        /* Init error enabling flags */
+        pcie_cap_deverr_init(pci_dev);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
             /* Init Link Control Register */
@@ -2349,8 +2347,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
-    DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
     DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
-- 
2.47.1


