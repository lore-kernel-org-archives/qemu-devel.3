Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9976DC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 05:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty2Aw-0005tZ-HS; Fri, 28 Mar 2025 01:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty2Au-0005t6-Pf
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:22:36 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty2Ar-0002lf-KA
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:22:35 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so3969387a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743139352; x=1743744152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XHMzNp3b69w9snRrUjSwrNXx6DGtzGaJ9IdIbxLF6Y0=;
 b=BsRtn42T2H7l0d7cGtUKs8UU9MRzQ9y0h/+p7B9kd79wVfnRYctTpw2Jbld8Ehp9id
 BVUta/1z5IjM13ixn6mnTH6L6z7KXKpsm2YqUggvq3UesL1OBaj2rOrPolzkzipUqxDz
 b2rksd9rn+YoMGN/XY273bRWnW7Gf6wmTsxxSx2T6iIiSchC8WIoPKxLyQEV1NMmiWWJ
 Xd1YOx+etqtHnhxQB4FG5W8Mdr8H+nFpVIp8NS9kdNexTGUWgYMhz959MntMDOZKLN8+
 Of7ybXvqxorJMhS3vOeczfTpEXS5PUGNr6lJC+DQxrXw10d1F5wjvWBMcfQwyH+yz2ke
 gA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743139352; x=1743744152;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHMzNp3b69w9snRrUjSwrNXx6DGtzGaJ9IdIbxLF6Y0=;
 b=m/fhRHjselukSOQ8utXW1sRX6L3s35clbRcmG3s3XzviuIq+HmpqlwRJMgmVZY2bmM
 HMy7vt2gJ1KUpxh3go6iF2DkicdQX/aD6IUPCXdR0vtYvNm5wA1O5iKHJ44hZ5GqMdHW
 /dE2ab/pxs7aWB8O/RCtlhCITNBzt9tbf1YSS40fL40LXjZDMI19ZEpMlOxgkjk5l8M2
 rIz5ABYzRacoXdbAcdArXDmgvXFJUnxS2sA3yIeCKYerKU/jlrwVXSBvpltqCwKOC5uC
 Hw5nRhneOvkvlXczy5z1HbV99IwxgcDwzzYLIaVsILJ2swpxlCc/FzOwm2NFeheUcBUP
 ndjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtjLZN8xMlJI7n0Du4boNng8S9vcwnyyWLGpsF6z8qZALYY3JeUpWa7ffZDjb3QSf5tnI2Lrau2tgF@nongnu.org
X-Gm-Message-State: AOJu0YwnYK+lANndwfutokefPrzSniSvOcbG9TiodV1lo2HxUBVsZl7u
 /bA4oqd+L7g6VGuo3hC3Hs30YU9H3HTwXHqxHT5UiAsNrxzwpFTA
X-Gm-Gg: ASbGncs0BgERC5Ks6we7AtqCFwnrHOKl0F/56JaS8Va8U+CkC0tAN2spQ5pehqEzsxP
 Ei3HHQW5jZuqCUCQkfNm4ClOvr91HN7eSOsGxR53yPhOfxxPA1/BnS6OBme2bYVxxSoqt4CjYox
 Pg4FhEuJnwy7vxNVOIxXZLATQaDWhRBXratHY+4qXz69T9l+0z01lDNSnVbFYzQnYHMKNa0HR9o
 axC+jsAmtQcCBQ08FaHOigcXmkV952dYLWByKT2l39afErSugk9APEM0V3kcIGVRRxSWTRDTUZj
 0wOfz6yAv2EWgv23Scak57jFMf6Puo9FCtuSm0Pt7TKFUDmhs/v9p/h4klbh1pT7rLVVDFX3nb3
 /X4InpWR6ikrf5OHRKA7WDqM=
X-Google-Smtp-Source: AGHT+IElAMaRtgss49/WtnKv7dLz7nBZMb433bpUZlfV7smombqxPT6oFGutQI5ZQKbDLmlbU6sIjg==
X-Received: by 2002:a17:90a:f947:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-303a8d80a3emr9655561a91.29.1743139351918; 
 Thu, 27 Mar 2025 22:22:31 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73971068581sm816922b3a.114.2025.03.27.22.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 22:22:31 -0700 (PDT)
