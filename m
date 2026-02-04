Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5350EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9u-0006VW-1U; Wed, 04 Feb 2026 14:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9o-00069J-3h
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9l-0007jt-Pf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/cqMaZU84kh1h3O8zEa+2dGJkgCLvA3AzeuIm4u7+Aw=;
 b=QHUpWIWZeO9YAbH+oohNplXtJFjl2QNRq2JK7SWKilb6W+M+sEf9kwwiqO0lc/+XGm5WH9
 Cj9Vdik3zDuW7z3BE+GsSmCjCjCrm+tq9Zi3i8RKbBkKUg6n0N5jdZB+YvXeIqxlyNUlmK
 yOk3xjRYxNSNW7taDjkK7HBiPvk4ms8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-mwC-ERUKMWOmUMX4uCz5UA-1; Wed, 04 Feb 2026 14:03:14 -0500
X-MC-Unique: mwC-ERUKMWOmUMX4uCz5UA-1
X-Mimecast-MFC-AGG-ID: mwC-ERUKMWOmUMX4uCz5UA_1770231792
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so1246685e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231792; x=1770836592; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/cqMaZU84kh1h3O8zEa+2dGJkgCLvA3AzeuIm4u7+Aw=;
 b=mTlVv09KMayNNKxk7X1LsdKyUO3rR1vhKu1N276Bk717Qd5cFOvWE7ujVZs73MPzjN
 +XAaAPm8rXmd8d3B+KnFleG7zyuiEPkHTUhb/y6hAeSlhhYfdOkuLX5A5MuEQ/jLT4Ib
 6cQwVNBFgAr1O2pAwpno4ZPpmbZL68SLlhoEBonCDV5nrFWouw5DVm7kawhrHhkiBPnz
 dwwIR6eGH3dypq3Yh1y6AQJsrLQjibHnlnE5/gc8o8M2wQJNlsEfop3fFddi6HhKYLCK
 2TaRjws+qSPxPb0Z7QK5/81fbbK/yOxQhlOaVfK2n5Ytd+dCBxvpFdT+mURObZh49XMS
 1s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231792; x=1770836592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cqMaZU84kh1h3O8zEa+2dGJkgCLvA3AzeuIm4u7+Aw=;
 b=m5nofLtyh8SlLDrgzW/QQkGRYY5Ay+L4lpOI47sp7+Eq4HHR+9FUQ225zhdWgKFVle
 z7+JCV10TIojos76GSoE3w5h7mFkm0F/xpB+IklLyED2L6LiCm8YvTejDApt7BUlK0nj
 EE7XNvJ3UD33QpeMbP1/DWtWazvR2nMmsrkaLQvTaJczfgBhe55EYalSSui653JgVIj0
 Kw6rcFHyHd1sl2EgIpba8VEgYBtopy7rT3MlcU1RMqk5Pe2MSgk8dSunf86ZDHbnRXEH
 2QSRkGEzg0qK7O2VKiGphUxO0vKZyNlQ0U69Nawk7tYA+IoShaXVqocqQfWAKa5geSKj
 78MQ==
X-Gm-Message-State: AOJu0YwPsGZIU206/4b8ki2RawLhhNLfd3qp+HdGlaM1Sm6UDZF1FfHe
 cY3QKdvcnSlgf6OQMrbh99CjOkKHMsOXfQ8qn2AEzpvKW7FiL6jzDoir9ZbQEOplU4NsiKX62Xg
 gPkFL5JGVFPEzw84dn7cAmKTUCCycD9KVV2Z7vNWMhlVlAxFIextJ/qgqG91aC07Mnq/Vf0fdXO
 iXG16vDuvSPOH+KsPe3Yi7z1BKQKBQnhSSUA==
