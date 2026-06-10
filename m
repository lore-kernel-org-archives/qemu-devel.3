Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DC6CD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNhl-00080a-2Z; Wed, 10 Jun 2026 14:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXNhi-0007x0-4V
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXNhd-0000Km-IU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781116257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ym912GRYmlUrMC9Dj5JDRERdtWtj2ybPK4nZd9F/B6M=;
 b=exCy4tTNNGSXN/ga0DM3mXXj8PNzE5LuHKI6hZTbPOzZX8vpOWkMHRbNmiEMxTsPcaFeH3
 WkXpPgvTvXzm1LhD5fngNBCYDxJxHWfBxRjng4JTSHBWC0L7KVz6p3puwEz+0PL4sWNlrz
 T0gOVxyTAt/8BdN4ikKalO+CUokoqIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-1gpW0OMwOjavEgggAfAFzA-1; Wed,
 10 Jun 2026 14:30:52 -0400
X-MC-Unique: 1gpW0OMwOjavEgggAfAFzA-1
X-Mimecast-MFC-AGG-ID: 1gpW0OMwOjavEgggAfAFzA_1781116251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4ECD1955DE3; Wed, 10 Jun 2026 18:30:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 332983008DC3; Wed, 10 Jun 2026 18:30:49 +0000 (UTC)
Date: Wed, 10 Jun 2026 14:30:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610183046.GB121666@fedora>
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="73UmiFWPOv3JseZj"
Content-Disposition: inline
In-Reply-To: <20260610041036-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--73UmiFWPOv3JseZj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 05:49:21AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > On the guest where a NVidia's GH100 card is passed from the host, the
> > guest system hang can be observed on attempt to compile 'cuda-samples',
> > as reported by Julia.
> >=20
> >    host$ lspci | grep GH100
> >    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / =
480GB] (rev a1)
> >    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -accel=
 kvm \
> >          -machine virt,gic-version=3Dhost,ras=3Don,highmem-mmio-size=3D=
4T         \
> >          -cpu host -smp cpus=3D32 -m size=3D8G                         =
         \
