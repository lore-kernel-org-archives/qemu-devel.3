Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8ja-0003fl-Cm; Wed, 03 Jul 2024 18:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jV-0003UO-Lb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jT-0001MX-JK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=WZlby+uO1+S/JH/q8kFmJwi4wLu73xNeegptpDy0euys8I4f8YlIbSVoSAU8PMAa9tRrpc
 N5tbuN4JQnB0MFeAmiUjwJYzv+z4NQ5mbNqP6R9lJnp9t2GAu7bSTWHgU5xryeMWY5QTrd
 cGNFP/6L422+fX9O3cZoc92IvcVkizI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Raqsfjl-OiO3YhT-TIM_Kw-1; Wed, 03 Jul 2024 18:45:44 -0400
X-MC-Unique: Raqsfjl-OiO3YhT-TIM_Kw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-58d152f7f67so2163a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046743; x=1720651543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=Qfs03rv9EFLE7jOBzs+clmfwfBXQYKXhOz159OC/SGf76YEpb0UQL5FDqWaMnQhYYz
 Y/MSxC/zAwwaePm1ObiRzJ+AntlW12mR3nBb2oypm/cbjPIILYkGcCJjpc0QyBX2GOXS
 3iCVxt1GWbIaMw18FfTsKQ0hFxgB2lb4YSdHtBPkEbiPb8pBy4Cnd6w0E37zno8gJsKr
 uaANwdZHiBxOpEhdN0SjYI0Gccxs0d5uEPIuMaWe4PJ9jROs/EAjNx9j0WL4Y+Q7YuxP
 7qM8+M/L61UcIVhoRqeLAQRkAP50qla2VREtOEqtoZ8Od1ylm69UgDYetG4HrPpkSC+p
 mvJQ==
X-Gm-Message-State: AOJu0Yyy+w7vhHdS3/3GSLpXmbLcdf5LRjctFCASMXxJt1dxhQt/8qNs
 0zmxbo5Pal5NlgDU2neSiNeBIaOYeeE0RKMQZ9xymBlp8vz/+2nBlkv/HHX7Os+6zgf0bj3kADa
 Q12TFMCNKAYVNeMDEpXgfrJ2j3PM7V43JD3l1d662FESLemP0+MykblfIiDxWUsMlPMbwP4K95z
 HCqSMx8D9SoDZeRYSz8AS0vkUJiAd6Vw==
X-Received: by 2002:a05:6402:2547:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-587a0919556mr10421990a12.33.1720046743291; 
 Wed, 03 Jul 2024 15:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8XneULyE7BI0vXo7U7CggJHhbMaGu29VQXp96igGoEXH6Ez+E85gtATcAr2hxrM81v/uUUQ==
X-Received: by 2002:a05:6402:2547:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-587a0919556mr10421958a12.33.1720046742268; 
 Wed, 03 Jul 2024 15:45:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58614d50464sm7570642a12.69.2024.07.03.15.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 18/85] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Message-ID: <7a21e5dedbbcec11ebab7a53186085f09a53f9e7.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


