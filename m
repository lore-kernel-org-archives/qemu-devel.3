Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF06D25056
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDwJ-0000wL-RR; Mon, 12 Jan 2026 04:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfDvy-0000tC-HC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfDvv-0005T0-Bp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768208993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSuT/0CZJUlxPAoAkk/Cbo2iXK2663iq+mn9uRQOZp8=;
 b=NVblrn1eelcWkfkQhjX8Ay5a9cbKb7pmDdfLfdaa7+NEiB/eLrCSzEXyF+ZD7kVpWn8OL8
 l/tA1Upd6hWnLznY4KUsPL3zvjwCDzcLt6gXzl95TniiVPexwcxqki7Z+g8ScE8+qLq6p9
 KrTPgThot4S55t2z++lnpZp7gY23TiE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Ye2eNN3iOgqYJOWBdN19BA-1; Mon, 12 Jan 2026 04:09:52 -0500
X-MC-Unique: Ye2eNN3iOgqYJOWBdN19BA-1
X-Mimecast-MFC-AGG-ID: Ye2eNN3iOgqYJOWBdN19BA_1768208991
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo2657484f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768208991; x=1768813791; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSuT/0CZJUlxPAoAkk/Cbo2iXK2663iq+mn9uRQOZp8=;
 b=P3MmbcLc7XG9JxqTowFN5fKOJuFS6/sfqmncOUmiQ086gu2d0w1IDAEbk/NyguE93J
 OC4pS64nIxkjt83ca/Lphd48UWtanatwVdRfkS0Y3olqRuL2h2unGJGRp1WSBx9UB6E1
 6XggQHhc35dRteBbbZ8pDD6RfM9k29c2wG8yzxfuh5FFwRDo4qEO+gKzdUrm5cMbcwiF
 GZYOTP1GpQrf0yhhmXo8rW8bK9t6U7xiCGPfEKhHBTD1XGlx5wgXkBsmkuJYZo31mpAx
 zUZUZ9z3ck7fKLxnLfrXpcCnfaKqn+7KrmIxn36Cej0a0NzhcbqRrRvA0CAH0Kp0aWl1
 FKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208991; x=1768813791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSuT/0CZJUlxPAoAkk/Cbo2iXK2663iq+mn9uRQOZp8=;
 b=StzDB8RA1loJoJD2IpasLCzH1N6q0jsUdIRpCo21FYEdt2r24oVf9Ep2bffrTqDHKd
 tdDhNc51nICQyXneOThpfPBKHpRqDIZfUXFKNO/K/FZR/06OQaWWQVvqgxHJgso+enNs
 V1saWuAdGHnWxdvB73f6M9+04CreGsDxKZ3sZKB0s/aZbJqxq4nbg8GTIhdpejr1Y24R
 yZlX4jvz51OFxFc1IdjkW+/VIRcDaWG9gel+1bcj1ic1FE8dCYgoi4Pf54pW7k9cDF46
 5OOmUUlK3DNSMepF2ftsJkwNIqAfqkSvKNTnUt9qNppHmEfrk+c2JlVjj30zeEV7GggC
 Krqg==
X-Gm-Message-State: AOJu0YzH+MLQggKrI1W6M2gThjSZ3UkjJ4IhcoXu6Ady8Av8HfLeo/54
 jJ23GbWBS8cVDXoRLZNzDGo5N+0za4Da48xoP523DapOFHO4jqRrq31tbJJd7W+CHj+ODBi7saN
 DlzxQmVTNw4imJGbUqGNt8vowrRrrHTX5ei81Bj9jLU5/VZZSa26PFAMC
X-Gm-Gg: AY/fxX7lK/jabuWxyNc4GTLKdC4EbOfYTT+ol5iGibHLriOua6R3EDMNr7eF67UCEnO
 /2Rx/40ELCvu4LO4MyRJCqi1/OJIAl5diZs7//cz9OOZnxSWAQz58uvMVFPBNnzXRdJCF9t/GUj
 f/yxpRg+VeqVTFOLZqCaBp41CiEpKwu7eKp5Ck0Iggrs4MmWu1mpvcn027phjr6bbTPyyHux7x+
 Bo/7Jiu0Eqz96HKOotGhWK65GRr7St/2KJ5CV2iuEufOgtkDNdb8Df8ydW7bHC4J/3xVLH1Ip9L
 w2uNJWA1zsFaY6PLExo+MwXgKnMatDVtr2PSf4cN6LQ9xuRbE/SVFWFE7Wn2w93GwUKpCMpVg2W
 GdAoBu7yOvrdzqS8=
