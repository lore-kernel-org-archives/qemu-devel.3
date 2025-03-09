Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AF2C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 16:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trJXg-00034J-ER; Sun, 09 Mar 2025 12:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1trJXe-00033z-RX
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 12:30:19 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1trJXc-0003Up-H1
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 12:30:18 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-475a77bbd8cso32535191cf.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1741537814; x=1742142614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34tsGPn/f84WgoD6v+e9fssQ5UG+cRTizoiassW55Ak=;
 b=DjruLqB7quGReL31TEPmb+JcLblTBE0bggpgR7ExaG6f/fUYh6O75Vez5Drxt/fGPo
 dpBm0R9iCgQoa0oAdj+eA3VBuFPbQqCOl+wL9jb6p8+TTWz9l/TTPxOK65B9y0sIhUGL
 0HJtqRdmTHONfr3dVRrqZoLrKjWiWdkYQJA7M3rBXugjVWGXW0X+4Lm1b6SSN7fsk8Xt
 ytV8ERUDpkxFqm09MrispNFfKkmkO2CD+axzehphZm2HgKON4K9paBE8dNmXdFT6aFNh
 Jqkhwi+79GNWGe9wGWvl20q4KeK7NPNMBMgLhOLHMFNE2sMISYC/1lBVTDe2Tpr4MI8v
 9jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741537814; x=1742142614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34tsGPn/f84WgoD6v+e9fssQ5UG+cRTizoiassW55Ak=;
 b=GxD0980v/CVegj4btC/a1ZBMWA1uQ5OCpJhO8N21UtaWZZAN/7d+8FPG7Lm0wtaw1Q
 Pk2bHyyhEzKUgh8hlcDbCDXxlII8oSNjn6KeBLUndRadG/GgMfBQWR9Gnzl5yp6NNHJZ
 ysr9OgydZ5w6qCAJqq2AJnX0Fh2qqWEa/zhHYhapOLTZTzFcFvHJ1irwg5jqcKDKMEJD
 pVVCQWbqy0QB7VK/kIZPGxCZETu6SlXRMOM6Bn5FtV6wWRJL3b6j30RJhMKRFO07/UJY
 aO1CyPXZTjQkq6A3xgM+X5bx9FzMc2ELfqyfDTCqLO5AFQTcZNDlWY4y2CH+Ro/itc5p
 jnvA==
X-Gm-Message-State: AOJu0Yxq9MS16KOcufoQwEXv+caFdn8X2/9v3PTJeQUDl4v6e/R/NZML
 p8umohTFmgBb/7WNc+7WRTHTr40Z7/okYeh+Ar3QnKBgH/0QNI2SsRo8QpodtlI0cJDUNAhXgci
 nwgLDVNBqKa4leeucY0YHQPTlXM0T2PBzCddI8w==
X-Gm-Gg: ASbGnctVLG5s2Bgj0d+983/TG+rS7dGxlXg9S+f2IuYDKDyi4Vj9iBFNayaQenv+yyy
 YuMuXh2Lv65Arpgo2koJcPb3V6I4niQrUE9YGTxQGN4Ff7vADJr+ANPFAmDM99nRjWpaROJG6pW
 z9wgV11jZ6QXMZRGY/Wk6aizPz8g==
X-Google-Smtp-Source: AGHT+IEl0Z6BdGfxmUSTdie8+xQMtUMcbYJZSfJPlfcV2Gp4W4DeSqM6I0Nolf4RGfhDvONdl36eMUwZLifaRi7In50=
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id
 6a1803df08f44-6e900693d5cmr164899066d6.38.1741537812613; Sun, 09 Mar 2025
 09:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250309094051.3655292-1-haoqian.he@smartx.com>
 <20250309094051.3655292-2-haoqian.he@smartx.com>
In-Reply-To: <20250309094051.3655292-2-haoqian.he@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Sun, 9 Mar 2025 18:30:00 +0200
X-Gm-Features: AQ5f1JrBAI9yBJWWNKMD9xqNc2TuxN5i5hMlblIzTNk8o4OBnm_GFTctyNEFC2M
Message-ID: <CAMDpr=eb7+PRmHC_VyyYPZ=kz5E53KTKG7fq0AnuHv=VCLVPHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost-user: return failure if backend crash when live
 migration
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=raphael@enfabrica.net; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I'll let others chime in on higher level device model changes you're
making. For the vhost-user-blk and vhost-user-scsi bits:

