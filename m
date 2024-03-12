Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1268FC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3uJ-0000U0-VC; Tue, 12 Mar 2024 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk3uI-0000Tq-Sx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk3uE-0006V6-RI
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710256743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vESg4F4TK3KV2+TxMR/3lXHAecFEGePJ9e7aWVE5oCY=;
 b=YAfgjSEGoPvvqptFuyQIgAey3beXQhp5yM07mwRrsflZPSpHn15nyAUkCYfjExROD6wyvA
 mSgWvW0v+k1Y6VfsnEuKtLpAhQuh/fthdKYMtSiavEABXs3K1tOqt8taekLK2xWH4VaTKy
 sjW0dZJay+dSg9j0x+ydYkR8dDOjSb8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-7isJpMy_NQaDwqqOcYijZg-1; Tue, 12 Mar 2024 11:19:02 -0400
X-MC-Unique: 7isJpMy_NQaDwqqOcYijZg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690c19ee50bso4203926d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256741; x=1710861541;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vESg4F4TK3KV2+TxMR/3lXHAecFEGePJ9e7aWVE5oCY=;
 b=Hqqaki2E9fo/3bO6E/8hl+DQIrgSPxvv0dVehtAzIWlh2+n8B8XyY7OUaSzNKreqa9
 Z7zCaN9ry4s1L9pfuIkscAjB5SW0t67BMyPaGDrN2nfszSWo973610rsUIlF4EN3AKKY
 K65I+TM1mMc3nHoJ6+JGrXYvRFu3sS9PVzn9Ekp7hGDeDJtwHlG9BWWWeh7AGbczqCgV
 qTY7E6Z0OKzD03I2FfYLUrjAViRBQnzqdtnIFKtr+pQ4KrC0UjFn5EZtwDvEhz/LRfWm
 1iItX4MG5umZvl9yEWGJpbzh+cC0t4EAPJ0Kt3mxDnrNrIBrfxd+anNAZ+DhOkQ3pry0
 Mjhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT8n7hJjYS5f3FGrP5y+mawuRTo+ThGTUecbr+LhHPuAJVJtCh5krdNYyeV0+GqUumdzfPLHCqF0AFUWGitYR/Q8xm0hg=
X-Gm-Message-State: AOJu0Yx72XxoNg8D79aiXkpVGgTC9gBD1GprjKroOi4luEOsqo50YD97
 CosCSCYf8EJrCCU4Y02PzgBSvCPi7CPhKZj59Nv5uVeaw6c724EqwgtO3cgLtwWs/9+aaThUoZ4
 Uw7nxZ/wOVViR6+nX8OgSjqiglkOUQekrbHmbDIHwDV4fiZEZlaJW
X-Received: by 2002:ad4:56e3:0:b0:690:c12f:9750 with SMTP id
 cr3-20020ad456e3000000b00690c12f9750mr8836581qvb.4.1710256741591; 
 Tue, 12 Mar 2024 08:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMNLZjgXWphQxbebhC6bR1Xs8sr7KZgohYSI0Z/4gG7NQuzZRzahzgrkUhnxlOz0u27MIEuQ==
X-Received: by 2002:ad4:56e3:0:b0:690:c12f:9750 with SMTP id
 cr3-20020ad456e3000000b00690c12f9750mr8836548qvb.4.1710256741181; 
 Tue, 12 Mar 2024 08:19:01 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 r6-20020a0cf606000000b0069046d929a3sm3708693qvm.145.2024.03.12.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:19:00 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:18:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfByYiL3Gl9d9u7h@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
 <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jdbmst4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 12, 2024 at 11:24:39AM -0300, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