X-Received: by 2002:a5d:588e:0:b0:432:dcb1:68bc with SMTP id
 ffacd0b85a97d-432dcb168f0mr9994008f8f.23.1768208990804; 
 Mon, 12 Jan 2026 01:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEou46/tWfcOz7Gf/aBTaWgoyngU5ScXeNfqrgld1bOD14Qw8AG6MvtX59+5RA8ur25K5gxiA==
X-Received: by 2002:a5d:588e:0:b0:432:dcb1:68bc with SMTP id
 ffacd0b85a97d-432dcb168f0mr9993968f8f.23.1768208990364; 
 Mon, 12 Jan 2026 01:09:50 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm38411242f8f.11.2026.01.12.01.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:09:49 -0800 (PST)
Date: Mon, 12 Jan 2026 10:09:40 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 5/6] igvm: Pass machine state to IGVM file processing
Message-ID: <aWS51gJnoQTIDIaO@leonardi-redhat>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-6-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260109143413.293593-6-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, Jan 09, 2026 at 03:34:12PM +0100, Oliver Steffen wrote:
>Add a new MachineState* parameter to qigvm_process_file()
>to make the machine state available in the IGVM processing
>context. We will use it later to generate MADT data there
>to pass to the guest as IGVM parameter.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm-cfg.c       | 2 +-
> backends/igvm.c           | 6 +++++-
> include/system/igvm-cfg.h | 3 ++-
> include/system/igvm.h     | 3 ++-
> target/i386/sev.c         | 2 +-
> 5 files changed, 11 insertions(+), 5 deletions(-)
>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index c1b45401f4..d79bdecab1 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -51,7 +51,7 @@ static void igvm_reset_hold(Object *obj, ResetType type)
>
>     trace_igvm_reset_hold(type);
>
>-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
>+    qigvm_process_file(igvm, ms->cgs, false, ms, &error_fatal);
> }
>
> static void igvm_reset_exit(Object *obj, ResetType type)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a797bd741c..7390dee734 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -11,6 +11,7 @@
>
> #include "qemu/osdep.h"
>
>+#include "hw/boards.h"
> #include "qapi/error.h"
> #include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
>@@ -93,6 +94,7 @@ typedef struct QIgvm {
>     unsigned region_start_index;
>     unsigned region_last_index;
>     unsigned region_page_count;
>+    MachineState *machine_state;
> } QIgvm;
>
> static QIgvmParameterData *qigvm_find_param_entry(QIgvm *igvm, const IGVM_VHS_PARAMETER *param) {
>@@ -906,7 +908,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
> }
>
> int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>-                       bool onlyVpContext, Error **errp)
>+                       bool onlyVpContext, MachineState *machine_state, Error **errp)
> {
>     int32_t header_count;
>     QIgvmParameterData *parameter;
>@@ -929,6 +931,8 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>     ctx.cgs = cgs;
>     ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
>
>+    ctx.machine_state = machine_state;
>+
>     /*
>      * Check that the IGVM file provides configuration for the current
>      * platform
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 7dc48677fd..2783fc542e 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -12,6 +12,7 @@
> #ifndef QEMU_IGVM_CFG_H
> #define QEMU_IGVM_CFG_H
>
>+#include "hw/boards.h"
> #include "qom/object.h"
> #include "hw/resettable.h"
>
>@@ -43,7 +44,7 @@ typedef struct IgvmCfgClass {
>      * Returns 0 for ok and -1 on error.
>      */
>     int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>-                   bool onlyVpContext, Error **errp);
>+                   bool onlyVpContext, MachineState *machine_state, Error **errp);
>
> } IgvmCfgClass;
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index ec2538daa0..0afe784a17 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -14,11 +14,12 @@
>
> #include "system/confidential-guest-support.h"
> #include "system/igvm-cfg.h"
>+#include "hw/boards.h"
> #include "qapi/error.h"
>
> IgvmHandle qigvm_file_init(char *filename, Error **errp);
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>-                      bool onlyVpContext, Error **errp);
>+                      bool onlyVpContext, MachineState *machine_state, Error **errp);
>
> /* x86 native */
> int qigvm_x86_get_mem_map_entry(int index,
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index fd2dada013..a733868043 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          */
>         if (x86machine->igvm) {
>             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
>-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
>+                    ->process(x86machine->igvm, machine->cgs, true, machine, errp) ==

`cgs` is part of the machine state. WDYT about dropping it?

Luigi


