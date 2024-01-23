Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC3C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKUf-0004mb-JJ; Tue, 23 Jan 2024 12:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSKUe-0004mM-Bh
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:23:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSKUb-0003vM-Bl
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706030600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwaaR3S6dqYLs7KyBvCXb7PoA39urmMNK4K1foXxwfc=;
 b=V2ayq80atvllMMLV9dAnNI5KEq7C08si975RxZ2GAJaMNFuSuzviQfSg0qW5WeJlvQGNEo
 clbUaN6lobvYw5hLrTofPyRXLQCJm4ppwOBb8m2ghZAgPN4bayGYFUW+YoPXfIcazDQ1VV
 OSiRV08xLPKyY47cJhDTu6kXv5Vb0Sw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-9wOzXtGsOkqgNj5X-OuViQ-1; Tue, 23 Jan 2024 12:23:18 -0500
X-MC-Unique: 9wOzXtGsOkqgNj5X-OuViQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e9d8e9a39so39111805e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030597; x=1706635397;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RwaaR3S6dqYLs7KyBvCXb7PoA39urmMNK4K1foXxwfc=;
 b=vCf2TZU5b0PbuxHmSFDI4TX23FnL4V3EIbXxBSioNN8P02K31CUcplkZW2m0WCLPyn
 FLmXjxf1JeRZPNbwm9Fu0OHAusUzg8PTWdWuhyHIrgnyRLUQvp3pQMDpK1W7JaeetohV
 hwtCs+D2wMGiqcJY5Wj5uFTRRTBUiM7H76vtbe0m2Gl0sadUR8B1aOKpIFnR3E7JxEzR
 a1fTjRCsZo/NW3FWiA9cLIjd+0Q5tNZT58KDg4OpDS5wwv8UI+MT2lLjkEduWltvTBY5
 lSR9fgG0zImtQgJbPYkHa+uEVqDLdSouVhhHOtS+BijwrBKDlk9XHOtBe28oobm2PkmW
 jh+g==
X-Gm-Message-State: AOJu0YwxxzJIk99R5QHb/EZ7v80NxBU15ww8ltVZeo379c5NMRbMk9vU
 YWX+p4v05+vVYL5Bw27WrKO64GB41fWIadhmskqxHF5iK6Ub6ZDIhxfRbKvyRwbXCirMFMji9an
 XXAlLvZfVH1LoBUsd2Cvt10P60yQ5AeVeevwzXICvajZ58tJS5JuN
X-Received: by 2002:a05:600c:3208:b0:40e:8903:6e1 with SMTP id
 r8-20020a05600c320800b0040e890306e1mr718290wmp.40.1706030597066; 
 Tue, 23 Jan 2024 09:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs75VW4/gboYCmw8wBm0XEV2OQEXspWDQgao5uwe92zxa9YfyIxjiLICYVJyAkf0+yP03CIA==
X-Received: by 2002:a05:600c:3208:b0:40e:8903:6e1 with SMTP id
 r8-20020a05600c320800b0040e890306e1mr718283wmp.40.1706030596727; 
 Tue, 23 Jan 2024 09:23:16 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0040d8ff79fd8sm43252595wmb.7.2024.01.23.09.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 09:23:16 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------5IwzkY0xB1bX1d7Xc0pikBAj"
