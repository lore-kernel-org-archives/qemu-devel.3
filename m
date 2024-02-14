Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC8C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFT-0005jY-3o; Wed, 14 Feb 2024 06:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEo-0004bF-Gr
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEm-0007G8-T3
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eTezAdoG0+PsCPdXqD/75aTZ1DfSUbN39Tdfu99ToIE=;
 b=Q+F7SFFq81RpXTU67l96czZ/gCsg/FDZ+UE6/g2MuRrNwAOn5u4hjS1zSg2g71Haz6blMe
 ComQW/OU0H578pZ4sJ38ooBlzdNnOfAPAavV4m6liLsJ7fEewFNo0al32gLu19YfX/DQsb
 8xmKl/BiJXS2V5krf0/9F9YfOFVQrhA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-o4yM7GrPPIuGTtkcpR9dvQ-1; Wed, 14 Feb 2024 06:15:34 -0500
X-MC-Unique: o4yM7GrPPIuGTtkcpR9dvQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3d4cfc543fso24541566b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909333; x=1708514133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTezAdoG0+PsCPdXqD/75aTZ1DfSUbN39Tdfu99ToIE=;
 b=u7xRn71KDva0J6eOaPLU99tPCHb93EXW8MI8L2YZc8YS3rtT/3VdRydYI3Pgymgh20
 XDemNSnspJqeqTj5e0qV+N8Cn/Q8x6iSe6uXAtWslEwU/yZYcWuP7GyJXzfU98133fWI
 /r93pKgIBxWsDlcOXRaQPN9/LfepkIZiow23okX30S4wR5bD64ZGsWn/n+GvHPMnCvla
 /hbDmJgqPQYudgBGD9T8DO7VxaWTywJQqAsAvM7mjfqLsTIn27CJj4pu+BTNGIHNEbEr
 vW62z+Zi6OnC/5eY6yO4yeRu+WJ6ol2fJbH85S6csR8kQP26SBD42UTbZOGnORiHf3ME
 BNbA==
X-Gm-Message-State: AOJu0YzcYn4aFNRveT5VXaKBnSnJPTKzGVJ6KB5fgnOGhlr64G3xKUhc
 IS7kEy+9NTfBOi8gLuuk45V+4Vw/jk/xfVN7QsMiHwvucvFKOM4ffq3r1oUJyZmJ2gfm52WJmpq
 OzKYVqdcJi3RlFz1KdWph5FctV3iwhwH3b9GxB+xVUCXd5ya6RL0GpVOyU0X1QAWoYNDiAuvhEZ
 JtfEHkLU/mUm+IGsJjrtLZMwFlxl44Kg==
X-Received: by 2002:a17:906:4e91:b0:a3d:47dc:e3a8 with SMTP id
 v17-20020a1709064e9100b00a3d47dce3a8mr1108685eju.3.1707909332863; 
 Wed, 14 Feb 2024 03:15:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuvX5JrJhja8Hb5a675iXcwVT+jyUm6OpRJzI4Rdd5MYNqgiFjbB4jFanVZBDLA7JluPAgXw==
X-Received: by 2002:a17:906:4e91:b0:a3d:47dc:e3a8 with SMTP id
 v17-20020a1709064e9100b00a3d47dce3a8mr1108670eju.3.1707909332541; 
 Wed, 14 Feb 2024 03:15:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMOZFH9/cRncfd9zJ5+f+XcqGy7xhbzIrYnnXaeZMSoC546466i3v4BCo17ZJs3S2hAwGC9wMRrnUZEh5pMnONETpNaeG5NqHjG/QoE0b/CWP2A0Ko1FNjnbXlGwQiBsUOf8HSdGjwauY/l2aKmI3IAXsjkA==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 y8-20020a170906558800b00a3d409ebe5fsm549997ejp.119.2024.02.14.03.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:32 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 42/60] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <f7509f462c788a347521f90f19d623908c4fbcc5.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Note that __toggle_media() managed to not only write something
that no one read, it did it to the wrong register storage and
so changed the reported mailbox size which was definitely not
the intent. That gets fixed as a side effect of allocating
separate state storage for this register.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  9 +++++++--
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index befb5f884b..31d2afcd3d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -202,6 +202,9 @@ typedef struct cxl_device_state {
         };
     };
 
+    /* Stash the memory device status value */
+    uint64_t memdev_status;
+
     struct {
         bool set;
         uint64_t last_set;
@@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
-    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+    dev_status_reg = cxl_dstate->memdev_status;
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
+    cxl_dstate->memdev_status = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
         do { __toggle_media((cxlds), 0x3); } while (0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..40b619ffd9 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
+    CXLDeviceState *cxl_dstate = opaque;
 
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
-
-    return retval;
+    return cxl_dstate->memdev_status;
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->memdev_status = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
-- 
MST


