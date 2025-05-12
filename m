Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320DDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlv-0005BL-Gv; Mon, 12 May 2025 04:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjp-0001CP-1p
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjn-0001qh-7g
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a1fb17a9beso1474355f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039333; x=1747644133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwde4m2vNeqC4ktqkmubqWfBQE/iNIb7Ju0SaXdDpA0=;
 b=f2mJv+maOY+tLHlnHcez7ClcjskiYbJrTWu4lgO0aNHpS1t0+KSy5SItXZ3zp1qkvC
 o7NN4pOrXHN/Ej0ltEbuSg5n3OJcOOGdZu9TOJcCtkiAVJnPCacQWmGTEkrp9W85yHns
 xplGXPLSj+T2jj68EgELnJPyFn0jI5crglrLL9VXU19hGHC2Z9b//G6PkEtqrLez+toU
 nKC60JrJinIZckrO+nAgcS2h42X7aC1mhhCA3q9q2YZFR8KQ/3nxZVGdqK42vpH1nJqM
 RrLtvSNmzO/6FJquZqyrNonSO1eqmRy1juJYdLEy15nyOncokaoBeZBQHzIknnPYQZJb
 LeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039333; x=1747644133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwde4m2vNeqC4ktqkmubqWfBQE/iNIb7Ju0SaXdDpA0=;
 b=lL1pJdwZ4VI+buTBtXSvghx1XEU4XIKttBrVS9VkmEuYjykjG3cVoZZaxJCaxKHtez
 xh/aBgFSh2nbu0p6157zTjZ3UDmd2F+1+9kCsjD5l7QzXoMK+Hkr+Xs8sSdJUAwF8Yo8
 9Yu4afpfnlPSi/PQE2Tu8bitMVUKKzyw8Rjrbh+wzcBnbil/T5eSBubD/wQjwDcfpL9/
 wh2e/w97MFqMmEtImUXOmKaPy8W7b1+Afsl4ck+i+HxBcKwsSvSFDNfXJsg5fimB2LhA
 VUXJGvZos8dMXqKoMdkTAUo9seWpZYN8VR20RQGXivJG/BggZGIiLCBkaYzXSHLUTNe8
 wbRw==
X-Gm-Message-State: AOJu0Yz6suaywIT3SyfjM6xTmY4sfOWLCq+mbqbqGkBCcpvLxeY4cpbM
 LMtAVcH+qjyOJDEL7zgaZ03oMnc4vN0G7toZSrBfqhHssRKWHYtdtTwf8502Ue1UUXZixbKcO38
 aAWXqtw==
X-Gm-Gg: ASbGncsr7WP0ynvnCcReen0/PhDLh11warI2gT50vZd+Dse/zakfxP0TBRtFOexCWPf
 r+oyYfAPPcezkSnBsvoAvDacz82npx/KT1XzcWsNnZYwnMcaJ3ocoOy/71yuSqvgNICNMTX7qR1
 nBl1iPYf+Nr0ULHCi2h7iS/ppNQ12420EKxgrUOi9JmwXi1kw6vS13X2xn1z81+KAFJqmWgtJm7
 W8dP6E77VQ581fYS63ST/o2aSXk5wbscVZyJz8NRTMDeqJYAIDcR2qwL0T39JBAmkzEmhQD+g3n
 Q8R2imR1GYNY0OlEvo7r9Qyb1aWGjgYqoIFHfDxrQuFqLcXG04jZjwRZm/09toDeZxg2N1xO2Wo
 dc4RxnBfXjWkqV85kfCBDbCw=
X-Google-Smtp-Source: AGHT+IGLIGjCy6rFcgPwzZzoAoDNB1akMyFgeaUhgtRicAzL6BcWt3dSoyRzF79dRSjMA5zFGNwt0g==
X-Received: by 2002:a5d:64cd:0:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a1f6436694mr9961992f8f.14.1747039332786; 
 Mon, 12 May 2025 01:42:12 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c599sm11874990f8f.94.2025.05.12.01.42.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:42:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 16/19] hw/scsi/vmw_pvscsi: Convert DeviceRealize ->
 InstanceInit
Date: Mon, 12 May 2025 10:39:45 +0200
Message-ID: <20250512083948.39294-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Simplify replacing pvscsi_realize() by pvscsi_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/scsi/vmw_pvscsi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e163023d14c..7c98b1b8ea6 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1267,21 +1267,15 @@ static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
 };
 
-static void pvscsi_realize(DeviceState *qdev, Error **errp)
+static void pvscsi_instance_init(Object *obj)
 {
-    PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    pvs_c->parent_dc_realize(qdev, errp);
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void pvscsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pvscsi_realizefn;
@@ -1290,8 +1284,6 @@ static void pvscsi_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    device_class_set_parent_realize(dc, pvscsi_realize,
-                                    &pvs_k->parent_dc_realize);
     device_class_set_legacy_reset(dc, pvscsi_reset);
     dc->vmsd = &vmstate_pvscsi;
     device_class_set_props(dc, pvscsi_properties);
@@ -1306,6 +1298,7 @@ static const TypeInfo pvscsi_info = {
     .class_size    = sizeof(PVSCSIClass),
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
+    .instance_init = pvscsi_instance_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
-- 
2.47.1