Message-ID: <5a3f55be-5b5d-4a77-9e3d-0dbf1f4c7705@gmail.com>
Date: Fri, 28 Mar 2025 10:52:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 5/7] vhost: Forward descriptors to guest via packed vqs
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-6-sahilcdq@proton.me>
 <49e5e2e1-4715-4949-93d5-b4e0f5425bbf@gmail.com>
 <CAJaqyWckqkkE=sB6yk1RhV8DVoPBAODqdNfgq5Vc0DLGo2_TNw@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWckqkkE=sB6yk1RhV8DVoPBAODqdNfgq5Vc0DLGo2_TNw@mail.gmail.com>
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

On 3/26/25 2:04 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:34 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> I had a few more queries here as well.
>>
>> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
>>> Detect when used descriptors are ready for consumption by the guest via
>>> packed virtqueues and forward them from the device to the guest.
>>>
>>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>> ---
>>> Changes from v4 -> v5:
>>> - New commit.
>>> - vhost-shadow-virtqueue.c:
>>>     (vhost_svq_more_used): Split into vhost_svq_more_used_split and
>>>     vhost_svq_more_used_packed.
>>>     (vhost_svq_enable_notification): Handle split and packed vqs.
>>>     (vhost_svq_disable_notification): Likewise.
>>>     (vhost_svq_get_buf): Split into vhost_svq_get_buf_split and
>>>     vhost_svq_get_buf_packed.
>>>     (vhost_svq_poll): Use new functions.
>>>
>>>    hw/virtio/vhost-shadow-virtqueue.c | 121 ++++++++++++++++++++++++++---
>>>    1 file changed, 110 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>>> index 126957231d..8430b3c94a 100644
>>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>>> @@ -463,7 +463,7 @@ static void vhost_handle_guest_kick_notifier(EventNotifier *n)
>>>        vhost_handle_guest_kick(svq);
>>>    }
>>>
>>> -static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
>>> +static bool vhost_svq_more_used_split(VhostShadowVirtqueue *svq)
>>>    {
>>>        uint16_t *used_idx = &svq->vring.used->idx;
>>>        if (svq->last_used_idx != svq->shadow_used_idx) {
>>> @@ -475,6 +475,22 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
>>>        return svq->last_used_idx != svq->shadow_used_idx;
>>>    }
>>>
>>> +static bool vhost_svq_more_used_packed(VhostShadowVirtqueue *svq)
>>> +{
>>> +    bool avail_flag, used_flag, used_wrap_counter;
>>> +    uint16_t last_used_idx, last_used, flags;
>>> +
>>> +    last_used_idx = svq->last_used_idx;
>>> +    last_used = last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>>
>> In the linux kernel, last_used is calculated as:
>>
>> last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>>
>> ...instead of...
>>
>> last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)
>>
>> Isn't the second option good enough if last_used_idx is uint16_t
>> and VRING_PACKED_EVENT_F_WRAP_CTR is defined as 15.
>>
> 
> I think it is good enough with the u16 restrictions but it's just
> defensive code.
> 

Got it. I think it'll be better then to follow the implementation in
the kernel to keep it more robust.

>>> +    used_wrap_counter = !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>>> +
>>> +    flags = le16_to_cpu(svq->vring_packed.vring.desc[last_used].flags);
>>> +    avail_flag = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
>>> +    used_flag = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
>>> +
>>> +    return avail_flag == used_flag && used_flag == used_wrap_counter;
>>> +}
>>> +
>>
>> Also in the implementation of vhost_svq_more_used_split() [1], I haven't
>> understood why the following condition:
>>
>> svq->last_used_idx != svq->shadow_used_idx
>>
>> is checked before updating the value of "svq->shadow_used_idx":
>>
>> svq->shadow_used_idx = le16_to_cpu(*(volatile uint16_t *)used_idx)
>>
> 
> As far as I know this is used to avoid concurrent access to guest's
> used_idx, avoiding cache sharing, the memory barrier, and the
> potentially costly volatile access.
> 

By concurrent access, do you mean in case one thread has already updated
the value of used_idx?

Thanks,
Sahil

