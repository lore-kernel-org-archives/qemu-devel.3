Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC52DC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvhO-00088j-46; Thu, 25 Jan 2024 04:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSvhM-000885-6c
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSvhK-0007at-1W
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706173617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkjogFPWy0wQJlrx1nFm5m7lGFRKCfnvtlNbFhEIiZk=;
 b=GtzH/GXjah8bn1vQ3+rf7sMBW4sW7SH8rBmQzX+cv7HpVKYwJb/gaGcnmxUCZdaqzGXknJ
 Qf1UFvZnVcPW296gs72FMAhKuir3LSTFOk81BiLR/i98GJt6jh3TubGRjKCXZhEHHPosKI
 blrSZfWQdIQiMGOgnNS67mHsEEOC40c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-eNzNi-TtO3-anCwE9NiJKA-1; Thu, 25 Jan 2024 04:06:54 -0500
X-MC-Unique: eNzNi-TtO3-anCwE9NiJKA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337cfc83240so4334667f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 01:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706173613; x=1706778413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkjogFPWy0wQJlrx1nFm5m7lGFRKCfnvtlNbFhEIiZk=;
 b=snpYDT5Fs7K3hOhsq51Ja1K6NiB727/u7gtHzlyfu7rGVw9IafTpO8KkRWYkyJRRf8
 QRFa4qx/ZEFXdBGEQbFXgz9ESjXIN/h931L/echp1empSJ9iihRlRCLjX4tEd3QCC8LD
 A2xnE/RjqyX00Bds7dfgMXxcRNwPixA1k4fm9Fph9fWh/ZrHFf3LiVYRADK2FLoCq0uE
 SSi8TNV0yQmDR55gJd8a1tG2d70yQqd1OTYmltDLprpH+bX+TNYOxrsa4W8TR+O9dMKI
 C1zy+4l+H3qOcXm1Q0dTTHezFyYeKEQBRn6RtGlROL+hh346weI225s87OLpkpGxs7hN
 3+Eg==
X-Gm-Message-State: AOJu0Yw3J9fXwWhfqXOosINbZEiuf6uUhu5VV4jPkDY2kqVVpt6dCUDj
 SIfp9tzQVF2rXdDnbcDg46TEcx1YVHyIUk7rJt80sJg/vonhIoaAq9ZhTqaP8FFQOmearwclNlC
 V/hya3tW6a2kO3plPpDpO1U6bueR+T6lK9lJ2zJ7mmHr5A8scp1UV
X-Received: by 2002:adf:fe91:0:b0:337:c258:121 with SMTP id
 l17-20020adffe91000000b00337c2580121mr345064wrr.41.1706173613371; 
 Thu, 25 Jan 2024 01:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkuEZJ+0roLEGMGbUKqY1UsyzVy+zbHEdeTt2ccdXY1l82YjPqbLvcj91jXsFbmJpba59qjg==
X-Received: by 2002:adf:fe91:0:b0:337:c258:121 with SMTP id
 l17-20020adffe91000000b00337c2580121mr345053wrr.41.1706173612930; 
 Thu, 25 Jan 2024 01:06:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVvlVBXD+f82zkIJGrjBWS9B5LqCpd7KXRo/t6ZTna3h9GPk51fsrKp6iNTrMdVysXr2CKMwpA5iNjASqz84jZr7vtCG18p/6hiZiTREu45J1TRHdJpDsZpfWJIkQ==
Received: from ?IPV6:2003:cf:d73b:41d9:5581:da3:1344:320c?
 (p200300cfd73b41d955810da31344320c.dip0.t-ipconnect.de.
 [2003:cf:d73b:41d9:5581:da3:1344:320c])
 by smtp.gmail.com with ESMTPSA id
 bv5-20020a0560001f0500b00337d92e8b9csm549815wrb.109.2024.01.25.01.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 01:06:52 -0800 (PST)
Message-ID: <dce73220-50a8-4339-a430-dcf13f9170ba@redhat.com>
Date: Thu, 25 Jan 2024 10:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <dcaea54b-f3de-4ba6-8ae6-313778689f74@redhat.com>
 <20240124215314.GC609846@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240124215314.GC609846@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On 24.01.24 22:53, Stefan Hajnoczi wrote:
> On Wed, Jan 24, 2024 at 01:12:47PM +0100, Hanna Czenczek wrote:
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
>>>>
>>>> {"execute":"device_del","arguments":{"id":"stg0"}}
>>>> {"return": {}}
>>>> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
>>>> Assertion `ctx == blk->ctx' failed.
>> [...]
>>
>>> I don't know anything about the problem either, but since you already
>>> speculated about the cause, let me speculate about the solution:
>>> Can we hold the graph writer lock for the tran_commit() call in
>>> bdrv_try_change_aio_context()? And of course take the reader lock for
>>> blk_get_aio_context(), but that should be completely unproblematic.
>> I tried this, and it’s not easy taking the lock just for tran_commit(),
>> because some callers of bdrv_try_change_aio_context() already hold the write
>> lock (specifically bdrv_attach_child_common(),
>> bdrv_attach_child_common_abort(), and bdrv_root_unref_child()[1]), and
>> qmp_x_blockdev_set_iothread() holds the read lock.  Other callers don’t hold
>> any lock[2].
>>
>> So I’m not sure whether we should mark all of bdrv_try_change_aio_context()
>> as GRAPH_WRLOCK and then make all callers take the lock, or really only take
>> it for tran_commit(), and have callers release the lock around
>> bdrv_try_change_aio_context(). Former sounds better to naïve me.
>>
>> (In any case, FWIW, having blk_set_aio_context() take the write lock, and
>> scsi_device_for_each_req_async_bh() take the read lock[3], does fix the
>> assertion failure.)
> I wonder if a simpler solution is blk_inc_in_flight() in
> scsi_device_for_each_req_async() and blk_dec_in_flight() in
> scsi_device_for_each_req_async_bh() so that drain
> waits for the BH.
>
> There is a drain around the AioContext change, so as long as
> scsi_device_for_each_req_async() was called before blk_set_aio_context()
> and not _during_ aio_poll(), we would prevent inconsistent BB vs BDS
> aio_contexts.

Actually, Kevin has suggested on IRC that we drop the whole drain. :)

Dropping the write lock in our outside of bdrv_try_change_aio_context() 
for callers that have already taken it seems unsafe, so the only option 
would be to make the whole function write-lock-able.  The drained 
section can cause problems with that if it ends up wanting to reorganize 
the graph, so AFAIU drain should never be done while under a write 
lock.  This is already a problem now because there are three callers 
that do call bdrv_try_change_aio_context() while under a write lock, so 
it seems like we shouldn’t keep the drain as-is.

So, Kevin suggested just dropping that drain, because I/O requests are 
no longer supposed to care about a BDS’s native AioContext anymore 
anyway, so it seems like the need for the drain has gone away with 
multiqueue.  Then we could make the whole function GRAPH_WRLOCK.

Hanna


