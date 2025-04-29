Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CD4C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lfP-0004Er-6g; Tue, 29 Apr 2025 10:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lf5-0003mP-7u
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lf1-0006b1-JW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so40884395e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935807; x=1746540607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg1vT0Z/kKcz1VyaWx5HUe6zicIy/oQzxPnBZl9mXrw=;
 b=H+5ob/45GKczEEZW8o5PqgsVP6V58hb6IltywBddL3pA1/R7Z64Z+NVCfZHuM8pKjt
 YW1qv0tasaEmC3V3Pgt663r17Vt3kPiYlzlKTkBwFc6rlelJ9U5c3DgWosV3UAqQTV9b
 LMzsT9gL5+TnPiWqvdaxbOUyijVSP6RvGVyKEG4+p0TMMRIZrrMoS5SKE1ki441StXEA
 O1Llq6XHQHsntWGodM95kXkl0O+S+cJri+xYlMcmtrR5KuXTXrSW04FE81jDNUzyc16q
 OqNfAcikxSOsJk0TNqtB5IIpDe3bUQUdlHJ9JiN6bWwlxLDvQ3BGJuiLrJy5zBTtwajo
 7ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935807; x=1746540607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kg1vT0Z/kKcz1VyaWx5HUe6zicIy/oQzxPnBZl9mXrw=;
 b=A/++nffezrxCfK0vCVYFSciGXu8l7FvTh0nmK/BdyFAjODwaWrkJRvXbZBwDmLVbXi
 bkOlj8KcKonU2NhQajjapJ3PEVXPHnSEYR823m7IpE+bSeZITeJK3+TkszIAYzpQAkFt
 IKZ+jwpF96lIfy0Nhj/6HvX3+pS4aPKsEM4j32Wrs26c7alJbOnOu5+9x2kWIt5Pz+m3
 FEFxAM8aEe92WvWhJBCvOQYFttcYxKlzsPgFclMk84E2VdbxwZkAeZaAS7zDNxZzVKip
 iCL6NfRMlTVT4eZF1FADYsTARm4MT+Fqlpl6S+ajyD9E2jvdnVUVJmR3NDfyjmg+W0Yn
 kWog==
X-Gm-Message-State: AOJu0YwSLvhTcUyox3CGj5ia3bDGng5PTUQeYwk7xvsQSzTbcOWnMPdH
 Ld/FMsIbNW4eGD9+79lMweDstdb1qEC+IJUvyBbMt1DRFcZcWCHz3iWjOV6rP62RmaRIzBTjzSu
 i
X-Gm-Gg: ASbGnctS+Ut8wm6OJAKgIABPhrIAPIMFycnGiuNw6AR7WvEcASiwSVX3u8f2eNGf2vO
 xPWr4QiePEdJkAVm5bBCFpYMibLUB4QwaS7I9m4FERrChyoQR5zLZ/+wZd9xL0PxayIImX+Xqg9
 2Cuxr4iE8O1LV4y23T4usIBchi1eBpzj66xHAwuCVAPvPvk2uS3G6uBLpkm7AjuqsrIXp5HlRbu
 pFAb+J4VyNm346bnxPFbvK4J94Q0LAGKUrPC5k+H/6Q4wCLkfYySaKTanwsN+8B7l0NM78BP52c
 p75cGR3ZjbFq/knyEAqeebnNnAztVBua5NEgl1ssZIUhqsKLeSxV07JcTi7rKI7VR94URTJmLLE
 olOwnRdo3Sveme4rNQa9X
X-Google-Smtp-Source: AGHT+IHk7wVMcAJ7CJy0vuobbFvebze2eS9GHWo0ETRu1ZsJtGW9dbeiW/vYH8PeKZOs2G5zL2MZCw==
X-Received: by 2002:a05:600c:35cf:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-441acadf4a7mr31220505e9.3.1745935806849; 
 Tue, 29 Apr 2025 07:10:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm188405515e9.0.2025.04.29.07.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:10:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 19/19] hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
Date: Tue, 29 Apr 2025 16:08:25 +0200
Message-ID: <20250429140825.25964-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/vmxnet3.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index d080fe9b38a..7c0ca56b7c0 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2238,6 +2238,7 @@ static void vmxnet3_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(obj));
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
@@ -2463,22 +2464,10 @@ static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
 };
 
-static void vmxnet3_realize(DeviceState *qdev, Error **errp)
-{
-    VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    VMXNET3State *s = VMXNET3(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    vc->parent_dc_realize(qdev, errp);
-}
-
 static void vmxnet3_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
-    VMXNET3Class *vc = VMXNET3_DEVICE_CLASS(class);
 
     c->realize = vmxnet3_pci_realize;
     c->exit = vmxnet3_pci_uninit;
@@ -2489,8 +2478,6 @@ static void vmxnet3_class_init(ObjectClass *class, const void *data)
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
     c->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
     c->subsystem_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
-    device_class_set_parent_realize(dc, vmxnet3_realize,
-                                    &vc->parent_dc_realize);
     dc->desc = "VMWare Paravirtualized Ethernet v3";
     device_class_set_legacy_reset(dc, vmxnet3_qdev_reset);
     dc->vmsd = &vmstate_vmxnet3;
-- 
2.47.1


