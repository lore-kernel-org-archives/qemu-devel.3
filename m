Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0452C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpa-0000sv-Fy; Wed, 17 Jul 2024 01:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpY-0000jE-2D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpW-0001yS-EC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbnyQIMsldrG9/GwANRlbJs0iH4w8UnSheZCAFBdDoE=;
 b=CBU4h3dzFF7cqhW6f6t0CvKKGAv3JywHizmwgUyrOe2H/9K3sy9AlGti0Cp06YYidxgKjY
 0sWRp2hrNJ8t/zPACDspvgXULy3PpviqkdUpORigmKi/l3eJqY4uQnGGTd2b26be4Uqh31
 xwCD/YlvLmXCasQmKY7TAB9HyLOW4L0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-ET2ZLuOsM1y5ttd8r602Yg-1; Wed, 17 Jul 2024 01:03:50 -0400
X-MC-Unique: ET2ZLuOsM1y5ttd8r602Yg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso41747965e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192627; x=1721797427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbnyQIMsldrG9/GwANRlbJs0iH4w8UnSheZCAFBdDoE=;
 b=I+WwMfECV7APbjJu0pYHU5Nhec0I3q9iHd4boAr6uW4B9eCAF5LetVRkUzG4NH7LnO
 2SmUmRODYDzreplxXq4Pf2HQk7oSPXRSKT339kQlHcxtMDuffkBJzn3lRyVfIQml3hYv
 MIdM74zjwvy+B/Vc/dJfjkkm2vMR7LFq/IyIFiGn6GayQHqAvqPdA9SA/zeQVyl1ib8A
 ImTYiSWWebMIzEobeAWiDQPetE23JKZd3xo7IQ+Skmsds8yIR4fzzRV2sCzPS81mzy3/
 WXA3AWuEDsXRaTNnDb28gOSl9Rzn3K2C52EBfxt+7dbnpF/dVxSUMDsfneFUyegN8vlQ
 GT2Q==
X-Gm-Message-State: AOJu0YxH1XmJDd7zHRwfk1qvMyv3Ezx7ZNIN0i8vIXbbhTe7vJ9BNmLA
 XqHiwsLEnxCccOIJOOaw2qiJS3NQc0MW6KgeNKjIQaN/7dWxJhjP6JtRqabyGr2ViZEIOBhGjqL
 pDwNxFpdTqoN65HbfLgj/gG4Rav8vLuQISjyT3dsYPxbZ6oPK4pkWFgYGPTJlZh8ve0nLMRCVZ/
 74qxWlzB630BU3+BOieUgV9feNLRdCqkpgEKi3
X-Received: by 2002:a05:600c:3152:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-427c2ce7bedmr3008375e9.22.1721192627752; 
 Tue, 16 Jul 2024 22:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErtDjsDt+sQrMXLLCQrLyGSe7EhKYsVbJMS7Ry+HQOCsJue6vDfyNpDRVB3jeSKfYXVC6/4w==
X-Received: by 2002:a05:600c:3152:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-427c2ce7bedmr3008215e9.22.1721192627391; 
 Tue, 16 Jul 2024 22:03:47 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db03900sm10649195f8f.92.2024.07.16.22.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 06/20] scsi: fix regression and honor bootindex again for
 legacy drives
Date: Wed, 17 Jul 2024 07:03:16 +0200
Message-ID: <20240717050331.295371-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 3089637461 ("scsi: Don't ignore most usb-storage properties")
removed the call to object_property_set_int() and thus the 'set'
method for the bootindex property was also not called anymore. Here
that method is device_set_bootindex() (as configured by
scsi_dev_instance_init() -> device_add_bootindex_property()) which as
a side effect registers the device via add_boot_device_path().

As reported by a downstream user [0], the bootindex property did not
have the desired effect anymore for legacy drives. Fix the regression
by explicitly calling the add_boot_device_path() function after
checking that the bootindex is not yet used (to avoid
add_boot_device_path() calling exit()).

[0]: https://forum.proxmox.com/threads/149772/post-679433

Cc: qemu-stable@nongnu.org
Fixes: 3089637461 ("scsi: Don't ignore most usb-storage properties")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.kernel.org/r/20240710152529.1737407-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9e40b0c920b..53eff5dd3d6 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -384,6 +384,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     DeviceState *dev;
     SCSIDevice *s;
     DriveInfo *dinfo;
+    Error *local_err = NULL;
 
     if (blk_is_sg(blk)) {
         driver = "scsi-generic";
@@ -403,6 +404,14 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     s = SCSI_DEVICE(dev);
     s->conf = *conf;
 
+    check_boot_index(conf->bootindex, &local_err);
+    if (local_err) {
+        object_unparent(OBJECT(dev));
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+    add_boot_device_path(conf->bootindex, dev, NULL);
+
     qdev_prop_set_uint32(dev, "scsi-id", unit);
     if (object_property_find(OBJECT(dev), "removable")) {
         qdev_prop_set_bit(dev, "removable", removable);
-- 
2.45.2


