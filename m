Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC00C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 04:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHxiO-0002n2-MW; Thu, 22 May 2025 00:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHxiN-0002ms-90
 for qemu-devel@nongnu.org; Thu, 22 May 2025 00:39:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHxiJ-0004dR-Ha
 for qemu-devel@nongnu.org; Thu, 22 May 2025 00:39:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso60488075ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747888765; x=1748493565;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtjktIeHr7h8HqbuJqTabqHH/U9+0Le4aYSUkWxaa00=;
 b=ZTVXYbvjwW8mptsJ9g9det8zQRdGcJPccb1Vp6iIEkHNFpXbFH5ro5x/WWDA5gy7zz
 asthdG0/dQ4Id+AzaTnIGiKeemfyB1REGL7dclflsIax4t4bXK6VyT2/fStd2kQQR9JK
 Y+tDRauJ6X71b7x4r44XMBfWsS6+CiQ0TOrzMxd9cdFMoe24kH57nDuX9IsQiqOg6VZx
 zSCJCLQbIVTGsfBbJZ553D/UkTAU31cxpZg0iFDfyo9dTuMImU+voJvaohmXOHddYxbN
 xdiB585QNPtLTKf8CuzbBwo/EfI1qabJ8GALwRjDqWNGh9KPmVW2KK9RDpaelj3Rs+ZL
 6nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747888765; x=1748493565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtjktIeHr7h8HqbuJqTabqHH/U9+0Le4aYSUkWxaa00=;
 b=gGO23R8bZRemp+pRotbFp2Xx9JWoKxXCMRF8MYV+HB9tJnjOyqBuMZdS6SaDiWaKfx
 cxZfyJbyFG8VCHQggJ12t8q2SuNG//oB4hgHDQwOt6Mfo8LeRw/PJ9Rp7tenpu4HjZWq
 l5RQs0+203d1KnzeR86D9ruoahSk7sklu+VNS3lDWhxcvt65G1sJAPa4dm4wTUkZAsAi
 3UcnMCipORACUG3AJhtzGBC08byKEKUOK9ZOnspKCFTjdS6ZNsqhmbYHRszh9g9ZL4+K
 rlPF2DfTLZ33udd0juFUbmx1rpYUwm8maLmkDHbFhMyAJlzRIJHxp3yMp+7QNMWYhQKX
 U3ag==
X-Gm-Message-State: AOJu0YyMQVblDZ7FM2B5Ngd617JL2sZPY+XahphxEkBN2f+xX09by91O
 sNXMgKewZvwF7xd0oFCLMjJ6qjtaAH0AEf1Kw9x4p5jo1PrLxbNDDE5qVuYeYIEQfvU=
X-Gm-Gg: ASbGncvrp1mdz8eWdW2fGgzePJBzCIqVBwrOMG2vV1Ut7u9J/0qH4Bv1v8TGI/0vHtV
 sk9R46XHJHOmlz6gSGoDe3wU7IAPOWb3BNhIUJYc4s6bL/6wPkE22F+xZ0OE5n/Bmc9fVcu611j
 TcXT/sPvtQn8IM/qmxZ9IC7KGg4im6yabzIMo1/cVnVjOt/691i06eMxeC0s/Upk/hP1Jt7dS/Y
 BQSd5+hw7GW6HD8k7JuXfeW3syyQ21u49folhNg1kmmE+N3AaLNn3xDk0xusZ1ErQ+5AI4oC/dH
 vfdb57zW3TuLXTVJsgdq/KNlGtEMoY5zbLa7KFeZF4BnKShUiyJCfiPxxR3INQ==
X-Google-Smtp-Source: AGHT+IEVUvjxTNp65F8+THrCZCs+ZS7mhnCnsZgpvlgBoo0lm3bML2wZ5XZLFYsx7+RbzxizT5ltaQ==
X-Received: by 2002:a17:902:dacc:b0:231:d0f4:6264 with SMTP id
 d9443c01a7336-231d43d9bc0mr370360275ad.10.1747888765017; 
 Wed, 21 May 2025 21:39:25 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm92202375ad.228.2025.05.21.21.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 21:39:24 -0700 (PDT)
Message-ID: <fb575fb3-d17c-4fd2-8dff-a77fd91b1d6a@daynix.com>
Date: Thu, 22 May 2025 13:39:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
 <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
 <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
 <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
 <f299600a-cf0b-47e4-85d1-5c3d1b4eaef0@daynix.com>
 <CACGkMEvEoZsdQh10ofOq4S-ZOJ7orJBK5MzDZ_0mV0f-Y=POFg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvEoZsdQh10ofOq4S-ZOJ7orJBK5MzDZ_0mV0f-Y=POFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 10:50, 'Jason Wang' via devel wrote:
