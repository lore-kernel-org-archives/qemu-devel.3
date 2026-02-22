Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B964BC636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASJ-000891-QB; Sun, 22 Feb 2026 09:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS1-00080Z-SJ
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARx-0006gb-B8
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5//VazXW7wADCbfP9nhBrYMpz6KwtNQEosG71RpWuw=;
 b=iZupk4a68QIs6UN93IHFuCW+zZpsXil80NxLgxMsznMF5JjMcJv71SMxNZYJUCGDbL91tf
 nWTN9AA/o4m48XgLYFgza4AbympqDBOCNfW4NrVMbdnup/BqMJU9Ii1uY4eT+44Dv3macD
 G7SsS5NOMZnZu6GiPSJ7uAYsRZPlUlA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-cxPwpCqyPjS4EpxXcQ3cow-1; Sun, 22 Feb 2026 09:28:43 -0500
X-MC-Unique: cxPwpCqyPjS4EpxXcQ3cow-1
X-Mimecast-MFC-AGG-ID: cxPwpCqyPjS4EpxXcQ3cow_1771770522
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so4813605e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770522; x=1772375322; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5//VazXW7wADCbfP9nhBrYMpz6KwtNQEosG71RpWuw=;
 b=F2gvRj4sRDc2r9ZfmOhJ0agWA/tajnpdIE9KRnYnFRcF1j1GMylGSx1ACCFdgeyzzz
 oTHyJClTp9qEnxDT0OzfARAIGGmwpva+/+rzsDSkyW82a3vgaSaaIklZ/EicjkbJbWMi
 7LBxGoFmcXTYwmZ96YvvKfIqZayKDo+Nyv5GLuWwCHgUYUafbAueeV7gF+sCIHot/KQ0
 SPPrJUcs2lA3sHMNXWRbDp9gMORhOcRDTasRBcE5L/O0nAQoQCizRypU0jkrKTzP4cAX
 uuzDKFjmAYFQHqX6Tjlr56xjgnagWYALvSlMZCGZuykH59iO0irTI7LtcGGQWb4l8RCA
 JUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770522; x=1772375322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5//VazXW7wADCbfP9nhBrYMpz6KwtNQEosG71RpWuw=;
 b=rTX21VFyQMx2pRvV2szv+BAXaIxjHapIV8WB5NAWR9PnjIFTifi13fgFzpwGbE79p+
 Yf+fpIUnO0C+uqdbhR6LYZaye6VlOnid9CDrEcQMgHt33zXoKTRzuXjqEakvWmuiH9ab
 nMu/WrpU/lOlnhekmmzxKWhVmiE+PcuPDmB2dJy10q33tsTaDfio1J3CvRSrnD8enFnQ
 nG+Qj+lM2JZ/+eB4FAot4FAx0Djrh3GDA0l15sK88BGNZIy8PrX547Vqy03558W0xJ/X
 24hJim7aEN1s1k/NCwp7Bsp0NghVFaNWMuQVQujGwMxnrBrh4O+PHFgumzO+Ir0sbECU
 139Q==
X-Gm-Message-State: AOJu0YwoJRpc0jRDasF3c8YLO6b1JpSSvd2O4kb7eDX6DT/o8+g8OHE0
 DumD4i/Ukty+TliQjEnjnnQ71oqstYlzBnUTQolqqHNta3O8StR5ut9Yc9N0iuXsfws11CpR6sN
 hPrbw6Z4cuXoE92TMl3jvuL8WoH/cdb96E0a7ld5u0bzwI0FOdI1nN1+eFB251CDzdH+NV2UPMq
 g0M6JI6DDh3ksNaz2FQ8WiW8PGROkerU3vbQ==
X-Gm-Gg: AZuq6aKHffnfuE6CeelJLgIcXlpYtIJJbz+xbt20OJQLpBqehVts4bgubXzs7Sp6Ajg
 7DTXHql/4Vj0i8DoMe9fvZlpHFbxJILDVrFh8xyg8Q6HOXacCP2l1lSVwLfFEubgb7CSEHquc9o
 R1cD+huOg9wf7UaoOSLyYyOyp0PSiqny5czKxk6kHX+PWRiNytHdrR5yn3DenxyoLrb3bNH6rSz
 8hrEdwlDDJetkpeObDfWoUdrpnvV1RpSxkydKwBqp0mEb5uYZnNICvaMSLCVaChKXvPbtv6JZEg
 tSDglgTUePadAGRoRuC3Tkv3DzATyHrQXxZveO4FhuxAj0gfmvg/qk8Te5ghDK6zMUpI9WEf3fS
 mzkAX9hCgJBeD8O4xjXbIGPCMeecuvhb+QuRSUdnUmsI/jQ==
