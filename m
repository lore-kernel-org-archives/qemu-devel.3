Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28934CEFD01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 19:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdD95-0000mt-KQ; Tue, 06 Jan 2026 14:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD93-0000mc-Pt
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD90-0003dC-UL
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767729305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLBYuCbGJX4wvpyfGEJZxJ88C6iaQlO+DitG52afzqY=;
 b=H9Yi6AWHeMshsAp1mRRhHoUWTDd7QcY3C81qQvmY37Sq1asAQ1hEhiHacCqq1i+LCoIfT1
 bmgJby+eVzUosF6DZ2jETNKdPvwx6tvkkWo1bfb1wZMQXgoNrMX9aWXY6ayZMWMpk8BWXQ
 C37WyT8uBObcj47YSShOIsF++vqiNi0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-gDHB52W_PjKFUjGL24mAZA-1; Tue, 06 Jan 2026 14:55:03 -0500
X-MC-Unique: gDHB52W_PjKFUjGL24mAZA-1
X-Mimecast-MFC-AGG-ID: gDHB52W_PjKFUjGL24mAZA_1767729302
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae25c02e7bso1656036eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767729302; x=1768334102; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JLBYuCbGJX4wvpyfGEJZxJ88C6iaQlO+DitG52afzqY=;
 b=M8/aH9hjRLEHUAtCsSGoU9OeCcTx7hOYVvr8CXeB/wSOGLLZ78NCoHei8odG1N8BX0
 FaedWbH4TqsyQ4apgSmL2Pp+CLqrzBp9z3rrxf6TfiXp7hCcTlCqKv8qAa4RxtqBXHa7
 sG2VCSxGdMLBlv7JBja0457/jBXOK//rA9CfOvTDV+Lapuk2HZTjfyv7XZJGGv2iBN07
 ejueU54IZTZ/CQJqLf5WmQIWy12mc+jLsgVYTOM2U2iHHCFfwPxDi2GOyXqjCyC8ZvOM
 p6TZXORs/xyxX7Fac3WaS+Wcjrfype+i0TuCVGw4XjRjsXRjz8lr5jtLrn06MpqXLEif
 SsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767729302; x=1768334102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLBYuCbGJX4wvpyfGEJZxJ88C6iaQlO+DitG52afzqY=;
 b=XITR3d4mgqlhln1jeqLUluAuN2Wz0JvWQxlbeTQ5jkVfWkT/JmMQHIg39AVBK2DIAq
 ibYaDH/NDS5F9WvcxkcJrbDtKZ0GmiZPFRJ9E0H/ZTkloqIAj9Zj/QCmVUN4nf4tiOoY
 +97BwSAldhXQc++mnXHDYlFKvEsJqCpbJyn6vPV6wSzzFfmuK4Yyv9uUqJq/dY3waZwE
 LENOtDp+aFoqCatsXCMEHOqm3DSj3v6byxOtS7heWe32LKgWzZetU5JE7lRt7s09pLPl
 FEVwg5MorZpzPCzvPGOdQw6z/P37l5FASrA3Ttll4tQTcRBhfoGH2d1BlV+A9LytWd7J
 3Ppw==
X-Gm-Message-State: AOJu0YyfpELN2GocUYGPT+yCX3i/qHS5BVhM53tp08pTNZRteNgzJ3O9
 CJUVmjZvgqPaTixTp8NYUP6hgO+bcNYuWyOwxF3ba3fHdNOH0n5X811LKyXBJv2BGEf2k0JikxF
 jWvR9WtL8gbqylCIonRyKt8tm523cBE30ACTUAbJvvxcH7R3XDHn2TcAS
X-Gm-Gg: AY/fxX6ZRo5bdMOWaqliC0tS6hLLrEku2mr5yZxruweci3wpHc2673kovHh2/FtB6Xt
 Oj8jjBoc9O6wohkyBFyIXWtb7m4PAywqicyFU/eNwY1u/i0xkhAc6mdu7vcbPlFKjzZh9WzDrNF
 SGsXnKhrfCHV46ph564fv/4839ZkJTYicmXCdFEGRkFhe15krjdr9azLdIDxscR4ojUSX1PKPY0
 OdMm5r6faC7GaKSpNtYL3iKal4+CpgIZuDrbjgDx19a4cgfeim8sOe3I1pXQ/n2Fp9r5zkFbDAp
 UPyj9j2puxqC/OpZAbNJ0XS6YH967TOsdPsK8cBBC9YC/VjMfifkE10nL82HjO37q+lL8/k4ASP
 pSDw=
