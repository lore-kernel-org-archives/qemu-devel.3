Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506E1D1681B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veB3H-0001Iy-2m; Fri, 09 Jan 2026 06:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veB3E-0001GT-32
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veB3C-0006TQ-FZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767959585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya8H71hJT0SUIfoFp5gHy6iX1tOX8Dxj4P5u0EREWgw=;
 b=Ic5z2rFN6oQ3s9qvL48WptHAoNwLD426GI4C0xiJJQT+rZY8eySyEJizWNwGsmEjL7VHy5
 yDJltlu5dwV/P3g/uG8vKqXJZBYeN7Q6jmhomgiVHWrZUSZgXGs7Q6LhP5cwS/saBMnL7c
 8QpVMCxs7mq1VYavgJBTc56BiVbq4zU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-8r-Fln2gMIiu7KaiAE9VPA-1; Fri, 09 Jan 2026 06:53:04 -0500
X-MC-Unique: 8r-Fln2gMIiu7KaiAE9VPA-1
X-Mimecast-MFC-AGG-ID: 8r-Fln2gMIiu7KaiAE9VPA_1767959583
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b83623fd3bdso590031666b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767959583; x=1768564383; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ya8H71hJT0SUIfoFp5gHy6iX1tOX8Dxj4P5u0EREWgw=;
 b=axpN5bkbrPBjoTFQgsfEn0fR0T2HkQP+SlJp7ESZ4OKDSz4ybiD96yvEQcIfedsvXk
 ewQlqz7DzJXL1CxhYjOR3b2DtKPVE4puPPzp+VH0R1kdF0/wanLtpzxp70DB4VqE/b+/
 q1+NCR/zHU+sS283cnnxiy6HGHvy/aj2VznAwUbywlNax3dxxHvhuX+DAhpPUEH2WKct
 7sZGuDSENOyfzUA23BOOyjfRkCSiDEC0lHNiPIgkxmjlkj9GI4MOdHM9YIe1Ly4lTEOv
 6d69lbNBRDDHR3YSIWthIVQldTIfN6Qmm5QzsjIJhz85nSnMC63KYLJfYWn/dMPnZpwt
 MUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767959583; x=1768564383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ya8H71hJT0SUIfoFp5gHy6iX1tOX8Dxj4P5u0EREWgw=;
 b=A0oVZ5BNXMuuoyGznEiwdeB78f40yXGYKRULex8yaHAj3RqN+8AAVxPsSovpGKNRb3
 2W2jtk5dBYyxq38e7/2wKcJ+9/blBXp2qQSJdZV1eCq4hz24xdG858UNLeGOaZOF6HjP
 CxXvrDYYJS+MZxbb04RuvADru3wNDagM8wW7uTXz8fpMxdR1G6cYUHZJVdGAUdNY2yVk
 yu0eVFnx+AG+IGdUgnPO4vFE7WGAxjm5/H4iawQmrXqGchvmWDJhofH5xDLQaj1JcHSN
 dvFC78aOTB+SArfW7OzL49mc07mHOdAN3jNbhNEIOuX8qnMBomcvF10/akYUeH9nBqIp
 UlSQ==
X-Gm-Message-State: AOJu0YyAx+wj802E8MigAPTsGpmxdWdMTUuJbcPZArcY6ClxZojGnGEg
 /RzTgBDX5UfFlLTvrk6kN7MgzFZpnY0tHJOVDCSwgPlYdbJHPrrkyWt7sZRP2SMA+z864j+HNki
 xsX+rJaQVHdUgbPZHwJncOK0/YSRHlgtFuWH0e2d/JhQ0x6KoMOW2WpK8
X-Gm-Gg: AY/fxX7B2UwiBn9s6dNzR86vT6WP0JnsP/471oEzkrdgi8h3BUZ9ibvgjW6xeHDFdlK
 zFwvQp9TeDRDPu8SLaoCJWGua4qMBp3Q7bK+KT+nZK5ULbLgEYHdy7cUZjATG5vwwvs3ww8ajRJ
 TMJAP5XImBVtkXoPLUouq8f1JsueCCnmcxWKwdSN60FzMHisEnkIxz0Y87UEjU/mGwoUcmn/P0g
 Rd+xcJdxAvpK3K7WY6CsJj1f9iezVeOYjrjF2HM3n4+lpP1yGV0/G/UYiUK9jNqJ80ZcgKDnrWn
 9exR+QH35YtJ1aGXOL7pj5UoSgVFjJPkVWBc3zGNn3S7y+w2RG+evT7KryCKtUUTE87/JjQfh7A
 MfH+j4UN3t0yzNZfe
X-Received: by 2002:a17:907:3d02:b0:b83:3716:ca6b with SMTP id
 a640c23a62f3a-b84451c7c7bmr928858266b.17.1767959583183; 
 Fri, 09 Jan 2026 03:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+nMcN4mIQNsRV7SlE/OWJotan7bCFhinZdE2FdOR5lMCOVufy1LJgo3MvauG7ly7k5ueX4Q==
X-Received: by 2002:a17:907:3d02:b0:b83:3716:ca6b with SMTP id
 a640c23a62f3a-b84451c7c7bmr928855066b.17.1767959582693; 
 Fri, 09 Jan 2026 03:53:02 -0800 (PST)
