Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A820AC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVU5r-0005qO-5b; Thu, 01 Feb 2024 05:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVU5m-0005oA-Rw
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVU5k-0000oh-H3
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706782483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3b8Uy72YDNT3+4muhxL6cH+j/c296lQm9jjUO9tf4g=;
 b=F9RVXxzkuOyX11DPEWj6d3vzXeA4RQ01xvWJrVPzEOTcavNV1UGq4GESpNhM70qezDYUg1
 Nu4IaOGdX+BTxNWytf8A7HaPL2A7kKQVQ0my5aIIKlCNG5Frb/x9WFYUPPp33Y6SgcCAp3
 ZrpBokDo1VWolfdTOYT0QEh4JNKl+4E=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284--1qcFEKRP0iBE1gJ1_PtXw-1; Thu, 01 Feb 2024 05:14:39 -0500
X-MC-Unique: -1qcFEKRP0iBE1gJ1_PtXw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc6b5d1899eso2465681276.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706782478; x=1707387278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3b8Uy72YDNT3+4muhxL6cH+j/c296lQm9jjUO9tf4g=;
 b=kOaB4SXAzOHfedrJEgO+hYzZy6UhPZ9Ax94Nk+4TI+w1XQYhwTcr8ZYBEfdpBcJyWA
 rHl0Yyon3tnWUEgyz1yurv5X7ySVgHdN0OSu8Dg0VFu0/3KY5/CMb3sZ036uP9jgFZjY
 kUVFBFkmnaWC1Zkchdw9ZPiis+dLhzsDn4HSiOTVRrV5RcmAqi5p65EusuntViCaV5ja
 +y1Z510a706k7A6icAFTX2LD1bHgt+FXwdXef60d6RLziqD2djjj3BKpPfVvFMiS9IRt
 jnhDlxbYM21aUq5LvukEqnNSNdBj5zxAC2aV8JV472KN7qb3fPSBrUEHF05GD/f7pQNy
 Bx0A==
X-Gm-Message-State: AOJu0YzAL76PAJxlw2qqfVU+UehBy+OYegJOLJ2l1pNil2jEWQ6g8Gfg
 o0kBAI/m2SewP6qg3iucVynRAgQmGSfYpf58Vsfuc3rhD0y9gGi7cz6/9TydE8g+qKzBaQHH5R+
 5kWUpiztEuhlrgEglgWgf2T8o0TPxy4DW3PsYs1WjZ0HNHloaqGiB+Nojw7qvH/lJlXd2ZSf/MZ
 wVqNakDroSs8I7xwyC1VSpHXSTwCY=
X-Received: by 2002:a25:6402:0:b0:dc2:58af:2af7 with SMTP id
 y2-20020a256402000000b00dc258af2af7mr4386095ybb.22.1706782478514; 
 Thu, 01 Feb 2024 02:14:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgr9C8eCKZCVRHxv5KfnaoRPhu/9aJ45oUWUymR2q/EJVgzme1CZ+1RNVKWThoJF3MWHAfkLlwPKAvtCYwOtg=
X-Received: by 2002:a25:6402:0:b0:dc2:58af:2af7 with SMTP id
 y2-20020a256402000000b00dc258af2af7mr4386083ybb.22.1706782478216; Thu, 01 Feb
 2024 02:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20240111190222.496695-1-eperezma@redhat.com>
 <20240111190222.496695-2-eperezma@redhat.com>
 <92ecfd90-8d06-4669-b260-a7a3b106277e@oracle.com>
In-Reply-To: <92ecfd90-8d06-4669-b260-a7a3b106277e@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Feb 2024 11:14:02 +0100
Message-ID: <CAJaqyWf4ADFiF2V=yOJUviLUAN00-5vfbrxW_uAMeEjC91MEXA@mail.gmail.com>
Subject: Re: [PATCH 1/6] vdpa: check for iova tree initialized at
 net_client_start
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Parav Pandit <parav@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 31, 2024 at 11:07=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
> Hi Eugenio,
>
> Maybe there's some patch missing, but I saw this core dump when x-svq=3Do=
n
> is specified while waiting for the incoming migration on destination host=
:
>
> (gdb) bt
> #0  0x00005643b24cc13c in vhost_iova_tree_map_alloc (tree=3D0x0,
> map=3Dmap@entry=3D0x7ffd58c54830) at ../hw/virtio/vhost-iova-tree.c:89
> #1  0x00005643b234f193 in vhost_vdpa_listener_region_add
> (listener=3D0x5643b4403fd8, section=3D0x7ffd58c548d0) at
> /home/opc/qemu-upstream/include/qemu/int128.h:34
> #2  0x00005643b24e6a61 in address_space_update_topology_pass
> (as=3Das@entry=3D0x5643b35a3840 <address_space_memory>,
> old_view=3Dold_view@entry=3D0x5643b442b5f0,
> new_view=3Dnew_view@entry=3D0x5643b44a2130, adding=3Dadding@entry=3Dtrue)=
 at
