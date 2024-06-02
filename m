Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5884C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 03:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxy6-0000tY-O0; Sun, 02 Jun 2024 23:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxy1-0000rE-Q4
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 23:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDm3y-00068M-Dy
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717337996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTBpgBqV5acSwPEQqkMQhtWg4Ro0B6fvhpVb2fXTKPk=;
 b=WGBI1AG04X8HGZOeT6g5zLULGCzjYU6/VYoeT+paAGlV0AzgsZg580dAMciMfyFnU04uFy
 tl+jGUjQR/1bZdHmQy3zYso7IxVcbrmWOUTHUdNEnQRF5dAqT6ggaKNyXkvLJgale14VZM
 21V0OfjtLCh7iazMA58z4RX01MgETI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-mcSE5YryPCuzJ01mbzeaBQ-1; Sun, 02 Jun 2024 10:19:55 -0400
X-MC-Unique: mcSE5YryPCuzJ01mbzeaBQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212a921370so22144465e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 07:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717337994; x=1717942794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTBpgBqV5acSwPEQqkMQhtWg4Ro0B6fvhpVb2fXTKPk=;
 b=Kxxaz3fZt6XrQo8iJBzCHEYsdOxSV8deIUvPz44dDmOaAcv5wo2G/NY9hDe+e1r3Ne
 elquoV3rQK9QTVtkCMyW4frR4X+crhx0/Bha5OLYvNQUPWU7Yz/0p9UXximyFdNTNu94
 YS4KdZW0ioZz3TDErIaah8jty20JnOU+EWuvk8sYjF6W0kdQXNkMf+cocRx2Pkd2ZZjV
 2NxPFfncXhrdiZO4jCUpTWbmHRLNmRhc6vRQkfd9kp7+/DOzVGWgMLV6P6N37rSeffc8
 jpebb7y/HqQoCPE0yoE20yopFtRMSJwb+Ptl51MT1JbyfhGPp1tEIz44N1GxKROZafOL
 NerQ==
X-Gm-Message-State: AOJu0Yzg5VKMGigr8YxKhZkDWS2xVbai7yEwx6mJ1Bm458Mo20tb9x9y
 JNtqkMl78Y4tLFcWSFzb5H0nnRz4B11q7yZ0QzNPj3tw399OcyLtpOJmAfTkKBwb1r63jdceUhb
 DMSCVpOcZP69CsAi0/C/jPehhjjQEwVLoQpHB5MVhLbWNVwQ6j3SR
X-Received: by 2002:a05:600c:1396:b0:420:182e:eb46 with SMTP id
 5b1f17b1804b1-4212e0bfec0mr68961885e9.38.1717337993773; 
 Sun, 02 Jun 2024 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj02qSBMegOVIU2BdhwAy3RqZiMisYwN3mDlR9vtt8MdXoCAKPKjG9gEK/nawYITkZCMh0lQ==
X-Received: by 2002:a05:600c:1396:b0:420:182e:eb46 with SMTP id
 5b1f17b1804b1-4212e0bfec0mr68961695e9.38.1717337993157; 
 Sun, 02 Jun 2024 07:19:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0f47sm6321758f8f.8.2024.06.02.07.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 07:19:52 -0700 (PDT)
