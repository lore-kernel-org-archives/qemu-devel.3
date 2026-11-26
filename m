Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E1606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZyS4Ive2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WgzX6XpV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hUcT+aXB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TcSEoYT4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWacW-0003Ui-D2; Thu, 26 Nov 2026 09:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWacD-0003GA-3L
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:38:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWacA-00047S-6W
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:38:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 214912255A;
 Thu, 26 Nov 2026 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795703900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3oCEWrTAL+JY9e/IUOplX5CIwNvgMJ7mcJVvqWhHR0=;
 b=ZyS4Ive2HJWZC3spNrLW/i22KC3y9A9H/hsn0IMFYzf0U2AVaxURWCxRNMqpuKRs7N0yrQ
 ANg/mDnvd+bWYAgEIterPIBxwMIMIELVQG6a/QxvZ399t0wGSHD35svyZ/lfPZFay8srli
 GOp2iOu6RZR8H2l40ifbdcNWeMRdm5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795703900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3oCEWrTAL+JY9e/IUOplX5CIwNvgMJ7mcJVvqWhHR0=;
 b=WgzX6XpVkQ8Fepmc1YoGoUS49QtPg972iPdmaUwK8Gjhe1V5gNwcg11fvK8s/KEcgH9xcP
 IDdhgXPhE7Ziq2Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795703899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3oCEWrTAL+JY9e/IUOplX5CIwNvgMJ7mcJVvqWhHR0=;
 b=hUcT+aXB/RePBXJeiyTC1bJ/LlEIiJkG18IcrNf4wneyCaZNtNMaQXAboPebEUGq6D2Jq7
 N4LeveG7wv6yQHcbYEI5w+mPMjYTxCfuAD6xkSyV606b5Rv1CTNQT+Jurqalqr10ppyVDb
 UMvtVyTKh6bxLZCGabo2uUmgIrJ3k+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795703899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3oCEWrTAL+JY9e/IUOplX5CIwNvgMJ7mcJVvqWhHR0=;
 b=TcSEoYT4TGkpXDAbnFjGhT9NNyV++BB3KX/TsKY/5MOoRBY8H92Zzv1dv19vVADryRXPHj
 k78KDhI/3edAGADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C4BB13432;
 Thu, 26 Nov 2026 14:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q3LSMVhECGsjLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 14:38:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
In-Reply-To: <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
Date: Thu, 26 Nov 2026 11:38:14 -0300
Message-ID: <8733snslnt.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email, suse.de:email, qemu.org:url,
 openvz.org:email, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 11/26/26 00:26, Fabiano Rosas wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>