> >          -drive file=3D/home/gavin/sandbox/images/disk.qcow2,if=3Dnone,=
id=3Dd0    \
> >          -device virtio-blk-pci,id=3Dvb0,bus=3Dpcie.0,drive=3Dd0,num-qu=
eues=3D4     \
> >          -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.1.0
> >=20
> >    guest$ cd cuda-samples/build
> >    guest$ make -j 20 clean
> >    guest$ make -j 20
> >                :
> >    [ 54%] Linking CUDA executable graphMemoryNodes
> >    [ 54%] Built target graphMemoryNodes
> >    <no more output afterwards, guest becomes frozen here>
> >=20
> >    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resou=
rces
> >    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byt=
e logical blocks (137 GB/128 GiB)
> >=20
> > When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> > the memory blocks residing in the PCI BAR can be presented to the guest
> > through memory hot-add. The page cache can be allocated from the hot ad=
ded
> > memory blocks when cuda-samples is being built. Afterwards, he page cac=
he
> > is sent to QEMU's virtio-blk device as part of the DMA request, the bou=
nce
> > buffer is used to accomodate the request as the corresponding memory
> > region (MemoryRegion) is a RAM DEVICE region in qemu. For this specific
> > case, false is returned from memory_access_is_direct() in the path where
> > the DMA request is handled.
> >=20
> >   QEMU
> >   =3D=3D=3D=3D
> >   virtio_blk_handle_output
> >     virtio_blk_handle_vq
> >       virtio_blk_get_request
> >         virtqueue_pop
> >           virtqueue_split_pop
> >             virtqueue_map_desc
> >               address_space_map
> >                 memory_access_is_direct         # Return false
> >                   memory_region_supports_direct_access
> >=20
> >   (qemu) info mtree
> >           :
> >   memory-region: pci_bridge_pci
> >     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_p=
ci
> >       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 bas=
e BAR 4
> >         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 B=
AR 4
> >           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.=
0 BAR 4 mmaps[0]
> >=20
> > By default, the max bounce buffer size is only 4096 bytes, even less
> > than one page when the guest page is 64KB. This tries to fix the issue
> > by inheriting the customized max bounce buffer size of the virtio bus's
> > parent through property 'x-max-bounce-buffer-size' when the customized
> > size is a larger one. With this applied, no guest system hang is seen
> > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=3D268435456'.
> >=20
> > Reported-by: Julia Graham <jugraham@redhat.com>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  hw/virtio/virtio-bus.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > index cef944e015..e0933823f3 100644
> > --- a/hw/virtio/virtio-bus.c
> > +++ b/hw/virtio/virtio-bus.c
> > @@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } w=
hile (0)
> >  /* A VirtIODevice is being plugged */
> >  void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> >  {
> > +    AddressSpace *as;
> >      DeviceState *qdev =3D DEVICE(vdev);
> >      BusState *qbus =3D BUS(qdev_get_parent_bus(qdev));
> >      VirtioBusState *bus =3D VIRTIO_BUS(qbus);
> > @@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
> >                  return;
> >              }
> >          }
> > +    } else {
> > +        /*
> > +         * The maximal bounce buffer size of the virtio bus's parent m=
ay
> > +         * have been customized by property 'x-max-bounce-buffer-size'.
> > +         * Lets inherit the customized size if it's larger than the
> > +         * current one.
> > +         */
> > +        as =3D klass->get_dma_as ? klass->get_dma_as(qbus->parent) : N=
ULL;
> > +        if (as) {
> > +            vdev->dma_as->max_bounce_buffer_size =3D MAX(
> > +                    vdev->dma_as->max_bounce_buffer_size,
> > +                    as->max_bounce_buffer_size);
> > +        }
> >      }
> >  }
> > =20
> > --=20
> > 2.54.0
>=20
>=20
> Problem with all this is, users would not know how to size this.
>=20
> So fundamentally, is not the issue that virtio blk (and scsi!) maps
> all of the buffer all the time?
>
> It's not hard to add something like virtio_pop_unmapped that would not ma=
p,
> then build QEMUSGLists out of addr/len pairs and submit these.
>=20
> Stefan, do you think doing it like this would be bad for perf? Good for
> perf?

I'd like to first make sure that the BAR really cannot be mmapped.

A bounce buffer is necessary when QEMU has no way of mmapping the memory
(e.g. it needs to invoke a device model's callback to read/write the
MemoryRegion).

The reason why the bounce buffer size is low is because it's normally
only used on emulated machines where MMIO registers or similar small
MemoryRegions are accessed by DMA. If we ran into this on modern
machines there would also be other consequences like vhost devices would
be unable to access that memory since it cannot be shared/mmapped.

This is why I think we need to understand why this BAR is a RAM DEVICE.
If it can support mmap then this issue, plus anything else like vhost,
would work.

Gavin, can you share the output of `lspci -vv -s 0009:01:00.0`?

Thanks,
Stefan

--73UmiFWPOv3JseZj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoprVYACgkQnKSrs4Gr
c8h9Pgf+JgAZiN2JJuMNaiZn9+brddtP0M2L4CyPL2DR6rPmjgntSVHS4NKEEpMl
twxQqW7gxjIpQjgRU2i2yfvzlzl07+B7J+tj1D5NOIIX+TroVgOlHmkuDKNjU7MH
4VAfUCRK5Y/UR700seviizeXPWpGuAG0eg16j+PXc0ckvMCkBeCAUVOTX8v6xriu
MwNJZaKg429bCnmg+NcjxQnRWPhdgSB+5mWSXH5d9G2uQqnV6Gdh2FubS65nUJa9
yEhBJhGJphuNLPO4TpJBA03tEKBrIsCVApSx6NrDw9S7ENMw5V1Vpo+Z8b5grOmY
Wwu8Tb3sKqhCThuKdBtRPKxL0qh4VA==
=5rdq
-----END PGP SIGNATURE-----

--73UmiFWPOv3JseZj--


