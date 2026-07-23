Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF811C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmwQ4-0006wF-VS; Thu, 23 Jul 2026 12:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmwPv-0006vl-Im
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmwPt-0004Ap-2E
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784824619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo1aAkzLHCGYrSLAHHNKJEbvoRtVRbdxhfXLJSNVpY0=;
 b=IhdiBIzmH0X9XPAWANmlFwOtdeTbyoKIHBr2tiS22ng/4EAAju9VLFITjSZHYDtr1LzE+4
 T+EnPiC7DbKvhCZaCwfJI5H7liNNJE8vYWX6O+43lgfa43XTmD+AL7+KXi2uI5GthgcB2K
 Lqmkbr2aVIo7HKGrefXkQy4TN+rT2fg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-KiquOxCdOs6-sFa-tTyjkA-1; Thu, 23 Jul 2026 12:36:58 -0400
X-MC-Unique: KiquOxCdOs6-sFa-tTyjkA-1
X-Mimecast-MFC-AGG-ID: KiquOxCdOs6-sFa-tTyjkA_1784824617
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso8986675e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784824617; x=1785429417;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wo1aAkzLHCGYrSLAHHNKJEbvoRtVRbdxhfXLJSNVpY0=;
 b=Cmk64CySwidnSqLShvkw0dBlwnanWLtV7CLNd+FIzG6agOuYfgv9ZPuzMjPHiJjSmB
 YVmZhQk4PS9KRz2H8ewCcm5U47LtHmSnxrLRWBBPmK+ObFRuAhyCwXBF15IeGZhlanXP
 waCMO5Rj2pqsINExTOBH0IxRX4zEmFIJYKUmySPPeBzbekmnC9jDrogVcmwxuPtqOxgb
 iD9iz3SLg7pdJzdKsZg37KpneIgS2TOeyG/L+WI8Rd8Z5KOVJeSnkUQ4/CQOgTrFkuoY
 sFvogAt9UE1Sr8eJauYHN6gFRcbo9N2d5V+kkWk8nxJLqovhsqSvMEYoxXhcf/9Q9/8L
 bLHA==
X-Gm-Message-State: AOJu0Yw0gB0MhK8uwVhWcmxZs5xhqADEqWnNsVJUQeHIBCDdPaqm35zG
 g7+maS2e+lKQ+NFDUP1+MxE+fxarsXNQlkA4VAd6pfPxtzIquarBTZJZJAk9zeCPusME0/htToh
 frmPp5pWX4GURErsb4f96ZHu7aQCEwnOnGQb+l0W0eLWqn28aCVwhvHyA
X-Gm-Gg: AR+sD12E2a+q2DmEq0bVxHFCQ9uT/Rt3V2kSJtoNk9sxasO5WxcsQMfKSGTi/2qXqjT
 0mfMUqwz+Nc/NMgA91tYOxxbFXLAufyrbIeL4FyH5vP0DXfIOYqCh92k5WnbT1fK2mGEzbVct/R
 s7LvVrvjfI6sRf2DssASA0fFNt1EDFRuDe/pLDmiO2pa+fLlj+etjWG/i0wouEKaWI4CvIAsfRL
 DUV2DSnwfsWK9fRYTWOMLzK34dbkf53LMoT2bcxr7wsFuSyjpc9Pfw81VvM+3NWiwv09EluyVnL
 reuE8Bc8LBHreqhGMOKtUbWeCVshO/qcSS0sOm8CDbuzLLGVnakZ/1PVkeDrHY2y0vFLGRsewCf
 5hE61J9wy3ix7c2grP3G+R0ivn5YeYgqxgKLTUjK0kPVvr8/A
X-Received: by 2002:a05:600c:4ed1:b0:493:f5bf:4da4 with SMTP id
 5b1f17b1804b1-49573d11690mr45016965e9.28.1784824617020; 
 Thu, 23 Jul 2026 09:36:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:493:f5bf:4da4 with SMTP id
 5b1f17b1804b1-49573d11690mr45016745e9.28.1784824616572; 
 Thu, 23 Jul 2026 09:36:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d4d7sm5688915e9.2.2026.07.23.09.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:36:55 -0700 (PDT)
Message-ID: <e119b02b-7ba2-4092-b12d-5f34e030797a@redhat.com>
Date: Thu, 23 Jul 2026 18:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-iommu: fix OOM due to unbounded call_rcu
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
 <587f8a83-7d2e-4683-8992-380b494dcdd0@redhat.com>
 <20260723115707-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260723115707-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/23/26 6:01 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 23, 2026 at 05:42:02PM +0200, Eric Auger wrote:
>> Hi Michael,
>>
>> On 7/23/26 1:58 PM, Michael S. Tsirkin wrote:
>>> Currently, within virtio-iommu, handle_command processes the command vq
>>> without any limits on the number of entries processed.
>>> This can easily and repeatedly enable/disable multiple memory regions.
>>> Within the memory code, this causes an accumulation of an
>>> unbounded number of RCU-deferred FlatViews - each of these
>>> is supposed to be freed with call_rcu, but that never happens
>>> because the main thread never returns to the main loop.
>>>
>>> Given FlatView is big, it's easy to have this balloon out to multiple
>>> Gigabytes of memory.
>>>
>>> Limit the loop defer any remaining work to a timer.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  include/hw/virtio/virtio-iommu.h |  1 +
>>>  hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>>> index 3b86050f2c..1f265540ad 100644
>>> --- a/include/hw/virtio/virtio-iommu.h
>>> +++ b/include/hw/virtio/virtio-iommu.h
>>> @@ -65,6 +65,7 @@ struct VirtIOIOMMU {
>>>      GTree *domains;
>>>      QemuRecMutex mutex;
>>>      GTree *endpoints;
>>> +    QEMUTimer *cmd_timer;
>>>      bool boot_bypass;
>>>      Notifier machine_done;
>>>      bool granule_frozen;
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 08f7e8b783..533bd5073f 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -993,6 +993,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
>>>      return ret ? ret : virtio_iommu_probe(s, &req, buf);
>>>  }
>>>  
>>> +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
>>> +
>>> +static void virtio_iommu_handle_command_timer(void *opaque)
>>> +{
>>> +    VirtIOIOMMU *s = opaque;
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>> +
>>> +    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
>>> +        virtio_iommu_handle_command(vdev, s->req_vq);
>> So what does happen in terms of scheduling. Can't this run concurrently
>> with the usual direct virtio_iommu_handle_command() path? 
> BQL prevents that.
OK
>
>
>>> +    }
>>> +}
>>> +
>>>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>>  {
>>>      VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>>> @@ -1003,10 +1015,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>>      struct iovec *iov;
>>>      void *buf = NULL;
>>>      size_t sz;
>>> +    unsigned int batch = 0;
>>>  
>>>      for (;;) {
>>>          size_t output_size = sizeof(tail);
>>>  
>>> +        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
>> how did you chose that condition? is it always safe wrt oom situation?
> It's kinda random, but the idea is that queue size already gives us
> a point on the memory/speed curve.
>
> There's nothing that is "safe wrt oom" in all configs - qemu makes
> no promises and even a single allocation can in theory push you
> into oom if memory is tight.
>
> But what this prevents is unbounded memory allocations which will trigger
> oom at some point for sure.
OK thanks for the explanation

Eric
>
>
>
>>> +            timer_mod(s->cmd_timer,
>>> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
>>> +            break;
>>> +        }
>>> +
>>>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>>          if (!elem) {
>>>              return;
>>> @@ -1416,6 +1435,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>      s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
>>>                               virtio_iommu_handle_command);
>>>      s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
>>> +    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
>>> +                                virtio_iommu_handle_command_timer, s);
>>>  
>>>      /*
>>>       * config.bypass is needed to get initial address space early, such as
>>> @@ -1498,6 +1519,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
>>>  
>>>      qemu_rec_mutex_destroy(&s->mutex);
>>>  
>>> +    timer_free(s->cmd_timer);
>>>      virtio_delete_queue(s->req_vq);
>>>      virtio_delete_queue(s->event_vq);
>>>      virtio_cleanup(vdev);
>>> @@ -1509,6 +1531,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
>>>  
>>>      trace_virtio_iommu_device_reset_exit();
>>>  
>>> +    timer_del(s->cmd_timer);
>>> +
>>>      if (s->domains) {
>>>          g_tree_destroy(s->domains);
>>>      }
>>> @@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
>>>       * still correct.
>>>       */
>>>      virtio_iommu_switch_address_space_all(s);
>>> +
>>> +    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
>>> +        timer_mod(s->cmd_timer,
>>> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
>>> +    }
>>>      return 0;
>>>  }
>>>  
>> Thanks
>>
>> Eric


