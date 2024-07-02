Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFDC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwW-0000mD-AG; Tue, 02 Jul 2024 16:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvT-0006lr-76
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvH-0008E9-TL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=OxYJdMFK4jlkbeUXrfYdZYtjY/uVcoOT84wldxOIZFJxbIdn/lEpjAIRtWUwsqKfYt9Y4X
 nawxLMImu6cqO9jdTwyyf+IarlComH9zilmNyf8ozbKrPjLNm1/sMJhQIFy7Mq2QUTQb32
 O8Q8UCdruujOAxObBneZ0Zd7k8UgkM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-UQhdNBsoM1CfRuD8W_ENdw-1; Tue, 02 Jul 2024 16:16:17 -0400
X-MC-Unique: UQhdNBsoM1CfRuD8W_ENdw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso32061405e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951376; x=1720556176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=T99A4Z8S/b3EUqNiJt2v5GtQ26dCXrwwdY/QnYYHeC4q1UjMtt0qdq5zrUBK+qZpJd
 SPplm29J3Zw7eyQT6Ot4VWQ9VJWW/BPzYTGuAzVaI4tfCoSUto5K+7vO7U0UZ3IWAslL
 eL6HH4dImugxY5noidabqpdhfcPFvuhYML65kTFQJxxT8ZCCaMtigW4OFph5nGPjhtOK
 oGsf+hoBzRgcP5sZl8LHg1ZMbnGmbBnXcTLb8pY6syJSuowY1eqU3vMXX4/NVitG+BUp
 vD+RyIGiGJF0CIt1XQNhPk+FQISzAipABjifR8J6xEVdmnzR0+r9wASq/lkChlpIo5gc
 om1w==
X-Gm-Message-State: AOJu0YxeD90WMQy4kjEt594wieKdpCO1LlWPl+zP+6E3y15jbRk+2amL
 ZvBG5HRCais1r61Dj9ixnebH6ceTnAjuAZ9tzqmaJzjw53JLGdIRidTu8iYnmbL1fbI7YpmmK/O
 9Il/ZETgDWnKBv0BoX4m8UKW2l3tE86/CpYVbqk9U7bIjYq4wuyXR+H1qwXFzJXL1fyEqH1jM0e
 EUTd9tpPIvHli88HbRJBoPDLRBaR3lVQ==
X-Received: by 2002:a05:600c:4fc5:b0:424:a578:fc7 with SMTP id
 5b1f17b1804b1-4257a009bc5mr65746495e9.3.1719951375823; 
 Tue, 02 Jul 2024 13:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs/b2dbQq3/LFxWzA+Lm+hiGN+lKyXcLw3vDQgXE2wNam1S+VG7xCABGc3t9KPlH3OoMlCgQ==
X-Received: by 2002:a05:600c:4fc5:b0:424:a578:fc7 with SMTP id
 5b1f17b1804b1-4257a009bc5mr65746275e9.3.1719951375289; 
 Tue, 02 Jul 2024 13:16:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a102bc5sm14090979f8f.92.2024.07.02.13.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:14 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 17/88] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <67adb7979b6c1151a906d99f19fccf1e789316b1.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


