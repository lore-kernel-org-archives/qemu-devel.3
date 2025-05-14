Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4338C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF5V9-0003Ga-8D; Wed, 14 May 2025 02:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uF5V7-0003Ci-3n
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:21:57 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uF5V4-00070x-Dr
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:21:56 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30e390ec275so180634a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747203712; x=1747808512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kC130gqx0Vm70PIy3GFhSXd5im9InL+D9A3nvh9FBQs=;
 b=lkIeZ3pzOMX9kVRs+gfgG7brebilgmS78ZjG44rfkvDnA0fK6E8fOruBRKrqR5gkA2
 f/6IU8c5undFfe0Iu4oaytJo/RWnmuAijf3JX4f15+K09HpcsYSL/JdLNgyDQ+r2wDEs
 xlmJloBiPe7m6eomJiX11x3ZOSVz0V4vNZC6jyMnCEMFySUNHT2dVU7KeIJVhG2PHfoz
 Cht1us8ssTBZ5jsV4VwGMNkM4+FCT8mHKaX4NhghpioBcM3HojvJa0lUPVPm0FmSBgPv
 tOKDl+fUnK7KQ5ZOmsubZ/vD7QpqFOpf1KwNn5TVcoLriVvp05n8yshBy1fZTERG4U2z
 79aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747203712; x=1747808512;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kC130gqx0Vm70PIy3GFhSXd5im9InL+D9A3nvh9FBQs=;
 b=pmu2ZvSikikGlEyI9BUoXttV75QSw4h9nOHz3Bo8VXwYq1vky6JtENkNpjI8owdKKk
 vJHvhpfqHE2+YmrHw4oo1z4mL1nehQTGIuRLOOZ9xGKp/69SKUtjsSycksAfopDaSVp/
 Ev8JB9UZ4ITrmsBbiHKPavt4TF2zT+TMYttq0hMeDMIzibQJk/r1Nq8jovte14BvGMi3
 R0skzSob2xzgaeNkgA2GB6ZfxB24s/ihtQC88BpHRQQS9Ap6UHOt64VBaU/+g5lB+Uyp
 Fgou09rAz0q7KF/obQEE1vB2FYoniSyeOn3GeLKPolH+3q0qGhXuz9sytuddi6aCzLqh
 x5sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPMGG/46tI9A4iv4bEk2NhzRSspPkrsFa3ce7RGvFwNii16dATBuSa52ihQ9k5KbAQ9onwchUTi9Yg@nongnu.org
X-Gm-Message-State: AOJu0YzhHIPOUdKodHLWf7d0qzIPjhuuyafhZYc50pIMRSwTqEMpehkn
 Zu0JAQ6hjrR/47y3E6xSFnJffJSFEzqi4vWsp0DJSZ1SoUUWQeLW
X-Gm-Gg: ASbGnctcfvtqeGzRNwRLWkwyk5aVOCR4HO43KnXWlzeysBk5HzlFs3Ol/FLgPZqqr+y
 zKTJHSJbbbSNCT9uxhR5BUYkyH5G3B1wV4Jz+Cj6xW7HYAhFvuXAnEYIJzLVz3avBIVy15xIhDD
 HsX9WJfTVfZRxRFYtDaZaV/EgM9Y1V4k2BN4L7+JBlZJo7fOmbp16c/tWGAD7+zJVm1vdRcMg5o
 GijpuvhvUPTTtGku6tmepYWVvTGDykRk26xE1Cl3jgV9tyjigw4Kk4N6GCV6ZirEx1ebnedbKnu
 OKSJZhK0JV03LV7SZvOf7+fjq08wYN4V8mLgbPj75Mn4IEHurGa/oX7ZiPxysxcWHgl/gIjAHWd
 3OQmGf6Cf27XwwKSD26M=
X-Google-Smtp-Source: AGHT+IH7RqGs6n52Q87brKW2BvUV1Eh2//j6AqNYeHOkQoAF2pPpmDiri0/Vk3URmHyFafycNiyBZA==
X-Received: by 2002:a17:90b:3cd0:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-30e2e62a959mr3151505a91.26.1747203711976; 
 Tue, 13 May 2025 23:21:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:9158:b92b:c88b:bc73:2408?
 ([2401:4900:1c44:9158:b92b:c88b:bc73:2408])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e334147acsm736181a91.1.2025.05.13.23.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 23:21:51 -0700 (PDT)
