Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9513606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpmeNvOZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=isgOmILc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWfD2-0007pk-F9; Thu, 26 Nov 2026 14:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfD0-0007nw-0C
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfCx-000537-Jw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795721557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCW8WYsMUqJs16Z9OcnpZbUfWxwREKZee+ztzectGnE=;
 b=TpmeNvOZqYu8Z4/8wdLTxk0s57bbvhj+dl2ZefdQR/2dBdFkIR+Mi8KkU/Kryl8OnXpIGC
 Kfa47M4fuw08Ohti+aHyXuxHFARxv/ofozR5RaGER+jwOQCSO8SMrM1o/SU3ahsBU8Kef+
 CprsucTPO2mTFpK3J42+bfu2vGlmBq8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-reJlOiFNMCanJyLvfGsFaw-1; Thu, 26 Nov 2026 19:32:35 +0000
X-MC-Unique: reJlOiFNMCanJyLvfGsFaw-1
X-Mimecast-MFC-AGG-ID: reJlOiFNMCanJyLvfGsFaw_1795721555
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d322fbso1018197885a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795721555; x=1796326355; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uCW8WYsMUqJs16Z9OcnpZbUfWxwREKZee+ztzectGnE=;
 b=isgOmILc099HyYconpjHe9ihFmlrg57UxuovjxISnhg0TnuTiSYGqf+9K+APcU5BED
 cl/rnCZpp8nfIW3wGMO5rP8gUufaZbLKQfKV8+e+Iv2hM0Qw/DruirtwGJc8R/fVIQ69
 JqBkGqk+Vy3tA4VXm7vYObBRBrEm9A1VmeBJxbsae7C0dpSgQQ2TqcJT9bVycoRorzrm
 9V6S/UJe8HxTbk6CIN0hKtMHzcQm43dPQNHWm04HVQapk3/PIa00kcA1jU7p8r21GzGf
 SzAK8yfBcXgcGeBlJfVb25hWonxN9EdwxLsc88rgh4AZld4fI6jACCcyzli2H7rUjbmM
 4LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721555; x=1796326355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCW8WYsMUqJs16Z9OcnpZbUfWxwREKZee+ztzectGnE=;
 b=KpsU8Y46op0WE00GcffpC7OsQid9I6ZLu/Wpk/hXW0JXKGOJyW1PDiBHad+WMF0Q1o
 3qMJCeGqy33QCJkp8Zr49p6Fho4BqS6UOsyCiWbFA5asmg/DUcFQpvopFPTeRprJdgB3
 DINYyrl8U6N9Pp2a6A5lr2ecSe6uFwu8w0Wq0IFPn+Iv5C4UeMRaGVGoq1sRwuRrBqFH
 QNuVFrbG2/Pmg9vqHGX3ODRaChZlmhNGYjHoRELcWxUWCbqSvq6cU2mSXxz6KYiSpau1
 2mYem0FRPgl72Dbz08Kc+Tstz/a4aEr17i8InXN1qpgqM72lyBIDwkfUFaSl1qyX5W61
 1QnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF4k+GCyrAExBfyppv2sfwPWBOJoqAXARj51VoTOx46PYKrSgrM57OnlxL+CtoEw7Vy9quWA3uvFLBB@nongnu.org
X-Gm-Message-State: APuU4Z9IWNZoAxuZgK+hFfQGyzDKO9ENAI9jppdXTDkJ4ITWUC2kDH4t
 15YGOpIvOlQ2wSsiEu7ROCCCUkiF6ZdD9IXVnYXaS686aa00Fd/Ptzq/ItJlab9ALbCnIB8zWev
 yJUym6lOK0EiDp6zkYK3sKtZECFOfGjUJAGhYFWWTJK3YJEX7GQYFgRag
X-Gm-Gg: AZFdTZePf2KERdfxutE4t7GPfuq7wyaCFmigR15rSqzG+Bm6QqMMaVwJDiZ+H1f7YLD
 tdg2r/aa+W7rDgjLTbY/pADB99ipXpwlxH4E9B5Oga65WeqYja7+lYYKBmyNCOCUSJy0n0vHBbs
 Up270Hwui2bVHBopxUunGH2MT1K22WfbtxfXyBdiZ7BYQSNt7dxA6oc6gZVIqMskoR8THNb3fsm
 G7fKynFl5hZsX0QCFFeJg6xeO+CXafbEJKZcIU9W013zK1qYjITcu7O6z3aN7Tce+L9eKYN8UrM
 ImEs6GIJNrjCVP1DQXseQI3M6wQhAWUB7yPn6/j1qbbxhGu3sJAuuNrBSD12Ko5urNtiSVuK5qT
 ZiAauaSCJP8wikqC1cWAYzP8Nqg72fLACF3yqbPijZ1Xe
