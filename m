Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BBF606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KlHjvXy0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PR9jWkDX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWuzD-00035c-0o; Fri, 27 Nov 2026 07:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWuyj-0002wT-L0
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:23:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWuyg-0000vs-Uo
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795782178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2lfSPK7zfNvuMQE46ExQfEg1P5C/zBAv2fPBqx7fA4=;
 b=KlHjvXy0pePXwZy/n+e8TeMboCFmbxR+Xiddoj1g2QzB8TZgX7G3FgGpay2CSfdbiBes7y
 mqlM3jhZs6h0JQkFxHkaGccW1XXyz3/StHL8k3S7uLbSW8y+82coBKNigzlHeptZZlewhh
 3FLwRimcOob2oX9LAfVavpTuz7qd9yE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-G2X6R23iNLanfl8Lyfl9GQ-1; Fri, 27 Nov 2026 12:22:53 +0000
X-MC-Unique: G2X6R23iNLanfl8Lyfl9GQ-1
X-Mimecast-MFC-AGG-ID: G2X6R23iNLanfl8Lyfl9GQ_1795782172
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961511b61so1274051685a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795782172; x=1796386972; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W2lfSPK7zfNvuMQE46ExQfEg1P5C/zBAv2fPBqx7fA4=;
 b=PR9jWkDXEETjJy4oJD+n3n41o9hpJXtKScdNEZxGQrZrG4LEWTcMVdK/l0y1uXt8zb
 CTVQJqdb2gE9S+qSYR7w9RPitCdWF+eNmg+yhNQxWli0MKtXpgZ3vkHYA4dnFqLiRgo0
 JwIqglTJHAW7tRkfWFTG3WU+L4G1C0bzQ+tpNlDMoN4VcU2DAZVhx4nNa5Iy6I/GaLbu
 Xh9w+NpwlHLFJ3LOjha/kIIUESfFxAgjGAf7jZBh71dWyuruGp0AIdfBnC5N5/pDqY4g
 cJV5FNQ46ZlBC8DLmvHi6UDvaH/EcE7/CSbtc8mdC2SP/TI5zRkyNtLpXp9iXHpQ/2EI
 6ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795782172; x=1796386972;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W2lfSPK7zfNvuMQE46ExQfEg1P5C/zBAv2fPBqx7fA4=;
 b=DcF5g1rHmP36kNOTWfjhVMFb3sSokAjXhONVab2ENCbGabwn9auq1auCuzW+r/h3jN
 R5ugEXtLP89U5QWDnjQRnWDZ4R52y15fO+8pz4HP6FgKw/90IBvWzH+LwWYaZB7HokSm
 aHa++F0TOkUDjUG0eBJjRh7poZzkcZXjdDvIKeRlPctJN7/Dqrbn01qmixupeDBaeWWR
 N8VJMyP7u9aTvatMAC/wbOBcb16UMlApHeIndHqllMMRFHlZdPVWTeiFt9ECs3Rm8/iA
 l1hpqPgk/4szT+xEt6K9HT+5YkWoRO3PaQl5CIixzavD7PWibfAkYakPs/FrhJTMDAxR
 gUww==
X-Forwarded-Encrypted: i=1;
 AL+hErGfYsLuuI+RJBISwhYsYxyv5Fg7e51FOa0T3Wix1piAial3J9BWGeawolK5NduDXyzK05NBYluZVPfl@nongnu.org
X-Gm-Message-State: APuU4Z9R9wJTD48vSI8Zmnc3azRpzgy7SmLwPk0QK/LYDfQM3EqiaehS
 9Xa8i1csoawHaHtoFTb4Uhd2wlb77GG3R1ly+99/tvYqmzyac2MNWUnccBuybjVzLUSW+WX7icd
 cjmazaMSS1z1HYtdtl1XAG0gCUOxWAHmlKK0UXYPr1Xtb+1vKYkUN6v8l
