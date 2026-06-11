Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35A4CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgGq-0001tw-MS; Thu, 11 Jun 2026 10:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXgGo-0001ta-W3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXgGl-0001QD-6r
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781187629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQHo+rT01YfKXX4j65wrxdRY6HLK5teuJ5PHFmWxRcI=;
 b=TYYdzE2XCOow6Tfy/DV8vQFRM9zXAo4hSt8Rn9c3Uh4Cxg/y2bKsOxmiVfxo/2rXCjB75+
 oHWVSarskb/jePZrOvXfswdujtGpcX2ocdJxfYs/04bl/CLDDn737er5eA37hberfbObsW
 A7QDqwKK/TeTn5LG9EDU9jsmzrPXLlM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-hNMQPZ21PJa-f56v1QOy2A-1; Thu,
 11 Jun 2026 10:20:27 -0400
X-MC-Unique: hNMQPZ21PJa-f56v1QOy2A-1
X-Mimecast-MFC-AGG-ID: hNMQPZ21PJa-f56v1QOy2A_1781187625
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B589719774F0; Thu, 11 Jun 2026 14:20:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D416519540C5; Thu, 11 Jun 2026 14:20:23 +0000 (UTC)
Date: Thu, 11 Jun 2026 10:20:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611142022.GA202155@fedora>
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bYfBcHUMCTLwmhob"
Content-Disposition: inline
In-Reply-To: <20260610165710-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--bYfBcHUMCTLwmhob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 05:00:51PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 02:30:46PM -0400, Stefan Hajnoczi wrote:
> > On Wed, Jun 10, 2026 at 05:49:21AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > > On the guest where a NVidia's GH100 card is passed from the host, t=
he
> > > > guest system hang can be observed on attempt to compile 'cuda-sampl=
es',
> > > > as reported by Julia.
> > > >=20
> > > >    host$ lspci | grep GH100
> > > >    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120G=
B / 480GB] (rev a1)
> > > >    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -a=
ccel kvm \
> > > >          -machine virt,gic-version=3Dhost,ras=3Don,highmem-mmio-siz=
e=3D4T         \
> > > >          -cpu host -smp cpus=3D32 -m size=3D8G                     =
             \
> > > >          -drive file=3D/home/gavin/sandbox/images/disk.qcow2,if=3Dn=
one,id=3Dd0    \
> > > >          -device virtio-blk-pci,id=3Dvb0,bus=3Dpcie.0,drive=3Dd0,nu=
m-queues=3D4     \
> > > >          -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.=
1.0
> > > >=20
> > > >    guest$ cd cuda-samples/build
> > > >    guest$ make -j 20 clean
> > > >    guest$ make -j 20
> > > >                :
> > > >    [ 54%] Linking CUDA executable graphMemoryNodes
> > > >    [ 54%] Built target graphMemoryNodes
> > > >    <no more output afterwards, guest becomes frozen here>
> > > >=20
> > > >    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of r=
esources
> > > >    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512=
-byte logical blocks (137 GB/128 GiB)
> > > >=20
> > > > When the GPU's driver (NVidia open driver) is loaded on guest bootu=
p,
> > > > the memory blocks residing in the PCI BAR can be presented to the g=
uest
> > > > through memory hot-add. The page cache can be allocated from the ho=
t added
> > > > memory blocks when cuda-samples is being built. Afterwards, he page=
 cache
> > > > is sent to QEMU's virtio-blk device as part of the DMA request, the=
 bounce
> > > > buffer is used to accomodate the request as the corresponding memory
> > > > region (MemoryRegion) is a RAM DEVICE region in qemu. For this spec=
ific
> > > > case, false is returned from memory_access_is_direct() in the path =
where
> > > > the DMA request is handled.
> > > >=20
> > > >   QEMU
> > > >   =3D=3D=3D=3D
> > > >   virtio_blk_handle_output
> > > >     virtio_blk_handle_vq
> > > >       virtio_blk_get_request
> > > >         virtqueue_pop
> > > >           virtqueue_split_pop
> > > >             virtqueue_map_desc
> > > >               address_space_map
> > > >                 memory_access_is_direct         # Return false
> > > >                   memory_region_supports_direct_access
> > > >=20
> > > >   (qemu) info mtree
> > > >           :
> > > >   memory-region: pci_bridge_pci
> > > >     0000000000000000-ffffffffffffffff (prio 0, container): pci_brid=
ge_pci
> > > >       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0=
 base BAR 4
