Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74151C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXlo-0008F1-Fw; Thu, 01 Feb 2024 09:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVXln-0008Ed-Fq
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVXlj-0007I6-V1
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706796619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8twKe7Yn41/Qubx9iM2NzsMvQlZGRtfGyDspdKP7OM=;
 b=aUcZqatcWhNsdR2KntdJPlALIQm4poywaCjdvQYG/6Fmg0GU+hOazcMrFiYsv6eKAt4/9x
 oKAa2/a4UzEa61F86xStxRG9WCp+forNacW2KSzhA73MlyhPsmoKbodqvgAtRN87XWrIbj
 jbaQnAkt8q7ltJd5VcpUL++2cTPcBxM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-BZ1UpjzjNUGPpvgG9aw25A-1; Thu, 01 Feb 2024 09:10:16 -0500
X-MC-Unique: BZ1UpjzjNUGPpvgG9aw25A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50ec9529001so941496e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 06:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796615; x=1707401415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8twKe7Yn41/Qubx9iM2NzsMvQlZGRtfGyDspdKP7OM=;
 b=a9SewLtrYll0xKr5szDj0ayzvBu0AcTtfSdMC4jCpUaGkFzrVk65qFqJrivNTQ1p38
 Yz838pKeDC5cov2fgsjViaE6JAcf5TrhhDz8euWzV0nvk4SaW+k1CFWEvynr262+J7XD
 XldpB6TKAnF3Zg8E5z1CkMPT1D00vKcbjJtuzd+mtXguOaFulRmHiIGlW5AMXHR14iuV
 wAIiE55cPe8RsBwxPk+es36hi3M9tqZj18av4Pzoh+fgFJvpCk34y5g9NjU3tx+AWefd
 fiPlPE4AvLERkM/MHIP9iG2DI6sFttaGXXaRwsOWB9eeuWZe02wdWGzPGYDpfEemMAxa
 4wrA==
X-Gm-Message-State: AOJu0Ywibh3KcOnpI0HfbINQkaWVrYSWN1aLi3w3kKSCJFOqpM15vp/x
 toIN/b0OY9oRhUTDgQtOnALiNZ0iI7vSKCEB7o4oBSGuN90Jn0OiN6liiOMUhv0W3n83fnuhygt
 eS0B+PsKGiwvM6Hk28HwScXOiKFEnHXDOSsdSVdJj5aKw6Ya5PLaK
X-Received: by 2002:a05:6512:3ab:b0:511:3058:735c with SMTP id
 v11-20020a05651203ab00b005113058735cmr1139151lfp.23.1706796615006; 
 Thu, 01 Feb 2024 06:10:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzV8z7HvZEhr+TxcbbsQKdFoEY7/Kz1NIXlPVyQELnjir71t42Gl3wqv27Lx+W7KPJpFmMkA==
X-Received: by 2002:a05:6512:3ab:b0:511:3058:735c with SMTP id
 v11-20020a05651203ab00b005113058735cmr1139120lfp.23.1706796614449; 
 Thu, 01 Feb 2024 06:10:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWngYJJrKlmdJoslm9UyAs3dUEjK5aAFsPAFqvwp9CfPhXmYTrYXLXw6XFNGrTuPCNzI6E41AufLxhw+nAd/FpR68qdWaVbmbvr6Iv4YFdzSFwcJqUGDUV49NQeXQ==
Received: from ?IPV6:2003:cf:d73b:4144:8f0d:1c55:f035:1a2b?
 (p200300cfd73b41448f0d1c55f0351a2b.dip0.t-ipconnect.de.
 [2003:cf:d73b:4144:8f0d:1c55:f035:1a2b])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c450c00b0040e9f7308f4sm4616307wmo.10.2024.02.01.06.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:10:13 -0800 (PST)
