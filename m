Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B9D16816
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAsR-0004f4-CZ; Fri, 09 Jan 2026 06:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veAsQ-0004eu-3u
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veAsO-0004ZA-F0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhQ40t+NOYUrnWctig+0eg0vX/SVFCTf9wRpo4pogxI=;
 b=eBpw3eZWNlSDXMk8lCnWgWg3S1s2x0/cvyQvXmXOBbVHU+9t8caQlGnUokQqCfvdcAJb9J
 qdqzjTIxJZ8kUM6UYBHRbE2elPvu4H4zihSY+P79QWzJ/sgRx6puyG334WAomBhy/QC6+5
 M/+jAou7njKpsUuf/Nicw3kZN5i0EHA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-oyv3C0DlNDCBiFliYmGlbA-1; Fri, 09 Jan 2026 06:41:54 -0500
X-MC-Unique: oyv3C0DlNDCBiFliYmGlbA-1
X-Mimecast-MFC-AGG-ID: oyv3C0DlNDCBiFliYmGlbA_1767958913
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64d3c4deb88so4494780a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767958913; x=1768563713; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HhQ40t+NOYUrnWctig+0eg0vX/SVFCTf9wRpo4pogxI=;
 b=WiyrKxLEokEA4qEIw/nM7Ko3xtrwtsHHK2Q72C8NIEBNZFRytdGY45/VnKypsN2VFP
 NN2ZUsPNDVgGX8AL5VoOaZkPBOsWpubRPqggdhTXTtB7aEYlOTzN2PDtd4oMzHLZQGwY
 IMHroVHYplKjVWef5MdbbqvqPh2hzYSFku5tE4mqSrDGEybT4DWUxU6pSoIeY8VoRBoI
 Q9taGdtDqt31ZWGBqpNspB5n4ek1oPlNJniYyBmkmQe/4GFVF5QBssn+R3TISX2f2X/j
 mf7jl4yD+0MChW1QiFMQ10VcTTXiFrJprfPcgfQDjyVEhR5lUm+oaScMFSKBgAolIumR
 zwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958913; x=1768563713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhQ40t+NOYUrnWctig+0eg0vX/SVFCTf9wRpo4pogxI=;
 b=HfN2dx9CBq4J3zil70iFd//sIQK8su6Ow458+2mf/SwJltTVljrXT5Shg6eMeWhRVC
 B7Q7eacBESWsOZnF9XH4XxqIfT7UJJuLMkAtJC/qctRAFaH8RJPztEM80xYfqjzzgmmO
 /UuESCVlG+kVBYLZsS7K9A+qDcnqA2flCgZIkX/8ZHJaciiA3+OqqXwCTOtlm1vU8ahC
 Hdc0xyvTSFWPQohLrXZiGHipF0mBRG0IX3/jyxebKyVmheJtQaEcQdZCmrBb3LEfdbbE
 f6+nl4N8DrImfqoGFSiSb1KbdLbMkAS4dORjIqYVJnUFrsPBKv+caFgNHOH19gZriRsF
 mVOw==
X-Gm-Message-State: AOJu0YwwPE9nWB9SdioYfBRElmu9iH5Q6ccdTZYnA7wYPg/FqpNAGA+O
 HAmXpfDSs0Mjv0fbaZbTX0/tzHEGVmZIYq1Kni3vSsoLBuglllddTutQibBjgYbigOpPyLAIA+Z
 KAnuP6d7NxHkJd31jG9i3FtIZB6N0r+8EGj4/f7j3MEMyAjUCxCXdhddX
X-Gm-Gg: AY/fxX7+hxT8vq08dNLttIsQR0akD/JMR5iNzU3P42Vkm0GzJp8wbiBOMCWd1Li3p4m
 J0B/xV5upghYqYzCtI8M6VEQU4ktW5ZLwkxe5Q6wWUs+ObYYttmp9v/tqaMNe1c3epcVTVV4Q0d
 SZFI0sEn3FJmEU1e5sL4aLzhPnaVU9qcMMYtlpcGcmdbIX+C/teziW+vjCKpv6Pe+tEja6M8tA6
 k/4myKg0xtXBKixvxIgkDZFzNh7Cv5p+ai8HgswW8X5KYbve6i47tBY6SDLdF6I1yTtBetRgNVF
 /uO0va073N8fN7CHzTwTeakWiJt6qpR9hfp0VkyNtiekcezxvM4jfIYHRmruQpZ3n7935K/CDQb
 Jxdr5Qqn+coA5UHWq
X-Received: by 2002:a05:6402:3593:b0:649:79a8:8b4f with SMTP id
 4fb4d7f45d1cf-65097df5bf5mr8917352a12.11.1767958913130; 
 Fri, 09 Jan 2026 03:41:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG5LiMZXTx2fbIr6WSDSmwJlR7Rr7GLuK6LwlnCfwD34k4L3TOpNKDfV+gIaTYZTqnu31Cvw==