Message-ID: <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
Date: Wed, 14 May 2025 11:51:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Apologies, I haven't been in touch for a while. I have an update that
I would like to give.

On 4/16/25 12:50 PM, Eugenio Perez Martin wrote:
> On Mon, Apr 14, 2025 at 11:20 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
>>> On Mon, Mar 24, 2025 at 2:59 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> I managed to fix a few issues while testing this patch series.
>>>> There is still one issue that I am unable to resolve. I thought
>>>> I would send this patch series for review in case I have missed
>>>> something.
>>>>
>>>> The issue is that this patch series does not work every time. I
>>>> am able to ping L0 from L2 and vice versa via packed SVQ when it
>>>> works.
>>>
>>> So we're on a very good track then!
>>>
>>>> When this doesn't work, both VMs throw a "Destination Host
>>>> Unreachable" error. This is sometimes (not always) accompanied
>>>> by the following kernel error (thrown by L2-kernel):
>>>>
>>>> virtio_net virtio1: output.0:id 1 is not a head!
>>>>
>>>
>>> How many packets have been sent or received before hitting this? If
>>> the answer to that is "the vq size", maybe there is a bug in the code
>>> that handles the wraparound of the packed vq, as the used and avail
>>> flags need to be twisted. You can count them in the SVQ code.
>>
>> I did a lot more testing. This issue is quite unpredictable in terms
>> of the time at which it appears after booting L2. So far, it almost
>> always appears after booting L2. Even when pinging works, this issue
>> appears after several seconds of pinging.
>>
> 
> Maybe you can speed it up with ping -f?

Thank you, I was able to run tests much faster with the -f option. So
far I have noticed that the RX queue does not give problems. When all
the descriptors are used it is able to wrap around without issues.

>> The total number of svq descriptors varied in every test run. But in
>> every case, all 256 indices were filled in the descriptor region for
>> vq with vq_idx = 0. This is the RX vq, right?
> 
> Right!

The TX queue seems to be problematic. More on this below.

>> This was filled while L2
>> was booting. In the case when the ctrl vq is disabled, I am not sure
>> what is responsible for filling the vqs in the data plane during
>> booting.
>>
> The nested guest's driver fills the rx queue at startup. After that,
> that nested guest kicks and SVQ receives the descriptors. It copies
> the descriptors to the shadow virtqueue and then kicks L0 QEMU.

Understood.

>> =====
>> The issue is hit most frequently when the following command is run
>> in L0:
>> $ ip addr add 111.1.1.1/24 dev tap0
>> $ ip link set tap0 up
>>
>> or, running the following in L2:
>> # ip addr add 111.1.1.2/24 dev eth0
>>
> 
> I guess those are able to start the network, aren't they?

Yes, that's correct.

