Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE1AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3gG-0007QL-Ii; Thu, 06 Feb 2025 10:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg3gE-0007Pq-9L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:20:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg3gB-0004oY-Lw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:20:38 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA85F1F381;
 Thu,  6 Feb 2025 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738855229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U0IABYa76IDfTsYEy8uFdhNmRnj8HvjJHNu4k3Vtqk=;
 b=ueaubsTl5Wdd/7OaXUEB58JKwEmGXne+BIeDHJXGEGL5zMRfUZ2dLF/BrBBn6op3gJlmmx
 rq/b+ZffNqZj4DjbdwGlod832X+DGTq8hDvi1FLt5YDHI2Fgmg17uHFl8JuAOdI8YiWkfL
 mv/ZHYWblv95pP2Gj3F/y9KHHb3gTf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738855229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U0IABYa76IDfTsYEy8uFdhNmRnj8HvjJHNu4k3Vtqk=;
 b=JCHuSP7mBCXJeXsmMLhKOegr6UUjT7Wg3/sV+wokw99V2g28NRq/qfLjKeW19s/Ubdz9I7
 whXas6XYu5KH/nBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738855229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U0IABYa76IDfTsYEy8uFdhNmRnj8HvjJHNu4k3Vtqk=;
 b=ueaubsTl5Wdd/7OaXUEB58JKwEmGXne+BIeDHJXGEGL5zMRfUZ2dLF/BrBBn6op3gJlmmx
 rq/b+ZffNqZj4DjbdwGlod832X+DGTq8hDvi1FLt5YDHI2Fgmg17uHFl8JuAOdI8YiWkfL
 mv/ZHYWblv95pP2Gj3F/y9KHHb3gTf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738855229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U0IABYa76IDfTsYEy8uFdhNmRnj8HvjJHNu4k3Vtqk=;
 b=JCHuSP7mBCXJeXsmMLhKOegr6UUjT7Wg3/sV+wokw99V2g28NRq/qfLjKeW19s/Ubdz9I7
 whXas6XYu5KH/nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 279DF13694;
 Thu,  6 Feb 2025 15:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rj+bNTzTpGdhNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 15:20:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?Daniel_P=2E_Be?=
 =?utf-8?Q?rrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <Z6Iy0wY-lsx3M71M@x1.local> <Z6I0mzWEsl5y57Zj@redhat.com>
 <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
 <192db6a6-f3ff-4cf9-8537-b849fb3a97b3@maciej.szmigiero.name>
 <87tt97ma9l.fsf@suse.de>
 <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
Date: Thu, 06 Feb 2025 12:20:25 -0300
Message-ID: <87msezm75y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 6.02.2025 15:13, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>=20
>>> On 5.02.2025 21:42, Fabiano Rosas wrote:
>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>
>>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>>
>>>>>> On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
>>>>>>> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
>>>>>>>> On 3.02.2025 23:56, Peter Xu wrote:
>>>>>>>>> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wro=
te:
>>>>>>>>>> On 3.02.2025 21:20, Peter Xu wrote:
>>>>>>>>>>> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero w=
rote:
>>>>>>>>>>>> On 3.02.2025 19:20, Peter Xu wrote:
>>>>>>>>>>>>> On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero=
 wrote:
>>>>>>>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Multifd send channels are terminated by calling
>>>>>>>>>>>>>> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>>>>>>>>>>>>> multifd_send_terminate_threads(), which in the TLS case esse=
ntially
>>>>>>>>>>>>>> calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Unfortunately, this does not terminate the TLS session prope=
rly and
>>>>>>>>>>>>>> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATI=
ON error.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The only reason why this wasn't causing migration failures i=
s because
>>>>>>>>>>>>>> the current migration code apparently does not check for mig=
ration
>>>>>>>>>>>>>> error being set after the end of the multifd receive process.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, this will change soon so the multifd receive code h=
as to be
>>>>>>>>>>>>>> prepared to not return an error on such premature TLS sessio=
n EOF.
>>>>>>>>>>>>>> Use the newly introduced QIOChannelTLS method for that.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It's worth noting that even if the sender were to be changed=
 to terminate
>>>>>>>>>>>>>> the TLS connection properly the receive side still needs to =
remain
>>>>>>>>>>>>>> compatible with older QEMU bit stream which does not do this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If this is an existing bug, we could add a Fixes.
>>>>>>>>>>>>
>>>>>>>>>>>> It is an existing issue but only uncovered by this patch set.
>>>>>>>>>>>>
>>>>>>>>>>>> As far as I can see it was always there, so it would need some
>>>>>>>>>>>> thought where to point that Fixes tag.
>>>>>>>>>>>
>>>>>>>>>>> If there's no way to trigger a real functional bug anyway, it's=
 also ok we
>>>>>>>>>>> omit the Fixes.
>>>>>>>>>>>
>>>>>>>>>>>>> Two pure questions..
>>>>>>>>>>>>>
>>>>>>>>>>>>>        - What is the correct way to terminate the TLS session=
 without this flag?
