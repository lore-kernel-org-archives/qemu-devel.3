Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574A7C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 09:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh2sx-0006cQ-MH; Wed, 30 Jul 2025 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uh2fI-0000lq-C5
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 05:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uh2fG-0007pR-3r
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 05:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753865996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAmyZEchioPyFr1TyHxk8HLjaiNeIk+6KbF9ZSXgp50=;
 b=bb/cRR33BcJFbWaZEEmIDZfIdKXQ/urqa3OPSgVOE7njTF94mZhe2a3O2b1KGxobjm/VeF
 pDatUY1Ad1UMZbmqzSauZKmPjMPqNAw4QAua1wSMv4o80N8Cn/SbWgAo2mBsZru0RzrMR8
 3Nzpni5PLVMBgQEV8yT9l7CssoqcSuQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-nVGDisKpOzKYZ_3GwP7MRg-1; Wed, 30 Jul 2025 04:59:51 -0400
X-MC-Unique: nVGDisKpOzKYZ_3GwP7MRg-1
X-Mimecast-MFC-AGG-ID: nVGDisKpOzKYZ_3GwP7MRg_1753865990
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so10610578a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 01:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753865990; x=1754470790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAmyZEchioPyFr1TyHxk8HLjaiNeIk+6KbF9ZSXgp50=;
 b=DLjXkIDR2dkk9O/dVHfwQpD3USXMuZrps195D8f+NHhChelP3468WOFeNbvme1FqF1
 67IIBuKrRuoQINM9oKYOtjpgCJpDx/xixz9Sr54FYm68KYAQ1F3QIgZ4KuIO12KagOrp
 wrtSzEUEu/pPrOG/caGVJ6QxtR2gUgTiAqAKiZPGCWP9SI0yDN1ADot434oGLbEea3FH
 J0TIbhCTP3qCekh4+wj1DG5457pknettFWxQLxwRTp/YWM96oZYMPhO7cjI9N71rf1zA
 Lj20zdaKE49aAiV2c1unYvMzm7CmkG9E8cLWOCggvLBQyKci+5rvq7MMgw2YSANAu7xx
 AtKw==
X-Gm-Message-State: AOJu0YzVHhM1s10O7mSFGkbfV5w4A/NJ+u25DmNPOsHMAs6V5KxsRkf4
 lLCIDbVaPV9zi0K0r80sErK5naBmLCgc0HY8MMzDE2A7ICiuCKLUzwfnPWjzN8A1jumY+Sm9RIg
 P6r+v/xTcVKpcriTs76R+QDxrTcPfY8irqo9/j24RL3H27PaY5fHo9Mnlq+kOc7ir/Cg9rKM1/j
 RYpCcg/8ziEkW5mtaYHr3E3G/7kQdmKoE=
X-Gm-Gg: ASbGnctG84AKDq3mIYmAAVt64j7H6uByiWfHmFOPsmmkT6ifa4Ikn8Mig1uFAh29Dw8
 yDYyj6ubq5T39pYtDMaJUBBmLa5iGJMIjlogS2Bp/lOS6rmvuOJ4F+Vt1U1tksvYKreuguZJpIA
 u2Y8+8jv1Rro77oN9AOOkQ
X-Received: by 2002:a17:90a:c107:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-31f5dfad9f1mr3854777a91.27.1753865990331; 
 Wed, 30 Jul 2025 01:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkoQ1s84dUm9fAmbteP37+wM7TzkxO+BwC2/U6bCFzTw3ODxQu4wJGSAzY/PjrbqspT4x4rBxnz3JTLyQ+V7A=
X-Received: by 2002:a17:90a:c107:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-31f5dfad9f1mr3854740a91.27.1753865989845; Wed, 30 Jul 2025
 01:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <CAJaqyWd7z-5cHojosMA5mrPQiD8Lz76zF=pmUrQ0cuuXvuSLzg@mail.gmail.com>
 <9f6be5cb-60b8-4c13-a80f-800f409033f0@oracle.com>
