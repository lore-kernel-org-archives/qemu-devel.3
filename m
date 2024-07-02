Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33606C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAy-0002Xa-Ae; Tue, 02 Jul 2024 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAt-0002Pi-Fx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAm-00080g-Mr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=f/yxZS8XfLBn37P7bovOimpV2RrrMhevsmKeTd7JInRz9xCoVEHV/kONnOiOigCQLmXJ14
 NuPOoRcpOzt8GbKBW52MeiVp+IirBHlBJmoygO+MjPgF74Y9cbwEsBq1ejeQh4XlhL/8gZ
 MKKUbJneaHQsuk8OQm6i4lvEVdGqg0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-YOBoCjopNKm_sfNqT6rJQg-1; Tue, 02 Jul 2024 10:07:53 -0400
X-MC-Unique: YOBoCjopNKm_sfNqT6rJQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso29669845e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929271; x=1720534071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=sRMSCF6yss8clufIDb8CBa5nuQjf7l3df/FFKpLJ+jYyWyWDnChlC5mExtftNIFQR3
 noOm3yAxUmHwTCzhU+NiqJWiTc6SXk9Q8Zr6fkPgwRuFzUMGT3oaNdFvaIRxG3XqUwwI
 tpecAPrE+lzZk/mDhd37gEcxFkxwuEx68YQEzKmIcdJKeq1gMqKhTB8pZqNe3neaTtvq
 Oohd0lRTuy/ItcHg/dYZDvSwQYoQ33sfgwq6G7Akw0vqCoTJdAC/wYR9m8hlmyp7C5WF
 ctArDwZYRN8AGNVD79S1gGdeO8hmfcHPj0ibOQSRszPV5sMxdOUexasf/Hp42ji91pM4
 gT2w==
X-Gm-Message-State: AOJu0YyEfOwG3EBRf2jszf/vmiy2ukmWmKaHw+32z4DuouBskTLgDQy8
 RX3+D3fyamABAkFr7RbXU8NgYCT73qgZtpMl9R+xJSuqBQFeG1r1+jXR7aXap6kkGq23yXMrEm/
 tcYg909QvJoWE6GVmGBwtRCzT2seBf8kfjQKUadrNWhucHxXhs2IUHntNOmAsJYCw1wMX1jHbu3
 AtADKsyUWjLFG2f9Yal/RPqACtlB0FsA==
X-Received: by 2002:a5d:598e:0:b0:362:4ce:2171 with SMTP id
 ffacd0b85a97d-3677571c1famr5822540f8f.52.1719929271683; 
 Tue, 02 Jul 2024 07:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6J/xB/tWrSfg2unlai84hYbi+kiEygCd2zLRXQLV+Fp2UjpW5lITljNwG2JXdSSNf6W+k5A==
X-Received: by 2002:a5d:598e:0:b0:362:4ce:2171 with SMTP id
 ffacd0b85a97d-3677571c1famr5822505f8f.52.1719929271128; 
 Tue, 02 Jul 2024 07:07:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a23b349sm1509179f8f.36.2024.07.02.07.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:50 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 17/91] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <67adb7979b6c1151a906d99f19fccf1e789316b1.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Gregory Price <gourry.memverge@gmail.com>

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Heavily edited by Jonathan Cameron to increase code reuse

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-3-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  2 ++
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ccc4611875..a5f8e25020 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -301,6 +301,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c9f50f0f9..2a64c58e2f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1424,9 +1424,9 @@ static void bg_timercb(void *opaque)
     }
 }
 
-void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+static void cxl_rebuild_cel(CXLCCI *cci)
 {
-    cci->payload_max = payload_max;
+    cci->cel_size = 0; /* Reset for a fresh build */
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cci->cxl_cmd_set[set][cmd].handler) {
@@ -1440,6 +1440,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+}
+
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+{
+    cci->payload_max = payload_max;
+    cxl_rebuild_cel(cci);
+
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
@@ -1458,6 +1465,14 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
     }
 }
 
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                                 size_t payload_max)
+{
+    cci->payload_max = MAX(payload_max, cci->payload_max);
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
+    cxl_rebuild_cel(cci);
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
-- 
MST


