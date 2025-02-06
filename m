Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD256C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg4K9-000803-Iv; Thu, 06 Feb 2025 11:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg4K3-0007zX-2t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:01:51 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg4K0-0000dz-1W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:01:46 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tg4Js-00000006yRd-2o3O; Thu, 06 Feb 2025 17:01:36 +0100
Message-ID: <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
Date: Thu, 6 Feb 2025 17:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
To: Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
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
 <87msezm75y.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87msezm75y.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 6.02.2025 16:20, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> On 6.02.2025 15:13, Fabiano Rosas wrote:
>>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>>
>>>> On 5.02.2025 21:42, Fabiano Rosas wrote:
>>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>>
>>>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>>>
>>>>>>> On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
>>>>>>>> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
>>>>>>>>> On 3.02.2025 23:56, Peter Xu wrote:
>>>>>>>>>> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
>>>>>>>>>>> On 3.02.2025 21:20, Peter Xu wrote:
>>>>>>>>>>>> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
>>>>>>>>>>>>> On 3.02.2025 19:20, Peter Xu wrote:
>>>>>>>>>>>>>> On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
>>>>>>>>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Multifd send channels are terminated by calling
>>>>>>>>>>>>>>> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>>>>>>>>>>>>>> multifd_send_terminate_threads(), which in the TLS case essentially
>>>>>>>>>>>>>>> calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Unfortunately, this does not terminate the TLS session properly and
>>>>>>>>>>>>>>> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The only reason why this wasn't causing migration failures is because
>>>>>>>>>>>>>>> the current migration code apparently does not check for migration
>>>>>>>>>>>>>>> error being set after the end of the multifd receive process.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> However, this will change soon so the multifd receive code has to be
>>>>>>>>>>>>>>> prepared to not return an error on such premature TLS session EOF.
>>>>>>>>>>>>>>> Use the newly introduced QIOChannelTLS method for that.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It's worth noting that even if the sender were to be changed to terminate
>>>>>>>>>>>>>>> the TLS connection properly the receive side still needs to remain
>>>>>>>>>>>>>>> compatible with older QEMU bit stream which does not do this.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If this is an existing bug, we could add a Fixes.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It is an existing issue but only uncovered by this patch set.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As far as I can see it was always there, so it would need some
>>>>>>>>>>>>> thought where to point that Fixes tag.
>>>>>>>>>>>>
>>>>>>>>>>>> If there's no way to trigger a real functional bug anyway, it's also ok we
>>>>>>>>>>>> omit the Fixes.
>>>>>>>>>>>>
>>>>>>>>>>>>>> Two pure questions..
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         - What is the correct way to terminate the TLS session without this flag?
>>>>>>>>>>>>>
>>>>>>>>>>>>> I guess one would need to call gnutls_bye() like in this GnuTLS example:
>>>>>>>>>>>>> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>>>>>>>>>>>>
>>>>>>>>>>>>>>         - Why this is only needed by multifd sessions?
>>>>>>>>>>>>>
>>>>>>>>>>>>> What uncovered the issue was switching the load threads to using
>>>>>>>>>>>>> migrate_set_error() instead of their own result variable
>>>>>>>>>>>>> (load_threads_ret) which you had requested during the previous
>>>>>>>>>>>>> patch set version review:
>>>>>>>>>>>>> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>>>>>>>>>>>>
>>>>>>>>>>>>> Turns out that the multifd receive code always returned
>>>>>>>>>>>>> error in the TLS case, just nothing was previously checking for
>>>>>>>>>>>>> that error presence.
>>>>>>>>>>>>
>>>>>>>>>>>> What I was curious is whether this issue also exists for the main migration
>>>>>>>>>>>> channel when with tls, especially when e.g. multifd not enabled at all.  As
>>>>>>>>>>>> I don't see anywhere that qemu uses gnutls_bye() for any tls session.
>>>>>>>>>>>>
>>>>>>>>>>>> I think it's a good to find that we overlooked this before.. and IMHO it's
>>>>>>>>>>>> always good we could fix this.
>>>>>>>>>>>>
>>>>>>>>>>>> Does it mean we need proper gnutls_bye() somewhere?
>>>>>>>>>>>>
>>>>>>>>>>>> If we need an explicit gnutls_bye(), then I wonder if that should be done
>>>>>>>>>>>> on the main channel as well.
>>>>>>>>>>>
>>>>>>>>>>> That's a good question and looking at the code qemu_loadvm_state_main() exits
>>>>>>>>>>> on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
>>>>>>>>>>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
>>>>>>>>>>> in qemu_loadvm_state() - so still not until channel EOF.
>>>>>>>>>>
>>>>>>>>>> I had a closer look, I do feel like such pre-mature termination is caused
>>>>>>>>>> by explicit shutdown()s of the iochannels, looks like that can cause issue
>>>>>>>>>> even after everything is sent.  Then I noticed indeed multifd sender
>>>>>>>>>> iochannels will get explicit shutdown()s since commit 077fbb5942, while we
>>>>>>>>>> don't do that for the main channel.  Maybe that is a major difference.
>>>>>>>>>>
>>>>>>>>>> Now I wonder whether we should shutdown() the channel at all if migration
>>>>>>>>>> succeeded, because looks like it can cause tls session to interrupt even if
>>>>>>>>>> the shutdown() is done after sent everything, and if so it'll explain why
>>>>>>>>>> you hit the issue with tls.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Then I can't see anything else reading the channel until it is closed in
>>>>>>>>>>> migration_incoming_state_destroy().
>>>>>>>>>>>
>>>>>>>>>>> So most likely the main migration channel will never read far enough to
>>>>>>>>>>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>>>>>
>>>>>>>>>>>> If we don't need gnutls_bye(), then should we always ignore pre-mature
>>>>>>>>>>>> termination of tls no matter if it's multifd or non-multifd channel (or
>>>>>>>>>>>> even a tls session that is not migration-related)?
>>>>>>>>>>>
>>>>>>>>>>> So basically have this patch extended to calling
>>>>>>>>>>> qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
>>>>>>>>>>
>>>>>>>>>> If above theory can stand, then eof-okay could be a workaround papering
>>>>>>>>>> over the real problem that we shouldn't always shutdown()..
>>>>>>>>>>
>>>>>>>>>> Could you have a look at below patch and see whether it can fix the problem
>>>>>>>>>> you hit too, in replace of these two patches (including the previous
>>>>>>>>>> iochannel change)?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Unfortunately, the patch below does not fix the problem:
>>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>>>>>>>>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>>>>>>>>>
>>>>>>>>> I think that, even in the absence of shutdown(), if the sender does not
>>>>>>>>> call gnutls_bye() the TLS session is considered improperly terminated.
>>>>>>>>
>>>>>>>> Ah..
>>>>>>>>
>>>>>>>> How about one more change on top of above change to disconnect properly for
>>>>>>>> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would that
>>>>>>>> make sense to you?
>>>>>>>
>>>>>>> Calling gnutls_bye from qio_channel_tls_close is not viable for the
>>>>>>> API contract of qio_channel_close. gnutls_bye needs to be able to
>>>>>>> perform I/O, which means we need to be able to tell the caller
>>>>>>> whether it needs to perform an event loop wait for POLLIN or POLLOUT.
>>>>>>>
>>>>>>> This is the same API design scenario as the gnutls_handshake method.
>>>>>>> As such I tdon't think it is practical to abstract it inside any
>>>>>>> existing QIOChannel API call, it'll have to be standalone like
>>>>>>> qio_channel_tls_handshake() is.
>>>>>>>
>>>>>>
>>>>>> I implemented the call to gnutls_bye:
>>>>>> https://gitlab.com/farosas/qemu/-/commits/migration-tls-bye
>>>>>>
>>>>>> Then while testing it I realised we actually have a regression from 9.2:
>>>>>>
>>>>>> 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
>>>>>>
>>>>>> It seems that patch somehow affected the ordering between src shutdown
>>>>>> vs. recv shutdown and now the recv channels are staying around to see
>>>>>> the connection being broken. Or something... I'm still looking into it.
>>>>>>
>>>>>
>>>>> Ok, so the issue is that the recv side would previously be stuck at the
>>>>> sync semaphore and multifd_recv_terminate_threads() would kick it only
>>>>> after 'exiting' was set, so no further recv() would happen.
>>>>>
>>>>> After the patch, there's no final sync anymore, so the recv thread loops
>>>>> around and waits at the recv() until multifd_send_terminate_threads()
>>>>> closes the connection.
>>>>>
>>>>> Waiting on sem_sync as before would lead to a cleaner termination
>>>>> process IMO, but I don't think it's worth the extra complexity of
>>>>> introducing a sync to the device state migration.
>>>>>
>>>>> So I think we'll have to go with one of the approaches suggested on this
>>>>> thread (gnutls_bye or premature_ok). I'm fine either way, but let's make
>>>>> sure we add a reference to the patch above and some words explaining the
>>>>> situation.
>>>>
>>>> We still need premature_ok for handling older QEMU versions that do not
>>>> terminate the TLS stream correctly since the TLS test regression happens
>>>> even without device state transfer being enabled.
>>>
>>> What exactly is the impact of this issue to the device state series?
>>>   From the cover letter:
>>>
>>>     * qemu_loadvm_load_thread_pool now reports error via migrate_set_error()
>>>     instead of dedicated load_threads_ret variable.
>>>
>>>     * Since the change above uncovered an issue with respect to multifd send
>>>     channels not terminating TLS session properly QIOChannelTLS now allows
>>>     gracefully handling this situation.
>>>
>>> I understand qemu_loadvm_load_thread_pool() is attempting to use
>>> migrate_set_error() but an error is already set by the recv_thread. Is
>>> that the issue?
>>
>> Yes, when we test for load threads error in the TLS case we see that multifd TLS
>> one.
>> We need to know whether the load threads succeeded so we either continue with the
>> migration or abort it.
>>
>>> I wonder if we could isolate somehow this so it doesn't
>>> impact this series.
>>
>> The previous version simply used a dedicated load_threads_ret variable
>> so it wasn't affected but Peter likes migrate_set_error() more for
>> migration thread pools.
>>    
>>>>
>>>> So I think that's what we should use generally.
>>>>     
>>>
>>> For premature_ok, we need to make sure it will not hang QEMU if the
>>> connection gets unexpectedly closed. The current code checks for
>>> shutdown() having already happened, which is fine because it means we're
>>> already on the way out. However, if any ol' recv() can now ignore a
>>> premature termination error, then the recv_thread will not trigger
>>> cleanup of the multifd_recv threads.
>>
>> Enabling premature_ok just turns GNUTLS_E_PREMATURE_TERMINATION error
>> on EOF into a normal EOF.
>>
>> The receive thread will exit on either one:
>>>            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>>>                  break;
>>>              }
>>
>> It's true that multifd_recv_terminate_threads() will only be called
>> by multifd_recv_cleanup() or multifd_recv_shutdown() in this case,
>> however this is already the case for non-TLS migration.
>>
> 
> My point is that a premature termination sets local_err and a
> premature_ok==true doesn't. 

