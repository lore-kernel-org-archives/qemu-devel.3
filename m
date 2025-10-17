Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C25BCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kQr-0006Zx-BC; Fri, 17 Oct 2025 09:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kQm-0006YU-02
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kQe-000723-J4
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760707409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HaxWyWdeeumA9qtoL3XFb3fw+Bju+xyOc2rFcxfl41s=;
 b=fwSrRaEB7fleToV4qs3nQiofp+Qwz9k1Nbaf7HU4PTUYXdrdB35pCPWDnpZTNd2whyFE5W
 JUifbL/LTnBjebmltl5FUaKk5Fr9jD4GxZL9f9jolIy+SZ7a+OLWEyuFl19d+KLlRRLBDG
 7NYBSre/w6LTtIx2Ms/QnacWc34ar3c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-NyrrG_rEOZKt5SvLuBI_Lw-1; Fri, 17 Oct 2025 09:23:28 -0400
X-MC-Unique: NyrrG_rEOZKt5SvLuBI_Lw-1
X-Mimecast-MFC-AGG-ID: NyrrG_rEOZKt5SvLuBI_Lw_1760707408
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-872d2ad9572so688708785a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707408; x=1761312208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaxWyWdeeumA9qtoL3XFb3fw+Bju+xyOc2rFcxfl41s=;
 b=nIniKBnYhQ50cOnJASaksXAUFA4GK63gPDjsJQPO5okosoDc3xL3eaQd0F9DSGFyM5
 jqBrtfoo7CVLNu4wN+mMKlTVvrZOSdkU/hIyF5GEuKQEXwc/4KDm4RSrLihrCXeHs4fL
 IeiKwl3w3K7SBxlRz+vObzejSe9FiaQJCugBBDd0yi/55I0K02qehhR7yCMLB6cQi+Hb
 xEfzgLRUZu0jPU1E6qIiN9eP9jid4B1JITItprm3bYXt++rMzfPwDmjgNwysZugFl/MW
 TFIi7tvL4JnpxBgo4hN8QSc2UF5gYtoITXhpNwMl/gQIk7qgRvquPNQ3LjeWhZvzbThL
 Y9Sg==
X-Gm-Message-State: AOJu0YxjhuUz+7+qyWvFQ9SUAdPmQVC1R+qLkNODwM5y5Cdht0izlLwO
 o1eIGSUaobYQULiv5//zJTXXBm06jLTF8KJtJNTtO3sxnmZZVR/DlrRwOM/xT/xDnGSfTNiMZAi
 akLl4CeHY0h9lRtSaCPb5o6VYUStgZHLoK8XM8czEJI26zwYu5ub/EXAc
X-Gm-Gg: ASbGnctp8MnvYZFZkOWp4Gnynp4z7z1/oAdmYd+/cZ+uOaaJcdUaCO1TQz/kBwxE0xt
 R2EyyCp09txGP0I4ogFXnaeQ9xMnb6ZlFXOla6x8Xvdep10Cu/5AWWNlAeEPjupfWkqeu7330/S
 EaUZVfcROU23tWstjfmy+93c0apsbBrT18L0RlwRjzxLf8dK2Yo/6fXHkO/KKB5Qt/nhmEGN4y1
 kxdXK68VU7tTVzkv/xGMS/O5TSN/T4/RpFcHs6UypK2Xl7YFGEMaCnQhR/iVfG2ZAewxw12zspk
 35IDm1YHPzpF7IoAMmH0c9u4AtI6RYbDabJ7R0Q778WYYtIvCK/8YpVJ5zO/CPnCoehehVskSc3
 O9zLnryu/DOscmA0r26ipWj3Z0lxXbvXw3T7luBWf1VOFtMcOzcs=
X-Received: by 2002:a05:622a:95:b0:4e8:a73c:87d8 with SMTP id
 d75a77b69052e-4e8a73cb645mr10301601cf.71.1760707407844; 
 Fri, 17 Oct 2025 06:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXx4FKwcbNrnjhj7thAJxuRHtDuNzkf9RRGy5eDqKk07rzVEgdA8V6JP7A8xBPGibbQ8JCTg==
X-Received: by 2002:a05:622a:95:b0:4e8:a73c:87d8 with SMTP id
 d75a77b69052e-4e8a73cb645mr10301101cf.71.1760707407342; 
 Fri, 17 Oct 2025 06:23:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8a8cf1a7dsm2049291cf.7.2025.10.17.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:23:26 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:23:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 2/5] igvm: add support for igvm memory map parameter
 in native mode
