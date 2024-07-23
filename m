Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C0C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBY-00075E-Ie; Tue, 23 Jul 2024 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBQ-0006se-0t
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBN-0001bw-IE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rKx/2elztiRwGmRFbkqmZWz2N64JAUbTIAqb5EmVbY=;
 b=CBdGCzlOT1WMwOXBzy48sMDhX0zy4X7TK/XJo0uyAqN7wCbYVaHRlb4HAn/MWOsmAiPCvP
 K+2F7XRmXWaxZR6Z8sQ4c9SUqWix3hgoHvq6xn2UEQB31Uhqy2rnBqcf5QFQMuyqTHjXJR
 qwTugJqAUAUhV25/iIa9xN4BfqFqxCk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2NHQm-QPPi6EpBXXjj2Nnw-1; Tue, 23 Jul 2024 06:55:44 -0400
X-MC-Unique: 2NHQm-QPPi6EpBXXjj2Nnw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a69c1f5691so3379564a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732143; x=1722336943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rKx/2elztiRwGmRFbkqmZWz2N64JAUbTIAqb5EmVbY=;
 b=RTEJt4ihbggBfbGdHSsaVJZGGmtSb+0JJqbsTMX2tE3lsTexqZLUmemQrd/Jm7lEtl
 mJukc+Si1BXqz5df0v6QHcdsDuaqZuH8pJOj8binDnzSoIl8fUIAjfycACF07iFSYygp
 RWDiy96N/AEu0dJOYA3uoNPURSaX0lPRMndaNwMuTXG9bMj1raXO88kYQ9tP0IQrI9qE
 15qEwQQjwlyZmhsWoKi4lubAZOypFQ1mXme+lyTrbIf7z5TIwX0OZnKgrc2/k6kItC9U
 fIYBz4kK20xMSL+vrTHt49uLcBZOUKqQ41SzesH0wLDOl9WPvB0Y1YjNPbBm3CV15cP6
 ZK7w==
X-Gm-Message-State: AOJu0YyEgltlZvOdzknxaE1clngbs2/YF+fhS7l6BnAY0qCM89MbpUi2
 e6rhtuSpO7rsPg/ewIXmH/ZacWdEXbv3iILsBwLc+Pu0paFXRUyjs6DKdgnjFMuap+a4sx2l0+y
 Z8CdxLqQb3p3GhdQmUiigVH5SKz7c5oHXFL1xOvmN73m6FJ/ltBno/z3W42FJwYBBhmAxrGIKX/
 du8MW5eHLSWHYpFnki7QYAVlk04RZ9jg==
X-Received: by 2002:a50:c041:0:b0:57d:d59:461b with SMTP id
 4fb4d7f45d1cf-5a99e770443mr1621583a12.13.1721732142965; 
 Tue, 23 Jul 2024 03:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaC3gsoeAY14WUlzBxeDnekI//ao84Z4WhLV6PfM/ydeGhIut3H7opkTIveB4l7wTsPwZ9QA==
X-Received: by 2002:a50:c041:0:b0:57d:d59:461b with SMTP id
 4fb4d7f45d1cf-5a99e770443mr1621545a12.13.1721732142253; 
 Tue, 23 Jul 2024 03:55:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f87dcsm7363262a12.68.2024.07.23.03.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:41 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 06/61] hw/cxl: Add get scan media capabilities cmd support
Message-ID: <d61cc5b6a8d373376a8bf5ec29cfc3267a29efbe.1721731723.git.mst@redhat.com>
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

Use simple heuristics to determine the cost of scanning any given
chunk, assuming cost is equal across the whole device, without
differentiating between volatile or persistent partitions. This
is aligned to the fact that these constraints are not enforced
in respective poison query commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230908073152.4386-3-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20240705120643.959422-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   9 ++
 hw/cxl/cxl-mailbox-utils.c  | 211 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  22 ++--
 3 files changed, 233 insertions(+), 9 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0a4fcb2800..b5beb7f90e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -397,6 +397,11 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
+static inline bool scan_media_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+}
+
 static inline bool sanitize_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
@@ -491,6 +496,9 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+    /* Poison Injection - backup */
+    CXLPoisonList poison_list_bkp;
+    CXLPoisonList scan_media_results;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
@@ -558,6 +566,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d);
 
 CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index facec42dc8..8ae9c6a699 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1110,6 +1112,10 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         out->flags = (1 << 1);
         stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
     }
+    if (scan_media_running(cci)) {
+        out->flags |= (1 << 2);
+    }
+
     stw_le_p(&out->count, record_count);
     *len_out = out_pl_len;
     return CXL_MBOX_SUCCESS;
@@ -1139,6 +1145,16 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
             return CXL_MBOX_SUCCESS;
         }
     }
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not adding to the list?
+         */
+        goto success;
+    }
 
     if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
         return CXL_MBOX_INJECT_POISON_LIMIT;
