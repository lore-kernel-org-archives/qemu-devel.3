Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0620AC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYwy-0006AJ-Mj; Thu, 01 Feb 2024 10:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVYwx-000675-9i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:25:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVYwu-0006li-K2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706801155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXl+iL19eRxe8xDssVG3AubY0vIJ7qGVX6PNqJ6aHJo=;
 b=eiQezIw6tKtUpVJSWk/O217QHUc8q9IGU5Fz6ezt0XQfCp4Gb4wZrceapyheUx0R4urkBa
 Npuu1Xupuw8IVID8O6B6j8LHvh7Jf4dhdWiF8D6Ux0vvnttvsJioUp18I57+m0hlRtFSYr
 soa/dzQkqCQ4xsUy4vWvQnqWmnXsgzM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-3vqIxK6CM1aqpmE3lwbmEw-1; Thu, 01 Feb 2024 10:25:53 -0500
X-MC-Unique: 3vqIxK6CM1aqpmE3lwbmEw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b1b431b3cso102695f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706801153; x=1707405953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nXl+iL19eRxe8xDssVG3AubY0vIJ7qGVX6PNqJ6aHJo=;
 b=bKh8q7RCmTwU4MQnK18ANqlT5cZfGMDS7T80l8gjGeKbjF4UzCFGsaNwhDOwKtONBn
 lmAgnQeVCO9cFUdROhb55QGwZfyGfAHzz0OyEkFf7xDzpbJr1DPqfPHDlivbZBQyy962
 wiek5i3bGyNuVnRdVaAFBiUAluum5mFTJ2P6JkTvVjTWdeH6XrlnenwGRNs/1mZJm8DY
 /qlimC3K/ULGTsVxUsny3Mm48Zz1YS8WIYiNRfpJJBvUnEFxMVAWK68RuhZAHyfOtEXT
 ucvZWPLUZS9Dv2PJWRh/BGIQFrToS7FNpEOqvgQMRUMbKkxfZP/H/zKcX2dI9IJ/UAse
 HjXg==
X-Gm-Message-State: AOJu0YyACX5bR8C0UZv7XXoZMejJvd6vh7ALBhHau6AkiGr9a5vXyHeb
 XO2rz53lMhZlh2qtlWSTwHdUbqmtxOLcAsCIoN0jZ7rC35LV3faoNMle3uarBcvromlTibPbv+T
 MrN/1sLw5utoaejX9IeJhPmfrVrqYPR5rrObMMq067aPJOESMZSNE
X-Received: by 2002:a5d:698d:0:b0:33a:f3a5:37d1 with SMTP id
 g13-20020a5d698d000000b0033af3a537d1mr3150487wru.29.1706801152614; 
 Thu, 01 Feb 2024 07:25:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhguLNDURCawv5iGJWF893HZYNomO9+CEeJWxvqi3ZSeV2QepfNMF/o82qMJdjXqzd0/Azow==
X-Received: by 2002:a5d:698d:0:b0:33a:f3a5:37d1 with SMTP id
 g13-20020a5d698d000000b0033af3a537d1mr3150473wru.29.1706801152103; 
 Thu, 01 Feb 2024 07:25:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWGHOhLoef9far551Cg+jLuXmVH5dBwrshE+V3j/Cc+6yH52nc/+qjxcB1SfsT6MhJE1EK94wZuzV9yktJhRJfOp5ZX7kHL4SoWOL+H+t41D9z9W43FL6QqbysVYg==
Received: from ?IPV6:2003:cf:d73b:4144:8f0d:1c55:f035:1a2b?
 (p200300cfd73b41448f0d1c55f0351a2b.dip0.t-ipconnect.de.
 [2003:cf:d73b:4144:8f0d:1c55:f035:1a2b])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c4eca00b0040fbba734f3sm2152232wmq.34.2024.02.01.07.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 07:25:51 -0800 (PST)
Message-ID: <6cb18310-c0cf-4747-a71d-540adba262cf@redhat.com>
Date: Thu, 1 Feb 2024 16:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
 <ZbOxI9Ar-YDn51Z0@redhat.com>
 <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
 <20240131203537.GC396296@fedora>
 <0a3e8d2a-add1-432b-b6b9-456ee0b17882@redhat.com>
 <20240201142817.GA516672@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240201142817.GA516672@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.02.24 15:28, Stefan Hajnoczi wrote:
> On Thu, Feb 01, 2024 at 03:10:12PM +0100, Hanna Czenczek wrote:
>> On 31.01.24 21:35, Stefan Hajnoczi wrote:
>>> On Fri, Jan 26, 2024 at 04:24:49PM +0100, Hanna Czenczek wrote:
>>>> On 26.01.24 14:18, Kevin Wolf wrote:
>>>>> Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
>>>>>> On 23.01.24 18:10, Kevin Wolf wrote:
>>>>>>> Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
>>>>>>>> On 21.12.23 22:23, Kevin Wolf wrote:
>>>>>>>>> From: Stefan Hajnoczi<stefanha@redhat.com>
>>>>>>>>>
>>>>>>>>> Stop depending on the AioContext lock and instead access
>>>>>>>>> SCSIDevice->requests from only one thread at a time:
>>>>>>>>> - When the VM is running only the BlockBackend's AioContext may access
>>>>>>>>>        the requests list.
>>>>>>>>> - When the VM is stopped only the main loop may access the requests
>>>>>>>>>        list.
>>>>>>>>>
>>>>>>>>> These constraints protect the requests list without the need for locking
>>>>>>>>> in the I/O code path.
>>>>>>>>>
>>>>>>>>> Note that multiple IOThreads are not supported yet because the code
>>>>>>>>> assumes all SCSIRequests are executed from a single AioContext. Leave
>>>>>>>>> that as future work.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>>>>>>>>> Reviewed-by: Eric Blake<eblake@redhat.com>
>>>>>>>>> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
>>>>>>>>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>>>>>>>>> ---
>>>>>>>>>       include/hw/scsi/scsi.h |   7 +-
>>>>>>>>>       hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>>>>>>>>>       2 files changed, 131 insertions(+), 57 deletions(-)
>>>>>>>> My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now breaks more
>>>>>>>> often because of this commit than because of the original bug, i.e. when
>>>>>>>> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
>>>>>>>> this tends to happen when unplugging the scsi-hd:
>>>> Note: We (on issues.redhat.com) have a separate report that seems to be
>>>> concerning this very problem: https://issues.redhat.com/browse/RHEL-19381
>>>>
>>>>>>>> {"execute":"device_del","arguments":{"id":"stg0"}}
>>>>>>>> {"return": {}}
>>>>>>>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>>>>>>>> Assertion `ctx == blk->ctx' failed.
>>>>>> [...]
>>>>>>
>>>>>>>> I don’t know anything about the problem yet, but as usual, I like
>>>>>>>> speculation and discovering how wrong I was later on, so one thing I came
>>>>>>>> across that’s funny about virtio-scsi is that requests can happen even while
>>>>>>>> a disk is being attached or detached.  That is, Linux seems to probe all
>>>>>>>> LUNs when a new virtio-scsi device is being attached, and it won’t stop just
>>>>>>>> because a disk is being attached or removed.  So maybe that’s part of the
>>>>>>>> problem, that we get a request while the BB is being detached, and
>>>>>>>> temporarily in an inconsistent state (BDS context differs from BB context).
>>>>>>> I don't know anything about the problem either, but since you already
>>>>>>> speculated about the cause, let me speculate about the solution:
>>>>>>> Can we hold the graph writer lock for the tran_commit() call in
>>>>>>> bdrv_try_change_aio_context()? And of course take the reader lock for
>>>>>>> blk_get_aio_context(), but that should be completely unproblematic.
>>>>>> Actually, now that completely unproblematic part is giving me trouble.  I
>>>>>> wanted to just put a graph lock into blk_get_aio_context() (making it a
>>>>>> coroutine with a wrapper)
>>>>> Which is the first thing I neglected and already not great. We have
>>>>> calls of blk_get_aio_context() in the SCSI I/O path, and creating a
>>>>> coroutine and doing at least two context switches simply for this call
>>>>> is a lot of overhead...
>>>>>
>>>>>> but callers of blk_get_aio_context() generally assume the context is
>>>>>> going to stay the BB’s context for as long as their AioContext *
>>>>>> variable is in scope.
>>>>> I'm not so sure about that. And taking another step back, I'm actually
>>>>> also not sure how much it still matters now that they can submit I/O
>>>>> from any thread.
>>>> That’s my impression, too, but “not sure” doesn’t feel great. :)
>>>> scsi_device_for_each_req_async_bh() specifically double-checks whether it’s
>>>> still in the right context before invoking the specified function, so it
>>>> seems there was some intention to continue to run in the context associated
>>>> with the BB.
>>>>
>>>> (Not judging whether that intent makes sense or not, yet.)
>>>>
>>>>> Maybe the correct solution is to remove the assertion from
>>>>> blk_get_aio_context() and just always return blk->ctx. If it's in the
>>>>> middle of a change, you'll either get the old one or the new one. Either
>>>>> one is fine to submit I/O from, and if you care about changes for other
>>>>> reasons (like SCSI does), then you need explicit code to protect it
>>>>> anyway (which SCSI apparently has, but it doesn't work).
>>>> I think most callers do just assume the BB stays in the context they got
>>>> (without any proof, admittedly), but I agree that under re-evaluation, it
>>>> probably doesn’t actually matter to them, really. And yes, basically, if the
>>>> caller doesn’t need to take a lock because it doesn’t really matter whether
>>>> blk->ctx changes while its still using the old value, blk_get_aio_context()
>>>> in turn doesn’t need to double-check blk->ctx against the root node’s
>>>> context either, and nobody needs a lock.
>>>>
>>>> So I agree, it’s on the caller to protect against a potentially changing
>>>> context, blk_get_aio_context() should just return blk->ctx and not check
>>>> against the root node.
>>>>
>>>> (On a tangent: blk_drain() is a caller of blk_get_aio_context(), and it
>>>> polls that context.  Why does it need to poll that context specifically when
>>>> requests may be in any context?  Is it because if there are requests in the
>>>> main thread, we must poll that, but otherwise it’s fine to poll any thread,
>>>> and we can only have requests in the main thread if that’s the BB’s
>>>> context?)
>>>>
>>>>>> I was tempted to think callers know what happens to the BB they pass
>>>>>> to blk_get_aio_context(), and it won’t change contexts so easily, but
>>>>>> then I remembered this is exactly what happens in this case; we run
>>>>>> scsi_device_for_each_req_async_bh() in one thread (which calls
>>>>>> blk_get_aio_context()), and in the other, we change the BB’s context.
>>>>> Let's think a bit more about scsi_device_for_each_req_async()
>>>>> specifically. This is a function that runs in the main thread. Nothing
>>>>> will change any AioContext assignment if it doesn't call it. It wants to
>>>>> make sure that scsi_device_for_each_req_async_bh() is called in the
>>>>> same AioContext where the virtqueue is processed, so it schedules a BH
>>>>> and waits for it.
>>>> I don’t quite follow, it doesn’t wait for the BH.  It uses
>>>> aio_bh_schedule_oneshot(), not aio_wait_bh_oneshot().  While you’re right
>>>> that if it did wait, the BB context might still change, in practice we
>>>> wouldn’t have the problem at hand because the caller is actually the one to
>>>> change the context, concurrently while the BH is running.
>>>>
>>>>> Waiting for it means running a nested event loop that could do anything,
>>>>> including changing AioContexts. So this is what needs the locking, not
>>>>> the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
>>>>> If we lock before the nested event loop and unlock in the BH, the check
>>>>> in the BH can become an assertion. (It is important that we unlock in
>>>>> the BH rather than after waiting because if something takes the writer
>>>>> lock, we need to unlock during the nested event loop of bdrv_wrlock() to
>>>>> avoid a deadlock.)
>>>>>
>>>>> And spawning a coroutine for this looks a lot more acceptable because
>>>>> it's on a slow path anyway.
>>>>>
>>>>> In fact, we probably don't technically need a coroutine to take the
>>>>> reader lock here. We can have a new graph lock function that asserts
>>>>> that there is no writer (we know because we're running in the main loop)
>>>>> and then atomically increments the reader count. But maybe that already
>>>>> complicates things again...
>>>> So as far as I understand we can’t just use aio_wait_bh_oneshot() and wrap
>>>> it in bdrv_graph_rd{,un}lock_main_loop(), because that doesn’t actually lock
>>>> the graph.  I feel like adding a new graph lock function for this quite
>>>> highly specific case could be dangerous, because it seems easy to use the
>>>> wrong way.
>>>>
>>>> Just having a trampoline coroutine to call bdrv_graph_co_rd{,un}lock() seems
>>>> simple enough and reasonable here (not a hot path).  Can we have that
>>>> coroutine then use aio_wait_bh_oneshot() with the existing _bh function, or
>>>> should that be made a coroutine, too?
>>> There is a reason for running in the context associated with the BB: the
>>> virtio-scsi code assumes all request processing happens in the BB's
>>> AioContext. The SCSI request list and other SCSI emulation code is not
>>> thread-safe!
>> One peculiarity about virtio-scsi, as far as I understand, is that its
>> context is not necessarily the BB’s context, because one virtio-scsi device
>> may have many BBs.  While the BBs are being hot-plugged or un-plugged, their
>> context may change (as is happening here), but that doesn’t stop SCSI
>> request processing, because SCSI requests happen independently of whether
>> there are devices on the SCSI bus.
>>
>> If SCSI request processing is not thread-safe, doesn’t that mean it always
>> must be done in the very same context, i.e. the context the virtio-scsi
>> device was configured to use?  Just because a new scsi-hd BB is added or
>> removed, and so we temporarily have a main context BB associated with the
>> virtio-scsi device, I don’t think we should switch to processing requests in
>> the main context.
> This case is not supposed to happen because virtio_scsi_hotplug()
> immediately places the BB into the virtio-scsi device's AioContext by
> calling blk_set_aio_context().
>
> The AioContext invariant is checked at several points in the SCSI
> request lifecycle by this function:
>
>    static inline void virtio_scsi_ctx_check(VirtIOSCSI *s, SCSIDevice *d)
>    {
>        if (s->dataplane_started && d && blk_is_available(d->conf.blk)) {
>            assert(blk_get_aio_context(d->conf.blk) == s->ctx);
>        }
>    }

Yes, in fact, when I looked at other callers of blk_get_aio_context(), 
this was one place that didn’t really make sense to me, exactly because 
I doubt the invariant.

(Other places are scsi_aio_complete() and scsi_read_complete_noio().)

> Did you find a scenario where the virtio-scsi AioContext is different
> from the scsi-hd BB's Aiocontext?

Technically, that’s the reason for this thread, specifically that 
virtio_scsi_hotunplug() switches the BB back to the main context while 
scsi_device_for_each_req_async_bh() is running.  Yes, we can fix that 
specific case via the in-flight counter, but I’m wondering whether 
there’s really any merit in requiring the BB to always be in 
virtio-scsi’s context, or whether it would make more sense to schedule 
everything in virtio-scsi’s context.  Now that BBs/BDSs can receive 
requests from any context, that is.

The critical path is in hot-plugging and -unplugging, because those 
happen in the main context, concurrently to request processing in 
virtio-scsi’s context.  As for hot-plugging, what I’ve seen is 
https://issues.redhat.com/browse/RHEL-3934#comment-23272702 : The 
scsi-hd device is created before it’s hot-plugged into virtio-scsi, so 
technically, we do then have a scsi-hd device whose context is different 
from virtio-scsi.  The blk_drain() that’s being done to this new scsi-hd 
device does lead into virtio_scsi_drained_begin(), so there is at least 
some connection between the two.

As for hot-unplugging, my worry is that there may be SCSI requests 
ongoing, which are processed in virtio-scsi’s context.  My hope is that 
scsi_device_purge_requests() settles all of them, so that there are no 
requests left after virtio_scsi_hotunplug()’s 
qdev_simple_device_unplug_cb(), before the BB is switched to the main 
context.  Right now, it doesn’t do that, though, because we use 
scsi_device_for_each_req_async(), i.e. don’t wait for those requests to 
be cancelled.  With the in-flight patch, the subsequent blk_drain() in 
scsi_device_purge_requests() would then await it, though.[1]

Even with that, the situation is all but clear to me.  We do run 
scsi_req_cancel_async() for every single request we currently have, and 
then wait until the in-flight counter reaches 0, which seems good[2], 
but with the rest of the unplugging code running in the main context, 
and virtio-scsi continuing to process requests from the guest in a 
different context, I can’t easily figure out why it would be impossible 
for the guest to launch a SCSI request for that SCSI disk that is being 
unplugged.  On one hand, just because the guest has accepted hot unplug 
does not mean it would be impossible to act against supposed protocol 
and submit another request.  On the other, this unplugging and unrealize 
state machine to me is a very complex and opaque state machine that 
makes it difficult to grasp where exactly the ties between a scsi-hd 
device with its BB and the virtio-scsi device are completely severed, 
i.e. until which point it is possible for virtio-scsi code to see the BB 
during the unplugging process, and consider it the target of a request.

It just seems simpler to me to not rely on the BB's context at all.

Hanna


[1] So, fun note: Incrementing the in-flight counter would fix the bug 
even without a drain in bdrv_try_change_aio_context(), because 
scsi_device_purge_requests() has a blk_drain() anyway.

[2] I had to inspect the code, though, so already this is non-obvious.  
There are no comments on either scsi_device_purge_one_req() or 
scsi_device_purge_requests(), so it’s unclear what their guarantees 
are.  scsi_device_purge_one_req() calls scsi_req_cancel_async(), which 
indicates that the request isn’t necessarily deleted after the function 
returns, and so you need to look at the code: Non-I/O requests are 
deleted, but I/O requests are not, they are just cancelled.  However, I 
assume that I/O requests have incremented some in-flight counter, so I 
assume that the blk_drain() in scsi_device_purge_requests() takes care 
of settling them all.