In-Reply-To: <9f6be5cb-60b8-4c13-a80f-800f409033f0@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 30 Jul 2025 10:59:12 +0200
X-Gm-Features: Ac12FXx1ld8Hu1F5v7fo07MfDtJzsBk3Hy4_XYE1gVQP5tA2Tbe3nrL3ZPVQb58
Message-ID: <CAJaqyWfqc=DhCRcHrK-XtT4NvJQ+jm5s5XRDN-qT-TopSkDZaw@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Mon, Jul 28, 2025 at 6:24=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 7/28/25 11:30 AM, Eugenio Perez Martin wrote:
> > On Tue, Jul 22, 2025 at 2:41=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Iterative live migration for virtio-net sends an initial
> >> VMStateDescription while the source is still active. Because data
> >> continues to flow for virtio-net, the guest's avail index continues to
> >> increment after last_avail_idx had already been sent. This causes the
> >> destination to often see something like this from virtio_error():
> >>
> >> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delt=
a 0xfff4
> >>
> >> This patch suppresses this consistency check if we're loading the
> >> initial VMStateDescriptions via iterative migration and unsuppresses
> >> it for the stop-and-copy phase when the final VMStateDescriptions
> >> (carrying the correct indices) are loaded.
> >>
> >> A temporary VirtIODevMigration migration data structure is introduced =
here to
> >> represent the iterative migration process for a VirtIODevice. For now =
it
> >> just holds a flag to indicate whether or not the initial
> >> VMStateDescription was sent during the iterative live migration proces=
s.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/net/virtio-net.c        | 13 +++++++++++++
> >>   hw/virtio/virtio.c         | 32 ++++++++++++++++++++++++--------
> >>   include/hw/virtio/virtio.h |  6 ++++++
> >>   3 files changed, 43 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 86a6fe5b91..b7ac5e8278 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3843,12 +3843,19 @@ static void virtio_net_save_cleanup(void *opaq=
ue)
> >>
> >>   static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **=
errp)
> >>   {
> >> +    VirtIONet *n =3D opaque;
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> +    vdev->migration =3D g_new0(VirtIODevMigration, 1);
> >> +    vdev->migration->iterative_vmstate_loaded =3D false;
> >> +
> >>       return 0;
> >>   }
> >>
> >>   static int virtio_net_load_state(QEMUFile *f, void *opaque, int vers=
ion_id)
> >>   {
> >>       VirtIONet *n =3D opaque;
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> +    VirtIODevMigration *mig =3D vdev->migration;
> >>       uint64_t flag;
> >>
> >>       flag =3D qemu_get_be64(f);
> >> @@ -3861,6 +3868,7 @@ static int virtio_net_load_state(QEMUFile *f, vo=
id *opaque, int version_id)
> >>           case VNET_MIG_F_INIT_STATE:
> >>           {
> >>               vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET=
_VM_VERSION);
> >> +            mig->iterative_vmstate_loaded =3D true;
> >
> > This code will need to change if we send the status iteratively more
> > than once. For example, if the guest changes the mac address, the
> > number of vqs, etc.
> >
>
> Hopefully we can reach a solution where we'd only need to call the full
> vmstate_load_state(f, &vmstate_virtio_net, ...) for a virtio-net device
> once and then handle any changes afterwards individually.
>
> Perhaps, maybe for simplicity, we could just send the
> sub-states/subsections (instead of the whole state again) iteratively if
> there were any changes in the fields that those sub-states/subsections
> govern.
>
> Definitely something I'll keep in mind as this series develops.
>
> > In my opinion, we should set a flag named "in_iterative_migration" (or
> > equivalent) in virtio_net_load_setup and clear it in
> > virtio_net_load_cleanup. That's enough to tell in virtio_load if we
> > should perform actions like checking for inconsistent indices.
> >
>
> I did actually try something like this but I realized that the
> .load_cleanup and .save_cleanup hooks actually fire at the very end of
> live migration (e.g. during the stop-and-copy phase). I thought they
> fired at the end of the iterative portion of live migration, but this
> didn't appear to be the case.
>

Ok that makes a lot of sense. What about .switchover_start ? We need
the switchover capability though, not sure if it is a good idea to
mandate it as a requirement. So yes, maybe this patch is the most
reliable way to do so.


> >>               break;
> >>           }
> >>           default:
> >> @@ -3875,6 +3883,11 @@ static int virtio_net_load_state(QEMUFile *f, v=
oid *opaque, int version_id)
> >>
> >>   static int virtio_net_load_cleanup(void *opaque)
> >>   {
> >> +    VirtIONet *n =3D opaque;
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> +    g_free(vdev->migration);
> >> +    vdev->migration =3D NULL;
> >> +
> >>       return 0;
> >>   }
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 5534251e01..68957ee7d1 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -3222,6 +3222,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int=
 version_id)