Message-ID: <0a3e8d2a-add1-432b-b6b9-456ee0b17882@redhat.com>
Date: Thu, 1 Feb 2024 15:10:12 +0100
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
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240131203537.GC396296@fedora>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31.01.24 21:35, Stefan Hajnoczi wrote:
> On Fri, Jan 26, 2024 at 04:24:49PM +0100, Hanna Czenczek wrote:
>> On 26.01.24 14:18, Kevin Wolf wrote:
>>> Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
>>>> On 23.01.24 18:10, Kevin Wolf wrote:
>>>>> Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
>>>>>> On 21.12.23 22:23, Kevin Wolf wrote:
>>>>>>> From: Stefan Hajnoczi<stefanha@redhat.com>
>>>>>>>
>>>>>>> Stop depending on the AioContext lock and instead access
>>>>>>> SCSIDevice->requests from only one thread at a time:
>>>>>>> - When the VM is running only the BlockBackend's AioContext may access
>>>>>>>       the requests list.
>>>>>>> - When the VM is stopped only the main loop may access the requests
>>>>>>>       list.
>>>>>>>
>>>>>>> These constraints protect the requests list without the need for locking
>>>>>>> in the I/O code path.
>>>>>>>
>>>>>>> Note that multiple IOThreads are not supported yet because the code
>>>>>>> assumes all SCSIRequests are executed from a single AioContext. Leave
>>>>>>> that as future work.
>>>>>>>
>>>>>>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>>>>>>> Reviewed-by: Eric Blake<eblake@redhat.com>
>>>>>>> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
>>>>>>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>>>>>>> ---
>>>>>>>      include/hw/scsi/scsi.h |   7 +-
>>>>>>>      hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>>>>>>>      2 files changed, 131 insertions(+), 57 deletions(-)
>>>>>> My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now breaks more
>>>>>> often because of this commit than because of the original bug, i.e. when
>>>>>> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
>>>>>> this tends to happen when unplugging the scsi-hd:
>> Note: We (on issues.redhat.com) have a separate report that seems to be
>> concerning this very problem: https://issues.redhat.com/browse/RHEL-19381
>>
>>>>>> {"execute":"device_del","arguments":{"id":"stg0"}}
>>>>>> {"return": {}}
>>>>>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>>>>>> Assertion `ctx == blk->ctx' failed.
>>>> [...]
>>>>
>>>>>> I don’t know anything about the problem yet, but as usual, I like
>>>>>> speculation and discovering how wrong I was later on, so one thing I came
>>>>>> across that’s funny about virtio-scsi is that requests can happen even while
>>>>>> a disk is being attached or detached.  That is, Linux seems to probe all
>>>>>> LUNs when a new virtio-scsi device is being attached, and it won’t stop just
>>>>>> because a disk is being attached or removed.  So maybe that’s part of the
>>>>>> problem, that we get a request while the BB is being detached, and
>>>>>> temporarily in an inconsistent state (BDS context differs from BB context).
>>>>> I don't know anything about the problem either, but since you already
>>>>> speculated about the cause, let me speculate about the solution:
>>>>> Can we hold the graph writer lock for the tran_commit() call in
>>>>> bdrv_try_change_aio_context()? And of course take the reader lock for
>>>>> blk_get_aio_context(), but that should be completely unproblematic.
>>>> Actually, now that completely unproblematic part is giving me trouble.  I
>>>> wanted to just put a graph lock into blk_get_aio_context() (making it a
>>>> coroutine with a wrapper)
>>> Which is the first thing I neglected and already not great. We have
>>> calls of blk_get_aio_context() in the SCSI I/O path, and creating a
>>> coroutine and doing at least two context switches simply for this call
>>> is a lot of overhead...
>>>
>>>> but callers of blk_get_aio_context() generally assume the context is
>>>> going to stay the BB’s context for as long as their AioContext *
>>>> variable is in scope.
>>> I'm not so sure about that. And taking another step back, I'm actually
>>> also not sure how much it still matters now that they can submit I/O
>>> from any thread.
>> That’s my impression, too, but “not sure” doesn’t feel great. :)
>> scsi_device_for_each_req_async_bh() specifically double-checks whether it’s
>> still in the right context before invoking the specified function, so it
>> seems there was some intention to continue to run in the context associated
>> with the BB.
>>
>> (Not judging whether that intent makes sense or not, yet.)
>>
>>> Maybe the correct solution is to remove the assertion from
>>> blk_get_aio_context() and just always return blk->ctx. If it's in the
>>> middle of a change, you'll either get the old one or the new one. Either
>>> one is fine to submit I/O from, and if you care about changes for other
>>> reasons (like SCSI does), then you need explicit code to protect it
>>> anyway (which SCSI apparently has, but it doesn't work).
>> I think most callers do just assume the BB stays in the context they got
>> (without any proof, admittedly), but I agree that under re-evaluation, it
>> probably doesn’t actually matter to them, really. And yes, basically, if the
>> caller doesn’t need to take a lock because it doesn’t really matter whether
>> blk->ctx changes while its still using the old value, blk_get_aio_context()
>> in turn doesn’t need to double-check blk->ctx against the root node’s
>> context either, and nobody needs a lock.
>>
>> So I agree, it’s on the caller to protect against a potentially changing
>> context, blk_get_aio_context() should just return blk->ctx and not check
>> against the root node.
>>
>> (On a tangent: blk_drain() is a caller of blk_get_aio_context(), and it
>> polls that context.  Why does it need to poll that context specifically when
>> requests may be in any context?  Is it because if there are requests in the
>> main thread, we must poll that, but otherwise it’s fine to poll any thread,
>> and we can only have requests in the main thread if that’s the BB’s
>> context?)
>>
>>>> I was tempted to think callers know what happens to the BB they pass
>>>> to blk_get_aio_context(), and it won’t change contexts so easily, but
>>>> then I remembered this is exactly what happens in this case; we run
>>>> scsi_device_for_each_req_async_bh() in one thread (which calls
>>>> blk_get_aio_context()), and in the other, we change the BB’s context.
>>> Let's think a bit more about scsi_device_for_each_req_async()
>>> specifically. This is a function that runs in the main thread. Nothing
>>> will change any AioContext assignment if it doesn't call it. It wants to
>>> make sure that scsi_device_for_each_req_async_bh() is called in the
>>> same AioContext where the virtqueue is processed, so it schedules a BH
>>> and waits for it.
>> I don’t quite follow, it doesn’t wait for the BH.  It uses
>> aio_bh_schedule_oneshot(), not aio_wait_bh_oneshot().  While you’re right
>> that if it did wait, the BB context might still change, in practice we
>> wouldn’t have the problem at hand because the caller is actually the one to
>> change the context, concurrently while the BH is running.
>>
>>> Waiting for it means running a nested event loop that could do anything,
>>> including changing AioContexts. So this is what needs the locking, not
>>> the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
>>> If we lock before the nested event loop and unlock in the BH, the check
>>> in the BH can become an assertion. (It is important that we unlock in
>>> the BH rather than after waiting because if something takes the writer
>>> lock, we need to unlock during the nested event loop of bdrv_wrlock() to
>>> avoid a deadlock.)
>>>
>>> And spawning a coroutine for this looks a lot more acceptable because
>>> it's on a slow path anyway.
>>>
>>> In fact, we probably don't technically need a coroutine to take the
>>> reader lock here. We can have a new graph lock function that asserts
>>> that there is no writer (we know because we're running in the main loop)
>>> and then atomically increments the reader count. But maybe that already
>>> complicates things again...
>> So as far as I understand we can’t just use aio_wait_bh_oneshot() and wrap
>> it in bdrv_graph_rd{,un}lock_main_loop(), because that doesn’t actually lock
>> the graph.  I feel like adding a new graph lock function for this quite
>> highly specific case could be dangerous, because it seems easy to use the
>> wrong way.
>>
>> Just having a trampoline coroutine to call bdrv_graph_co_rd{,un}lock() seems
>> simple enough and reasonable here (not a hot path).  Can we have that
>> coroutine then use aio_wait_bh_oneshot() with the existing _bh function, or
>> should that be made a coroutine, too?
> There is a reason for running in the context associated with the BB: the
> virtio-scsi code assumes all request processing happens in the BB's
> AioContext. The SCSI request list and other SCSI emulation code is not
> thread-safe!

One peculiarity about virtio-scsi, as far as I understand, is that its 
context is not necessarily the BB’s context, because one virtio-scsi 
device may have many BBs.  While the BBs are being hot-plugged or 
un-plugged, their context may change (as is happening here), but that 
doesn’t stop SCSI request processing, because SCSI requests happen 
independently of whether there are devices on the SCSI bus.

If SCSI request processing is not thread-safe, doesn’t that mean it 
always must be done in the very same context, i.e. the context the 
virtio-scsi device was configured to use?  Just because a new scsi-hd BB 
is added or removed, and so we temporarily have a main context BB 
associated with the virtio-scsi device, I don’t think we should switch 
to processing requests in the main context.

Hanna


