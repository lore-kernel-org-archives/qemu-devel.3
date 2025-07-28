Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F3EC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPof-0006mW-GP; Mon, 28 Jul 2025 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPob-0006kB-Jx
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPoZ-0001Dm-B8
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuwiBCsDC0uZt945uQRrM5t3efzA3VCmig+RyN1wvAo=;
 b=VJ8WYesdYfU6td1Avn4fvHdYRUcSmaIjiw4drx3UzKH0RlTXQQKY6aXgVCowUZ04nq7pjX
 1BhTOzTSYwAQjCOU8lbjoB7+2DUA4i74LYzWOYNvrjlaMbD3waQPzvVBJaz0vVTcHgyA2z
 eez+Bexb7PTH9xbHD0o0sJAsicdhJas=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-sVFB_QLcNdSfJYHfi9YVYA-1; Mon, 28 Jul 2025 11:30:54 -0400
X-MC-Unique: sVFB_QLcNdSfJYHfi9YVYA-1
X-Mimecast-MFC-AGG-ID: sVFB_QLcNdSfJYHfi9YVYA_1753716654
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b2c36d3f884so3379849a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753716653; x=1754321453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuwiBCsDC0uZt945uQRrM5t3efzA3VCmig+RyN1wvAo=;
 b=dpMhr61keBhn8/67uU9qz2a42UWabwpfX63OblGRy6FHrsIDqWrzSrTQICFJNY76xh
 lTUh6oLNIHWlp3FtU2T+IWF6GPvtksIwLgF4UUPaiU515yPOhNtm8ydyH3OXnp2+WBcK
 7abATjxBUCYz188fxZgIxrXwbk1BxBqBhw2ghC0SP2KVJdzHC6+rF5vFseBTQ+dl35iG
 /lsaxNiY8E0RLQFrldD4ntstjAbzd5NltwwGN4n07jXRDV4dU03IKRigWNCqJlrrYnRe
 mEB6n6xx4SyMmWFTduPk6qZuDrwJYgxmUqSPCm/m6t0Qr9wAcKFz9gC4XJQp1kcyBcPC
 SPtA==
X-Gm-Message-State: AOJu0YynNSZtytCoKl4+38yHrhEWYyWJzzC9nIkBfF5hkbqFJLos7bDw
 d/NFuiK0sZPe5k/8YLmMd3XDYKd4jdRDHjzSZz7t0dhHWQ6OQ6KGinxrAacyjm1IxuQFumZ49or
 Etn66XjjrxqsygBQEG1f5UP+R5btsk7zwYVewSczZtB7RPyBo2u/1m+aQFmHLaHhglJP1NtTmzi
 AQpBsrtvt1WM1xfRVF3V/mZiDoIad8djo=
X-Gm-Gg: ASbGncsSxAzTAbyTzDFffeFv/cvfIuCvuFWA0YcjeFcMiibS9j0PDw9xGFrwgqrw37p
 EtnTWujtZ1inI5wmvnWtDSP7lBuP8frwqHf5yxIlysAZ6zIIvUjzp4R80O+LhjjXXMLqzc06J39
 w6/4hovVAdhZOZOmhze36y
X-Received: by 2002:a17:90b:2b8b:b0:314:2892:b1e0 with SMTP id
 98e67ed59e1d1-31e77a1a327mr14505773a91.34.1753716653465; 
 Mon, 28 Jul 2025 08:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtq12NO/zFlOGDk2Ct09I+SLScHbYuxkjhq8CmaHtLHPUqcrPZedbIlchAUpktaGXhe39qCjJ8F2VEkAZafSY=
X-Received: by 2002:a17:90b:2b8b:b0:314:2892:b1e0 with SMTP id
 98e67ed59e1d1-31e77a1a327mr14505726a91.34.1753716653015; Mon, 28 Jul 2025
 08:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
