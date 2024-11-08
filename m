Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CE5D5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Iy5-0006da-Sr; Fri, 08 Nov 2024 01:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t9Iy3-0006d5-LJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 01:59:39 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t9Iy1-0005Fz-K4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 01:59:39 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so1427949b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731049176; x=1731653976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VEVbIXlHWYOISWkOGgOAlEiIsE/26zurVPP3wVIdNe4=;
 b=dOKzWwlnt5oez7TzPVm1G3IeUc2nPgFQKcXm6nqdXI0YL6Vv14HIp7ID0ZUelcG44E
 ShfKTIgiM3LvjCHQWKNLtRz8+G0QvpgYwM2GROC7UKx02Kc4lBkmiDXPkQVFjOasuQw4
 N1de2hhsTuT5OzVdtQYRzGlh8yMwVjkAGbMQwp+6V6JeEUt44N5fNaUatNyj0/KXnil8
 oRYdbcvlSqc4cHKao6MKHwELL7ihaUiAZ9vMG0FX1yq8D9BCYDbToJdArumsQEpF5HyP
 jte6uz3LuYgERad3+LDVcqIqbiRO22/UAdZT6GDH1WR0O4CXS72hAs5O1U6Th2uAMmuk
 UTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049176; x=1731653976;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEVbIXlHWYOISWkOGgOAlEiIsE/26zurVPP3wVIdNe4=;
 b=mkHDmd9AtCJdUF6e259HN2cmE/CavmL4KQgESl3IGIb2/kyCoxqSOndG5mjGtDEU9W
 MFO1+VJWWxnkfPzUWCkJAC9ThRNFDbBNLNAyRHyA5s/DJIDrrsOUGpT6yzQnpNxRDZmA
 IrWHuFYMr/CAJOcxrCaMzKH+2qxuPgUzr547IUTc6zXrOr89fnBuTDCIApCvfiHt3UhN
 +NARXAKzYuYOO0dSrEluRyzL7/wzOkVMiCn39VX4eMF+IWo0wZFC3rCmE5iqVwfOEvC5
 gwfdJPzf+45ucyIaF4yiXuUfJZNI4OvQ6hyhmwepXjc6y70jkR6Vl0MXHsVM+T0QxmAr
 WM+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwfZdzlAJ+04m082F5TafB6I3smFghydHBbvsTI8xYPxgdiIbaGlkvVJyFuzn1jsuoaiBn83wv7FVJ@nongnu.org
X-Gm-Message-State: AOJu0YxWErSHyjjFzBOFYRT0UyF35GgKB3F+XDNiBUucgPlUbnV66CFE
 uc1sju5qPTqp/xbhHhFZj+drKvblfpAFtUorZJ+u8ol6vTZrbnO3
X-Google-Smtp-Source: AGHT+IGQtK0Y1Mq0Zjpvu6RcEwkATWzk8mZ0rw5t0qaSdGfFabcf1LoRQHtzNTa0B9GjGE+XG6VyNg==
X-Received: by 2002:a05:6a20:7fa1:b0:1d9:c64a:9f72 with SMTP id
 adf61e73a8af0-1dc228b0208mr2130435637.2.1731049175585; 
 Thu, 07 Nov 2024 22:59:35 -0800 (PST)
