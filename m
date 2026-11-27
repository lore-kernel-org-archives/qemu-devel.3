Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB9606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C4hJGXWp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QzmTRSCE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PPlxeCLC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uEo/nh8L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvP4-0005XT-BV; Fri, 27 Nov 2026 07:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWvOy-0005Sp-C3
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:50:08 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWvOs-0008Ce-GM
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:50:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C18EA1FDF1;
 Fri, 27 Nov 2026 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795783798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch2F7yvHpcaXQJcbZqkATePPrz3r1aiDTUJBS3WUoWY=;
 b=C4hJGXWpgBJK+Hrn3/YS24qGKoYRNhyq9lfu3/GGGMXTPcsdLd8WMU98TaAplwsYgC8gE2
 VPkbDDakxDt9HumI38Y0A80K5vgR5d6ZsjG90m1BI9ixDMs7CDAJHhstlNjhllv9Sdv10Z
 ipG4S1dbWEUlr4OCSgy+nZBfZfSgl30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795783798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch2F7yvHpcaXQJcbZqkATePPrz3r1aiDTUJBS3WUoWY=;
 b=QzmTRSCEYlcHw34TIQN+7D2hmsP2yJw60h0KoCc9W3bE2RjP7TlxVsEikOtd2X+vbq++rG
 3AbeVP8JkD/6/ZBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795783797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch2F7yvHpcaXQJcbZqkATePPrz3r1aiDTUJBS3WUoWY=;
 b=PPlxeCLCjbXjhUL2bOQ6CqXtUHF5e3U+dtPL7H0C7yKJIVdKT4Y44YOiwqLRun8GwMCAiC
 Dsw84/WrZEdUBiSgsgPeIkKn15xXz5GUx4JKYCR7+CzzWtMtmD44hcphF8i6aDfCF4/lav
 FM8fj4WFht1Li/Tk6IczGWKCCJ52PSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795783797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch2F7yvHpcaXQJcbZqkATePPrz3r1aiDTUJBS3WUoWY=;
 b=uEo/nh8LTJL2kQgqgi9Y4UvBNkJn3wJG9EelnA+SyjCJ+65Xzgrq1qzLfeC3qkBbQi6lcJ
 dSk2wZh49M8wOyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EB07134E8;
 Fri, 27 Nov 2026 12:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GsMzJnR8CWsKbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 12:49:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
In-Reply-To: <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
 <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87y0afqoho.fsf@suse.de>
 <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Fri, 27 Nov 2026 09:49:50 -0300
Message-ID: <87v75iqw0h.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Xu <peterx@redhat.com> writes:

> On Thu, Nov 26, 2026 at 06:20:03PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Thu, Nov 26, 2026 at 11:38:14AM -0300, Fabiano Rosas wrote:
>> >> "Denis V. Lunev" <den@virtuozzo.com> writes:
>> >>=20
>> >> > On 11/26/26 00:26, Fabiano Rosas wrote:
>> >> >> "Denis V. Lunev" <den@openvz.org> writes:
>> >> >>
>> >> >> What a coincidence, I just spent the afternoon fixing this.=20
>> >> >>
>> >> >>> Cancelling a migration right after starting it can hang the source
>> >> >>> QEMU forever. This happens when the cancel arrives while the sour=
ce is
>> >> >>> still connecting to the destination and the connection then succe=
eds.
>> >> >>> The source goes on as if nothing was cancelled, then waits for a =
reply
>> >> >>> from the destination that never comes. It waits with the BQL held=
, so
>> >> >>> the monitor stops answering too, and the only way out is to kill =
the
>> >> >>> source. We hit this in an automated test that aborts a live migra=
tion
>> >> >>> right after starting it.
>> >> >> How does this test look like? I'm thinking that instead of writing=
 a new
