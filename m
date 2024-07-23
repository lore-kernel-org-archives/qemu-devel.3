Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8926DC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBg-0007ob-LL; Tue, 23 Jul 2024 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBe-0007gP-RV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBc-0001eB-VD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7i/ikH3mbc0bL34LgKCgRiXDl4kA7AlgZAMAJaf21I=;
 b=T9TjOGOTXSfTU8f8n3BaSUGlA+REP/nofkpr7qgYXhVYtJkourxKQmmgCYq8Rh5xpGm9dj
 KgYVPcwbuHl7Kt4f6FYyIO5NJbt4ThImI4rVKKmvHtt5oErlY8QIUm76+El60Quc5ftQ67
 TBHSPDtQTDH6ha+MSu2HXXJmZh0XKh0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-nTEO2rEmMjGtGq9H8I5oXg-1; Tue, 23 Jul 2024 06:56:02 -0400
X-MC-Unique: nTEO2rEmMjGtGq9H8I5oXg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77f48f2118so114382466b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732160; x=1722336960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7i/ikH3mbc0bL34LgKCgRiXDl4kA7AlgZAMAJaf21I=;
 b=FKJRUMn8HRwhQ60XcH6PjTUzs9GdkdALSW1wRaRAurd4RKpBo/8lw6LhexvXOOPq74
 faARd0RXXtpVYd3waHL671T3N7iF8VqH5pJ+Lqltkh6dXw/umLOS1xEpcsO90r5ZYBea
 qP1CUmwEVHJNwhIUAOa1KqXTWa0H7w/2oaStQmkjIKmEUAlw1SraJ6cwV/8F3i7LJ1tP
 iwfu+ka8+908LfCW6Zrc/L2jlYLVgOwaR3AfQP7coUutdJWKxrAxAqV140/O6JCarcMz
 PjEltcEL0RvatYpS5IeygXPuVsUolf0b42+ckRwe+J8Zafz3q6AChiNbvo+qkHwzi9/e
 4RWQ==
X-Gm-Message-State: AOJu0YwnNQhCAm5Pxu1cg5TqeLhOXAAhEpLNooMjnAnG2qiTaFOxL4B3
 /cpPkmzSaSEU4XPhe1PiGfoAnXhf45AD56aGTwo+aq2lVFt2B4BumuYbaeBg2Tt1Eq4hrdnAjHR
 MoHcDRt5kAC1d6PUKh+vxqCabsI6J7+NqAI427R/CGwiqcWE32/IlU4NK4l/LaVzLSDQk79tLZL
 VP/6u4eE6Y1f+l3Jp2VnsL2S4Rz+0Opg==
X-Received: by 2002:a17:907:2dab:b0:a72:7a71:7f4f with SMTP id
 a640c23a62f3a-a7a93f36b39mr172560466b.7.1721732160508; 
 Tue, 23 Jul 2024 03:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF76SdFlrWp+Ys26+TZ6xK0PB1WL69clRlKVeQWxEuDBRCzDmr0RcbvyOyJyJpm/GVOoc6tzQ==
X-Received: by 2002:a17:907:2dab:b0:a72:7a71:7f4f with SMTP id
 a640c23a62f3a-a7a93f36b39mr172557266b.7.1721732159845; 
 Tue, 23 Jul 2024 03:55:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7bea7esm527848766b.83.2024.07.23.03.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:59 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 09/61] hw/cxl: Add get scan media results cmd support
Message-ID: <89b5cfcc31e655a40919698a7f95a9208d6f12a3.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

Iterate over the list keeping the output payload size into account,
returning the results from a previous scan media operation. The
scan media operation does not fail prematurely due to device being
out of storage, so this implementation does not deal with the
retry/restart functionality.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230908073152.4386-5-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705120643.959422-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 85 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0509d961c3..cc98553583 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -499,6 +499,7 @@ struct CXLType3Dev {
     /* Poison Injection - backup */
     CXLPoisonList poison_list_bkp;
     CXLPoisonList scan_media_results;
+    bool scan_media_hasrun;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3c9600c39c..82120a6e7b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -85,6 +85,7 @@ enum {
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
         #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1339,6 +1340,8 @@ static void __do_scan_media(CXLType3Dev *ct3d)
         ct3d->poison_list_cnt == results_cnt) {
         cxl_clear_poison_list_overflowed(ct3d);
     }
+    /* scan media has run since last conventional reset */
+    ct3d->scan_media_hasrun = true;
 }
 
 /*
@@ -1443,6 +1446,85 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.4.6: Get Scan Media Results
+ */
+static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct get_scan_media_results_out_pl {
+        uint64_t dpa_restart;
+        uint64_t length;
+        uint8_t flags;
+        uint8_t rsvd1;
+        uint16_t count;
+        uint8_t rsvd2[0xc];
+        struct {
+            uint64_t addr;
+            uint32_t length;
+            uint32_t resv;
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_scan_media_results_out_pl *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLPoisonList *scan_media_results = &ct3d->scan_media_results;
+    CXLPoison *ent, *next;
+    uint16_t total_count = 0, record_count = 0, i = 0;
+    uint16_t out_pl_len;
+
+    if (!ct3d->scan_media_hasrun) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /*
+     * Calculate limits, all entries are within the same address range of the
+     * last scan media call.
+     */
+    QLIST_FOREACH(ent, scan_media_results, node) {
+        size_t rec_size = record_count * sizeof(out->records[0]);
+
+        if (sizeof(*out) + rec_size < CXL_MAILBOX_MAX_PAYLOAD_SIZE) {
+            record_count++;
+        }
+        total_count++;
+    }
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    QLIST_FOREACH_SAFE(ent, scan_media_results, node, next) {
+        uint64_t start, stop;
+
+        if (i == record_count) {
+            break;
+        }
+
+        start = ROUND_DOWN(ent->start, 64ull);
+        stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
+        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
+        i++;
+
+        /* consume the returning entry */
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    stw_le_p(&out->count, record_count);
+    if (total_count > record_count) {
+        out->flags = (1 << 0); /* More Media Error Records */
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 /*
  * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
  * (Opcode: 4800h)
@@ -2060,6 +2142,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
         cmd_media_scan_media, 17, BACKGROUND_OPERATION },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
+        "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
+        cmd_media_get_scan_media_results, 0, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
-- 
MST


