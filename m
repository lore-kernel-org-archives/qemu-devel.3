Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5725310F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AHf-0006Dt-1V; Fri, 27 Mar 2026 12:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6AHc-0006Dd-7J
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6AHW-0002r3-Ri
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774629813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvwvJwlGVrr4AUHlWD+7rPKZ4NS3YJ2yEXDABqJ9wBk=;
 b=HqxMZPLkAoo6UYxM5fzSSTqKNS2arY77+pmP+RU/D+j+R6i3EMKeDhSbTqlAx/0ceDaJYj
 tlPXQV11K5xdgPhxNu6095fDt8dB4JwYhLZBageau/qHjYREGYdS+0wzoZzVAsBa6c4qzK
 Faw8lrtyea6K/p1TZ81Yh1o2JIjpZrg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-na8N5H7FN9205X6TRusXIQ-1; Fri, 27 Mar 2026 12:43:30 -0400
X-MC-Unique: na8N5H7FN9205X6TRusXIQ-1
X-Mimecast-MFC-AGG-ID: na8N5H7FN9205X6TRusXIQ_1774629809
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fe3b9441so17618265e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774629809; x=1775234609; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yvwvJwlGVrr4AUHlWD+7rPKZ4NS3YJ2yEXDABqJ9wBk=;
 b=U6nQYsoRDzx2RC9iJcXlRYFxE14H6KPWgHtq8+Ck3XkFc6scwf09rRcU982hW9NoWZ
 QqgJwZakGqu+JK2VmzKvR21SpVcLnRxOIRhMi+1FOdpRMqX5mO3yHMIhoJnOn7sj2Cv5
 zHFVjcF8cGdsfs+TcxNrEuSGt3sY2ydDjk3s0GGjCekqxX7LYDBbiheTjc7QPzRA+Tw7
 ExVxB6iRW7Lo1udy9CvwIC31eSdI+uFFohtAUsRhoNy1k+Sc8LH336VJJUbDKsDwDyJ/
 CKJ4VYjOBf2VhsIf8Fbhf38aMUF+piMtWFGawtjBq7BIy5bOCwzbfqK/weUWVoXvYZs6
 NSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629809; x=1775234609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvwvJwlGVrr4AUHlWD+7rPKZ4NS3YJ2yEXDABqJ9wBk=;
 b=HNOnTUDAo7Nl2GcEt7sxCF4p3dH/GsZ7GauoLf+TyE9obgtzlc4/NRys+IfceKSJ9a
 ianyyocxA/0G/6DruhAYBBowydxM2yCc15CshNnJZtFtGePUrTnlLsF6djxOR+upz9Kb
 j98OLLYK3o4FALfJ5bKyTE8Y/sIgQDanObxwUO+FEJkZgpiJbTW2l1HH2+EOpwdk8RUD
 HJ395YA8UIb+C7r00WHmyVVUFwZqqf3vmAL7xRZhSL9c29eWoALhfEWRTMZNYOeoyDJ5
 N52soN8EsRLZ2zM8qGycWETZ2HkoN4Jn09QVMsBHb9CP3I1VcJzLjWoNKm5V5P7lfQf+
 uVwg==
X-Gm-Message-State: AOJu0YysJ6H6fl3IUmOTcARvYlO2mhFIN1t0DjMux7i1QnMlMti52I9P
 zhY0k+Xljf9H+hdj0ao+bcPzatRE6YIENh3jWAkJo7w0ke89wBXUGjTiQcLl134ni+rDXw3fbHl
 EmyJ6PFsp9PQ7yajnKLvVvvBSrkoZTsPUTdI+y4yg6jDt4qhCm4tsBUPe
X-Gm-Gg: ATEYQzxNp0FWftDtaVBdUI/6+YtNkI+PQRds5CjbPzJ+FzqmN9/at/0B8gVFxC1ts7d
 6oAjveguEJkEV2D/mYaAOVajwB7ccG5QpVpbQpbxckuTmD/tTlfhjrnfCENRUd9knqqkSOiG2FN
 Px9iOlsLnEzP/4M5a70TdvHzBUHhXPTAAw/m4C51GUBsFMbDrF+rWCZC47SHhIGMLL74qMpsGCe
 94PTNGP0qYXrR2qkX9LQWgZQ3m0QZh3SXAcL+QBiDdMjTrUkaIvfRsHioUjac4wd5GbhabSCwy1
 RB3beeL+s5zCtBbXTWZyQ7LIue5e1lVJcm1Qa5K4WdutP1LzWnP9mKm4x0/tiTSs9+SwzStCuir
 Sgg==
X-Received: by 2002:a05:600c:3592:b0:485:3949:e5c6 with SMTP id
 5b1f17b1804b1-48727d5943dmr58783685e9.3.1774629808631; 
 Fri, 27 Mar 2026 09:43:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3592:b0:485:3949:e5c6 with SMTP id
 5b1f17b1804b1-48727d5943dmr58783095e9.3.1774629808041; 
 Fri, 27 Mar 2026 09:43:28 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9f58fsm167382685e9.11.2026.03.27.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:43:26 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:43:24 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <acavsDOsAz0hmfvi@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-8-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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

