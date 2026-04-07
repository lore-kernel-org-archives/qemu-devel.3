Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F1FFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTy-0005O5-JF; Tue, 07 Apr 2026 14:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABSY-0003Gt-JP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wA8Ns-0005KZ-1U
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775575830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLe2VtAvZJhM48HDeSenfgbd/zpoYVuqxcP5G+/EY5Q=;
 b=D7Ku06Ib4ul4UX799xBu2RetR3eX+EbA+K/M6THR3EkjCEqWfdoVvWglObuowsB8arvHcU
 Ghc+FEIbwCPTzgzAoHvlwrM2xPwXs8u36kNlh3crZ/uTsE1e8HLjsCLpp/uFqTmAkSOe/3
 1G5LRpEXKNtgJg3Jh6spV8LekZZ6oHo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Mdo1pzrRPtC_-h3S6VTMaA-1; Tue, 07 Apr 2026 11:30:29 -0400
X-MC-Unique: Mdo1pzrRPtC_-h3S6VTMaA-1
X-Mimecast-MFC-AGG-ID: Mdo1pzrRPtC_-h3S6VTMaA_1775575829
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso81563561cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775575829; x=1776180629; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLe2VtAvZJhM48HDeSenfgbd/zpoYVuqxcP5G+/EY5Q=;
 b=Tb5/Fu5qEp404J32AZiI9h6Fg86eE26c3NkaXOCSHP+mjUKHSGNKIw7ZCh6XLQzsQQ
 WBHsOH+FJcPVIYpk2uYmWzdRoj0MBrwKT+uem8OBKvSAsLZDPFkVCMcEhjvj2ixWhzMl
 fA/8zv7tMoBLxvkbEjAcOcsKwoji63g5Kd1IaMMNqwiW/+gfJZwH5KVQijL3KzlkcRY2
 yW4ECGTbeB7staCicXlqN8atRhuHiaUAAx9vdVFGmI5gXY5Mosph2BIM2PPpbQuc8F+6
 lJboChMz5xS5l3K907YNTj4DXlW4ugqljYtgRYTCpW7HPp/RL8Hun14vKfThEXykgBFU
 sNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575829; x=1776180629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLe2VtAvZJhM48HDeSenfgbd/zpoYVuqxcP5G+/EY5Q=;
 b=FZKQFVNO1PIFRgo0pDkGiK1WCdGCv5XRSeJce5Na9dQ4XUV7KjQ8qDaVfiZj7dPIuW
 kiyjtak37SJJrtMAbQrtQymPCzh00YL6isBzfZA31G3TXfU/kH6Qxe6K48bgtq1oDahm
 Ssw6FKuoLQOEJBLYn/yLef87u7CeHVrwKTwyslUx4wOwxVB8PzkTmQIIDip1I1ci1JfY
 AtIp0A4jNg/O/OsanfgKdKNOI9Z1sYBy+DZTIGxR+e59RQ+0pXNXzGDYgz1QGBqbKAsk
 p8HA5F1XbQ0EQFbmsKeoM8gjbG4HMJUnQV4GrIlHGmcqriRs43P0xa0PDnz6IhP+KkZ3
 9Lag==
X-Gm-Message-State: AOJu0Yx/xB/PAyZc2Yr2OfUi9xJ7c9NkypZO/LIDKh7YGZcDQuwyw1a3
 yXRrmX+/8b3NfVWmxKcPQkh0Nt0P8ZijdZsUpV615bb8Q4plGttc+06rdF67ongretKH0hT/bIA
 RNbWcYu8Apj5PzzpkU1KdRtmw5fyWs2Hw5veJEnMy/+xOXmcbvgo2KfgW
X-Gm-Gg: AeBDiev8ZimLBVKgg5hbMG7tOHRPvTbbvBdMt1TMuISlcYZ0Naj4H56k+aUfo17iTZk
 5PxaZH3CvJnxnwhDXpzMEOiFqMtF38r4OeyP5c1wA4wTCC+x+3Aqz6b/51jbU/QilYn1VR32f2W
 1Sgi4Q9CmS4w3fcyWcOciLaATuLDjeLyLPXXiSOe+V9zNEJdJ4kj7HbUvTkAqCU/hLKEpnpZgqW
 xOdQYVp/M3q8HCNnw9MKjYYHr/XLDFHua5wGH+SxdLjm0HPwyfzf6dze4KoErK125/YvUAehAFa
 FEud6+j1mhcC9NKlTgY/racgh4QXHZPQesd9k+9gRemJK37Zt5MmVGS0QH+g4Z5mQqkKnfSw6E/
 ysI3gEJXqYjFu+2BxPmLxHlogcJM4KmphMomP73dXcA7gUKU=
