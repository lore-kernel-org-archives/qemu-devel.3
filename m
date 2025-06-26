Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EA6C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUeyD-0007YG-HA; Thu, 26 Jun 2025 01:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uUey8-0007Y2-Ml
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:16:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uUey6-0001MV-02
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:16:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235e1d710d8so8468255ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 22:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750914971; x=1751519771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=almBluoUfQGxgdHLgPUCEkDnP8cNw7v9ZSjjroc4P5I=;
 b=WAmkSWiKzBZ3oQsUPGnkPdyw3XJQY2lDw9H+G4Jfqjwj1FcmPq2KEwLdb9x/L7gAvv
 EUZLj0TPbr1OqncOgNUlBUk1ke9dUYOtMyzXBD/F0o9Nr2Qtchm4/NKmmM4F7zRz5oUl
 7fsFij5V19WGvsoJyxw+a4G1SVefchVdVFfG4iaGtRAt7vGiGFxm8ZZ7ax6LHD3W+9mq
 AEXBAIspJt4hNKr7zaaWoGFF3+8cj/84ujCZ3sHAW5JtKABsp/8pReNRLI7uS49KrU7I
 w1gaQlc/sbbkfp/SkTUjq46TwskLtGEy0TEsuo3tm8Ds5okn+fC1AtGbw2TDwEJ9WGZy
 TC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750914971; x=1751519771;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=almBluoUfQGxgdHLgPUCEkDnP8cNw7v9ZSjjroc4P5I=;
 b=iZ+uJsFLImeXNywl9EoBT01E70J+x811yPfqrL1+CsgAzztWdapfzkJwzlfn+6+lIQ
 ntNH9UGRVF4mY0mkc5SIsgPdU2ZddtR2KZOCB6UWigrdseOpSzGg+t3IZF2wQatMsbDX
 01TsNyKogGgKah/J0c9oLI0S6PDViavNQ1qxRTWxRyfsnyoEkeEjG8cFlP4ycXYPGqmY
 0ekXPJdOyb0AfMMbA1LGVUxhr1kNZdYr2CGNpJ/pD7h9EW63p3a7VE6AzZbGBsRrcsbl
 FI5u4gz9tY3MOAfK1AXbh1pi7KpcXX+AahGGKXOxApEWJcuop7zTcDPKMvqYynA5he6i
 cZuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzYEdSeEeV2kzuAxDk2R2Pokco989Jiwe7tDWHq8pWlmaYKovKXO5cHR0W7aQFgE4G4dmNH9AW4m4j@nongnu.org
X-Gm-Message-State: AOJu0YxF0jpxJkx262e2R07hGR2JXrGfF8o9Dlybdh2hsWHzd6/xTwg1
 gvV0DsDkKqQrVqIceovUJK/zTvzgWmcR/KJ1JE5HRxVkO3Tsy71xGI0u
X-Gm-Gg: ASbGnctvgthu/3Fb8/GEj0+1AYpWkQQ/HVQ0J/8whCayMzPcSHoNG2KhSCyLrv1MQBh
 1sQFs8g7gEE/YZvD1viC8rhmr5E5qlGiOBhPBIrAACxu6uic0WvN+CpMQNc2HVlFUBneKANMfun
 wetVFs7elKSlfB/O4057IiA/gZjHUrQQsxZQnrfxSEN+CTzJ1eodwVRXqlQ9fqkebGTMQqqL8/U
 EiS0R3CnnY48eSvg4rU20xRcGaHnkZJQJWqDGmjNyU6KiwIGiMfmpa4v7PSDkUeopLL7yHfVCVo
 lmnjuzmRTnpI0znNiCdQQuvD7uuwhWo0H1p8PV6MEUDyNpmn68ojvAqpZErPlnCGzQdo65bLhpC
 D4Ok6E9wYasIpnGynPMIViz8MNkY=
