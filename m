Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9091C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4GGO-0003qJ-NH; Mon, 14 Apr 2025 05:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4GGM-0003q2-NB
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:37:58 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4GGK-00068y-E3
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:37:58 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30572effb26so3571207a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744623474; x=1745228274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZJc7dD09+xmYASZbu+3IGMpDhTkB5Mg3iT8HvALX7s=;
 b=XGv3fX1+c3CQM83kU0k6v3E7ItrX8zzjpERRDb9b1izP0q/i0tr9SmC59BJ3zyKEHp
 2oqR4sOWJt97M9cXaKmSCT05g8SugKZQLPaHRXdQIwgQx9Il0oNxVjjrO8W+2NStxOjx
 LAPB9zftn/bYP6nQ2uvG/T3TgaRiERrktqe3ObWAmWy8OCKKGqryS6cx3eQxyrCwqkkO
 cuM4Lfw74ys+0E2LvFs+Sg1/1Mw+ISbSgS5wTfv9gZsKuyGrg/NIgiR0byIJF0bup5dJ
 E32aJuZo7xI5tK2KWGqFJ42Z6uW1Xqc99l8ENnFiNdVhsbOk2HXwJx2yYOQOgAWN3ra3
 vHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744623474; x=1745228274;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZJc7dD09+xmYASZbu+3IGMpDhTkB5Mg3iT8HvALX7s=;
 b=HCVtchsXNRQPu8OysJL202MpS2q+LgisX90rOcHva4VBJy4wred5zXUldY1+SXqdlf
 NIdgy/xWhRoDqbj/C4kYPTDZPIA60pGM2dWslUAGWKTenqzJC16R0gwCAmce/ZweSNkZ
 vjlaASuG9tRmr72pXJjXsIviD0QmAmmxEAfrSJdd1mqdTgnTTTk6YGtXdivWHJdAv5Op
 G5gZfGWClxUjCGsDPTMylosZcWKR0HEQQfF01YWgtPw65UbQ0oJwoCkOGQ6qyW3tCkxo
 t/UdF4Ri3fFCIUE+XkX23KeUc8o1C1iNpTqNbxQ/nzu1sXpQTCr8Fna3EbgRe/XLJOKC
 tT7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8vFWkqY5JfNsIGvSFFrm0bdOEP1UUby/R5EEfqem/cV7uJvb1TonvvyKh418qKLyrsUTv5qVL7q5n@nongnu.org
X-Gm-Message-State: AOJu0Yz0Vx+RlMEtT7Em0mgwyMnk74t2urNZeNEcUBgN9Ltx63btI5E+
 o7+E83SKIaHZlZkuEx6+c0Q/pwC9vzRkmHtztToBiJGttBwqqTjU
X-Gm-Gg: ASbGncv514LRPe3JDwp+FT9uLz3cFVmIQ6gno+ewjlHx7e0kMlzzOI47CTa5dZsAKju
 dY75TIGzq3+XCI23CxRd+0ADXiuCfml7Gnkd5U3GEncixr02DB4LlSWAa/kJQRjRDFinFMEHdxQ
 u6OnQg7VOvG5ww/yhzaiPh9TIdJ/pCVrnCzgwvlTyga2o8M3J2GO5C2+HE+XjVXM+YMyYDn75J7
 aAlKHYTPNnp5eL+mGYtSEzEzuQAt+fq1EtRjI77s43ywBilBY6JLINB2gOT9QQA+8sZlY4AlydR
 QKkpmLaQDIT9qu+IUYkYOQ2UEFIlECegTTsfkIRkjbRAATA6kdasgg17g4bw/FLiOYDWUxczvrs
 qxVRvXlXO
X-Google-Smtp-Source: AGHT+IEMAggL6f9+zMOfqpH7TtoJlgW6pHM7bSwp8lsbcmv5Mu5ImSzR8eg1RSFXU9eMoC0V1Aq6IQ==
X-Received: by 2002:a17:90a:e7ca:b0:2ff:6ac2:c5a6 with SMTP id
 98e67ed59e1d1-308237cdb4amr15252175a91.31.1744623474135; 
 Mon, 14 Apr 2025 02:37:54 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76?
 ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df07caafsm10629520a91.11.2025.04.14.02.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 02:37:53 -0700 (PDT)