X-Received: by 2002:a05:6402:3593:b0:649:79a8:8b4f with SMTP id
 4fb4d7f45d1cf-65097df5bf5mr8917319a12.11.1767958912647; 
 Fri, 09 Jan 2026 03:41:52 -0800 (PST)
Received: from sgarzare-redhat ([193.207.180.225])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d89csm9722871a12.35.2026.01.09.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 03:41:51 -0800 (PST)
Date: Fri, 9 Jan 2026 12:41:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH v2 1/5] igvm: reorganize headers
Message-ID: <o3p7tqmk7nkzgrvoie5c2j5n32c242m54j7xfhiua3bkvoglcu@lavnoqs2hkbi>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211105419.3573449-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Dec 11, 2025 at 11:54:15AM +0100, Gerd Hoffmann wrote:
>Add a new igvm-internal.h header file.  Structs and declarations which
>depend on the igvm library header go into that file.
>
>Also declare IgvmCfg in typedefs.h, so the type can be used without
>including igvm header files.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/qemu/typedefs.h        |  1 +
> include/system/igvm-cfg.h      | 12 +-----------
> include/system/igvm-internal.h | 26 ++++++++++++++++++++++++++
> include/system/igvm.h          |  2 +-
> backends/igvm-cfg.c            |  4 +++-
> backends/igvm.c                |  2 ++
> 6 files changed, 34 insertions(+), 13 deletions(-)
> create mode 100644 include/system/igvm-internal.h
>
>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>index 4a94af9665a5..416a8c9acead 100644
>--- a/include/qemu/typedefs.h
>+++ b/include/qemu/typedefs.h
>@@ -55,6 +55,7 @@ typedef struct FWCfgState FWCfgState;
> typedef struct HostMemoryBackend HostMemoryBackend;
> typedef struct I2CBus I2CBus;
> typedef struct I2SCodec I2SCodec;
>+typedef struct IgvmCfg IgvmCfg;
> typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
> typedef struct ISABus ISABus;
> typedef struct ISADevice ISADevice;
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 944f23a814dd..6c07f3084082 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -12,19 +12,9 @@
> #ifndef QEMU_IGVM_CFG_H
> #define QEMU_IGVM_CFG_H
>
>+#include "qemu/typedefs.h"
> #include "qom/object.h"
>
>-typedef struct IgvmCfg {
>-    ObjectClass parent_class;
>-
>-    /*
>-     * filename: Filename that specifies a file that contains the configuration
>-     *           of the guest in Independent Guest Virtual Machine (IGVM)
>-     *           format.
>-     */
>-    char *filename;
>-} IgvmCfg;
>-
> typedef struct IgvmCfgClass {
>     ObjectClass parent_class;
>
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>new file mode 100644
>index 000000000000..475a29bbf3d7
>--- /dev/null
>+++ b/include/system/igvm-internal.h
>@@ -0,0 +1,26 @@
>+/*
>+ * QEMU IGVM private data structures
>+ *
>+ * Everything which depends on igvm library headers goes here.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#ifndef QEMU_IGVM_INTERNAL_H
>+#define QEMU_IGVM_INTERNAL_H
>+
>+#include "qemu/typedefs.h"
>+#include "qom/object.h"
>+
>+struct IgvmCfg {
>+    ObjectClass parent_class;
>+
>+    /*
>+     * filename: Filename that specifies a file that contains the configuration
>+     *           of the guest in Independent Guest Virtual Machine (IGVM)
>+     *           format.
>+     */
>+    char *filename;
>+};
>+
>+#endif
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 48ce20604259..8355e54e95fc 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -12,8 +12,8 @@
> #ifndef BACKENDS_IGVM_H
> #define BACKENDS_IGVM_H
>
>+#include "qemu/typedefs.h"
> #include "system/confidential-guest-support.h"
>-#include "system/igvm-cfg.h"
> #include "qapi/error.h"
>
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index d00acf351249..001c4dc93346 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -11,8 +11,10 @@
>
> #include "qemu/osdep.h"
>
>-#include "system/igvm-cfg.h"
> #include "system/igvm.h"
>+#include "system/igvm-cfg.h"
>+#include "system/igvm-internal.h"
>+#include "system/reset.h"

Why we need to include "system/reset.h" ?

The rest LGTM.
Stefano

> #include "qom/object_interfaces.h"
>
> static char *get_igvm(Object *obj, Error **errp)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 905bd8d98994..fbb8300b6d01 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -14,6 +14,8 @@
> #include "qapi/error.h"
> #include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
>+#include "system/igvm-cfg.h"
>+#include "system/igvm-internal.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>-- 
>2.52.0
>