Date: Sun, 2 Jun 2024 10:19:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] virtio-blk: remove SCSI passthrough functionality
Message-ID: <20240602101751-mutt-send-email-mst@kernel.org>
References: <20240508113203.36767-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508113203.36767-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 08, 2024 at 01:32:03PM +0200, Paolo Bonzini wrote:
> The legacy SCSI passthrough functionality has never been enabled for
> VIRTIO 1.0 and was deprecated more than four years ago.
> 
> Get rid of it---almost, because QEMU is advertising it unconditionally
> for legacy virtio-blk devices.  Just parse the header and return a
> nonzero status.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/deprecated.rst       |  10 --
>  docs/about/removed-features.rst |   8 ++
>  hw/block/virtio-blk.c           | 166 +++-----------------------------
>  hw/core/machine.c               |   2 -
>  4 files changed, 19 insertions(+), 167 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 03f8b1b655e..9bfaeda3adb 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,16 +282,6 @@ Device options
>  Emulated device options
>  '''''''''''''''''''''''
>  
> -``-device virtio-blk,scsi=on|off`` (since 5.0)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> -and later do not support it because the virtio-scsi device was introduced for
> -full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> -
> -Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
> -alias.
> -
>  ``-device nvme-ns,eui64-default=on|off`` (since 7.1)
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 53ca08aba9c..1044d657c1a 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -505,6 +505,14 @@ configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
>  to ensure that all the topology members described with -smp are greater
>  than zero.
>  
> +``-device virtio-blk,scsi=on|off`` (since 9.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Should not this be:
+``-device virtio-blk,scsi=on|off`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

for consistency with rest of the file?



> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> +and later do not support it because the virtio-scsi device was introduced for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> +
> +


I observe a single empty line between rest of entries. Why two lines
here? intentional?

>  User-mode emulator command line arguments
>  -----------------------------------------
>  
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index bb86e65f652..73bdfd6122a 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -172,57 +172,6 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
>      virtio_blk_free_request(req);
>  }
>  
> -#ifdef __linux__
> -
> -typedef struct {
> -    VirtIOBlockReq *req;
> -    struct sg_io_hdr hdr;
> -} VirtIOBlockIoctlReq;
> -
> -static void virtio_blk_ioctl_complete(void *opaque, int status)
> -{
> -    VirtIOBlockIoctlReq *ioctl_req = opaque;
> -    VirtIOBlockReq *req = ioctl_req->req;
> -    VirtIOBlock *s = req->dev;
> -    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> -    struct virtio_scsi_inhdr *scsi;
> -    struct sg_io_hdr *hdr;
> -
> -    scsi = (void *)req->elem.in_sg[req->elem.in_num - 2].iov_base;
> -
> -    if (status) {
> -        status = VIRTIO_BLK_S_UNSUPP;
> -        virtio_stl_p(vdev, &scsi->errors, 255);
> -        goto out;
> -    }
> -
> -    hdr = &ioctl_req->hdr;
> -    /*
> -     * From SCSI-Generic-HOWTO: "Some lower level drivers (e.g. ide-scsi)
> -     * clear the masked_status field [hence status gets cleared too, see
> -     * block/scsi_ioctl.c] even when a CHECK_CONDITION or COMMAND_TERMINATED
> -     * status has occurred.  However they do set DRIVER_SENSE in driver_status
> -     * field. Also a (sb_len_wr > 0) indicates there is a sense buffer.
> -     */
> -    if (hdr->status == 0 && hdr->sb_len_wr > 0) {
> -        hdr->status = CHECK_CONDITION;
> -    }
> -
> -    virtio_stl_p(vdev, &scsi->errors,
> -                 hdr->status | (hdr->msg_status << 8) |
> -                 (hdr->host_status << 16) | (hdr->driver_status << 24));
> -    virtio_stl_p(vdev, &scsi->residual, hdr->resid);
> -    virtio_stl_p(vdev, &scsi->sense_len, hdr->sb_len_wr);
> -    virtio_stl_p(vdev, &scsi->data_len, hdr->dxfer_len);
> -
> -out:
> -    virtio_blk_req_complete(req, status);
> -    virtio_blk_free_request(req);
> -    g_free(ioctl_req);
> -}
> -
> -#endif
> -
>  static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
>  {
>      VirtIOBlockReq *req = virtqueue_pop(vq, sizeof(VirtIOBlockReq));
> @@ -233,20 +182,14 @@ static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
>      return req;
>  }
>  
> -static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
> +static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
>  {
> -    int status = VIRTIO_BLK_S_OK;
> -    struct virtio_scsi_inhdr *scsi = NULL;
> +    int status;
> +    struct virtio_scsi_inhdr *scsi;
>      VirtIOBlock *blk = req->dev;
>      VirtIODevice *vdev = VIRTIO_DEVICE(blk);
>      VirtQueueElement *elem = &req->elem;
>  
> -#ifdef __linux__
> -    int i;
> -    VirtIOBlockIoctlReq *ioctl_req;
> -    BlockAIOCB *acb;
> -#endif
> -
>      /*
>       * We require at least one output segment each for the virtio_blk_outhdr
>       * and the SCSI command block.
> @@ -262,95 +205,16 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
>      /*
>       * The scsi inhdr is placed in the second-to-last input segment, just
>       * before the regular inhdr.
> +     *
> +     * Just put anything nonzero so that the ioctl fails in the guest.
>       */
>      scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
> -
> -    if (!virtio_has_feature(blk->host_features, VIRTIO_BLK_F_SCSI)) {
> -        status = VIRTIO_BLK_S_UNSUPP;
> -        goto fail;
> -    }
> -
> -    /*
> -     * No support for bidirection commands yet.
> -     */
> -    if (elem->out_num > 2 && elem->in_num > 3) {
> -        status = VIRTIO_BLK_S_UNSUPP;
> -        goto fail;
> -    }
> -
> -#ifdef __linux__
> -    ioctl_req = g_new0(VirtIOBlockIoctlReq, 1);
> -    ioctl_req->req = req;
> -    ioctl_req->hdr.interface_id = 'S';
> -    ioctl_req->hdr.cmd_len = elem->out_sg[1].iov_len;
> -    ioctl_req->hdr.cmdp = elem->out_sg[1].iov_base;
> -    ioctl_req->hdr.dxfer_len = 0;
> -
> -    if (elem->out_num > 2) {
> -        /*
> -         * If there are more than the minimally required 2 output segments
> -         * there is write payload starting from the third iovec.
> -         */
> -        ioctl_req->hdr.dxfer_direction = SG_DXFER_TO_DEV;
> -        ioctl_req->hdr.iovec_count = elem->out_num - 2;
> -
> -        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
> -            ioctl_req->hdr.dxfer_len += elem->out_sg[i + 2].iov_len;
> -        }
> -
> -        ioctl_req->hdr.dxferp = elem->out_sg + 2;
> -
> -    } else if (elem->in_num > 3) {
> -        /*
> -         * If we have more than 3 input segments the guest wants to actually
> -         * read data.
> -         */
> -        ioctl_req->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
> -        ioctl_req->hdr.iovec_count = elem->in_num - 3;
> -        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
> -            ioctl_req->hdr.dxfer_len += elem->in_sg[i].iov_len;
> -        }
> -
> -        ioctl_req->hdr.dxferp = elem->in_sg;
> -    } else {
> -        /*
> -         * Some SCSI commands don't actually transfer any data.
> -         */
> -        ioctl_req->hdr.dxfer_direction = SG_DXFER_NONE;
> -    }
> -
> -    ioctl_req->hdr.sbp = elem->in_sg[elem->in_num - 3].iov_base;
> -    ioctl_req->hdr.mx_sb_len = elem->in_sg[elem->in_num - 3].iov_len;
> -
> -    acb = blk_aio_ioctl(blk->blk, SG_IO, &ioctl_req->hdr,
> -                        virtio_blk_ioctl_complete, ioctl_req);
> -    if (!acb) {
> -        g_free(ioctl_req);
> -        status = VIRTIO_BLK_S_UNSUPP;
> -        goto fail;
> -    }
> -    return -EINPROGRESS;
> -#else
> -    abort();
> -#endif
> +    virtio_stl_p(vdev, &scsi->errors, 255);
> +    status = VIRTIO_BLK_S_UNSUPP;
>  
>  fail:
> -    /* Just put anything nonzero so that the ioctl fails in the guest.  */
> -    if (scsi) {
> -        virtio_stl_p(vdev, &scsi->errors, 255);
> -    }
> -    return status;
> -}
> -
> -static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
> -{
> -    int status;
> -
> -    status = virtio_blk_handle_scsi_req(req);
> -    if (status != -EINPROGRESS) {
> -        virtio_blk_req_complete(req, status);
> -        virtio_blk_free_request(req);
> -    }
> +    virtio_blk_req_complete(req, status);
> +    virtio_blk_free_request(req);
>  }
>  
>  static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
> @@ -1379,13 +1243,9 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>      virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
> -    if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
> -        if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_SCSI)) {
> -            error_setg(errp, "Please set scsi=off for virtio-blk devices in order to use virtio 1.0");
> -            return 0;
> -        }
> -    } else {
> +    if (!virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
>          virtio_clear_feature(&features, VIRTIO_F_ANY_LAYOUT);
> +        /* Added for historical reasons, removing it could break migration.  */
>          virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
>      }
>  
> @@ -2132,10 +1992,6 @@ static Property virtio_blk_properties[] = {
>      DEFINE_PROP_STRING("serial", VirtIOBlock, conf.serial),
>      DEFINE_PROP_BIT64("config-wce", VirtIOBlock, host_features,
>                        VIRTIO_BLK_F_CONFIG_WCE, true),
> -#ifdef __linux__
> -    DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
> -                      VIRTIO_BLK_F_SCSI, false),
> -#endif
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4ff60911e74..8cbbd529845 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -264,8 +264,6 @@ GlobalProperty hw_compat_2_5[] = {
>  const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
>  
>  GlobalProperty hw_compat_2_4[] = {
> -    /* Optional because the 'scsi' property is Linux-only */
> -    { "virtio-blk-device", "scsi", "true", .optional = true },
>      { "e1000", "extra_mac_registers", "off" },
>      { "virtio-pci", "x-disable-pcie", "on" },
>      { "virtio-pci", "migrate-extra", "off" },
> -- 
> 2.45.0