@@ -1154,6 +1170,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
@@ -1193,6 +1210,17 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
 
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not removing from the list?
+         */
+        goto success;
+    }
+
     QLIST_FOREACH(ent, poison_list, node) {
         /*
          * Test for contained in entry. Simpler than general case
@@ -1203,7 +1231,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
     if (!ent) {
-        return CXL_MBOX_SUCCESS;
+        goto success;
     }
 
     QLIST_REMOVE(ent, node);
@@ -1240,11 +1268,180 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     }
     /* Any fragments have been added, free original entry */
     g_free(ent);
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.4.4: Get Scan Media Capabilities
+ */
+static CXLRetCode
+cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct get_scan_media_capabilities_pl {
+        uint64_t pa;
+        uint64_t length;
+    } QEMU_PACKED;
+
+    struct get_scan_media_capabilities_out_pl {
+        uint32_t estimated_runtime_ms;
+    };
+
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    struct get_scan_media_capabilities_pl *in = (void *)payload_in;
+    struct get_scan_media_capabilities_out_pl *out = (void *)payload_out;
+    uint64_t query_start;
+    uint64_t query_length;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /*
+     * Just use 400 nanosecond access/read latency + 100 ns for
+     * the cost of updating the poison list. For small enough
+     * chunks return at least 1 ms.
+     */
+    stl_le_p(&out->estimated_runtime_ms,
+             MAX(1, query_length * (0.0005L / 64)));
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
+static void __do_scan_media(CXLType3Dev *ct3d)
+{
+    CXLPoison *ent;
+    unsigned int results_cnt = 0;
+
+    QLIST_FOREACH(ent, &ct3d->scan_media_results, node) {
+        results_cnt++;
+    }
+
+    /* only scan media may clear the overflow */
+    if (ct3d->poison_list_overflowed &&
+        ct3d->poison_list_cnt == results_cnt) {
+        cxl_clear_poison_list_overflowed(ct3d);
+    }
+}
+
+/*
+ * CXL r3.1 section 8.2.9.9.4.5: Scan Media
+ */
+static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct scan_media_pl {
+        uint64_t pa;
+        uint64_t length;
+        uint8_t flags;
+    } QEMU_PACKED;
+
+    struct scan_media_pl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    uint64_t query_start;
+    uint64_t query_length;
+    CXLPoison *ent, *next;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+    if (ct3d->dc.num_regions && query_start + query_length >=
+            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (in->flags == 0) { /* TODO */
+        qemu_log_mask(LOG_UNIMP,
+                      "Scan Media Event Log is unsupported\n");
+    }
+
+    /* any previous results are discarded upon a new Scan Media */
+    QLIST_FOREACH_SAFE(ent, &ct3d->scan_media_results, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    /* kill the poison list - it will be recreated */
+    if (ct3d->poison_list_overflowed) {
+        QLIST_FOREACH_SAFE(ent, &ct3d->poison_list, node, next) {
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
+            ct3d->poison_list_cnt--;
+        }
+    }
+
+    /*
+     * Scan the backup list and move corresponding entries
+     * into the results list, updating the poison list
+     * when possible.
+     */
+    QLIST_FOREACH_SAFE(ent, &ct3d->poison_list_bkp, node, next) {
+        CXLPoison *res;
+
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+
+        /*
+         * If a Get Poison List cmd comes in while this
+         * scan is being done, it will see the new complete
+         * list, while setting the respective flag.
+         */
+        if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+            CXLPoison *p = g_new0(CXLPoison, 1);
+
+            p->start = ent->start;
+            p->length = ent->length;
+            p->type = ent->type;
+            QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+            ct3d->poison_list_cnt++;
+        }
+
+        res = g_new0(CXLPoison, 1);
+        res->start = ent->start;
+        res->length = ent->length;
+        res->type = ent->type;
+        QLIST_INSERT_HEAD(&ct3d->scan_media_results, res, node);
+
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    cci->bg.runtime = MAX(1, query_length * (0.0005L / 64));
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
 /*
  * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
  * (Opcode: 4800h)
@@ -1857,6 +2054,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = {
+        "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
+        cmd_media_get_scan_media_capabilities, 16, 0 },
+    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
+        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
@@ -1988,8 +2190,13 @@ static void bg_timercb(void *opaque)
             cxl_dev_enable_media(&ct3d->cxl_dstate);
         }
         break;
-        case 0x4304: /* TODO: scan media */
+        case 0x4304: /* scan media */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+            __do_scan_media(ct3d);
             break;
+        }
         default:
             __builtin_unreachable();
             break;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e7fbbb4d51..e763b9bff0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1319,6 +1319,12 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
             cxl_device_get_timestamp(&ct3d->cxl_dstate);
 }
 
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
+{
+    ct3d->poison_list_overflowed = false;
+    ct3d->poison_list_overflow_ts = 0;
+}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
@@ -1355,19 +1361,21 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
         }
     }
 
-    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
-        cxl_set_poison_list_overflowed(ct3d);
-        return;
-    }
-
     p = g_new0(CXLPoison, 1);
     p->length = length;
     p->start = start;
     /* Different from injected via the mbox */
     p->type = CXL_POISON_TYPE_INTERNAL;
 
-    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
-    ct3d->poison_list_cnt++;
+    if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+        QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+        ct3d->poison_list_cnt++;
+    } else {
+        if (!ct3d->poison_list_overflowed) {
+            cxl_set_poison_list_overflowed(ct3d);
+        }
+        QLIST_INSERT_HEAD(&ct3d->poison_list_bkp, p, node);
+    }
 }
 
 /* For uncorrectable errors include support for multiple header recording */
-- 
MST


