Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZV2-0007FR-Uz; Tue, 04 Jun 2024 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZV0-00072k-OT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUy-0000ru-Cg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=H4Fo7o4HJ8CdaTzhpvb8OG7THpgxeESoeyK+e1nYqkO07SktYxarrF2+9MwRVBJ2QrDlE2
 ZCPR7ygab3UQ3BK3534t0lPslHEqATkPbAXB6yvxaYGgSklp+MAWoTgO14nUYNgq7xyWpR
 8xF5tNBAFaj+y+m8e08l8ZkfdBUQbZY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-rHcltf5COm2oKxeyvbtN6Q-1; Tue, 04 Jun 2024 15:07:05 -0400
X-MC-Unique: rHcltf5COm2oKxeyvbtN6Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ea892f8441so43935501fa.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528023; x=1718132823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7oOBawQ17ekJGPjTeJH6qenvWsB1BSkAwbq0wuPpCg=;
 b=JgiL03ZsLT4ZaPI/qhCrg3VaWioiBaBXn/THDAP77VhqeG/wgknNGb7WNa4ZaWTzdA
 +rU3TZIBwO/+SB7dYf7G+gUwn9EvIt9DryJivETWn3YbG9R7cfcYDIHGs07aEVVV0CEA
 q7EogL5NjohhWaKPNhAjIaUcsfhAGYdRDFnjA+QlzbSefiOhV4iV+ufbDa+8cPnPe6bJ
 bFerMbhKey0RHM+wG/FaTe57lS6F7k+yYnes37oAOm+FLAprTftguji822Nseo511ijX
 LNA1Dt9lACpfSjYq+WIJerRtpqOWXI7k0Aus7b3Ryinh/j0v5nMY2hU/xXhlxLip+Ndq
 7rWA==
X-Gm-Message-State: AOJu0YzAE9pb2eq2fxLs1ylCcE0ftVjNPjKOQ8ZZSLChkFbMNo8iSd7S
 J7HMAYfcGqzLt60jovS5Y+2pK76eYkwO5YwxtmyXEwhDPAvyxjHjuPMa7TzO2UkTZ0eJSSLpn5X
 veC/S7YwpFPEFd2RtW88LZnNcodap//0/sdzeIX60BsZC2Tbo2YSxRW+T/EwTali4B/mwC7xcCT
 HX8uLKcc7npgZ06ZSZBGfAQXz0bNSuiA==
X-Received: by 2002:a05:651c:3c2:b0:2e9:8c28:3358 with SMTP id
 38308e7fff4ca-2eac79f18bcmr881041fa.20.1717528023220; 
 Tue, 04 Jun 2024 12:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmjgCiUF8C0mi2kPyB9h0Xdw4I3njHCZaSoymo5J+K0aMRM/YWUg+8SZYXg74Ux/MPdtiUA==
X-Received: by 2002:a05:651c:3c2:b0:2e9:8c28:3358 with SMTP id
 38308e7fff4ca-2eac79f18bcmr880841fa.20.1717528022551; 
 Tue, 04 Jun 2024 12:07:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138260c5asm122254205e9.41.2024.06.04.12.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:02 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 18/46] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <5b02e8711374f760215075524ee413a1cbaead6b.1717527933.git.mst@redhat.com>
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