>>>>>>>>>>>>
>>>>>>>>>>>> I guess one would need to call gnutls_bye() like in this GnuTL=
S example:
>>>>>>>>>>>> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb3=
2e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>>>>>>>>>>>
>>>>>>>>>>>>>        - Why this is only needed by multifd sessions?
>>>>>>>>>>>>
>>>>>>>>>>>> What uncovered the issue was switching the load threads to usi=
ng
>>>>>>>>>>>> migrate_set_error() instead of their own result variable
>>>>>>>>>>>> (load_threads_ret) which you had requested during the previous
>>>>>>>>>>>> patch set version review:
>>>>>>>>>>>> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>>>>>>>>>>>
>>>>>>>>>>>> Turns out that the multifd receive code always returned
>>>>>>>>>>>> error in the TLS case, just nothing was previously checking for
>>>>>>>>>>>> that error presence.
>>>>>>>>>>>
>>>>>>>>>>> What I was curious is whether this issue also exists for the ma=
in migration
>>>>>>>>>>> channel when with tls, especially when e.g. multifd not enabled=
 at all.  As
>>>>>>>>>>> I don't see anywhere that qemu uses gnutls_bye() for any tls se=
ssion.
>>>>>>>>>>>
>>>>>>>>>>> I think it's a good to find that we overlooked this before.. an=
d IMHO it's
>>>>>>>>>>> always good we could fix this.
>>>>>>>>>>>
>>>>>>>>>>> Does it mean we need proper gnutls_bye() somewhere?
>>>>>>>>>>>
>>>>>>>>>>> If we need an explicit gnutls_bye(), then I wonder if that shou=
ld be done
>>>>>>>>>>> on the main channel as well.
>>>>>>>>>>
>>>>>>>>>> That's a good question and looking at the code qemu_loadvm_state=
_main() exits
>>>>>>>>>> on receiving "QEMU_VM_EOF" section (that's different from receiv=
ing socket EOF)
>>>>>>>>>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with=
 explicit size
>>>>>>>>>> in qemu_loadvm_state() - so still not until channel EOF.
>>>>>>>>>
>>>>>>>>> I had a closer look, I do feel like such pre-mature termination i=
s caused
>>>>>>>>> by explicit shutdown()s of the iochannels, looks like that can ca=
use issue
>>>>>>>>> even after everything is sent.  Then I noticed indeed multifd sen=
der
>>>>>>>>> iochannels will get explicit shutdown()s since commit 077fbb5942,=
 while we
>>>>>>>>> don't do that for the main channel.  Maybe that is a major differ=
ence.
>>>>>>>>>
>>>>>>>>> Now I wonder whether we should shutdown() the channel at all if m=
igration
>>>>>>>>> succeeded, because looks like it can cause tls session to interru=
pt even if
>>>>>>>>> the shutdown() is done after sent everything, and if so it'll exp=
lain why
>>>>>>>>> you hit the issue with tls.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Then I can't see anything else reading the channel until it is c=
losed in
>>>>>>>>>> migration_incoming_state_destroy().
>>>>>>>>>>
>>>>>>>>>> So most likely the main migration channel will never read far en=
ough to
>>>>>>>>>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>>>>
>>>>>>>>>>> If we don't need gnutls_bye(), then should we always ignore pre=
-mature
>>>>>>>>>>> termination of tls no matter if it's multifd or non-multifd cha=
nnel (or
>>>>>>>>>>> even a tls session that is not migration-related)?
>>>>>>>>>>
>>>>>>>>>> So basically have this patch extended to calling
>>>>>>>>>> qio_channel_tls_set_premature_eof_okay() also on the main migrat=
ion channel?
>>>>>>>>>
>>>>>>>>> If above theory can stand, then eof-okay could be a workaround pa=
pering
>>>>>>>>> over the real problem that we shouldn't always shutdown()..
>>>>>>>>>
>>>>>>>>> Could you have a look at below patch and see whether it can fix t=
he problem
>>>>>>>>> you hit too, in replace of these two patches (including the previ=
ous
>>>>>>>>> iochannel change)?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Unfortunately, the patch below does not fix the problem:
>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connect=
ion was non-properly terminated.
>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connect=
ion was non-properly terminated.
>>>>>>>>
>>>>>>>> I think that, even in the absence of shutdown(), if the sender doe=
s not
>>>>>>>> call gnutls_bye() the TLS session is considered improperly termina=
ted.
>>>>>>>
>>>>>>> Ah..
>>>>>>>
>>>>>>> How about one more change on top of above change to disconnect prop=
erly for
>>>>>>> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would=
 that
