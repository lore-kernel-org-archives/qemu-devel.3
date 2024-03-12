Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBBCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6ru-0008KJ-LW; Tue, 12 Mar 2024 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk6rq-00082i-V7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:28:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk6ro-0007gR-Up
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:28:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B440421BC9;
 Tue, 12 Mar 2024 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710268125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XkesQrimYGVNWylNpSnpuudTj3YHaA2iSbURhkJR2Q=;
 b=WGslPVtmRKfDWcVt8wKRKVjgjGG0lYFdwrtHSt4kDRq9rSojj03eoayJ8IieCGYOam6xcA
 iPkv09qmACRPZdYfTSEgAacjPyGMrnxPGvh20/wE3Eli1vpnquIVLdwtm3YLiGaPM3K+WU
 WxHV/plMBYbD1AvHkCgbZO7/hXPQc/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710268125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XkesQrimYGVNWylNpSnpuudTj3YHaA2iSbURhkJR2Q=;
 b=O4qPFQXv6OaMUFdnQGiDOsIkwlm41QONqr+gkHmXRQy5LNuii1pLkSklz1BfxjR29nqXiz
 oyDMN8aAMVfczGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710268125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XkesQrimYGVNWylNpSnpuudTj3YHaA2iSbURhkJR2Q=;
 b=WGslPVtmRKfDWcVt8wKRKVjgjGG0lYFdwrtHSt4kDRq9rSojj03eoayJ8IieCGYOam6xcA
 iPkv09qmACRPZdYfTSEgAacjPyGMrnxPGvh20/wE3Eli1vpnquIVLdwtm3YLiGaPM3K+WU
 WxHV/plMBYbD1AvHkCgbZO7/hXPQc/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710268125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XkesQrimYGVNWylNpSnpuudTj3YHaA2iSbURhkJR2Q=;
 b=O4qPFQXv6OaMUFdnQGiDOsIkwlm41QONqr+gkHmXRQy5LNuii1pLkSklz1BfxjR29nqXiz
 oyDMN8aAMVfczGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EA1013795;
 Tue, 12 Mar 2024 18:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QpzdAd2e8GUwcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Mar 2024 18:28:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex
 Williamson <alex.williamson@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
In-Reply-To: <ZfByYiL3Gl9d9u7h@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n>
Date: Tue, 12 Mar 2024 15:28:42 -0300
Message-ID: <87wmq7l2xx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WGslPVtm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O4qPFQXv
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: B440421BC9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Mar 12, 2024 at 11:24:39AM -0300, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>> > On 3/12/24 14:34, C=C3=A9dric Le Goater wrote:
>> >> On 3/12/24 13:32, C=C3=A9dric Le Goater wrote:
>> >>> On 3/11/24 20:03, Fabiano Rosas wrote:
>> >>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>> >>>>
>> >>>>> On 3/8/24 15:36, Fabiano Rosas wrote:
>> >>>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>> >>>>>>
>> >>>>>>> This prepares ground for the changes coming next which add an Er=
ror**
>> >>>>>>> argument to the .save_setup() handler. Callers of qemu_savevm_st=
ate_setup()
>> >>>>>>> now handle the error and fail earlier setting the migration stat=
e from
>> >>>>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>> >>>>>>>
>> >>>>>>> In qemu_savevm_state(), move the cleanup to preserve the error
>> >>>>>>> reported by .save_setup() handlers.
>> >>>>>>>
>> >>>>>>> Since the previous behavior was to ignore errors at this step of
>> >>>>>>> migration, this change should be examined closely to check that
>> >>>>>>> cleanups are still correctly done.
>> >>>>>>>
>> >>>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>> >>>>>>> ---
>> >>>>>>>
>> >>>>>>> =C2=A0=C2=A0 Changes in v4:
>> >>>>>>> =C2=A0=C2=A0 - Merged cleanup change in qemu_savevm_state()
>> >>>>>>> =C2=A0=C2=A0 Changes in v3:
>> >>>>>>> =C2=A0=C2=A0 - Set migration state to MIGRATION_STATUS_FAILED
>> >>>>>>> =C2=A0=C2=A0 - Fixed error handling to be done under lock in bg_=
migration_thread()
>> >>>>>>> =C2=A0=C2=A0 - Made sure an error is always set in case of failu=
re in
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_savevm_state_setup()
>> >>>>>>> =C2=A0=C2=A0 migration/savevm.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> >>>>>>> =C2=A0=C2=A0 migration/migration.c | 27 ++++++++++++++++++++++++=
---
>> >>>>>>> =C2=A0=C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0 | 26 +++++++++=
++++++-----------
>> >>>>>>> =C2=A0=C2=A0 3 files changed, 40 insertions(+), 15 deletions(-)
>> >>>>>>>
>> >>>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>> >>>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42a=
ad621595f0ed58596c532328 100644
>> >>>>>>> --- a/migration/savevm.h
>> >>>>>>> +++ b/migration/savevm.h
>> >>>>>>> @@ -32,7 +32,7 @@
>> >>>>>>> =C2=A0=C2=A0 bool qemu_savevm_state_blocked(Error **errp);
>> >>>>>>> =C2=A0=C2=A0 void qemu_savevm_non_migratable_list(strList **reas=
ons);
>> >>>>>>> =C2=A0=C2=A0 int qemu_savevm_state_prepare(Error **errp);
>> >>>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>> >>>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>> >>>>>>> =C2=A0=C2=A0 bool qemu_savevm_state_guest_unplug_pending(void);
>> >>>>>>> =C2=A0=C2=A0 int qemu_savevm_state_resume_prepare(MigrationState=
 *s);
