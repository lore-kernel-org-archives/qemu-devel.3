Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B7C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txsBn-00072w-LU; Thu, 27 Mar 2025 14:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1txsBi-00072G-UF
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:42:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1txsBg-0005vH-H4
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:42:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so2450591a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743100961; x=1743705761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MqMS+1Azi3Xbg4a4/24GcWgoztdierzewFWy4CcOyVc=;
 b=EIOrr3TO0fIO/sPwePBOKZpsAuW2G4Cgf6XZ1LTqFJzt9eUGZStqqezWQELMDTfvJ/
 9wy0FBx1UHTtak+t7xRoxeX8BkCmAsyUUtsCbvttssIxp96IGertxWGHcOdSviBKiaYs
 m3/JuifqRjjG/NZ145WbnM5Xq2u2hzAhROK1oKwd0tR774fEKYqJe2FHSIJbsDxkxbM3
 dmwdSs4nBnwU/nqoUDLHcS7Swrg1AimABiDkSq5YznuOmDHwdFjdt/ryQwj1lKoGeVB6
 6QBIsMEEgy4ooDgD0WD++BbIyZEn020+0h6GJWbG3LjWoONgkR45h1qL1FoHu2XbkOZ+
 9+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743100961; x=1743705761;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MqMS+1Azi3Xbg4a4/24GcWgoztdierzewFWy4CcOyVc=;
 b=NXHSRa4Zc6N7LOHBsZ52Q6DcVIEXwWRkTRcae3ovd+3gx7PKnpJtQ1DC9Dwny7Jhk0
 H+6vIma2fdqluoAeVCEfUOkK7Q+yxK7XjDbPG/T0XmB/YbUYuKpSbVK/0gvYx6/hmJQ7
 7R9y8k424wzXbFlUm7sIyJog+boRU/+45R/lBNn74Qi1+MxwBpF1xYwAfqznPPsvHaXU
 zJ2v5gJcN+EDWgre9SWC0KHpg5Uym9q776gCa2PR/PLPT+y+thkbVpUkvDQj0hUzo5yc
 xaERrqYthP8ox7SSUcx91JQzd6SI06qKiqVVp7pe/gUz1oZUJ3BryCYXC8awKMHaWxnd
 JQzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0COKry3jK1TT4N1CRWozm/4U+XENUMjIt2X697xrTzF7ZUw9a+tZ7qXqmmD9eZEv56/GmFBz1xSlA@nongnu.org
X-Gm-Message-State: AOJu0Yx5jPvkA7SDKmATAdSZxD6jl1f7P+KUhfAG5VZ0e7MPW+iFlN1T
 YNXEfnd7M3H6UloNp0xhJ55WLXjevMTjeKcKhkeTKnOjSPX1sASU
X-Gm-Gg: ASbGncsqHSJ/5/20O1bQxvxeAGWztjxyI4VO817yyT+IxLovLF9ki+VUTDXVP+YxqK0
 83RR4d89AYhP4CXa/FA5z5y08E+QHllhADvA5UR6ncxU6afCp5CBRy+cVxhPf4oF03i6/LPX2yU
 t6L+5Tm1G/C4cdDFU/M68MPoPgIBN3zIwCn/LobXHKYhZGtJbY1wBi7MO8QbFs/opT4saNPLggI
 bYUyP5jihbBBDMIxsnK9DZJ2QWVQXJbQg1Cz9hXfjqm7EaZCot8+eQF4+PlVoXlTp41tA4IQqsU
 1uXXkyPNkOkhokWnVJ8Q4n+Upp7OBmR0pV1ZqdK29N0xEQZXvoh1fwAdJfZbTJ86x8AN3SWU7po
 M4tRSqYwubguT2kMRJtvoYtI=
X-Google-Smtp-Source: AGHT+IHdgx7c7yxeDXBUYBhZhTng+XCCMBgXmrBRnYyeUapicBJjCzUmuAo5BSMr3HroH2MnKIiQNg==
X-Received: by 2002:a17:90a:c88c:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-303a7d73507mr6807215a91.13.1743100960421; 
 Thu, 27 Mar 2025 11:42:40 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f1d430asm2598638a91.35.2025.03.27.11.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 11:42:39 -0700 (PDT)
