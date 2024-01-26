Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470FAC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO4x-0006Wz-Du; Fri, 26 Jan 2024 10:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rTO4i-0006R1-RL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rTO4g-0004OW-14
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706282696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSnYg3o24ekVgD3ZWjBbs2VxGpZr48UArIqjvPDc3SU=;
 b=U8exGTzNRnm41ReXdzbL0TMoK3buQEExq3b8WJ0g/USuHhfFLu7Gb/DHaqRj8YeCWlHM0h
 hz2ZUFbVIZSXQoZcyp2kAXi4ttVHO6gJ2YNUsthEvvS2GnrrNSaUcsKwlhxATZzxE056d9
 R+sn2ZBe2H2T4NTSrJp1oqZn4ld6Z9M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-6Ah3axqHM1uYeq5HzN4fqg-1; Fri, 26 Jan 2024 10:24:54 -0500
X-MC-Unique: 6Ah3axqHM1uYeq5HzN4fqg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e479a51e4so8648165e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282693; x=1706887493;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LSnYg3o24ekVgD3ZWjBbs2VxGpZr48UArIqjvPDc3SU=;
 b=bp6k+3fQNos5g8fDiGsEcKtMeYBE1YHYlRo2yNR69wrnfwiDeluZXdnQHRFM9zwNbZ
 WAapVzSqNk36khPQyp/iwlvv+RMjDxbQ7MDNtK9XjsKSsKz4aTkRjnxbB9MQD7wSMsfP
 2G+FGT+mkiQGnWPAhmC8sSv/t/3OaQV77y2nky3t+loLobV9FoPCw48ZufIiGrhBaxKX
 uci5vPbHssH50EFjXLoxeChKYkrGz2umXTuO87rSVjT9+ZJV+U+k3MQ4DZ8dGMn969ZW
 klrP41zeEq22qVR8tDUz4QBTbHUvLELUn9yW6PNHRi+e93zSn/El7pf123gID1ZI+17g
 /ZJw==
X-Gm-Message-State: AOJu0YxoY+TdWXLBcTNxBB2OIdBqRTYHV4OD8Dqf6Jt1+h7NNOMxT3MI
 Gs4VmNSL5gzbGMS725iOiIzCIveWOJMz88NuFNUUgRqajUgl2nvswyd4i1j6hl/qu9iX8KZOXF3
 xEdGPzyEQuT2JwyY1YdB9E7G+yW18lRy1246Eizpv4jEZxTx7V9NnEXfH9wXf
X-Received: by 2002:a05:600c:2188:b0:40e:e875:ae86 with SMTP id
 e8-20020a05600c218800b0040ee875ae86mr163965wme.179.1706282692772; 
 Fri, 26 Jan 2024 07:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfHtOv85GIIxYcUoYEX8LKJA6OzWMO/zqdS9Ca86k1S1ConIFiuvZYVRrAfCITHLtns2HBUQ==
X-Received: by 2002:a05:600c:2188:b0:40e:e875:ae86 with SMTP id
 e8-20020a05600c218800b0040ee875ae86mr163956wme.179.1706282692258; 
 Fri, 26 Jan 2024 07:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXDOxYisxnvbDIWKT2WpE/PrCxVOXXRrgpBhihA5JpNU+6u5dOgTcqcn65eoSxf+RWd79/duHFw5XqOKDNVNyIC9gWpf7mQKGvvUNaN4p+PxJhySuWJlxHZ59E=
Received: from ?IPV6:2003:cf:d73b:41e3:4a3e:681e:32b7:8988?
 (p200300cfd73b41e34a3e681e32b78988.dip0.t-ipconnect.de.
 [2003:cf:d73b:41e3:4a3e:681e:32b7:8988])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c0a0700b0040eccfa8a36sm2210560wmp.27.2024.01.26.07.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:24:49 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------uAgtG0pd8xnWWweAqDUeUx1o"
Message-ID: <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
Date: Fri, 26 Jan 2024 16:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
 <ZbOxI9Ar-YDn51Z0@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <ZbOxI9Ar-YDn51Z0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------uAgtG0pd8xnWWweAqDUeUx1o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.01.24 14:18, Kevin Wolf wrote:
> Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
>> On 23.01.24 18:10, Kevin Wolf wrote:
>>> Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
>>>> On 21.12.23 22:23, Kevin Wolf wrote:
>>>>> From: Stefan Hajnoczi<stefanha@redhat.com>
>>>>>
>>>>> Stop depending on the AioContext lock and instead access
>>>>> SCSIDevice->requests from only one thread at a time:
>>>>> - When the VM is running only the BlockBackend's AioContext may access
>>>>>      the requests list.
>>>>> - When the VM is stopped only the main loop may access the requests
>>>>>      list.
>>>>>
>>>>> These constraints protect the requests list without the need for locking
>>>>> in the I/O code path.
>>>>>
>>>>> Note that multiple IOThreads are not supported yet because the code
>>>>> assumes all SCSIRequests are executed from a single AioContext. Leave
>>>>> that as future work.
>>>>>
>>>>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>>>>> Reviewed-by: Eric Blake<eblake@redhat.com>
>>>>> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
>>>>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>>>>> ---
>>>>>     include/hw/scsi/scsi.h |   7 +-
>>>>>     hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>>>>>     2 files changed, 131 insertions(+), 57 deletions(-)
>>>> My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now breaks more
>>>> often because of this commit than because of the original bug, i.e. when
>>>> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
>>>> this tends to happen when unplugging the scsi-hd:

Note: We (on issues.redhat.com) have a separate report that seems to be 
concerning this very problem: https://issues.redhat.com/browse/RHEL-19381

