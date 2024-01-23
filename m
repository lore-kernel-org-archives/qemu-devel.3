Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD5C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKT3-0003rz-Ry; Tue, 23 Jan 2024 12:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSKSt-0003qr-6o
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSKSn-0003gH-Jf
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706030486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhvvBinHEUtrc7/DQaqhpNPPKz+Mi8pw4sn6QqGIZO4=;
 b=PnveBkmAf4UOlIxKNlHYipOukS2fJBLGP85CD5o4+AlgST3jqp+OUk7TPE4kYZimFUSfgd
 9IlnyTy/iO9ceUKMf7hmIeGn22IQFWGKeXIXBoG/oaxf+XHyFwEE1340wOgAY4qGCFRTOK
 vIspDIKqM1KBXmjBtsiGcPcucToq0zU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-_gGndE1ANEakDA_sKsV36A-1; Tue, 23 Jan 2024 12:21:25 -0500
X-MC-Unique: _gGndE1ANEakDA_sKsV36A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6800aa45af1so66664416d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030483; x=1706635283;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhvvBinHEUtrc7/DQaqhpNPPKz+Mi8pw4sn6QqGIZO4=;
 b=SvriadbBTvh0spTaB/l2t0J5tPTgb84xiiz+imlWTEPNhywZI6FNcFn3INKj9uO7DD
 Fz53glZx/1uAM8Md55XwoZT89MTM/v8YzQLEDtO5x/t+1roMT8c9xtzNabpGnQg4hEoo
 Z1n408DhKSo8acZSDyokFWPlNaRDAsECDQO3EanppaCGluNaJOCV+MDVM1LZaRVWJ5EZ
 H1jEJEk+WHfYGb7gsjjEFdUXfCNiI2IlXzs1IBnPtmhUYI/UpVhddLe9hrLX06gAbOns
 3KG9Dop2OP/t4h8Epxm4juk1J649GwQ6g40aaGsUG8BeZ8E6jBkAeP1G7aBRWhQA4Obf
 0HwQ==
X-Gm-Message-State: AOJu0YzK3WafFVa+ujcUF1lBEG5fo5ZU4GlsZ8xKqEA2zMYcSLI3YDzF
 b3688mo3To9SjEYGK55AdT9xgRSTfluQ9q42Ev/9Kn+gtmwAqjWdw/gW+LN9Vw/nkRjf0+3jhf+
 1jeyVtjRd3iVmtm+po+lCey7jerSx2Lq9FnIwnj5LvynO1aFkDQRkkLGGy2um
X-Received: by 2002:a05:6214:21ef:b0:686:2659:a244 with SMTP id
 p15-20020a05621421ef00b006862659a244mr1290489qvj.70.1706030483679; 
 Tue, 23 Jan 2024 09:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqz2GgvMYUEVv3BliVjVnh7o5cWTtTC9fJGcS1B0Y0ayZb/CB65s89XmYSLBDkk6A970sJ8Q==
X-Received: by 2002:a05:6214:21ef:b0:686:2659:a244 with SMTP id
 p15-20020a05621421ef00b006862659a244mr1290475qvj.70.1706030483312; 
 Tue, 23 Jan 2024 09:21:23 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 lb25-20020a056214319900b00685ba831e4bsm3375000qvb.118.2024.01.23.09.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 09:21:22 -0800 (PST)
Message-ID: <8f0d1bf4-c4d1-411f-ad8b-b9dfa7dd6e74@redhat.com>
Date: Tue, 23 Jan 2024 18:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
In-Reply-To: <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23.01.24 17:40, Hanna Czenczek wrote:
> On 21.12.23 22:23, Kevin Wolf wrote:
>> From: Stefan Hajnoczi<stefanha@redhat.com>
>>
>> Stop depending on the AioContext lock and instead access
>> SCSIDevice->requests from only one thread at a time:
>> - When the VM is running only the BlockBackend's AioContext may access
>>    the requests list.
>> - When the VM is stopped only the main loop may access the requests
>>    list.
>>
>> These constraints protect the requests list without the need for locking
>> in the I/O code path.
>>
>> Note that multiple IOThreads are not supported yet because the code
>> assumes all SCSIRequests are executed from a single AioContext. Leave
>> that as future work.
>>
>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>> Reviewed-by: Eric Blake<eblake@redhat.com>
>> Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>> ---
>>   include/hw/scsi/scsi.h |   7 +-
>>   hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
>>   2 files changed, 131 insertions(+), 57 deletions(-)
[...]

> I don’t know anything about the problem yet, but as usual, I like 
> speculation and discovering how wrong I was later on, so one thing I 
> came across that’s funny about virtio-scsi is that requests can happen 
> even while a disk is being attached or detached.  That is, Linux seems 
> to probe all LUNs when a new virtio-scsi device is being attached, and 
> it won’t stop just because a disk is being attached or removed.  So 
> maybe that’s part of the problem, that we get a request while the BB 
> is being detached, and temporarily in an inconsistent state (BDS 
> context differs from BB context).
>
> I’ll look more into it.

What I think happens is that scsi_device_purge_requests() runs (perhaps 
through virtio_scsi_hotunplug() -> qdev_simple_device_unplug_cb() -> 
scsi_qdev_unrealize()?), which schedules 
scsi_device_for_each_req_async_bh() to run, but doesn’t await it.  We go 
on, begin to move the BB and its BDS back to the main context (via 
blk_set_aio_context() in virtio_scsi_hotunplug()), but 
scsi_device_for_each_req_async_bh() still runs in the I/O thread, it 
calls blk_get_aio_context() while the contexts are inconsistent, and we 
get the crash.

There is a comment above blk_get_aio_context() in 
scsi_device_for_each_req_async_bh() about the BB potentially being moved 
to a different context prior to the BH running, but it doesn’t consider 
the possibility that that move may occur *concurrently*.

I don’t know how to fix this, though.  The whole idea of anything 
happening to a BB while it is being moved to a different context seems 
so wrong to me that I’d want to slap a big lock on it, but I have the 
feeling that that isn’t what we want.

Hanna


