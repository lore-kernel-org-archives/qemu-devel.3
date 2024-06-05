Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0A4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Ah-0003R3-Bj; Wed, 05 Jun 2024 19:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Ad-0003H9-Sn
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Ac-0005bU-7W
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=gt3GpJHlXaw3NxGacEd7H0r5lTx+70gHHrzQ8l2D3eb9ROtOw8XlBgJYVEYnNSEjKbB24A
 8fY3GTe7aXmvDQwMaQhsp52I7b5PRIgqsYc+55ySks1WNVV1Ypf+Po1d4q7uUAgYPzHPju
 eQu08SnJyrF6WzVcseu2l4sOf+EzldI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-iuQseTyZMbaif6El0OWXxQ-1; Wed, 05 Jun 2024 19:35:52 -0400
X-MC-Unique: iuQseTyZMbaif6El0OWXxQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68ea01c455so8554866b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630551; x=1718235351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=hglUIrFXdWmJ9+5u5bxcJWqgtI0SJuSORvLPSLK5+2Lluo9To80B8AlSv3IxvWWX99
 RW68hFbzcuKqTp9NsrtmKChzO0NXxn7mFVQWxnpo+EKXx6tjVo5/QoQrNinhdKKDWGGW
 NXp/rs6vPLsibyl2fh3jYvQxiRST1sUGQJAq0Azmb+rdtjBSJ6zvejN4yRJ5EpKZmzrp
 37o15jW4zMUeTxrbC9pX5uSiXcMsgq0ZcVkaD1VXnK2J12VNjpr54ngcbQZV/ro2bEAZ
 EoroiVbS8chSb5+cY1hp4+G4ZzPHElr+Mq3UcfGJXoSE9M1EM5uPTTIG3m/BWBz4XfF7
 Thxw==
X-Gm-Message-State: AOJu0Yw0jRXE2s1JqQL+e3efZ7xkUlLoSssmclNBGJljfTZlE+CxS3IZ
 7pWmo8mhrPF3+prgui6XauigBc6uQfO8naYUs1mD4C2hLFAHFIMO9fqVN/OOLAfIZqUv6qHecUu
 dI2pnYGieYEwsDgnzhtDmWEeSDuWjM/Nd8bZkWuyumTXYlTLywJd9XZI8AlDHrf4K2sgJRLGX/7
 MLPRcMeDc/i6GAKqMVnGQdQh1hIAmBlw==
X-Received: by 2002:a17:906:bcda:b0:a68:f83b:22fa with SMTP id
 a640c23a62f3a-a699f34bfaamr257780666b.11.1717630550893; 
 Wed, 05 Jun 2024 16:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsjN5Id0H8dtL24u2t9MhfHZ2YZ+LUfmZzW9KpyS/LTQxcvvuxYE/YTYUzvBq/BnO5pXRwEQ==
X-Received: by 2002:a17:906:bcda:b0:a68:f83b:22fa with SMTP id
 a640c23a62f3a-a699f34bfaamr257779566b.11.1717630550404; 
 Wed, 05 Jun 2024 16:35:50 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eab0asm6490866b.134.2024.06.05.16.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:49 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 18/41] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Message-ID: <9cb633dc30908fd94762ea3694f117b60042ddc8.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-4-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2a64c58e2f..626acc1d0d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
MST


