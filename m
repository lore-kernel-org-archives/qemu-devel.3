Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDA1F364A9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtJO-0004MQ-Va; Thu, 09 Apr 2026 13:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtJN-0004M8-Og
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtJL-0008F9-FG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775756217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=grrTmrXgWLYKI9Gg8TUfoHkN8SlRAsghf2bMNWvvqFs=;
 b=DshCbCH1FkXKVT5h27NpQ7XcQpEwTo7l7amO6v41AoJ4K+GIqdugbby704emXBRIpguNnW
 5kme3XRBafY+fnFOiH8EZ8kvLsZkpywRskTMUW35vMsdkPLv2fTzAR0mKHU4V5/8C0+NdN
 /oufAHSpMQQMq4iYA+rk/zcAmY3iS18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-blyGG_uKOT24fx2hkcd2yA-1; Thu, 09 Apr 2026 13:36:56 -0400
X-MC-Unique: blyGG_uKOT24fx2hkcd2yA-1
X-Mimecast-MFC-AGG-ID: blyGG_uKOT24fx2hkcd2yA_1775756215
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d103e46c3so732066f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775756215; x=1776361015; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=grrTmrXgWLYKI9Gg8TUfoHkN8SlRAsghf2bMNWvvqFs=;
 b=YeK2VmNmlWYnkk1zkuD/apewccN2hzX6ZwN8PAbV8cZDd+zcyXsmgxmqZJKuQ/XUg9
 vpq/V+TcW1fEB3EZaAy9dxJ27K8nNW74GQxEc3x7Vf5/oH64RUrtcWZPfNSbSVFoY8N0
 L2nfOhhVisSksAmrxfDioRwr6N+pGo/glbulAZG5UXls9VXIchp2vhOyIAhJZKKFnHMg
 3cMmMFA16Leh//GX4hM69rHOVHM0uhYaWo95AikkbC+ad4+7ac2wWl3A6lJ8DvOtaT53
 HTjJxuN25S+4kFkcDdGxMt9ebKygZusqSNFsQ682qQK9tpTsDPto4mhfVE/6g//8Apwn
 CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775756215; x=1776361015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grrTmrXgWLYKI9Gg8TUfoHkN8SlRAsghf2bMNWvvqFs=;
 b=ARXJ3O3qIy6GnED+A4h6LJOSs+3kjWs1KGq+UbxxRsI1CNmM0NwiMlbUGuE95qOyKU
 conMeOH1j0HsVPcLtxODWx4gUhYVOTt4Ky3elshGISuWOipSq7CCW80lhBxoxiZWdbDE
 TJiGu6fqLlxdKhCdVH2kN71HYZGqCLfpKFQPGMjk+5xnrpKcIdQ4v9lyaqOW1AACKjh7
 VNNFuVUXo2bmWAQa61zi/+oAg+8OV+izSru5+bve1JQYoMP/q5nG/t5udddJdf0j2hYM
 Ffp4VXEzrW3OcMyMDeU9AabBx1h2gGpZmtOdaRg8JbmDDlhpy1z8rrdnqhv3ReTV3ORA
 dv0g==
X-Gm-Message-State: AOJu0YxV1caH4489vtfhXecHQpG1D+Olu7HdKMhPLJZrrmNd/Y3BhAYU
 gSi84oYG6t8A74JnN4uMw99N6i9t2/gbyZIBnpX+esyAP04TNnY90OMCoZySiNoYZJPBIb8kipA
 CD4cnNj/2uan76Dywdr7BnccXbcHCJ5DwfD7G3Yip6E2zL6XthMHECYDR
X-Gm-Gg: AeBDiesvsy43Psc9xwQ0lYznT5721A0Nx2fJYfIxi0uAa4QENNpYm3/29T3HOkXrvWe
 WXP0qkMLQ1iFLReAWQaOdz9179ZFGueDs5Qf0T+jtK86dIkZgAQp4nrCwXd3DIYh9HTXYhn5jy7
 CXmJmsJl4hlrWANGlb0asKZNzKXm0x9c/Ybo81h5GnlQSmLpJEf/Uyvk9osw9XAR9tu6HKCi+Vz
 fQa+2JMKHVRaahH84cJJ5utWgldxWdjUcriM+1vd+ZIgryYL/wYzvY/GupSQTsfp11vOKXXt8e7
 tfwqmWMS96KDW/UUGhi7W4M774LtgE1JSrNVd36IcbCHXEsxDTWRba5xVM2ttcW4SFcNzD3Pn0g
 4sm0oMvcAT9EopUDQGFOAihHTl84HKFcYcJkcT0g=