> > On 3/12/24 14:34, Cédric Le Goater wrote:
> >> On 3/12/24 13:32, Cédric Le Goater wrote:
> >>> On 3/11/24 20:03, Fabiano Rosas wrote:
> >>>> Cédric Le Goater <clg@redhat.com> writes:
> >>>>
> >>>>> On 3/8/24 15:36, Fabiano Rosas wrote:
> >>>>>> Cédric Le Goater <clg@redhat.com> writes:
> >>>>>>
> >>>>>>> This prepares ground for the changes coming next which add an Error**
> >>>>>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
> >>>>>>> now handle the error and fail earlier setting the migration state from
> >>>>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
> >>>>>>>
> >>>>>>> In qemu_savevm_state(), move the cleanup to preserve the error
> >>>>>>> reported by .save_setup() handlers.
> >>>>>>>
> >>>>>>> Since the previous behavior was to ignore errors at this step of
> >>>>>>> migration, this change should be examined closely to check that
> >>>>>>> cleanups are still correctly done.
> >>>>>>>
> >>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>>    Changes in v4:
> >>>>>>>    - Merged cleanup change in qemu_savevm_state()
> >>>>>>>    Changes in v3:
> >>>>>>>    - Set migration state to MIGRATION_STATUS_FAILED
> >>>>>>>    - Fixed error handling to be done under lock in bg_migration_thread()
> >>>>>>>    - Made sure an error is always set in case of failure in
> >>>>>>>      qemu_savevm_state_setup()
> >>>>>>>    migration/savevm.h    |  2 +-
> >>>>>>>    migration/migration.c | 27 ++++++++++++++++++++++++---
> >>>>>>>    migration/savevm.c    | 26 +++++++++++++++-----------
> >>>>>>>    3 files changed, 40 insertions(+), 15 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
> >>>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
> >>>>>>> --- a/migration/savevm.h
> >>>>>>> +++ b/migration/savevm.h
> >>>>>>> @@ -32,7 +32,7 @@
> >>>>>>>    bool qemu_savevm_state_blocked(Error **errp);
> >>>>>>>    void qemu_savevm_non_migratable_list(strList **reasons);
> >>>>>>>    int qemu_savevm_state_prepare(Error **errp);
> >>>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
> >>>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
> >>>>>>>    bool qemu_savevm_state_guest_unplug_pending(void);
> >>>>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s);
> >>>>>>>    void qemu_savevm_state_header(QEMUFile *f);
> >>>>>>> diff --git a/migration/migration.c b/migration/migration.c
> >>>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
> >>>>>>> --- a/migration/migration.c
> >>>>>>> +++ b/migration/migration.c
> >>>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
> >>>>>>>        int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> >>>>>>>        MigThrError thr_error;
> >>>>>>>        bool urgent = false;
> >>>>>>> +    Error *local_err = NULL;
> >>>>>>> +    int ret;
> >>>>>>>        thread = migration_threads_add("live_migration", qemu_get_thread_id());
> >>>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
> >>>>>>>        }
> >>>>>>>        bql_lock();
> >>>>>>> -    qemu_savevm_state_setup(s->to_dst_file);
> >>>>>>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
> >>>>>>>        bql_unlock();
> >>>>>>> +    if (ret) {
> >>>>>>> +        migrate_set_error(s, local_err);
> >>>>>>> +        error_free(local_err);
> >>>>>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> >>>>>>> +                          MIGRATION_STATUS_FAILED);
> >>>>>>> +        goto out;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>>        qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> >>>>>>>                                   MIGRATION_STATUS_ACTIVE);
> >>>>>>
> >>>>>> This^ should be before the new block it seems:
> >>>>>>
> >>>>>> GOOD:
> >>>>>> migrate_set_state new state setup
> >>>>>> migrate_set_state new state wait-unplug
> >>>>>> migrate_fd_cancel
> >>>>>> migrate_set_state new state cancelling
> >>>>>> migrate_fd_cleanup
> >>>>>> migrate_set_state new state cancelled
> >>>>>> migrate_fd_cancel
> >>>>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
> >>>>>>
> >>>>>> BAD:
> >>>>>> migrate_set_state new state setup
> >>>>>> migrate_fd_cancel
> >>>>>> migrate_set_state new state cancelling
> >>>>>> migrate_fd_cleanup
> >>>>>> migrate_set_state new state cancelled
> >>>>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
> >>>>>> **
> >>>>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
> >>>>>> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
> >>>>>>
> >>>>>> Otherwise migration_iteration_finish() will schedule the cleanup BH and
> >>>>>> that will run concurrently with migrate_fd_cancel() issued by the test
> >>>>>> and bad things happens.
> >>>>>
> >>>>> This hack makes things work :
> >>>>>
> >>>>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
> >>>>>            qemu_savevm_send_colo_enable(s->to_dst_file);
> >>>>>        }
> >>>>> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> >>>>> +                            MIGRATION_STATUS_SETUP);
> >>>>> +
> >>>>
> >>>> Why move it all the way up here? Has moving the wait_unplug before the
> >>>> 'if (ret)' block not worked for you?
> >>>
> >>> We could be sleeping while holding the BQL. It looked wrong.
> >> 
> >> Sorry wrong answer. Yes I can try moving it before the 'if (ret)' block.
> >> I can reproduce easily with an x86 guest running on PPC64.
> >
> > That works just the same.
> >
> > Peter, Fabiano,
> >
> > What would you prefer  ?
> >
> > 1. move qemu_savevm_wait_unplug() before qemu_savevm_state_setup(),
> >     means one new patch.
> 
> Is there a point to this except "because we can"? Honest question, I
> might have missed the motivation.

My previous point was, it avoids holding the resources (that will be
allocated in setup() routines) while we know we can wait for a long time.

But then I found that the ordering is indeed needed at least if we don't
change migrate_set_state() first - it is the only place we set the status
to START (which I overlooked, sorry)...

IMHO the function is not well designed; the state update of the next stage
should not reside in a function to wait for failover primary devices
conditionally. It's a bit of a mess.

> 
> Also a couple of points:
> 
> - The current version of this proposal seems it will lose the transition
> from SETUP->ACTIVE no? As in, after qemu_savevm_state_setup, there's
> nothing changing the state to ACTIVE anymore.
> 
> - You also need to change the bg migration path.
> 
> >
> > 2. leave qemu_savevm_wait_unplug() after qemu_savevm_state_setup()
> >     and handle state_setup() errors after waiting. means an update
> >     of this patch.
> 
> I vote for this. This failover feature is a pretty complex one, let's
> not risk changing the behavior for no good reason. Just look at the
> amount of head-banging going on in these threads:
> 
> https://patchwork.ozlabs.org/project/qemu-devel/cover/20181025140631.634922-1-sameeh@daynix.com/
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg609296.html

Do we know who is consuming this feature?

Now VFIO allows a migration to happen without this trick.  I'm wondering
whether all relevant NICs can also support VFIO migrations in the future,
then we can drop this tricky feature for good.

-- 
Peter Xu


