Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18261C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeP-0006hT-1K; Tue, 12 Mar 2024 18:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcO-0002sX-3X
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcB-0004cR-8G
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fScw+GbeSb7Y/URvyjrtWLndZz8ykgk7NaxW0WCLA+8=;
 b=b6lJdB7RTbPoKIpwqvo9kC/d1BCPDE+Ve/0RPT4p/GBlsZ2nUcrrQKjQ4klod9i3WRNKGr
 ZYQiNRIpqjYUrTGY5FbvQzpNVv33+zDL+Be6w+qoewGU9krdoeKWHskxc6e6UMZwj0hAE9
 NnRD0lAMEshCDrgsvYrzcVB4MPxQTUQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-OqxLRk_fPCWq0SEIBN2z4A-1; Tue, 12 Mar 2024 18:28:53 -0400
X-MC-Unique: OqxLRk_fPCWq0SEIBN2z4A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45190fd2fcso278651666b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282532; x=1710887332;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fScw+GbeSb7Y/URvyjrtWLndZz8ykgk7NaxW0WCLA+8=;
 b=fucTjwYQuESfLjfJSe10oU5xYduBWtLp9uaC7mqEbeM5c0whVzn/ZMqOo4DVOyv7XH
 wVc3y+63Pn/2Q30JpRchgoUrfKo5E5+k4fc2H14LrZdevJxY6zTzc+FNK/uVEgWoTGgd
 3i+STeMbpdic7bYBa4B45IaAjT8R/ExHTvS9pMAAqVy3L0za5wtihSw0TRDrZlOs4Ne3
 yyhgQD5+fKo/h+7+Ho7Thdzt7oZWjfSDWe6YMXuSAtAZjP2TDyklKZz981lNapLWmS+3
 WPRqd+pVFUMYCTObnm7IDDbJrxzIrwHWkLv0sQlQrSxgcCZ5mxmKs7RMJq883kzic60J
 XNQA==
X-Gm-Message-State: AOJu0Ywbnc1X3XJ+4O4L/47mnj5cNFRrNuObBMkEnhWePSdFHk9oVl/R
 UAPcVFSZ+dcayT3Dq3wKiuuWd70XjWSwwTfGXwsykWa6MjXgDjd1iTAN2EhJmLhrEYM2NDJWUOD
 QMZOdAj8unCLv3ae0p3LT+n/glyvRIlpC65DlfVBQwH/BodHvKyrdaA+rY80XzTQlvyPZA0sJC0
 venhBrygPNOj9xg+HBnaz2aLoOZdsY53Qk
X-Received: by 2002:a17:907:7d9e:b0:a46:30f4:6321 with SMTP id
 oz30-20020a1709077d9e00b00a4630f46321mr5098891ejc.58.1710282531877; 
 Tue, 12 Mar 2024 15:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvzpcqEL0CG+1pobs8bJpTj9boPaW9IzYrExRw17aftRGIy7teSuOAfCNdc63I+EFuN7Mylw==
X-Received: by 2002:a17:907:7d9e:b0:a46:30f4:6321 with SMTP id
 oz30-20020a1709077d9e00b00a4630f46321mr5098879ejc.58.1710282531463; 
 Tue, 12 Mar 2024 15:28:51 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 l19-20020a170906231300b00a449d6184dasm4213363eja.6.2024.03.12.15.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 61/68] virtio-iommu: Add an option to define the input range
 width
Message-ID: <01e7e4921ccebb81cebc69eb648040a57be4f5ff.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

aw-bits is a new option that allows to set the bit width of
the input address range. This value will be used as a default for
the device config input_range.end. By default it is set to 64 bits
which is the current value.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240307134445.92296-7-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h | 1 +
 hw/virtio/virtio-iommu.c         | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 67ea5022af..83a52cc446 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -68,6 +68,7 @@ struct VirtIOIOMMU {
     Notifier machine_done;
     bool granule_frozen;
     GranuleMode granule_mode;
+    uint8_t aw_bits;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index aab97e1527..1326c6ec41 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1314,7 +1314,12 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.input_range.end = UINT64_MAX;
+    if (s->aw_bits < 32 || s->aw_bits > 64) {
+        error_setg(errp, "aw-bits must be within [32,64]");
+        return;
+    }
+    s->config.input_range.end =
+        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
 
     switch (s->granule_mode) {
     case GRANULE_MODE_4K:
@@ -1544,6 +1549,7 @@ static Property virtio_iommu_properties[] = {
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
                              GRANULE_MODE_HOST),
+    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