On Sun, Mar 9, 2025 at 11:41=E2=80=AFAM Haoqian He <haoqian.he@smartx.com> =
wrote:
>
> Live migration should be terminated if backend crash.

nit: "...if the backend crashes before the migration completes."

>
> Since the vhost device will be stopped when VM is stopped before
> the end of the live migration, current implementation if vhost
> backend died, vhost device's set_status() will not return failure,
> live migration won't perceive the disconnection between qemu and
> vhost backend, inflight io would be submitted in migration target
> host, leading to IO error.
>
> To fix this issue:
> 1. Add set_status_ext() which has return value for
> VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.
>
> 2. In set_status_ext(), return failure if the flag `connected`
> is false or vhost_dev_stop return failure, which means qemu lost
> connection with backend.

I have some concerns with [2]. See my later responses.

>
> Hence migration_completion() will process failure, terminate
> migration and restore VM.
>
> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> ---
>  hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
>  hw/scsi/vhost-scsi-common.c           | 11 +++++-----
>  hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
>  hw/virtio/virtio.c                    | 20 +++++++++++++-----
>  include/hw/virtio/vhost-scsi-common.h |  2 +-
>  include/hw/virtio/virtio.h            |  1 +
>  6 files changed, 51 insertions(+), 32 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index ae42327cf8..4865786c54 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -204,7 +204,7 @@ err_host_notifiers:
>      return ret;
>  }
>
> -static void vhost_user_blk_stop(VirtIODevice *vdev)
> +static int vhost_user_blk_stop(VirtIODevice *vdev)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> @@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>      int ret;
>
>      if (!s->started_vu) {
> -        return;
> +        return 0;
>      }
>      s->started_vu =3D false;
>
>      if (!k->set_guest_notifiers) {
> -        return;
> +        return 0;
>      }
>
> -    vhost_dev_stop(&s->dev, vdev, true);
> +    ret =3D vhost_dev_stop(&s->dev, vdev, true);
>
> -    ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> -    if (ret < 0) {
> +    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>          error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> +        return -1;
>      }
>
>      vhost_dev_disable_notifiers(&s->dev, vdev);
> +    return ret;
>  }
>
> -static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status=
)
> +static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      bool should_start =3D virtio_device_should_start(vdev, status);
> @@ -239,11 +239,11 @@ static void vhost_user_blk_set_status(VirtIODevice =
*vdev, uint8_t status)
>      int ret;
>

Do we want to fail out in all cases where vhost_user_blk_set_status()
and the device is not connected? Could this impact power-on if the
backend is temporarily down?

>      if (!s->connected) {
> -        return;
> +        return -1;
>      }
>
>      if (vhost_dev_is_started(&s->dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>      }
>
>      if (should_start) {
> @@ -253,9 +253,12 @@ static void vhost_user_blk_set_status(VirtIODevice *=
vdev, uint8_t status)
>              qemu_chr_fe_disconnect(&s->chardev);
>          }
>      } else {
> -        vhost_user_blk_stop(vdev);
> +        ret =3D vhost_user_blk_stop(vdev);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
> -
> +    return 0;
>  }
>
>  static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> @@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass *kl=
ass, void *data)
>      vdc->get_config =3D vhost_user_blk_update_config;
>      vdc->set_config =3D vhost_user_blk_set_config;
>      vdc->get_features =3D vhost_user_blk_get_features;
> -    vdc->set_status =3D vhost_user_blk_set_status;
> +    vdc->set_status_ext =3D vhost_user_blk_set_status;
>      vdc->reset =3D vhost_user_blk_reset;
>      vdc->get_vhost =3D vhost_user_blk_get_vhost;
>  }
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index 4c8637045d..bfeed0cb1b 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -101,24 +101,25 @@ err_host_notifiers:
>      return ret;
>  }
>
> -void vhost_scsi_common_stop(VHostSCSICommon *vsc)
> +int vhost_scsi_common_stop(VHostSCSICommon *vsc)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret =3D 0;
>
> -    vhost_dev_stop(&vsc->dev, vdev, true);
> +    ret =3D vhost_dev_stop(&vsc->dev, vdev, true);
>
>      if (k->set_guest_notifiers) {
> -        ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, fals=
e);
> -        if (ret < 0) {
> +        int r =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, fa=
lse);
> +        if (r < 0) {
>                  error_report("vhost guest notifier cleanup failed: %d", =
ret);
>          }

