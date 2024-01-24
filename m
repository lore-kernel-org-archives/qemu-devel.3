Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998F2C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSc7q-00048t-EP; Wed, 24 Jan 2024 07:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSc7o-00046U-Jr
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSc7j-0000xT-MK
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706098374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fbv7RXp+qxP9P1RZSNBJGJO8Pf8GPVJZCX/HAArbneM=;
 b=XiQ4xW/ThYGYePySTuLwDTLfkHsmp3ViK7VN2yEZay0ZqunZam2CigECkldfeE3iDqG67x
 EkbWr3iHgSjifBXgCRPweXdQOSyPU9zhlMfhGx3A6v8WZ7AfAhvQlR1Cczh6OEEa9Nj7Zc
 UoLb1v5Ra8hOE6s007dHd4K0cSAQmZI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-AilnOp-fPACBr54ZkAAp9g-1; Wed, 24 Jan 2024 07:12:52 -0500
X-MC-Unique: AilnOp-fPACBr54ZkAAp9g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e55470b49so4226919e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 04:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706098370; x=1706703170;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fbv7RXp+qxP9P1RZSNBJGJO8Pf8GPVJZCX/HAArbneM=;
 b=RqPNrdDZihrRJHZOAHh4OsIVOSAWCYTMTPOnpu+Lm61Jcnd7XxrgTyyredvDRZJ2ii
 rEOTtTJSRF8T4O+dXE5d7a9VQAaB7tQR2HyxJIoCjD/NxnnPdjUuzqRsPg9gaeliSlQ/
 lYusKPgO8/0LVpYHZI8Vo+vXlQUW39WIaYEYbD9qqvEe7NJ1IG3ndrH8IgGxfKzVA87d
 2tVm16XJi9lI0gzBEG2SqMSPQQ5Zq90vSFsiOigi/u57qDOzNU9z/2Yk4Syln6peBsLW
 sLfgnUxByjOC3OxDBBMjYQgJDZeruC2iqDg8Kxx+Mq76yUGLVx+wiFwKWMlP3nn5FO55
 pDdQ==
X-Gm-Message-State: AOJu0YxjOWopk6cB2NGGzr+Hu7JJy++1S0c8OQ5aqJvhT+AIgNKtyIlA
 v7wkSvgOPfmKkWKi6x0uXXe/LTrblOdbe8LmorMDueAcjgcwdFBfOF1ePeKWWAGOZHG8ajGxEMZ
 VM17BgDaMf3Lhgyjk1wl3QYZvD1erotORq4tIk3KD1BroO9xrumbA
X-Received: by 2002:a19:5f1d:0:b0:50e:ac2a:6b59 with SMTP id
 t29-20020a195f1d000000b0050eac2a6b59mr3180907lfb.120.1706098370635; 
 Wed, 24 Jan 2024 04:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/9gvi6Qg0YJCIb4W4ZQexszW4INTPyTF+P6hVFDnWaCuWq5ZfcZqCXY9B2Eh8xIZyrruRow==
X-Received: by 2002:a19:5f1d:0:b0:50e:ac2a:6b59 with SMTP id
 t29-20020a195f1d000000b0050eac2a6b59mr3180898lfb.120.1706098370205; 
 Wed, 24 Jan 2024 04:12:50 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:41d9:5581:da3:1344:320c?
 (p200300cfd73b41d955810da31344320c.dip0.t-ipconnect.de.
 [2003:cf:d73b:41d9:5581:da3:1344:320c])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a193818000000b005100dc5faf8sm239582lfa.178.2024.01.24.04.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 04:12:49 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------5G0XJLuenLrKDGzI7Nj9AIcu"
Message-ID: <dcaea54b-f3de-4ba6-8ae6-313778689f74@redhat.com>
Date: Wed, 24 Jan 2024 13:12:47 +0100
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
--------------5G0XJLuenLrKDGzI7Nj9AIcu
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

[...]