>> What a coincidence, I just spent the afternoon fixing this.=20
>>
>>> Cancelling a migration right after starting it can hang the source
>>> QEMU forever. This happens when the cancel arrives while the source is
>>> still connecting to the destination and the connection then succeeds.
>>> The source goes on as if nothing was cancelled, then waits for a reply
>>> from the destination that never comes. It waits with the BQL held, so
>>> the monitor stops answering too, and the only way out is to kill the
>>> source. We hit this in an automated test that aborts a live migration
>>> right after starting it.
>> How does this test look like? I'm thinking that instead of writing a new
>> test for this bug (haven't read your patch 2 yet), what we need it to
>> remove the usage of migrate_wait_for_dirty_mem from the multifd cancel
>> test. I think that's an artificial delay that's there for no good reason
>> in this case. If your CI manages to hit the issue on a real-ish
>> scenario, that's even more reason to remove that code.
> This is old fashioned product testing over OpenStack cluster
> which specifically performing cancels in a row. Tests are run
> inside VMs inside the product and thus L0 host delays comes
> as a bit of fuzzing.
>

That is good to know because I was not sure whether this issue could
happen outside of migration-test.

> Tests are running non-stop inside development cycle :-)
>
> That is why I am coming with this or that problems on paths
> like that. But this is not very good in terms of QEMU level
> specific tests and that is why patch 2 comes with a pointing
> tests.
>
> NOTE: both your are my patches are fixed the problem as stated
> and the test passes without both your and my variants.
>
>>> Patch 2 adds a qtest for this window, which Peter left for later when
>>> fixing the early-cancel crash in 4f08b870f8 [1].
>>>
>>> [1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Fabiano Rosas <farosas@suse.de>
>>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Cc: Laurent Vivier <lvivier@redhat.com>
>>>
>>> Denis V. Lunev (2):
>>>   migration: fix source hang on cancel before the channel connects
>> Here's my version. It's very opinionated due to my long-standing grudge
>> with this code.
>> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency
>>
>> -- >8 --
>> From a27909503af9749f2cf6d8b901d675ee24c66d2c Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Wed, 25 Nov 2026 18:43:57 -0300
>> Subject: [PATCH 1/2] migration: Avoid early cancel causing a hang
>>
>> If migration is cancelled at just the right moment when the main
>> channel transport has finished connecting, it's possible that the
>> shutdown()s issued by migrate_cancel() miss the (unset) QEMUFiles
>> entirely. A moment later, migration_channel_connect_outgoing() carries
>> along with the migration and initializes the QEMUFiles for the first
>> time.
>>
>> Migration then hangs because the source goes into migration_cleanup()
>> due to its state being CANCELLING and hangs waiting for the return
>> path thread to join, which never happens because the destination is
>> unaware and never sends any SHUT message. The cleanup itself also
>> doesn't kick the RP thread because commit 64763e8ca61 ("migration:
>> Keep s->rp_state.from_dst_file open until migration ends") has changed
>> the code to keep the QEMUFile until after the RP thread exits. The
>> only other way to kick it would be from
>> stop_return_path_thread_on_source() if an error had occurred, but no
>> error has occurred.
>>
>> This situation is not surprising because the migration cancelling has
>> never had any synchronization mechanism aside from the BQL, which in
>> this case is not enough to protect from the race. It has also never
>> had a way to inform the rest of the code in a thread safe manner about
>> the cancellation.
>>
>> To start moving in the correct direction, make the qmp_migrate_cancel
>> command (under BQL) set the migration error, which is protected by the
>> error_mutex and suitable to be used as a way to inform the other
>> threads of the cancellation. This avoids the need to check the
>> MigrationStatus which is already fragile in terms of concurrency.
>>
>> Note that the QMP handler for migrate_cancel is used instead of the
>> internal function because the latter is used from other parts of the
>> code that might have set s->error already.
>>
>> In the case where qmp_migrate_cancel() sets s->error and some other
>> code hits an error due to the shutdown()s, the
>> migrate_error_propagate() call chain will simply ignore the error set
>> for last. This is the correct behavior because errors after cancelling
>> are very likely to be caused by the cancellation itself. This has the
>> extra benefit that the migration cancellation now shows up in the
>> logs, which solves a confusing situation when the user sees "Broken
>> pipe" and thinks it's due to an error.
>>
>> For this specific bug, check that the asynchronous entry to
>> migration_channel_connect_outgoing() doesn't bring an already set
>> s->error and call migration_connect_error_propagate() under the BQL if
>> that's the case. We need the whole migration_connect_error_propagate()
>> here to handle the postcopy resume case as well as making sure
>> migration_cleanup() is reached.
>>
>> Reproduced with /x86_64/migration/multifd+postcopy/tcp/plain/cancel
>> and my stress branch, which basically skips
>> migrate_wait_for_dirty_mem().
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/channel.c   | 5 +++++
>>  migration/migration.c | 8 ++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 1aeb8814858..12ff68fc38c 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -563,6 +563,11 @@ void migration_channel_connect_outgoing(MigrationSt=
ate *s, QIOChannel *ioc)
>>  {
>>      trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJEC=
T(ioc)));
>>=20=20
>> +    if (migrate_has_error(s)) {
>> +        migration_connect_error_propagate(s, error_copy(s->error));
>> +        return;
>> +    }
>> +
>>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>>          Error *local_err =3D NULL;
>>=20=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5686209ab11..40c3f21d520 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1890,6 +1890,8 @@ void qmp_migrate_incoming(const char *uri, bool ha=
s_channels,
>>          return;
>>      }
>>=20=20
>> +    migrate_error_free(migrate_get_current());
>> +
>>      if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
>>          return;
>>      }
>> @@ -2218,6 +2220,9 @@ out:
>>=20=20
>>  void qmp_migrate_cancel(Error **errp)
>>  {
>> +    MigrationState *s =3D migrate_get_current();
>> +    Error *local_err =3D NULL;
>> +
>>      /*
>>       * After postcopy migration has started, the source machine is not
>>       * recoverable in case of a migration error. This also means the
>> @@ -2229,6 +2234,9 @@ void qmp_migrate_cancel(Error **errp)
>>          return;
>>      }
>>=20=20
>> +    error_setg(&local_err, "Migration was cancelled by the user.");
>> +    migrate_error_propagate(s, local_err);
>> +
>>      migration_cancel();
>>  }
>>=20=20
> I have spend a bit of time trying to weight against the approaches
> and the only item I found is that "cancel" is actually not a error
> while we are reusing field as a error state.
>

That cat is out of the bag already since commit dc487044d5c ("migration:
Make migration_has_failed() work even for CANCELLING"). If
migration_has_failed() includes cancel states, then I think it's
actually a bug that migrate_cancel() doesn't set an error. Otherwise
code that calls migration_has_failed() will have to check
migrate_has_error() to find out if the "failure was an error". That's a
worse pattern in my opinion.

That's how I came up with this patch actually because I was trying to
avoid checking SETUP specifically, in case something else races and sets
another state in the mean time. As I mentioned briefly in the commit
message, the MigrationStatus is not thread-safe, that cmpxchg only
protects the migration event against a duplicated state change.

> Both are working. If you will take your one - pls consider
>
> Tested-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
>
> I would say - up to you :-)
>

Thank you. Let's see what Peter thinks about it.

> Regards,
> =C2=A0 =C2=A0 Den

