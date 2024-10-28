Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F7FD3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5T5H-00011d-Vl; Mon, 28 Oct 2024 12:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5T5F-00011K-KT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5T58-00038z-Ky
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730134745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgrVnlxOUbzN4GZzt7RZfR6rUAkzMfDoH9YU8rN83Dk=;
 b=cGVmGJoJ+BC3qvi49hBgAZ7jW1MWztF1PWytL5WKqXs+eVd6YWbeIwrj6qNj1aX/4JTIs3
 OvfkxumJW7gDvcyUz7PCsIhB18UNqGI1H+CIPU7UI0yyOCiA5YlzaLFLI8HFkq6BsTngBP
 EUJIkE4C5P7M0SNMwNa3g2uwBrHordM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-dUhlODU-O4eWlHMbiNbxxg-1; Mon, 28 Oct 2024 12:59:01 -0400
X-MC-Unique: dUhlODU-O4eWlHMbiNbxxg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4608d303ebeso81467021cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134741; x=1730739541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgrVnlxOUbzN4GZzt7RZfR6rUAkzMfDoH9YU8rN83Dk=;
 b=laPMJ8Vv2OvFh1pYF3RKWu/0ve1zoJ2BZYxrdnii7Op/lKAoLPrVgeFuLVlX/mF73W
 2dRF/pfsoUqfXW5JYdvJjOdbgtYwxDlTSXE8xyGdtVZArRgdbLoU1g1oHTJekUHwWOap
 lhd5A2zkXzpAi03MNOXLh0V/FjCZIxtVfw4K9QONQaYYxNPhnfuczonqqp9PMHS3lnuy
 ruv5bMZSVuGLJgH8H9YYq12IeSPmE4o5nzpIn1GuXzYK4aXPNB3uPzYcOftGn1wAGsJ0
 wuYSG3y1Y3Nt3rmCAFgtT1LRCjCYu2S6oOBPQ0t0HEvnJGv5KjEta2ap0Wjxc1m9+1Z/
 V/rA==
X-Gm-Message-State: AOJu0YwXNDddP6zRwMDeHrcXqrsl1mRxYOd8KQAmGfDMgxVQnllRU9rP
 LB8ajaldJqPkol2UrF/9gRA+4WagMkovJohXTJbloyoA6SyUufqKpSyNPlUVl5F7A/at5Fhn9qR
 paUMvgLjjLg9F6/tdiAWvzDkb0b9dIa4xHrgd0ykfZ1/FBeo1mJLc
X-Received: by 2002:ac8:5d46:0:b0:45d:5f8c:8280 with SMTP id
 d75a77b69052e-4613c053248mr154907521cf.35.1730134741049; 
 Mon, 28 Oct 2024 09:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhIvhdSWiwZjLbxyW+665Cf/++I5jLAMUwqayUpKQpITQ2dT8cfR5WUJa/MYUxRoGo311DTg==
X-Received: by 2002:ac8:5d46:0:b0:45d:5f8c:8280 with SMTP id
 d75a77b69052e-4613c053248mr154907191cf.35.1730134740556; 
 Mon, 28 Oct 2024 09:59:00 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a6862sm35978491cf.92.2024.10.28.09.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:59:00 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:58:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
Message-ID: <Zx_C0hrRZK34qc7I@x1n>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com>
 <Zx-xpZzYG_1KuCQu@x1n>
 <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:
> 
> On 28/10/2024 17:45, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
> > > On 25/10/2024 0:30, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > We have two outside users of this API, so it's exported.
> > > > 
> > > > Is it really necessary?  Does it matter whether it must be
> > > > ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
> > > Actually for VFIO it does matter, because we don't want VFIO to do DPT
> > > log_sync in SETUP stage when DPT might not have been started yet.
> > > See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
> > > SETUP state").
> > This seems to be a known issue for migration in general, rather than VFIO
> > specific.  Hyman has a patch for it, not yet reviewed..
> > 
> > https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com
> > 
> > That corresponds to your comment here:
> > 
> >      Redundant -- all RAM is marked dirty in migration SETUP state and is
> >      transferred only after migration is set to ACTIVE state, so doing
> >      log_sync during migration SETUP is pointless.
> > 
> > So I wonder whether it's only VFIO that should skip it, or log_sync()
> > simply shouldn't be called at all during SETUP, because of its redundancy.
> 
> Not sure why this sync was there in the first place, but if its only purpose
> was to sync dirty pages then yes, I guess it be dropped.
> 
> > 
> > The other thing you mentioned here:
> > 
> >      Can fail -- there is a time window, between setting migration state to
> >      SETUP and starting dirty tracking by RAM save_live_setup handler, during
> >      which dirty tracking is still not started. Any VFIO log_sync call that
> >      is issued during this time window will fail. For example, this error can
> >      be triggered by migrating a VM when a GUI is active, which constantly
> >      calls log_sync.
> > 
> > This is VFIO specific.  Why this can fail even if global tracking is
> > started already?
> 
> It can fail if global tracking is *not* started yet.
> As mentioned in the commit message, there is a time window where migration
> is in SETUP state but global tracking is not started yet.

