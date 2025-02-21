Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C9C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3Q-0004Y5-Vq; Fri, 21 Feb 2025 07:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3O-0004V3-Hn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3M-00070Y-UZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7MQix8FGUYJVo/KUMfZ0aNvVpXePxV+3xwtbN+SCMWk=;
 b=druYtbjCd6dpn4MzN5V6ALL23t789u46dl+xUwmsap7zsPyMgTRtLjW2dM9Ryn1qgfo4bB
 m5aQmI+g4qvfC9ylWXjgnWCdSjDvKb/36u0gT26FSYuj17ND4C8HG+bEMrHYLPD1/SeTF+
 A6VgzdYCO2FZKhlRq9Mk23HmUwBRVUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-FLsUqF-YOh2O203JQdHCbA-1; Fri, 21 Feb 2025 07:22:46 -0500
X-MC-Unique: FLsUqF-YOh2O203JQdHCbA-1
X-Mimecast-MFC-AGG-ID: FLsUqF-YOh2O203JQdHCbA_1740140566
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2f78aee1so940948f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140565; x=1740745365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MQix8FGUYJVo/KUMfZ0aNvVpXePxV+3xwtbN+SCMWk=;
 b=Aa4ojany2VYTMi5XsVPEt4BNa5pcu42Z+8lnZpv/phl5yonmfMkmT6QVZvLcuH28s7
 GCW2tlJ0g2+EhYu2Cq2pX26MeIwARSX9svygx3XVCEQINyaIoM6eSmUp/wTZHJZi8AID
 dEPUQgu4cALpYPIbpfPpKG3MNhfdS3tM4Jot3swhxssxkmSKQ5A5plhd/bwXisxAwcYT
 +U2DRAitIKcrRmIqM41FXMDHG42AD9nUXKFrfF91kVgEoqzEQYVqT/PfFv88OwDVg/WL
 rm32sQJ91AjYBU+Ky7jfnKMzv+9g+f+7xcNOLC9fznkyrFxwcIkv1oXLzbqm++KKm1JV
 F7zQ==
X-Gm-Message-State: AOJu0YzZV7vUm/L50OHffgfvmNWfUEHEcL8JYMccl4lYYOkySjfgi3DB
 Au+AUIv92LtVl3NFTjBhKMC1OiCWO5IVb2OL3MdvgQ9hDEDAFYehxhaDCWYT9AA0X3STckrFfRm
 hS9NPDNxFRBov6gd9+a7GGMa6ViCXdOD+XOk57MstSY2KcYrVd3BPQkCKTNw/a1JzQDvrVlRcqs
 0zNtxwSg7JkgJApgKHaQB4iAriA1G96Q==
X-Gm-Gg: ASbGncte/6iFha3WZSlew4hgEAUxJ4oPcoiMo5V4EFsBRRYBZs7Jh/Sm773hcnXXdX4
 KussXvZvMFMfA9L8oh1OYitpH/rD3IWAE9RgdtPWK0f26f2wPje2cWyHLUOUwl7NIZG6C8llQUU
 hzsYwbPvZT5HUf2yEyuyLe7R+tpOOFbmUhb5lhtzSQrYV1MJig9wg4pQryBMWOaufq0sc1TW/MV
 0A8JClbH9WsfXhmHJjxrkUlR9SfdA/bRbrlzETzI91RjqSkHHih7MGnV2+NxoBVBDjH9RGkbg8T
 3xvVyg==
X-Received: by 2002:a05:6000:4601:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38f614b6e05mr5807387f8f.8.1740140565496; 
 Fri, 21 Feb 2025 04:22:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrAnCXaIYDuswyI624BgoJT7WSDuQgIwmDuFOSOQPkmR5Qq/oSSfJJ031qH7RaRMR3m2YJNw==
X-Received: by 2002:a05:6000:4601:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38f614b6e05mr5807357f8f.8.1740140565134; 
 Fri, 21 Feb 2025 04:22:45 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7987sm22856411f8f.87.2025.02.21.04.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:44 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL 05/41] s390x/pci: Avoid creating zpci for VFs
Message-ID: <b77a2778d9bbefc6119331ce3083d85d69d7a0c1.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VFs are automatically created by PF, and creating zpci for them will
result in unexpected usage of fids. Currently QEMU does not support
multifunction for s390x so we don't need zpci for VFs anyway.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-3-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eead269cc2..8c5eb69f7d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
+            /*
+             * VFs are automatically created by PF, and creating zpci for them
+             * will result in unexpected usage of fids. Currently QEMU does not
+             * support multifunction for s390x so we don't need zpci for VFs
+             * anyway.
+             */
+            if (pci_is_vf(pdev)) {
+                return;
+            }
+
             pbdev = s390_pci_device_new(s, dev->id, errp);
             if (!pbdev) {
                 return;
@@ -1167,7 +1177,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         int32_t devfn;
 
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(pci_dev));
+            return;
+        }
 
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
@@ -1206,7 +1219,11 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
          * we've checked the PCI device already (to prevent endless recursion).
          */
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(PCI_DEVICE(dev)));
+            return;
+        }
+
         pbdev->pci_unplug_request_processed = true;
         qdev_unplug(DEVICE(pbdev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
-- 
MST


