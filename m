Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3462BCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vIB-0004nW-Pr; Wed, 15 Oct 2025 02:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8vI9-0004nD-JL
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8vHy-000655-ED
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760510818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clhmdyUEM72Thz5KnSxMSenxjtn7tn28EC2MxUdd2C0=;
 b=My+xYi4YeirU7p3cjFh3561RyYpRS6dB3njh3aQBfil9qbg0t4HS+CL6F+rf3IaIUdb3Wu
 jvkROyrZCyMPgYBa5hO6pb2SVCsJZCipMNDPzA75STfG6HvZGri+lmTo4Yp9Of9Zh26M69
 oO3tWXaOJJ3NMbWAFBtrGjSmBFKcEE8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-DwOPwcQtPGGfTAie5Jsh8A-1; Wed, 15 Oct 2025 02:46:56 -0400
X-MC-Unique: DwOPwcQtPGGfTAie5Jsh8A-1
X-Mimecast-MFC-AGG-ID: DwOPwcQtPGGfTAie5Jsh8A_1760510816
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-272b7bdf41fso124041185ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 23:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760510816; x=1761115616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clhmdyUEM72Thz5KnSxMSenxjtn7tn28EC2MxUdd2C0=;
 b=E4qxbyYxxJWTD9989hd/v6NURi0ObBvAqd7R8ED4XrlmtVxHm2l0ofHDsdH8PyqHQo
 bvBg91PLZSAMpRPgrC6IDysguHVUg8Wu3lNMLRL/lcHoy5sLd/alwuEJEm50f4rfCs6F
 lY3pX9cWGF8vfTgx9ekV3HA2m/4Lbr8D+J2lKtfp5CRyYUrvrWIrFCCura71UTOHA6ht
 DDl9FknHlEc6sCBE8SZu+jncH6EOz91ti5CdrQ+Gyvp1ZUNTAbYkrKBDK5spJz+yTJp0
 ABgGRY7ujv0wjqCZHlKWlQ7DRX2xwKZaeV0j5HmOgU3N2V3zjaFFF6Wga+7DZMAo3jZc
 ojLg==
X-Gm-Message-State: AOJu0YzzlOsFIxP9z0sv8/2zeoXelDZ5dx2OtHYfLlpYZAfGgORT0MRK
 RTOGltKi6eInlT46znDXMLtKCS5paWn1hU2f5pqXOGEzZnrsBRSHnykwXjS8WSTr/6DL+FtHL3+
 wrN2m2aqVKn7+J9ie+yqo3Nnyc1EnRi3Vh7CZoj1igLzFn6yUl2P0BLO6dTLX0fjRCsYEReziHv
 erl/Xmj/4OGnEXlSNkbSCnXEIPINfgfF4=
X-Gm-Gg: ASbGncslRUHZl3Pl4P2jJ1JIPTx2yJmNhjBX0O6WY1+kkDkbVuMMbS16hrXmokLakPv
 UTW0IwR0Y4gJRDOTWpU6ZclEmwrnUfa8Fo22Itx5PCw4thG+kgnDMhvJgp5tWyNS841KTfbovNH
 v+Dcn5wWhXZE37TTDhgNNAETEjdThoO8FREKKPeVPALxyvA/utJnQ=
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id
 d9443c01a7336-290272b54b6mr335159265ad.29.1760510815750; 
 Tue, 14 Oct 2025 23:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGssf6ze34S2+Lzj4l2TXgZIXsPP9Z15X1YGVTnVEf3iwdQABnjaqvG7cU6H8tjrz+cde6s7PwUza+AuK3/kMA=
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id
 d9443c01a7336-290272b54b6mr335159055ad.29.1760510815336; Tue, 14 Oct 2025
 23:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-8-aesteve@redhat.com>
 <20250929190031.GG81824@fedora>
 <CADSE00KBfyW=bTaNjvr8xgTevzndsk=Rps6gvfE8yH4sYqHqgA@mail.gmail.com>
 <20251014151802.GA11115@fedora>
In-Reply-To: <20251014151802.GA11115@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 15 Oct 2025 08:46:43 +0200
X-Gm-Features: AS18NWDbH4TeNunNkzph1vt099xEHns-M_3ulYvsg4HNXhb-Ng9TkeSo6Vz3XoM
Message-ID: <CADSE00K2-czoi=7K1Npagfc_PgZBXpf-tRoWU15ykg3n7SQY=Q@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] vhost-user-device: Add shared memory BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, 
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com, 
 david@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 5:18=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Oct 13, 2025 at 05:37:52PM +0200, Albert Esteve wrote:
