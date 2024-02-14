Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CFFC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFh-00067c-AX; Wed, 14 Feb 2024 06:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFH-0005PO-Fj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFF-0007Np-Il
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylEcLLQelxgTT5SRTb3yQG3L55Bz8TDs5AeDEz2G4ss=;
 b=UEpJTA1gsI9ZVRUnh6zfSXv0qJewIh4aNsdjVLUHskn9IVpssZBWs0PyChepyei8jnxT6Y
 MSuhX8ETSxeNp+TGGBSJdxpL3XxV5j2O/Sm4qcqE/kJUZe4kVIXJjp6pBEt6rePCfuGYKm
 0X8kE3y47DAY0g48ru1kq1CuJ9xynAk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-jugRfqSBMeCanekjl0Bcng-1; Wed, 14 Feb 2024 06:16:03 -0500
X-MC-Unique: jugRfqSBMeCanekjl0Bcng-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5620e5747acso669440a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909362; x=1708514162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylEcLLQelxgTT5SRTb3yQG3L55Bz8TDs5AeDEz2G4ss=;
 b=IMZsXPbgt4Tu1dT1MKGk1l82tiH9wDJot1mUTEOcfSnpAGltARkmS/OFvqZTUeRkqV
 O9wfe5EkZkz/24h2dWS1qTZbSur74gi7nxfNQBEeOBlIKxi9k9pgh0S0ArHVNNlzE9V+
 e7rDp7CnOq+9wHNAdWoy8Vw6jEtsYQovVupc7hbBqI9Y/fT03UGPEyF4fWtJ9AuMmIFp
 pRqbttbSD4w6mojiig6RaCxdUHg7YpYKdjAjY9TanL4w3XfBrVpvfQLL6ucFW88+wz99
 mwZJH0jqR/9Tb7mia3l+xWFuunqgDNOTsECI3TlGbszlBz0+I5M1LVYYwnDJ70f/y1FS
 /Zyw==
X-Gm-Message-State: AOJu0YzF6a975+joXY+HuKhmWwR9YLnGdT/vvToa7VrUwttW+phOiiAo
 Ci8Hn+Nf06N4rIhVyFFmN8/DkRcW1LKzabG5amKp4LGvf9yUd8visGh/rPY4nUb0STx5YYbIg13
 efMkSFK4DYpRe7kUE5KsMCQ7bp+Hp+rYtkepUPQJGBBSAnNDqKE/zfX3R7eMunn5pqfoc8FhJ58
 8gVvNwtYYEVCMzsoocuYxWcqyuDpS7EA==
X-Received: by 2002:a05:6402:5410:b0:561:5e21:8b89 with SMTP id
 ev16-20020a056402541000b005615e218b89mr1669576edb.13.1707909362094; 
 Wed, 14 Feb 2024 03:16:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnUwzQAgZoc9Y5U/DZp5GdynU0j6oJbT2Ym7gFOc/uY0hNc2e0ipL7dvWlG5LDXc6G8RoaMQ==
X-Received: by 2002:a05:6402:5410:b0:561:5e21:8b89 with SMTP id
 ev16-20020a056402541000b005615e218b89mr1669562edb.13.1707909361788; 
 Wed, 14 Feb 2024 03:16:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtSe5S3zQApolxxgTdW5XYX+GyKydWvcWMijuVQ+AQwhvLgtrBWh8eK6uauhNWG1vV6W0zWfI+AuH8iU+XT4PD4z5qd6fEIAh7c0t7BvPovVBz7zcvuBXelKvGSjyn+Q==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 i23-20020a50d757000000b005621e66c8ddsm710069edj.17.2024.02.14.03.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:01 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 52/60] hw/cxl: Update mailbox status registers.
Message-ID: <202f651469b7a6440577cb6a985cf1eb538ea899.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst the reported version was 1 so there should be no changes,
a couple of fields (where the value 0 was valid) were not
defined. Make those explicit and update references to be based
on CXL r3.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126121636.24611-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 17 ++++++++++-------
 hw/cxl/cxl-device-utils.c   |  6 +++++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 31d2afcd3d..9f51c586d7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,7 +189,7 @@ typedef struct cxl_device_state {
         };
     };
 
-    /* mmio for the mailbox registers 8.2.8.4 */
+    /* CXL r3.1 Section 8.2.8.4: Mailbox Registers */
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
@@ -310,39 +310,42 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
 REG64(CXL_DEV_EVENT_STATUS, 0)
     FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
 
-/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
+#define CXL_DEV_MAILBOX_VERSION 1
+/* CXL r3.1 Section 8.2.8.4.3: Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
     FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
+    FIELD(CXL_DEV_MAILBOX_CAP, MBOX_READY_TIME, 11, 8)
+    FIELD(CXL_DEV_MAILBOX_CAP, TYPE, 19, 4)
 
-/* CXL 2.0 8.2.8.4.4 Mailbox Control Register */
+/* CXL r3.1 Section 8.2.8.4.4: Mailbox Control Register */
 REG32(CXL_DEV_MAILBOX_CTRL, 4)
     FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
 
-/* CXL 2.0 8.2.8.4.5 Command Register */
+/* CXL r3.1 Section 8.2.8.4.5: Command Register */
 REG64(CXL_DEV_MAILBOX_CMD, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
 
-/* CXL 2.0 8.2.8.4.6 Mailbox Status Register */
+/* CXL r3.1 Section 8.2.8.4.6: Mailbox Status Register */
 REG64(CXL_DEV_MAILBOX_STS, 0x10)
     FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
     FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
     FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
 
-/* CXL 2.0 8.2.8.4.7 Background Command Status Register */
+/* CXL r3.1 Section 8.2.8.4.7: Background Command Status Register */
 REG64(CXL_DEV_BG_CMD_STS, 0x18)
     FIELD(CXL_DEV_BG_CMD_STS, OP, 0, 16)
     FIELD(CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP, 16, 7)
     FIELD(CXL_DEV_BG_CMD_STS, RET_CODE, 32, 16)
     FIELD(CXL_DEV_BG_CMD_STS, VENDOR_RET_CODE, 48, 16)
 
-/* CXL 2.0 8.2.8.4.8 Command Payload Registers */
+/* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
 REG64(CXL_MEM_DEV_STS, 0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 40b619ffd9..9df8738f86 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -366,6 +366,10 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      MSI_N, msi_n);
     cxl_dstate->mbox_msi_n = msi_n;
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MBOX_READY_TIME, 0); /* Not reported */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     TYPE, 0); /* Inferred from class code */
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
@@ -392,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
     device_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
     mailbox_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
-- 
MST


