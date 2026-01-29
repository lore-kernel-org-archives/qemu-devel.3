Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C32D358FD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPuO-0004ZA-7B; Thu, 29 Jan 2026 06:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPuN-0004Yd-8l
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPuK-0001YO-2t
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769684988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkHgRwXBNoQjtv8jea8xR991tHIKZLt4Po4JRLHOOp8=;
 b=Xu2hoi1KHN/o4gHySI7G5RFkoV/3oNHOzffT9ABykdHoE0QwHmQZHHLFZx/D6GHf4ABt9K
 kBcL9CwUgUasZqAaMYI0gBhtE0kVjbTQq1rESc/MWHbF0q1Ew9p1vy0iyNbR57q4vF0Yoh
 bq9Na8EXMMwobK41vV2SUy14/d+RogQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-tJIWIXBbP_ahxwR7Th9eiw-1; Thu, 29 Jan 2026 06:09:46 -0500
X-MC-Unique: tJIWIXBbP_ahxwR7Th9eiw-1
X-Mimecast-MFC-AGG-ID: tJIWIXBbP_ahxwR7Th9eiw_1769684985
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48069a43217so7918635e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769684985; x=1770289785; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TkHgRwXBNoQjtv8jea8xR991tHIKZLt4Po4JRLHOOp8=;
 b=F5sZmgu4Xpp6WKn/EK9ip6BJiMsVbjmQHfeMi3WDEfqMC7tgZPU0Wpug48EZlK2VlI
 M4FbLyHVNJmHeapjHIKaz35VbZw5l5AwD0Ho88DQT99XeUZN7eNjGwln/aHflOmAirDT
 H6b6woPa4LUyBTel02se4gnmKt8LeJVBo6Pq3C0v6a9N5VMi56/cyqcoGBF1bVizcbAo
 EYKG8ijumtxT8VgLOk7dgCnURhMejN3Xx58HXq524DEs1+IMtBOeSfqyIBd5tDumCdeK
 IZh5Dv1VTR82QEVVFOpvq2wbnx+SKnkdwkhCwo6a9jgpnqqKp9abbT+GNu12iQKTBNYI
 QC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769684985; x=1770289785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkHgRwXBNoQjtv8jea8xR991tHIKZLt4Po4JRLHOOp8=;
 b=JyCzJ/tP3FYH+cq2HN32mmW0osJLaRdv8+/8wlRRr6AS0ofDGbsUHqST9xLjIaSGle
 6jRn4alXnkPmNY0hS7dP6uRzGElSvl4/ZfnnFpY6GgtdB+cIOO3urXzaBPQOOl7xdGU4
 F2+sghoNRinnQvKVbvka2uX2dLITL6u4iFEQSY3oYB0hyNhGJs7BiqHyOO6Kph7FEYni
 Pk/vqqtv40xQeiiQcmQebGs4CQKcZUix8+2avLegEj2GWXWfjeqluP4An7KcTRHxFEeg
 fdsZJCYsiOJYYSfJ8EOP27pKqNDIs2UsM+CaKTLv/t3qO/gee2FTtDeCPGxhYsHRWXtU
 fomQ==
X-Gm-Message-State: AOJu0Yx2qwr+4dTSmWvKrgnfjbuyPmGvenrcRYxar7MoXy8tH3PKatXC
 nAxaryckTRIOLGxfgPE0pOcIIfnghwKLzhgqNuUAAmj5jyN0zKQxHfk2hpHuSpo4IvHwi1fSv/8
 fnHLEPwf5VRO0VX+RGy9PRRT3BgQucAZUyaMM47LaYZR5gBNZsOXXUBcl
X-Gm-Gg: AZuq6aK1ZmCuw4TV+ubOcKjchP3/2PnJbmeBiYCbq32mel8kpPZinIzWX+MWwme3Bxl
 J6FhUZJAiHQpNzLrHIKb6zlhrBQCvo+mLuNMNObLX7cpVhEANUGS4JlApNfUP2ewwY0efU84XrX
 B1PS2tg6K2d+a3NrMU2o7+Bh2l+cgtVhh3YMqCSmHNQe3PQBy5yVwK25MaFh4ZjrPZYQwpfqAzd
 6O3Or1sDvjBwwWqVhj6hwQA88df09PxazMSAvkjV6Kdytp5jm566hvaSYQmj8T/gvkNwkBqTSqY
 e2eBwBeCVC+ZqE5Dbz1bhEP4QukIzWHBeU8w8Emuke9SN1PYRfoHGxr0ZDIvXRoTrwg/B3wRLG7
 DfE4ZHC9Fxtd9jQ==
X-Received: by 2002:a05:600c:c83:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-48069c9a4e2mr100868915e9.29.1769684985040; 
 Thu, 29 Jan 2026 03:09:45 -0800 (PST)
X-Received: by 2002:a05:600c:c83:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-48069c9a4e2mr100868495e9.29.1769684984536; 
 Thu, 29 Jan 2026 03:09:44 -0800 (PST)