>> >> >> test for this bug (haven't read your patch 2 yet), what we need it=
 to
>> >> >> remove the usage of migrate_wait_for_dirty_mem from the multifd ca=
ncel
>> >> >> test. I think that's an artificial delay that's there for no good =
reason
>> >> >> in this case. If your CI manages to hit the issue on a real-ish
>> >> >> scenario, that's even more reason to remove that code.
>> >> > This is old fashioned product testing over OpenStack cluster
>> >> > which specifically performing cancels in a row. Tests are run
>> >> > inside VMs inside the product and thus L0 host delays comes
>> >> > as a bit of fuzzing.
>> >> >
>> >>=20
>> >> That is good to know because I was not sure whether this issue could
>> >> happen outside of migration-test.
>> >>=20
>> >> > Tests are running non-stop inside development cycle :-)
>> >> >
>> >> > That is why I am coming with this or that problems on paths
>> >> > like that. But this is not very good in terms of QEMU level
>> >> > specific tests and that is why patch 2 comes with a pointing
>> >> > tests.
>> >> >
>> >> > NOTE: both your are my patches are fixed the problem as stated
>> >> > and the test passes without both your and my variants.
>> >> >
>> >> >>> Patch 2 adds a qtest for this window, which Peter left for later =
when
>> >> >>> fixing the early-cancel crash in 4f08b870f8 [1].
>> >> >>>
>> >> >>> [1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redh=
at.com
>> >> >>>
>> >> >>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> >> >>> Cc: Peter Xu <peterx@redhat.com>
>> >> >>> Cc: Fabiano Rosas <farosas@suse.de>
>> >> >>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> >>> Cc: Laurent Vivier <lvivier@redhat.com>
>> >> >>>
>> >> >>> Denis V. Lunev (2):
>> >> >>>   migration: fix source hang on cancel before the channel connects
>> >> >> Here's my version. It's very opinionated due to my long-standing g=
rudge
>> >> >> with this code.
>> >> >> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurre=
ncy
>> >> >>
>> >> >> -- >8 --
>> >> >> From a27909503af9749f2cf6d8b901d675ee24c66d2c Mon Sep 17 00:00:00 =
2001
>> >> >> From: Fabiano Rosas <farosas@suse.de>
>> >> >> Date: Wed, 25 Nov 2026 18:43:57 -0300
>> >> >> Subject: [PATCH 1/2] migration: Avoid early cancel causing a hang
>> >> >>
>> >> >> If migration is cancelled at just the right moment when the main
>> >> >> channel transport has finished connecting, it's possible that the
>> >> >> shutdown()s issued by migrate_cancel() miss the (unset) QEMUFiles
>> >> >> entirely. A moment later, migration_channel_connect_outgoing() car=
ries
>> >> >> along with the migration and initializes the QEMUFiles for the fir=
st
>> >> >> time.
>> >> >>
>> >> >> Migration then hangs because the source goes into migration_cleanu=
p()
>> >> >> due to its state being CANCELLING and hangs waiting for the return
>> >> >> path thread to join, which never happens because the destination is
>> >> >> unaware and never sends any SHUT message. The cleanup itself also
>> >> >> doesn't kick the RP thread because commit 64763e8ca61 ("migration:
>> >> >> Keep s->rp_state.from_dst_file open until migration ends") has cha=
nged
>> >> >> the code to keep the QEMUFile until after the RP thread exits. The
>> >> >> only other way to kick it would be from
>> >> >> stop_return_path_thread_on_source() if an error had occurred, but =
no
>> >> >> error has occurred.
>> >> >>
>> >> >> This situation is not surprising because the migration cancelling =
has
>> >> >> never had any synchronization mechanism aside from the BQL, which =
in
>> >> >> this case is not enough to protect from the race. It has also never
>> >> >> had a way to inform the rest of the code in a thread safe manner a=
bout
>> >> >> the cancellation.
>> >> >>
>> >> >> To start moving in the correct direction, make the qmp_migrate_can=
cel
>> >> >> command (under BQL) set the migration error, which is protected by=
 the
>> >> >> error_mutex and suitable to be used as a way to inform the other
>> >> >> threads of the cancellation. This avoids the need to check the
>> >> >> MigrationStatus which is already fragile in terms of concurrency.
>> >> >>
>> >> >> Note that the QMP handler for migrate_cancel is used instead of the
>> >> >> internal function because the latter is used from other parts of t=
he
>> >> >> code that might have set s->error already.
>> >> >>
>> >> >> In the case where qmp_migrate_cancel() sets s->error and some other
>> >> >> code hits an error due to the shutdown()s, the
>> >> >> migrate_error_propagate() call chain will simply ignore the error =
set
>> >> >> for last. This is the correct behavior because errors after cancel=
ling
>> >> >> are very likely to be caused by the cancellation itself. This has =
the
>> >> >> extra benefit that the migration cancellation now shows up in the
>> >> >> logs, which solves a confusing situation when the user sees "Broken
>> >> >> pipe" and thinks it's due to an error.
>> >> >>
>> >> >> For this specific bug, check that the asynchronous entry to
>> >> >> migration_channel_connect_outgoing() doesn't bring an already set
>> >> >> s->error and call migration_connect_error_propagate() under the BQ=
L if
>> >> >> that's the case. We need the whole migration_connect_error_propaga=
te()
>> >> >> here to handle the postcopy resume case as well as making sure
>> >> >> migration_cleanup() is reached.
>> >> >>
>> >> >> Reproduced with /x86_64/migration/multifd+postcopy/tcp/plain/cancel
>> >> >> and my stress branch, which basically skips
>> >> >> migrate_wait_for_dirty_mem().
>> >> >>
>> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> >> ---
>> >> >>  migration/channel.c   | 5 +++++
>> >> >>  migration/migration.c | 8 ++++++++
>> >> >>  2 files changed, 13 insertions(+)
>> >> >>
>> >> >> diff --git a/migration/channel.c b/migration/channel.c
>> >> >> index 1aeb8814858..12ff68fc38c 100644
>> >> >> --- a/migration/channel.c
>> >> >> +++ b/migration/channel.c
>> >> >> @@ -563,6 +563,11 @@ void migration_channel_connect_outgoing(Migra=
tionState *s, QIOChannel *ioc)
>> >> >>  {
>> >> >>      trace_migration_outgoing_channel_set(ioc, object_get_typename=
(OBJECT(ioc)));
>> >> >>=20=20
>> >> >> +    if (migrate_has_error(s)) {
>> >> >> +        migration_connect_error_propagate(s, error_copy(s->error)=
);
>> >
>> > [1]
>> >
>> >> >> +        return;
>> >> >> +    }
>> >> >> +
>> >> >>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>> >> >>          Error *local_err =3D NULL;
>> >> >>=20=20
>> >> >> diff --git a/migration/migration.c b/migration/migration.c
>> >> >> index 5686209ab11..40c3f21d520 100644
>> >> >> --- a/migration/migration.c
>> >> >> +++ b/migration/migration.c
>> >> >> @@ -1890,6 +1890,8 @@ void qmp_migrate_incoming(const char *uri, b=
ool has_channels,
>> >> >>          return;
>> >> >>      }
>> >> >>=20=20
>> >> >> +    migrate_error_free(migrate_get_current());
>> >
>> > Is this line somewhat separate from the issue?  When s->error will be
>> > non-NULL?
>> >
>>=20
>> One of the cancel tests issues migrate_cancel(to), that puts the error
>> in s->error and since QEMU keeps running, a subsequent migration
>> crashes. We free the error at migrate_init() and migrate_prepare() for
>> similar reasons I think.
>
> But this is migrate_incoming, which means if something got wrong, instead
> of retrying, we should kill the qemu and re-initiate?  I don't know if we
> could have other loopholes on this path to be invoked more than once.. as=
 I
> never expected it to run twice (either success and take over, or halted f=
or
> query error only, or killed).
>

I think this is only about calling cancel _without_ any migration:

$ (echo "migrate_cancel"; echo "quit") | ~/qemu-system-x86_64 -S -monitor s=
tdio -incoming defer -trace migration_cancel
QEMU 11.1.92 monitor - type 'help' for more information
(qemu) migrate_cancel
migration_cancel=20
(qemu) quit
migration_cancel

So a state check in there could be good enough.

>>=20
>> >> >> +
>> >> >>      if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
>> >> >>          return;
>> >> >>      }
>> >> >> @@ -2218,6 +2220,9 @@ out:
>> >> >>=20=20
>> >> >>  void qmp_migrate_cancel(Error **errp)
>> >> >>  {
>> >> >> +    MigrationState *s =3D migrate_get_current();
>> >> >> +    Error *local_err =3D NULL;
>> >> >> +
>> >> >>      /*
>> >> >>       * After postcopy migration has started, the source machine i=
s not
>> >> >>       * recoverable in case of a migration error. This also means =
the
>> >> >> @@ -2229,6 +2234,9 @@ void qmp_migrate_cancel(Error **errp)
>> >> >>          return;
>> >> >>      }
>> >> >>=20=20
>> >> >> +    error_setg(&local_err, "Migration was cancelled by the user."=
);
>> >> >> +    migrate_error_propagate(s, local_err);
>> >> >> +
>> >> >>      migration_cancel();
>> >> >>  }
>> >> >>=20=20
>> >> > I have spend a bit of time trying to weight against the approaches
>> >> > and the only item I found is that "cancel" is actually not a error
>> >> > while we are reusing field as a error state.
>> >> >
>> >>=20
>> >> That cat is out of the bag already since commit dc487044d5c ("migrati=
on:
>> >> Make migration_has_failed() work even for CANCELLING"). If
>> >> migration_has_failed() includes cancel states, then I think it's
>> >> actually a bug that migrate_cancel() doesn't set an error. Otherwise
>> >> code that calls migration_has_failed() will have to check
>> >> migrate_has_error() to find out if the "failure was an error". That's=
 a
>> >> worse pattern in my opinion.
>> >
>> > Indeed, at least for qemufile it's the same, where qemu_file_shutdown()
>> > sets error for the qemufile error (PS: every time I see these bunch of
>> > error flags I headache..).
>> >
>> >>=20
>> >> That's how I came up with this patch actually because I was trying to
>> >> avoid checking SETUP specifically, in case something else races and s=
ets
>> >> another state in the mean time. As I mentioned briefly in the commit
>> >> message, the MigrationStatus is not thread-safe, that cmpxchg only
>> >> protects the migration event against a duplicated state change.
>> >>=20
>> >> > Both are working. If you will take your one - pls consider
>> >> >
>> >> > Tested-by: Denis V. Lunev <den@openvz.org>
>> >> > Reviewed-by: Denis V. Lunev <den@openvz.org>
>> >> >
>> >> > I would say - up to you :-)
>> >> >
>> >>=20
>> >> Thank you. Let's see what Peter thinks about it.
>> >
>> > I agree with you that if we already have code treating cancellation as=
 part
>> > of error, then setting error may make things more aligned.
>> >
>> > My only complaint might be that above [1], it has "if there is an erro=
r,
>> > duplicate that error and try to inject the same error, even if we're
>> > pretty sure is already there, so the dup one will be freed".  It was a=
lmost
>> > a malloc/free unit test..
>> >
>>=20
>> Hmm, maybe NULL is indeed better, let me check. We just need to make
>> sure the error is set because the RP closing path then gets one more
>> chance to call shutdown(). But yeah, migrate_has_error() already
>> guarantees that.
>
> Yep.
>
>>=20
>> > So.. maybe Fabiano's patch, but use the migrate_cleanup() from Denis
>> > instead only at line [1]?
>>=20
>> As you noticed, it has to be migration_connect_error_propagate() because
>> it handles postcopy. I also don't want to have one more loose call to
>> migration_cleanup(), it makes it difficult to think about concurrency
>> bugs. The more we can centralize on a single error path, the better.
>
> Yes I agree.