Message-ID: <90b2a5da-d4b5-4749-aba4-7a0d42b4f6f8@redhat.com>
Date: Tue, 23 Jan 2024 18:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <Za_zAj11uwavd2va@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------5IwzkY0xB1bX1d7Xc0pikBAj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.01.24 18:10, Kevin Wolf wrote:
> Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
>> On 21.12.23 22:23, Kevin Wolf wrote:
>>> From: Stefan Hajnoczi<stefanha@redhat.com>
>>>
>>> Stop depending on the AioContext lock and instead access
>>> SCSIDevice->requests from only one thread at a time:
>>> - When the VM is running only the BlockBackend's AioContext may access
>>>     the requests list.
>>> - When the VM is stopped only the main loop may access the requests
>>>     list.
>>>
>>> These constraints protect the requests list without the need for locking
>>> in the I/O code path.
>>>
>>> Note that multiple IOThreads are not supported yet because the code
>>> assumes all SCSIRequests are executed from a single AioContext. Leave
>>> that as future work.
>>>
>>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>>> Reviewed-by: Eric Blake<eblake@redhat.com>
>>> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
>>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>>> ---
>>>    include/hw/scsi/scsi.h |   7 +-
>>>    hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>>>    2 files changed, 131 insertions(+), 57 deletions(-)
>> My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now breaks more
>> often because of this commit than because of the original bug, i.e. when
>> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
>> this tends to happen when unplugging the scsi-hd:
>>
>> {"execute":"device_del","arguments":{"id":"stg0"}}
>> {"return": {}}
>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>> Assertion `ctx == blk->ctx' failed.
>>
>> (gdb) bt
>> #0  0x00007f32a668d83c in  () at /usr/lib/libc.so.6
>> #1  0x00007f32a663d668 in raise () at /usr/lib/libc.so.6
>> #2  0x00007f32a66254b8 in abort () at /usr/lib/libc.so.6
>> #3  0x00007f32a66253dc in  () at /usr/lib/libc.so.6
>> #4  0x00007f32a6635d26 in  () at /usr/lib/libc.so.6
>> #5  0x0000556e6b4880a4 in blk_get_aio_context (blk=0x556e6e89ccf0) at
>> ../block/block-backend.c:2429
>> #6  blk_get_aio_context (blk=0x556e6e89ccf0) at
>> ../block/block-backend.c:2417
>> #7  0x0000556e6b112d87 in scsi_device_for_each_req_async_bh
>> (opaque=0x556e6e2c6d10) at ../hw/scsi/scsi-bus.c:128
>> #8  0x0000556e6b5d1966 in aio_bh_poll (ctx=ctx@entry=0x556e6d8aa290) at
>> ../util/async.c:218
>> #9  0x0000556e6b5bb16a in aio_poll (ctx=0x556e6d8aa290,
>> blocking=blocking@entry=true) at ../util/aio-posix.c:722
>> #10 0x0000556e6b4564b6 in iothread_run (opaque=opaque@entry=0x556e6d89d920)
>> at ../iothread.c:63
>> #11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at
>> ../util/qemu-thread-posix.c:541
>> #12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6
>> #13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6
>>
>> I don’t know anything about the problem yet, but as usual, I like
>> speculation and discovering how wrong I was later on, so one thing I came
>> across that’s funny about virtio-scsi is that requests can happen even while
>> a disk is being attached or detached.  That is, Linux seems to probe all
>> LUNs when a new virtio-scsi device is being attached, and it won’t stop just
>> because a disk is being attached or removed.  So maybe that’s part of the
>> problem, that we get a request while the BB is being detached, and
>> temporarily in an inconsistent state (BDS context differs from BB context).
> I don't know anything about the problem either, but since you already
> speculated about the cause, let me speculate about the solution:
> Can we hold the graph writer lock for the tran_commit() call in
> bdrv_try_change_aio_context()? And of course take the reader lock for
> blk_get_aio_context(), but that should be completely unproblematic.
>
> At the first sight I don't see a reason why this would break something,
> but I've learnt not to trust my first impression with the graph locking
> work...
>
> Of course, I also didn't check if there are more things inside of the
> device emulation that need additional locking in this case, too. But
> even if so, blk_get_aio_context() should never see an inconsistent
> state.

Ah, sorry, saw your reply only now that I hit “send”.

I forgot that we do have that big lock that I thought rather to avoid 
:)  Sounds good and very reasonable to me.  Changing the contexts in the 
graph sounds like a graph change operation, and reading and comparing 
contexts in the graph sounds like reading the graph.

Hanna
--------------5IwzkY0xB1bX1d7Xc0pikBAj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 23.01.24 18:10, Kevin Wolf wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Za_zAj11uwavd2va@redhat.com">
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
        <pre class="moz-quote-pre" wrap="">
My reproducer for <a class="moz-txt-link-freetext" href="https://issues.redhat.com/browse/RHEL-3934">https://issues.redhat.com/browse/RHEL-3934</a> now breaks more
often because of this commit than because of the original bug, i.e. when
repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
this tends to happen when unplugging the scsi-hd:

{"execute":"device_del","arguments":{"id":"stg0"}}
{"return": {}}
qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
Assertion `ctx == blk-&gt;ctx' failed.

(gdb) bt
#0  0x00007f32a668d83c in  () at /usr/lib/libc.so.6
#1  0x00007f32a663d668 in raise () at /usr/lib/libc.so.6
#2  0x00007f32a66254b8 in abort () at /usr/lib/libc.so.6
#3  0x00007f32a66253dc in  () at /usr/lib/libc.so.6
#4  0x00007f32a6635d26 in  () at /usr/lib/libc.so.6
#5  0x0000556e6b4880a4 in blk_get_aio_context (blk=0x556e6e89ccf0) at
../block/block-backend.c:2429
#6  blk_get_aio_context (blk=0x556e6e89ccf0) at
../block/block-backend.c:2417
#7  0x0000556e6b112d87 in scsi_device_for_each_req_async_bh
(opaque=0x556e6e2c6d10) at ../hw/scsi/scsi-bus.c:128
#8  0x0000556e6b5d1966 in aio_bh_poll (ctx=ctx@entry=0x556e6d8aa290) at
../util/async.c:218
#9  0x0000556e6b5bb16a in aio_poll (ctx=0x556e6d8aa290,
blocking=blocking@entry=true) at ../util/aio-posix.c:722
#10 0x0000556e6b4564b6 in iothread_run (opaque=opaque@entry=0x556e6d89d920)
at ../iothread.c:63
#11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at
../util/qemu-thread-posix.c:541
#12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6
#13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6

I don’t know anything about the problem yet, but as usual, I like
speculation and discovering how wrong I was later on, so one thing I came
across that’s funny about virtio-scsi is that requests can happen even while
a disk is being attached or detached.  That is, Linux seems to probe all
LUNs when a new virtio-scsi device is being attached, and it won’t stop just
because a disk is being attached or removed.  So maybe that’s part of the
problem, that we get a request while the BB is being detached, and
temporarily in an inconsistent state (BDS context differs from BB context).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't know anything about the problem either, but since you already
speculated about the cause, let me speculate about the solution:
Can we hold the graph writer lock for the tran_commit() call in
bdrv_try_change_aio_context()? And of course take the reader lock for
blk_get_aio_context(), but that should be completely unproblematic.

At the first sight I don't see a reason why this would break something,
but I've learnt not to trust my first impression with the graph locking
work...

Of course, I also didn't check if there are more things inside of the
device emulation that need additional locking in this case, too. But
even if so, blk_get_aio_context() should never see an inconsistent
state.</pre>
    </blockquote>
    <span style="white-space: pre-wrap">
</span><br>
    Ah, sorry, saw your reply only now that I hit “send”.<br>
    <br>
    I forgot that we do have that big lock that I thought rather to
    avoid :)  Sounds good and very reasonable to me.  Changing the
    contexts in the graph sounds like a graph change operation, and
    reading and comparing contexts in the graph sounds like reading the
    graph.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------5IwzkY0xB1bX1d7Xc0pikBAj--