X-Received: by 2002:a05:620a:171f:b0:949:7f5c:6d9d with SMTP id
 af79cd13be357-949bab24d39mr3775160285a.75.1795721554484; 
 Thu, 26 Nov 2026 11:32:34 -0800 (PST)
X-Received: by 2002:a05:620a:171f:b0:949:7f5c:6d9d with SMTP id
 af79cd13be357-949bab24d39mr3775154985a.75.1795721553898; 
 Thu, 26 Nov 2026 11:32:33 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3a646fsm1657152185a.22.2026.11.26.11.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:32:33 -0800 (PST)
Date: Thu, 26 Nov 2026 14:32:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
Message-ID: <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8733snslnt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 11:38:14AM -0300, Fabiano Rosas wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
> 
> > On 11/26/26 00:26, Fabiano Rosas wrote:
> >> "Denis V. Lunev" <den@openvz.org> writes:
> >>
> >> What a coincidence, I just spent the afternoon fixing this. 
> >>
> >>> Cancelling a migration right after starting it can hang the source
> >>> QEMU forever. This happens when the cancel arrives while the source is
> >>> still connecting to the destination and the connection then succeeds.
> >>> The source goes on as if nothing was cancelled, then waits for a reply
> >>> from the destination that never comes. It waits with the BQL held, so
> >>> the monitor stops answering too, and the only way out is to kill the
> >>> source. We hit this in an automated test that aborts a live migration
> >>> right after starting it.
> >> How does this test look like? I'm thinking that instead of writing a new
> >> test for this bug (haven't read your patch 2 yet), what we need it to
> >> remove the usage of migrate_wait_for_dirty_mem from the multifd cancel
> >> test. I think that's an artificial delay that's there for no good reason
> >> in this case. If your CI manages to hit the issue on a real-ish
> >> scenario, that's even more reason to remove that code.
> > This is old fashioned product testing over OpenStack cluster
> > which specifically performing cancels in a row. Tests are run
> > inside VMs inside the product and thus L0 host delays comes
> > as a bit of fuzzing.
> >
> 
> That is good to know because I was not sure whether this issue could
> happen outside of migration-test.
> 
> > Tests are running non-stop inside development cycle :-)
> >
> > That is why I am coming with this or that problems on paths
> > like that. But this is not very good in terms of QEMU level
> > specific tests and that is why patch 2 comes with a pointing
> > tests.
> >
> > NOTE: both your are my patches are fixed the problem as stated
> > and the test passes without both your and my variants.
> >
> >>> Patch 2 adds a qtest for this window, which Peter left for later when
> >>> fixing the early-cancel crash in 4f08b870f8 [1].
> >>>
> >>> [1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com
> >>>
> >>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Fabiano Rosas <farosas@suse.de>
> >>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Laurent Vivier <lvivier@redhat.com>
> >>>
> >>> Denis V. Lunev (2):
> >>>   migration: fix source hang on cancel before the channel connects
> >> Here's my version. It's very opinionated due to my long-standing grudge
> >> with this code.
> >> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency
> >>
> >> -- >8 --
> >> From a27909503af9749f2cf6d8b901d675ee24c66d2c Mon Sep 17 00:00:00 2001
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Date: Wed, 25 Nov 2026 18:43:57 -0300
> >> Subject: [PATCH 1/2] migration: Avoid early cancel causing a hang
> >>
> >> If migration is cancelled at just the right moment when the main
> >> channel transport has finished connecting, it's possible that the
> >> shutdown()s issued by migrate_cancel() miss the (unset) QEMUFiles
> >> entirely. A moment later, migration_channel_connect_outgoing() carries
> >> along with the migration and initializes the QEMUFiles for the first
> >> time.
> >>
> >> Migration then hangs because the source goes into migration_cleanup()
> >> due to its state being CANCELLING and hangs waiting for the return
> >> path thread to join, which never happens because the destination is
> >> unaware and never sends any SHUT message. The cleanup itself also
> >> doesn't kick the RP thread because commit 64763e8ca61 ("migration:
> >> Keep s->rp_state.from_dst_file open until migration ends") has changed
> >> the code to keep the QEMUFile until after the RP thread exits. The
> >> only other way to kick it would be from
> >> stop_return_path_thread_on_source() if an error had occurred, but no
> >> error has occurred.
> >>
> >> This situation is not surprising because the migration cancelling has
> >> never had any synchronization mechanism aside from the BQL, which in
> >> this case is not enough to protect from the race. It has also never
> >> had a way to inform the rest of the code in a thread safe manner about
> >> the cancellation.
> >>
> >> To start moving in the correct direction, make the qmp_migrate_cancel
> >> command (under BQL) set the migration error, which is protected by the
> >> error_mutex and suitable to be used as a way to inform the other
> >> threads of the cancellation. This avoids the need to check the
> >> MigrationStatus which is already fragile in terms of concurrency.
> >>
> >> Note that the QMP handler for migrate_cancel is used instead of the
> >> internal function because the latter is used from other parts of the
> >> code that might have set s->error already.
> >>
> >> In the case where qmp_migrate_cancel() sets s->error and some other
> >> code hits an error due to the shutdown()s, the
> >> migrate_error_propagate() call chain will simply ignore the error set
> >> for last. This is the correct behavior because errors after cancelling
> >> are very likely to be caused by the cancellation itself. This has the
> >> extra benefit that the migration cancellation now shows up in the
> >> logs, which solves a confusing situation when the user sees "Broken
> >> pipe" and thinks it's due to an error.
> >>
> >> For this specific bug, check that the asynchronous entry to
> >> migration_channel_connect_outgoing() doesn't bring an already set
> >> s->error and call migration_connect_error_propagate() under the BQL if
> >> that's the case. We need the whole migration_connect_error_propagate()
> >> here to handle the postcopy resume case as well as making sure
> >> migration_cleanup() is reached.
> >>
> >> Reproduced with /x86_64/migration/multifd+postcopy/tcp/plain/cancel
> >> and my stress branch, which basically skips
> >> migrate_wait_for_dirty_mem().
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/channel.c   | 5 +++++
> >>  migration/migration.c | 8 ++++++++
> >>  2 files changed, 13 insertions(+)
> >>
> >> diff --git a/migration/channel.c b/migration/channel.c
> >> index 1aeb8814858..12ff68fc38c 100644
> >> --- a/migration/channel.c
> >> +++ b/migration/channel.c
> >> @@ -563,6 +563,11 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
> >>  {
> >>      trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
> >>  
> >> +    if (migrate_has_error(s)) {
> >> +        migration_connect_error_propagate(s, error_copy(s->error));

[1]

> >> +        return;
> >> +    }
> >> +
> >>      if (migrate_channel_requires_tls_upgrade(ioc)) {
> >>          Error *local_err = NULL;
> >>  
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 5686209ab11..40c3f21d520 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1890,6 +1890,8 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
> >>          return;
> >>      }
> >>  
> >> +    migrate_error_free(migrate_get_current());

Is this line somewhat separate from the issue?  When s->error will be
non-NULL?

> >> +
> >>      if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
> >>          return;
> >>      }
> >> @@ -2218,6 +2220,9 @@ out:
> >>  
> >>  void qmp_migrate_cancel(Error **errp)
> >>  {
> >> +    MigrationState *s = migrate_get_current();
> >> +    Error *local_err = NULL;
> >> +
> >>      /*
> >>       * After postcopy migration has started, the source machine is not
> >>       * recoverable in case of a migration error. This also means the
> >> @@ -2229,6 +2234,9 @@ void qmp_migrate_cancel(Error **errp)
> >>          return;
> >>      }
> >>  
> >> +    error_setg(&local_err, "Migration was cancelled by the user.");
> >> +    migrate_error_propagate(s, local_err);
> >> +
> >>      migration_cancel();
> >>  }
> >>  
> > I have spend a bit of time trying to weight against the approaches
> > and the only item I found is that "cancel" is actually not a error
> > while we are reusing field as a error state.
> >
> 
> That cat is out of the bag already since commit dc487044d5c ("migration:
> Make migration_has_failed() work even for CANCELLING"). If
> migration_has_failed() includes cancel states, then I think it's
> actually a bug that migrate_cancel() doesn't set an error. Otherwise
> code that calls migration_has_failed() will have to check
> migrate_has_error() to find out if the "failure was an error". That's a
> worse pattern in my opinion.

Indeed, at least for qemufile it's the same, where qemu_file_shutdown()
sets error for the qemufile error (PS: every time I see these bunch of
error flags I headache..).

> 
> That's how I came up with this patch actually because I was trying to
> avoid checking SETUP specifically, in case something else races and sets
> another state in the mean time. As I mentioned briefly in the commit
> message, the MigrationStatus is not thread-safe, that cmpxchg only
> protects the migration event against a duplicated state change.
> 
> > Both are working. If you will take your one - pls consider
> >
> > Tested-by: Denis V. Lunev <den@openvz.org>
> > Reviewed-by: Denis V. Lunev <den@openvz.org>
> >
> > I would say - up to you :-)
> >
> 
> Thank you. Let's see what Peter thinks about it.

I agree with you that if we already have code treating cancellation as part
of error, then setting error may make things more aligned.

My only complaint might be that above [1], it has "if there is an error,
duplicate that error and try to inject the same error, even if we're
pretty sure is already there, so the dup one will be freed".  It was almost
a malloc/free unit test..

So.. maybe Fabiano's patch, but use the migrate_cleanup() from Denis
instead only at line [1]?

-- 
Peter Xu


