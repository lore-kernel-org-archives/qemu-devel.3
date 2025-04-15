Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76AC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lpP-0006xQ-Jc; Tue, 15 Apr 2025 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4lpO-0006wu-If
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:20:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4lpM-00074d-0M
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:20:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso5737115b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744744810; x=1745349610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=d8MV/9ihDX+bChlp3YZPyG3tNZDA3wf/xirltgvrCio=;
 b=DF2vSTMj7boWZIAtFKB/6wZOSxtMXshzms9vFqc2IZl1leX8PiN372tuiequ/5gwpJ
 V4/kfGIk6Y2ZFIY2zV+Wq0Q3tN1ETOb5LSh380BBX15/yCToZSzM4qn4mKdIohZTv3qv
 svh0l25SZeMZqhm/DlXSGlDywc663ztoZSek0aVTkoFwLN7GLC2/Al9agxANjDE+LOa3
 98zW1yuI+QEuvAJ3rB8vjYcQUjidgwpg3dOTQaWX4B9Q6stazPOK+7bVNcIu/YTI3sAe
 u/OcFHmtCaMJNi/UIsn/vLDFwR0d3/jCEsPHLZsOA+VmgcR/SXrwXvFQZod4U2hnw16f
 x22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744744810; x=1745349610;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d8MV/9ihDX+bChlp3YZPyG3tNZDA3wf/xirltgvrCio=;
 b=e7hxAfBIoYuveoG88NyTZMoNB8FV+q2+r8vt8S4OiRJ1A1+8vVn9x0mNtt7N7e7RTc
 LY5gHG8S7cRC9tvKdsL9cp3nlpmsXDHBTRdqlXm6BbQ48Abb2hGXjOw7ZsgG74zgjL1o
 FYjaMKwenyomYZIQVL21/wEQ6J3M84cKw4M4swpgPTZadL+eYRhVlT07ttAkMTc45ePS
 nvIYaQwj3g/Locejihdb5rDsT6Fbf+ZQvmyRg0/rmVAkYRO833QOJQH5PTwWaFH4t74r
 hNMnGb0jLxdt3Lnp3x3s/b7jMkGVFzDy68JfLlzuredcA+9bVlqHLnQDglYHmDOrEACO
 iZ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIrBWNvNyasLkkg8l9tErYgxTmEtOnHZq2nS1JZeK1bwg2DY8Zpdq454D6iw8w4CqDXJTRtUwdixAF@nongnu.org
X-Gm-Message-State: AOJu0Yycp12NsFcQo1meKLoUtW+OE4K02L4JO+COcabvOG62Qmmw32/P
 +tVSrLO6GTDzb9LyLlSRmX3j4hjUaWlZ2H3T0MpzuS6X4TYTVjkx
X-Gm-Gg: ASbGncsZE706a9Z6BRp7DlQ2sKXDgcjU3Vc8or880c7BgCxBL/noKBHz56l4cMkdFZb
 pcGe9q6V+u+cqYRpnQShZ7GObGb3BdJRva5VS1+1InohlPuu50BnqxBbESsLxEJ+Prbhv5A4cqG
 XmSaS30XcLkJvLKBw0TikQ5ymweAPNmMDyf8Uwrm71Lj8WgLHHUOhzZTgtztRX7Fc+Ljo6Y1u4v
 fguE5vG6uRkf+IYUweyURezoM/A9wrQYPOI8EuC+StJySccPXh+OZmQxDTDtDLDm8krZfcUOqWB
 3eJjQccMNBmULlEMKA+cFnmPOtcWqgNrKDDu4batTRNVxk8gKe79Ua16mGa4S6pzNrZYY8HWfIt
 qkQTCNW/zSjqNmt9jmUA=
X-Google-Smtp-Source: AGHT+IFz91gqkPhjtp9wI2DwrWdJ9rFZ6mR8amh05HpwomvI5CvBiH9QptD2BcXrwLcU605fklyydA==
X-Received: by 2002:a17:90b:4c43:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-3085ef1dbbamr595981a91.14.1744744809825; 
 Tue, 15 Apr 2025 12:20:09 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76?
 ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df2fb081sm13543997a91.35.2025.04.15.12.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 12:20:09 -0700 (PDT)
Message-ID: <a549035f-9e33-45ed-a4bb-14d60964b604@gmail.com>
Date: Wed, 16 Apr 2025 00:50:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
From: Sahil Siddiq <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42b.google.com
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

