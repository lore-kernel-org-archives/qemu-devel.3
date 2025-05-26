Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C48FC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 03:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJOP8-0005j8-I8; Sun, 25 May 2025 23:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJOP7-0005iy-5q
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:21:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJOP4-0003Vm-9k
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:21:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-234488c2ea6so6801685ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748229688; x=1748834488;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RPBmsiv+SQ9+411qHi2U8jTBr7epoYlkdmC+qbOH+I=;
 b=eyRCndJP/upzcxNnCxoe1nGRMsa6QB5bf2i6+aAFwaYuKDHoJyE9KcB29ghjS2QmIL
 hP+UsNcB2bXQZIPGYjzgNiFeP61cmfj9yBhW6gLL7rtpdYTf+1LKA2YlkmD5+ndEl/Ei
 YPR33T5vT1p8d90fz7Bb83h9f/mtW1cLW8H7UzL/56PwY5Hu7ndqGKbZEJuEiklMf3Qh
 PeZirz1Z9f5tGnAgWGD53JvnybP/CNzxwwAwsfom3Y3bMANmddsSQjhDMemNu1yOc7tg
 Z5m/q87d7oFQNMn2D/VieEAas+yTvIAzRW3C/xN2GL/DmxVriloyhUiPhaCeTnaJEEH9
 jDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748229688; x=1748834488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RPBmsiv+SQ9+411qHi2U8jTBr7epoYlkdmC+qbOH+I=;
 b=w2p50w4UVTMVY2sD/jLwPwIcgu+mk1uUGLREtwoMvpphHucYDhFhsY5YXCHi0RYxHz
 GUCOlCBgovPqCQdB7iq2coB7x738h+4ZMbwvx5tgXbwtbJbeGcChMhbWXqTP/ToJxSEV
 /mgshFme5we2qwL1ZyFJDPPYaOYS9dLZZx0//gHsM7Jw92RtAO9slt67vYSScRFfLvkc
 tlbVGzkbmfC8Cm/V+/hz0YRaBxW3+dB72o32QC9bVLmOVbmaRti28AbDrWSYobLqJkRu
 axHLrISecays29R7SSBRTsCXn9UTfAltyhP1mOrUWQ0NitXpJNUbHt/AgDiGXLLyT6vf
 FeQg==
X-Gm-Message-State: AOJu0YxPPw5FgsfWLatWvcfXg3jz5eBz6ySIbUoxBjDiPqkUDIYU1Dr9
 xemu+WAv9/r7xYBeR6NNPXP8238xS1gXSiCyuuMkw9A7pwSy8OUOdNHC7cOYxpkdqaIu4tc7veZ
 YV1Ut
X-Gm-Gg: ASbGncvoOfXwcp94H2bBfD3f731AbrcqY1fqdOv3lnJ2hclszV56I97GnuYYOznGgf9
 x/FCNlP44XFCvM9oNX7FxcouMW/gnAto9OHles0Ezezwlq/m2uGT7oJm3ML7gTH99JC5uxHevH1
 BMYcDgWk4ye2kFlb95aY99DeKiI8+usdZ2VdD0sOiO5Nf+OutrBk93YLZXXjGy5JM72uYhCMbEl
 srfWNyzbPSuBfSVLoNxVV0bubb8RIW3sbKz+9aEeD5MOXOBYonda9412SrIstC8edJSarQ22Nav
 4nuQbUQelvQ86CIxGfcj61fFWnaa2+kGp7CUOlnpNtSEkbaHi0oqmfAXclfCMg==
X-Google-Smtp-Source: AGHT+IGjSJ4e/ekXqBdBlItNUxY5B9dB1/AYvcnVVV2KG6ZnmYu8UMygdasEg2J8dX1Q4PM6XCXU7A==
X-Received: by 2002:a17:902:fc84:b0:220:c178:b2e with SMTP id
 d9443c01a7336-23414f535aamr116036085ad.17.1748229687558; 
 Sun, 25 May 2025 20:21:27 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2340c2df1fbsm37091745ad.139.2025.05.25.20.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 20:21:27 -0700 (PDT)
Message-ID: <dd14717e-0e6d-4bdd-80d5-de820148f6c2@daynix.com>
Date: Mon, 26 May 2025 12:21:25 +0900
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
 <fb575fb3-d17c-4fd2-8dff-a77fd91b1d6a@daynix.com>
 <CACGkMEvkbgGeWwBLd=9RzTzA3PkiiRu0QiDkF56ATrRzz72m5g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvkbgGeWwBLd=9RzTzA3PkiiRu0QiDkF56ATrRzz72m5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