Received: from sgarzare-redhat ([193.207.180.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe76sm1079420766b.40.2026.01.09.03.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 03:53:02 -0800 (PST)
Date: Fri, 9 Jan 2026 12:52:58 +0100
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
Message-ID: <aWDsB5VqrKnft8v_@sgarzare-redhat>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-2-kraxel@redhat.com>
 <o3p7tqmk7nkzgrvoie5c2j5n32c242m54j7xfhiua3bkvoglcu@lavnoqs2hkbi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <o3p7tqmk7nkzgrvoie5c2j5n32c242m54j7xfhiua3bkvoglcu@lavnoqs2hkbi>
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

On Fri, Jan 09, 2026 at 12:41:33PM +0100, Stefano Garzarella wrote:
>On Thu, Dec 11, 2025 at 11:54:15AM +0100, Gerd Hoffmann wrote:
>>Add a new igvm-internal.h header file.  Structs and declarations which
>>depend on the igvm library header go into that file.
>>
>>Also declare IgvmCfg in typedefs.h, so the type can be used without
>>including igvm header files.
>>
>>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>---
>>include/qemu/typedefs.h        |  1 +
>>include/system/igvm-cfg.h      | 12 +-----------
>>include/system/igvm-internal.h | 26 ++++++++++++++++++++++++++
>>include/system/igvm.h          |  2 +-
>>backends/igvm-cfg.c            |  4 +++-
>>backends/igvm.c                |  2 ++
>>6 files changed, 34 insertions(+), 13 deletions(-)
>>create mode 100644 include/system/igvm-internal.h
>>
>>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>index 4a94af9665a5..416a8c9acead 100644
>>--- a/include/qemu/typedefs.h
>>+++ b/include/qemu/typedefs.h
>>@@ -55,6 +55,7 @@ typedef struct FWCfgState FWCfgState;
>>typedef struct HostMemoryBackend HostMemoryBackend;
>>typedef struct I2CBus I2CBus;
>>typedef struct I2SCodec I2SCodec;
>>+typedef struct IgvmCfg IgvmCfg;
>>typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
>>typedef struct ISABus ISABus;
>>typedef struct ISADevice ISADevice;
>>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>>index 944f23a814dd..6c07f3084082 100644
>>--- a/include/system/igvm-cfg.h
>>+++ b/include/system/igvm-cfg.h
>>@@ -12,19 +12,9 @@
>>#ifndef QEMU_IGVM_CFG_H
>>#define QEMU_IGVM_CFG_H
>>
>>+#include "qemu/typedefs.h"
>>#include "qom/object.h"
>>
>>-typedef struct IgvmCfg {
>>-    ObjectClass parent_class;
>>-
>>-    /*
>>-     * filename: Filename that specifies a file that contains the configuration
>>-     *           of the guest in Independent Guest Virtual Machine (IGVM)
>>-     *           format.
>>-     */
>>-    char *filename;
>>-} IgvmCfg;
>>-
>>typedef struct IgvmCfgClass {
>>    ObjectClass parent_class;
>>
>>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>>new file mode 100644
>>index 000000000000..475a29bbf3d7
>>--- /dev/null
>>+++ b/include/system/igvm-internal.h
>>@@ -0,0 +1,26 @@
>>+/*
>>+ * QEMU IGVM private data structures
>>+ *
>>+ * Everything which depends on igvm library headers goes here.
>>+ *
>>+ * SPDX-License-Identifier: GPL-2.0-or-later
>>+ */
>>+
>>+#ifndef QEMU_IGVM_INTERNAL_H
>>+#define QEMU_IGVM_INTERNAL_H
>>+
>>+#include "qemu/typedefs.h"
>>+#include "qom/object.h"
>>+
>>+struct IgvmCfg {
>>+    ObjectClass parent_class;
>>+
>>+    /*
>>+     * filename: Filename that specifies a file that contains the configuration
>>+     *           of the guest in Independent Guest Virtual Machine (IGVM)
>>+     *           format.
>>+     */
>>+    char *filename;
>>+};
>>+
>>+#endif
>>diff --git a/include/system/igvm.h b/include/system/igvm.h
>>index 48ce20604259..8355e54e95fc 100644
>>--- a/include/system/igvm.h
>>+++ b/include/system/igvm.h
>>@@ -12,8 +12,8 @@
>>#ifndef BACKENDS_IGVM_H
>>#define BACKENDS_IGVM_H
>>
>>+#include "qemu/typedefs.h"
>>#include "system/confidential-guest-support.h"
>>-#include "system/igvm-cfg.h"
>>#include "qapi/error.h"
>>
>>int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>>index d00acf351249..001c4dc93346 100644
>>--- a/backends/igvm-cfg.c
>>+++ b/backends/igvm-cfg.c
>>@@ -11,8 +11,10 @@
>>
>>#include "qemu/osdep.h"
>>
>>-#include "system/igvm-cfg.h"
>>#include "system/igvm.h"
>>+#include "system/igvm-cfg.h"
>>+#include "system/igvm-internal.h"
>>+#include "system/reset.h"
>
>Why we need to include "system/reset.h" ?

BTW it's a minor thing:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>The rest LGTM.
>Stefano
>
>>#include "qom/object_interfaces.h"
>>
>>static char *get_igvm(Object *obj, Error **errp)
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index 905bd8d98994..fbb8300b6d01 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -14,6 +14,8 @@
>>#include "qapi/error.h"
>>#include "qemu/target-info-qapi.h"
>>#include "system/igvm.h"
>>+#include "system/igvm-cfg.h"
>>+#include "system/igvm-internal.h"
>>#include "system/memory.h"
>>#include "system/address-spaces.h"
>>#include "hw/core/cpu.h"
>>-- 
>>2.52.0
>>


