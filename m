Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95502C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZV4-0007Pv-8d; Tue, 04 Jun 2024 15:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZV3-0007HG-6S
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZV0-0000sB-UJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=QoFfV9FrM3w9Ykd5AjfWHtpqnS6XpdmpC7HCDYvv47Ec+xI6myuton9MvStKJaC14dmUgl
 LZEt+Yf7za8h7UifFaWWuZoROS+JZBbgWdFO7IuQy0b2gtxWa0pqOdenr1poZ04+ipGti+
 1QgK/Xn4pEnN1+uulz1/YalBrc5boZE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-RK54PfahOryfk7mbDNq1sA-1; Tue, 04 Jun 2024 15:07:08 -0400
X-MC-Unique: RK54PfahOryfk7mbDNq1sA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4215604d4a2so1746245e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528026; x=1718132826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=o1P0AYshxy4Vg7CV2jrO0akWT8lDNtB4nBUcxf32Hts0caJ18Bgwrvs5Yn8jtRuzIL
 HwhQN29FxTlMM5ZRW5nyVcFZiKluXKmjTvkqVdjFO9stLrY7JptPH2VUf8rzjFkcsaIr
 UiZOx7iRklWk/QXK0wVkfDep2QdB/8udKsUJWYdKD2gH0QEKZhuDsSmxdPFWyESEiENd
 HyIxzmpL2BIczuWN0/z4JaYrG9Q4nWt1KrTn6UnxH+poOF0lp+hTeUpXmuygXJNLXtX5
 8Tu1vq8W0vpo1jJE+tPhl0qZ8EBcItLe8Xbpo4PndGvzCB2XPoquetKHp5cZqVkn3dip
 l1TQ==
X-Gm-Message-State: AOJu0Yym6sWvnbdU/3+GOmdWm1X8ginOl8MPS+9xSwRM5GxPkDGaiPW1
 UiM+BTDDLErgA9101w3JlHYsbVeHISO8HSzVP1zLzzDId1ZV562CXCtJP7mWtUeSbo6YSuF3gDF
 98d620XEN228QkUt9F190oXYCEzT/1Zz3ahfWc5of/ThluJ2cr0PsFI/whhcQTVFjY0bnEXXk8I
 zxQYnf8urD97YiyG24N5obcFhb6yVpsA==
X-Received: by 2002:a05:600c:3155:b0:41f:fca0:8c09 with SMTP id
 5b1f17b1804b1-421563393d0mr3267595e9.40.1717528026381; 
 Tue, 04 Jun 2024 12:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiv50TYIbSEk0CYNaTOAwM6d///BS30WglIOV4ybTJnZgzqoePnakqaMFWz6uEcARDTjHKXA==
X-Received: by 2002:a05:600c:3155:b0:41f:fca0:8c09 with SMTP id
 5b1f17b1804b1-421563393d0mr3267355e9.40.1717528025778; 
 Tue, 04 Jun 2024 12:07:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm181448665e9.13.2024.06.04.12.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 19/46] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field
 to output payload of identify memory device command
Message-ID: <d51322aa4bef0ac909f945f27e9bc79fabb5a0d0.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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