On 2025/05/26 9:41, Jason Wang wrote:
> On Thu, May 22, 2025 at 12:39 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/05/22 10:50, 'Jason Wang' via devel wrote:
>>> On Wed, May 21, 2025 at 11:51 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/05/21 9:51, Jason Wang wrote:
>>>>> On Fri, May 16, 2025 at 11:29 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/05/16 10:44, Jason Wang wrote:
>>>>>>> On Wed, May 14, 2025 at 2:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
>>>>>>>>> On Sat, May 10, 2025 at 3:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
>>>>>>>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
>>>>>>>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
>>>>>>>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
>>>>>>>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
>>>>>>>>>> VIRTIO_NET_F_MQ uses bit 22.
>>>>>>>>>>
>>>>>>>>>> Instead of inferring the required number of queues from
>>>>>>>>>> vdev->guest_features, use the number loaded from the vm state.
>>>>>>>>>>
>>>>>>>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>> ---
>>>>>>>>>>       include/hw/virtio/virtio.h |  2 +-
>>>>>>>>>>       hw/net/virtio-net.c        | 11 ++++-------
>>>>>>>>>>       hw/virtio/virtio.c         | 14 +++++++-------
>>>>>>>>>>       3 files changed, 12 insertions(+), 15 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>>>>>> index 638691028050..af52580c1e63 100644
>>>>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>>>>>>>>>>           int (*start_ioeventfd)(VirtIODevice *vdev);
>>>>>>>>>>           void (*stop_ioeventfd)(VirtIODevice *vdev);
>>>>>>>>>>           /* Called before loading queues. Useful to add queues before loading. */
>>>>>>>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
>>>>>>>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
>>>>>>>>>
>>>>>>>>> This turns out to be tricky as it has a lot of assumptions as
>>>>>>>>> described in the changelog (e.g only lower 32bit of guest_features is
>>>>>>>>> correct etc when calling this function).
>>>>>>>>
>>>>>>>> The problem is that I missed the following comment in
>>>>>>>> hw/virtio/virtio.c:
>>>>>>>>          /*
>>>>>>>>           * Temporarily set guest_features low bits - needed by
>>>>>>>>           * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>>>>>>>>           * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
>>>>>>>>           *
>>>>>>>>           * Note: devices should always test host features in future - don't
>>>>>>>> create
>>>>>>>>           * new dependencies like this.
>>>>>>>>           */
>>>>>>>>          vdev->guest_features = features;
>>>>>>>>
>>>>>>>> This problem is specific to guest_features so avoiding it should give us
>>>>>>>> a reliable solution.
>>>>>>>
>>>>>>> I meant not all the states were fully loaded for pre_load_queues(),
>>>>>>> this seems another trick besides the above one. We should seek a way
>>>>>>> to do it in post_load() or at least document the assumptions.
>>>>>>
>>>>>> The name of the function already clarifies the state is not fully
>>>>>> loaded. An implementation of the function can make no assumption on the
>>>>>> state except that you can add queues here, which is already documented.
>>>>>
>>>>> Where? I can only see this:
>>>>>
>>>>>        /* Called before loading queues. Useful to add queues before loading. */
>>>>
>>>> I meant it is documented that it can add queues. There is nothing else
>>>> to document as an implementation of the function can make no assumption
>>>> else.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Looking at the commit that introduces this which is 9379ea9db3c that says:
>>>>>>>>>
>>>>>>>>> """
>>>>>>>>> Otherwise the loaded queues will not have handlers and elements
>>>>>>>>> in them will not be processed.
>>>>>>>>> """
>>>>>>>>>
>>>>>>>>> I fail to remember what it means or what happens if we don't do 9379ea9db3c.
>>>>>>>>
>>>>>>>> The packets and control commands in the queues except the first queue
>>>>>>>> will not be processed because they do not have handle_output set.
>>>>>>>
>>>>>>> I don't understand here, the VM is not resumed in this case. Or what
>>>>>>> issue did you see here?
>>>>>>
>>>>>> Below is the order of relevant events that happen when loading and
>>>>>> resuming a VM for migration:
>>>>>>
>>>>>> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
>>>>>> queue, and one control queue.
>>>>>> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues if
>>>>>> the "n" parameter requires that.
>>>>>> 3) The state of queues are loaded.
>>>>>> 4) The VM gets resumed.
>>>>>>
>>>>>> If we skip 2), 3) will load states of queues that are not added yet,
>>>>>> which breaks these queues and packets and leave control packets on them
>>>>>> unprocessed.
>>>>>
>>>>> Ok, let's document this and
>>>>>
>>>>> 1) explain why only virtio-net requires the pre_load_queues (due to
>>>>> the fact that the index of ctrl vq could be changed according to
>>>>> #queue_paris)
>>>>
>>>> We would need this logic even if the index of ctrl vq didn't change. We
>>>> need it because virtio-net have varying number of queues, which needs to
>>>> be added before loading.
>>>
>>> Well, if the ctrl vq index doesn't change we don't need a dynamic
>>> virtio_add_queue() we can do them all in realize just like other
>>> multiqueue devices.
>>
>> The number of virtqueues also affects the behavior visible to the guest
>> so we shouldn't add them all in realize anyway. In particular, struct
>> virtio_pci_common_cfg contains fields related virtqueus, and most (if
>> not all) of them are affected by the number of virtqueues.
> 
> I don't understand here, is this requested by the spec for example?

The spec is not relevant here as commit 9379ea9db3c0 ("virtio-net: Add 
queues before loading them") and this patch deal with migration.

QEMU promises that migration will not change behaviors visible to the 
guest and the number of virtqueues are visible to the guest. So these 
changes aim to prevent the number of virtqueues changes after migration.

Regards,
Akihiko Odaki