>>>> {"execute":"device_del","arguments":{"id":"stg0"}}
>>>> {"return": {}}
>>>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>>>> Assertion `ctx == blk->ctx' failed.
>> [...]
>>
>>>> I don’t know anything about the problem yet, but as usual, I like
>>>> speculation and discovering how wrong I was later on, so one thing I came
>>>> across that’s funny about virtio-scsi is that requests can happen even while
>>>> a disk is being attached or detached.  That is, Linux seems to probe all
>>>> LUNs when a new virtio-scsi device is being attached, and it won’t stop just
>>>> because a disk is being attached or removed.  So maybe that’s part of the
>>>> problem, that we get a request while the BB is being detached, and
>>>> temporarily in an inconsistent state (BDS context differs from BB context).
>>> I don't know anything about the problem either, but since you already
>>> speculated about the cause, let me speculate about the solution:
>>> Can we hold the graph writer lock for the tran_commit() call in
>>> bdrv_try_change_aio_context()? And of course take the reader lock for
>>> blk_get_aio_context(), but that should be completely unproblematic.
>> Actually, now that completely unproblematic part is giving me trouble.  I
>> wanted to just put a graph lock into blk_get_aio_context() (making it a
>> coroutine with a wrapper)
> Which is the first thing I neglected and already not great. We have
> calls of blk_get_aio_context() in the SCSI I/O path, and creating a
> coroutine and doing at least two context switches simply for this call
> is a lot of overhead...
>
>> but callers of blk_get_aio_context() generally assume the context is
>> going to stay the BB’s context for as long as their AioContext *
>> variable is in scope.
> I'm not so sure about that. And taking another step back, I'm actually
> also not sure how much it still matters now that they can submit I/O
> from any thread.

That’s my impression, too, but “not sure” doesn’t feel great. :) 
scsi_device_for_each_req_async_bh() specifically double-checks whether 
it’s still in the right context before invoking the specified function, 
so it seems there was some intention to continue to run in the context 
associated with the BB.

(Not judging whether that intent makes sense or not, yet.)

> Maybe the correct solution is to remove the assertion from
> blk_get_aio_context() and just always return blk->ctx. If it's in the
> middle of a change, you'll either get the old one or the new one. Either
> one is fine to submit I/O from, and if you care about changes for other
> reasons (like SCSI does), then you need explicit code to protect it
> anyway (which SCSI apparently has, but it doesn't work).

I think most callers do just assume the BB stays in the context they got 
(without any proof, admittedly), but I agree that under re-evaluation, 
it probably doesn’t actually matter to them, really. And yes, basically, 
if the caller doesn’t need to take a lock because it doesn’t really 
matter whether blk->ctx changes while its still using the old value, 
blk_get_aio_context() in turn doesn’t need to double-check blk->ctx 
against the root node’s context either, and nobody needs a lock.

So I agree, it’s on the caller to protect against a potentially changing 
context, blk_get_aio_context() should just return blk->ctx and not check 
against the root node.

(On a tangent: blk_drain() is a caller of blk_get_aio_context(), and it 
polls that context.  Why does it need to poll that context specifically 
when requests may be in any context?  Is it because if there are 
requests in the main thread, we must poll that, but otherwise it’s fine 
to poll any thread, and we can only have requests in the main thread if 
that’s the BB’s context?)

>> I was tempted to think callers know what happens to the BB they pass
>> to blk_get_aio_context(), and it won’t change contexts so easily, but
>> then I remembered this is exactly what happens in this case; we run
>> scsi_device_for_each_req_async_bh() in one thread (which calls
>> blk_get_aio_context()), and in the other, we change the BB’s context.
> Let's think a bit more about scsi_device_for_each_req_async()
> specifically. This is a function that runs in the main thread. Nothing
> will change any AioContext assignment if it doesn't call it. It wants to
> make sure that scsi_device_for_each_req_async_bh() is called in the
> same AioContext where the virtqueue is processed, so it schedules a BH
> and waits for it.

I don’t quite follow, it doesn’t wait for the BH.  It uses 
aio_bh_schedule_oneshot(), not aio_wait_bh_oneshot().  While you’re 
right that if it did wait, the BB context might still change, in 
practice we wouldn’t have the problem at hand because the caller is 
actually the one to change the context, concurrently while the BH is 
running.

> Waiting for it means running a nested event loop that could do anything,
> including changing AioContexts. So this is what needs the locking, not
> the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
> If we lock before the nested event loop and unlock in the BH, the check
> in the BH can become an assertion. (It is important that we unlock in
> the BH rather than after waiting because if something takes the writer
> lock, we need to unlock during the nested event loop of bdrv_wrlock() to
> avoid a deadlock.)
>
> And spawning a coroutine for this looks a lot more acceptable because
> it's on a slow path anyway.
>
> In fact, we probably don't technically need a coroutine to take the
> reader lock here. We can have a new graph lock function that asserts
> that there is no writer (we know because we're running in the main loop)
> and then atomically increments the reader count. But maybe that already
> complicates things again...

So as far as I understand we can’t just use aio_wait_bh_oneshot() and 
wrap it in bdrv_graph_rd{,un}lock_main_loop(), because that doesn’t 
actually lock the graph.  I feel like adding a new graph lock function 
for this quite highly specific case could be dangerous, because it seems 
easy to use the wrong way.

Just having a trampoline coroutine to call bdrv_graph_co_rd{,un}lock() 
seems simple enough and reasonable here (not a hot path).  Can we have 
that coroutine then use aio_wait_bh_oneshot() with the existing _bh 
function, or should that be made a coroutine, too?

>> It seems like there are very few blk_* functions right now that
>> require taking a graph lock around it, so I’m hesitant to go that
>> route.  But if we’re protecting a BB’s context via the graph write
>> lock, I can’t think of a way around having to take a read lock
>> whenever reading a BB’s context, and holding it for as long as we
>> assume that context to remain the BB’s context.  It’s also hard to
>> figure out how long that is, case by case; for example, dma_blk_read()
>> schedules an AIO function in the BB context; but we probably don’t
>> care that this context remains the BB’s context until the request is
>> done.  In the case of scsi_device_for_each_req_async_bh(), we already
>> take care to re-schedule it when it turns out the context is outdated,
>> so it does seem quite important here, and we probably want to keep the
>> lock until after the QTAILQ_FOREACH_SAFE() loop.
> Maybe we need to audit all callers. Fortunately, there don't seem to be
> too many. At least not direct ones...
>
>> On a tangent, this TOCTTOU problem makes me wary of other blk_*
>> functions that query information.  For example, fuse_read() (in
>> block/export/fuse.c) truncates requests to the BB length.  But what if
>> the BB length changes concurrently between blk_getlength() and
>> blk_pread()?  While we can justify using the graph lock for a BB’s
>> AioContext, we can’t use it for other metadata like its length.
> Hm... Is "tough luck" an acceptable answer? ;-)

Absolutely, if we do it acknowledgingly (great word).  I’m just a bit 
worried not all of these corner cases have been acknowledged, and some 
of them may be looking for a different answer.

Hanna
--------------uAgtG0pd8xnWWweAqDUeUx1o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 26.01.24 14:18, Kevin Wolf wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <pre class="moz-quote-pre" wrap="">Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 23.01.24 18:10, Kevin Wolf wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 21.12.23 22:23, Kevin Wolf wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Stefan Hajnoczi<a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>

Stop depending on the AioContext lock and instead access
SCSIDevice-&gt;requests from only one thread at a time:
- When the VM is running only the BlockBackend's AioContext may access
    the requests list.
- When the VM is stopped only the main loop may access the requests
    list.

These constraints protect the requests list without the need for locking
in the I/O code path.

Note that multiple IOThreads are not supported yet because the code
assumes all SCSIRequests are executed from a single AioContext. Leave
that as future work.

Signed-off-by: Stefan Hajnoczi<a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
Reviewed-by: Eric Blake<a class="moz-txt-link-rfc2396E" href="mailto:eblake@redhat.com">&lt;eblake@redhat.com&gt;</a>
Message-ID:<a class="moz-txt-link-rfc2396E" href="mailto:20231204164259.1515217-2-stefanha@redhat.com">&lt;20231204164259.1515217-2-stefanha@redhat.com&gt;</a>
Signed-off-by: Kevin Wolf<a class="moz-txt-link-rfc2396E" href="mailto:kwolf@redhat.com">&lt;kwolf@redhat.com&gt;</a>
---
   include/hw/scsi/scsi.h |   7 +-
   hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
   2 files changed, 131 insertions(+), 57 deletions(-)
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">My reproducer for <a class="moz-txt-link-freetext" href="https://issues.redhat.com/browse/RHEL-3934">https://issues.redhat.com/browse/RHEL-3934</a> now breaks more
often because of this commit than because of the original bug, i.e. when
repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
this tends to happen when unplugging the scsi-hd:
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
    Note: We (on issues.redhat.com) have a separate report that seems to
    be concerning this very problem:
    <a class="moz-txt-link-freetext" href="https://issues.redhat.com/browse/RHEL-19381">https://issues.redhat.com/browse/RHEL-19381</a><br>
    <br>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
{"execute":"device_del","arguments":{"id":"stg0"}}
{"return": {}}
qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
Assertion `ctx == blk-&gt;ctx' failed.
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
[...]

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">I don’t know anything about the problem yet, but as usual, I like
speculation and discovering how wrong I was later on, so one thing I came
across that’s funny about virtio-scsi is that requests can happen even while
a disk is being attached or detached.  That is, Linux seems to probe all
LUNs when a new virtio-scsi device is being attached, and it won’t stop just
because a disk is being attached or removed.  So maybe that’s part of the
problem, that we get a request while the BB is being detached, and
temporarily in an inconsistent state (BDS context differs from BB context).
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I don't know anything about the problem either, but since you already
speculated about the cause, let me speculate about the solution:
Can we hold the graph writer lock for the tran_commit() call in
bdrv_try_change_aio_context()? And of course take the reader lock for
blk_get_aio_context(), but that should be completely unproblematic.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Actually, now that completely unproblematic part is giving me trouble.  I
wanted to just put a graph lock into blk_get_aio_context() (making it a
coroutine with a wrapper)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Which is the first thing I neglected and already not great. We have
calls of blk_get_aio_context() in the SCSI I/O path, and creating a
coroutine and doing at least two context switches simply for this call
is a lot of overhead...

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">but callers of blk_get_aio_context() generally assume the context is
going to stay the BB’s context for as long as their AioContext *
variable is in scope.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not so sure about that. And taking another step back, I'm actually
also not sure how much it still matters now that they can submit I/O
from any thread.</pre>
    </blockquote>
    <br>
    That’s my impression, too, but “not sure” doesn’t feel great. :) 
    scsi_device_for_each_req_async_bh() specifically double-checks
    whether it’s still in the right context before invoking the
    specified function, so it seems there was some intention to continue
    to run in the context associated with the BB.<br>
    <br>
    (Not judging whether that intent makes sense or not, yet.)<br>
    <br>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <pre class="moz-quote-pre" wrap="">Maybe the correct solution is to remove the assertion from
