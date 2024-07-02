Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44799C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAv-0002UA-Az; Tue, 02 Jul 2024 10:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAr-0002OT-G9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAo-00080y-HR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=DYLDX/3EBozASiv6n/Y5lQ+FBqbdyzUJ31enMJt7X28dI0mPELwaWZSoM4ZYUIasa2wFs9
 NSfIvyauHVFs8qjkKFzhy+AaZS3HUbejdmUCI6xDOAVMvuZKeUJ2mM6agkYUeCZszPZV99
 776keFrO0S8fNyTb2X0/fkiY2pW1pkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-UAbieWo1N4OjF9e-occ0IA-1; Tue, 02 Jul 2024 10:07:56 -0400
X-MC-Unique: UAbieWo1N4OjF9e-occ0IA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso29671135e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929275; x=1720534075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=sUDHwmlDPGsl1RnbUGeyPorKIM2E6ANn5R4+h7CnbTHaUYAuRl83Da3K1+0101Mhsp
 Z/PMKhL8eCxvwWYXJVMqpyMxiraOWkilS9tCynG3VFhw7dfBQ538L+/GKSKYjpwRY8XK
 WeIubEI5j9JroK8w7V1VAf+QXRP9yLzR1yiZisbF+37Wd5oGA7lNLfWwImUM5KPDM9uI
 csm/JBU2bBXoeMoD8kGSSenH9dZkxHcuv02w6kpDVmr+ujE0oobCnDv7YJf8uHfl+hzM
 EsF7A9NC0UiX9QxmSMYZTVGikBA0Yx5oOpf9DFwf77fV2q2sGqRwkQ/rGJ8G2T+mn4Qk
 utHA==
X-Gm-Message-State: AOJu0YwnbTUB6N6296fsk/yrMIS96ZPs/hZYVc641/gLxX4s6wy/d17+
 IULsXHLdbO6lx/VORlNVkLCSa8PLQ2/hMd0CHk+gDsFmQvRxvKFwjnG0p8s0TC1crmzK0dbP53w
 iQTwWl5fu33dghvL4pLQAPKReDHGnl2kAJiwRKezSjs9jD2N+Do/aZQtOTmw4xUOMR1b4iny0vO
 nl8NwszKAx0FLorNS0bLEB2vvP/PthWA==
X-Received: by 2002:a05:600c:492f:b0:424:a5d8:ac83 with SMTP id
 5b1f17b1804b1-4257a03acddmr47831615e9.41.1719929275147; 
 Tue, 02 Jul 2024 07:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1hlY2v4BJ6yEstzJiLUzKEAnawVgGZ0v0W1UoDtIl3vwYLFT+TXU5ilYgRZBh0PN35zuVXA==
X-Received: by 2002:a05:600c:492f:b0:424:a5d8:ac83 with SMTP id
 5b1f17b1804b1-4257a03acddmr47831405e9.41.1719929274634; 
 Tue, 02 Jul 2024 07:07:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8cd8sm13303291f8f.27.2024.07.02.07.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:54 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 18/91] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field
 to output payload of identify memory device command
Message-ID: <7a21e5dedbbcec11ebab7a53186085f09a53f9e7.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