X-Google-Smtp-Source: AGHT+IFl02Ff5/3R5J/4TqAGkLec+g+QzcAn2qxzPqtnLGRgZZu5uUC5goqCBWAvcSLB3q1GswvS7Q==
X-Received: by 2002:a17:903:198b:b0:233:ab04:27a with SMTP id
 d9443c01a7336-23824094ce2mr106238735ad.53.1750914970804; 
 Wed, 25 Jun 2025 22:16:10 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c43:11b:9732:a723:2129:ccf4?
 ([2401:4900:1c43:11b:9732:a723:2129:ccf4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860b624sm147500245ad.125.2025.06.25.22.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 22:16:10 -0700 (PDT)
Message-ID: <97eafb50-492a-4571-92de-503fbc0d06fd@gmail.com>
Date: Thu, 26 Jun 2025 10:46:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
 <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
 <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x630.google.com
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

It's been a while since I sent an email. I thought I would send an update
to keep you in the loop.

I have been comparing svq's mechanism for split and packed vqs hoping to
find something that might lead to the source of the issue.

One thing worth noting is that when I use kernel version 6.8.5 for testing,
the crashes are far more frequent. In kernel version 6.15.0-rc3+, it's much
harder to reproduce.

On 5/15/25 11:49 AM, Eugenio Perez Martin wrote:
> On Wed, May 14, 2025 at 8:22 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 4/16/25 12:50 PM, Eugenio Perez Martin wrote:
>>> On Mon, Apr 14, 2025 at 11:20 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
>>>>> On Mon, Mar 24, 2025 at 2:59 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>> I managed to fix a few issues while testing this patch series.
>>>>>> There is still one issue that I am unable to resolve. I thought
>>>>>> I would send this patch series for review in case I have missed
>>>>>> something.
>>>>>>
>>>>>> The issue is that this patch series does not work every time. I
>>>>>> am able to ping L0 from L2 and vice versa via packed SVQ when it
>>>>>> works.
>>>>>>
>>>>>> When this doesn't work, both VMs throw a "Destination Host
>>>>>> Unreachable" error. This is sometimes (not always) accompanied
>>>>>> by the following kernel error (thrown by L2-kernel):
>>>>>>
>>>>>> virtio_net virtio1: output.0:id 1 is not a head!
>>>>>>
>>
>> The TX queue seems to be problematic. More on this below.

Sometimes RX also results in this crash, but it seems to be less frequent.

>>>> This was filled while L2
>>>> was booting. In the case when the ctrl vq is disabled, I am not sure
>>>> what is responsible for filling the vqs in the data plane during
>>>> booting.
>>>>
>>> The nested guest's driver fills the rx queue at startup. After that,
>>> that nested guest kicks and SVQ receives the descriptors. It copies
>>> the descriptors to the shadow virtqueue and then kicks L0 QEMU.
>>
>> Understood.
>>
>>>> The other vq (vq_idx=1) is not filled completely before the issue is
>>>> hit.
>>>> I have been noting down the numbers and here is an example:
>>>>
>>>> 295 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
>>>> |_ 256 additions in vq_idx = 0, all with unique ids
>>>>        |---- 27 descriptors (ids 0 through 26) were received later from the device (vhost_svq_get_buf_packed)
>>>> |_ 39 additions in vq_idx = 1
>>>>        |_ 13 descriptors had id = 0
>>>>        |_ 26 descriptors had id = 1
>>>>        |---- All descriptors were received at some point from the device (vhost_svq_get_buf_packed)
>>>>
>>>> There was one case in which vq_idx=0 had wrapped around. I verified
>>>> that flags were set appropriately during the wrap (avail and used flags
>>>> were flipped as expected).
>>>>
>>>
>>> Ok sounds like you're able to reach it before filling the queue. I'd
>>> go for debugging notifications for this one then. More on this below.
>>>
>>>> =====
>>>> The next common situation where this issue is hit is during startup.
>>>> Before L2 can finish booting successfully, this error is thrown:
>>>>
>>>> virtio_net virtio1: output.0:id 0 is not a head!
>>>>
>>>> 258 descriptors were added individually to the queues during startup (there were no chains) (vhost_svq_add_packed)
>>>> |_ 256 additions in vq_idx = 0, all with unique ids
>>>>       |---- None of them were received by the device (vhost_svq_get_buf_packed)
>>>> |_ 2 additions in vq_idx = 1
>>>>       |_ id = 0 in index 0
>>>>       |_ id = 1 in index 1
>>>>       |---- Both descriptors were received at some point during startup from the device (vhost_svq_get_buf_packed)
>>>>
>>>> =====
>>>> Another case is after several seconds of pinging L0 from L2.
>>>>
>>>> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
>>>>
>>>
>>> So the L2 guest sees a descriptor it has not made available
>>> previously. This can be caused because SVQ returns the same descriptor
>>> twice, or it doesn't fill the id or flags properly. It can also be
>>> caused because we're not protecting the write ordering in the ring,
>>> but I don't see anything obviously wrong by looking at the code.
>>>
>>>> 366 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
>>>> |_ 289 additions in vq_idx = 0, wrap-around was observed with avail and used flags inverted for 33 descriptors
>>>> |   |---- 40 descriptors (ids 0 through 39) were received from the device (vhost_svq_get_buf_packed)
>>>> |_ 77 additions in vq_idx = 1
>>>>        |_ 76 descriptors had id = 0
>>>>        |_ 1 descriptor had id = 1
>>>>        |---- all 77 descriptors were received at some point from the device (vhost_svq_get_buf_packed)
>>>>
>>>>
>>>> "id is not a head" is being thrown because vq->packed.desc_state[id].data
>>>> doesn't exist for the corresponding id in Linux [1]. But QEMU seems to have
>>>> stored some data for this id via vhost_svq_add() [2]. Linux sets the value
>>>> of vq->packed.desc_state[id].data in its version of virtqueue_add_packed() [3].
>>>>
>>>
>>> Let's keep debugging further. Can you trace the ids that the L2 kernel
>>> makes available, and then the ones that it uses? At the same time, can
>>> you trace the ids that the svq sees in vhost_svq_get_buf and the ones
>>> that flushes? This allows us to check the set of available descriptors
>>> at any given time.
>>>
>> In the linux kernel, I am printing which descriptor is received in which
>> queue in drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_packed() [1].
>> I see the following lines getting printed for the TX queue:
>>
>> [  192.101591] output.0 -> id: 0
>> [  213.737417] output.0 -> id: 0
>> [  213.738714] output.0 -> id: 1
>> [  213.740093] output.0 -> id: 0
>> [  213.741521] virtio_net virtio1: output.0:id 0 is not a head!
>>
> 
> I find it particular that it is the first descriptor with id 1. Do you
> have any other descriptor with id 1 previously? Does it fail
> consistently with id 1?

Yes, the descriptor with id 1 was used previously in TX. It varies between
test runs. It has failed with other ids as well during some test runs. In
one test run, it failed with id 17. I think there's an off-by-one bug here.
It crashes when it receives id 'x - 1' instead of 'x'.
> You should have descriptors with id 1 and more in the rx queue and the
> code should not be able to tell the difference, so it seems weird it
> fails with tx. But who knows :).
Oh, I thought it would be able to differentiate between them since it knows
which vq->idx it's coming from.

I think there's something off in the way "free_head", "last_used_idx" and
"desc_next" values are calculated in vhost_svq_get_buf_packed() [1].

In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started receiving
them in order till id 8. At this point it received id 7 again for some reason
and then crashed.

L2:

[ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
[ 1641.130621] (notify) output.0 -> function will return true
[ 1641.132022] output.0 -> id: 0
[ 1739.502358] input.0 -> id: 0
[ 1739.503003] input.0 -> id: 1
[ 1739.562024] input.0 -> id: 2
[ 1739.578682] input.0 -> id: 3
[ 1739.661913] input.0 -> id: 4
[ 1739.828796] input.0 -> id: 5
[ 1739.829789] input.0 -> id: 6
[ 1740.078757] input.0 -> id: 7
[ 1740.079749] input.0 -> id: 8
[ 1740.080382] input.0 -> id: 7    <----Received 7 again
[ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!

QEMU logs (vhost_svq_get_buf_packed):
------
size              : svq->vring.num
len               : svq->vring_packed.vring.desc[last_used].len
id                : svq->vring_packed.vring.desc[last_used].id
num               : svq->desc_state[id].ndescs
last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num, id) [2]
free_head         : svq->free_head
last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + num
used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))
------

