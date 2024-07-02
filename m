Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E9AC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOju6-0003iq-Jv; Tue, 02 Jul 2024 16:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOju4-0003bT-V5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOju0-0007gx-Av
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=KfkpY7D5aBuNEzolRU9y+ME+Zk7FThUAlqaCbiRgcTwin/5r0ba1vUhtA+4rDJdgmAVCR4
 4+NKuYJ9iRj7EZme5MGmlex1IHeC5aJ0e9hpDZ2LfDAK/BjxRpsR4Nmd3hanWbbbdKHj+u
 a1ETS6B5QZnlPuL9S6T6X8wu+6gLJc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-fzu_Vyh_ORubrIipbjQw6Q-1; Tue, 02 Jul 2024 16:14:58 -0400
X-MC-Unique: fzu_Vyh_ORubrIipbjQw6Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257dd7d40dso15987275e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951297; x=1720556097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=IFkwG5bNHP6sc5ciKv8ytWJPUGyzu5ZADlf1UVlZKl0NjzO1pzMzb+4IwR/eHaZIJj
 nBqtJ/DkusO3USFqf2ufFvP4P10oqUV+SLbpZ/oKY8Bh5LVdmBLbJaOZswXOg3RnLeKU
 rhYpfp/wBAL4U8XSV0rNCk0rK2SJPjkuY0CTfDtK6945HSL87wPzy5BbNHAsQ8Szm565
 c7zgEoRaG3X/cWPQMdwDt+PAHc4En7r3jFkvptBZAjUwyLPpm8w0QnwU1OV/Zz6y5Iji
 vYNeNSGyVjv2YyzWNynlCCMNLWa8AFpuN1qy9/wN+TUuzxHoETZ0t0sjMEKh0Dj6LTAj
 5ojA==
X-Gm-Message-State: AOJu0Yw44EpLjxgLWySmbA9lLwXutnWObEVc/SYXQMEcEKsyhvXXCOJc
 QCQ+WbbcZU1KKky/2v5oZjVJJRtyHsSb01SHKrXyVT+kKNzEmXf8ePCGVjldUX97ML2Rasj0tE9
 A5/i3qBFMttRTmtnVZS6oXTapiIY+xVYEX7CVyarFscSkh70fxn/5tFHEF1gFZJ0dZxIuOz1xUC
 kKa7CBDWw8eC+WIUkWK+D2Pm0XBlNOKw==
X-Received: by 2002:a05:600c:3508:b0:424:a664:485a with SMTP id
 5b1f17b1804b1-42579854746mr84708355e9.8.1719951296757; 
 Tue, 02 Jul 2024 13:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFflx5ZMJmV5Wh/0gQv36J5GrpNDIm/FeqZT0xW+gKu+GSNWieiycKTdZFwIQr9QTsEzhaL+g==
X-Received: by 2002:a05:600c:3508:b0:424:a664:485a with SMTP id
 5b1f17b1804b1-42579854746mr84707945e9.8.1719951295730; 
 Tue, 02 Jul 2024 13:14:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af59732sm211603165e9.11.2024.07.02.13.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:55 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 18/91] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Message-ID: <7a21e5dedbbcec11ebab7a53186085f09a53f9e7.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