>> The other vq (vq_idx=1) is not filled completely before the issue is
>> hit.
>> I have been noting down the numbers and here is an example:
>>
>> 295 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
>> |_ 256 additions in vq_idx = 0, all with unique ids
>>       |---- 27 descriptors (ids 0 through 26) were received later from the device (vhost_svq_get_buf_packed)
>> |_ 39 additions in vq_idx = 1
>>       |_ 13 descriptors had id = 0
>>       |_ 26 descriptors had id = 1
>>       |---- All descriptors were received at some point from the device (vhost_svq_get_buf_packed)
>>
>> There was one case in which vq_idx=0 had wrapped around. I verified
>> that flags were set appropriately during the wrap (avail and used flags
>> were flipped as expected).
>>
> 
> Ok sounds like you're able to reach it before filling the queue. I'd
> go for debugging notifications for this one then. More on this below.
> 
>> =====
>> The next common situation where this issue is hit is during startup.
>> Before L2 can finish booting successfully, this error is thrown:
>>
>> virtio_net virtio1: output.0:id 0 is not a head!
>>
>> 258 descriptors were added individually to the queues during startup (there were no chains) (vhost_svq_add_packed)
>> |_ 256 additions in vq_idx = 0, all with unique ids
>>      |---- None of them were received by the device (vhost_svq_get_buf_packed)
>> |_ 2 additions in vq_idx = 1
>>      |_ id = 0 in index 0
>>      |_ id = 1 in index 1
>>      |---- Both descriptors were received at some point during startup from the device (vhost_svq_get_buf_packed)
>>
>> =====
>> Another case is after several seconds of pinging L0 from L2.
>>
>> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
>>
> 
> So the L2 guest sees a descriptor it has not made available
> previously. This can be caused because SVQ returns the same descriptor
> twice, or it doesn't fill the id or flags properly. It can also be
> caused because we're not protecting the write ordering in the ring,
> but I don't see anything obviously wrong by looking at the code.
> 
>> 366 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
>> |_ 289 additions in vq_idx = 0, wrap-around was observed with avail and used flags inverted for 33 descriptors
>> |   |---- 40 descriptors (ids 0 through 39) were received from the device (vhost_svq_get_buf_packed)
>> |_ 77 additions in vq_idx = 1
>>       |_ 76 descriptors had id = 0
>>       |_ 1 descriptor had id = 1
>>       |---- all 77 descriptors were received at some point from the device (vhost_svq_get_buf_packed)
>>
>> I am not entirely sure now if there's an issue in the packed vq
>> implementation in QEMU or if this is being caused due to some sort
>> of race condition in linux.
>>
>> "id is not a head" is being thrown because vq->packed.desc_state[id].data
>> doesn't exist for the corresponding id in Linux [1]. But QEMU seems to have
>> stored some data for this id via vhost_svq_add() [2]. Linux sets the value
>> of vq->packed.desc_state[id].data in its version of virtqueue_add_packed() [3].
>>
> 
> Let's keep debugging further. Can you trace the ids that the L2 kernel
> makes available, and then the ones that it uses? At the same time, can
> you trace the ids that the svq sees in vhost_svq_get_buf and the ones
> that flushes? This allows us to check the set of available descriptors
> at any given time.
> 
In the linux kernel, I am printing which descriptor is received in which
queue in drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_packed() [1].
I see the following lines getting printed for the TX queue:

[  192.101591] output.0 -> id: 0
[  213.737417] output.0 -> id: 0
[  213.738714] output.0 -> id: 1
[  213.740093] output.0 -> id: 0
[  213.741521] virtio_net virtio1: output.0:id 0 is not a head!

In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_add_packed(), I am
printing the head_idx, id, len, flags and vq_idx. Just before the crash,
the following lines are printed:

head_idx: 157, id: 0, len: 122, flags: 32768, vq idx: 1
head_idx: 158, id: 0, len: 122, flags: 32768, vq idx: 1
head_idx: 159, id: 0, len: 66, flags: 32768, vq idx: 1
head_idx: 160, id: 1, len: 102, flags: 32768, vq idx: 1

In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf_packed(), I
am printing the id, last_used index, used wrap counter and vq_idx. These
are the lines just before the crash:

id: 0, last_used: 158, used_wrap_counter: 0, vq idx: 1
id: 0, last_used: 159, used_wrap_counter: 0, vq idx: 1
id: 0, last_used: 160, used_wrap_counter: 0, vq idx: 1
id: 1, last_used: 161, used_wrap_counter: 0, vq idx: 1

In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush() [2], I am tracking
the values of i and vq_idx in the outer do..while() loop as well as in the inner
while(true) loop. The value of i is used as the "idx" in virtqueue_fill() [3] and
as "count" in virtqueue_flush() [4]. Lines printed in each iteration of the outer
do...while loop are enclosed between "===" lines. These are the lines just before
the crash:

===
in_loop: i: 0, vq idx: 1
in_loop: i: 1, vq idx: 1
out_loop: i: 1, vq idx: 1
===
in_loop: i: 0, vq idx: 1
in_loop: i: 1, vq idx: 1
out_loop: i: 1, vq idx: 1
===
in_loop: i: 0, vq idx: 1
in_loop: i: 1, vq idx: 1
in_loop: i: 2, vq idx: 1
out_loop: i: 2, vq idx: 1
===
in_loop: i: 0, vq idx: 1
out_loop: i: 0, vq idx: 1

I have only investigated which descriptors the kernel uses. I'll also check
which descriptors are made available by the kernel. I'll let you know what I
find.

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1727
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L499
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c#L1008
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c#L1147