size: 256, len: 102, id: 0, vq idx: 0
id: 0, last_used_chain: 0, free_head: 0, vq idx: 0
num: 1, free_head: 0, id: 0, last_used: 1, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 74, id: 1, vq idx: 0
id: 1, last_used_chain: 1, free_head: 0, vq idx: 0
num: 1, free_head: 1, id: 1, last_used: 2, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 102, id: 2, vq idx: 0
id: 2, last_used_chain: 2, free_head: 1, vq idx: 0
num: 1, free_head: 2, id: 2, last_used: 3, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 82, id: 3, vq idx: 0
id: 3, last_used_chain: 3, free_head: 2, vq idx: 0
num: 1, free_head: 3, id: 3, last_used: 4, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 74, id: 4, vq idx: 0
id: 4, last_used_chain: 4, free_head: 3, vq idx: 0
num: 1, free_head: 4, id: 4, last_used: 5, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 82, id: 5, vq idx: 0
id: 5, last_used_chain: 5, free_head: 4, vq idx: 0
num: 1, free_head: 5, id: 5, last_used: 6, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 104, id: 6, vq idx: 0
id: 6, last_used_chain: 6, free_head: 5, vq idx: 0
num: 1, free_head: 6, id: 6, last_used: 7, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 82, id: 7, vq idx: 0
id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 104, id: 8, vq idx: 0
id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 98, id: 9, vq idx: 0
id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq idx: 0
------
size: 256, len: 104, id: 10, vq idx: 0
id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, vq idx: 0

I have a few more ideas of what to do. I'll let you know if I find something
else.

Thanks,
Sahil

[1] https://github.com/valdaarhun/qemu/blob/packed_vq/hw/virtio/vhost-shadow-virtqueue.c#L687
[2] https://github.com/valdaarhun/qemu/blob/packed_vq/hw/virtio/vhost-shadow-virtqueue.c#L629