>>>>>>> make sense to you?
>>>>>>
>>>>>> Calling gnutls_bye from qio_channel_tls_close is not viable for the
>>>>>> API contract of qio_channel_close. gnutls_bye needs to be able to
>>>>>> perform I/O, which means we need to be able to tell the caller
>>>>>> whether it needs to perform an event loop wait for POLLIN or POLLOUT.
>>>>>>
>>>>>> This is the same API design scenario as the gnutls_handshake method.
>>>>>> As such I tdon't think it is practical to abstract it inside any
>>>>>> existing QIOChannel API call, it'll have to be standalone like
>>>>>> qio_channel_tls_handshake() is.
>>>>>>
>>>>>
>>>>> I implemented the call to gnutls_bye:
>>>>> https://gitlab.com/farosas/qemu/-/commits/migration-tls-bye
>>>>>
>>>>> Then while testing it I realised we actually have a regression from 9=
.2:
>>>>>
>>>>> 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
>>>>>
>>>>> It seems that patch somehow affected the ordering between src shutdown
>>>>> vs. recv shutdown and now the recv channels are staying around to see
>>>>> the connection being broken. Or something... I'm still looking into i=
t.
>>>>>
>>>>
>>>> Ok, so the issue is that the recv side would previously be stuck at the
>>>> sync semaphore and multifd_recv_terminate_threads() would kick it only
>>>> after 'exiting' was set, so no further recv() would happen.
>>>>
>>>> After the patch, there's no final sync anymore, so the recv thread loo=
ps
>>>> around and waits at the recv() until multifd_send_terminate_threads()
>>>> closes the connection.
>>>>
>>>> Waiting on sem_sync as before would lead to a cleaner termination
>>>> process IMO, but I don't think it's worth the extra complexity of
>>>> introducing a sync to the device state migration.
>>>>
>>>> So I think we'll have to go with one of the approaches suggested on th=
is
>>>> thread (gnutls_bye or premature_ok). I'm fine either way, but let's ma=
ke
>>>> sure we add a reference to the patch above and some words explaining t=
he
>>>> situation.
>>>
>>> We still need premature_ok for handling older QEMU versions that do not
>>> terminate the TLS stream correctly since the TLS test regression happens
>>> even without device state transfer being enabled.
>>=20
>> What exactly is the impact of this issue to the device state series?
>>  From the cover letter:
>>=20
>>    * qemu_loadvm_load_thread_pool now reports error via migrate_set_erro=
r()
>>    instead of dedicated load_threads_ret variable.
>>=20
>>    * Since the change above uncovered an issue with respect to multifd s=
end
>>    channels not terminating TLS session properly QIOChannelTLS now allows
>>    gracefully handling this situation.
>>=20
>> I understand qemu_loadvm_load_thread_pool() is attempting to use
>> migrate_set_error() but an error is already set by the recv_thread. Is
>> that the issue?=20
>
> Yes, when we test for load threads error in the TLS case we see that mult=
ifd TLS
> one.
> We need to know whether the load threads succeeded so we either continue =
with the
> migration or abort it.
>
>> I wonder if we could isolate somehow this so it doesn't
>> impact this series.
>
> The previous version simply used a dedicated load_threads_ret variable
> so it wasn't affected but Peter likes migrate_set_error() more for
> migration thread pools.
>=20=20=20
>>>
>>> So I think that's what we should use generally.
>>>=20=20=20=20
>>=20
>> For premature_ok, we need to make sure it will not hang QEMU if the
>> connection gets unexpectedly closed. The current code checks for
>> shutdown() having already happened, which is fine because it means we're
>> already on the way out. However, if any ol' recv() can now ignore a
>> premature termination error, then the recv_thread will not trigger
>> cleanup of the multifd_recv threads.
>
> Enabling premature_ok just turns GNUTLS_E_PREMATURE_TERMINATION error
> on EOF into a normal EOF.
>
> The receive thread will exit on either one:
>>           if (ret =3D=3D 0 || ret =3D=3D -1) {   /* 0: EOF  -1: Error */
>>                 break;
>>             }
>
> It's true that multifd_recv_terminate_threads() will only be called
> by multifd_recv_cleanup() or multifd_recv_shutdown() in this case,
> however this is already the case for non-TLS migration.
>

My point is that a premature termination sets local_err and a
premature_ok=3D=3Dtrue doesn't. So it's not the same as non-TLS migration
because there we don't have a way to ignore any errors.

Multifd recv threads can't discern an EOF in the middle of the migration
from an EOF after all data has been received. The former is definitely
an error and should cause migration to abort, multifd threads to
cleanup, etc.

> So if there was a bug with multifd threads shutdown it would have
> already been manifesting on the non-TLS migration.
>

Even if non-TLS behaved the same, why would we choose to port a bug to
the TLS implementation?

We could of course decide at this point to punt the problem forward and
when it shows up, we'd have to go implement gnutls_bye() to allow the
distinction between good-EOF/bad-EOF or maybe add an extra sync at the
end of migration to make sure the last recv() call is only started after
the source has already shutdown() the channel.

> Also, to be clear, I'm not advocating for removing that shutdown()
> call.

Yes, I think we should keep it.


