Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E416D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJje-0001X1-Pd; Fri, 11 Oct 2024 13:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1szJjV-0001VR-Qw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:47:22 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1szJjM-0000O6-E4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=6uOdLXp6BvLQyZMcUQAWbdFN2zwYIvqLxaUexQXhICY=; b=V/QWzkM90y5s44K/
 gO42cjHpn2KNiJsH4aB0X+o5QZFR+xMsidX8vc8AwVRJgNfxjzlzr4OEbeUrD8RIwshaseB3TUwEM
 4SosTQIjvMQzpKviAZOWAdZFIUp2vMGOSluJBInrlAcPqOYuzWYeouQoJb84OSWdcSpaVVgdOQn8H
 LHQMZUH1mSpdENsPPnL1Ih8LNjM5VCtoJ3Pop2/pvKHYhQQnI2vEL4G/wxt0XyatqvU0sKkVgQCGw
 QsptO1rIuHGrW0DEOFuhMJI3YXWJNCi0vgfArSEdn7EFBvfMz2rR421/bceUXG8HjEK8GW4I1xI0d
 NJbki8tcMauHJF6Gaw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1szJjD-00AZvc-2w;
 Fri, 11 Oct 2024 17:47:03 +0000
Date: Fri, 11 Oct 2024 17:47:03 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
Message-ID: <Zwlklx6232nW6ln5@gallifrey>
References: <20241011153417.516715-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241011153417.516715-1-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:43:54 up 156 days,  4:57,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Xu (peterx@redhat.com) wrote:
> This reverts two commits:
> 
> 671326201dac8fe91222ba0045709f04a8ec3af4
> 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
> 
> Meanwhile it adds an entry to removed-features.rst for the
> query-migrationthreads QMP command.
> 
> This patch originates from another patchset [1] that wanted to cleanup the
> interface and add corresponding HMP command, as lots of things are missing
> in the query report; so far it only reports the main thread and multifd
> sender threads; all the rest migration threads are not reported, including
> multifd recv threads.
> 
> As pointed out by Dan in the follow up discussions [1], the API is designed
> in an awkward way where CPU pinning may not cover the whole lifecycle of
> even the thread being reported.  When asked, we also didn't get chance to
> hear from the developer who introduced this feature to explain how this API
> can be properly used.

One suggestion for replacing it, might be a way for a management interface
to add threads to a thread-pool, prior to migration; and then have migration
use threads from that pool rather than creating it's own.

Dave