X-Received: by 2002:a05:600c:3b20:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-483a95eabadmr98807265e9.5.1771770521926; 
 Sun, 22 Feb 2026 06:28:41 -0800 (PST)
X-Received: by 2002:a05:600c:3b20:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-483a95eabadmr98806845e9.5.1771770521404; 
 Sun, 22 Feb 2026 06:28:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3d88sm219868765e9.3.2026.02.22.06.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:40 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 10/33] hw/cxl/events: Updates for rev3.2 DRAM event record
Message-ID: <94976b8631a11297b52826f51a638242b2767f9f.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
has updated with following new fields.
1. Component Identifier
2. Sub-channel of the memory event location
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Volatile Memory Error Count at Event
5. Memory Event Sub-Type

Add updates for the above spec changes in the CXL DRAM event
reporting and QMP command to inject DRAM event.

In order to ensure consistency update all specification references
for this command to CXL r3.2.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260205112350.60681-5-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 44 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  7 ++++++
 include/hw/cxl/cxl_events.h |  9 ++++++--
 qapi/cxl.json               | 33 ++++++++++++++++++++++------
 4 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 229be88708..be99d20faf 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1783,6 +1783,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_ROW                              BIT(5)
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
+#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
+#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
+
+#define CXL_DRAM_EV_DESC_UCE                            BIT(0)
+#define CXL_DRAM_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_DRAM_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                uint32_t flags,
@@ -1802,6 +1809,12 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm, bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1838,7 +1851,6 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                             has_maint_op_subclass, maint_op_subclass,
                             has_ld_id, ld_id, has_head_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
-    dram.descriptor = descriptor;
     dram.type = type;
     dram.transaction_type = transaction_type;
 
@@ -1888,6 +1900,36 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
         valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
     }
 
+    if (component_id) {
+        strncpy((char *)dram.component_id, component_id,
+                sizeof(dram.component_id) - 1);
+        valid_flags |= CXL_DRAM_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+
+    if (has_sub_channel) {
+        dram.sub_channel = sub_channel;
+        valid_flags |= CXL_DRAM_VALID_SUB_CHANNEL;
+    }
+
+    if (has_cme_ev_flags) {
+        dram.cme_ev_flags = cme_ev_flags;
+    } else {
+        dram.cme_ev_flags = 0;
+    }
+
+    if (has_cvme_count) {
+        descriptor |= CXL_DRAM_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(dram.cvme_count, cvme_count);
+    } else {
+        st24_le_p(dram.cvme_count, 0);
+    }
+    dram.descriptor = descriptor;
+
+    dram.sub_type = sub_type;
+
     stw_le_p(&dram.validity_flags, valid_flags);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 2047e97846..231dda263f 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm,
+                               bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 352f9891bd..a3c5f2ec20 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -138,7 +138,7 @@ typedef struct CXLEventGenMedia {
 
 /*
  * DRAM Event Record
- * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
+ * CXL r3.2 Section 8.2.10.2.1.2: Table 8-58
  * All fields little endian.
  */
 typedef struct CXLEventDram {
@@ -156,7 +156,12 @@ typedef struct CXLEventDram {
     uint8_t row[3];
     uint16_t column;
     uint64_t correction_mask[4];
-    uint8_t reserved[0x17];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    uint8_t cme_ev_flags;
+    uint8_t cvme_count[3];
+    uint8_t sub_type;
+    uint8_t reserved;
 } QEMU_PACKED CXLEventDram;
 
 /*
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 4ff66fc6c1..1dc8b08ca3 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -131,21 +131,21 @@
 ##
 # @CXLDRAMEvent:
 #
-# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
+#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
 #     Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
+#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
 #     Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
 #     DRAM Event Record, Memory Event Type for possible values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
+#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -169,6 +169,21 @@
 # @correction-mask: Bits within each nibble.  Used in order of bits
 #     set in the nibble-mask.  Up to 4 nibbles may be covered.
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-channel: The sub-channel of the memory event location.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cvme-count: Corrected volatile memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLDRAMEvent',
@@ -177,13 +192,17 @@
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
-            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            '*sub-channel':'uint8',
+            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
+            'sub-type':'uint8'
            }}
 
 ##
 # @cxl-inject-dram-event:
 #
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 # This event type is reported via one of the event logs
 # specified via the log parameter.
 #
-- 
MST


