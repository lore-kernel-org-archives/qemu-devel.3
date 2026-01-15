Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DCBD41177
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLmE-0006Nm-Ta; Thu, 15 Jan 2026 06:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vgLm5-0006Hx-3r
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vgLm3-0008Fw-Bc
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768477461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0mUnKqTDPYeGBq3J7FxGI1fg8tXB/i7Hy7CrdeMHoE=;
 b=PUg8qNoCQeKDc9JAQnTf1q2x4BMuUZWtuyMzl6JRvaMcSXHaa2jJwQS352P1/js9M3VeVa
 izeEueGl+PospBSG8CrpP3Hkr8Vm9o2/OxO0Xwixt6q1l+lsX6oR9XlZNiRdgmBKIfFkBC
 cAzhX0OAYkBFrNpEx+Ojf4WIQrhJB0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-DwQPzDI5MaGWJfTbOqituQ-1; Thu, 15 Jan 2026 06:44:19 -0500
X-MC-Unique: DwQPzDI5MaGWJfTbOqituQ-1
X-Mimecast-MFC-AGG-ID: DwQPzDI5MaGWJfTbOqituQ_1768477458
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso490919f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768477458; x=1769082258; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B0mUnKqTDPYeGBq3J7FxGI1fg8tXB/i7Hy7CrdeMHoE=;
 b=LPRVs+DCQ9W0UNC+Ad/P6VmzQxQrrownvgu0Gem0bLtvZLxveVepTnNrxOPl5U1F7f
 2GpyyNAapxh7bXm9rqMXUVnVo5pBAjx3FptvfieZvv9k++4r6vSEF46RvkjFoid69r9V
 vswKArE4C1vGyV82ki/ilaaJzjbC9tU39c6cX1FTTbEOpausdwK2ZxcMly5xyuo9BBjj
 93wm3GuN7fyvhbWJw9BnT2Et2U0Y/bAF0P1eWKVx1TOhUtc30xaMtVwPktcqVG0hLOYy
 +WnFdUnR7QhRZcsPAmCIIGv8k86XxJZr5xWS2ijVoJZv6carxjFiukgZzWTsuzzrcpaO
 rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768477458; x=1769082258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0mUnKqTDPYeGBq3J7FxGI1fg8tXB/i7Hy7CrdeMHoE=;
 b=AMrTQWq2X3l1fWjLQSpjmtE/0c4zkmJ+xwJXwHzDzF2Iaoet6E4gIXY9Bi6Mv5ib7Q
 o44HGN6sVPDJqzt1txJKKXhlIHu8c7TjOK+644RuMkzPyYph0ms8KjqLBJb3XDMXYifJ
 td68ovl4qGOc1dmlMwPSzUgO6uM/Zq/an+fXLmCsttR9ShEaF5bbRvO39ulAK+qL+D4q
 ilMuBld6ozdpcZ1oXWrWdHMR5N+nkBSetQ9UZfwmxxQrIWVbQFEX2kXAc3KVBSK7UXxN
 uYoAKc0jHJQu1ClAJduxUmQZTtSsZI+jn079gof8jmMQDwPFIPVVWTyXtDlwTwcdOXmg
 Kurw==
X-Gm-Message-State: AOJu0YxDOpCmgKjcWGYUcQKJbO7lKQAZXc3lUQCMEm1jatXfPKd6BDyK
 TIb1/2anEX7Uy8tnFZQPi/Gjcj5KdFhysMDExGWlIldL6K0K6rywK56keaWVUUbpw9uZtrpluyR
 /9kbyBijmDzcMqpK7fYiuTej6pk+4GL0z73vW66znagKRlz0EQaqK0n7N
X-Gm-Gg: AY/fxX71lmWaqFyS5+1e7qcn95NbIePz4QvGEq6gTmzwFAHH9gDG4WBpUHpqcmGPqZ6
 +SnSXboxBcJTNH8741oYVtXLoN9ityigb7Bxhpp5iexqhWlojxQcFVkj+lhnT0OCYYnt1yN7EtR
 F0jzsxY3ib+qUUbdaIb5LuQsSMJvQJ3WzLsQzBrnkG31tejjT1Y/PiUti5uyFN12o3oMMSyUPN/
 76Zc4DS6o2Ih9GuiwqVIoBk5mKntcpVnIZ2p2nkxbBAi5bUPJxjIT3r1ELIa+BmZ7Ceu6NnTKTV
 o9UW/x3BvoJxV1x8jCOqgZ7XILs+/c1/TXBWZWNIkYrK0EBJGkxEOP/MUe3W3djuu2sp7FpoaZV
 wy3Ns+zRHXNh5x6I=
X-Received: by 2002:a05:6000:26c6:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-4342c4ef09emr6865159f8f.4.1768477458370; 
 Thu, 15 Jan 2026 03:44:18 -0800 (PST)
X-Received: by 2002:a05:6000:26c6:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-4342c4ef09emr6865132f8f.4.1768477457900; 
 Thu, 15 Jan 2026 03:44:17 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6b143fsm5374205f8f.25.2026.01.15.03.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:44:17 -0800 (PST)
Date: Thu, 15 Jan 2026 12:44:14 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 3/5] igvm: Add common function for finding parameter
 entries
Message-ID: <aWjQyUrF_bLIhm9H@leonardi-redhat>
References: <20260114175007.90845-1-osteffen@redhat.com>
 <20260114175007.90845-4-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260114175007.90845-4-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
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

Hi Oliver,

On Wed, Jan 14, 2026 at 06:50:05PM +0100, Oliver Steffen wrote:
>Move repeating code for finding the parameter entries in the IGVM
>backend out of the parameter handlers into a common function.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 117 +++++++++++++++++++++++++-----------------------
> 1 file changed, 61 insertions(+), 56 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a350c890cc..ccb2f51cd9 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -95,6 +95,19 @@ typedef struct QIgvm {
>     unsigned region_page_count;
> } QIgvm;
>
>+static QIgvmParameterData*
>+qigvm_find_param_entry(QIgvm *igvm, const IGVM_VHS_PARAMETER *param)
>+{
>+    QIgvmParameterData *param_entry;
>+    QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
>+    {
>+        if (param_entry->index == param->parameter_area_index) {
>+            return param_entry;
>+        }
>+    }
>+    return NULL;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -569,58 +582,53 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
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
>+    param_entry = qigvm_find_param_entry(ctx, param);
>+    if (param_entry == NULL) {
>+        return 0;
>+    }
>+
>+    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>
>+    retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>+    while (retval == 0) {
>+        if (entry >= max_entry_count) {
>+            error_setg(
>+                errp,
>+                "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
>+            return -1;
>+        }
>+        mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
>+        mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
>+
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
>     }
>+    if (retval < 0) {
>+        return retval;
>+    }
>+    /* The entries need to be sorted */
>+    qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
>+          qigvm_cmp_mm_entry);
>     return 0;
> }
>
>@@ -655,14 +663,11 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
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
>+    param_entry = qigvm_find_param_entry(ctx, param);
>+    if (param_entry != NULL) {

What about an early return?

>+        environmental_state =
>+            (IgvmEnvironmentInfo *)(param_entry->data + 
>param->byte_offset);
>+        environmental_state->memory_is_shared = 1;
>     }
>     return 0;
> }
>-- 2.52.0
>

Can we reuse `qigvm_find_param_entry` for 
`qigvm_directive_parameter_insert` and `qigvm_directive_vp_count` as 
well?

Luigi


