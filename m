Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08126C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJpV-00014i-6U; Tue, 23 Jan 2024 11:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSJpT-000149-Hz
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSJpP-0003Gb-Ok
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706028044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KobH5MX03kEU0/Zo2QEsyU3yjbYsZ/IZn/OfGuHqZp0=;
 b=OTWPjVOTd/ptrWOvzH2OMHnuaZkkn5DFa2gGhEtaehFSMtAgEj1aRA3v22PCPy0FDGJRG8
 DdidqIDKfV2zTa9Ws2VgFrChxak1XWzdnjOclcU54PmcGEEuwtxKdCnppg3EP4P57/QqIq
 EXp+GxlQg7qTNRzV0O7a49qfioAKrm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Ma41hbL8PoqGkADw0zOe1w-1; Tue, 23 Jan 2024 11:40:41 -0500
X-MC-Unique: Ma41hbL8PoqGkADw0zOe1w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e479a51e4so25145585e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706028041; x=1706632841;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KobH5MX03kEU0/Zo2QEsyU3yjbYsZ/IZn/OfGuHqZp0=;
 b=h01z4rJXKNnY1l51M2Cc2D/7Z8QPMWOSPRv9YdIhNKYkId2rrJ/o/Ev218wnLFJ/MQ
 RdIscptnsRqx7J1yCmY3hDoy/prutv7RTj/71vYdjTPtvHmeKAQ3K/4C4koak++NLLVb
 jQSB39oy+V/HHJCp9Ev6NJxLjGgGvhsvXpVLLl/RTZRMOcpdt5TE2YPyhYrfStkVVy+w
 abWQWch6FXGF3sEOPS63T26INNo+UURrXHgg2/xZyK5Wgc2fsf4vTvLONicLR9AUPCY5
 oYHwN1sXdLPNk9wgnCyrX1D4sQcSmLcy6LMAfIDA6yCMJdATlcdV0vYTmMch2pRppNQe
 oGuA==
X-Gm-Message-State: AOJu0Yy0l41c173/NvuF0DV7/Y+TU23w1708xAExxSXFsN6fPuVnd0P4
 suhBrTAkQfWPml637Vf4yFbc4mKwJpgn8hyZutGqY2wOZeCIlgc6tor7p4sfihjJJhUk7iqzoxN
 GwC5VAMQrOfZpiP1kzHAeChAtXfaKlS0DeQByJywXnmib2bDW6QNR
X-Received: by 2002:a05:600c:18a5:b0:40d:b191:10e with SMTP id
 x37-20020a05600c18a500b0040db191010emr306739wmp.175.1706028040778; 
 Tue, 23 Jan 2024 08:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLxFCi+uDdHeHYLVuYy2V+x/cP3f0tuh3hR4v8qmFRBJdQlaYGPs9Ypqhbk5nQKJxUzVgZJQ==
X-Received: by 2002:a05:600c:18a5:b0:40d:b191:10e with SMTP id
 x37-20020a05600c18a500b0040db191010emr306733wmp.175.1706028040345; 
 Tue, 23 Jan 2024 08:40:40 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 bi13-20020a05600c3d8d00b0040e8800fcf3sm22935620wmb.5.2024.01.23.08.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:40:39 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------ykasGuEektmD3i4bNf0Hgwsh"
Message-ID: <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
Date: Tue, 23 Jan 2024 17:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231221212339.164439-12-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
--------------ykasGuEektmD3i4bNf0Hgwsh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.12.23 22:23, Kevin Wolf wrote:
> From: Stefan Hajnoczi<stefanha@redhat.com>
>
> Stop depending on the AioContext lock and instead access
> SCSIDevice->requests from only one thread at a time:
> - When the VM is running only the BlockBackend's AioContext may access
>    the requests list.
> - When the VM is stopped only the main loop may access the requests
>    list.
>
> These constraints protect the requests list without the need for locking
> in the I/O code path.
>
> Note that multiple IOThreads are not supported yet because the code
> assumes all SCSIRequests are executed from a single AioContext. Leave
> that as future work.
>
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> ---
>   include/hw/scsi/scsi.h |   7 +-
>   hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>   2 files changed, 131 insertions(+), 57 deletions(-)

My reproducer for https://issues.redhat.com/browse/RHEL-3934 now breaks 
more often because of this commit than because of the original bug, i.e. 
when repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd 
device, this tends to happen when unplugging the scsi-hd:

{"execute":"device_del","arguments":{"id":"stg0"}}
{"return": {}}
qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context: 
Assertion `ctx == blk->ctx' failed.

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
#10 0x0000556e6b4564b6 in iothread_run 
(opaque=opaque@entry=0x556e6d89d920) at ../iothread.c:63
#11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at 
../util/qemu-thread-posix.c:541
#12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6
#13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6

I don’t know anything about the problem yet, but as usual, I like 
speculation and discovering how wrong I was later on, so one thing I 
came across that’s funny about virtio-scsi is that requests can happen 
even while a disk is being attached or detached.  That is, Linux seems 
to probe all LUNs when a new virtio-scsi device is being attached, and 
it won’t stop just because a disk is being attached or removed.  So 
maybe that’s part of the problem, that we get a request while the BB is 
being detached, and temporarily in an inconsistent state (BDS context 
differs from BB context).

I’ll look more into it.

Hanna
--------------ykasGuEektmD3i4bNf0Hgwsh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 21.12.23 22:23, Kevin Wolf wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20231221212339.164439-12-kwolf@redhat.com">
      <pre class="moz-quote-pre" wrap="">From: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>

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

Signed-off-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
Reviewed-by: Eric Blake <a class="moz-txt-link-rfc2396E" href="mailto:eblake@redhat.com">&lt;eblake@redhat.com&gt;</a>
Message-ID: <a class="moz-txt-link-rfc2396E" href="mailto:20231204164259.1515217-2-stefanha@redhat.com">&lt;20231204164259.1515217-2-stefanha@redhat.com&gt;</a>
Signed-off-by: Kevin Wolf <a class="moz-txt-link-rfc2396E" href="mailto:kwolf@redhat.com">&lt;kwolf@redhat.com&gt;</a>
---
 include/hw/scsi/scsi.h |   7 +-
 hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
 2 files changed, 131 insertions(+), 57 deletions(-)
</pre>
    </blockquote>
    <br>
    My reproducer for <a class="moz-txt-link-freetext" href="https://issues.redhat.com/browse/RHEL-3934">https://issues.redhat.com/browse/RHEL-3934</a> now
    breaks more often because of this commit than because of the
    original bug, i.e. when repeatedly hot-plugging and unplugging a
    virtio-scsi and a scsi-hd device, this tends to happen when
    unplugging the scsi-hd:<br>
    <br>
    {"execute":"device_del","arguments":{"id":"stg0"}}<br>
    {"return": {}}<br>
    qemu-system-x86_64: ../block/block-backend.c:2429:
    blk_get_aio_context: Assertion `ctx == blk-&gt;ctx' failed.<br>
    <br>
    (gdb) bt<br>
    #0  0x00007f32a668d83c in  () at /usr/lib/libc.so.6<br>
    #1  0x00007f32a663d668 in raise () at /usr/lib/libc.so.6<br>
    #2  0x00007f32a66254b8 in abort () at /usr/lib/libc.so.6<br>
    #3  0x00007f32a66253dc in  () at /usr/lib/libc.so.6<br>
    #4  0x00007f32a6635d26 in  () at /usr/lib/libc.so.6<br>
    #5  0x0000556e6b4880a4 in blk_get_aio_context (blk=0x556e6e89ccf0)
    at ../block/block-backend.c:2429<br>
    #6  blk_get_aio_context (blk=0x556e6e89ccf0) at
    ../block/block-backend.c:2417<br>
    #7  0x0000556e6b112d87 in scsi_device_for_each_req_async_bh
    (opaque=0x556e6e2c6d10) at ../hw/scsi/scsi-bus.c:128<br>
    #8  0x0000556e6b5d1966 in aio_bh_poll (ctx=ctx@entry=0x556e6d8aa290)
    at ../util/async.c:218<br>
    #9  0x0000556e6b5bb16a in aio_poll (ctx=0x556e6d8aa290,
    blocking=blocking@entry=true) at ../util/aio-posix.c:722<br>
    #10 0x0000556e6b4564b6 in iothread_run
    (opaque=opaque@entry=0x556e6d89d920) at ../iothread.c:63<br>
    #11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at
    ../util/qemu-thread-posix.c:541<br>
    #12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6<br>
    #13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6<br>
    <br>
    I don’t know anything about the problem yet, but as usual, I like
    speculation and discovering how wrong I was later on, so one thing I
    came across that’s funny about virtio-scsi is that requests can
    happen even while a disk is being attached or detached.  That is,
    Linux seems to probe all LUNs when a new virtio-scsi device is being
    attached, and it won’t stop just because a disk is being attached or
    removed.  So maybe that’s part of the problem, that we get a request
    while the BB is being detached, and temporarily in an inconsistent
    state (BDS context differs from BB context).<br>
    <br>
    I’ll look more into it.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------ykasGuEektmD3i4bNf0Hgwsh--