X-Received: by 2002:a05:622a:4414:b0:50b:4337:179a with SMTP id
 d75a77b69052e-50d6262de78mr192610621cf.3.1775575828335; 
 Tue, 07 Apr 2026 08:30:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4414:b0:50b:4337:179a with SMTP id
 d75a77b69052e-50d6262de78mr192608591cf.3.1775575827160; 
 Tue, 07 Apr 2026 08:30:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d8e11b927sm71890711cf.23.2026.04.07.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:30:26 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:30:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <adUjEMYBalt644wn@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <82b40877-482e-4dbe-add1-6e0cc4292ae7@nvidia.com>
 <ac54tN39eq0Rv6T4@x1.local>
 <f8482f15-73e3-415e-b905-1ab5d77e653e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8482f15-73e3-415e-b905-1ab5d77e653e@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On Mon, Apr 06, 2026 at 03:20:21PM +0300, Avihai Horon wrote:
> 
> On 4/2/2026 5:09 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Mar 25, 2026 at 06:54:58PM +0200, Avihai Horon wrote:
> > > On 3/20/2026 1:12 AM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > Allow modules to report data that can only be migrated after VM is stopped.
> > > > 
> > > > When this concept is introduced, we will need to account stopcopy size to
> > > > be part of pending_size as before.
> > > > 
> > > > One thing to mention is, when there can be stopcopy size, it means the old
> > > > "pending_size" may not always be able to reach low enough to kickoff an
> > > > slow version of query sync.  While it used to be almost guaranteed to
> > > > happen because if we keep iterating, normally pending_size can go to zero
> > > > for precopy-only because we assume everything reported can be migrated in
> > > > precopy phase.
> > > > 
> > > > So we need to make sure QEMU will kickoff a synchronized version of query
> > > > pending when all precopy data is migrated too.  This might be important to
> > > > VFIO to keep making progress even if the downtime cannot yet be satisfied.
> > > > 
> > > > So far, this patch should introduce no functional change, as no module yet
> > > > report stopcopy size.
> > > > 
> > > > This will pave way for VFIO to properly report its pending data sizes,
> > > > which was actually buggy today.  Will be done in follow up patches.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    include/migration/register.h | 12 +++++++++
> > > >    migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
> > > >    migration/savevm.c           |  7 +++--
> > > >    migration/trace-events       |  2 +-
> > > >    4 files changed, 62 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > index 2320c3a981..3824958ba5 100644
> > > > --- a/include/migration/register.h
> > > > +++ b/include/migration/register.h
> > > > @@ -17,12 +17,24 @@
> > > >    #include "hw/core/vmstate-if.h"
> > > > 
> > > >    typedef struct MigPendingData {
> > > > +    /*
> > > > +     * Modules can only update these fields in a query request via its
> > > > +     * save_query_pending() API.
> > > > +     */
> > > Move comment to patch #5?
> > > 
> > > >        /* How many bytes are pending for precopy / stopcopy? */
> > > >        uint64_t precopy_bytes;
> > > >        /* How many bytes are pending that can be transferred in postcopy? */
> > > >        uint64_t postcopy_bytes;
> > > > +    /* How many bytes that can only be transferred when VM stopped? */
> > > > +    uint64_t stopcopy_bytes;
> > > Keep consistent phrasing?
> > > 
> > > /* Amount of pending bytes that can be transferred either in precopy or
> > > stopcopy */
> > > uint64_t precopy_bytes;
> > > /* Amount of pending bytes that can be transferred in postcopy */
> > > uint64_t postcopy_bytes;
> > > /* Amount of pending bytes that can be transferred only in stopcopy */
> > > uint64_t stopcopy_bytes;
> > > 
> > > > +
> > > > +    /*
> > > > +     * Modules should never update these fields.
> > > > +     */
> > > Move comment to patch #5?
> > Sure, I'll address all above.
> > 
> > > >        /* Is this a fastpath query (which can be inaccurate)? */
> > > >        bool fastpath;
> > > > +    /* Total pending data */
> > > > +    uint64_t total_bytes;
> > > >    } MigPendingData ;
> > > > 
> > > >    /**
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index 99c4d09000..42facb16d1 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -3198,6 +3198,44 @@ typedef enum {
> > > >        MIG_ITERATE_BREAK,          /* Break the loop */
> > > >    } MigIterateState;
> > > > 
> > > > +/* Are we ready to move to the next iteration phase? */
> > > > +static bool migration_iteration_next_ready(MigrationState *s,
> > > > +                                           MigPendingData *pending)
> > > > +{
> > > > +    /*
> > > > +     * If the estimated values already suggest us to switchover, mark this
> > > > +     * iteration finished, time to do a slow sync.
> > > > +     */
> > > > +    if (pending->total_bytes <= s->threshold_size) {
> > > > +        return true;
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * Since we may have modules reporting stop-only data, we also want to
> > > > +     * re-query with slow mode if all precopy data is moved over.  This
> > > > +     * will also mark the current iteration done.
> > > > +     *
> > > > +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> > > > +     * size too large so it will never yet satisfy the downtime with the
> > > > +     * current setup (above check).  Here, slow version of re-query helps
> > > > +     * because we keep trying the best to move whatever we have.
> > > > +     */
> > > > +    if (pending->precopy_bytes == 0) {
> > > > +        return true;
> > > > +    }
> > > > +
> > > > +    return false;
> > > > +}
> > > > +
> > > > +static void migration_iteration_go_next(MigPendingData *pending)
> > > > +{
> > > > +    /*
> > > > +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> > > > +     * into the core layer.
> > > > +     */
> > > > +    qemu_savevm_query_pending(pending, false);
> > > > +}
> > > I think the iteration terminology here could be confusing, because these two
> > > functions are called from migration_iteration_run() and they don't refer to
> > > the same iteration concept.
> > > How about migration_pass_next_ready/migration_pass_go_next?
> > > Or migration_dirty_sync_ready/migration_dirty_sync?
> > I get the confusion, but IIUC the word "iteration" normally was used to
> > describe one full walk of system resources, introducing "pass" may causing
> > another way of confusion to me.
> > 
> > E.g. see Dan's post in 2016 and since then iteration was defined as so:
> > 
> > https://www.berrange.com/posts/2016/05/12/analysis-of-techniques-for-ensuring-migration-completion-with-kvm/
> > 
> > Here, migration_iteration_run() was named to say "run the current
> > iteration", but it doesn't necessarily mean it can only be run once for the
> > current iteration.
> 
> Ah, thanks, reading the code with that in mind makes it much clearer.
> 
> However, I think iteration meaning is still not consistent, as
> update_iteration_initial_status() and MigrationState->iteration_{start_time,
> initial_bytes, initial_pages} refer to iteration as the 100ms period for
> rate measurement. Or am I missing something here?

You're right, that was indeed confusing and maybe some rename on the
variables can help the code provide consistent definition of iterations.

It'll still be tricky though as the word "iterate" should still be fine
when used to walk over the resources, which may not be once per iteration.

> 
> Also the MIG_ITERATE_{SKIP,BREAK,RESUME} return value of
> migration_iteration_run() (and their docs) may be confusing, as it makes
> "iteration" more related to the while loop.
> I just skimmed briefly, but can we make migration_iteration_run() return a
> bool? (I don't think SKIP value is really needed?)
> BTW, while at it I noticed that the migration_iteration_run() doc is stale
> [1].
> 
> [1] https://elixir.bootlin.com/qemu/v11.0.0-rc2/source/migration/migration.c#L3202

True.

> 
> > 
> > OTOH, I don't think it makes much sense we define "iteration" (or any new
> > term at all) to be one run of migration_iteration_run(): currently, we
> > invoke handlers' savevm iterator hook for each migration_iteration_run(),
> > but that's pretty random behavior..
> > 
> > For RAM, that's MAX_WAIT.  For VFIO, it's something else...
> > 
> > It was still a "grey area" and no way to define, even if we may want to
> > define it at some point to make each iterator to follow some rule.
> > 
> > Comparing to that, iteration to be defined to describe one round of walk
> > for all VM resources makes a lot of sense and it's a criticla concept for
> > precopy.
> > 
> Yes, I agree. I guess some refactoring of the migration_iteration_run() area
> could make it clearer (but not necessary as part of this series). Thanks.

I'll add a todo to cleanup these part after this series.

Thanks,

-- 
Peter Xu