Received: from leonardi-redhat ([176.206.38.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm13967057f8f.18.2026.01.29.03.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:09:43 -0800 (PST)
Date: Thu, 29 Jan 2026 12:09:41 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v5 3/6] igvm: Add common function for finding parameter
 entries
Message-ID: <aXs_30LoEwVjCSg1@leonardi-redhat>
References: <20260127100257.1074104-1-osteffen@redhat.com>
 <20260127100257.1074104-4-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260127100257.1074104-4-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 27, 2026 at 11:02:54AM +0100, Oliver Steffen wrote:
>Move repeating code for finding the parameter entries in the IGVM
>backend out of the parameter handlers into a common function.
>
>A warning message is emitted in case a no parameter entry can be found
>for a given index.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 143 ++++++++++++++++++++++++++----------------------
> 1 file changed, 77 insertions(+), 66 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 4cf7b57234..213c9d337e 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -12,6 +12,7 @@
> #include "qemu/osdep.h"
>
> #include "qapi/error.h"
>+#include "qemu/error-report.h"
> #include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
> #include "system/igvm-cfg.h"
>@@ -97,6 +98,20 @@ typedef struct QIgvm {
>     unsigned region_page_count;
> } QIgvm;
>
>+static QIgvmParameterData*
>+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
>+{
>+    QIgvmParameterData *param_entry;
>+    QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
>+    {
>+        if (param_entry->index == parameter_area_index) {
>+            return param_entry;
>+        }
>+    }
>+    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
>+    return NULL;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -571,58 +586,54 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     /* Find the parameter area that should hold the memory map */
>-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>-    {
>-        if (param_entry->index == param->parameter_area_index) {
>-            max_entry_count =
>-                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>-            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>-
>-            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>-            while (retval == 0) {
>-                if (entry >= max_entry_count) {
>-                    error_setg(
>-                        errp,
>-                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
>-                    return -1;
>-                }
>-                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
>-                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
>-
>-                switch (cgmm_entry.type) {
>-                case CGS_MEM_RAM:
>-                    mm_entry[entry].entry_type =
>-                        IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
>-                    break;
>-                case CGS_MEM_RESERVED:
>-                    mm_entry[entry].entry_type =
>-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>-                    break;
>-                case CGS_MEM_ACPI:
>-                    mm_entry[entry].entry_type =
>-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>-                    break;
>-                case CGS_MEM_NVS:
>-                    mm_entry[entry].entry_type =
>-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
>-                    break;
>-                case CGS_MEM_UNUSABLE:
>-                    mm_entry[entry].entry_type =
>-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>-                    break;
>-                }
>-                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
>-            }
>-            if (retval < 0) {
>-                return retval;
>-            }
>-            /* The entries need to be sorted */
>-            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
>-                  qigvm_cmp_mm_entry);
>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        return 0;
>+    }
>+
>+    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>+
>+    retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>+    while (retval == 0) {
>+        if (entry >= max_entry_count) {
>+            error_setg(
>+                errp,
>+                "IGVM: guest memory map size exceeds parameter area defined "
>+                "in IGVM file");
>+            return -1;
>+        }
>+        mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
>+        mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
>
>+        switch (cgmm_entry.type) {
>+        case CGS_MEM_RAM:
>+            mm_entry[entry].entry_type = IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
>+            break;
>+        case CGS_MEM_RESERVED:
>+            mm_entry[entry].entry_type =
>+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>+            break;
>+        case CGS_MEM_ACPI:
>+            mm_entry[entry].entry_type =
>+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>+            break;
>+        case CGS_MEM_NVS:
>+            mm_entry[entry].entry_type = IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
>+            break;
>+        case CGS_MEM_UNUSABLE:
>+            mm_entry[entry].entry_type =
>+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>             break;
>         }
>+        retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
>+    }
>+    if (retval < 0) {
>+        return retval;
>     }
>+    /* The entries need to be sorted */
>+    qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
>+          qigvm_cmp_mm_entry);
>     return 0;
> }
>
>@@ -634,18 +645,18 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>     uint32_t *vp_count;
>     CPUState *cpu;
>
>-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        return 0;
>+    }
>+
>+    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>+    *vp_count = 0;
>+    CPU_FOREACH(cpu)
>     {
>-        if (param_entry->index == param->parameter_area_index) {
>-            vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>-            *vp_count = 0;
>-            CPU_FOREACH(cpu)
>-            {
>-                (*vp_count)++;
>-            }
>-            break;
>-        }
>+        (*vp_count)++;
>     }
>+
>     return 0;
> }
>
>@@ -657,15 +668,15 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>     QIgvmParameterData *param_entry;
>     IgvmEnvironmentInfo *environmental_state;
>
>-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>-    {
>-        if (param_entry->index == param->parameter_area_index) {
>-            environmental_state =
>-                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>-            environmental_state->memory_is_shared = 1;
>-            break;
>-        }
>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        return 0;
>     }
>+
>+    environmental_state =
>+        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>+    environmental_state->memory_is_shared = 1;
>+
>     return 0;
> }
>
>-- 
>2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