> > > >         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00=
=2E0 BAR 4
> > > >           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01=
:00.0 BAR 4 mmaps[0]
> > > >=20
> > > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > > than one page when the guest page is 64KB. This tries to fix the is=
sue
> > > > by inheriting the customized max bounce buffer size of the virtio b=
us's
> > > > parent through property 'x-max-bounce-buffer-size' when the customi=
zed
> > > > size is a larger one. With this applied, no guest system hang is se=
en
> > > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=3D2684354=
56'.
> > > >=20
> > > > Reported-by: Julia Graham <jugraham@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > ---
> > > >  hw/virtio/virtio-bus.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >=20
> > > > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > > > index cef944e015..e0933823f3 100644
> > > > --- a/hw/virtio/virtio-bus.c
> > > > +++ b/hw/virtio/virtio-bus.c
> > > > @@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__);=
 } while (0)
> > > >  /* A VirtIODevice is being plugged */
> > > >  void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> > > >  {
> > > > +    AddressSpace *as;
> > > >      DeviceState *qdev =3D DEVICE(vdev);
> > > >      BusState *qbus =3D BUS(qdev_get_parent_bus(qdev));
> > > >      VirtioBusState *bus =3D VIRTIO_BUS(qbus);
> > > > @@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *v=
dev, Error **errp)
> > > >                  return;
> > > >              }
> > > >          }
> > > > +    } else {
> > > > +        /*
> > > > +         * The maximal bounce buffer size of the virtio bus's pare=
nt may
> > > > +         * have been customized by property 'x-max-bounce-buffer-s=
ize'.
> > > > +         * Lets inherit the customized size if it's larger than the
> > > > +         * current one.
> > > > +         */
> > > > +        as =3D klass->get_dma_as ? klass->get_dma_as(qbus->parent)=
 : NULL;
> > > > +        if (as) {
> > > > +            vdev->dma_as->max_bounce_buffer_size =3D MAX(
> > > > +                    vdev->dma_as->max_bounce_buffer_size,
> > > > +                    as->max_bounce_buffer_size);
> > > > +        }
> > > >      }
> > > >  }
> > > > =20
> > > > --=20
> > > > 2.54.0
> > >=20
> > >=20
> > > Problem with all this is, users would not know how to size this.
> > >=20
> > > So fundamentally, is not the issue that virtio blk (and scsi!) maps
> > > all of the buffer all the time?
> > >
> > > It's not hard to add something like virtio_pop_unmapped that would no=
t map,
> > > then build QEMUSGLists out of addr/len pairs and submit these.
> > >=20
> > > Stefan, do you think doing it like this would be bad for perf? Good f=
or
> > > perf?
> >=20
> > I'd like to first make sure that the BAR really cannot be mmapped.
>=20
> The issue is that qemu has no way to know, up front.

Gavin posted the lspci output:

  Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=3D16M]
  Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=3D128G]
  Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=3D32M]

These are prefetchable memory BARs, so I would expect them to be
mmappable. Why does QEMU have no way of knowing upfront whether they can
be mmapped?

> What we could thinkably do, is map it and do the
> accesses from QEMU through the bounce buffer, while
> DMA through mmap.
>=20
>=20
> > A bounce buffer is necessary when QEMU has no way of mmapping the memory
> > (e.g. it needs to invoke a device model's callback to read/write the
> > MemoryRegion).
> >=20
> > The reason why the bounce buffer size is low is because it's normally
> > only used on emulated machines where MMIO registers or similar small
> > MemoryRegions are accessed by DMA. If we ran into this on modern
> > machines there would also be other consequences like vhost devices would
> > be unable to access that memory since it cannot be shared/mmapped.
> >=20
> > This is why I think we need to understand why this BAR is a RAM DEVICE.
>=20
>=20
> VFIO maps all memory BARS like this.
>=20
> > If it can support mmap then this issue, plus anything else like vhost,
> > would work.
> >=20
> > Gavin, can you share the output of `lspci -vv -s 0009:01:00.0`?
> >=20
> > Thanks,
> > Stefan
>=20
>=20

--bYfBcHUMCTLwmhob
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoqxCYACgkQnKSrs4Gr
c8h11wf/cHM0MtWQ6O1y2Z7uDdZLapdLeFEZkB0kwCZDxvyk9ki4E8j0AEF9h8z8
AztfqEZzB5qYr/tBMtFps3bjTo930E7PYVMjEVELIIDlOO7zukFuffkMTz9/H9C+
X6NgRVs29dgxolMkx/7z1P7xHYRqZeYqWzsXf1etKW/HWZzlE5NhE2Sf59Uaf6LS
C5TfkgrDXS2Cwt0pNoK4tWRzntEla/vRqWtgFt5q1+q81tj6Fy9SEc0k58lQ/GoD
dVJ4/q/12fozK7Ck0O5675x+cuPqTrQeyYT+7xxo7HBugGdHk8ehHsPUDX+0o97g
6rRINiY1OEfE0KCaC/yGF1ZgmjK89A==
=S6E+
-----END PGP SIGNATURE-----

--bYfBcHUMCTLwmhob--