> On Wed, May 21, 2025 at 11:51 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/05/21 9:51, Jason Wang wrote:
>>> On Fri, May 16, 2025 at 11:29 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/05/16 10:44, Jason Wang wrote:
>>>>> On Wed, May 14, 2025 at 2:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
>>>>>>> On Sat, May 10, 2025 at 3:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
>>>>>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
>>>>>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
>>>>>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
>>>>>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
>>>>>>>> VIRTIO_NET_F_MQ uses bit 22.
>>>>>>>>
>>>>>>>> Instead of inferring the required number of queues from
>>>>>>>> vdev->guest_features, use the number loaded from the vm state.
>>>>>>>>
>>>>>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> ---
>>>>>>>>      include/hw/virtio/virtio.h |  2 +-
>>>>>>>>      hw/net/virtio-net.c        | 11 ++++-------
>>>>>>>>      hw/virtio/virtio.c         | 14 +++++++-------
>>>>>>>>      3 files changed, 12 insertions(+), 15 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>>>> index 638691028050..af52580c1e63 100644
>>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>>>>>>>>          int (*start_ioeventfd)(VirtIODevice *vdev);
>>>>>>>>          void (*stop_ioeventfd)(VirtIODevice *vdev);
>>>>>>>>          /* Called before loading queues. Useful to add queues before loading. */
>>>>>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
>>>>>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
>>>>>>>
>>>>>>> This turns out to be tricky as it has a lot of assumptions as
>>>>>>> described in the changelog (e.g only lower 32bit of guest_features is
>>>>>>> correct etc when calling this function).
>>>>>>
>>>>>> The problem is that I missed the following comment in
>>>>>> hw/virtio/virtio.c:
>>>>>>         /*
>>>>>>          * Temporarily set guest_features low bits - needed by
>>>>>>          * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>>>>>>          * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
>>>>>>          *
>>>>>>          * Note: devices should always test host features in future - don't
>>>>>> create
>>>>>>          * new dependencies like this.
>>>>>>          */
>>>>>>         vdev->guest_features = features;
>>>>>>
>>>>>> This problem is specific to guest_features so avoiding it should give us
>>>>>> a reliable solution.
>>>>>
>>>>> I meant not all the states were fully loaded for pre_load_queues(),
>>>>> this seems another trick besides the above one. We should seek a way
>>>>> to do it in post_load() or at least document the assumptions.
>>>>
>>>> The name of the function already clarifies the state is not fully
>>>> loaded. An implementation of the function can make no assumption on the
>>>> state except that you can add queues here, which is already documented.
>>>
>>> Where? I can only see this:
>>>
>>>       /* Called before loading queues. Useful to add queues before loading. */
>>
>> I meant it is documented that it can add queues. There is nothing else
>> to document as an implementation of the function can make no assumption
>> else.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Looking at the commit that introduces this which is 9379ea9db3c that says:
>>>>>>>
>>>>>>> """
>>>>>>> Otherwise the loaded queues will not have handlers and elements
>>>>>>> in them will not be processed.
>>>>>>> """
>>>>>>>
>>>>>>> I fail to remember what it means or what happens if we don't do 9379ea9db3c.
>>>>>>
>>>>>> The packets and control commands in the queues except the first queue
>>>>>> will not be processed because they do not have handle_output set.
>>>>>
>>>>> I don't understand here, the VM is not resumed in this case. Or what
>>>>> issue did you see here?
>>>>
>>>> Below is the order of relevant events that happen when loading and
>>>> resuming a VM for migration:
>>>>
>>>> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
>>>> queue, and one control queue.
>>>> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues if
>>>> the "n" parameter requires that.
>>>> 3) The state of queues are loaded.
>>>> 4) The VM gets resumed.
>>>>
>>>> If we skip 2), 3) will load states of queues that are not added yet,
>>>> which breaks these queues and packets and leave control packets on them
>>>> unprocessed.
>>>
>>> Ok, let's document this and
>>>
>>> 1) explain why only virtio-net requires the pre_load_queues (due to
>>> the fact that the index of ctrl vq could be changed according to
>>> #queue_paris)
>>
>> We would need this logic even if the index of ctrl vq didn't change. We
>> need it because virtio-net have varying number of queues, which needs to
>> be added before loading.
> 
> Well, if the ctrl vq index doesn't change we don't need a dynamic
> virtio_add_queue() we can do them all in realize just like other
> multiqueue devices.

The number of virtqueues also affects the behavior visible to the guest 
so we shouldn't add them all in realize anyway. In particular, struct 
virtio_pci_common_cfg contains fields related virtqueus, and most (if 
not all) of them are affected by the number of virtqueues.

Regards,
Akihiko Odaki

