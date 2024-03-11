Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB784C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlzI-0000hL-RJ; Mon, 11 Mar 2024 16:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjlz7-0000gW-TB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjlz5-0002T7-Oc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710187853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOoWd1hsVBLo+HYRH8sKb+sYkG/TUsUw9dT5FmXwnBU=;
 b=FEw4DO5Zx2xLrhc/qzPrqfGxnEG/s1xLxuSevQ6naOWbcK+jIEzJsU4QEa3WHO4Am6cDod
 /McF38CTh7k5PugqTI0Ms3jsbQFpRMMYm6seYd4TRVDsKodcQh+iafdMsIKtRVMBdnMMH7
 lNhMAJckCSE0kuHGS8WYvvgSjUTXWlY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--WV8RwGfPmimHrhhVy3hwQ-1; Mon, 11 Mar 2024 16:10:52 -0400
X-MC-Unique: -WV8RwGfPmimHrhhVy3hwQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-690becce69eso10663996d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187852; x=1710792652;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rOoWd1hsVBLo+HYRH8sKb+sYkG/TUsUw9dT5FmXwnBU=;
 b=oXtOAor16K8sFPBukQ8waT2AwK7H6iqPDX64xVb4ufmEvxs3aead4JUD0EG5ecNXrd
 pRZxu3pa2lVaU8JPHxS1E6uxfBeYPduNm+sHzg0ofmmx6hgTgEYX2hmnRBQaprM2tQuY
 HxonxAhpZsR1DS3CAgw977ZjdLHdxkhSNs8WDPaE+swQEdGUh6+3DB4YpFt+VkXa9gce
 OKlxU28oiKP9UVHZBrS+gknzVGvS70ESlGJR96k3Ye2ZwuyGwdIMgclGBWknXv9tNSGa
 R2gJwcBAkY02FkAjnSPug8ChBb1WSr3n1fVdzXrrG0HVZTOnoet85lD/UqoNnagtDZVw
 GQ4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV48ZaFGStIK/Q8LyHSHwei6MbYjSUa58rwe44pLcwpllfhzoCjf9OF4BrthF7B+bNbR4paUqY8a7IroquMscxQ/79l9gk=
X-Gm-Message-State: AOJu0Yz8CERbKxfDd++QqKMU6CVwL+1ei3n27fiTNt8wkLk+pQSvV3Dt
 NoLRXHdI1odIM6Wd5Tw8DLkJqiCgUXxfbmBard+kzQmID/z4D55wm8hoswHwNKlEEkxN5X449eN
 si6cz2EgXfmYwz8ZX+bxy2OXkCWry8KtCe7wcpB/hnNmnnZPJ4DRi
X-Received: by 2002:a05:6214:973:b0:690:c35c:7590 with SMTP id
 do19-20020a056214097300b00690c35c7590mr6172078qvb.2.1710187851742; 
 Mon, 11 Mar 2024 13:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiX+ZqRpua98heN2gF7CMDglsCk+WfQpQWzMbJ/PtGvhnM5DVN76zQJgfLKFQMM1EzY5AJMA==
X-Received: by 2002:a05:6214:973:b0:690:c35c:7590 with SMTP id
 do19-20020a056214097300b00690c35c7590mr6172056qvb.2.1710187851325; 
 Mon, 11 Mar 2024 13:10:51 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n13-20020a0cfbcd000000b00690bb839b5bsm2948710qvp.135.2024.03.11.13.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:10:50 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:10:48 -0400
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
Message-ID: <Ze9lSAS2COx7s17l@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
 <87le6omw0d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le6omw0d.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Mar 11, 2024 at 04:03:14PM -0300, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
