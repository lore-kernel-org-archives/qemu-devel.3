Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34345CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7Vx-0005KA-9e; Mon, 02 Sep 2024 09:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7Vo-0005IE-8t
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7Vl-0001fl-7Y
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725285267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2xue0PWlm1Ry+OtqgPZCDvEigSRcFq/3XQYlDnOa5c=;
 b=cbY8MDQXylIEaulziwTPOcKEZ0x/0Ed2u3vMlVFfHdBxlZ5KZypuA4flkz8+U5cRl7bjZ/
 V0r5yVY4nAdtEDFNd1S9xyJrIB6sBxWzmO23obxi9TSPE+EwUDB2dlJJM6aHmRi3Gsm6R2
 A/XTE95FDTk+0+qxw5f8qpKVuJ5FWO8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-P7a6UUGeMwKqw6mTUu9TOw-1; Mon, 02 Sep 2024 09:54:25 -0400
X-MC-Unique: P7a6UUGeMwKqw6mTUu9TOw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bfc57e2aso1511435f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 06:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725285264; x=1725890064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2xue0PWlm1Ry+OtqgPZCDvEigSRcFq/3XQYlDnOa5c=;
 b=ngt9r4UmA59BVwEhGS3aoPpIoPRkO3XGFbjfMEeJVuHWjbwApRPNtTzHNykpYNP+74
 uzm3nC5q1CiJpTkppuK+THP9UurkR2ccaEcdfO1kmN5FmcsLBoBO7jmp4F0RHjInwaD/
 VJNRhuKesy99f/LyqPgBfLdPiPHmX8PNDGvUww/ntPV9hZwqzpq8/KCpiBNknCnldQ9r
 aPu827e8I5mBeYF5qUxl3ytz5Jdayd8SDFBrQMyJQCIonsCyOzXRPIfcKwJ7nfbnK0b8
 F2cI0rw7+4cLEK2h59QBvsJANqb2r9iZOp9n2tc2NUd7ooVlxHRk6sEjJ2TjULIS+IDf
 H8Gw==
X-Gm-Message-State: AOJu0Yw9x72Rn0pY37IZ+oOlzOqikxl04Ln/3qGmeY+eDTaC3yBSYfad
 uXWMoG2bH4bFlsXxDAgyKQa7d51QPnhEEZscL/kJVOcU7r3jt+8lxZvvcvIY6L21EQEl7prsiAc
 awB6+zSllM6DbwH32bsL9ZJyiUGVoYCEpx2p9HQ3IaM05gffTFDFT
X-Received: by 2002:adf:e646:0:b0:371:9154:597 with SMTP id
 ffacd0b85a97d-374c9427d23mr2820875f8f.0.1725285264381; 
 Mon, 02 Sep 2024 06:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxlhezbxgaQMuVLzKPra8B6Gw6pyaW2VVcjJYkpXOIxKArc1sKBHFGuXiWZGQAgcLpHiQwmg==
X-Received: by 2002:adf:e646:0:b0:371:9154:597 with SMTP id
 ffacd0b85a97d-374c9427d23mr2820829f8f.0.1725285263438; 
 Mon, 02 Sep 2024 06:54:23 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee9ba83sm11613438f8f.54.2024.09.02.06.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 06:54:22 -0700 (PDT)
Date: Mon, 2 Sep 2024 15:54:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 02/16] backends/confidential-guest-support: Add
 functions to support IGVM