blk_get_aio_context() and just always return blk-&gt;ctx. If it's in the
middle of a change, you'll either get the old one or the new one. Either
one is fine to submit I/O from, and if you care about changes for other
reasons (like SCSI does), then you need explicit code to protect it
anyway (which SCSI apparently has, but it doesn't work).</pre>
    </blockquote>
    <br>
    I think most callers do just assume the BB stays in the context they
    got (without any proof, admittedly), but I agree that under
    re-evaluation, it probably doesn’t actually matter to them, really. 
    And yes, basically, if the caller doesn’t need to take a lock
    because it doesn’t really matter whether blk-&gt;ctx changes while
    its still using the old value, blk_get_aio_context() in turn doesn’t
    need to double-check blk-&gt;ctx against the root node’s context
    either, and nobody needs a lock.<br>
    <br>
    So I agree, it’s on the caller to protect against a potentially
    changing context, blk_get_aio_context() should just return
    blk-&gt;ctx and not check against the root node.<br>
    <br>
    (On a tangent: blk_drain() is a caller of blk_get_aio_context(), and
    it polls that context.  Why does it need to poll that context
    specifically when requests may be in any context?  Is it because if
    there are requests in the main thread, we must poll that, but
    otherwise it’s fine to poll any thread, and we can only have
    requests in the main thread if that’s the BB’s context?)<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I was tempted to think callers know what happens to the BB they pass
to blk_get_aio_context(), and it won’t change contexts so easily, but
then I remembered this is exactly what happens in this case; we run
scsi_device_for_each_req_async_bh() in one thread (which calls
blk_get_aio_context()), and in the other, we change the BB’s context.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Let's think a bit more about scsi_device_for_each_req_async()
specifically. This is a function that runs in the main thread. Nothing
will change any AioContext assignment if it doesn't call it. It wants to
make sure that scsi_device_for_each_req_async_bh() is called in the
same AioContext where the virtqueue is processed, so it schedules a BH
and waits for it.</pre>
    </blockquote>
    <br>
    I don’t quite follow, it doesn’t wait for the BH.  It uses
    aio_bh_schedule_oneshot(), not aio_wait_bh_oneshot().  While you’re
    right that if it did wait, the BB context might still change, in
    practice we wouldn’t have the problem at hand because the caller is
    actually the one to change the context, concurrently while the BH is
    running.<br>
    <br>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <pre class="moz-quote-pre" wrap="">Waiting for it means running a nested event loop that could do anything,
including changing AioContexts. So this is what needs the locking, not
the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
If we lock before the nested event loop and unlock in the BH, the check
in the BH can become an assertion. (It is important that we unlock in
the BH rather than after waiting because if something takes the writer
lock, we need to unlock during the nested event loop of bdrv_wrlock() to
avoid a deadlock.)

And spawning a coroutine for this looks a lot more acceptable because
it's on a slow path anyway.

In fact, we probably don't technically need a coroutine to take the
reader lock here. We can have a new graph lock function that asserts
that there is no writer (we know because we're running in the main loop)
and then atomically increments the reader count. But maybe that already
complicates things again...</pre>
    </blockquote>
    <br>
    So as far as I understand we can’t just use aio_wait_bh_oneshot()
    and wrap it in bdrv_graph_rd{,un}lock_main_loop(), because that
    doesn’t actually lock the graph.  I feel like adding a new graph
    lock function for this quite highly specific case could be
    dangerous, because it seems easy to use the wrong way.<br>
    <br>
    Just having a trampoline coroutine to call
    bdrv_graph_co_rd{,un}lock() seems simple enough and reasonable here
    (not a hot path).  Can we have that coroutine then use
    aio_wait_bh_oneshot() with the existing _bh function, or should that
    be made a coroutine, too?<br>
    <br>
    <span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZbOxI9Ar-YDn51Z0@redhat.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">It seems like there are very few blk_* functions right now that
require taking a graph lock around it, so I’m hesitant to go that
route.  But if we’re protecting a BB’s context via the graph write
lock, I can’t think of a way around having to take a read lock
whenever reading a BB’s context, and holding it for as long as we
assume that context to remain the BB’s context.  It’s also hard to
figure out how long that is, case by case; for example, dma_blk_read()
schedules an AIO function in the BB context; but we probably don’t
care that this context remains the BB’s context until the request is
done.  In the case of scsi_device_for_each_req_async_bh(), we already
take care to re-schedule it when it turns out the context is outdated,
so it does seem quite important here, and we probably want to keep the
lock until after the QTAILQ_FOREACH_SAFE() loop.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Maybe we need to audit all callers. Fortunately, there don't seem to be
too many. At least not direct ones...

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On a tangent, this TOCTTOU problem makes me wary of other blk_*
functions that query information.  For example, fuse_read() (in
block/export/fuse.c) truncates requests to the BB length.  But what if
the BB length changes concurrently between blk_getlength() and
blk_pread()?  While we can justify using the graph lock for a BB’s
AioContext, we can’t use it for other metadata like its length.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hm... Is "tough luck" an acceptable answer? ;-)</pre>
    </blockquote>
    <br>
    Absolutely, if we do it acknowledgingly (great word).  I’m just a
    bit worried not all of these corner cases have been acknowledged,
    and some of them may be looking for a different answer.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------uAgtG0pd8xnWWweAqDUeUx1o--


