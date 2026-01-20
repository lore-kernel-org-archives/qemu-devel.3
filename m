Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280DCA5FB7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFJ5-00030G-Dy; Tue, 20 Jan 2026 12:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFJ4-000304-5R
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFJ1-00017a-Nd
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768929253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ik+bVVX3xwrIormXBQVp1PPxSpXq2ko+RZAxh9HwZC4=;
 b=YGIhbM9A2A1GlMrZg/aMzwyBzy1Q4/Ib6mz0aDlEX640eYJcwxkZhFf8oooKJ27+R9l+f+
 EZV5MXWjaUIDuejCKMhs7UsEee8+l6sOyqW7o8Rxi4P4Wb6F1t8pqvrcklyNMf2/1pKUSP
 xG11wLZnem+rs7eApt8t7PDKZznei3g=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-LmM7aontOZ2fyDLTvgH1Xw-1; Tue, 20 Jan 2026 12:14:11 -0500
X-MC-Unique: LmM7aontOZ2fyDLTvgH1Xw-1
X-Mimecast-MFC-AGG-ID: LmM7aontOZ2fyDLTvgH1Xw_1768929250
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b70c92f404so300752eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768929250; x=1769534050; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ik+bVVX3xwrIormXBQVp1PPxSpXq2ko+RZAxh9HwZC4=;
 b=VqThX83vBKJYFfJ80oPXCiqI3/vxazYEqXxPjYWNx1Quq3CBiJFJxKKfCq7HxXPTs/
 MvaYtd28KQhE+nVd0S+m9RP7GTNHo8iFBs1Mn+CshqHN+uB5gRizZpnY6gzmLvzXMkES
 FDyThiq1GCa9pMpDaIXbAU8DeuBvaMBYnje5sWyTcYtH/lr002gFuDke/AMIgOK8DUjG
 PgqzzqkfQ1S0HA2PhlTWauibiCz5XONl5Iv/iQbN8YJ7Y1HkKYTXDFvU0jAGEfRD384h
 JVEbdIpEI6TdRsFNENwogMHAm/sY4SdaNuYg/amHoRI8fzhbfcWtVmIjCVnyMCTfvRaY
 /2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768929250; x=1769534050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik+bVVX3xwrIormXBQVp1PPxSpXq2ko+RZAxh9HwZC4=;
 b=AXVpSXdpuZQff/nBkgV3eVCDoDpEUIPfjpH9ZSP4wZXmTItQYERpDPHqUMbHBhAsgi
 x/CpdV9MgyImqhSx04q48Dew0zGHvoTVbHZ/FLkhnrvNsTVmj2Qh77yChZjNOMqwlyOX
 T0mM4n9sKonJH+BJwY0trwJYKyClrTpcDOqwfg+/ThwGHUitBocpy3L20OpYgd5m+v/g
 gsQcHC+0eACL1s4pHKXOM+Pv/1okeJymUfZZwZ/K9EyEGCbl1yCB7z8reoClZbuM0l8J
 2xxyp+umLWwxJ4Bsvag8uUhDtAlIPw30rPRKL8M+PndJdKH6rZZdguDAhkLHm6PzXS37
 s3wA==
X-Gm-Message-State: AOJu0YwF1XX1RmGR2e9nuCKriBiHt+MkoBdbsF5PdSse2ryfTUqao1tX
 kqEg7/dzGy0clY5HgXOnlVIUh+cZV169bwrNOH5uKVjcD3K+v6k3nai5L5adsXoc6Hb2HJ91844
 LT4DRUY0tffjlrqs47RO8ItsfM4nuNOiX3gS2to+gnDMB6T/gqtO6GlrF
X-Gm-Gg: AZuq6aLE/LDvqq7SwqCOHW0t/ay8GI7MwCnwaRQ0Q1MfbKPYzX7aimkh/VrrEy1OFqA
 2nUk30xdStw/txO9q8BvF65NRYEbfQRU5fB6DD5ExNqDIH89+F3SeEHu6A9ifAIEVLFT/MGIJTL
 QKFRWcDCUmsvtea+QZ0EkQjEGNc2irznncZwKS69X4s0fgP74uAcokJEpvfBOiRbRBkkhPB7kih
 8EtPpt1uQei8YUKM1T/a7aujvAAjEFAcr2xzYcH3bThNkHwK54F/jXQbuxpMOswuy/k8V+Mucko
 msiLq7S6ETW950/gmd7w2nZLQIO5ih+is4Pc1zplY7/cA5hi43gjFC5acleu5lY/KH+HIZABCxj
 yL/c=
X-Received: by 2002:a05:7300:ec0c:b0:2ae:5a13:9e3a with SMTP id
 5a478bee46e88-2b6b412acafmr9565589eec.40.1768929248724; 
 Tue, 20 Jan 2026 09:14:08 -0800 (PST)
X-Received: by 2002:a05:7300:ec0c:b0:2ae:5a13:9e3a with SMTP id
 5a478bee46e88-2b6b412acafmr9565489eec.40.1768929246636; 
 Tue, 20 Jan 2026 09:14:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1244af108absm19954268c88.13.2026.01.20.09.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:14:06 -0800 (PST)
