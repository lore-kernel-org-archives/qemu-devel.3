Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8EAC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3az-0007A0-Nm; Thu, 25 Jan 2024 12:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT3ax-0006sV-AA
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT3av-0006rk-8W
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706203972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlyXHXLezAMliACVNbPNFAQBlgifrPDgzPLngRgk11A=;
 b=W9PWAABXqkYZOCmcNmDlL+uzuE1nOCVzWjBxDxyGj2kVGfWSNhF9B4XAUHD8nBYC2jyahA
 NMuOWfy7fuRCCDKHW2dMuZptM/f89jOtccLL+U2gfgfBvP1c4o3yHZLJhIgIL/JUSKnoU+
 /+BFD9/cFPqdGl1TxEROwS9KODAKcgQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-38Z7vPedMK2WbRQ65HhtUw-1; Thu, 25 Jan 2024 12:32:49 -0500
X-MC-Unique: 38Z7vPedMK2WbRQ65HhtUw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2d1e1fa245so310885066b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706203968; x=1706808768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlyXHXLezAMliACVNbPNFAQBlgifrPDgzPLngRgk11A=;
 b=XD4mmvXPvCt6+2q+WdJOpl7SfCk8X0cGHUd12WeFXexkc9Z3+Qfp49eIbfNalCmpWs
 F+43F1jMsbSxkyaIwVvgZfk3MscdZyMrdjxe++kF66kv4avLyVNlGjlb9kz+HGrZpdgG
 FJ/qaUxB7/wYrX4Slr2axKm0QP/ybyyRyZZ9XF/Tu+xvmMkitI1P6czWXgSYh+7FXSpL
 6TVJsLWFjF+3Pgi7ZypfyLYzxxImwgCBhZGx/bb1Zu7O7SDWszi0+FcNvsYB0dWDJ2zo
 pQUeJJFmc/fi04eB4F7lmQ46pDVKfJbPgo6SLqo878TiJlY53FHMRjO0SWYsOm+FKXN8
 ATHQ==
X-Gm-Message-State: AOJu0YzQEL3Y/54UOWzcd4DSr77s5lAyh6qE2RN3nDerVqWHFIsFKHiU
 gLRHmOznUwcPkNIDeUIhWY7HOdhQzYwC5nFIZPURL+k9bjwTgOK0j8SQIfgzWA83Vj3Tt2Cl6/h
 GfQhkDdrzVWhQkAcndycG5335xcmazrUUtwe3wCq/4cwVePWuGrHW
X-Received: by 2002:a17:907:c313:b0:a32:2205:6ad9 with SMTP id
 tl19-20020a170907c31300b00a3222056ad9mr307173ejc.295.1706203968191; 
 Thu, 25 Jan 2024 09:32:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0rYlLb3jVgJrGvD076yy09SQsw94sU8PvEw0UuC2yArIGsuNnfpOkL3haK50oP5jVHH4qcw==
X-Received: by 2002:a17:907:c313:b0:a32:2205:6ad9 with SMTP id
 tl19-20020a170907c31300b00a3222056ad9mr307168ejc.295.1706203967877; 
 Thu, 25 Jan 2024 09:32:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVgGiiLwCopcOz00eAewnuyfXB3zBZ1Cy6fH49AEJAd6RR0glqIcMI2LdtzD8/yeiha72Dcsm8GFaJd3fZgTw6jkmKQNTnWxuZNrxJdBYRAbrJH5DPxRgHCjQo=
Received: from ?IPV6:2003:cf:d73b:4169:9eef:dd9f:57fb:1235?
 (p200300cfd73b41699eefdd9f57fb1235.dip0.t-ipconnect.de.
 [2003:cf:d73b:4169:9eef:dd9f:57fb:1235])
 by smtp.gmail.com with ESMTPSA id
 cm2-20020a170907938200b00a2cc5199dd0sm1238341ejc.135.2024.01.25.09.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 09:32:47 -0800 (PST)
Message-ID: <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
Date: Thu, 25 Jan 2024 18:32:46 +0100
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> My reproducer for https://issues.redhat.com/browse/RHEL-3934 now breaks more
>> often because of this commit than because of the original bug, i.e. when
>> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
>> this tends to happen when unplugging the scsi-hd:
>>
>> {"execute":"device_del","arguments":{"id":"stg0"}}
>> {"return": {}}
>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>> Assertion `ctx == blk->ctx' failed.

[...]

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

Actually, now that completely unproblematic part is giving me trouble.  
I wanted to just put a graph lock into blk_get_aio_context() (making it 
a coroutine with a wrapper), but callers of blk_get_aio_context() 
generally assume the context is going to stay the BB’s context for as 
long as their AioContext * variable is in scope.  I was tempted to think 
callers know what happens to the BB they pass to blk_get_aio_context(), 
and it won’t change contexts so easily, but then I remembered this is 
exactly what happens in this case; we run 
scsi_device_for_each_req_async_bh() in one thread (which calls 
blk_get_aio_context()), and in the other, we change the BB’s context.

It seems like there are very few blk_* functions right now that require 
taking a graph lock around it, so I’m hesitant to go that route.  But if 
we’re protecting a BB’s context via the graph write lock, I can’t think 
of a way around having to take a read lock whenever reading a BB’s 
context, and holding it for as long as we assume that context to remain 
the BB’s context.  It’s also hard to figure out how long that is, case 
by case; for example, dma_blk_read() schedules an AIO function in the BB 
context; but we probably don’t care that this context remains the BB’s 
context until the request is done.  In the case of 
scsi_device_for_each_req_async_bh(), we already take care to re-schedule 
it when it turns out the context is outdated, so it does seem quite 
important here, and we probably want to keep the lock until after the 
QTAILQ_FOREACH_SAFE() loop.

On a tangent, this TOCTTOU problem makes me wary of other blk_* 
functions that query information.  For example, fuse_read() (in 
block/export/fuse.c) truncates requests to the BB length.  But what if 
the BB length changes concurrently between blk_getlength() and 
blk_pread()?  While we can justify using the graph lock for a BB’s 
AioContext, we can’t use it for other metadata like its length.

Hanna