Hmm, I'm totally confused now..

The only thing that can kickoff the sync during SETUP, AFAICT, is:

            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
            if (!ret) {
                goto out_unlock;
            }
            migration_bitmap_sync_precopy(false);   <------------- here

I need to confess this may not be the right place to invoke it in ram.c (I
think we probably should move it out at some point.. into generic migration
code).  However I don't yet see why log_start() is not called first in your
case before log_sync().

Could you elaborate?

> 
> Thanks.
> 
> > I didn't yet get why a GUI being active in guest could
> > affect log_sync() from working.. after vfio_listener_log_global_start()
> > properly setup everything.
> > 
> > Thanks,
> > 
> > > Thanks.
> > > 
> > > > The external user is trying to detect whether migration is running or not,
> > > > as simple as that.
> > > > 
> > > > To make the migration_is*() APIs even shorter, let's use
> > > > migration_is_running() for outside worlds.
> > > > 
> > > > Internally there're actually three places that literally needs
> > > > migration_is_active() rather than running().  Keep that an internal helper.
> > > > 
> > > > After this patch, we finally only export one helper that allows external
> > > > world to try detect migration status, which is migration_is_running().
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    include/migration/misc.h | 1 -
> > > >    migration/migration.h    | 1 +
> > > >    hw/vfio/common.c         | 4 ++--
> > > >    system/dirtylimit.c      | 3 +--
> > > >    4 files changed, 4 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > > index ad1e25826a..c0e23fdac9 100644
> > > > --- a/include/migration/misc.h
> > > > +++ b/include/migration/misc.h
> > > > @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
> > > >    void migration_object_init(void);
> > > >    void migration_shutdown(void);
> > > > 
> > > > -bool migration_is_active(void);
> > > >    bool migration_is_running(void);
> > > >    bool migration_thread_is_self(void);
> > > > 
> > > > diff --git a/migration/migration.h b/migration/migration.h
> > > > index 0956e9274b..9fa26ab06a 100644
> > > > --- a/migration/migration.h
> > > > +++ b/migration/migration.h
> > > > @@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> > > > 
> > > >    int migrate_init(MigrationState *s, Error **errp);
> > > >    bool migration_is_blocked(Error **errp);
> > > > +bool migration_is_active(void);
> > > >    /* True if outgoing migration has entered postcopy phase */
> > > >    bool migration_in_postcopy(void);
> > > >    bool migration_postcopy_is_alive(MigrationStatus state);
> > > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > > index cc72282c71..7eb99ebd4d 100644
> > > > --- a/hw/vfio/common.c
> > > > +++ b/hw/vfio/common.c
> > > > @@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
> > > >    {
> > > >        VFIODevice *vbasedev;
> > > > 
> > > > -    if (!migration_is_active()) {
> > > > +    if (!migration_is_running()) {
> > > >            return false;
> > > >        }
> > > > 
> > > > @@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
> > > >    {
> > > >        VFIODevice *vbasedev;
> > > > 
> > > > -    if (!migration_is_active()) {
> > > > +    if (!migration_is_running()) {
> > > >            return false;
> > > >        }
> > > > 
> > > > diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> > > > index ab20da34bb..d7a855c603 100644
> > > > --- a/system/dirtylimit.c
> > > > +++ b/system/dirtylimit.c
> > > > @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
> > > >        int i = 0;
> > > >        int64_t period = DIRTYLIMIT_CALC_TIME_MS;
> > > > 
> > > > -    if (migrate_dirty_limit() &&
> > > > -        migration_is_active()) {
> > > > +    if (migrate_dirty_limit() && migration_is_running()) {
> > > >            period = migrate_vcpu_dirty_limit_period();
> > > >        }
> > > > 
> > > > --
> > > > 2.45.0
> > > > 
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


