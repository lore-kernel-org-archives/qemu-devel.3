Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC8C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwX-00012f-Tp; Tue, 02 Jul 2024 16:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvT-0006le-4v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvP-0008FL-Ge
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=JDD3xbbOkd9s3BA4Hevvxzs9U/r0+wswgL+iccdGxWEI2/qjGYlsJ7Ftm6zl+XCJMjoZsm
 SLOfkL+YL0nGoG2jp+Z6A1nJCvlR0wzUciGYo1B4j6viDQWfMOrA4Duepk2SKeVIZYCx+F
 ShgWznRST5ESgFxImrG+t8ZrNLrciWY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-5g4sq0akO3qcnmfgbP3w0A-1; Tue, 02 Jul 2024 16:16:23 -0400
X-MC-Unique: 5g4sq0akO3qcnmfgbP3w0A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e9557e312so104837e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951380; x=1720556180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2rkXgOWy7oaxjC82Fwhko4ewIXnfZhtW9KkNOPqa7A=;
 b=UUdV2cTMMj7TRb1MnteCvG8KKmoXFhBdbdSH5hNI8SDYaXGnBnSfPLHom8+6GxbBYw
 P47m3Scaym2qC7M+anJLOR1EVVKf9w1P8qpYw+kEsmq1KEZoDh8ivm19+h0AWvVYmPlu
 3i8Ft36z7wa7TLK6Iy2rqjUJ/AnV8JSgeuBCrEG/XzgztxetRdPskNS+Q8tAPCYKeIqR
 G//6JZHk16a59p4RyPjQwJpWxxr/Sl5ALL6KnVCOCYtPSlzZJxSRxVHd3nCE09vN9Zv/
 wYpY7F7NPEnNiuQ2yUAgHVsVGUJL/nvQ+YKVlCYcZxN77voWKDeNGAxZnn9w6njAMH+Y
 qbIg==
X-Gm-Message-State: AOJu0YyLKrghNwjuhxq3A6ctTM5vWeq4hYk1IJKiLNjGgZQGcCNOyH2s
 onjGWQNhuKQ5TUuYXRm2qRDygD8LNbctFuTtODkHUqkfn8ZjeKytL0znUtEyWyMNaXh6dLONtdN
 iDX9YlNp1zv3/jYN7FrzZfQuI8jM0Qlp49kkWgy8sC8ypSW9h9WtHC5y06CVTSbegmprWh0mMVK
 spvNSONfNUiO12cRSO744tkU4XNL7qkw==
X-Received: by 2002:a05:6512:b84:b0:52c:820e:a7e7 with SMTP id
 2adb3069b0e04-52e826fb7bcmr6432708e87.50.1719951380521; 
 Tue, 02 Jul 2024 13:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpiplkEeg9yvkzTcIY7koZ/eXMoIHafPxQlHAcMRpc78LeC2zoyt7PHhLar2rBhHNeUxbxxQ==
X-Received: by 2002:a05:6512:b84:b0:52c:820e:a7e7 with SMTP id
 2adb3069b0e04-52e826fb7bcmr6432685e87.50.1719951379811; 
 Tue, 02 Jul 2024 13:16:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm121163025e9.22.2024.07.02.13.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:18 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 18/88] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Message-ID: <7a21e5dedbbcec11ebab7a53186085f09a53f9e7.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


