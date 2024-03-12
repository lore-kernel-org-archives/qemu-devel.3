Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FACC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6Sl-0002Z3-Ch; Tue, 12 Mar 2024 14:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6SF-0002RD-AU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6SC-0003Hu-On
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710266540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuFXnHbk4Ph8I7gPvn0ymvYNVfFIImEZkhvtspv5C0I=;
 b=PTMro+baNbgvbiUCTo3UKaRXmOk82HLj8q5TiaTGI6mAE5aphn3tHbigTcdFAfBUhoNHPp
 crN8t2ZizHUV1SZ7CvbqHTBazH5nWW9grErRDxyU5KErVi9gzLzN+cGButYmGzoacrARAJ
 mvttuUq5tPgoVi5mCcRFakN2sJqtixc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-7HbVeDJvP0-TPkyerttWxg-1; Tue, 12 Mar 2024 14:02:18 -0400
X-MC-Unique: 7HbVeDJvP0-TPkyerttWxg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412e992444eso24679305e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266537; x=1710871337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuFXnHbk4Ph8I7gPvn0ymvYNVfFIImEZkhvtspv5C0I=;
 b=p7ZE2XRbnukTjqDWFTIEqg2RNol1DJ8MpCqwfrTPdcpnbTQVMPomgz1zeQmJcFOkAM
 HeAMxmzg+2cx7sM5SkoRpBbcH2USlJszx/xw35qPO0K/Et5PZij4RLm//Do9bT1c16hy
 Yc7rr6vG4uGdXPgNKh6TkL560EvDdkqYGSDSX9V2oGgdGM45SEDyz+/6B/q+LkcaOruB
 RUoEzg2OFPDCaB7Sv2eFe0ri7d9TwVdOoW3vace9XseYjdb2/xEUvNy5AEwgLljPEvgY
 oz7CVq4Do3gtWVHivJ/LlZzhuZ1b/dnDDeCwSMv9BUYDQIVg+qVyIUCwrF62RDatfhnk
 hBeA==
X-Gm-Message-State: AOJu0YyV9PoP1tnq7dbqsHqk09Rxx84lQ6wlLag08JhTk7M0gL8BsXf4
 EWhs3TQ8eZIPRjTLxghFL2qiW5D6snu30jJOH5wPDmNODBWeCh9eQiJ1J8kadiKqu5UxK0n9LJx
 RvdcqkbyaxN/usa9MGBw0pj833OWkvZ8GP/JsB5X1U3BPNRf9AILV
X-Received: by 2002:a05:600c:310f:b0:412:f572:5318 with SMTP id
 g15-20020a05600c310f00b00412f5725318mr7670648wmo.11.1710266537032; 
 Tue, 12 Mar 2024 11:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmedmsaF7YJ8lTr+O81RCDuBOTcYZxyMkmkTL7zXUMOM18B3cLOJQj45BL0yDB6G4NlrnY9A==
X-Received: by 2002:a05:600c:310f:b0:412:f572:5318 with SMTP id
 g15-20020a05600c310f00b00412f5725318mr7670623wmo.11.1710266536478; 
 Tue, 12 Mar 2024 11:02:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 bd24-20020a05600c1f1800b00413e4ff2884sm854211wmb.40.2024.03.12.11.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:02:16 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:02:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: iothread-vq-mapping coroutine pool sizing