Message-ID: <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
Date: Fri, 28 Mar 2025 00:12:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
 <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x102f.google.com
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

On 3/26/25 1:33 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:14 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
>>> Implement the insertion of available buffers in the descriptor area of
>>> packed shadow virtqueues. It takes into account descriptor chains, but
>>> does not consider indirect descriptors.
>>>
>>> Enable the packed SVQ to forward the descriptors to the device.
>>>
>>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>> ---
>>> Changes from v4 -> v5:
>>> - This was commit #2 in v4. This has been reordered to commit #3
>>>     based on review comments.
>>> - vhost-shadow-virtqueue.c:
>>>     (vhost_svq_valid_features): Move addition of enums to commit #6
>>>     based on review comments.
>>>     (vhost_svq_add_packed): Set head_idx to buffer id instead of vring's
>>>     index.
>>>     (vhost_svq_kick): Split into vhost_svq_kick_split and
>>>     vhost_svq_kick_packed.
>>>     (vhost_svq_add): Use new vhost_svq_kick_* functions.
>>>
>>>    hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++--
>>>    1 file changed, 112 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>>> index 4f74ad402a..6e16cd4bdf 100644
>>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>>> @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
>>>        /* Update the avail index after write the descriptor */
>>>        smp_wmb();
>>>        avail->idx = cpu_to_le16(svq->shadow_avail_idx);
>>> +}
>>> +
>>> +/**
>>> + * Write descriptors to SVQ packed vring
>>> + *
>>> + * @svq: The shadow virtqueue
>>> + * @out_sg: The iovec to the guest
>>> + * @out_num: Outgoing iovec length
>>> + * @in_sg: The iovec from the guest
>>> + * @in_num: Incoming iovec length
>>> + * @sgs: Cache for hwaddr
>>> + * @head: Saves current free_head
>>> + */
>>> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
>>> +                                 const struct iovec *out_sg, size_t out_num,
>>> +                                 const struct iovec *in_sg, size_t in_num,
>>> +                                 hwaddr *sgs, unsigned *head)
>>> +{
>>> +    uint16_t id, curr, i, head_flags = 0, head_idx;
>>> +    size_t num = out_num + in_num;
>>> +    unsigned n;
>>> +
>>> +    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
>>> +
>>> +    head_idx = svq->vring_packed.next_avail_idx;
>>
>> Since "svq->vring_packed.next_avail_idx" is part of QEMU internals and not
>> stored in guest memory, no endianness conversion is required here, right?
>>
> 
> Right!

Understood.

>>> +    i = head_idx;
>>> +    id = svq->free_head;
>>> +    curr = id;
>>> +    *head = id;
>>
>> Should head be the buffer id or the idx of the descriptor ring where the
>> first descriptor of a descriptor chain is inserted?
>>
> 
> The buffer id of the *last* descriptor of a chain. See "2.8.6 Next
> Flag: Descriptor Chaining" at [1].

Ah, yes. The second half of my question in incorrect.

The tail descriptor of the chain includes the buffer id. In this implementation
we place the same tail buffer id in other locations of the descriptor ring since
they will be ignored anyway [1].

The explanation below frames my query better.

>>> +    /* Write descriptors to SVQ packed vring */
>>> +    for (n = 0; n < num; n++) {
>>> +        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
>>> +                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
>>> +                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
>>> +        if (i == head_idx) {
>>> +            head_flags = flags;
>>> +        } else {
>>> +            descs[i].flags = flags;
>>> +        }
>>> +
>>> +        descs[i].addr = cpu_to_le64(sgs[n]);
>>> +        descs[i].id = id;
>>> +        if (n < out_num) {
>>> +            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
>>> +        } else {
>>> +            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
>>> +        }
>>> +
>>> +        curr = cpu_to_le16(svq->desc_next[curr]);
>>> +
>>> +        if (++i >= svq->vring_packed.vring.num) {
>>> +            i = 0;
>>> +            svq->vring_packed.avail_used_flags ^=
>>> +                1 << VRING_PACKED_DESC_F_AVAIL |
>>> +                1 << VRING_PACKED_DESC_F_USED;
>>> +        }
>>> +    }
>>>
>>> +    if (i <= head_idx) {
>>> +        svq->vring_packed.avail_wrap_counter ^= 1;
>>> +    }
>>> +
>>> +    svq->vring_packed.next_avail_idx = i;
>>> +    svq->shadow_avail_idx = i;
>>> +    svq->free_head = curr;
>>> +
>>> +    /*
>>> +     * A driver MUST NOT make the first descriptor in the list
>>> +     * available before all subsequent descriptors comprising
>>> +     * the list are made available.
>>> +     */
>>> +    smp_wmb();
>>> +    svq->vring_packed.vring.desc[head_idx].flags = head_flags;
>>>    }
>>>
>>> -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>>> +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
>>>    {
>>>        bool needs_kick;
>>>
>>> @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>>>        if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>>>            uint16_t avail_event = le16_to_cpu(
>>>                    *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
>>> -        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
>>> +        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx,
>>> +                     svq->shadow_avail_idx - 1);
>>>        } else {
>>>            needs_kick =
>>>                    !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
>>> @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>>>        event_notifier_set(&svq->hdev_kick);
>>>    }
>>>
>>> +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
>>> +{
>>> +    bool needs_kick;
>>> +
>>> +    /*
>>> +     * We need to expose the available array entries before checking
>>> +     * notification suppressions.
>>> +     */
>>> +    smp_mb();
>>> +
>>> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>>> +        return;
>>> +    } else {
>>> +        needs_kick = (svq->vring_packed.vring.device->flags !=
>>> +                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
>>> +    }
>>> +
>>> +    if (!needs_kick) {
>>> +        return;
>>> +    }
>>> +
>>> +    event_notifier_set(&svq->hdev_kick);
>>> +}
>>> +
>>>    /**
>>>     * Add an element to a SVQ.
>>>     *
>>> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>>>            return -EINVAL;
>>>        }
>>>
>>> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
>>> -                        in_num, sgs, &qemu_head);
>>> +    if (svq->is_packed) {
>>> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
>>> +                             in_num, sgs, &qemu_head);
>>> +    } else {
>>> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
>>> +                            in_num, sgs, &qemu_head);
>>> +    }
>>>
>>>        svq->num_free -= ndescs;
>>>        svq->desc_state[qemu_head].elem = elem;
>>>        svq->desc_state[qemu_head].ndescs = ndescs;
>>
>> *head in vhost_svq_add_packed() is stored in "qemu_head" here.
>>
> 
> Sorry I don't get this, can you expand?

Sure. In vhost_svq_add(), after the descriptors have been added
(either using vhost_svq_add_split or vhost_svq_add_packed),
VirtQueueElement elem and ndescs are both saved in the
svq->desc_state array. "elem" and "ndescs" are later used when
the guest consumes used descriptors from the device in
vhost_svq_get_buf_(split|packed).

For split vqs, the index of svq->desc where elem and ndescs are
saved matches the index of the descriptor ring where the head of
the descriptor ring is placed.

In vhost_svq_add_split:

*head = svq->free_head;
[...]
avail_idx = svq->shadow_avail_idx & (svq->vring.num - 1);
avail->ring[avail_idx] = cpu_to_le16(*head);

"qemu_head" in vhost_svq_add gets its value from "*head" in
vhost_svq_add_split:

svq->desc_state[qemu_head].elem = elem;
svq->desc_state[qemu_head].ndescs = ndescs;

For packed vq, something similar has to be done. My approach was
to have the index of svq->desc_state match the buffer id in the
tail of the descriptor ring.

The entire chain is written to the descriptor ring in the loop
in vhost_svq_add_packed. I am not sure if the index of
svq->desc_state should be the buffer id or if it should be a
descriptor index ("head_idx" or the index corresponding to the
tail of the chain).

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg03512.html