> > On 3/8/24 15:36, Fabiano Rosas wrote:
> >> Cédric Le Goater <clg@redhat.com> writes:
> >> 
> >>> This prepares ground for the changes coming next which add an Error**
> >>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
> >>> now handle the error and fail earlier setting the migration state from
> >>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
> >>>
> >>> In qemu_savevm_state(), move the cleanup to preserve the error
> >>> reported by .save_setup() handlers.
> >>>
> >>> Since the previous behavior was to ignore errors at this step of
> >>> migration, this change should be examined closely to check that
> >>> cleanups are still correctly done.
> >>>
> >>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> >>> ---
> >>>
> >>>   Changes in v4:
> >>>   
> >>>   - Merged cleanup change in qemu_savevm_state()
> >>>     
> >>>   Changes in v3:
> >>>   
> >>>   - Set migration state to MIGRATION_STATUS_FAILED
> >>>   - Fixed error handling to be done under lock in bg_migration_thread()
> >>>   - Made sure an error is always set in case of failure in
> >>>     qemu_savevm_state_setup()
> >>>     
> >>>   migration/savevm.h    |  2 +-
> >>>   migration/migration.c | 27 ++++++++++++++++++++++++---
> >>>   migration/savevm.c    | 26 +++++++++++++++-----------
> >>>   3 files changed, 40 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/migration/savevm.h b/migration/savevm.h
> >>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
> >>> --- a/migration/savevm.h
> >>> +++ b/migration/savevm.h
> >>> @@ -32,7 +32,7 @@
> >>>   bool qemu_savevm_state_blocked(Error **errp);
> >>>   void qemu_savevm_non_migratable_list(strList **reasons);
> >>>   int qemu_savevm_state_prepare(Error **errp);
> >>> -void qemu_savevm_state_setup(QEMUFile *f);
> >>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
> >>>   bool qemu_savevm_state_guest_unplug_pending(void);
> >>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
> >>>   void qemu_savevm_state_header(QEMUFile *f);
> >>> diff --git a/migration/migration.c b/migration/migration.c
> >>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
> >>> --- a/migration/migration.c
> >>> +++ b/migration/migration.c
> >>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
> >>>       int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> >>>       MigThrError thr_error;
> >>>       bool urgent = false;
> >>> +    Error *local_err = NULL;
> >>> +    int ret;
> >>>   
> >>>       thread = migration_threads_add("live_migration", qemu_get_thread_id());
> >>>   
> >>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
> >>>       }
> >>>   
> >>>       bql_lock();
> >>> -    qemu_savevm_state_setup(s->to_dst_file);
> >>> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
> >>>       bql_unlock();
> >>>   
> >>> +    if (ret) {
> >>> +        migrate_set_error(s, local_err);
> >>> +        error_free(local_err);
> >>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> >>> +                          MIGRATION_STATUS_FAILED);
> >>> +        goto out;
> >>> +     }
> >>> +
> >>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> >>>                                  MIGRATION_STATUS_ACTIVE);
> >> 
> >> This^ should be before the new block it seems:
> >> 
> >> GOOD:
> >> migrate_set_state new state setup
> >> migrate_set_state new state wait-unplug
> >> migrate_fd_cancel
> >> migrate_set_state new state cancelling
> >> migrate_fd_cleanup
> >> migrate_set_state new state cancelled
> >> migrate_fd_cancel
> >> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
> >> 
> >> BAD:
> >> migrate_set_state new state setup
> >> migrate_fd_cancel
> >> migrate_set_state new state cancelling
> >> migrate_fd_cleanup
> >> migrate_set_state new state cancelled
> >> qemu-system-x86_64: ram_save_setup failed: Input/output error
> >> **
> >> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug:
> >> assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
> >> 
> >> Otherwise migration_iteration_finish() will schedule the cleanup BH and
> >> that will run concurrently with migrate_fd_cancel() issued by the test
> >> and bad things happens.
> >
> > This hack makes things work :
> >
> > @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
> >           qemu_savevm_send_colo_enable(s->to_dst_file);
> >       }
> >   
> > +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> > +                            MIGRATION_STATUS_SETUP);
> > +
> 
> Why move it all the way up here? Has moving the wait_unplug before the
> 'if (ret)' block not worked for you?
> 
> >       bql_lock();
> >       ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
> >       bql_unlock();
> >
> > We should fix the test instead :) Unless waiting for failover devices
> > to unplug before the save_setup handlers and not after is ok.
> >
> > commit c7e0acd5a3f8 ("migration: add new migration state wait-unplug")
> > is not clear about the justification.:
> >
> >      This patch adds a new migration state called wait-unplug.  It is entered
> >      after the SETUP state if failover devices are present. It will transition
> >      into ACTIVE once all devices were succesfully unplugged from the guest.
> 
> This is not clear indeed, but to me it seems having the wait-unplug
> after setup was important.

Finally got some time to read this code..

So far I didn't see an issue if it's called before the setup hooks.
Actually it looks to me it should better do that before those hooks.

IIUC what that qemu_savevm_wait_unplug() does is waiting for all the
primary devices to be completely unplugged before moving on the migration.

Here setup() hook, or to be explicit, the primary devices' VMSDs (if ever
existed, and if that was the concern) should have zero impact on such wait,
because the "unplug" should also contain one step to unregister those
vmsds; see the virtio_net_handle_migration_primary() where it has:

        if (failover_unplug_primary(n, dev)) {
            vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
            ...
        }

So qemu_savevm_wait_unplug() looks like a pure wait function to me until
all the unplug is processed by the guest OS.  And it makes some sense to me
to avoid calling setup() (which can start to hold resources, like in RAM we
create bitmaps etc to prepare for migration) before such possible long halts.

In all cases, I guess it's still too rush to figure out a plan, meanwhile
anything proposed for either test/code changes would better get some
reviews from either Laurent or other virtio-net guys.  I think I'll go
ahead the pull without the 2nd batch of patches.

> 
> >
> >
> >> =====
> >> PS: I guess the next level in our Freestyle Concurrency video-game is to
> >> make migrate_fd_cancel() stop setting state and poking files and only
> >> set a flag that's tested in the other parts of the code.
> >
> > Is that a new item on the TODO list?
> 
> Yep, I'll add it to the wiki.

Sounds like a good thing, however let's be aware of the evils (that are
always in the details..), where there can be users/tests relying on that
"CANCELLING" state, so it can be part of the ABIs.. :-(

-- 
Peter Xu