X-Received: by 2002:a05:6000:2503:b0:43b:4136:1e76 with SMTP id
 ffacd0b85a97d-43d292e3e10mr39181499f8f.29.1775756214601; 
 Thu, 09 Apr 2026 10:36:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2503:b0:43b:4136:1e76 with SMTP id
 ffacd0b85a97d-43d292e3e10mr39181455f8f.29.1775756214072; 
 Thu, 09 Apr 2026 10:36:54 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d85fsm318774f8f.36.2026.04.09.10.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:36:53 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:36:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <adfhtgEeWtsMxEmv@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-7-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter,

actually, I do have one question, see inline

On 2026-04-08 12:55, Peter Xu wrote:
> Allow modules to report data that can only be migrated after VM is stopped.
> 
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
> 
> However, when there're data only can be migrated in stopcopy phase, it
> means the old "pending_size" may not always be able to reach low enough to
> kickoff an slow version of query sync.
> 
> It used to be almost guaranteed to happen as all prior iterative modules
> doesn't have stopcopy only data.  VFIO may change that fact by having some
> data that must be copied during stop phase.
> 
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated.  This might be important to VFIO
> to keep making progress even if the downtime cannot yet be satisfied.
> 
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
> 
> This paves way for VFIO to properly report its pending data sizes, which
> will start to include stop-only data.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h |  7 +++++
>  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>  migration/savevm.c           |  7 +++--
>  migration/trace-events       |  2 +-
>  4 files changed, 57 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index aba3c9af2f..e822a2a59f 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -21,6 +21,13 @@ typedef struct MigPendingData {
>      uint64_t precopy_bytes;
>      /* Amount of pending bytes can be transferred in postcopy */
>      uint64_t postcopy_bytes;
> +    /* Amount of pending bytes can be transferred only in stopcopy */
> +    uint64_t stopcopy_bytes;
> +    /*
> +     * Total pending data, modules do not need to update this field, it
> +     * will be automatically calculated by migration core API.
> +     */
> +    uint64_t total_bytes;
>  } MigPendingData;
>  
>  /**
> diff --git a/migration/migration.c b/migration/migration.c
> index 68cfe2d3bf..bb17bd0e68 100644
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
> +    qemu_savevm_query_pending(pending, true);
> +}
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
>      qemu_savevm_query_pending(&pending, false);
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
> -            qemu_savevm_query_pending(&pending, true);
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

shouldn't also the condition that triggers postcopy migration be updated?
As total_bytes is calculated as sum of all three
(precopy_bytes + stopcopy_bytes + postcopy_bytes), this implies to me
that stopcopy_bytes is not subset of precopy_bytes and would also need
to be migrated during switchover before postcopy.

Once this is resolved, then my Reviewed-by tag is valid, the patch looks
good to me otherwise.

Thanks!

>      }
>  
>      if (complete_ready) {
> -        trace_migration_thread_low_pending(pending_size);
> +        trace_migration_thread_low_pending(pending.total_bytes);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 397f602257..b75c311a95 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>  {
>      SaveStateEntry *se;
>  
> -    pending->precopy_bytes = 0;
> -    pending->postcopy_bytes = 0;
> +    memset(pending, 0, sizeof(*pending));
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops || !se->ops->save_query_pending) {
> @@ -1779,7 +1778,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>          se->ops->save_query_pending(se->opaque, pending, exact);
>      }
>  
> +    pending->total_bytes = pending->precopy_bytes +
> +        pending->stopcopy_bytes + pending->postcopy_bytes;
> +
>      trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +                                    pending->stopcopy_bytes,
>                                      pending->postcopy_bytes);
>  }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index f8995b8d0d..2f86ad448e 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> -- 
> 2.53.0
> 