On 2026-03-19 19:12, Peter Xu wrote:
> Allow modules to report data that can only be migrated after VM is stopped.
> 
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
> 
> One thing to mention is, when there can be stopcopy size, it means the old
> "pending_size" may not always be able to reach low enough to kickoff an
> slow version of query sync.  While it used to be almost guaranteed to
> happen because if we keep iterating, normally pending_size can go to zero
> for precopy-only because we assume everything reported can be migrated in
> precopy phase.
> 
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated too.  This might be important to
> VFIO to keep making progress even if the downtime cannot yet be satisfied.
> 
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
> 
> This will pave way for VFIO to properly report its pending data sizes,
> which was actually buggy today.  Will be done in follow up patches.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h | 12 +++++++++
>  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>  migration/savevm.c           |  7 +++--
>  migration/trace-events       |  2 +-
>  4 files changed, 62 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 2320c3a981..3824958ba5 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -17,12 +17,24 @@
>  #include "hw/core/vmstate-if.h"
>  
>  typedef struct MigPendingData {
> +    /*
> +     * Modules can only update these fields in a query request via its
> +     * save_query_pending() API.
> +     */
>      /* How many bytes are pending for precopy / stopcopy? */
>      uint64_t precopy_bytes;

The comment suggests precopy_bytes should include iterable precopy and
also non-iterable precopy (stopcopy) bytes, however, all 3 are then
summed up for total_bytes.

>      /* How many bytes are pending that can be transferred in postcopy? */
>      uint64_t postcopy_bytes;
> +    /* How many bytes that can only be transferred when VM stopped? */
> +    uint64_t stopcopy_bytes;

I was also wondering if having precopy_iterable_bytes,
precopy_non_iterable_bytes, and postcopy_bytes would be clearer, but
given that stopcopy is already a term for this in VFIO it is probably
fine.

> +
> +    /*
> +     * Modules should never update these fields.
> +     */

Maybe splitting input and output parameters, or things which modules
should touch and output of the overall API into different
structures/simple parameters could be better instead of the comment.

>      /* Is this a fastpath query (which can be inaccurate)? */
>      bool fastpath;
> +    /* Total pending data */
> +    uint64_t total_bytes;
>  } MigPendingData ;
>  
>  /**
> diff --git a/migration/migration.c b/migration/migration.c
> index 99c4d09000..42facb16d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3198,6 +3198,44 @@ typedef enum {
>      MIG_ITERATE_BREAK,          /* Break the loop */
>  } MigIterateState;
>  
> +/* Are we ready to move to the next iteration phase? */
> +static bool migration_iteration_next_ready(MigrationState *s,
> +                                           MigPendingData *pending)
> +{
> +    /*
> +     * If the estimated values already suggest us to switchover, mark this
> +     * iteration finished, time to do a slow sync.
> +     */
> +    if (pending->total_bytes <= s->threshold_size) {
> +        return true;
> +    }
> +
> +    /*
> +     * Since we may have modules reporting stop-only data, we also want to
> +     * re-query with slow mode if all precopy data is moved over.  This
> +     * will also mark the current iteration done.
> +     *
> +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> +     * size too large so it will never yet satisfy the downtime with the
> +     * current setup (above check).  Here, slow version of re-query helps
> +     * because we keep trying the best to move whatever we have.
> +     */
> +    if (pending->precopy_bytes == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void migration_iteration_go_next(MigPendingData *pending)
> +{
> +    /*
> +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> +     * into the core layer.
> +     */
> +    qemu_savevm_query_pending(pending, false);
> +}

I agree with Avihai regarding the iteration terminology. I slightly
prefer migration_dirty_sync_ready/migration_dirty_sync, but using pass
instead of iteration is also fine.

> +
>  /*
>   * Return true if continue to the next iteration directly, false
>   * otherwise.
> @@ -3209,12 +3247,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>                          s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>      bool can_switchover = migration_can_switchover(s);
>      MigPendingData pending = { };
> -    uint64_t pending_size;
>      bool complete_ready;
>  
>      /* Fast path - get the estimated amount of pending data */
>      qemu_savevm_query_pending(&pending, true);
> -    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>  
>      if (in_postcopy) {
>          /*
> @@ -3222,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy completion doesn't rely on can_switchover, because when
>           * POSTCOPY_ACTIVE it means switchover already happened.
>           */
> -        complete_ready = !pending_size;
> +        complete_ready = !pending.total_bytes;
>          if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
>              (s->postcopy_package_loaded || complete_ready)) {
>              /*
> @@ -3242,9 +3278,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy started, so ESTIMATE should always match with EXACT
>           * during postcopy phase.
>           */
> -        if (pending_size <= s->threshold_size) {
> -            qemu_savevm_query_pending(&pending, false);
> -            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
> +        if (migration_iteration_next_ready(s, &pending)) {
> +            migration_iteration_go_next(&pending);
>          }
>  
>          /* Should we switch to postcopy now? */
> @@ -3264,11 +3299,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * (2) Pending size is no more than the threshold specified
>           *     (which was calculated from expected downtime)
>           */
> -        complete_ready = can_switchover && (pending_size <= s->threshold_size);
> +        complete_ready = can_switchover &&
> +            (pending.total_bytes <= s->threshold_size);
>      }
>  
>      if (complete_ready) {
> -        trace_migration_thread_low_pending(pending_size);
> +        trace_migration_thread_low_pending(pending.total_bytes);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b3285d480f..812c72b3e5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>  {
>      SaveStateEntry *se;
>  
> -    pending->precopy_bytes = 0;
> -    pending->postcopy_bytes = 0;
> +    memset(pending, 0, sizeof(*pending));
>      pending->fastpath = fastpath;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> @@ -1780,7 +1779,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>          se->ops->save_query_pending(se->opaque, pending);
>      }
>  
> +    pending->total_bytes = pending->precopy_bytes +
> +        pending->stopcopy_bytes + pending->postcopy_bytes;
> +
>      trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
> +                                    pending->stopcopy_bytes,
>                                      pending->postcopy_bytes);
>  }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 5f836a8652..175f09f8ad 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> -- 
> 2.50.1
> 