Received: from [192.168.0.106] ([182.48.209.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb83sm2876335b3a.91.2024.11.07.22.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 22:59:35 -0800 (PST)
Message-ID: <8dd9684c-96a3-4dc8-909f-c7ca803aa2d4@gmail.com>
Date: Fri, 8 Nov 2024 12:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
References: <20241104162124.49867-1-sahilcdq@proton.me>
 <k2suxbt2qy7ewjrlozlkzrhsa7bbf7xrze33outna65dejuus2@eamj5pdkvpkw>
 <77bc1be1-e4b3-46a0-a263-cc8f7d6e28fe@gmail.com>
 <pu5razer3dkaltyuwiav236sepob44mj6cmigskdcet7davn4t@6orjjrzeqtau>
 <CAJaqyWd6+F7PO6tjq5QtjrRkoZNQZiqEPOsrjEN9Zp3S2t7SUA@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWd6+F7PO6tjq5QtjrRkoZNQZiqEPOsrjEN9Zp3S2t7SUA@mail.gmail.com>
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

On 11/6/24 8:30 PM, Eugenio Perez Martin wrote:
> On Wed, Nov 6, 2024 at 3:33 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Nov 05, 2024 at 08:24:17PM +0530, Sahil Siddiq wrote:
>>> Hi,
>>>
>>> Thank you for the review.
>>>
>>> On 11/5/24 3:06 PM, Stefano Garzarella wrote:
>>>> On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
>>>>> Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
>>>>
>>>> To refer to a commit, please use the SHA-1 id or even better the form
>>>> suggested in
>>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>>>>
>>>> So in this case I'd use:
>>>> Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial state
>>>> after reset")
>>>
>>> Understood, I'll change this in v2.
>>>
>>>>> vq state to the device's initial state. This works differently for
>>>>> split and packed vqs.
>>>>>
>>>>> With shadow virtqueues enabled, vhost-vdpa sets the vring base using
>>>>> the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
>>>>> differs for split and packed vqs. The implementation in QEMU currently
>>>>> uses the payload required for split vqs (i.e., the num field of
>>>>> vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
>>>>> payload is used with packed vqs.
>>>>>
>>>>> This patch sets the num field in the payload appropriately so vhost-vdpa
>>>>
>>>> I'm not very familiar with shadow virtqueue, so can you elaborate what
>>>> "appropriately" means here?
>>>
>>> My understanding is that the ioctl and the payload themselves are not
>>> directly related to shadow virtqueues [1]. They concern virtqueues in general.
>>>
>>> In QEMU's implementation, hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_setup [2]
>>> is called from hw/virtio/vhost-vdpa.c:vhost_vdpa_svqs_start [3] only when
>>> shadow virtqueues are enabled.
>>>
>>> QEMU's vhost-user doc [1] states that the payload for the VHOST_SET_VRING_BASE
>>> ioctl is different for split and packed vqs. The struct is the same:
>>>
>>> struct vhost_vring_state {
>>>        unsigned int index;
>>>        unsigned int num;
>>> };
>>>
>>> The num field takes a different value depending on the virtqueue's format
>>> (split vs packed). The explanation below throws more light on this.
>>>
>>>>> (with the vp_vdpa driver) can use packed svqs.
>>>>>
>>>>> Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
>>>>> Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
>>>>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>>>> ---
>>>>> QEMU currently does not support packed vhost shadow virtqueues. I am
>>>>> working on adding support for packed svqs [1]. The test environment
>>>>> that I am using [2] requires vhost-vdpa to use the relevant payload
>>>>> when setting vring base.
>>>>>
>>>>> [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>>>>> [2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
>>>>>
>>>>> hw/virtio/vhost-vdpa.c | 4 ++++
>>>>> 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>> index 3cdaa12ed5..5f81945109 100644
>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>> @@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
>>>>>     };
>>>>>     int r;
>>>>>
>>>>> +    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
>>>>> +        s.num = 0x80008000;
>>>>
>>>> Why this magic value?
>>>>
>>>> Looking at the kernel code it looks like we are assgining 0x8000 for
>>>> both last_avail_idx and last_used_idx, but why 0x8000?
>>>>
>>>> Thanks,
>>>> Stefano
>>>>
>>>
>>> When I boot a VM with packed=on and x-svq=true, QEMU sets the vring base
>>> using VHOST_SET_VRING_BASE. I used ftrace to trace the functions in the
>>> linux kernel and got the following trace:
>>>
>>> [...]
>>> qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vdpa_unlocked_ioctl <-__x64_sys_ioctl
>>> qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl <-vhost_vdpa_unlocked_ioctl
>>> qemu-system-x86-1737    [001] ...1.  3613.371362: vp_vdpa_set_vq_state <-vhost_vdpa_unlocked_ioctl
>>> [...]
>>>
>>> In the kernel, drivers/vhost/vhost.c:vhost_vring_ioctl [4] uses
>>> the vhost_vring_state payload to set the last_avail_idx. For
>>> packed vqs, it also sets last_used_idx.
>>>
>>>     vq->last_avail_idx = s.num & 0xffff;
>>>     vq->last_used_idx = (s.num >> 16) & 0xffff;
>>>
>>> These values are used to populate a new struct vdpa_vq_state in
>>> drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl [5].
>>>
>>>     vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
>>>     vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
>>>     vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
>>>     vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
>>>
>>> The following check is then made in drivers/vdpa/virtio_pci/vp_vdpa.c:
>>> vp_vdpa_set_vq_state_packed [6]:
>>>
>>>     if (packed->last_avail_counter == 1 &&
>>>         packed->last_avail_idx == 0 &&
>>>         packed->last_used_counter == 1 &&
>>>         packed->last_used_idx == 0)
>>>         return 0;
>>>     return -EOPNOTSUPP;
>>>
>>> The most significant bit in 0x8000 is used to set the wrap counters.
>>> All the other bits are 0 and so the avail and used idx are also set
>>> to 0.
>>
>> Thanks for these great details!
>>
>> Okay, so IIUC the only configuration that vp_vdpa supports when
>> VHOST_SET_VRING_BASE is called is idx == 0 and wrap_couter = true for
>> both avail and used.
>>
> 
> Right, it cannot set any other value as there is no standardized way
> in virtio. But vp_vdpa allows the default one, as QEMU always sends
> it.
> 
>> Is this okay with QEMU shadow vq? (More a question for Eugenio).
>>
> 
> Yes, it is a required step to support packed vq.
> 
> I misunderstood the previous thread and I thought the problem was
> somewhere else. It is hard to justify introducing this change in QEMU
> by itself, as the code is not reachable. However, when you post the
> whole series, you can make the two changes requested here (commit id,
> no magic number) and add my acked-by directly :):
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>

Sure thing, this makes more sense. I'll do that.

Thanks,
Sahil

