Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2B7C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNpe-0002n8-7A; Tue, 06 Feb 2024 10:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rXNpY-0002mG-59
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rXNpW-0003oJ-MO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707235064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4iUKb6WtBSYl38bt1+IqBCu2H/AswFxWeAELmeskTY=;
 b=PNBzxFHTQRHgDABfX2aZc9in+Ip62/m21nYxgWxpRyosLIU1RjojA8yYsBwJiBN5Rw3MgX
 1hKq7fMv+DXYPUrvrrmmJhQMx52ZAg0Ecn3chJS7jRSMPVFTlsMBljKtBJZEvBdGybmdLZ
 Mtk5TbhXj2IwOepG8Yy16LIBIAd4QOI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-VZZqmNMBOWOiiDcE8xstMg-1; Tue, 06 Feb 2024 10:57:43 -0500
X-MC-Unique: VZZqmNMBOWOiiDcE8xstMg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d0a3bcfb11so22506201fa.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707235062; x=1707839862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4iUKb6WtBSYl38bt1+IqBCu2H/AswFxWeAELmeskTY=;
 b=Kekd05+7KyOjQmexhsQo57KSJDRPFU/brpe7DyqU2IwuVlT9EMBkD5rEG3bp0N3ylr
 lErulQVSVbsv6hqpwXqFc3ezEgoYz+FC5KWguFY7gsu20JqSSz4Vdu+Y+ZufPN5fq0qm
 sfG8Lk+0qFy97s7yJLGbZyFIjkYdMH4z2vGszyEN+5p5YmjLfDn21yjJn8Y6w0VXyC6x
 S3FA17b1zobOhAvYN0iCpeKQSdCAlqhfLkcDhuD2hIF8Ce5h59EtqUCZMBk9mzE6BXmi
 82tW2XM7t5e/RRt+JiuES/aJACWN466QIQg5RqbxsYSbj3mX187ANQXLf5iNv3pCeDBY
 ajIA==
X-Gm-Message-State: AOJu0YwuT/IEsDo6Q9nH2EABBj8Zz+DMDrv1mS3Tu0TtlhK0/0CFXlPv
 U/chryGuBvU4gklXp3na+foDJ967kkyb44VfVcJvhPZz7P0hFKXsjKbqrImmiJLRkw9gA24araW
 PJLTDmBkOlxPs0sgSE6muzl0razVKywbLGuzdNAUTqW5BVJIBFeIe
X-Received: by 2002:a2e:2416:0:b0:2d0:abec:25b9 with SMTP id
 k22-20020a2e2416000000b002d0abec25b9mr1925938ljk.50.1707235062018; 
 Tue, 06 Feb 2024 07:57:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmvpsZsU0LVLam4y32AtDylZwC30+ZXMlWp4J1Jv/LVdMp+N6uKY5j6JtjaJxAVzrZnf2ZeA==
X-Received: by 2002:a2e:2416:0:b0:2d0:abec:25b9 with SMTP id
 k22-20020a2e2416000000b002d0abec25b9mr1925920ljk.50.1707235061587; 
 Tue, 06 Feb 2024 07:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUxg6Cun3Zjl4EyMISSmP9uf8CG4HpUwFbQCV5ck53s2Zqwpwy/K9k49Xy4IJY2QB5F1qZI/MPdeT2N0Quh7tes6Mr4x8jLLwUcZ/4z12Y1VA4q8KgqL49oO56d05LY+U7hhPkzPfbz6fBK
Received: from redhat.com ([2.52.129.159]) by smtp.gmail.com with ESMTPSA id
 fj18-20020a0564022b9200b005607825b11bsm1154597edb.12.2024.02.06.07.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 07:57:40 -0800 (PST)
Date: Tue, 6 Feb 2024 10:57:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] virtio-blk: do not use C99 mixed declarations
Message-ID: <20240206105722-mutt-send-email-mst@kernel.org>
References: <20240206140410.65650-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206140410.65650-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 09:04:09AM -0500, Stefan Hajnoczi wrote:
> QEMU's coding style generally forbids C99 mixed declarations.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

or maybe it's time we moved on?

> ---
>  hw/block/virtio-blk.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 227d83569f..f6009cd9b3 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -661,16 +661,16 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
>      int64_t zrp_size, n, j = 0;
>      int64_t nz = data->zone_report_data.nr_zones;
>      int8_t err_status = VIRTIO_BLK_S_OK;
> -
> -    trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
> -    if (ret) {
> -        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
> -        goto out;
> -    }
> -
>      struct virtio_blk_zone_report zrp_hdr = (struct virtio_blk_zone_report) {
>          .nr_zones = cpu_to_le64(nz),
>      };
> +
> +    trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
> +    if (ret) {
> +        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
> +        goto out;
> +    }
> +
>      zrp_size = sizeof(struct virtio_blk_zone_report)
>                 + sizeof(struct virtio_blk_zone_descriptor) * nz;
>      n = iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
> @@ -898,13 +898,14 @@ static int virtio_blk_handle_zone_append(VirtIOBlockReq *req,
>  
>      int64_t offset = virtio_ldq_p(vdev, &req->out.sector) << BDRV_SECTOR_BITS;
>      int64_t len = iov_size(out_iov, out_num);
> +    ZoneCmdData *data;
>  
>      trace_virtio_blk_handle_zone_append(vdev, req, offset >> BDRV_SECTOR_BITS);
>      if (!check_zoned_request(s, offset, len, true, &err_status)) {
>          goto out;
>      }
>  
> -    ZoneCmdData *data = g_malloc(sizeof(ZoneCmdData));
> +    data = g_malloc(sizeof(ZoneCmdData));
>      data->req = req;
>      data->in_iov = in_iov;
>      data->in_num = in_num;
> @@ -1191,14 +1192,15 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
>  {
>      VirtIOBlock *s = opaque;
>      uint16_t num_queues = s->conf.num_queues;
> +    g_autofree VirtIOBlockReq **vq_rq = NULL;
> +    VirtIOBlockReq *rq;
>  
>      if (!running) {
>          return;
>      }
>  
>      /* Split the device-wide s->rq request list into per-vq request lists */
> -    g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
> -    VirtIOBlockReq *rq;
> +    vq_rq = g_new0(VirtIOBlockReq *, num_queues);
>  
>      WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
>          rq = s->rq;
> @@ -1924,6 +1926,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIOBlock *s = VIRTIO_BLK(dev);
>      VirtIOBlkConf *conf = &s->conf;
> +    BlockDriverState *bs;
>      Error *err = NULL;
>      unsigned i;
>  
> @@ -1969,7 +1972,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    BlockDriverState *bs = blk_bs(conf->conf.blk);
> +    bs = blk_bs(conf->conf.blk);
>      if (bs->bl.zoned != BLK_Z_NONE) {
>          virtio_add_feature(&s->host_features, VIRTIO_BLK_F_ZONED);
>          if (bs->bl.zoned == BLK_Z_HM) {
> -- 
> 2.43.0


