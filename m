Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0AEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9t-0006P9-7I; Wed, 04 Feb 2026 14:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9j-00062N-AZ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9h-0007ja-Hk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2QPRaRY25mgH7GQ9hBvdL6BBixB+wpf/B6tPD3ZxpU=;
 b=MRWdM97fVTeLBRXoNSwB/c9Fy9iPYTLMUnnL7vn0VQaGOS5BgijgSgD2W3sb1QNTV5Nvpp
 2KqFn0f2vt6O3GNdLBGImHAbEOnlQUeAD9Whsdxs6nsfZjQM0LNJDCqLZ9nn3eUGddBorU
 Ay69I+DTXjbL8uTBnA3OYPKyoFlOEi0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-NlLDHFrwNky6Frw_E5jaHA-1; Wed, 04 Feb 2026 14:03:11 -0500
X-MC-Unique: NlLDHFrwNky6Frw_E5jaHA-1
X-Mimecast-MFC-AGG-ID: NlLDHFrwNky6Frw_E5jaHA_1770231790
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435db8ebc98so201817f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231790; x=1770836590; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P2QPRaRY25mgH7GQ9hBvdL6BBixB+wpf/B6tPD3ZxpU=;
 b=h4IKNGgMaGLGPGRGBbXtP5qsN+gdTluAN1ia+GRqJ6RPGqyXQXrSiGnkKeeU4L0eWD
 mtWGYKYMxus80Dqnd9Isb62spmwSNIP+EOGcfrrveakasgo3VSxznsddpoG+xIzikhFN
 sSJhEfyy/XNesBGuU23cQLxiWWRAXKifW6bdIpCGJR1YpSyjaYchfvzXtg+xVJv2khDz
 o0P4zYOI2IFSp9FgMd178Eh4iXfmpM0lwZZ2k0HY2Mn0tv+zeh7W3TH5++sSEFpVD1zJ
 b6c/rkL0E2gSWdOr6us+NN1WVMZ0qx+/NY9QKA+OTZKTpcc+mPjgVA5sAcUHkIiq0JJN
 GV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231790; x=1770836590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2QPRaRY25mgH7GQ9hBvdL6BBixB+wpf/B6tPD3ZxpU=;
 b=o01m1h3TFZ5RsDDOK3JzJj4rm/fgiirbjKiEdpuT1bMAExMjP9jd393jIJzB4MlN9K
 1OTky98ZvIu8dmBFdJPdnU6pV079bEMMmUbnI1ySU8f06rWu+gxLxKj4uqOzpQdWJhAn
 VHhJjqymtroeSCIIf82jAERgCxjr/m+VbYfyfyfghfeNjT5xLbfxvGHHc0beqouyZP22
 DlEX0eWKCIAkyjSah3adNQC6E/wA/N9WTKmMv+j7U7E1Ni+ep25TcIV3FqGK1Ce/dy+S
 piENLKg+jwEz1+TYqdXAXhJ8bHsRTZwAE7yN4Or6WBOtH0NTOZXfBPS9kpt8XCqeW0yx
 PpsA==
X-Gm-Message-State: AOJu0YydhmsGm1q4xaiXmsQVrwVZGYVMXqmK7Q24nQU7UpFLlMUJNPV8
 I4Z+DuTZuvxJ48pwIupBCZhklxEuybuCAtOrW7cVtDwZJqLrB1TAJe3fVNZe708MUJyz+8YR1GR
 Pym2oGlrBap+wQRvVoBkYTIzUVxVZV22jtnl/YlI+II5qIB9XHy9z0YI1CqkZprH9GArEx0wdLF
 C3n6qSIs8OEbyPvMboRzxr9Ap/+Zg4q1kipw==
X-Gm-Gg: AZuq6aLMaNra8uRucD40W1KeHR/GaM2IufOJnjOBHtZwI7XgZrQW2oqPVa0uA0z+N33
 IFt8tJPl0t2ObZEdXUc5hpQWXGFl5xxVCGgA8tU54az/kjntAWHIxxzIBzfsODsAouNhN6W8tca
 VlUC4cXB6BHHxXtPKBXoZtx/+4Xwe4miVsUYUaTlrBQgbpxxQigsYQKo+nKH4d9K7qsuV6a6fNT
 CoUbaXSqbk7Qf2EIbWRXd1Lh8eMkcXplmKhMvAwmxhksOBt+zg4Oi+nQgydVLFzcdSR4wrgGGpi
 gWtNl3pHNGR+o9HwOkKpJj6fUK+71rGUXuA6Ofm1pBM8xlOjqa63QTHnTeqC2gkHLgI6dqoAhBR
 qvC5C4L82bbuWuXm6/fzBwzh8pn7TysfxWg==
X-Received: by 2002:a05:6000:438a:b0:435:96b7:e0db with SMTP id
 ffacd0b85a97d-43617e410b4mr5529502f8f.17.1770231789898; 
 Wed, 04 Feb 2026 11:03:09 -0800 (PST)
X-Received: by 2002:a05:6000:438a:b0:435:96b7:e0db with SMTP id
 ffacd0b85a97d-43617e410b4mr5529412f8f.17.1770231789139; 
 Wed, 04 Feb 2026 11:03:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f93sm8039995f8f.24.2026.02.04.11.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:08 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 08/51] hw/cxl/events: Updates for rev3.2 DRAM event record
Message-ID: <bef3c4b9d71a029358abe0f4cd80207f4ad08b26.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260114142713.617806-5-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  7 +++++++
 include/hw/cxl/cxl_events.h |  9 ++++++--
 qapi/cxl.json               | 31 +++++++++++++++++++++------
 4 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 73fd85daa7..d6bb219597 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1936,6 +1936,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
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
@@ -1955,6 +1962,12 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
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
@@ -2046,6 +2059,35 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
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
index a3f69b99a4..0cc7372101 100644
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
index c159687f84..630c37d64e 100644
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
@@ -177,7 +192,11 @@
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
-- 
MST


