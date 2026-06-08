Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DD0CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbIv-0007yi-6O; Mon, 08 Jun 2026 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wWbIt-0007yR-UU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wWbIr-0005kJ-PA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780930212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E43NSsYs30cAO4ZuWZUfpHF+oi0lfu7HEaTnPSMejS0=;
 b=K1G8fpIck9RdrIxCXM/q+x/MCAcHyfNx4T2QpD+dTE4/SCk6UVjweg/RSgWb2EC6BiNkE0
 7xZmKpUxXCZaJEwesd6bGCeafvjsXFgst5jJvjXqvGqfNw+rEWVorkQ0nW8Ltn3yYtIQy+
 2Gxm8cjLDbLWRWa0Ms9u3K7XFfoq/SY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-NvFAdLi6NOSxVKDGQ5-s-g-1; Mon, 08 Jun 2026 10:50:11 -0400
X-MC-Unique: NvFAdLi6NOSxVKDGQ5-s-g-1
X-Mimecast-MFC-AGG-ID: NvFAdLi6NOSxVKDGQ5-s-g_1780930210
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so46050025e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780930210; x=1781535010; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E43NSsYs30cAO4ZuWZUfpHF+oi0lfu7HEaTnPSMejS0=;
 b=ExJIzneqCRnx6Uuc/Xmddv+qw/ikXTnjqp3dEzQPhzJnky5KHubUU5wZlV3xTO/tW1
 3mMGRLwBKRyM17xK8ZVy67fjAVLaS5+921R/LRZlleBOR36m5mPuS5QiIodsaQxWvkgy
 0o2oSkpPS1ahAvT8VK0QM+5FJoBLwbDz6/Z7ssfq0Q1RrSAi5ZbqqWA0tF8VZvE0lVxx
 lVeyLjChqZuo32seKpT1RZUdNshX5bmj3psvxzuiSvboZqO8cPYlrYaPRyCUYuMbG8vP
 MOsKI4+X08+0fTYBxFYglM+zoQt08SkOwgMSJwPSQ/AfTPw78Tg4MssWuf5Jd8mMKzdf
 B4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780930210; x=1781535010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E43NSsYs30cAO4ZuWZUfpHF+oi0lfu7HEaTnPSMejS0=;
 b=Vk55tumtv0jwsAK5FS0ttCeMzizR99aFtb/6aBobUxSzCOsJvAwg0Ikn3LuBR7VJW7
 2/zfAGF+5NgVL0F4OAlNxYLj3frFS+VQNTXeU8EiGocYG161Njqtg+N/j/9gFs4QZqt2
 KRXt2Hwub/Lak54hltdlB7F/RLsxkNDcBYe34nS0g91myNPUWy8QKvIqaD42p2LCMMI5
 sgyGioMPx09DRKjh/pVeTzxk/W31+d46o7avqS+OqW/u4ViTj+IfBpKB0Jv5JX8IVST5
 HhqjOsSqcIDlJqiia7C6CWUhvoL4VxPRisuJd4XRat1AouM4VZ7y+V9DcyDB5b9nLAjz
 VRMg==
X-Gm-Message-State: AOJu0YyUC3QzymVf3F2NJH9BZRcVK1pmWVcWZXpdH/hwKtXsOuVEhlJC
 JCqu8IVjJrK8OeyI7NLH3TuSBqlVeFXvZzXF2xyd0pHmCwLKCmXiU+tIiiIMDExeIfJtKVeY6V1
 ftbzUR+1bZ9znN6dG5UiyS1HXRCLyLmHn6SPMCd5Wx1SBO0GLldSIF5vU