In-Reply-To: <20250722124127.2497406-6-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 17:30:16 +0200
X-Gm-Features: Ac12FXzDSQN8QIXMXcQl_Djcc2Pz53aq5cQ43EqhvlaGf3ttnsMPwhJyIHfMS08
Message-ID: <CAJaqyWd7z-5cHojosMA5mrPQiD8Lz76zF=pmUrQ0cuuXvuSLzg@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 22, 2025 at 2:41=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Iterative live migration for virtio-net sends an initial
> VMStateDescription while the source is still active. Because data
> continues to flow for virtio-net, the guest's avail index continues to
> increment after last_avail_idx had already been sent. This causes the
> destination to often see something like this from virtio_error():
>
> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0=
xfff4
>
> This patch suppresses this consistency check if we're loading the
> initial VMStateDescriptions via iterative migration and unsuppresses
> it for the stop-and-copy phase when the final VMStateDescriptions
> (carrying the correct indices) are loaded.
>
> A temporary VirtIODevMigration migration data structure is introduced her=
e to
> represent the iterative migration process for a VirtIODevice. For now it
> just holds a flag to indicate whether or not the initial
> VMStateDescription was sent during the iterative live migration process.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c        | 13 +++++++++++++
>  hw/virtio/virtio.c         | 32 ++++++++++++++++++++++++--------
>  include/hw/virtio/virtio.h |  6 ++++++
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 86a6fe5b91..b7ac5e8278 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3843,12 +3843,19 @@ static void virtio_net_save_cleanup(void *opaque)
>
>  static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp=
)
>  {
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    vdev->migration =3D g_new0(VirtIODevMigration, 1);
> +    vdev->migration->iterative_vmstate_loaded =3D false;
> +
>      return 0;
>  }
>
>  static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_=
id)
>  {
>      VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    VirtIODevMigration *mig =3D vdev->migration;
>      uint64_t flag;
>
>      flag =3D qemu_get_be64(f);
> @@ -3861,6 +3868,7 @@ static int virtio_net_load_state(QEMUFile *f, void =
*opaque, int version_id)
>          case VNET_MIG_F_INIT_STATE:
>          {
>              vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_=
VERSION);
> +            mig->iterative_vmstate_loaded =3D true;

This code will need to change if we send the status iteratively more
than once. For example, if the guest changes the mac address, the
number of vqs, etc.

In my opinion, we should set a flag named "in_iterative_migration" (or
equivalent) in virtio_net_load_setup and clear it in
virtio_net_load_cleanup. That's enough to tell in virtio_load if we
should perform actions like checking for inconsistent indices.

>              break;
>          }
>          default:
> @@ -3875,6 +3883,11 @@ static int virtio_net_load_state(QEMUFile *f, void=
 *opaque, int version_id)
>
>  static int virtio_net_load_cleanup(void *opaque)
>  {
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    g_free(vdev->migration);
> +    vdev->migration =3D NULL;
> +
>      return 0;
>  }
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5534251e01..68957ee7d1 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3222,6 +3222,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id)
>      int32_t config_len;
>      uint32_t num;
>      uint32_t features;
> +    bool inconsistent_indices;
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> @@ -3365,6 +3366,16 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
>
> +           /*
> +            * Ring indices will be inconsistent during iterative migrati=
on. The actual
> +            * indices will be sent later during the stop-and-copy phase.
> +            */
> +            if (vdev->migration) {
> +                inconsistent_indices =3D !vdev->migration->iterative_vms=
tate_loaded;
> +            } else {
> +                inconsistent_indices =3D false;
> +            }

Nit, "inconsistent_indices =3D vdev->migration &&
!vdev->migration->iterative_vmstate_loaded" ? I'm happy with the
current "if else" too, but I think the one line is clearer. Your call
:).

> +
>              /*
>               * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
>               * only the region cache needs to be set up.  Legacy devices=
 need
> @@ -3384,14 +3395,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
>                  continue;
>              }
>
> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
> -            /* Check it isn't doing strange things with descriptor numbe=
rs. */
> -            if (nheads > vdev->vq[i].vring.num) {
> -                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
> -                             "inconsistent with Host index 0x%x: delta 0=
x%x",
> -                             i, vdev->vq[i].vring.num,
> -                             vring_avail_idx(&vdev->vq[i]),
> -                             vdev->vq[i].last_avail_idx, nheads);
> +            if (!inconsistent_indices) {
> +                nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> +                /* Check it isn't doing strange things with descriptor n=
umbers. */
> +                if (nheads > vdev->vq[i].vring.num) {
> +                    virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x=
 "
> +                                 "inconsistent with Host index 0x%x: del=
ta 0x%x",
> +                                 i, vdev->vq[i].vring.num,
> +                                 vring_avail_idx(&vdev->vq[i]),
> +                                 vdev->vq[i].last_avail_idx, nheads);
> +                    inconsistent_indices =3D true;
> +                }
> +            }
> +            if (inconsistent_indices) {
>                  vdev->vq[i].used_idx =3D 0;
>                  vdev->vq[i].shadow_avail_idx =3D 0;
>                  vdev->vq[i].inuse =3D 0;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 214d4a77e9..06b6e6ba65 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -98,6 +98,11 @@ enum virtio_device_endian {
>      VIRTIO_DEVICE_ENDIAN_BIG,
>  };
>
> +/* VirtIODevice iterative live migration data structure */
> +typedef struct VirtIODevMigration {
> +    bool iterative_vmstate_loaded;
> +} VirtIODevMigration;
> +
>  /**
>   * struct VirtIODevice - common VirtIO structure
>   * @name: name of the device
> @@ -151,6 +156,7 @@ struct VirtIODevice
>      bool disable_legacy_check;
>      bool vhost_started;
>      VMChangeStateEntry *vmstate;
> +    VirtIODevMigration *migration;
>      char *bus_name;
>      uint8_t device_endian;
>      /**
> --
> 2.47.1
>


