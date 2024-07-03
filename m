Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6802DC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jg-000495-5M; Wed, 03 Jul 2024 18:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jV-0003UP-Tu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jU-0001LG-7g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=azgngmo286x2WoMi5lFr0k4SDtxjTnQXxKer/TQOXqlkfuFWeUq+QSkemkjRO3gwg3nz8P
 MrYfX6TZAw47tPDWB9P2iSMs8gWejZlWuuggMoC4xscRmBxK0G4cwFaNM9Kfuz9zgL98/D
 teBVuu423rCKuMXK5bxFZvMjx896FSQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-OkcMpryLNvegmI-L_0QqsQ-1; Wed, 03 Jul 2024 18:45:42 -0400
X-MC-Unique: OkcMpryLNvegmI-L_0QqsQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57cad6e94e5so2907495a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046739; x=1720651539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=EDeJdDcvKrOuYUI7+0+eqvksHP69+Ba1yjDUxt/LN2gmQCvK5uBnyYFHr/NpSlmFuV
 R3LMDg0L8YEoNGJRyVN8ZRhdEXkNAuyCcWYXV9/ePIyy+z98qI26HP19WvjhoK7vOmy7
 pqtHSIdXpfZXUXCvl23+BHVgjpOQfIIJHoi3Ol9HXSQvs/4H2lqR3rTE77X6MYR+p6g9
 KogvGXAHzAyUDIqN7bOiGfi//DjbX50NKfXQk2Or4DsbNY7iOACP5P5EGQM4CD5wlqNF
 gseUmtTScK7mLZUmNqWcgMpGyDaNHSDYIbfZDvtRb74lFKK+8FNOLKjM4O2yifaP92tk
 skAA==
X-Gm-Message-State: AOJu0YxUgYX4TvTZV9PrYLcmttg1hdPVQhlvRKgWU+Fuy5gRxYQnhSYW
 ODYT6zzk8OAEAdx22hQk8pFxO98czciADEMp+SreCZFw1/ltbm+T+JMP24v+OzPYr95y5i/w4t/
 7LJV22ddzenlXG9BmSvE4P8cpftIHr5FoLzhpblZvctQJq1lL445Pj21FU2yDR1HE8uuPauibBI
 bhxGdXKwf/V6STFKS6ld0sdmsXvSqgEQ==
X-Received: by 2002:a05:6402:51d3:b0:57c:947c:f9cf with SMTP id
 4fb4d7f45d1cf-5879eed9408mr9390423a12.11.1720046738905; 
 Wed, 03 Jul 2024 15:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcOFLTyGAEO6NXvv5yhaYNaCwNKD0DVZreB/5Mu/jQWKsJHTsk9pKkhFpORLLotXjQ+/Z+Q==
X-Received: by 2002:a05:6402:51d3:b0:57c:947c:f9cf with SMTP id
 4fb4d7f45d1cf-5879eed9408mr9390402a12.11.1720046738283; 
 Wed, 03 Jul 2024 15:45:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58de8fe6322sm442672a12.53.2024.07.03.15.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:37 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v3 17/85] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <67adb7979b6c1151a906d99f19fccf1e789316b1.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