>> >>>>>>> =C2=A0=C2=A0 void qemu_savevm_state_header(QEMUFile *f);
>> >>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>> >>>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5ed=
fe56939a9c8395d88ef29581 100644
>> >>>>>>> --- a/migration/migration.c
>> >>>>>>> +++ b/migration/migration.c
>> >>>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t setup_start =3D qem=
u_clock_get_ms(QEMU_CLOCK_HOST);
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigThrError thr_error;
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool urgent =3D false;
>> >>>>>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> >>>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread =3D migration_thread=
s_add("live_migration", qemu_get_thread_id());
>> >>>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaqu=
e)
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_lock();
>> >>>>>>> -=C2=A0=C2=A0=C2=A0 qemu_savevm_state_setup(s->to_dst_file);
>> >>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D qemu_savevm_state_setup(s->to_dst_fi=
le, &local_err);
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>> >>>>>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate_set_error(s,=
 local_err);
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(local_err=
);
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate_set_state(&s=
->state, MIGRATION_STATUS_SETUP,
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 MIGRATION_STATUS_FAILED);
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >>>>>>> +
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_savevm_wait_unplug(s, =
MIGRATION_STATUS_SETUP,
>> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIGRATION_STAT=
US_ACTIVE);
>> >>>>>>
>> >>>>>> This^ should be before the new block it seems:
>> >>>>>>
>> >>>>>> GOOD:
>> >>>>>> migrate_set_state new state setup
>> >>>>>> migrate_set_state new state wait-unplug
>> >>>>>> migrate_fd_cancel
>> >>>>>> migrate_set_state new state cancelling
>> >>>>>> migrate_fd_cleanup
>> >>>>>> migrate_set_state new state cancelled
>> >>>>>> migrate_fd_cancel
>> >>>>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>> >>>>>>
>> >>>>>> BAD:
>> >>>>>> migrate_set_state new state setup
>> >>>>>> migrate_fd_cancel
>> >>>>>> migrate_set_state new state cancelling
>> >>>>>> migrate_fd_cleanup
>> >>>>>> migrate_set_state new state cancelled
>> >>>>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>> >>>>>> **
>> >>>>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abor=
t_wait_unplug:
>> >>>>>> assertion failed (status =3D=3D "cancelling"): ("cancelled" =3D=
=3D "cancelling")
>> >>>>>>
>> >>>>>> Otherwise migration_iteration_finish() will schedule the cleanup =
BH and
>> >>>>>> that will run concurrently with migrate_fd_cancel() issued by the=
 test
>> >>>>>> and bad things happens.
>> >>>>>
>> >>>>> This hack makes things work :
>> >>>>>
>> >>>>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_=
savevm_send_colo_enable(s->to_dst_file);
>> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >>>>> +=C2=A0=C2=A0=C2=A0 qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SE=
TUP,
>> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 MIGRATION_STATUS_SETUP);
>> >>>>> +
>> >>>>
>> >>>> Why move it all the way up here? Has moving the wait_unplug before =
the
>> >>>> 'if (ret)' block not worked for you?
>> >>>
>> >>> We could be sleeping while holding the BQL. It looked wrong.
>> >>=20
>> >> Sorry wrong answer. Yes I can try moving it before the 'if (ret)' blo=
ck.
>> >> I can reproduce easily with an x86 guest running on PPC64.
>> >
>> > That works just the same.
>> >
>> > Peter, Fabiano,
>> >
>> > What would you prefer  ?
>> >
>> > 1. move qemu_savevm_wait_unplug() before qemu_savevm_state_setup(),
>> >     means one new patch.
>>=20
>> Is there a point to this except "because we can"? Honest question, I
>> might have missed the motivation.
>
> My previous point was, it avoids holding the resources (that will be
> allocated in setup() routines) while we know we can wait for a long time.
>
> But then I found that the ordering is indeed needed at least if we don't
> change migrate_set_state() first - it is the only place we set the status
> to START (which I overlooked, sorry)...
>
> IMHO the function is not well designed; the state update of the next stage
> should not reside in a function to wait for failover primary devices
> conditionally. It's a bit of a mess.
>

I agree. We can clean that up in 9.1.

migrate_set_state is also unintuitive because it ignores invalid state
transitions and we've been using that property to deal with special
states such as POSTCOPY_PAUSED and FAILED:

- After the migration goes into POSTCOPY_PAUSED, the resumed migration's
  migrate_init() will try to set the state NONE->SETUP, which is not
  valid.

- After save_setup fails, the migration goes into FAILED, but wait_unplug
  will try to transition SETUP->ACTIVE, which is also not valid.


