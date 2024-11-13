Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D916D41C02
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 05:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB5eh-0008LZ-4M; Wed, 13 Nov 2024 00:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tB5ec-0008KA-KS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 00:10:58 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tB5ea-0008GC-Fz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 00:10:58 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so61862725ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 21:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731474654; x=1732079454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DKA09rfKoGn0RSaAxp2Rf0LndBFiHMNM6/gsNbFAKK4=;
 b=VCetXalZPDfSESWmDWEgW20MGy1L359b6xR9WTHTbL9HzbypFOzyuDMVenT07u0pwr
 UUFdrhMlo8evk6AtmUyWB/oFjirrjljzAJq2BqgUCTAO+FUnpxwoAgOfF85x1EABCYSn
 elLxUzqrgWukNeylf1KB6pOhxsWpT8I21kN7YV2eXVXcfLe4B56A8r83IzbmME+nRALb
 ctaBZSiY7uduUXfthoaFWRSogv98rFk1FPcV8INj8OUvqhBtyOCW3JOaAhJ90tY14r4H
 QeeYnLaMYeFJhTqeS/gEv118YiJhs5uAqOz6LCNHgNdRoZjE2KfeSdfPEN0y3oSzF6bm
 C7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731474654; x=1732079454;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DKA09rfKoGn0RSaAxp2Rf0LndBFiHMNM6/gsNbFAKK4=;
 b=IajQDtDIS/5ojFxPh1gL5EkDcGjcrsL17O6ilOIIOrCGuLZGgr3wv4gjsOproQjiRi
 rMVIzbIKTrbZdf2+dZHDBeCodRK7mieJUtwBuIaBEJez+cunvdzzM15rfDVBlHoBWSxQ
 DTEo3Xq+EdQzqb3TiG0t/F7xNQRovi9RhwS48ipQRMfIxCjZUvvtqpkZEBhcoeK5WX4n
 98LNbk4Zt3XjOP2Qnfi89pqj5KE2dHdlAligrO7X1ikXTNHawk1h7dcyZWxKMD9aMHFu
 Km1AKCeA/zdoTlN5rhA2ccvZklyqMBEynUc6uX+gxjACjfb9ehJ6lr8vZZ5SZ/1tI2PA
 CSaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaudoFvAsGy2MBuYotNYwkjwuhssm4aItnjS1fSKtZsG3o4zaN6bINtLLqwOfXJQLdnva1/zyH+2mc@nongnu.org
X-Gm-Message-State: AOJu0YxdtTRbjNuZiT9kxf1HZFo5kOhnLeSGmmEwmFNqqiBVa89K5R14
 KVgGdeq64fnV2eav0QuLrj4VmZx/+bm/0CsTBnsQIMLTC6btPHwE
X-Google-Smtp-Source: AGHT+IGjvJd60W28D6NQHYGbhptpAx5Dl9Z4cg2uraLE5ahnzDP/0N5paGBPWFoUPG0ID7A4t/TugA==
X-Received: by 2002:a17:903:234c:b0:20b:8a71:b5c1 with SMTP id
 d9443c01a7336-211834e6bf1mr261707055ad.1.1731474653781; 
 Tue, 12 Nov 2024 21:10:53 -0800 (PST)