* Only in the TLS case - the non-TLS doesn't set any error even with
premature_ok==true (assuming there hasn't been any other error during
receive)

* If there *has* been other any other error during receive then it
will be set and the code flow will be the same even with premature_ok==true.

> So it's not the same as non-TLS migration
> because there we don't have a way to ignore any errors.

The GNUTLS_E_PREMATURE_TERMINATION error can't happen in the non-TLS case
so by definition we can't ignore it in the non-TLS case.

And we don't ignore any other error in the TLS/non-TLS case.

> Multifd recv threads can't discern an EOF in the middle of the migration
> from an EOF after all data has been received. The former is definitely
> an error and should cause migration to abort, multifd threads to
> cleanup, etc.

So in this case we should set the QIO_CHANNEL_READ_RELAXED_EOF flag on
the multifd channel recv thread main loop only, and leave the
mid-stream page receive methods report GNUTLS_E_PREMATURE_TERMINATION
as usual.

This makes the TLS case work the same with respect to premature
EOF as the non-TLS case since the non-TLS case can't detect premature
EOF in the multifd channel recv thread main loop either.

>> So if there was a bug with multifd threads shutdown it would have
>> already been manifesting on the non-TLS migration.
>>
> 
> Even if non-TLS behaved the same, why would we choose to port a bug to
> the TLS implementation?
> 
> We could of course decide at this point to punt the problem forward and
> when it shows up, we'd have to go implement gnutls_bye() to allow the
> distinction between good-EOF/bad-EOF or maybe add an extra sync at the
> end of migration to make sure the last recv() call is only started after
> the source has already shutdown() the channel.

If we do some kind of a premature EOF detection then it should probably
work for the non-TLS case too (since that's probably by far the most
common use case).
So adding some MULTIFD_FLAG_EOS would make the most sense and would work
even with QIO_CHANNEL_READ_RELAXED_EOF being set.

In any case we'd still need some kind of a compatibility behavior for
the TLS bit stream emitted by older QEMU versions (which is always
improperly terminated).

Thanks,
Maciej