> OTOH, this feature from debugging POV isn't very helpful either, as all
> these information can be easily obtained by GDB.  Esepcially, if with
> "-name $VM,debug-threads=on" we do already have names for each migration
> threads (which covers more than multifd sender threads).
> 
> So it looks like the API isn't helpful in any form as of now, besides it
> only adds maintenance burden to migration code, even if not much.
> 
> Considering that so far there's totally no justification on how to use this
> interface correctly, let's remove this interface instead of cleaning it up.
> 
> In this special case, we even go beyond normal deprecation procedure,
> because a deprecation process would only make sense when there are existing
> users. In this specific case, we expect zero serious users with this API.
> 
> [1] https://lore.kernel.org/qemu-devel/20240930195837.825728-1-peterx@redhat.com/
> 
> Cc: Jiang Jiacheng <jiangjiacheng@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst |  6 ++++
>  qapi/migration.json             | 27 --------------
>  migration/threadinfo.h          | 25 -------------
>  migration/migration.c           |  6 ----
>  migration/multifd.c             |  5 ---
>  migration/threadinfo.c          | 64 ---------------------------------
>  migration/meson.build           |  1 -
>  7 files changed, 6 insertions(+), 128 deletions(-)
>  delete mode 100644 migration/threadinfo.h
>  delete mode 100644 migration/threadinfo.c
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index c76b91a88d..02ca43dec7 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -693,6 +693,12 @@ Use ``multifd-channels`` instead.
>  
>  Use ``multifd-compression`` instead.
>  
> +``query-migrationthreads`` (removed in 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Removed with no replacement.  For debugging purpose, please use ``-name
> +$VM,debug-threads=on`` instead.
> +
>  QEMU Machine Protocol (QMP) events
>  ----------------------------------
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3af6aa1740..5520a51553 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2264,33 +2264,6 @@
>  { 'command': 'query-vcpu-dirty-limit',
>    'returns': [ 'DirtyLimitInfo' ] }
>  
> -##
> -# @MigrationThreadInfo:
> -#
> -# Information about migrationthreads
> -#
> -# @name: the name of migration thread
> -#
> -# @thread-id: ID of the underlying host thread
> -#
> -# Since: 7.2
> -##
> -{ 'struct': 'MigrationThreadInfo',
> -  'data': {'name': 'str',
> -           'thread-id': 'int'} }
> -
> -##
> -# @query-migrationthreads:
> -#
> -# Returns information of migration threads
> -#
> -# Returns: @MigrationThreadInfo
> -#
> -# Since: 7.2
> -##
> -{ 'command': 'query-migrationthreads',
> -  'returns': ['MigrationThreadInfo'] }
> -
>  ##
>  # @snapshot-save:
>  #
> diff --git a/migration/threadinfo.h b/migration/threadinfo.h
> deleted file mode 100644
> index 2f356ff312..0000000000
> --- a/migration/threadinfo.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - *  Migration Threads info
> - *
> - *  Copyright (c) 2022 HUAWEI TECHNOLOGIES CO., LTD.
> - *
> - *  Authors:
> - *  Jiang Jiacheng <jiangjiacheng@huawei.com>
> - *
> - *  This work is licensed under the terms of the GNU GPL, version 2 or later.
> - *  See the COPYING file in the top-level directory.
> - */
> -
> -#include "qapi/error.h"
> -#include "qapi/qapi-commands-migration.h"
> -
> -typedef struct MigrationThread MigrationThread;
> -
> -struct MigrationThread {
> -    const char *name; /* the name of migration thread */
> -    int thread_id; /* ID of the underlying host thread */
> -    QLIST_ENTRY(MigrationThread) node;
> -};
> -
> -MigrationThread *migration_threads_add(const char *name, int thread_id);
> -void migration_threads_remove(MigrationThread *info);
> diff --git a/migration/migration.c b/migration/migration.c
> index 7609e0feed..12388c451d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -57,7 +57,6 @@
>  #include "net/announce.h"
>  #include "qemu/queue.h"
>  #include "multifd.h"
> -#include "threadinfo.h"
>  #include "qemu/yank.h"
>  #include "sysemu/cpus.h"
>  #include "yank_functions.h"
> @@ -3466,16 +3465,12 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
>  static void *migration_thread(void *opaque)
>  {
>      MigrationState *s = opaque;
> -    MigrationThread *thread = NULL;
>      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      MigThrError thr_error;
>      bool urgent = false;
>      Error *local_err = NULL;
>      int ret;
>  
> -    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
> -                                   qemu_get_thread_id());
> -
>      rcu_register_thread();
>  
>      object_ref(OBJECT(s));
> @@ -3573,7 +3568,6 @@ out:
>      migration_iteration_finish(s);
>      object_unref(OBJECT(s));
>      rcu_unregister_thread();
> -    migration_threads_remove(thread);
>      return NULL;
>  }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 697fe86fdf..659022e817 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -26,7 +26,6 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> -#include "threadinfo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
>  #include "io/channel-file.h"
> @@ -570,13 +569,10 @@ int multifd_send_sync_main(void)
>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
> -    MigrationThread *thread = NULL;
>      Error *local_err = NULL;
>      int ret = 0;
>      bool use_packets = multifd_use_packets();
>  
> -    thread = migration_threads_add(p->name, qemu_get_thread_id());
> -
>      trace_multifd_send_thread_start(p->id);
>      rcu_register_thread();
>  
> @@ -669,7 +665,6 @@ out:
>      }
>  
>      rcu_unregister_thread();
> -    migration_threads_remove(thread);
>      trace_multifd_send_thread_end(p->id, p->packets_sent);
>  
>      return NULL;
> diff --git a/migration/threadinfo.c b/migration/threadinfo.c
> deleted file mode 100644
> index 262990dd75..0000000000
> --- a/migration/threadinfo.c
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -/*
> - *  Migration Threads info
> - *
> - *  Copyright (c) 2022 HUAWEI TECHNOLOGIES CO., LTD.
> - *
> - *  Authors:
> - *  Jiang Jiacheng <jiangjiacheng@huawei.com>
> - *
> - *  This work is licensed under the terms of the GNU GPL, version 2 or later.
> - *  See the COPYING file in the top-level directory.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/queue.h"
> -#include "qemu/lockable.h"
> -#include "threadinfo.h"
> -
> -QemuMutex migration_threads_lock;
> -static QLIST_HEAD(, MigrationThread) migration_threads;
> -
> -static void __attribute__((constructor)) migration_threads_init(void)
> -{
> -    qemu_mutex_init(&migration_threads_lock);
> -}
> -
> -MigrationThread *migration_threads_add(const char *name, int thread_id)
> -{
> -    MigrationThread *thread =  g_new0(MigrationThread, 1);
> -    thread->name = name;
> -    thread->thread_id = thread_id;
> -
> -    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
> -        QLIST_INSERT_HEAD(&migration_threads, thread, node);
> -    }
> -
> -    return thread;
> -}
> -
> -void migration_threads_remove(MigrationThread *thread)
> -{
> -    QEMU_LOCK_GUARD(&migration_threads_lock);
> -    if (thread) {
> -        QLIST_REMOVE(thread, node);
> -        g_free(thread);
> -    }
> -}
> -
> -MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
> -{
> -    MigrationThreadInfoList *head = NULL;
> -    MigrationThreadInfoList **tail = &head;
> -    MigrationThread *thread = NULL;
> -
> -    QEMU_LOCK_GUARD(&migration_threads_lock);
> -    QLIST_FOREACH(thread, &migration_threads, node) {
> -        MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
> -        info->name = g_strdup(thread->name);
> -        info->thread_id = thread->thread_id;
> -
> -        QAPI_LIST_APPEND(tail, info);
> -    }
> -
> -    return head;
> -}
> diff --git a/migration/meson.build b/migration/meson.build
> index 66d3de86f0..28a680e5e2 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -29,7 +29,6 @@ system_ss.add(files(
>    'savevm.c',
>    'socket.c',
>    'tls.c',
> -  'threadinfo.c',
>  ), gnutls, zlib)
>  
>  if get_option('replication').allowed()
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

