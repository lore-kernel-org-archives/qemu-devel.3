Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15813C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmwRG-0007K5-Qd; Thu, 23 Jul 2026 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmwR8-0007Jd-HU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmwR6-0004EY-5A
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784824694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xevl0oAs7IZ3fGVqfhVD4DPVOc9glSBeR3rVus8qVBo=;
 b=EPcbPakvp3whJy8D7DDrjgOGGwWv1iCXwjEXgl/+hgomJpaLvbYk6V4Eh58LUzbMJpuNrW
 A6hueXxeespQ37z0VtElXHB9xAogBtlCM584qGH3M0Lec38eeSqaLNlcX20WDTGr0+E4si
 1yFbTZZeQkvl8S7yHL4ZDP4SRaMr86Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-6LjBvT5tOEKCs1TvQJPkdA-1; Thu, 23 Jul 2026 12:38:13 -0400
X-MC-Unique: 6LjBvT5tOEKCs1TvQJPkdA-1
X-Mimecast-MFC-AGG-ID: 6LjBvT5tOEKCs1TvQJPkdA_1784824692
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso6037735e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784824692; x=1785429492;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xevl0oAs7IZ3fGVqfhVD4DPVOc9glSBeR3rVus8qVBo=;
 b=jmv2jp0RpIifQZEyUYqkalyuOtExgIp8I6+wUt7AXkAg0K7kQ4OIcU+oHBZgDhMxff
 47z5js5arRm5YMpK5kte3pzf/by8lWhm8JbqmhLJqshs61FOSYalYFMLnYk2ZMUPE+k/
 QxEzqCf8SnEdgJA/JBfoZjYkg0UiZRDyVWW801npMzHaqCsERMBxxOOhaaUara3DMqPx
 DkZt5vRdqnW01Q3Iz/0uPvLOmI6WZjdD5fykKKGylE8w1Wn051+zASyfZAJ1G069z5lC
 8iGNoCfAVN+L/vnGUvExmVydi7PCS6/calP2E4jP0+mpD/aqbtJzICS5klP0idNz5w4j
 Dmhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5PrrXIDn+IxgED5QeU3nK+fto3lpVTyg8PLufyuh+To1lQe5Q3wgr/lMNYHNOd5Q45EqpxrpF48MK@nongnu.org
X-Gm-Message-State: AOJu0Yx/CEiGwhtz0Uu7K6tiIygnKyeeCkdPEzckaHGPv0zpdS4uUCwb
 hfmUnyAKPwAbxKEyv3n0mBx+gPn1CaX79nBUjBmU+I0d74ITTBZAmW/NYVO/Qlx4qt7G00AhOsV
 5UFCqIYBhabHPTfYQn+rqqnX8MwnBKllXwrm2CFDimeLjmqma2RjeFxnH
X-Gm-Gg: AR+sD12GPKd0xm6Ser37lYUqiDJ6lwWznmTpu46o9VBmuplSfepMR5VmlwbbsX5yssV
 1vyjpkJcUmRkm6YTS+qAaEODKt+Du0YZzfZ92aloIT/yv53TidaulgUPegCpEZOozQPgNRoWx45
 WpyL2qLwdCLxGDL6v5F9OvgN8hhFA1vlP3T/l3d/e3uClTFBszHWgeBXYIF4U16LPsMyONtSa9y
 5EfahacphXTzfTGRHCHLH3n7rMfnVzMIaBhs+ucRsi+ZKLbhhaVwYYMbr6w72H/QJosl81O9Mua
 hxfteEFuNwVkABhVcAe52C96Cm0bUkD70gC1ZBNoSQWva3CzFSDrKWtrgGoMCHRwJT/a6v1bqYr
 r37vKvgurjhD/TND7YejoZV5uUBIVkMYZfOntMIlnFihSv68l
X-Received: by 2002:a05:600c:4ed1:b0:495:5d6d:9cb3 with SMTP id
 5b1f17b1804b1-49573d13756mr40667475e9.37.1784824691822; 
 Thu, 23 Jul 2026 09:38:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:495:5d6d:9cb3 with SMTP id
 5b1f17b1804b1-49573d13756mr40667175e9.37.1784824691360; 
 Thu, 23 Jul 2026 09:38:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm17607276f8f.37.2026.07.23.09.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:38:10 -0700 (PDT)
Message-ID: <aa14aaa7-0e90-4ccf-9f06-f20b778a885e@redhat.com>
Date: Thu, 23 Jul 2026 18:38:09 +0200
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
Content-Transfer-Encoding: 7bit
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

test migration, reset and obviously normal execution with lowered threshold.

Thanks!

Eric
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