> > On Mon, Sep 29, 2025 at 9:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 01:54:20PM +0200, Albert Esteve wrote:
> > > > Add shared memory BAR support to vhost-user-device-pci
> > > > to enable direct file mapping for VIRTIO Shared
> > > > Memory Regions.
> > > >
> > > > The implementation creates a consolidated shared
> > > > memory BAR that contains all VIRTIO Shared
> > > > Memory Regions as subregions. Each region is
> > > > configured with its proper shmid, size, and
> > > > offset within the BAR. The number and size of
> > > > regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> > > > message sent by vhost-user-base during realization
> > > > after virtio_init().
> > > >
> > > > Specifiically, it uses BAR 3 to avoid conflicts, as
> > > > it is currently unused.
> > > >
> > > > The shared memory BAR is only created when the
> > > > backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> > > > has configured shared memory regions. This maintains
> > > > backward compatibility with backends that do not
> > > > support shared memory functionality.
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++=
++--
> > > >  hw/virtio/vhost-user-device-pci.c | 34 ++++++++++++++++++++--
> > > >  2 files changed, 76 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-bas=
e.c
> > > > index ff67a020b4..82f49500e4 100644
> > > > --- a/hw/virtio/vhost-user-base.c
> > > > +++ b/hw/virtio/vhost-user-base.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include "hw/virtio/virtio-bus.h"
> > > >  #include "hw/virtio/vhost-user-base.h"
> > > >  #include "qemu/error-report.h"
> > > > +#include "migration/blocker.h"
> > > >
> > > >  static void vub_start(VirtIODevice *vdev)
> > > >  {
> > > > @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev=
, Error **errp)
> > > >  {
> > > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > > > -    int ret;
> > > > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > > > +    g_autofree char *name =3D NULL;
> > > > +    int i, ret, nregions, regions_processed =3D 0;
> > > >
> > > >      if (!vub->chardev.chr) {
> > > >          error_setg(errp, "vhost-user-base: missing chardev");
> > > > @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev=
, Error **errp)
> > > >
> > > >      /* Allocate queues */
> > > >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > > > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > > > +    for (i =3D 0; i < vub->num_vqs; i++) {
> > > >          g_ptr_array_add(vub->vqs,
> > > >                          virtio_add_queue(vdev, vub->vq_size,
> > > >                                           vub_handle_output));
> > > > @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *d=
ev, Error **errp)
> > > >                           VHOST_BACKEND_TYPE_USER, 0, errp);
> > > >
> > > >      if (ret < 0) {
> > > > -        do_vhost_user_cleanup(vdev, vub);
> > > > +        goto err;
> > > > +    }
> > > > +
> > > > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub-=
>vhost_dev,
> > > > +                                                           &nregio=
ns,
> > > > +                                                           memory_=
sizes,
> > > > +                                                           errp);
> > > > +
> > > > +    if (ret < 0) {
> > > > +        goto err;
> > > > +    }
> > > > +
> > > > +    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processe=
d < nregions; i++) {
> > > > +        if (memory_sizes[i]) {
> > > > +            regions_processed++;
> > > > +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> > > > +                error_setg(&vub->vhost_dev.migration_blocker,
> > > > +                       "Migration disabled: devices with VIRTIO Sh=
ared Memory "
> > > > +                       "Regions do not support migration yet.");
> > > > +                ret =3D migrate_add_blocker_normal(
> > > > +                    &vub->vhost_dev.migration_blocker,
> > > > +                    errp);
> > > > +
> > > > +                if (ret < 0) {
> > > > +                    goto err;
> > > > +                }
> > > > +            }
> > > > +
> > > > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D =
0) {
> > > > +                error_setg(errp, "Shared memory %d size must be a =
power of 2 "
> > > > +                                 "no smaller than the page size", =
i);
> > > > +                goto err;
> > > > +            }
> > > > +
> > > > +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
> > > > +        }
> > > >      }
> > > >
> > > >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event,=
 NULL,
> > > >                               dev, NULL, true);
> > > > +    return;
> > > > +err:
> > > > +    do_vhost_user_cleanup(vdev, vub);
> > > >  }
> > > >
> > > >  static void vub_device_unrealize(DeviceState *dev)
> > > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-us=
er-device-pci.c
> > > > index f10bac874e..bac99e7c60 100644
> > > > --- a/hw/virtio/vhost-user-device-pci.c
> > > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > > @@ -8,14 +8,18 @@
> > > >   */
> > > >
> > > >  #include "qemu/osdep.h"
> > > > +#include "qapi/error.h"
> > > >  #include "hw/qdev-properties.h"
> > > >  #include "hw/virtio/vhost-user-base.h"
> > > >  #include "hw/virtio/virtio-pci.h"
> > > >
> > > > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 3
> > >
> > > 64-bit PCI memory BARs require two contiguous 32-bit BARs. Choosing B=
AR
> > > 3 won't work because modern_mem_bar_idx =3D 4 (and 5) and there is a
> > > collision.
> > >
> > > virtio-gpu-hostmem uses BAR 2 and 3 for VIRTIO Shared Memory Regions.=
 In
> > > order to do this, it rearranges the other VIRTIO PCI BARs in
> > > virtio_vga_base_realize(). Following that approach should be safe.
> >
> > I see. But doing the same strategy would collide with
> > virtio-gpu-hostmem if both devices are used simultaneously? Would that
> > be ok?
>
> virtio-gpu-* and vhost-user-device-pci are separate PCI devices with
> their own BARs, how would they conflict?

Ah! I see. I thought different devices registering the same IDs would
conflict. But you're right, it doesn't make sense. Understood. Then
I'll follow your initial suggestion.