Message-ID: <20240312140142-mutt-send-email-mst@kernel.org>
References: <20240312151204.412624-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312151204.412624-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 12, 2024 at 11:12:04AM -0400, Stefan Hajnoczi wrote:
> It is possible to hit the sysctl vm.max_map_count limit when the
> coroutine pool size becomes large. Each coroutine requires two mappings
> (one for the stack and one for the guard page). QEMU can crash with
> "failed to set up stack guard page" or "failed to allocate memory for
> stack" when this happens.
> 
> Coroutine pool sizing is simple when there is only thread: sum up all
> I/O requests across all virtqueues.
> 
> When the iothread-vq-mapping option is used we should calculate tighter
> bounds because thread may serve a subset of the device's virtqueues:
> take the maximum number of the number of I/O requests across all
> virtqueues. A thread does not need coroutine pool space for I/O requests
> that are handled by other threads.
> 
> This is not a solution to hitting vm.max_map_count, but it helps. A
> guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
> iothread-vq-mapping virtio-blk device and a root disk without goes from
> pool_max_size 16,448 to 10,304.
> 
> Reported-by: Sanjay Rao <srao@redhat.com>
> Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> Reported-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Looks reasonable.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

if you want me to merge it, let me know pls.

> ---
> v2:
> - State the the tighter bounds reflect the fact that threads may only
>   process a subset of the total I/O requests from a device [Kevin]
> - Add Reported-by: Joe Mario, he has been investigating this issue.
> 
>  include/hw/virtio/virtio-blk.h |  2 ++
>  hw/block/virtio-blk.c          | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index 5c14110c4b..ac29700ad4 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -74,6 +74,8 @@ struct VirtIOBlock {
>      uint64_t host_features;
>      size_t config_size;
>      BlockRAMRegistrar blk_ram_registrar;
> +
> +    unsigned coroutine_pool_size;
>  };
>  
>  typedef struct VirtIOBlockReq {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 738cb2ac36..0a14b2b175 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1957,6 +1957,35 @@ static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
>      s->ioeventfd_stopping = false;
>  }
>  
> +/* Increase the coroutine pool size to include our I/O requests */
> +static void virtio_blk_inc_coroutine_pool_size(VirtIOBlock *s)
> +{
> +    VirtIOBlkConf *conf = &s->conf;
> +    unsigned max_requests = 0;
> +
> +    /* Tracks the total number of requests for AioContext */
> +    g_autoptr(GHashTable) counters = g_hash_table_new(NULL, NULL);
> +
> +    /* Call this function after setting up vq_aio_context[] */
> +    assert(s->vq_aio_context);
> +
> +    for (unsigned i = 0; i < conf->num_queues; i++) {
> +        AioContext *ctx = s->vq_aio_context[i];
> +        unsigned n = GPOINTER_TO_UINT(g_hash_table_lookup(counters, ctx));
> +
> +        n += conf->queue_size / 2; /* this is a heuristic */
> +
> +        g_hash_table_insert(counters, ctx, GUINT_TO_POINTER(n));
> +
> +        if (n > max_requests) {
> +            max_requests = n;
> +        }
> +    }
> +
> +    qemu_coroutine_inc_pool_size(max_requests);
> +    s->coroutine_pool_size = max_requests; /* stash it for ->unrealize() */
> +}
> +
>  static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -2048,7 +2077,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < conf->num_queues; i++) {
>          virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
>      }
> -    qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
>  
>      /* Don't start ioeventfd if transport does not support notifiers. */
>      if (!virtio_device_ioeventfd_enabled(vdev)) {
> @@ -2065,6 +2093,8 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    virtio_blk_inc_coroutine_pool_size(s);
> +
>      /*
>       * This must be after virtio_init() so virtio_blk_dma_restart_cb() gets
>       * called after ->start_ioeventfd() has already set blk's AioContext.
> @@ -2096,7 +2126,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
>      for (i = 0; i < conf->num_queues; i++) {
>          virtio_del_queue(vdev, i);
>      }
> -    qemu_coroutine_dec_pool_size(conf->num_queues * conf->queue_size / 2);
> +    qemu_coroutine_dec_pool_size(s->coroutine_pool_size);
>      qemu_mutex_destroy(&s->rq_lock);
>      blk_ram_registrar_destroy(&s->blk_ram_registrar);
>      qemu_del_vm_change_state_handler(s->change);
> -- 
> 2.44.0


