Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E434D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RwI-0004BW-AR; Mon, 28 Oct 2024 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5RwG-0004BE-E2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5RwE-0003m1-OD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730130346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xacej/js35huDd4tn5WnbGNbsZoXIThHebBJrs0EJjQ=;
 b=B2xQGe35AdRjMLkgx1ezgRbmyP6SqLOfL43/U3XJxsgx85/gjkXVVD7cIZw+yMuqZETm5a
 np/lzCV5abnPM4QRnRcGUOmTjwk7YSvIWp69WAO4WuEBkSoshKSIrCNoVYkhIryA/3fRk2
 bt39eaMK4ZabhfQSGpNjFZ1hl16xemc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-KWo5A5yoOK-IYA0mWJOhDA-1; Mon, 28 Oct 2024 11:45:44 -0400
X-MC-Unique: KWo5A5yoOK-IYA0mWJOhDA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbead8eb2bso77788546d6.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730130344; x=1730735144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xacej/js35huDd4tn5WnbGNbsZoXIThHebBJrs0EJjQ=;
 b=WFv0gYOCc7h3DsmgY0n/c5yAq4wapadKJ9QpPkB+zeujUqD5/av3L3VN2Xj9dUyNqu
 J5Kk/MKkldU4GhbV67jTR1flMWW6oY5CGqKgh1zrpO70hfUjiZhmgiXY1Ge5bUQiePUi
 97DIzZTnedJQ8LHDOjl7cnfjcTg6aKpatTCuf9AOZrZXnzW18YPSphjSV2X3ah9vZjH2
 vjVWJaqXYXSTOhjGC8pwsWAU2YXmDrLGBdluFmFkaaj5YVORz6wGgCvPYWL6+npv9Sqz
 OKOoAqDom3NlOpDW+G/y0ie9/H3gpVrKhRIQXXRxF27SXsxuGCk698bu6Uweyw00qEov
 0jNA==
X-Gm-Message-State: AOJu0YxL5Tyjrv98mnmfnruVG0ezt2ZEWzDE8EiFj09uIp8O6ML5ZOCJ
 qfoxMznRH0oqb3KfTXNNDffYklUtlxbRKh/Q9aZXJHnFZ9W+7Nji6WsnBTL7jc1/uOsfw/Yc4ND
 uKGwg582JHagRsnTadYnBduzWS/7UBDl+3js4bA8Tyv7mt3gTaxdN
X-Received: by 2002:a05:6214:5a03:b0:6cb:ee73:6932 with SMTP id
 6a1803df08f44-6d18570cf00mr127755566d6.28.1730130344133; 
 Mon, 28 Oct 2024 08:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl8Afpy4nrNe0t/nq++bBRSMW145ioSXVrFxQOCJCFcc+3hBaG17eIH8K54qATLsrX8W7n1A==
X-Received: by 2002:a05:6214:5a03:b0:6cb:ee73:6932 with SMTP id
 6a1803df08f44-6d18570cf00mr127755366d6.28.1730130343727; 
 Mon, 28 Oct 2024 08:45:43 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f73esm33561286d6.16.2024.10.28.08.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:45:43 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:45:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
Message-ID: <Zx-xpZzYG_1KuCQu@x1n>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
> 
> On 25/10/2024 0:30, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > We have two outside users of this API, so it's exported.
> > 
> > Is it really necessary?  Does it matter whether it must be
> > ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
> 
> Actually for VFIO it does matter, because we don't want VFIO to do DPT
> log_sync in SETUP stage when DPT might not have been started yet.
> See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
> SETUP state").

This seems to be a known issue for migration in general, rather than VFIO
specific.  Hyman has a patch for it, not yet reviewed..

https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com

That corresponds to your comment here:

    Redundant -- all RAM is marked dirty in migration SETUP state and is
    transferred only after migration is set to ACTIVE state, so doing
    log_sync during migration SETUP is pointless.

So I wonder whether it's only VFIO that should skip it, or log_sync()
simply shouldn't be called at all during SETUP, because of its redundancy.

The other thing you mentioned here:

    Can fail -- there is a time window, between setting migration state to
    SETUP and starting dirty tracking by RAM save_live_setup handler, during
    which dirty tracking is still not started. Any VFIO log_sync call that
    is issued during this time window will fail. For example, this error can
    be triggered by migrating a VM when a GUI is active, which constantly
    calls log_sync.

This is VFIO specific.  Why this can fail even if global tracking is
started already?  I didn't yet get why a GUI being active in guest could
affect log_sync() from working.. after vfio_listener_log_global_start()
properly setup everything.

Thanks,

> 
> Thanks.
> 
> > 
> > The external user is trying to detect whether migration is running or not,
> > as simple as that.
> > 
> > To make the migration_is*() APIs even shorter, let's use
> > migration_is_running() for outside worlds.
> > 
> > Internally there're actually three places that literally needs
> > migration_is_active() rather than running().  Keep that an internal helper.
> > 
> > After this patch, we finally only export one helper that allows external
> > world to try detect migration status, which is migration_is_running().
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/migration/misc.h | 1 -
> >   migration/migration.h    | 1 +
> >   hw/vfio/common.c         | 4 ++--
> >   system/dirtylimit.c      | 3 +--
> >   4 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index ad1e25826a..c0e23fdac9 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
> >   void migration_object_init(void);
> >   void migration_shutdown(void);
> > 
> > -bool migration_is_active(void);
> >   bool migration_is_running(void);
> >   bool migration_thread_is_self(void);
> > 
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 0956e9274b..9fa26ab06a 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> > 
> >   int migrate_init(MigrationState *s, Error **errp);
> >   bool migration_is_blocked(Error **errp);
> > +bool migration_is_active(void);
> >   /* True if outgoing migration has entered postcopy phase */
> >   bool migration_in_postcopy(void);
> >   bool migration_postcopy_is_alive(MigrationStatus state);
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index cc72282c71..7eb99ebd4d 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
> >   {
> >       VFIODevice *vbasedev;
> > 
> > -    if (!migration_is_active()) {
> > +    if (!migration_is_running()) {
> >           return false;
> >       }
> > 
> > @@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
> >   {
> >       VFIODevice *vbasedev;
> > 
> > -    if (!migration_is_active()) {
> > +    if (!migration_is_running()) {
> >           return false;
> >       }
> > 
> > diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> > index ab20da34bb..d7a855c603 100644
> > --- a/system/dirtylimit.c
> > +++ b/system/dirtylimit.c
> > @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
> >       int i = 0;
> >       int64_t period = DIRTYLIMIT_CALC_TIME_MS;
> > 
> > -    if (migrate_dirty_limit() &&
> > -        migration_is_active()) {
> > +    if (migrate_dirty_limit() && migration_is_running()) {
> >           period = migrate_vcpu_dirty_limit_period();
> >       }
> > 
> > --
> > 2.45.0
> > 
> 

-- 
Peter Xu