> >>       int32_t config_len;
> >>       uint32_t num;
> >>       uint32_t features;
> >> +    bool inconsistent_indices;
> >>       BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> >>       VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> >>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >> @@ -3365,6 +3366,16 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, in=
t version_id)
> >>           if (vdev->vq[i].vring.desc) {
> >>               uint16_t nheads;
> >>
> >> +           /*
> >> +            * Ring indices will be inconsistent during iterative migr=
ation. The actual
> >> +            * indices will be sent later during the stop-and-copy pha=
se.
> >> +            */
> >> +            if (vdev->migration) {
> >> +                inconsistent_indices =3D !vdev->migration->iterative_=
vmstate_loaded;
> >> +            } else {
> >> +                inconsistent_indices =3D false;
> >> +            }
> >
> > Nit, "inconsistent_indices =3D vdev->migration &&
> > !vdev->migration->iterative_vmstate_loaded" ? I'm happy with the
> > current "if else" too, but I think the one line is clearer. Your call
> > :).
> >
>
> Ah, nice catch! I like the one-liner more :) Will change this for next
> series.
>
> >> +
> >>               /*
> >>                * VIRTIO-1 devices migrate desc, used, and avail ring a=
ddresses so
> >>                * only the region cache needs to be set up.  Legacy dev=
ices need
> >> @@ -3384,14 +3395,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
> >>                   continue;
> >>               }
> >>
> >> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].la=
st_avail_idx;
> >> -            /* Check it isn't doing strange things with descriptor nu=
mbers. */
> >> -            if (nheads > vdev->vq[i].vring.num) {
> >> -                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x =
"
> >> -                             "inconsistent with Host index 0x%x: delt=
a 0x%x",
> >> -                             i, vdev->vq[i].vring.num,
> >> -                             vring_avail_idx(&vdev->vq[i]),
> >> -                             vdev->vq[i].last_avail_idx, nheads);
> >> +            if (!inconsistent_indices) {
> >> +                nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i=
].last_avail_idx;
> >> +                /* Check it isn't doing strange things with descripto=
r numbers. */
> >> +                if (nheads > vdev->vq[i].vring.num) {
> >> +                    virtio_error(vdev, "VQ %d size 0x%x Guest index 0=
x%x "
> >> +                                 "inconsistent with Host index 0x%x: =
delta 0x%x",
> >> +                                 i, vdev->vq[i].vring.num,
> >> +                                 vring_avail_idx(&vdev->vq[i]),
> >> +                                 vdev->vq[i].last_avail_idx, nheads);
> >> +                    inconsistent_indices =3D true;
> >> +                }
> >> +            }
> >> +            if (inconsistent_indices) {
> >>                   vdev->vq[i].used_idx =3D 0;
> >>                   vdev->vq[i].shadow_avail_idx =3D 0;
> >>                   vdev->vq[i].inuse =3D 0;
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index 214d4a77e9..06b6e6ba65 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -98,6 +98,11 @@ enum virtio_device_endian {
> >>       VIRTIO_DEVICE_ENDIAN_BIG,
> >>   };
> >>
> >> +/* VirtIODevice iterative live migration data structure */
> >> +typedef struct VirtIODevMigration {
> >> +    bool iterative_vmstate_loaded;
> >> +} VirtIODevMigration;
> >> +
> >>   /**
> >>    * struct VirtIODevice - common VirtIO structure
> >>    * @name: name of the device
> >> @@ -151,6 +156,7 @@ struct VirtIODevice
> >>       bool disable_legacy_check;
> >>       bool vhost_started;
> >>       VMChangeStateEntry *vmstate;
> >> +    VirtIODevMigration *migration;
> >>       char *bus_name;
> >>       uint8_t device_endian;
> >>       /**
> >> --
> >> 2.47.1
> >>
> >
>