X-Received: by 2002:a05:7300:f187:b0:2b0:310c:529 with SMTP id
 5a478bee46e88-2b17d24cbdamr83390eec.14.1767729302357; 
 Tue, 06 Jan 2026 11:55:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFIu02HwAcCxhs/vLcklLEDBeI8ft93+dvOf5ig54+hXRsbgVNgDubZ19BfGYjZS430Yl+FA==
X-Received: by 2002:a05:7300:f187:b0:2b0:310c:529 with SMTP id
 5a478bee46e88-2b17d24cbdamr83374eec.14.1767729301800; 
 Tue, 06 Jan 2026 11:55:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707d57aasm4518557eec.30.2026.01.06.11.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 11:55:01 -0800 (PST)
Date: Tue, 6 Jan 2026 14:54:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 1/3] multifd: Add colo support
Message-ID: <aV1oj75xvV8IfrU8@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-1-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230-colo_unit_test_multifd-v1-1-f9734bc74c71@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 30, 2025 at 03:05:44PM +0100, Lukas Straub wrote:
> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/meson.build    |  2 +-
>  migration/multifd-colo.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/multifd-colo.h | 26 ++++++++++++++++++++++
>  migration/multifd.c      | 14 +++++++++---
>  4 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/meson.build b/migration/meson.build
> index 16909d54c5110fc5d8187fd3a68c4a5b08b59ea7..1e59fe4f1f0bbfffed90df38e8f39fa87bceb9b9 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -40,7 +40,7 @@ system_ss.add(files(
>  ), gnutls, zlib)
>  
>  if get_option('replication').allowed()
> -  system_ss.add(files('colo-failover.c', 'colo.c'))
> +  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
>  else
>    system_ss.add(files('colo-stubs.c'))
>  endif
> diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..05a81e57b2bda517cbc0844b4f03dc78453f6af8
> --- /dev/null
> +++ b/migration/multifd-colo.c
> @@ -0,0 +1,57 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo implementation
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/target_page.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "ram.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "io/channel-socket.h"
> +#include "migration/colo.h"
> +#include "multifd-colo.h"
> +#include "system/ramblock.h"
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
> +{
> +    if (!migrate_colo()) {

We should avoid invoking *_colo_*() function, then check COLO enabled or
not only reaching here.  Instead, we'd check "migrate_colo()" first and
invoke it only if it's enabled.

> +        return;
> +    }
> +
> +    assert(p->block->colo_cache);
> +
> +    /*
> +     * While we're still in precopy state (not yet in colo state), we copy
> +     * received pages to both guest and cache. No need to set dirty bits,
> +     * since guest and cache memory are in sync.
> +     */
> +    if (migration_incoming_in_colo_state()) {
> +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> +    }
> +    p->host = p->block->colo_cache;

May want to update the comment of "host" then, because it isn't always
pointing to ramblock's buffer now when COLO is enabled.

> +}
> +
> +void multifd_colo_process_recv(MultiFDRecvParams *p)
> +{
> +    if (!migrate_colo()) {

Same here.

> +        return;
> +    }
> +
> +    if (!migration_incoming_in_colo_state()) {
> +        for (int i = 0; i < p->normal_num; i++) {
> +            void *guest = p->block->host + p->normal[i];
> +            void *cache = p->host + p->normal[i];
> +            memcpy(guest, cache, multifd_ram_page_size());
> +        }
> +    }
> +    p->host = p->block->host;
> +}
> diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f9d57a337d4754a
> --- /dev/null
> +++ b/migration/multifd-colo.h
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo header
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
> +#define QEMU_MIGRATION_MULTIFD_COLO_H
> +
> +#ifdef CONFIG_REPLICATION
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
> +void multifd_colo_process_recv(MultiFDRecvParams *p);
> +
> +#else
> +
> +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
> +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
> +
> +#endif
> +#endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index bf6da85af8a1e207235ce06b8dbace33beded6d8..9006f73cc5b52e8814da107c0b5c867ee6d03a95 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -29,6 +29,7 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "threadinfo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
> @@ -1398,11 +1399,18 @@ static void *multifd_recv_thread(void *opaque)
>              if (is_device_state) {
>                  assert(use_packets);
>                  ret = multifd_device_state_recv(p, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
>              } else {
> +                multifd_colo_prepare_recv(p);
> +
>                  ret = multifd_recv_state->ops->recv(p, &local_err);
> -            }
> -            if (ret != 0) {
> -                break;
> +                if (ret != 0) {
> +                    break;
> +                }
> +
> +                multifd_colo_process_recv(p);

Personally I'd suggest we introduce multifd_ram_state_recv() and put
everything there.

Thanks,

>              }
>          } else if (is_device_state) {
>              error_setg(&local_err,
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