Message-ID: <5f970447-2547-4ce2-8d27-420540d5896b@gmail.com>
Date: Mon, 14 Apr 2025 15:07:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
 <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
 <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
 <CAJaqyWfwUqek9McKYZoDpPxf-woxw0g8AJ589W9t6LSdqzdniQ@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfwUqek9McKYZoDpPxf-woxw0g8AJ589W9t6LSdqzdniQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1033.google.com
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

On 3/28/25 1:21 PM, Eugenio Perez Martin wrote:
> On Thu, Mar 27, 2025 at 7:42 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 3/26/25 1:33 PM, Eugenio Perez Martin wrote:
>>> On Mon, Mar 24, 2025 at 3:14 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
>>>>> Implement the insertion of available buffers in the descriptor area of
>>>>> packed shadow virtqueues. It takes into account descriptor chains, but
>>>>> does not consider indirect descriptors.
>>>>>
>>>>> Enable the packed SVQ to forward the descriptors to the device.
>>>>>
>>>>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>>>> ---
>>>>> [...]
>>>>> +
>>>>> +/**
>>>>> + * Write descriptors to SVQ packed vring
>>>>> + *
>>>>> + * @svq: The shadow virtqueue
>>>>> + * @out_sg: The iovec to the guest
>>>>> + * @out_num: Outgoing iovec length
>>>>> + * @in_sg: The iovec from the guest
>>>>> + * @in_num: Incoming iovec length
>>>>> + * @sgs: Cache for hwaddr
>>>>> + * @head: Saves current free_head
>>>>> + */
>>>>> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
>>>>> +                                 const struct iovec *out_sg, size_t out_num,
>>>>> +                                 const struct iovec *in_sg, size_t in_num,
>>>>> +                                 hwaddr *sgs, unsigned *head)
>>>>> +{
>>>>> +    uint16_t id, curr, i, head_flags = 0, head_idx;
>>>>> +    size_t num = out_num + in_num;
>>>>> +    unsigned n;
>>>>> +
>>>>> +    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
>>>>> +
>>>>> +    head_idx = svq->vring_packed.next_avail_idx;
>>>>
>>>> Since "svq->vring_packed.next_avail_idx" is part of QEMU internals and not
>>>> stored in guest memory, no endianness conversion is required here, right?
>>>>
>>>
>>> Right!
>>
>> Understood.
>>
>>>>> +    i = head_idx;
>>>>> +    id = svq->free_head;
>>>>> +    curr = id;
>>>>> +    *head = id;
>>>>
>>>> Should head be the buffer id or the idx of the descriptor ring where the
>>>> first descriptor of a descriptor chain is inserted?
>>>>
>>>
>>> The buffer id of the *last* descriptor of a chain. See "2.8.6 Next
>>> Flag: Descriptor Chaining" at [1].
>>
>> Ah, yes. The second half of my question in incorrect.
>>
>> The tail descriptor of the chain includes the buffer id. In this implementation
>> we place the same tail buffer id in other locations of the descriptor ring since
>> they will be ignored anyway [1].
>>
>> The explanation below frames my query better.
>>
>>>>> +    /* Write descriptors to SVQ packed vring */
>>>>> +    for (n = 0; n < num; n++) {
>>>>> +        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
>>>>> +                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
>>>>> +                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
>>>>> +        if (i == head_idx) {
>>>>> +            head_flags = flags;
>>>>> +        } else {
>>>>> +            descs[i].flags = flags;
>>>>> +        }
>>>>> +
>>>>> +        descs[i].addr = cpu_to_le64(sgs[n]);
>>>>> +        descs[i].id = id;
>>>>> +        if (n < out_num) {
>>>>> +            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
>>>>> +        } else {
>>>>> +            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
>>>>> +        }
>>>>> +
>>>>> +        curr = cpu_to_le16(svq->desc_next[curr]);
>>>>> +
>>>>> +        if (++i >= svq->vring_packed.vring.num) {
>>>>> +            i = 0;
>>>>> +            svq->vring_packed.avail_used_flags ^=
>>>>> +                1 << VRING_PACKED_DESC_F_AVAIL |
>>>>> +                1 << VRING_PACKED_DESC_F_USED;
>>>>> +        }
>>>>> +    }
>>>>>
>>>>> +    if (i <= head_idx) {
>>>>> +        svq->vring_packed.avail_wrap_counter ^= 1;
>>>>> +    }
>>>>> +
>>>>> +    svq->vring_packed.next_avail_idx = i;
>>>>> +    svq->shadow_avail_idx = i;
>>>>> +    svq->free_head = curr;
>>>>> +
>>>>> +    /*
>>>>> +     * A driver MUST NOT make the first descriptor in the list
>>>>> +     * available before all subsequent descriptors comprising
>>>>> +     * the list are made available.
>>>>> +     */
>>>>> +    smp_wmb();
>>>>> +    svq->vring_packed.vring.desc[head_idx].flags = head_flags;
>>>>>     }
>>>>>
>>>>> [...]
>>>>> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>>>>>             return -EINVAL;
>>>>>         }
>>>>>
>>>>> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
>>>>> -                        in_num, sgs, &qemu_head);
>>>>> +    if (svq->is_packed) {
>>>>> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
>>>>> +                             in_num, sgs, &qemu_head);
>>>>> +    } else {
>>>>> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
>>>>> +                            in_num, sgs, &qemu_head);
>>>>> +    }
>>>>>
>>>>>         svq->num_free -= ndescs;
>>>>>         svq->desc_state[qemu_head].elem = elem;
>>>>>         svq->desc_state[qemu_head].ndescs = ndescs;
>>>>
>>>> *head in vhost_svq_add_packed() is stored in "qemu_head" here.
>>>>
>>>
>>> Sorry I don't get this, can you expand?
>>
>> Sure. In vhost_svq_add(), after the descriptors have been added
>> (either using vhost_svq_add_split or vhost_svq_add_packed),
>> VirtQueueElement elem and ndescs are both saved in the
>> svq->desc_state array. "elem" and "ndescs" are later used when
>> the guest consumes used descriptors from the device in
>> vhost_svq_get_buf_(split|packed).
>>
>> For split vqs, the index of svq->desc where elem and ndescs are
>> saved matches the index of the descriptor ring where the head of
>> the descriptor ring is placed.
>>
>> In vhost_svq_add_split:
>>
>> *head = svq->free_head;
>> [...]
>> avail_idx = svq->shadow_avail_idx & (svq->vring.num - 1);
>> avail->ring[avail_idx] = cpu_to_le16(*head);
>>
>> "qemu_head" in vhost_svq_add gets its value from "*head" in
>> vhost_svq_add_split:
>>
>> svq->desc_state[qemu_head].elem = elem;
>> svq->desc_state[qemu_head].ndescs = ndescs;
>>
>> For packed vq, something similar has to be done. My approach was
>> to have the index of svq->desc_state match the buffer id in the
>> tail of the descriptor ring.
>>
>> The entire chain is written to the descriptor ring in the loop
>> in vhost_svq_add_packed. I am not sure if the index of
>> svq->desc_state should be the buffer id or if it should be a
>> descriptor index ("head_idx" or the index corresponding to the
>> tail of the chain).
>>
> 
> I think both approaches should be valid. My advice is to follow
> Linux's code and let it be the tail descriptor id. This descriptor id
> is pushed and popped from vq->free_head in a stack style.
> 
> In addition to that, Linux also sets the same id to all the chain
> elements. I think this is useful when dealing with bad devices. In
> particular, 

Understood. So far, I have implemented this so it matches the
implementation in Linux.

> QEMU's packed vq implementation looked at the first
> desciptor's id, which is an incorrect behavior.

Are you referring to:

1. svq->desc_state[qemu_head].elem = elem (in vhost_svq_add()), and
2. *head = id (in vhost_svq_add_packed())

According to the virtio spec, the buffer id must be saved in the last
index of the list in the descriptor region [1]. QEMU and Linux [2][3]
both use the value of vq->free_head (instead of the id that precedes
curr [4]) to save in the descriptor region and to use in svq->desc_state.

Thanks,
Sahil

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-780006
[2] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1507
[3] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1563
[4] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1560