Now that we return back a value the assert here should probably be dropped?

> +        assert(r >=3D 0);
>      }
> -    assert(ret >=3D 0);
>
>      vhost_dev_disable_notifiers(&vsc->dev, vdev);
> +    return ret;
>  }
>
>  uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t fea=
tures,
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index adb41b9816..8e7efc38f2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, Er=
ror **errp)
>      return ret;
>  }
>
> -static void vhost_user_scsi_stop(VHostUserSCSI *s)
> +static int vhost_user_scsi_stop(VHostUserSCSI *s)
>  {
>      VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>
>      if (!s->started_vu) {
> -        return;
> +        return 0;
>      }
>      s->started_vu =3D false;
>
> -    vhost_scsi_common_stop(vsc);
> +    return vhost_scsi_common_stop(vsc);
>  }
>
> -static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t statu=
s)
> +static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status=
)
>  {
>      VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>      DeviceState *dev =3D DEVICE(vdev);
> @@ -75,11 +75,11 @@ static void vhost_user_scsi_set_status(VirtIODevice *=
vdev, uint8_t status)
>      int ret;
>
>      if (!s->connected) {
> -        return;
> +        return -1;
>      }
>
>      if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
> -        return;
> +        return 0;
>      }
>
>      if (should_start) {
> @@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice *v=
dev, uint8_t status)
>              qemu_chr_fe_disconnect(&vs->conf.chardev);
>          }
>      } else {
> -        vhost_user_scsi_stop(s);
> +        ret =3D vhost_user_scsi_stop(s);
> +        if (ret) {
> +            return ret;
> +        }
>      }
> +    return 0;
>  }
>
>  static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
> @@ -399,7 +403,7 @@ static void vhost_user_scsi_class_init(ObjectClass *k=
lass, void *data)
>      vdc->unrealize =3D vhost_user_scsi_unrealize;
>      vdc->get_features =3D vhost_scsi_common_get_features;
>      vdc->set_config =3D vhost_scsi_common_set_config;
> -    vdc->set_status =3D vhost_user_scsi_set_status;
> +    vdc->set_status_ext =3D vhost_user_scsi_set_status;
>      fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
>      vdc->reset =3D vhost_user_scsi_reset;
>      vdc->get_vhost =3D vhost_user_scsi_get_vhost;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5e8d4cab53..fff7cdb35d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t=
 val)
>  {
>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>      trace_virtio_set_status(vdev, val);
> +    int ret =3D 0;
>
>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>          if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>              val & VIRTIO_CONFIG_S_FEATURES_OK) {
> -            int ret =3D virtio_validate_features(vdev);
> -
> +            ret =3D virtio_validate_features(vdev);
>              if (ret) {
>                  return ret;
>              }
> @@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t=
 val)
>          virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>      }
>
> -    if (k->set_status) {
> +    if (k->set_status_ext) {
> +        ret =3D k->set_status_ext(vdev, val);
> +        if (ret) {
> +            qemu_log("set %s status to %d failed, old status: %d\n",
> +                     vdev->name, val, vdev->status);
> +        }
> +    } else if (k->set_status) {
>          k->set_status(vdev, val);
>      }
>      vdev->status =3D val;
>
> -    return 0;
> +    return ret;
>  }
>
>  static enum virtio_device_endian virtio_default_endian(void)
> @@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, boo=
l running, RunState state)
>      }
>
>      if (!backend_run) {
> -        virtio_set_status(vdev, vdev->status);
> +        // the return value was used for stopping VM during migration
> +        int ret =3D virtio_set_status(vdev, vdev->status);
> +        if (ret) {
> +            return ret;
> +        }
>      }
>      return 0;
>  }
> diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vh=
ost-scsi-common.h
> index c5d2c09455..d54d9c916f 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -40,7 +40,7 @@ struct VHostSCSICommon {
>  };
>
>  int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
> -void vhost_scsi_common_stop(VHostSCSICommon *vsc);
> +int vhost_scsi_common_stop(VHostSCSICommon *vsc);
>  char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus=
,
>                                          DeviceState *dev);
>  void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *con=
fig);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 6386910280..c99d56f519 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>      void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>      void (*reset)(VirtIODevice *vdev);
>      void (*set_status)(VirtIODevice *vdev, uint8_t val);
> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>      /* Device must validate queue_index.  */
>      void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
>      /* Device must validate queue_index.  */
> --
> 2.48.1
>

