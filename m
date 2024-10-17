Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36559D21262
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MTl-0003D5-5e; Thu, 17 Oct 2024 05:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1MTj-0003Cj-GB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:07:31 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1MTh-0000Mo-G4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:07:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso513208a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729156047; x=1729760847;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=52dJXAzaYvj2RMltd4bzcws2XHsP/jm0BdB3BbYB/V0=;
 b=yqJPQmbuS3kutlvgibdcmawWQUZ+aD6lYw3n9yNuaJb6a3GcI4jKku1dDTd4DIw+d3
 I5V3qQYvsxKShijbtoAAh20nBGfFNd3xeCmFTsBgaNyXZ8aKoKaHpNKls00RYkWs8BA6
 C6M8jY+jKnPqo1MS+CqPnZoC5q8xk7OQ6W4H1x1fpXpPYSRCmbvUrUmxFyK5+cY3FrBU
 3pga8+z4Ql6ejkPwXiMTl3gmtw0wWIKs3watPLTigCINs420tykXYEe3Nu8WuNRkxsK7
 BO5IG6WNEQ98bFy6y5wGGIcXxLfgRsldO+AY0vhAfEwgQE6/4v6ip3p/4gtHNdoRlf2h
 +dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729156047; x=1729760847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=52dJXAzaYvj2RMltd4bzcws2XHsP/jm0BdB3BbYB/V0=;
 b=lq+jMCaqMIa8oLsk5z+xAZIwG2GF+4Ruh3/+shltmhz7fh1rVUugjMsq5JiSQvaMov
 5P0j8yXxEEQZY1Zz865bqeaG0e9cWjcjYK0kEBlFqPGBm5Kk2b6KtlLBg837MxtR9GV5
 wgfSQjDpMqV9RNvlEYuL/N41vorMCKX5ABFvaMLGvxyl67JsxstpBBpm3h6/Vyx/HiJd
 wl5QI1v1juRltsMV87SV668xZ6k9HlIaf0fDRSUG/0NMxFGWizji/3cCjz9ietjfYDJj
 bvDwxCnYNblY9zWrqG2l24HFSz0Weelbz1meRuxeovadaPwvCQwYDqDV7qCT47vV/Y0Q
 zKKg==
X-Gm-Message-State: AOJu0YxNmIfnDldHAESAZkDdNyZvo7XelSawSExdonua/HWSAcKO3JiU
 MwpZAcQqh3Sgl/XwTBZgTOpTzPzgMK3nHTa9Fn8Ji6c3vFA1xR1gsLIoiq75vDE=
X-Google-Smtp-Source: AGHT+IHeWFtWEoU54NgkH9dxBjU9iYUCDRGE+DzjoUvWNXh8M18RvlcQop6aZy1IFiu0xe9qBlGcLg==
X-Received: by 2002:a05:6a21:1813:b0:1cf:2d22:3ec4 with SMTP id
 adf61e73a8af0-1d91c6e1353mr2904782637.25.1729156047462; 
 Thu, 17 Oct 2024 02:07:27 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e773a2f7fsm4322832b3a.55.2024.10.17.02.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 02:07:27 -0700 (PDT)
Message-ID: <60169858-3930-4490-b42d-d04117ab9abd@daynix.com>
Date: Thu, 17 Oct 2024 18:07:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
 <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
 <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/17 16:32, Laurent Vivier wrote:
> On 17/10/2024 08:59, Jason Wang wrote:
>> On Mon, Oct 14, 2024 at 11:16 PM Laurent Vivier <lvivier@redhat.com> 
>> wrote:
>>>
>>> On 14/10/2024 10:30, Laurent Vivier wrote:
>>>> Hi Akihiko,
>>>>
>>>> On 04/06/2024 09:37, Jason Wang wrote:
>>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> Multiqueue usage is not negotiated yet when realizing. If more than
>>>>> one queue is added and the guest never requests to enable multiqueue,
>>>>> the extra queues will not be deleted when unrealizing and leak.
>>>>>
>>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest 
>>>>> doesn't support
>>>>> multiqueue")
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>>    hw/net/virtio-net.c | 4 +---
>>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>> index 3cee2ef3ac..a8db8bfd9c 100644
>>>>> --- a/hw/net/virtio-net.c
>>>>> +++ b/hw/net/virtio-net.c
>>>>> @@ -3743,9 +3743,7 @@ static void 
>>>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>>        n->net_conf.tx_queue_size = 
>>>>> MIN(virtio_net_max_tx_queue_size(n),
>>>>>                                        n->net_conf.tx_queue_size);
>>>>> -    for (i = 0; i < n->max_queue_pairs; i++) {
>>>>> -        virtio_net_add_queue(n, i);
>>>>> -    }
>>>>> +    virtio_net_add_queue(n, 0);
>>>>>        n->ctrl_vq = virtio_add_queue(vdev, 64, 
>>>>> virtio_net_handle_ctrl);
>>>>>        qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>>>>
>>>> This change breaks virtio net migration when multiqueue is enabled.
>>>>
>>>> I think this is because virtqueues are half initialized after 
>>>> migration : they are
>>>> initialized on guest side (kernel is using them) but not on QEMU 
>>>> side (realized has only
>>>> initialized one). After migration, they are not initialized by the 
>>>> call to
>>>> virtio_net_set_multiqueue() from virtio_net_set_features() because 
>>>> virtio_get_num_queues()
>>>> reports already n->max_queue_pairs as this value is coming from the 
>>>> source guest memory.
>>>>
>>>> I don't think we have a way to half-initialize a virtqueue (to 
>>>> initialize them only on
>>>> QEMU side as they are already initialized on kernel side).
>>>>
>>>> I think this change should be reverted to fix the migration issue.
>>>>
>>>
>>> Moreover, if I look in the code of virtio_load() and 
>>> virtio_add_queue() we can guess it's
>>> not correct to migrate a virtqueue that is not initialized on the 
>>> destination side because
>>> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elems' 
>>> cannot be initialized
>>> by virtio_load() and neither by virtio_add_queue() after 
>>> virtio_load() as fields like
>>> 'vring.num' are already initialized by virtio_load().
>>>
>>> For instance, in virtio_load() we set:
>>>
>>>       for (i = 0; i < num; i++) {
>>>           vdev->vq[i].vring.num = qemu_get_be32(f);
>>>
>>> and in virtio_add_queue() we search for the firt available queue to 
>>> add with:
>>>
>>>       for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>           if (vdev->vq[i].vring.num == 0)
>>>               break;
>>>       }
>>>
>>> So virtio_add_queue() cannot be used to set:
>>>
>>>       vdev->vq[i].handle_output = handle_output;
>>>       vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
>>>
>>> Moreover it would overwrite fields already set by virtio_load():
>>>
>>>       vdev->vq[i].vring.num = queue_size;
>>>       vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>>>
>>> It also explains why virtio_net_change_num_queue_pairs() (indirectly 
>>> called by
>>> virtio_net_set_features()) doesn't update the queue pair numbers: 
>>> vring.num is already set
>>> so it thinks there is no more queues to add.
>>>
>>> Thanks,
>>> LAurent
>>>
>>
>> I agree.
>>
>> Laurent, would you like to send a patch to revert this?
>>
> 
> Yes. I will also try to fix the leak in unrealize that the patch wanted 
> to fix initially.

I wrote a fix so I will submit it once internal testing is done. You can 
see the change at:
https://gitlab.com/akihiko.odaki/qemu-kvm/-/commit/22161221aa2d2031d7ad1be7701852083aa9109a

Regards,
Akihiko Odaki