X-Gm-Gg: Acq92OHfDNT3keVwsU7aslmI2YH6I8DkBt0GU3WJyC/8FtwNPv7PmCBhUY878DQTbJ1
 m04toI4yVDhFg6MRpsPB7wW2U7lQ/io1VJ21QZgWacDp8BXemNjWuXiXuuRQqEW0lqzRqm3J3xP
 X0l7I7Su8OyBGLgcFcQCaJXNga009fMvMFjVLhsWQwuhdnqUnuLnUKfe44ynZOVMQ0aQZtzykll
 yVUJKgmXQbUz+GMAte5xDveMltLPOrWKysMsIRGXX6F+q0ZFFhYGxbsA/6Wnj6nGIoQxm/3Vt+V
 6Y/OK3rqwYc+GMbuwU5ZtFHMnjwHTrsPLKN0neRQY9ok7mNtXHQbsGj9IV0R/1VyIXZRJRud2nV
 CFTweCBY5O4qt6EY92PeFe2kdaa1qDvsQ3j72KE3sgXaFMnZ6S03ksK7jytfCFMG0v2YZpxAsJD
 cdmVhEHA==
X-Received: by 2002:a05:600c:470c:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-490c25dd118mr272804815e9.19.1780930209792; 
 Mon, 08 Jun 2026 07:50:09 -0700 (PDT)
X-Received: by 2002:a05:600c:470c:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-490c25dd118mr272804165e9.19.1780930209101; 
 Mon, 08 Jun 2026 07:50:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a87dasm385842655e9.7.2026.06.08.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:50:08 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:50:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
Message-ID: <aibRJYujhIGXExms@sgarzare-redhat>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
 <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 11:37:47AM +0200, Luigi Leonardi wrote:
>Coconut SVSM, with the upcoming device tree support[1], will use
>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>devices instead of relying on the fw_cfg interface, which is
>QEMU-specific.
>
>The IGVM parameter handler is implemented for the i386 machine
>target and stubbed for all others.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c       |  2 ++
> include/system/igvm.h |  2 ++
> stubs/igvm.c          |  6 ++++++
> target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
> 4 files changed, 46 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index c347d0c17e..9c6bee4add 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -130,6 +130,8 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_initialization_guest_policy },
>     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>       qigvm_directive_madt },
>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_directive_device_tree },
> };
>
> static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 64d3542311..d39f3d55f1 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -32,5 +32,7 @@ int qigvm_x86_set_vp_context(void *data, int index,
>  *  IGVM parameter handlers
>  */
> int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                Error **errp);
>
> #endif
>diff --git a/stubs/igvm.c b/stubs/igvm.c
>index 9e9f683fc9..b4d533ad24 100644
>--- a/stubs/igvm.c
>+++ b/stubs/igvm.c
>@@ -29,3 +29,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
> {
>     return -1;
> }
>+
>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                Error **errp)
>+{
>+    return -1;

This is pre-existing in the other stubs, so maybe should be fixed in 
another patch, but IMO we should set errp, like we do in other files in 
stubs/ (e.g. monitor-internal.c, qmp*.c, etc.)

I mean something like:

     error_setg(errp, "IGVM not supported on this platform");

>+}
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index f41b498b89..13db6e9be0 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -11,6 +11,8 @@
>
> #include "qemu/osdep.h"
>
>+#include <libfdt.h>
>+
> #include "cpu.h"
> #include "hw/i386/e820_memory_layout.h"
> #include "hw/i386/acpi-build.h"
>@@ -210,3 +212,37 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>     g_array_free(madt, true);
>     return result;
> }
>+
>+/*
>+ * Process device tree IGVM parameter
>+ */
>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    QIgvmParameterData *param_entry;
>+    uint32_t fdt_size;
>+
>+    /* Find the parameter area that should hold the device tree data */

This comment is a bit pointless; IMHO, we should explain why we return 
success if we can't find the device tree area.

Here or in the function doc.

Thanks,
Stefano

>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        return 0;
>+    }
>+
>+    if (ctx->machine_state->fdt == NULL) {
>+        error_setg(errp, "IGVM: device tree not available");
>+        return -1;
>+    }
>+
>+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
>+    if (fdt_size > param_entry->size) {
>+        error_setg(errp,
>+                   "IGVM: device tree size exceeds parameter area"
>+                   " defined in IGVM file");
>+        return -1;
>+    }
>+
>+    memcpy(param_entry->data, ctx->machine_state->fdt, fdt_size);
>+
>+    return 0;
>+}
>
>-- 
>2.54.0
>