Date: Tue, 20 Jan 2026 12:13:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v2 4/8] multifd: Add COLO support
Message-ID: <aW-31rQky14G8_lq@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Sat, Jan 17, 2026 at 03:09:11PM +0100, Lukas Straub wrote:
> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
> 
> Multifd with COLO is useful to reduce the VM pause time during checkpointing
> for latency sensitive workloads. In such workloads the worst-case latency
> is especially important.
> 
> Also, multifd migration is the preferred way to do migration nowadays and this
> allows to use multifd compression with COLO.
> 
> Benchmark:
> Cluster nodes
>  - Intel Xenon E5-2630 v3
>  - 48Gb RAM
>  - 10G Ethernet
> Guest
>  - Windows Server 2016
>  - 6Gb RAM
>  - 4 cores
> Workload
>  - Upload a file to the guest with SMB to simulate moderate
>    memory dirtying
>  - Measure the memory transfer time portion of each checkpoint
>  - 600ms COLO checkpoint interval
> 
> Results
> Plain
>  idle mean: 4.50ms 99per: 10.33ms
>  load mean: 24.30ms 99per: 78.05ms
> Multifd-4
>  idle mean: 6.48ms 99per: 10.41ms
>  load mean: 14.12ms 99per: 31.27ms

Thanks for the numbers.  They're persuasive at least from 1st look.

Said that, one major question is, multifd should only help with throughput
when cpu is a bottleneck sending, in your case it's 10Gbps NIC.  Normally
any decent cpu should be able to push closer to 10Gbps even without
multifd.

Per my previous experiences, multifd can only show a difference when the
hosts have at least 25GBps+ bandwidth available.

Maybe you turned on compression already?  If so, worth stating the
compressor methods chosen / parameters.

> 
> Evaluation
> While multifd has slightly higher latency when the guest idles, it is
> 10ms faster under load and more importantly it's worst case latency is
> less than 1/2 of plain under load as can be seen in the 99. Percentile.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS              |  1 +
>  migration/meson.build    |  2 +-
>  migration/multifd-colo.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/multifd-colo.h | 26 +++++++++++++++++++++++++
>  migration/multifd.c      | 12 ++++++++++++
>  migration/multifd.h      |  1 +
>  6 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 563804345fec68ee72793dbb7c1b7e5be4c32083..dbb217255c2cf35dc0ce971c2021b130fac5469b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3837,6 +3837,7 @@ COLO Framework
>  M: Lukas Straub <lukasstraub2@web.de>
>  S: Maintained
>  F: migration/colo*
> +F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: docs/COLO-FT.txt
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
> index 0000000000000000000000000000000000000000..d8d98e79b12ed52c41f341052a682d7786e221b5
> --- /dev/null
> +++ b/migration/multifd-colo.c
> @@ -0,0 +1,49 @@
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

I should have mentioned it while reviewing the previous version, anyway..

IMHO it would be better to have one place setting p->host instead of
overwritting it.

So instead of hooking before ->recv(), we should do it in
multifd_ram_unfill_packet(), moving the p->host update to the end of
function and hook it there with COLO (so that you can still record the
bitmaps, only after normal[]).

Another thing, which might be more important: you seem to have ignored
zero[], but I think you need it.  zero[] keeps all pages that are zeros
(which may not used to be zeros).  So IMHO you'll need to record them as
dirty too in COLO's dest bitmap, otherwise you may hit hard to debug RAM
corruptions.

> +}
> +
> +void multifd_colo_process_recv(MultiFDRecvParams *p)
> +{
> +    if (!migration_incoming_in_colo_state()) {
> +        for (int i = 0; i < p->normal_num; i++) {
> +            void *guest = p->block->host + p->normal[i];
> +            void *cache = p->host + p->normal[i];
> +            memcpy(guest, cache, multifd_ram_page_size());
> +        }
> +    }
> +    p->host = p->block->host;

Is resetting the pointer required?  If not, we can skip it.

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
> index 8e71171fb7a17726ba7eb0705e293c41e8aa32ec..6c85acec3bac134e85cfcee0d32057134f5af8d1 100644
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
> @@ -1269,7 +1270,18 @@ static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
>  {
>      int ret;
>  
> +    if (migrate_colo()) {
> +        multifd_colo_prepare_recv(p);
> +    }
> +
>      ret = multifd_recv_state->ops->recv(p, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    if (migrate_colo()) {
> +        multifd_colo_process_recv(p);
> +    }
>  
>      return ret;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9b6d81e7ede024f05d4cd235de95e73840d0bbc4..7036f438fade1baed2442bfdcf8b5d6397c4a448 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -280,6 +280,7 @@ typedef struct {
>      /* ramblock */
>      RAMBlock *block;
>      /* ramblock host address */
> +    /* or points to the corresponding address in the colo cache */

Nit: we can merge it with /* ... */, and some wording change:

       /*
        * Normally, it points to ramblock's host address.  When COLO
        * enabled, it points to the mirror cache for the ramblock.
        */

>      uint8_t *host;
>      /* buffers to recv */
>      struct iovec *iov;
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


