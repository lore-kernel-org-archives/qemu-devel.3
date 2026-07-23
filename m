Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B16DC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvZ2-0003cz-Tb; Thu, 23 Jul 2026 11:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmvYt-0003aI-KA
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmvYp-0003QZ-RV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784821327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Osao2wWYr4o40ToqXgi0eI0+ZDb02/kDLiUxukaV02U=;
 b=U9KHlmhHEmR5pcwAmp23yaHfdwNhjVkQlPdIBnoCflO/gLHUJ1oV74/j+qxDwOAgHK9+iA
 sAM3yz3oiGv/RjWkGLEisdhV86rLNEz9DZiFpxRXBpuAnQyGgTo/cLLHeI2h/SsVXxeOvL
 Uq4Zr6O1IFwQ2mmyHfEEv5KJxvKNV3M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-zOjDMjLAPDmYbZgMpcYSkQ-1; Thu, 23 Jul 2026 11:42:06 -0400
X-MC-Unique: zOjDMjLAPDmYbZgMpcYSkQ-1
X-Mimecast-MFC-AGG-ID: zOjDMjLAPDmYbZgMpcYSkQ_1784821325
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f810c8aebso513919f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784821325; x=1785426125;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Osao2wWYr4o40ToqXgi0eI0+ZDb02/kDLiUxukaV02U=;
 b=DPLKpwNkboANqK32I1gLcRKCx0P+YUSsD3ziEzsaKH5l3R6llLVJut2KwFzcFSB+Tu
 RYK+Mmq5NHjJ3oi4i7MgKrUaKFTwn9mO84YcMTwOzsXeAnniazWEQRyRbLkfp8VpMSED
 7acwsI/6RdkSHVnOVh0dphLC3vemBHiC8VHSaWAt6xCLqHV1UDb3aPti0lX9SGa91gjC
 3Cb28mrRMou/PEJTdFdY2aRG3vYW8OA6Q42R4QzPUxFtcAv8X7NNo8GvEPv2Icr+qIC+
 41HU9cF21NDizMEUhmEsOxbvpHk0mviHMWdaEklW9h+wWdu9OIxzNFBQ2ewQSUK6iq/O
 J/jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAkc7RHpJbF3S777jR/i0vLKW+oGnkAVXLf++U6XNWNMyj75GncCs/MVzGvMkWPv5n6Rk8vDfm3oMZ@nongnu.org
X-Gm-Message-State: AOJu0Yx4a0xPCcpC/RWpo7oLQjnQUUSCi2cla/lp8uWcnzL8ZZaaYooS
 QG+VGsTKSwdVmmFCmGGEqJF+zcHcwEH+sAUG4u2h0gyG7hg1Wl95ykkNo/uV0LrSBELtepOSmy9
 Wwibb80lYd8IH4TpHDhihL/3tu8aJUbqawOyzncXGa1NM3dbSU0Fbp5sw
X-Gm-Gg: AR+sD13TOQx2WsT3qbuX0gIGecoQwG+dZFarPVdYjxB5bebqazooCp0UI1qCUfpt8/g
 gaQpvZ+bjdJVqKna/Bmoc4yFLy7ARl8qLXFlVQxhiYHRVu6qOOgPMzln5ynFtBjl3useHujLJhZ
 EY8g6NM0pH0QhxkI2C3yYmvJorGvv6oTCvr/JCeYUajmLujpdv14H69rLKnrUkX8fza5jivWCLo
 xXMIbwe8ZGfYv0AD5x5MOdALpu2TsZaLxWOV3/pV7vFA5CZT/njlrNw87Yq4V62wRWPUjwFYP0E
 yyal464elUq+85SD/zDxfE7sz2vPIU7F7kP3WiN1pymjqCjGOyrawWlj3ylfrTDw1pP6YNNuqrX
 aLhpjVBihdvs/0DRSb8OJySq43x0sR86m9gdBiq8RmZBcaO3n
X-Received: by 2002:a05:6000:29cc:b0:47f:91f3:de52 with SMTP id
 ffacd0b85a97d-47f91f3de88mr2318717f8f.37.1784821324946; 
 Thu, 23 Jul 2026 08:42:04 -0700 (PDT)
X-Received: by 2002:a05:6000:29cc:b0:47f:91f3:de52 with SMTP id
 ffacd0b85a97d-47f91f3de88mr2318688f8f.37.1784821324438; 
 Thu, 23 Jul 2026 08:42:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm17860959f8f.7.2026.07.23.08.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 08:42:03 -0700 (PDT)
Message-ID: <587f8a83-7d2e-4683-8992-380b494dcdd0@redhat.com>
Date: Thu, 23 Jul 2026 17:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-iommu: fix OOM due to unbounded call_rcu
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Michael,

On 7/23/26 1:58 PM, Michael S. Tsirkin wrote:
> Currently, within virtio-iommu, handle_command processes the command vq
> without any limits on the number of entries processed.
> This can easily and repeatedly enable/disable multiple memory regions.
> Within the memory code, this causes an accumulation of an
> unbounded number of RCU-deferred FlatViews - each of these
> is supposed to be freed with call_rcu, but that never happens
> because the main thread never returns to the main loop.
>
> Given FlatView is big, it's easy to have this balloon out to multiple
> Gigabytes of memory.
>
> Limit the loop defer any remaining work to a timer.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio-iommu.h |  1 +
>  hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 3b86050f2c..1f265540ad 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -65,6 +65,7 @@ struct VirtIOIOMMU {
>      GTree *domains;
>      QemuRecMutex mutex;
>      GTree *endpoints;
> +    QEMUTimer *cmd_timer;
>      bool boot_bypass;
>      Notifier machine_done;
>      bool granule_frozen;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 08f7e8b783..533bd5073f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -993,6 +993,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
>      return ret ? ret : virtio_iommu_probe(s, &req, buf);
>  }
>  
> +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
> +
> +static void virtio_iommu_handle_command_timer(void *opaque)
> +{
> +    VirtIOIOMMU *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
> +        virtio_iommu_handle_command(vdev, s->req_vq);
So what does happen in terms of scheduling. Can't this run concurrently
with the usual direct virtio_iommu_handle_command() path? 
> +    }
> +}
> +
>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
> @@ -1003,10 +1015,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>      struct iovec *iov;
>      void *buf = NULL;
>      size_t sz;
> +    unsigned int batch = 0;
>  
>      for (;;) {
>          size_t output_size = sizeof(tail);
>  
> +        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
how did you chose that condition? is it always safe wrt oom situation?
> +            timer_mod(s->cmd_timer,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
> +            break;
> +        }
> +
>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>          if (!elem) {
>              return;
> @@ -1416,6 +1435,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
>                               virtio_iommu_handle_command);
>      s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
> +    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> +                                virtio_iommu_handle_command_timer, s);
>  
>      /*
>       * config.bypass is needed to get initial address space early, such as
> @@ -1498,6 +1519,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
>  
>      qemu_rec_mutex_destroy(&s->mutex);
>  
> +    timer_free(s->cmd_timer);
>      virtio_delete_queue(s->req_vq);
>      virtio_delete_queue(s->event_vq);
>      virtio_cleanup(vdev);
> @@ -1509,6 +1531,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
>  
>      trace_virtio_iommu_device_reset_exit();
>  
> +    timer_del(s->cmd_timer);
> +
>      if (s->domains) {
>          g_tree_destroy(s->domains);
>      }
> @@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
>       * still correct.
>       */
>      virtio_iommu_switch_address_space_all(s);
> +
> +    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
> +        timer_mod(s->cmd_timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
> +    }
>      return 0;
>  }
>  
Thanks

Eric


