Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F888D767D9
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6WVr-0003SJ-9u; Thu, 31 Oct 2024 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6WVq-0003S0-A4
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6WVn-0007bb-MO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730386258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBgWunjofV/JrQaDxVFPYJdS/KxxXHVfCeg40gVwl4g=;
 b=ACod+Fy7PEeEdU4f8FffT08LkLfzk0B4SHY5QJGOjXgjhmfHgd5+PqrEiA/ncyh/1qJV1s
 9yIZ13kWbvZBNa+VPGxG4Dz/a6NtitkLrWseacA0B2dK1SS+nWrIbFT9l6V5F0UZfpXtCo
 /eLm9+knrUkDA/oiRs7bG+eqEohIQQU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-oKBeRWEdPHGGen4BbofJ-w-1; Thu, 31 Oct 2024 10:50:56 -0400
X-MC-Unique: oKBeRWEdPHGGen4BbofJ-w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b14538be1eso136338385a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 07:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730386256; x=1730991056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBgWunjofV/JrQaDxVFPYJdS/KxxXHVfCeg40gVwl4g=;
 b=S1bS1L5wKZWt5PlQg6JNfRb8VVv3wotF2JFt+cEfSmVk4ASyQIt62hhY0to+FCF1ZX
 Lhb2TlYExHmtDIDuVi6hPi6qoyzl58/kTO7jn72fSm5rGvgcn72rya8qJVTKtTflnUDE
 lfowGE4qG+a+b0/kbzDkG5/ahQdpg9om1Hv2AAssmcC7z9jUTT4fFE2bahNFA/AHp780
 Wq9k+B4pLl81VvSw8Yi660U5bpd4tvq5Pva+OXjutXqxL8dnGoePmiL5ZOUntxYKZRLK
 tAicKhhcLHQxcalfIDyiPfI5Wj6cy0DXK+V77Jvqpnw5ya5cRmXeX4X+/1y/qbJr4GfY
 4LWw==
X-Gm-Message-State: AOJu0YwG+UVzT9lvdxRApPLHvkW4B9KxTzU/w4HxlZE73vdY5UuUpGRE
 LCCooyA8F3yeDq20sPt4c8k4OwY2zqx8fdhQVvWfdy4xG9NF50CNeiAkgjga9iIwx97TvdWo3eY
 yrCcoQIZCuuP61PGjHDszhae0NeWGC0WooegYxY4GtLjFnBqTIVgC
X-Received: by 2002:a05:620a:4108:b0:7ac:9b07:dbd9 with SMTP id
 af79cd13be357-7b2f2554e5bmr388316585a.65.1730386256097; 
 Thu, 31 Oct 2024 07:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0NQK4uhmrtLEESGceY9AKO4NexoyKXx5GgsjtjibWEEH+WyU3d5k38muvFHVk5Zsgk2mAIQ==
X-Received: by 2002:a05:620a:4108:b0:7ac:9b07:dbd9 with SMTP id
 af79cd13be357-7b2f2554e5bmr388314185a.65.1730386255711; 
 Thu, 31 Oct 2024 07:50:55 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a9c205sm74236585a.136.2024.10.31.07.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 07:50:54 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:50:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/18] Migration 20241030 patches
Message-ID: <ZyOZTDUB-GfyRYo9@x1n>
References: <20241030155734.2141398-1-peterx@redhat.com>
 <CAFEAcA_p+LiT6wz2UaPBUs14XBnuCM9x46piOLSJP6WivMMbAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_p+LiT6wz2UaPBUs14XBnuCM9x46piOLSJP6WivMMbAQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 31, 2024 at 01:28:31PM +0000, Peter Maydell wrote:
> On Wed, 30 Oct 2024 at 15:57, Peter Xu <peterx@redhat.com> wrote:
> >
> > The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:
> >
> >   Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/peterx/qemu.git tags/migration-20241030-pull-request
> >
> > for you to fetch changes up to 53a60118d2654dd8e595e61f4e767ff747fd0b69:
> >
> >   migration/multifd: Zero p->flags before starting filling a packet (2024-10-30 11:32:41 -0400)
> >
> > ----------------------------------------------------------------
> > Migration pull request for softfreeze
> >
> > NOTE: checkpatch.pl could report a false positive on this branch:
> >
> >   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> >   #21:
> >    {include/sysemu => migration}/cpu-throttle.h | 0
> >
> > That's covered by "F: migration/" entry.
> >
> > Changelog:
> >
> > - Peter's cleanup patch on migrate_fd_cleanup()
> > - Peter's cleanup patch to introduce thread name macros
> > - Hanna's error path fix for vmstate subsection save()s
> > - Hyman's auto converge enhancement on background dirty sync
> > - Peter's additional tracepoints for save state entries
> > - Thomas's build fix for OpenBSD in dirtyrate.c
> > - Peter's deprecation of query-migrationthreads command
> > - Peter's cleanup/fixes from the "export misc.h" series
> > - Maciej's two small patches from multifd+vfio series
> 
> 
> >  {include/sysemu => migration}/cpu-throttle.h |  14 ++
> 
> Hi; this fails to build on macos:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8237753019
> 
> ../ui/cocoa.m:40:10: fatal error: 'sysemu/cpu-throttle.h' file not found
>     40 | #include "sysemu/cpu-throttle.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.

Errr, cocoa.m used cpu-throttle for Speed feature.. so it needs it to be
exported.

Luckily cocoa.m is only compiled in system_ss.  The simplest fix so far is
to only move cpu-throttle.c, not cpu-throttle.h yet in the commit:

"migration: Move cpu-throttole.c from system to migration"

Fixup patch to be squashed:

===8<===
From 68515db81e28832cbd24b1cdbc12aeb618c9de54 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 31 Oct 2024 10:37:29 -0400
Subject: [PATCH] fixup! migration: Move cpu-throttole.c from system to
 migration

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 {migration => include/sysemu}/cpu-throttle.h | 0
 migration/cpu-throttle.c                     | 2 +-
 migration/migration.c                        | 2 +-
 migration/ram.c                              | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename {migration => include/sysemu}/cpu-throttle.h (100%)

diff --git a/migration/cpu-throttle.h b/include/sysemu/cpu-throttle.h
similarity index 100%
rename from migration/cpu-throttle.h
rename to include/sysemu/cpu-throttle.h
diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 3df287d8d3..5179019e33 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -27,7 +27,7 @@
 #include "hw/core/cpu.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
-#include "cpu-throttle.h"
+#include "sysemu/cpu-throttle.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index 04d7e67897..aedf7f0751 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,7 +24,7 @@
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "cpu-throttle.h"
+#include "sysemu/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
diff --git a/migration/ram.c b/migration/ram.c
index 12031df4e5..05ff9eb328 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,7 +52,7 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "cpu-throttle.h"
+#include "sysemu/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
-- 
2.45.0
===8<===

Hyman/Fabiano, feel free to comment if there's any objections.  I'll wait
for 1 day for that before I send the v2 pull with the planned fix.

Thanks,

-- 
Peter Xu


