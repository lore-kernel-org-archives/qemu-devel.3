Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A36C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjt-0003CA-7z; Sun, 21 Jul 2024 20:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjq-0002zt-0h
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjo-0005jq-2F
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EH7iZz7W3GpWmzCfYcERS56IxpqGZ9YSdfDypAnOEA4=;
 b=NzD8DJ3PVx3PojtHtC+CXF1bHXXV8akoTS5IHnUChMWgs2i4Vvp/q0AymTQ/bq6qAMccGg
 I88IZcian0d4PAkT3R5KByxjWLIjMbEQZB5JnXXQmBCpXvvKgJrrnBiny6SX5GPe8Ff8V5
 nX3gYwaaESQNbjFG7SoI5ZGPzKemiOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-7ZxqRsqBMBuZ8dU0OeePQg-1; Sun, 21 Jul 2024 20:17:10 -0400
X-MC-Unique: 7ZxqRsqBMBuZ8dU0OeePQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso25420995e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607428; x=1722212228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH7iZz7W3GpWmzCfYcERS56IxpqGZ9YSdfDypAnOEA4=;
 b=aimsgtScHAG10JiMmd6oL8fbdRfwaQ/2dM3aWaXYlP94Gt51C+5/wdlv/EvxsjVUWM
 DNN/9IryvFujWxYItzN9tU1PTpXPFJynjD8QS57dWhVhUuNLxGMs0cSAUDx2J7M6kgAX
 ydRFE8SBcv0QOHttIY9yRF0SqRIWIPh+PgjS2DHZbrfJuLx/0I/CjiMjneJcJMdvMQCs
 X0iq5RZkdhSa5flLRwrT+Y3keoza4nHy5sIoMqHKwi76jyI+zxWW3d94OejPUQpPMsLf
 6wxKls6ebXw4GfoMsrtAxu0xnufJRIPOPSKVadzwLmODMeRtDxBkHoZqWEZybkdwievZ
 BamQ==
X-Gm-Message-State: AOJu0YwkS4dd1U+iQsb1rya2wZoT9ptu7ZOl6vKe1tDgu4VwxdBxxNZi
 ZYHR15r5loqert3ZglYI1bMpD6LkvE3IrzAhvkw26ldC4gDasicYxixiWUPfC2FHqUWqZL4OTUp
 H6w/rhQZplcUnN49iGZODkSzjLVU2koO1UDoDVOGnDLEOPRKdEK8Vn2qU9V8mmWb3nFuXFr+Eoy
 HVFYmpzguDSsC7v5caL9NLZFiFGFRq9Q==
X-Received: by 2002:a05:600c:3147:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-427dc559db9mr32413695e9.27.1721607428356; 
 Sun, 21 Jul 2024 17:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLExCdg1NSZDe3hG1l+pFeoHWQ3wP7TS2oYCzpq/5DTY9TeuF0VD29B0tBm3XMshdeQ8WHA==
X-Received: by 2002:a05:600c:3147:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-427dc559db9mr32413525e9.27.1721607427874; 
 Sun, 21 Jul 2024 17:17:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684253sm7164773f8f.4.2024.07.21.17.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:07 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 08/63] hw/cxl/events: discard all event records during
 sanitation
Message-ID: <7d65874ba0ea8cdb2a5ac51c397d721d7d49d828.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Per CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h), the
sanitize command should delete all event logs. Introduce
cxl_discard_all_event_logs() and call
this in __do_sanitization().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20231222090051.3265307-5-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20240705120643.959422-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 +
 3 files changed, 15 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 42a622197e..0509d961c3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -562,6 +562,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
 
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d397718b1b..12dee2e467 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -139,6 +139,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     return cxl_event_count(log) == 1;
 }
 
+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
+{
+    CXLEventLogType log_type;
+    CXLEventLog *log;
+
+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
+        log = &cxlds->event_logs[log_type];
+        while (!cxl_event_empty(log)) {
+            cxl_event_delete_head(cxlds, log_type, log);
+        }
+    }
+}
+
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
                                  size_t *len)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 522d9aa589..3c9600c39c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -949,6 +949,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
             memset(lsa, 0, memory_region_size(mr));
         }
     }
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
 /*
-- 
MST


