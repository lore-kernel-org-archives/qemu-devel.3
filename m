Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AECC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6yg-0002YL-NE; Tue, 12 Mar 2024 14:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6yf-0002Y9-3t
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6yd-0000Px-7P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710268549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiY2P7m0uTCToX8UaUdzNrw659X+6BxkAAP/zZe/LUA=;
 b=OqlrYo6cxPGUmgBsEFaxlNA6DfcLUcrJoAz3fyajWL/B1WVQLWe+m4gQykgpbGCVuU/mhO
 fdL/XHtq9v0GUOUgFLl960IBB0LjW8aNMiOr7suzFbsgNl4QPJx5N0xWZXjOI0Y9idE06U
 mRxEovVHBWC5ZCkuEOqxDxM3/50/xKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-iA11R5FTOJOcjasExZ9GAw-1; Tue, 12 Mar 2024 14:35:47 -0400
X-MC-Unique: iA11R5FTOJOcjasExZ9GAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412edc9d70aso35031595e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268546; x=1710873346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiY2P7m0uTCToX8UaUdzNrw659X+6BxkAAP/zZe/LUA=;
 b=Zg5TP6gjjcmacwMkkcWaCn0+z8+NKFpIUwaqMQ9hBqcVjj7j2HdgswNyODsmg6ceN7
 Ecv+FRqYWVvuIu2ZEm+Jfe7rWNGPGcC4cWTsyOUE5O1lsM3ahv5IaVsp6bU3jlhhntzM
 KbwW5lblgISc2hS/NJvLdCh4ZJJNWZQk5YUNHpRikov0wyvLszTfu3jwebzNRTQUu7r2
 TVh4fUuk6F4nNClKKIdBkO208cMMcl4MC0Jv2aqg+QWohTm6SgO+ZXBZppAmFJtyNJ0n
 PQZtM7yWCQlgNQWGlSIPmLUn4B1dwfmsrm81NqfY17/7ELLrqzdDuFtFu663b1/Hg/Un
 WidQ==
X-Gm-Message-State: AOJu0YwIPPDo9PlotmW89cCkn2Eq4iSwMIggHQLglbzFwjuBFhHJbr/c
 jEwl70Q8Se88Rhuo+/552vKURo0aXNVQL/3nXhIjMIuEn6WQw6a9qRFKCqsdlGAJdBxMtIq6734
 vo8BMkcM09ZFyij4K70DnPDBnDphKeYb6g7nFQ9jgPg4o++w0uAS/
X-Received: by 2002:adf:e8ce:0:b0:33b:62c0:6181 with SMTP id
 k14-20020adfe8ce000000b0033b62c06181mr166761wrn.42.1710268546101; 
 Tue, 12 Mar 2024 11:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrHVpfcvRHz1m9sILW/Ywi4+Ck37q25OW1nuyxTveGxG5zc5fLEPqgSOrgQplcMtx1gr8BiQ==
X-Received: by 2002:adf:e8ce:0:b0:33b:62c0:6181 with SMTP id
 k14-20020adfe8ce000000b0033b62c06181mr166750wrn.42.1710268545549; 
 Tue, 12 Mar 2024 11:35:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adffdc6000000b0033b66c2d61esm9643633wrs.48.2024.03.12.11.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:35:44 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:35:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 2/2] vhost: Perform memory section dirty scans once
 per iteration
Message-ID: <20240312143425-mutt-send-email-mst@kernel.org>
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
 <1707911419-11758-2-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707911419-11758-2-git-send-email-si-wei.liu@oracle.com>
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

On Wed, Feb 14, 2024 at 03:50:19AM -0800, Si-Wei Liu wrote:
> On setups with one or more virtio-net devices with vhost on,
> dirty tracking iteration increases cost the bigger the number
> amount of queues are set up e.g. on idle guests migration the
> following is observed with virtio-net with vhost=on:
> 
> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14

Given the drastic slowdown I am prepared to treat this as
a bugfix if a version addressing all comments and rebased
is sent early during the freeze.