X-Gm-Gg: AZFdTZebel0eMBq6WfLvF+oOJlLCqbY8h7MgGCQcto1FvogbZ0oJ7JrEVbaUYVEvaZv
 pUU/anTrz7DesLVlDK9YpWl0X825yu2I6xrSHrTQl2J4/6MvPZ3UlRv5VgNr4ds/CtcsjsuStvM
 ce5463BaSkP9lPoy7+zgs6DfnjAfsGmNuBJn0OKT1f3dcQLRt8wLJRnf0JYQ8S13gGmhqTDNt4r
 sKDLvsoCcUKuHpyw8S1RDpiWfpQ7WnGkRa/MiGjROR72dx9Ge00bJ0gOaG/t2bflWapFtBLkG9H
 Tq+X0fc4YNVeNnVVy6Mc5TjOuRwE8/mkVhQXvu2XjU0XnQ3jVlMBShSpyPBNL4hDaK5ozjEY4t0
 RQv/YSrYzUYAB9HlZGQCy+c+X2dCTuIvQg3Vb3yqbegZ+
X-Received: by 2002:a05:620a:2812:b0:949:98fe:8f66 with SMTP id
 af79cd13be357-949ba955442mr3827768685a.14.1795782172320; 
 Fri, 27 Nov 2026 04:22:52 -0800 (PST)
X-Received: by 2002:a05:620a:2812:b0:949:98fe:8f66 with SMTP id
 af79cd13be357-949ba955442mr3827764585a.14.1795782171736; 
 Fri, 27 Nov 2026 04:22:51 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949ca6a0693sm1583077985a.20.2026.11.27.04.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:22:50 -0800 (PST)
Date: Fri, 27 Nov 2026 07:22:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
Message-ID: <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
 <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87y0afqoho.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0afqoho.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 26, 2026 at 06:20:03PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Nov 26, 2026 at 11:38:14AM -0300, Fabiano Rosas wrote:
> >> "Denis V. Lunev" <den@virtuozzo.com> writes:
> >> 
> >> > On 11/26/26 00:26, Fabiano Rosas wrote:
> >> >> "Denis V. Lunev" <den@openvz.org> writes:
> >> >>
> >> >> What a coincidence, I just spent the afternoon fixing this. 
> >> >>
> >> >>> Cancelling a migration right after starting it can hang the source
> >> >>> QEMU forever. This happens when the cancel arrives while the source is
> >> >>> still connecting to the destination and the connection then succeeds.
> >> >>> The source goes on as if nothing was cancelled, then waits for a reply
> >> >>> from the destination that never comes. It waits with the BQL held, so
> >> >>> the monitor stops answering too, and the only way out is to kill the
> >> >>> source. We hit this in an automated test that aborts a live migration
> >> >>> right after starting it.
> >> >> How does this test look like? I'm thinking that instead of writing a new
> >> >> test for this bug (haven't read your patch 2 yet), what we need it to
> >> >> remove the usage of migrate_wait_for_dirty_mem from the multifd cancel
> >> >> test. I think that's an artificial delay that's there for no good reason
> >> >> in this case. If your CI manages to hit the issue on a real-ish
> >> >> scenario, that's even more reason to remove that code.
> >> > This is old fashioned product testing over OpenStack cluster
> >> > which specifically performing cancels in a row. Tests are run
> >> > inside VMs inside the product and thus L0 host delays comes
> >> > as a bit of fuzzing.
> >> >
> >> 
> >> That is good to know because I was not sure whether this issue could
> >> happen outside of migration-test.
> >> 
> >> > Tests are running non-stop inside development cycle :-)
> >> >
> >> > That is why I am coming with this or that problems on paths
> >> > like that. But this is not very good in terms of QEMU level
> >> > specific tests and that is why patch 2 comes with a pointing
> >> > tests.
> >> >
> >> > NOTE: both your are my patches are fixed the problem as stated
> >> > and the test passes without both your and my variants.
> >> >
> >> >>> Patch 2 adds a qtest for this window, which Peter left for later when
> >> >>> fixing the early-cancel crash in 4f08b870f8 [1].
> >> >>>
> >> >>> [1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com
> >> >>>
> >> >>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >> >>> Cc: Peter Xu <peterx@redhat.com>
> >> >>> Cc: Fabiano Rosas <farosas@suse.de>
> >> >>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> >>> Cc: Laurent Vivier <lvivier@redhat.com>
> >> >>>
> >> >>> Denis V. Lunev (2):
> >> >>>   migration: fix source hang on cancel before the channel connects
> >> >> Here's my version. It's very opinionated due to my long-standing grudge
> >> >> with this code.
> >> >> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency
> >> >>
> >> >> -- >8 --
> >> >> From a27909503af9749f2cf6d8b901d675ee24c66d2c Mon Sep 17 00:00:00 2001
> >> >> From: Fabiano Rosas <farosas@suse.de>
> >> >> Date: Wed, 25 Nov 2026 18:43:57 -0300
> >> >> Subject: [PATCH 1/2] migration: Avoid early cancel causing a hang
> >> >>
> >> >> If migration is cancelled at just the right moment when the main
> >> >> channel transport has finished connecting, it's possible that the
> >> >> shutdown()s issued by migrate_cancel() miss the (unset) QEMUFiles
> >> >> entirely. A moment later, migration_channel_connect_outgoing() carries
> >> >> along with the migration and initializes the QEMUFiles for the first
> >> >> time.
> >> >>
> >> >> Migration then hangs because the source goes into migration_cleanup()
> >> >> due to its state being CANCELLING and hangs waiting for the return
> >> >> path thread to join, which never happens because the destination is
> >> >> unaware and never sends any SHUT message. The cleanup itself also
> >> >> doesn't kick the RP thread because commit 64763e8ca61 ("migration:
> >> >> Keep s->rp_state.from_dst_file open until migration ends") has changed
> >> >> the code to keep the QEMUFile until after the RP thread exits. The
> >> >> only other way to kick it would be from
> >> >> stop_return_path_thread_on_source() if an error had occurred, but no
> >> >> error has occurred.
> >> >>
> >> >> This situation is not surprising because the migration cancelling has
> >> >> never had any synchronization mechanism aside from the BQL, which in
> >> >> this case is not enough to protect from the race. It has also never
> >> >> had a way to inform the rest of the code in a thread safe manner about
> >> >> the cancellation.
> >> >>
> >> >> To start moving in the correct direction, make the qmp_migrate_cancel
> >> >> command (under BQL) set the migration error, which is protected by the
> >> >> error_mutex and suitable to be used as a way to inform the other
> >> >> threads of the cancellation. This avoids the need to check the
> >> >> MigrationStatus which is already fragile in terms of concurrency.
> >> >>
> >> >> Note that the QMP handler for migrate_cancel is used instead of the
> >> >> internal function because the latter is used from other parts of the
> >> >> code that might have set s->error already.
> >> >>
> >> >> In the case where qmp_migrate_cancel() sets s->error and some other
> >> >> code hits an error due to the shutdown()s, the
> >> >> migrate_error_propagate() call chain will simply ignore the error set
> >> >> for last. This is the correct behavior because errors after cancelling
> >> >> are very likely to be caused by the cancellation itself. This has the
> >> >> extra benefit that the migration cancellation now shows up in the
> >> >> logs, which solves a confusing situation when the user sees "Broken
> >> >> pipe" and thinks it's due to an error.
> >> >>
> >> >> For this specific bug, check that the asynchronous entry to
> >> >> migration_channel_connect_outgoing() doesn't bring an already set
> >> >> s->error and call migration_connect_error_propagate() under the BQL if
> >> >> that's the case. We need the whole migration_connect_error_propagate()
> >> >> here to handle the postcopy resume case as well as making sure
> >> >> migration_cleanup() is reached.
> >> >>
> >> >> Reproduced with /x86_64/migration/multifd+postcopy/tcp/plain/cancel
> >> >> and my stress branch, which basically skips
> >> >> migrate_wait_for_dirty_mem().
> >> >>
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  migration/channel.c   | 5 +++++
> >> >>  migration/migration.c | 8 ++++++++
> >> >>  2 files changed, 13 insertions(+)
> >> >>
> >> >> diff --git a/migration/channel.c b/migration/channel.c
> >> >> index 1aeb8814858..12ff68fc38c 100644
> >> >> --- a/migration/channel.c
> >> >> +++ b/migration/channel.c
> >> >> @@ -563,6 +563,11 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
> >> >>  {
> >> >>      trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
> >> >>  
> >> >> +    if (migrate_has_error(s)) {
> >> >> +        migration_connect_error_propagate(s, error_copy(s->error));
> >
> > [1]
> >
> >> >> +        return;
> >> >> +    }
> >> >> +
> >> >>      if (migrate_channel_requires_tls_upgrade(ioc)) {
> >> >>          Error *local_err = NULL;
> >> >>  
> >> >> diff --git a/migration/migration.c b/migration/migration.c
> >> >> index 5686209ab11..40c3f21d520 100644
> >> >> --- a/migration/migration.c
> >> >> +++ b/migration/migration.c
> >> >> @@ -1890,6 +1890,8 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
> >> >>          return;
> >> >>      }
> >> >>  
> >> >> +    migrate_error_free(migrate_get_current());
> >
> > Is this line somewhat separate from the issue?  When s->error will be
> > non-NULL?
> >
> 
> One of the cancel tests issues migrate_cancel(to), that puts the error
> in s->error and since QEMU keeps running, a subsequent migration
> crashes. We free the error at migrate_init() and migrate_prepare() for
> similar reasons I think.

But this is migrate_incoming, which means if something got wrong, instead
of retrying, we should kill the qemu and re-initiate?  I don't know if we
could have other loopholes on this path to be invoked more than once.. as I
never expected it to run twice (either success and take over, or halted for
query error only, or killed).

> 
> >> >> +
> >> >>      if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
> >> >>          return;
> >> >>      }
> >> >> @@ -2218,6 +2220,9 @@ out:
> >> >>  
> >> >>  void qmp_migrate_cancel(Error **errp)
> >> >>  {
> >> >> +    MigrationState *s = migrate_get_current();
> >> >> +    Error *local_err = NULL;
> >> >> +
> >> >>      /*
> >> >>       * After postcopy migration has started, the source machine is not
> >> >>       * recoverable in case of a migration error. This also means the
> >> >> @@ -2229,6 +2234,9 @@ void qmp_migrate_cancel(Error **errp)
> >> >>          return;
> >> >>      }
> >> >>  
> >> >> +    error_setg(&local_err, "Migration was cancelled by the user.");
> >> >> +    migrate_error_propagate(s, local_err);
> >> >> +
> >> >>      migration_cancel();
> >> >>  }
> >> >>  
> >> > I have spend a bit of time trying to weight against the approaches
> >> > and the only item I found is that "cancel" is actually not a error
> >> > while we are reusing field as a error state.
> >> >
> >> 
> >> That cat is out of the bag already since commit dc487044d5c ("migration:
> >> Make migration_has_failed() work even for CANCELLING"). If
> >> migration_has_failed() includes cancel states, then I think it's
> >> actually a bug that migrate_cancel() doesn't set an error. Otherwise
> >> code that calls migration_has_failed() will have to check
> >> migrate_has_error() to find out if the "failure was an error". That's a
> >> worse pattern in my opinion.
> >
> > Indeed, at least for qemufile it's the same, where qemu_file_shutdown()
> > sets error for the qemufile error (PS: every time I see these bunch of
> > error flags I headache..).
> >
> >> 
> >> That's how I came up with this patch actually because I was trying to
> >> avoid checking SETUP specifically, in case something else races and sets
> >> another state in the mean time. As I mentioned briefly in the commit
> >> message, the MigrationStatus is not thread-safe, that cmpxchg only
> >> protects the migration event against a duplicated state change.
> >> 
> >> > Both are working. If you will take your one - pls consider
> >> >
> >> > Tested-by: Denis V. Lunev <den@openvz.org>
> >> > Reviewed-by: Denis V. Lunev <den@openvz.org>
> >> >
> >> > I would say - up to you :-)
> >> >
> >> 
> >> Thank you. Let's see what Peter thinks about it.
> >
> > I agree with you that if we already have code treating cancellation as part
> > of error, then setting error may make things more aligned.
> >
> > My only complaint might be that above [1], it has "if there is an error,
> > duplicate that error and try to inject the same error, even if we're
> > pretty sure is already there, so the dup one will be freed".  It was almost
> > a malloc/free unit test..
> >
> 
> Hmm, maybe NULL is indeed better, let me check. We just need to make
> sure the error is set because the RP closing path then gets one more
> chance to call shutdown(). But yeah, migrate_has_error() already
> guarantees that.

Yep.

> 
> > So.. maybe Fabiano's patch, but use the migrate_cleanup() from Denis
> > instead only at line [1]?
> 
> As you noticed, it has to be migration_connect_error_propagate() because
> it handles postcopy. I also don't want to have one more loose call to
> migration_cleanup(), it makes it difficult to think about concurrency
> bugs. The more we can centralize on a single error path, the better.

Yes I agree.

-- 
Peter Xu