> I don't know anything about the problem either, but since you already
> speculated about the cause, let me speculate about the solution:
> Can we hold the graph writer lock for the tran_commit() call in
> bdrv_try_change_aio_context()? And of course take the reader lock for
> blk_get_aio_context(), but that should be completely unproblematic.

I tried this, and it’s not easy taking the lock just for tran_commit(), 
because some callers of bdrv_try_change_aio_context() already hold the 
write lock (specifically bdrv_attach_child_common(), 
bdrv_attach_child_common_abort(), and bdrv_root_unref_child()[1]), and 
qmp_x_blockdev_set_iothread() holds the read lock.  Other callers don’t 
hold any lock[2].

So I’m not sure whether we should mark all of 
bdrv_try_change_aio_context() as GRAPH_WRLOCK and then make all callers 
take the lock, or really only take it for tran_commit(), and have 
callers release the lock around bdrv_try_change_aio_context(). Former 
sounds better to naïve me.

(In any case, FWIW, having blk_set_aio_context() take the write lock, 
and scsi_device_for_each_req_async_bh() take the read lock[3], does fix 
the assertion failure.)

Hanna

[1] bdrv_root_unref_child() is not marked as GRAPH_WRLOCK, but it’s 
callers generally seem to ensure that the lock is taken when calling it.

[2] blk_set_aio_context() (evidently), blk_exp_add(), 
external_snapshot_abort(), {blockdev,drive}_backup_action(), 
qmp_{blockdev,drive}_mirror()

[3] I’ve made the _bh a coroutine (for bdrv_graph_co_rdlock()) and 
replaced the aio_bh_schedule_oneshot() by aio_co_enter() – hope that’s 
right.
--------------5G0XJLuenLrKDGzI7Nj9AIcu
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
Assertion `ctx == blk-&gt;ctx' failed.</pre>
      </blockquote>
    </blockquote>
    <br>
    [...]<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:Za_zAj11uwavd2va@redhat.com">
      <pre class="moz-quote-pre" wrap="">I don't know anything about the problem either, but since you already
speculated about the cause, let me speculate about the solution:
Can we hold the graph writer lock for the tran_commit() call in
bdrv_try_change_aio_context()? And of course take the reader lock for
blk_get_aio_context(), but that should be completely unproblematic.</pre>
    </blockquote>
    <br>
    I tried this, and it’s not easy taking the lock just for
    tran_commit(), because some callers of bdrv_try_change_aio_context()
    already hold the write lock (specifically
    bdrv_attach_child_common(), bdrv_attach_child_common_abort(), and
    bdrv_root_unref_child()[1]), and qmp_x_blockdev_set_iothread() holds
    the read lock.  Other callers don’t hold any lock[2].<br>
    <br>
    So I’m not sure whether we should mark all of
    bdrv_try_change_aio_context() as GRAPH_WRLOCK and then make all
    callers take the lock, or really only take it for tran_commit(), and
    have callers release the lock around bdrv_try_change_aio_context(). 
    Former sounds better to naïve me.<br>
    <br>
    (In any case, FWIW, having blk_set_aio_context() take the write
    lock, and scsi_device_for_each_req_async_bh() take the read lock[3],
    does fix the assertion failure.)<br>
    <br>
    Hanna<br>
    <br>
    [1] bdrv_root_unref_child() is not marked as GRAPH_WRLOCK, but it’s
    callers generally seem to ensure that the lock is taken when calling
    it.<br>
    <br>
    [2] blk_set_aio_context() (evidently), blk_exp_add(),
    external_snapshot_abort(), {blockdev,drive}_backup_action(),
    qmp_{blockdev,drive}_mirror()<br>
    <br>
    [3] I’ve made the _bh a coroutine (for bdrv_graph_co_rdlock()) and
    replaced the aio_bh_schedule_oneshot() by aio_co_enter() – hope
    that’s right.<br>
  </body>
</html>

--------------5G0XJLuenLrKDGzI7Nj9AIcu--


