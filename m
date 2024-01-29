Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4AAC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUXD-0004ys-EN; Mon, 29 Jan 2024 11:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rUUX6-0004yS-IH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rUUX3-0007lU-EE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706545848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGIQgVqi2n6RWeMWuOfDO//xU9Q9x8E3KazQ0T2Wtwo=;
 b=Qbwu6Ao0pX11EJZ4+LEhkUBZ6+oCCsm77oEClm6rGEu97v/FQokxoKENOBpKHsKp4ouZ19
 R4aLZwzCKQWlQtuFnZZwfu9gT94i921MSY5YcPKYq+d0iwibBw29E30hKQZYVnGNl3k8Hq
 s4L8x8fjyQr4FltupYMUd5bzsGkRWCc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-WAD_LNWuNmmW95ST8MGjTw-1; Mon, 29 Jan 2024 11:30:47 -0500
X-MC-Unique: WAD_LNWuNmmW95ST8MGjTw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ae4fd9c3cso977177f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706545845; x=1707150645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hGIQgVqi2n6RWeMWuOfDO//xU9Q9x8E3KazQ0T2Wtwo=;
 b=KcyKlLaoRF8F+XcYnX/YS7U0vFaMzCavqgQL7sB5n93C5vYsBfJ1q5MR7BRXdDzng6
 vjNpjKUwTbhl8V8VpcgHFbSBVGe1Nxfs75Uu+q4a0xjOuXTn5DF1wbAka33AgfNRoT7k
 OOCqDOJmfEve7RUp3W45I5x6sJStukix7nQkYzTZCO+FZE67lt+8sKkIx14rfEi5QFIU
 ezMrLMsD9awwJ7SB3x0cYT7qWIUVcpOslmciV1ioLMf+HSrIzWqL1jiUFN9i4409/mHQ
 oNFRaLzejCivO6KyGSZy1bmcQxwsQy0zpiKkH3A52K269xYWzgH4FEG4wxiFj1MDN68C
 1mFQ==
X-Gm-Message-State: AOJu0YzRDlny6PYNHlsY/NkCtxaeqipkQ8PoUv6ykR5lTYl/jxfLvyTU
 8cNr9zGFAJa2GEp7PT5uvkY3Rcvptp4wPyRlHXJM75e8eoQi2Yu+a4nKdS68c+6NCQoZiIpexk6
 FbHW/AiQFx/u0BVI7o5LuyhLHmZ6/YluD3EqG/LheAotloHyLgm7sjgZJ/iur
X-Received: by 2002:adf:fa92:0:b0:33a:eb25:31a2 with SMTP id
 h18-20020adffa92000000b0033aeb2531a2mr3192858wrr.67.1706545845134; 
 Mon, 29 Jan 2024 08:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw9hXCeFh+/nSUYtQ3DcBr7qEz4OFmnTJ85HM92TSW1L9yrKj8lAYgoHNK0w6fqMtlPkyvmA==
X-Received: by 2002:adf:fa92:0:b0:33a:eb25:31a2 with SMTP id
 h18-20020adffa92000000b0033aeb2531a2mr3192831wrr.67.1706545844587; 
 Mon, 29 Jan 2024 08:30:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXQElY4nBINt7DGT9jLb7lOaThq6ImlugaYjaoJMyGGbu0g5LY3gxXKHEXavqOGTJL7Pa3a4Dw4yHO/XDy7iVx67Z/84aXzFf940aWBU7LPho6LfA/KboRg1gM=
Received: from ?IPV6:2003:cf:d73b:41c3:ec2e:57a5:78bb:25b0?
 (p200300cfd73b41c3ec2e57a578bb25b0.dip0.t-ipconnect.de.
 [2003:cf:d73b:41c3:ec2e:57a5:78bb:25b0])
 by smtp.gmail.com with ESMTPSA id
 bk7-20020a0560001d8700b0033addbf2d2csm7966905wrb.9.2024.01.29.08.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 08:30:43 -0800 (PST)
Message-ID: <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
Date: Mon, 29 Jan 2024 17:30:42 +0100
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> bdrv_try_change_aio_context()?

Removing the drain to allow for all of bdrv_try_change_aio_context() to 
require GRAPH_WRLOCK, but that broke tests/unit/test-block-iothread, 
because without draining, block jobs would need to switch AioContexts 
while running, and job_set_aio_context() doesn’t like that.  Similarly 
to blk_get_aio_context(), I assume we can in theory just drop the 
assertion there and change the context while the job is running, because 
then the job can just change AioContexts on the next pause point (and in 
the meantime send requests from the old context, which is fine), but 
this does get quite murky.  (One rather virtual (but present) problem is 
that test-block-iothread itself contains some assertions in the job that 
its AioContext is actually the on its running in, but this assertion 
would no longer necessarily hold true.)

I don’t like using drain as a form of lock specifically against 
AioContext changes, but maybe Stefan is right, and we should use it in 
this specific case to get just the single problem fixed.  (Though it’s 
not quite trivial either.  We’d probably still want to remove the 
assertion from blk_get_aio_context(), so we don’t have to require all of 
its callers to hold a count in the in-flight counter.)

Hanna


