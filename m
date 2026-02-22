Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD11CC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASE-00085n-Ro; Sun, 22 Feb 2026 09:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARw-0007zp-OK
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARu-0006gP-UG
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CmO3F7ykaFCJkUyLzi4jRP22kFdoWcISouSDSQqFs+g=;
 b=dH+EGTR+fXyJmQtHjR2IfJ12OqY//OnOIzHt5wEh1rVzgwtPRISognQ2S7wZKfflrXRSBR
 2ENXyuOSDI/So4xiy5naMGeYg/27XzNPFFK7dsLGrIskegc2qpOraoO39y88yuKsTIBSe7
 ZSm93q2F0780EL+iDL9PCKLEN6wyyB8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Jls_YnzuOKC3Ul2a6uFTOA-1; Sun, 22 Feb 2026 09:28:40 -0500
X-MC-Unique: Jls_YnzuOKC3Ul2a6uFTOA-1
X-Mimecast-MFC-AGG-ID: Jls_YnzuOKC3Ul2a6uFTOA_1771770519
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so46683675e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770519; x=1772375319; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CmO3F7ykaFCJkUyLzi4jRP22kFdoWcISouSDSQqFs+g=;
 b=XC17yWXWiSSFqpjX2Y2butU1+c3ZyhmGC6R5jG+YVNGjy5DlhVPsndG+BOH+VWrqAU
 mLO//uJp3JBlyFj8EPsoXsprS2ImT3V9zNa333GcOAjaDNiBKN2kMty7U8brRRhMWTdN
 2YKKJk+V77ZGlW4I67jiaQexER69uF91rB0l00l8I1XpbQXP2GclakmQAbhM9wYSOFEI
 6w7dI61Bi8qNmBTFm9CGqbgXPYMi5KSOlzwxUhPSvnt9L4SrRoRHyMNnIZK7FaEFGYdp
 HsPDlSGqPnY9HgTD7ogrD7pcgrBA7oqq0oAv9UnGHL8t2B0AgxsWXM16ora4ICIoaLo5
 XO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770519; x=1772375319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmO3F7ykaFCJkUyLzi4jRP22kFdoWcISouSDSQqFs+g=;
 b=c4vUovhDN3NhS/oY63xoWTHe8NQvi9sY0QG2k+oSnc7l/Dv+0m1vphk2vgl4ibX7ad
 83D3QwkKQlrGHyBlAm3hZXVhFwaGoT2l3w3P1AhHpmK8YR8T7W6xLXe/6oltzOT1RNpa
 SxM4xbzbTO1/3dIXZBlh5i6mjWU/tdgw28i++bxRFyuI9EPmFqgMn9j8Ty5tmzJ2eG+r
 O5ryfFYUbrOZcfFPV0xQivd8gMQLV5jHEENpi9mEHxgRc+kXGkOMxWk0xzHAifmAtf8N
 GZnMbO1JL7tZyIP8kPYuxrPLg0/60+Y9DbiI1SUv9MxvHckfG26DuciMx/GTlnc4UL7g
 4LzA==
X-Gm-Message-State: AOJu0Yy5UT2FSLeSVIUGGV6ngDN4RpFXeAQs4xd7ri/IYUKk4VVvwpkw
 KsicDYbgVY1chzcwV9z3ZbUTe5KUiteI8TNsrAbvyssa6Nix1zi5+tglFL2ib8OXlbtCpAt6NHH
 ziHoiN5IwlR+uynNlhh0/KkvZhRTotz1RznQIxIeFjXfDytx12LU+yRYw1QdKQT6jAvmnVEFeMe
 vIfheDTXrWyTi12VzLUKwOUyZiZb5mJM+Ehw==
X-Gm-Gg: AZuq6aI9eqzIotfAOwcj/9urciOijAM5qyppqzCntEYXtLbb+l2XUIw9JyJXNgS0N5J
 i0ufcL/IPajFKkQRhUjCz1D9GkMU63TxjdLSwd1bz0XzBMAI20fNX7ILjA7KTSJWsL51TRwjkEC
 MCHcjh8POe97iHS0+f2124xPq6mEOWyIRi1eqkAyVxSVERcZAmyN6x4OLRe/TnsBhRGGlbyStx/
 pP+I8GOhriO5G0CGRKDicqTsZTxxUB+3nu8nNfwM8GdVbhqNyFrgS3xVPsyqMpKEuie6D8NOTqa
 WoReksiQhPHyNvHejviiq6W8riGUzA+o/0s9kxnC+n7LanDUVWuZfxJKLYluxrYVEyzCCFGXVaP
 1oGel9yRTlsjYbYg5vZNgh4EsD6KTqgiwTstruVaV7dd5Eg==