Message-ID: <lvk2mna2vasyqb2ws6ylnyhtec7iym32mdreqglae6gupnejcw@rxhsvsjf33xe>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015112342.1672955-3-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Oct 15, 2025 at 01:23:39PM +0200, Gerd Hoffmann wrote:
>Add and wire up qigvm_x86_get_mem_map_entry function which converts the
>e820 table into an igvm memory map parameter.  This makes igvm files for
>the native (non-confidential) platform with memory map parameter work.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/system/igvm.h   |  5 +++++
> backends/igvm.c         | 18 ++++++++++++----
> stubs/igvm.c            | 21 +++++++++++++++++++
> target/i386/igvm.c      | 46 +++++++++++++++++++++++++++++++++++++++++
> stubs/meson.build       |  1 +
> target/i386/meson.build |  3 +++
> 6 files changed, 90 insertions(+), 4 deletions(-)
> create mode 100644 stubs/igvm.c
> create mode 100644 target/i386/igvm.c
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index a4abab043a1f..3f72a40b8897 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -19,4 +19,9 @@
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>                       bool onlyVpContext, Error **errp);
>
>+/* x86 native */
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp);
>+
> #endif
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 723d45b755a0..e949c81abb9a 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -12,6 +12,7 @@
> #include "qemu/osdep.h"
>
> #include "qapi/error.h"
>+#include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
>@@ -543,6 +544,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                                       Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>+                             Error **errp) = NULL;
>     QIgvmParameterData *param_entry;
>     int max_entry_count;
>     int entry = 0;
>@@ -550,7 +553,15 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     ConfidentialGuestMemoryMapEntry cgmm_entry;
>     int retval = 0;
>
>-    if (!ctx->cgs) {
>+    if (ctx->cgs && ctx->cgsc->get_mem_map_entry) {
>+        get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
>+    }
>+
>+    if (!get_mem_map_entry && target_arch() == SYS_EMU_TARGET_X86_64) {

nit: we can avoid to re-evaluate `get_mem_map_entry` again, so we can
do: (not a strong opinion, just more readable IMHO)

       else if (target_arch() == SYS_EMU_TARGET_X86_64) {

>+        get_mem_map_entry = qigvm_x86_get_mem_map_entry;
>+    }
>+
>+    if (!get_mem_map_entry) {
>         error_setg(errp,
>                    "IGVM file contains a memory map but this is not supported "
>                    "by the current system.");
>@@ -565,7 +576,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                 param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>             mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>
>-            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
>+            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>             while (retval == 0) {
>                 if (entry > max_entry_count) {

pre-existing, but should this be `entry >= max_entry_count` ?

BTW this should be eventually fixed in another patch, so for this patch:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>                     error_setg(
>@@ -598,8 +609,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                         IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>                     break;
>                 }
>-                retval =
>-                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
>+                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
>             }
>             if (retval < 0) {
>                 return retval;
>diff --git a/stubs/igvm.c b/stubs/igvm.c
>new file mode 100644
>index 000000000000..c32058eb2a6e
>--- /dev/null
>+++ b/stubs/igvm.c
>@@ -0,0 +1,21 @@
>+/*
>+ * QEMU IGVM, stubs
>+ *
>+ * Copyright (C) 2026 Red Hat
>+ *
>+ * Authors:
>+ *  Gerd Hoffmann <kraxel@redhat.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "system/igvm.h"
>+
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp)
>+{
>+    return -1;
>+}
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>new file mode 100644
>index 000000000000..2ed6cd052c79
>--- /dev/null
>+++ b/target/i386/igvm.c
>@@ -0,0 +1,46 @@
>+/*
>+ * QEMU IGVM, support for native x86 guests
>+ *
>+ * Copyright (C) 2026 Red Hat
>+ *
>+ * Authors:
>+ *  Gerd Hoffmann <kraxel@redhat.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "hw/i386/e820_memory_layout.h"
>+#include "system/igvm.h"
>+
>+/*
>+ * convert e820 table into igvm memory map
>+ */
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp)
>+{
>+    struct e820_entry *table;
>+    int num_entries;
>+
>+    num_entries = e820_get_table(&table);
>+    if ((index < 0) || (index >= num_entries)) {
>+        return 1;
>+    }
>+    entry->gpa = table[index].address;
>+    entry->size = table[index].length;
>+    switch (table[index].type) {
>+    case E820_RAM:
>+        entry->type = CGS_MEM_RAM;
>+        break;
>+    case E820_RESERVED:
>+        entry->type = CGS_MEM_RESERVED;
>+        break;
>+    default:
>+        /* should not happen */
>+        error_setg(errp, "unknown e820 type");
>+        return -1;
>+    }
>+    return 0;
>+}
>diff --git a/stubs/meson.build b/stubs/meson.build
>index 5d577467bfdd..27be2dec9f9e 100644
>--- a/stubs/meson.build
>+++ b/stubs/meson.build
>@@ -74,6 +74,7 @@ if have_system
>   stub_ss.add(files('dump.c'))
>   stub_ss.add(files('cmos.c'))
>   stub_ss.add(files('fw_cfg.c'))
>+  stub_ss.add(files('igvm.c'))
>   stub_ss.add(files('target-get-monitor-def.c'))
>   stub_ss.add(files('target-monitor-defs.c'))
>   stub_ss.add(files('win32-kbd-hook.c'))
>diff --git a/target/i386/meson.build b/target/i386/meson.build
>index 89ba4912aaeb..d385eafdf7e1 100644
>--- a/target/i386/meson.build
>+++ b/target/i386/meson.build
>@@ -26,6 +26,9 @@ i386_system_ss.add(files(
> ))
> i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
>                                        if_false: files('sev-system-stub.c'))
>+if igvm.found()
>+  i386_system_ss.add(files('igvm.c'))
>+endif
>
> i386_user_ss = ss.source_set()
>
>-- 
>2.51.0
>