X-Gm-Gg: AZuq6aKzfZV0U1EkpOcAK3PUQDkiJU3eiMOzLLGyVrkidIhdUUgkOXiaeTaQlQ2uWca
 kYoq5xtDdAA6DqMxkwfN+puxTAgHY1ZdnmIgWyQf/vN9uV9/CNUyEtOw8rNumWR9BIlF5RlYZoX
 jUxa46Wflq/RGahwmT2eeQUzoaqK1QIUN/KGl4yOZS+fLMYHXjSxvg12NqvosabA4f5ou4o42zH
 05G22vIBQoXkLh1X0K4nWwCF0hfyPAY4N0MY6Rlx9hyD+eBYxA61S0QXXiNuixoipAyKH5rxhKN
 gk2LLecV8/Si6XDWm7WMQaNw73fJO6xqiZ+BsoJZapVEBxwtCJCLTcjWMHHvdGBVWVBiWgpPrLi
 cszJNAGQBWybGre3eKCj+bWwHFIuBJ67v2Q==
X-Received: by 2002:a05:600c:1c26:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-4830e933a24mr60204755e9.12.1770231791994; 
 Wed, 04 Feb 2026 11:03:11 -0800 (PST)
X-Received: by 2002:a05:600c:1c26:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-4830e933a24mr60204165e9.12.1770231791419; 
 Wed, 04 Feb 2026 11:03:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2c856sm4341125e9.4.2026.02.04.11.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:10 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/51] hw/cxl/events: Updates for rev3.2 memory module event
 record
Message-ID: <c2a866366e44e8d4ef3d73a91d18905de27cab08.1770231744.git.mst@redhat.com>
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

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Updated all references for this command to the CXL r3.2
specification.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260114142713.617806-6-Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  4 ++++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 26 ++++++++++++++++++--------
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d6bb219597..85694707e2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2106,6 +2106,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_MMER_VALID_COMPONENT                        BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
+
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
                                         uint8_t maint_op_class,
@@ -2122,11 +2125,16 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
     CXLEventMemoryModule module;
     CXLEventRecordHdr *hdr = &module.hdr;
+    uint16_t valid_flags = 0;
     CXLDeviceState *cxlds;
     CXLType3Dev *ct3d;
     uint8_t enc_log;
@@ -2169,6 +2177,18 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     stl_le_p(&module.corrected_persistent_error_count,
              corrected_persist_error_count);
 
+    if (component_id) {
+        strncpy((char *)module.component_id, component_id,
+                sizeof(module.component_id) - 1);
+        valid_flags |= CXL_MMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+    module.sub_type = sub_type;
+
+    stw_le_p(&module.validity_flags, valid_flags);
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 231dda263f..98292a931c 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 0cc7372101..89f6aad531 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,7 +166,7 @@ typedef struct CXLEventDram {
 
 /*
  * Memory Module Event Record
- * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
+ * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59
  * All fields little endian.
  */
 typedef struct CXLEventMemoryModule {
@@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
     uint32_t dirty_shutdown_count;
     uint32_t corrected_volatile_error_count;
     uint32_t corrected_persistent_error_count;
-    uint8_t reserved[0x3d];
+    uint16_t validity_flags;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_type;
+    uint8_t reserved[0x2a];
 } QEMU_PACKED CXLEventMemoryModule;
 
 /*
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 630c37d64e..fc2ff2e080 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -214,20 +214,20 @@
 ##
 # @CXLMemModuleEvent:
 #
-# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
+# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
-# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
+# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
-# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Health Status for bit
+# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Health Status for bit
 #     definitions.
 #
-# @media-status: Overall media health summary.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Media Status for bit
+# @media-status: Overall media health summary.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Media Status for bit
 #     definitions.
 #
-# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
 #     Payload, Additional Status for subfield definitions.
 #
 # @life-used: Percentage (0-100) of factory expected life span.
@@ -243,6 +243,14 @@
 # @corrected-persistent-error-count: Total number of correctable
 #     errors in persistent memory
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-type: Device event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLMemModuleEvent',
@@ -252,7 +260,9 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            'sub-type':'uint8'
             }}
 
 ##
-- 
MST