Received: from [192.168.1.8] ([223.233.80.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9dffsm102845045ad.57.2024.11.12.21.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 21:10:53 -0800 (PST)
Message-ID: <89ae0aad-eb82-4f51-9384-689a19e1626d@gmail.com>
Date: Wed, 13 Nov 2024 10:40:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
From: Sahil Siddiq <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
 <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
In-Reply-To: <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
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

On 10/28/24 11:07 AM, Sahil Siddiq wrote:
> [...]
> The payload that VHOST_SET_VRING_BASE accepts depends on whether
> split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost-
> vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which is
> not suitable for packed virtqueues:
> 
> struct vhost_vring_state s = {
>          .index = vq_index,
> };
> 
> Based on the implementation in the linux kernel, the payload needs to
> be as shown below for the ioctl to succeed for packed virtqueues:
> 
> struct vhost_vring_state s = {
>          .index = vq_index,
>          .num = 0x80008000,
> };
> 
> After making these changes, it looks like QEMU is able to set up the
> virtqueues and shadow virtqueues are enabled as well.
> 
> Unfortunately, before the L2 VM can finish booting the kernel crashes.
> The reason is that even though packed virtqueues are to be used, the
> kernel tries to run
> drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() [8]
> (instead of virtqueue_get_buf_ctx_packed) and throws an "invalid vring
> head" error. I am still investigating this issue.

I made a mistake here. "virtqueue_get_buf_ctx_packed" [1] in the linux
kernel also throws the same error. I think the issue might be because
hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings [2] does not handle
mapping packed virtqueues at the moment.

Probably because of this, vq->packed.desc_state[id].data [1] is NULL in the
kernel.

Regarding one of the earlier reviews in the same thread [3]:

On 8/7/24 9:52 PM, Eugenio Perez Martin wrote:
> On Fri, Aug 2, 2024 at 1:22 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Allocate memory for the packed vq format and support
>> packed vq in the SVQ "start" and "stop" operations.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> [...]
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>> index 4c308ee53d..f4285db2b4 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> [...]
>> @@ -672,6 +674,16 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
>>       return ROUND_UP(used_size, qemu_real_host_page_size());
>>   }
>>
>> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
>> +{
>> +    size_t desc_size = sizeof(struct vring_packed_desc) * svq->num_free;
>> +    size_t driver_event_suppression = sizeof(struct vring_packed_desc_event);
>> +    size_t device_event_suppression = sizeof(struct vring_packed_desc_event);
>> +
>> +    return ROUND_UP(desc_size + driver_event_suppression + device_event_suppression,
>> +                    qemu_real_host_page_size());
>> +}
>> +
>>   /**
>>    * Set a new file descriptor for the guest to kick the SVQ and notify for avail
>>    *
>> @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>>
>>      svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
>>      svq->num_free = svq->vring.num;
>> -    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
>> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
>> -                           -1, 0);
>> -    desc_size = sizeof(vring_desc_t) * svq->vring.num;
>> -    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
>> -    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
>> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
>> -                           -1, 0);
>> -    svq->desc_state = g_new0(SVQDescState, svq->vring.num);
>> -    svq->desc_next = g_new0(uint16_t, svq->vring.num);
>> -    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
>> +    svq->is_packed = virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED);
>> +
>> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
>> +        svq->vring_packed.vring.desc = mmap(NULL, vhost_svq_memory_packed(svq),
>> +                                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
>> +                                            -1, 0);
>> +        desc_size = sizeof(struct vring_packed_desc) * svq->vring.num;
>> +        svq->vring_packed.vring.driver = (void *)((char *)svq->vring_packed.vring.desc + desc_size);
>> +        svq->vring_packed.vring.device = (void *)((char *)svq->vring_packed.vring.driver +
>> +                                                  sizeof(struct vring_packed_desc_event));
> 
> This is a great start but it will be problematic when you start
> mapping the areas to the vdpa device. The driver area should be read
> only for the device, but it is placed in the same page as a RW one.
> 
> More on this later.
> 
>> +    } else {
>> +        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
>> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
>> +                               -1, 0);
>> +        desc_size = sizeof(vring_desc_t) * svq->vring.num;
>> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
>> +        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
>> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
>> +                               -1, 0);
>> +    }
> 
> I think it will be beneficial to avoid "if (packed)" conditionals on
> the exposed functions that give information about the memory maps.
> These need to be replicated at
> hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.

Based on what I have understood, I'll need to have an if(packed)
condition in vhost_vdpa_svq_map_rings() because the mappings will
differ in the packed and split cases.

> However, the current one depends on the driver area to live in the
> same page as the descriptor area, so it is not suitable for this.

Right, for the split case, svq->vring.desc and svq->vring.avail are
mapped to the same page.

     svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
     desc_size = sizeof(vring_desc_t) * svq->vring.num;
     svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);

vhost_svq_driver_area_size() encompasses the descriptor area and avail ring.

> So what about this action plan:
> 1) Make the avail ring (or driver area) independent of the descriptor ring.
> 2) Return the mapping permissions of the descriptor area (not needed
> here, but needed for hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings

Does point 1 refer to mapping the descriptor and avail rings to separate
pages for both split and packed cases. I am not sure if my understanding
is correct.

I believe, however, that this approach will make it easier to map the
rings in the vdpa device. It might also help in removing the if(packed)
condition in vhost_svq_start().

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1708
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vdpa.c#L1178
[3] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01145.html