> ../system/memory.c:1004
> #3  0x00005643b24e6e60 in address_space_set_flatview (as=3D0x5643b35a3840
> <address_space_memory>) at ../system/memory.c:1080
> #4  0x00005643b24ea750 in memory_region_transaction_commit () at
> ../system/memory.c:1132
> #5  0x00005643b24ea750 in memory_region_transaction_commit () at
> ../system/memory.c:1117
> #6  0x00005643b241f4c1 in pc_memory_init
> (pcms=3Dpcms@entry=3D0x5643b43c8400,
> system_memory=3Dsystem_memory@entry=3D0x5643b43d18b0,
> rom_memory=3Drom_memory@entry=3D0x5643b449a960, pci_hole64_size=3D<optimi=
zed
> out>) at ../hw/i386/pc.c:954
> #7  0x00005643b240d088 in pc_q35_init (machine=3D0x5643b43c8400) at
> ../hw/i386/pc_q35.c:222
> #8  0x00005643b21e1da8 in machine_run_board_init (machine=3D<optimized
> out>, mem_path=3D<optimized out>, errp=3D<optimized out>,
> errp@entry=3D0x5643b35b7958 <error_fatal>)
>      at ../hw/core/machine.c:1509
> #9  0x00005643b237c0f6 in qmp_x_exit_preconfig () at ../system/vl.c:2613
> #10 0x00005643b237c0f6 in qmp_x_exit_preconfig (errp=3D<optimized out>) a=
t
> ../system/vl.c:2704
> #11 0x00005643b237fcdd in qemu_init (errp=3D<optimized out>) at
> ../system/vl.c:3753
> #12 0x00005643b237fcdd in qemu_init (argc=3D<optimized out>,
> argv=3D<optimized out>) at ../system/vl.c:3753
> #13 0x00005643b2158249 in main (argc=3D<optimized out>, argv=3D<optimized
> out>) at ../system/main.c:47
>
> Shall we create the iova tree early during vdpa dev int for the x-svq=3Do=
n
> case?
>
> +    if (s->always_svq) {
> +        /* iova tree is needed because of SVQ */
> +        shared->iova_tree =3D vhost_iova_tree_new(shared->iova_range.fir=
st,
> + shared->iova_range.last);
> +    }
> +
>

Right.

As your series will make the maps permanent in the best case, I think
it is wise to follow the same path as with the memory listener and
create always, not conditionally.

I'll send a new series by today with this fix and the other one that
Lei detected.

Thanks!

> Regards,
> -Siwei
>
> On 1/11/2024 11:02 AM, Eugenio P=C3=A9rez wrote:
> > To map the guest memory while it is migrating we need to create the
> > iova_tree, as long as the destination uses x-svq=3Don. Checking to not
> > override it.
> >
> > The function vhost_vdpa_net_client_stop clear it if the device is
> > stopped. If the guest starts the device again, the iova tree is
> > recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_star=
t
> > if needed, so old behavior is kept.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   net/vhost-vdpa.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 3726ee5d67..e11b390466 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -341,7 +341,9 @@ static void vhost_vdpa_net_data_start_first(VhostVD=
PAState *s)
> >
> >       migration_add_notifier(&s->migration_state,
> >                              vdpa_net_migration_state_notifier);
> > -    if (v->shadow_vqs_enabled) {
> > +
> > +    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
> > +    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
> >           v->shared->iova_tree =3D vhost_iova_tree_new(v->shared->iova_=
range.first,
> >                                                      v->shared->iova_ra=
nge.last);
> >       }
>