On 4/14/25 2:50 PM, Sahil Siddiq wrote:
> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
>> On Mon, Mar 24, 2025 at 2:59 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>> I managed to fix a few issues while testing this patch series.
>>> There is still one issue that I am unable to resolve. I thought
>>> I would send this patch series for review in case I have missed
>>> something.
>>>
>>> The issue is that this patch series does not work every time. I
>>> am able to ping L0 from L2 and vice versa via packed SVQ when it
>>> works.
>>
>> So we're on a very good track then!
>>
>>> When this doesn't work, both VMs throw a "Destination Host
>>> Unreachable" error. This is sometimes (not always) accompanied
>>> by the following kernel error (thrown by L2-kernel):
>>>
>>> virtio_net virtio1: output.0:id 1 is not a head!
>>>
>>
>> How many packets have been sent or received before hitting this? If
>> the answer to that is "the vq size", maybe there is a bug in the code
>> that handles the wraparound of the packed vq, as the used and avail
>> flags need to be twisted. You can count them in the SVQ code.
> 
> I did a lot more testing. This issue is quite unpredictable in terms
> of the time at which it appears after booting L2. So far, it almost
> always appears after booting L2. Even when pinging works, this issue
> appears after several seconds of pinging.
> 
> The total number of svq descriptors varied in every test run. But in
> every case, all 256 indices were filled in the descriptor region for
> vq with vq_idx = 0. This is the RX vq, right? This was filled while L2
> was booting. In the case when the ctrl vq is disabled, I am not sure
> what is responsible for filling the vqs in the data plane during
> booting.
> 
> =====
> The issue is hit most frequently when the following command is run
> in L0:
> $ ip addr add 111.1.1.1/24 dev tap0
> $ ip link set tap0 up
> 
> or, running the following in L2:
> # ip addr add 111.1.1.2/24 dev eth0
> 
> The other vq (vq_idx=1) is not filled completely before the issue is
> hit. I have been noting down the numbers and here is an example:
> 
> 295 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
> |_ 256 additions in vq_idx = 0, all with unique ids
>      |---- 27 descriptors (ids 0 through 26) were received later from the device (vhost_svq_get_buf_packed)
> |_ 39 additions in vq_idx = 1
>      |_ 13 descriptors had id = 0
>      |_ 26 descriptors had id = 1
>      |---- All descriptors were received at some point from the device (vhost_svq_get_buf_packed)
> 
> There was one case in which vq_idx=0 had wrapped around. I verified
> that flags were set appropriately during the wrap (avail and used flags
> were flipped as expected).
> 
> =====
> The next common situation where this issue is hit is during startup.
> Before L2 can finish booting successfully, this error is thrown:
> 
> virtio_net virtio1: output.0:id 0 is not a head!
> 
> 258 descriptors were added individually to the queues during startup (there were no chains) (vhost_svq_add_packed)
> |_ 256 additions in vq_idx = 0, all with unique ids
>     |---- None of them were received by the device (vhost_svq_get_buf_packed)
> |_ 2 additions in vq_idx = 1
>     |_ id = 0 in index 0
>     |_ id = 1 in index 1
>     |---- Both descriptors were received at some point during startup from the device (vhost_svq_get_buf_packed)
> 
> =====
> Another case is after several seconds of pinging L0 from L2.
> 
> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
> 
> 366 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
> |_ 289 additions in vq_idx = 0, wrap-around was observed with avail and used flags inverted for 33 descriptors
> |   |---- 40 descriptors (ids 0 through 39) were received from the device (vhost_svq_get_buf_packed)
> |_ 77 additions in vq_idx = 1
>      |_ 76 descriptors had id = 0
>      |_ 1 descriptor had id = 1
>      |---- all 77 descriptors were received at some point from the device (vhost_svq_get_buf_packed)
> 
> I am not entirely sure now if there's an issue in the packed vq
> implementation in QEMU or if this is being caused due to some sort
> of race condition in linux.

After some more testing, I think the issue is indeed in the current
implementation of packed vq in QEMU. The kernel does not crash when
using packed vqs with x-svq=false. I have an idea that might help
find the issue. It involves debugging the linux kernel. I'll try this
out and will let you know how it goes.

> "id is not a head" is being thrown because vq->packed.desc_state[id].data
> doesn't exist for the corresponding id in Linux [1]. But QEMU seems to have
> stored some data for this id via vhost_svq_add() [2]. Linux sets the value
> of vq->packed.desc_state[id].data in its version of virtqueue_add_packed() [3].
> [...]

Thanks,
Sahil