X-Received: by 2002:a05:600c:34cb:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483a95bef2amr85615505e9.10.1771770518923; 
 Sun, 22 Feb 2026 06:28:38 -0800 (PST)
X-Received: by 2002:a05:600c:34cb:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483a95bef2amr85615105e9.10.1771770518289; 
 Sun, 22 Feb 2026 06:28:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d401aasm12267168f8f.23.2026.02.22.06.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:37 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 09/33] hw/cxl/events: Updates for rev3.2 general media event
 record
Message-ID: <1aa989a1767f91803493ec05d399f9c96bed3b90.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
table has updated with following new fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type
4. Support for component ID in the PLDM format.

Add updates for the above spec changes in the CXL general media event
reporting and QMP command to inject general media event.

In order to have one consistent source of references, update all to
references for this command to CXL r3.2.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260205112350.60681-4-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 31 ++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  6 ++++++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 29 +++++++++++++++++++++--------
 4 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 371bd4dc6a..229be88708 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1646,6 +1646,11 @@ static const QemuUUID memory_module_uuid = {
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
 #define CXL_GMER_VALID_COMPONENT                        BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
+
+#define CXL_GMER_EV_DESC_UCE                            BIT(0)
+#define CXL_GMER_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_GMER_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 {
@@ -1677,6 +1682,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1714,7 +1725,6 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                             has_ld_id, ld_id, has_head_id, head_id);
 
     stq_le_p(&gem.phys_addr, dpa);
-    gem.descriptor = descriptor;
     gem.type = type;
     gem.transaction_type = transaction_type;
 
@@ -1737,10 +1747,29 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         strncpy((char *)gem.component_id, component_id,
                 sizeof(gem.component_id) - 1);
         valid_flags |= CXL_GMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
+        }
     }
 
     stw_le_p(&gem.validity_flags, valid_flags);
 
+    if (has_cme_ev_flags) {
+        gem.cme_ev_flags = cme_ev_flags;
+    } else {
+        gem.cme_ev_flags = 0;
+    }
+
+    if (has_cme_count) {
+        descriptor |= CXL_GMER_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(gem.cme_count, cme_count);
+    } else {
+        st24_le_p(gem.cme_count, 0);
+    }
+    gem.descriptor = descriptor;
+
+    gem.sub_type = sub_type;
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 91b1478114..2047e97846 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -27,6 +27,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4d9cfdb621..352f9891bd 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
 
 /*
  * General Media Event Record
- * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
+ * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
-#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
 typedef struct CXLEventGenMedia {
     CXLEventRecordHdr hdr;
     uint64_t phys_addr;
@@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
     uint8_t rank;
     uint8_t device[3];
     uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t cme_ev_flags;
+    uint8_t cme_count[3];
+    uint8_t sub_type;
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 82001c0591..4ff66fc6c1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -64,22 +64,22 @@
 ##
 # @CXLGeneralMediaEvent:
 #
-# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
+# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
+#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
 #     Media Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-43 General Media Event
+#     information.  See CXL r3.2 Table 8-57 General Media Event
 #     Record, Memory Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
 #     General Media Event Record, Memory Event Type for possible
 #     values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
+#     to occur.  See CXL r3-2 Table 8-57 General Media Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -94,6 +94,16 @@
 # @component-id: Device specific component identifier for the event.
 #     May describe a field replaceable sub-component of the device.
 #
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cme-count: Corrected memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLGeneralMediaEvent',
@@ -101,13 +111,16 @@
   'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
-            '*device': 'uint32', '*component-id': 'str' } }
+            '*device': 'uint32', '*component-id': 'str',
+            '*is-comp-id-pldm':'bool',
+            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
+            'sub-type':'uint8' } }
 
 ##
 # @cxl-inject-general-media-event:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event
+# Inject an event record for a General Media Event (CXL r3.2
+# 8.2.10.2.1.1).  This event type is reported via one of the event
 # logs specified via the log parameter.
 #
 # Since: 8.1
-- 
MST