> With high memory rates the symptom is lack of convergence as soon
> as it has a vhost device with a sufficiently high number of queues,
> the sufficient number of vhost devices.
> 
> On every migration iteration (every 100msecs) it will redundantly
> query the *shared log* the number of queues configured with vhost
> that exist in the guest. For the virtqueue data, this is necessary,
> but not for the memory sections which are the same. So
> essentially we end up scanning the dirty log too often.
> 
> To fix that, select a vhost device responsible for scanning the
> log with regards to memory sections dirty tracking. It is selected
> when we enable the logger (during migration) and cleared when we
> disable the logger. If the vhost logger device goes away for some
> reason, the logger will be re-selected from the rest of vhost
> devices.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost.c         | 75 +++++++++++++++++++++++++++++++++++++++++++----
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ef6d9b5..997d560 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,6 +45,9 @@
>  
>  static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>  static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> +static struct vhost_dev *vhost_mem_logger[VHOST_BACKEND_TYPE_MAX];
> +static QLIST_HEAD(, vhost_dev) vhost_mlog_devices =
> +    QLIST_HEAD_INITIALIZER(vhost_mlog_devices);
>  
>  /* Memslots used by backends that support private memslots (without an fd). */
>  static unsigned int used_memslots;
> @@ -149,6 +152,53 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>      }
>  }
>  
> +static bool vhost_log_dev_enabled(struct vhost_dev *dev)
> +{
> +    assert(dev->vhost_ops);
> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    return dev == vhost_mem_logger[dev->vhost_ops->backend_type];
> +}
> +
> +static void vhost_mlog_set_dev(struct vhost_dev *hdev, bool enable)
> +{
> +    struct vhost_dev *logdev = NULL;
> +    VhostBackendType backend_type;
> +    bool reelect = false;
> +
> +    assert(hdev->vhost_ops);
> +    assert(hdev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(hdev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    backend_type = hdev->vhost_ops->backend_type;
> +
> +    if (enable && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        reelect = !vhost_mem_logger[backend_type];
> +        QLIST_INSERT_HEAD(&vhost_mlog_devices, hdev, logdev_entry);
> +    } else if (!enable && QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        reelect = vhost_mem_logger[backend_type] == hdev;
> +        QLIST_REMOVE(hdev, logdev_entry);
> +    }
> +
> +    if (!reelect)
> +        return;
> +
> +    QLIST_FOREACH(hdev, &vhost_mlog_devices, logdev_entry) {
> +        if (!hdev->vhost_ops ||
> +            hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_NONE ||
> +            hdev->vhost_ops->backend_type >= VHOST_BACKEND_TYPE_MAX)
> +            continue;
> +
> +        if (hdev->vhost_ops->backend_type == backend_type) {
> +            logdev = hdev;
> +            break;
> +        }
> +    }
> +
> +    vhost_mem_logger[backend_type] = logdev;
> +}
> +
>  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                     MemoryRegionSection *section,
>                                     hwaddr first,
> @@ -166,12 +216,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>      start_addr = MAX(first, start_addr);
>      end_addr = MIN(last, end_addr);
>  
> -    for (i = 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg = dev->mem->regions + i;
> -        vhost_dev_sync_region(dev, section, start_addr, end_addr,
> -                              reg->guest_phys_addr,
> -                              range_get_last(reg->guest_phys_addr,
> -                                             reg->memory_size));
> +    if (vhost_log_dev_enabled(dev)) {
> +        for (i = 0; i < dev->mem->nregions; ++i) {
> +            struct vhost_memory_region *reg = dev->mem->regions + i;
> +            vhost_dev_sync_region(dev, section, start_addr, end_addr,
> +                                  reg->guest_phys_addr,
> +                                  range_get_last(reg->guest_phys_addr,
> +                                                 reg->memory_size));
> +        }
>      }
>      for (i = 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq = dev->vqs + i;
> @@ -382,6 +434,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
>          g_free(log);
>      }
>  
> +    vhost_mlog_set_dev(dev, false);
>      dev->log = NULL;
>      dev->log_size = 0;
>  }
> @@ -997,6 +1050,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>              goto err_vq;
>          }
>      }
> +
> +    /*
> +     * At log start we select our vhost_device logger that will scan the
> +     * memory sections and skip for the others. This is possible because
> +     * the log is shared amongst all vhost devices for a given type of
> +     * backend.
> +     */
> +    vhost_mlog_set_dev(dev, enable_log);
> +
>      return 0;
>  err_vq:
>      for (; i >= 0; --i) {
> @@ -2072,6 +2134,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>              VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
>              goto fail_log;
>          }
> +        vhost_mlog_set_dev(hdev, true);
>      }
>      if (vrings) {
>          r = vhost_dev_set_vring_enable(hdev, true);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 0247778..d75faf4 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -129,6 +129,7 @@ struct vhost_dev {
>      void *opaque;
>      struct vhost_log *log;
>      QLIST_ENTRY(vhost_dev) entry;
> +    QLIST_ENTRY(vhost_dev) logdev_entry;
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
>      const VhostDevConfigOps *config_ops;
> -- 
> 1.8.3.1