Message-ID: <rxngzcf2w7gxvlnqslzw764ep4pta6t2td7zwajr57kxcq4k7g@ukeprgvvl24g>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <7e85c3b60ead96ff4de03c55fdeb5e701bba0c7c.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7e85c3b60ead96ff4de03c55fdeb5e701bba0c7c.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Aug 13, 2024 at 04:01:04PM GMT, Roy Hopkins wrote:
>In preparation for supporting the processing of IGVM files to configure
>guests, this adds a set of functions to ConfidentialGuestSupport
>allowing configuration of secure virtual machines that can be
>implemented for each supported isolation platform type such as Intel TDX
>or AMD SEV-SNP. These functions will be called by IGVM processing code
>in subsequent patches.
>
>This commit provides a default implementation of the functions that
>either perform no action or generate an error when they are called.
>Targets that support ConfidentalGuestSupport should override these
>implementations.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> backends/confidential-guest-support.c     | 31 +++++++++++
> include/exec/confidential-guest-support.h | 65 +++++++++++++++++++++++
> 2 files changed, 96 insertions(+)
>
>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>index 052fde8db0..68e6fd9d18 100644
>--- a/backends/confidential-guest-support.c
>+++ b/backends/confidential-guest-support.c
>@@ -14,14 +14,45 @@
> #include "qemu/osdep.h"
>
> #include "exec/confidential-guest-support.h"
>+#include "qapi/error.h"
>
> OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                             confidential_guest_support,
>                             CONFIDENTIAL_GUEST_SUPPORT,
>                             OBJECT)
>
>+static int check_support(ConfidentialGuestPlatformType platform,
>+                         uint16_t platform_version, uint8_t highest_vtl,
>+                         uint64_t shared_gpa_boundary)
>+{
>+    /* Default: no support. */
>+    return 0;
>+}
>+
>+static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>+                           ConfidentialGuestPageType memory_type,
>+                           uint16_t cpu_index, Error **errp)
>+{
>+    error_setg(errp,
>+               "Setting confidential guest state is not supported for this platform");
>+    return -1;
>+}
>+
>+static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
>+                             Error **errp)
>+{
>+    error_setg(
>+        errp,
>+        "Obtaining the confidential guest memory map is not supported for this platform");
>+    return -1;
>+}
>+
> static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
> {
>+    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>+    cgsc->check_support = check_support;
>+    cgsc->set_guest_state = set_guest_state;
>+    cgsc->get_mem_map_entry = get_mem_map_entry;
> }
>
> static void confidential_guest_support_init(Object *obj)
>diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
>index 02dc4e518f..058c7535ca 100644
>--- a/include/exec/confidential-guest-support.h
>+++ b/include/exec/confidential-guest-support.h
>@@ -21,6 +21,7 @@
> #ifndef CONFIG_USER_ONLY
>
> #include "qom/object.h"
>+#include "exec/hwaddr.h"
>
> #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
> OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
>@@ -28,6 +29,36 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
>                     CONFIDENTIAL_GUEST_SUPPORT)
>
>
>+typedef enum ConfidentialGuestPlatformType {
>+    CGS_PLATFORM_SEV,
>+    CGS_PLATFORM_SEV_ES,
>+    CGS_PLATFORM_SEV_SNP,
>+} ConfidentialGuestPlatformType;
>+
>+typedef enum ConfidentialGuestMemoryType {
>+    CGS_MEM_RAM,
>+    CGS_MEM_RESERVED,
>+    CGS_MEM_ACPI,
>+    CGS_MEM_NVS,
>+    CGS_MEM_UNUSABLE,
>+} ConfidentialGuestMemoryType;
>+
>+typedef struct ConfidentialGuestMemoryMapEntry {
>+    uint64_t gpa;
>+    uint64_t size;
>+    ConfidentialGuestMemoryType type;
>+} ConfidentialGuestMemoryMapEntry;
>+
>+typedef enum ConfidentialGuestPageType {
>+    CGS_PAGE_TYPE_NORMAL,
>+    CGS_PAGE_TYPE_VMSA,
>+    CGS_PAGE_TYPE_ZERO,
>+    CGS_PAGE_TYPE_UNMEASURED,
>+    CGS_PAGE_TYPE_SECRETS,
>+    CGS_PAGE_TYPE_CPUID,
>+    CGS_PAGE_TYPE_REQUIRED_MEMORY,
>+} ConfidentialGuestPageType;
>+
> struct ConfidentialGuestSupport {
>     Object parent;
>
>@@ -66,6 +97,40 @@ typedef struct ConfidentialGuestSupportClass {
>
>     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
>     int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
>+
>+    /*
>+     * Check for to see if this confidential guest supports a particular
>+     * platform or configuration
>+     */

nit: What about using bool as return type?
I'm also fine with int, but I'd document the return value, since 0 in
this case is not supported, right?

BTW, code LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+    int (*check_support)(ConfidentialGuestPlatformType platform,
>+                         uint16_t platform_version, uint8_t highest_vtl,
>+                         uint64_t shared_gpa_boundary);
>+
>+    /*
>+     * Configure part of the state of a guest for a particular set of data, page
>+     * type and gpa. This can be used for example to pre-populate and measure
>+     * guest memory contents, define private ranges or set the initial CPU state
>+     * for one or more CPUs.
>+     *
>+     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
>+     * context for a virtual CPU. The format of the data depends on the type of
>+     * confidential virtual machine. For example, for SEV-ES ptr will point to a
>+     * vmcb_save_area structure that should be copied into guest memory at the
>+     * address specified in gpa. The cpu_index parameter contains the index of
>+     * the CPU the VMSA applies to.
>+     */
>+    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
>+                           ConfidentialGuestPageType memory_type,
>+                           uint16_t cpu_index, Error **errp);
>+
>+    /*
>+     * Iterate the system memory map, getting the entry with the given index
>+     * that can be populated into guest memory.
>+     *
>+     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
>+     */
>+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>+                             Error **errp);
> } ConfidentialGuestSupportClass;
>
> static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
>-- 
>2.43.0
>


