Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BDFE7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmz2e-0003Bg-2z; Mon, 02 Feb 2026 13:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vmz2W-0003Am-P4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vmz2U-0003MN-H1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770058365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F44idrk/OeVvNUlt4ot6UswsW9BLCaCx7t3MGaw1hFA=;
 b=ZZIWIg/Yq0Vhk6r03nEsgNhWgJkYWNynbWunNcMa9snQJ+JYV43Va/K3GZ+9wh/h+wAICF
 /6TuZlWzfI65Kr74Uatph9oB6kFK3aCS3SHbCa1iu8sk8pom0nnmCu/cZTj55lLC3oPUil
 9yq/QbaLMb/foNuq+tRzw0AWq0Lh76A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Zlpqo8v4PtGfwNq6DAcq5Q-1; Mon,
 02 Feb 2026 13:52:37 -0500
X-MC-Unique: Zlpqo8v4PtGfwNq6DAcq5Q-1
X-Mimecast-MFC-AGG-ID: Zlpqo8v4PtGfwNq6DAcq5Q_1770058356
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5FFD1800357; Mon,  2 Feb 2026 18:52:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 166391956053; Mon,  2 Feb 2026 18:52:34 +0000 (UTC)
Date: Mon, 2 Feb 2026 13:52:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Message-ID: <20260202185233.GC405548@fedora>
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
 <20260202105847-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gb+mduCjLD6PK4dt"
Content-Disposition: inline
In-Reply-To: <20260202105847-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--gb+mduCjLD6PK4dt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 11:04:08AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 02, 2026 at 01:08:25PM +0000, Alex Benn=E9e wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >=20
> > > On Mon, Feb 02, 2026 at 12:29:16AM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > >> Endianness access is constant between device resets.
> > >> Use the field instead of calling the same function.
> > >
> > > yes but the function was inlined and often a NOP. worth mentioning.
> > >
> > >>=20
> > >> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> > >> ---
> > >>  include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
> > >>  hw/virtio/virtio.c                |  4 ++--
> > >>  2 files changed, 14 insertions(+), 14 deletions(-)
> > >>=20
> > >> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/v=
irtio-access.h
> > >> index cd17d0c87eb..f3b4d0075b5 100644
> > >> --- a/include/hw/virtio/virtio-access.h
> > >> +++ b/include/hw/virtio/virtio-access.h
> > >> @@ -42,7 +42,7 @@ static inline bool virtio_access_is_big_endian(Vir=
tIODevice *vdev)
> > >> =20
> > >>  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint=
16_t v)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          stw_be_p(ptr, v);
> > >>      } else {
> > >>          stw_le_p(ptr, v);
> > >
> > >
> > > So this is the main extra cost: on an LE host, we now have this branc=
h on every
> > > access where previously it was all optimized out.
> > >
> > > Is it measureable? It is worth testing.
> >=20
> > I suspect not given this is a well predicted branch on the control
> > plane.
>=20
> Actually you are right. I meant the cached variants below. Not this one.
>=20
>=20
>=20
>=20
>=20
> > But we can certainly try an measure it. Do we have any virtio
> > performance benchmarks?
> >=20
> > We only have a few in meson:
> >=20
> >   ./pyvenv/bin/meson test --benchmark --list
> >   bufferiszero-bench
> >   benchmark-crypto-hash
> >   benchmark-crypto-hmac
> >   benchmark-crypto-cipher
> >   benchmark-crypto-akcipher
>=20
> I usually use fio but whatever blk maintainers use is fine by me.

This command-line lets you benchmark virtio-blk without actual I/O
slowing down the request processing:

  qemu-system-x86_64 \
      -M accel=3Dkvm \
      -cpu host \
      -m 4G \
      --blockdev file,node-name=3Ddrive0,filename=3Dboot.img,cache.direct=
=3Don,aio=3Dnative \
      --blockdev null-co,node-name=3Ddrive1,size=3D$((10 * 1024 * 1024 * 10=
24)) \
      --object iothread,id=3Diothread0 \
      --device virtio-blk-pci,drive=3Ddrive0,iothread=3Diothread0 \
      --device virtio-blk-pci,drive=3Ddrive1,iothread=3Diothread0

Here is a fio command-line for 4 KiB random reads:

  fio \
      --ioengine=3Dlibaio \
      --direct=3D1 \
      --runtime=3D30 \
      --ramp_time=3D10 \
      --rw=3Drandread \
      --bs=3D4k \
      --iodepth=3D128 \
      --filename=3D/dev/vdb \
      --name=3Drandread

This is just a single vCPU, but it should be enough to see if there is
any difference in I/O Operations Per Second (IOPS) or efficiency
(IOPS/CPU utilization).

>=20
>=20
> > >
> > >
> > >
> > >> @@ -51,7 +51,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev=
, void *ptr, uint16_t v)
> > >> =20
> > >>  static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint=
32_t v)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          stl_be_p(ptr, v);
> > >>      } else {
> > >>          stl_le_p(ptr, v);
> > >> @@ -60,7 +60,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev=
, void *ptr, uint32_t v)
> > >> =20
> > >>  static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint=
64_t v)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          stq_be_p(ptr, v);
> > >>      } else {
> > >>          stq_le_p(ptr, v);
> > >> @@ -69,7 +69,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev=
, void *ptr, uint64_t v)
> > >> =20
> > >>  static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          return lduw_be_p(ptr);
> > >>      } else {
> > >>          return lduw_le_p(ptr);
> > >
> > > and this one.
> > >
> > >
> > >> @@ -78,7 +78,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev=
, const void *ptr)
> > >> =20
> > >>  static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          return ldl_be_p(ptr);
> > >>      } else {
> > >>          return ldl_le_p(ptr);
> > >> @@ -87,7 +87,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev,=
 const void *ptr)
> > >> =20
> > >>  static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void =
*ptr)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          return ldq_be_p(ptr);
> > >>      } else {
> > >>          return ldq_le_p(ptr);
> > >> @@ -97,9 +97,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *=
vdev, const void *ptr)
> > >>  static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t =
s)
> > >>  {
> > >>  #if HOST_BIG_ENDIAN
> > >> -    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
> > >> +    return vdev->access_is_big_endian ? s : bswap16(s);
> > >>  #else
> > >> -    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
> > >> +    return vdev->access_is_big_endian ? bswap16(s) : s;
> > >>  #endif
> > >>  }
> > >> =20
> > >> @@ -111,9 +111,9 @@ static inline void virtio_tswap16s(VirtIODevice =
*vdev, uint16_t *s)
> > >>  static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t =
s)
> > >>  {
> > >>  #if HOST_BIG_ENDIAN
> > >> -    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
> > >> +    return vdev->access_is_big_endian ? s : bswap32(s);
> > >>  #else
> > >> -    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
> > >> +    return vdev->access_is_big_endian ? bswap32(s) : s;
> > >>  #endif
> > >>  }
> > >> =20
> > >> @@ -125,9 +125,9 @@ static inline void virtio_tswap32s(VirtIODevice =
*vdev, uint32_t *s)
> > >>  static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t =
s)
> > >>  {
> > >>  #if HOST_BIG_ENDIAN
> > >> -    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
> > >> +    return vdev->access_is_big_endian ? s : bswap64(s);
> > >>  #else
> > >> -    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
> > >> +    return vdev->access_is_big_endian ? bswap64(s) : s;
> > >>  #endif
> > >>  }
> > >> =20
> > >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > >> index 242c207a591..1dc60d37cb4 100644
> > >> --- a/hw/virtio/virtio.c
> > >> +++ b/hw/virtio/virtio.c
> > >> @@ -220,7 +220,7 @@ static inline uint16_t virtio_lduw_phys_cached(V=
irtIODevice *vdev,
> > >>                                                 MemoryRegionCache *c=
ache,
> > >>                                                 hwaddr pa)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          return lduw_be_phys_cached(cache, pa);
> > >>      }
> > >>      return lduw_le_phys_cached(cache, pa);
> > >> @@ -230,7 +230,7 @@ static inline void virtio_stw_phys_cached(VirtIO=
Device *vdev,
> > >>                                            MemoryRegionCache *cache,
> > >>                                            hwaddr pa, uint16_t value)
> > >>  {
> > >> -    if (virtio_access_is_big_endian(vdev)) {
> > >> +    if (vdev->access_is_big_endian) {
> > >>          stw_be_phys_cached(cache, pa, value);
> > >>      } else {
> > >>          stw_le_phys_cached(cache, pa, value);
> > >> --=20
> > >> 2.52.0
>=20
>=20
> I meant these ones.
>=20
> > --=20
> > Alex Benn=E9e
> > Virtualisation Tech Lead @ Linaro
>=20

--gb+mduCjLD6PK4dt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmA8nEACgkQnKSrs4Gr
c8iZ4gf/UIMCEg3BSPdtNCH9Ph9PdYGB18E9jHyOOnXSCFXEhSsk5zl6j1i9d73e
rkVpn3suDXOPqlpHpzeT+sL7H6bCZAbZ71gP2FNfH1RjyJobhqfVOcZFtT8V2lPN
aPaPxEnBm1Jv/Vmm6q0kyIKiWdDZANkS3z7kJXsA2IfvCbLsM4tdonoT8cdq04vL
/qWGhL2RR0Ici8FfYFlfTJkWfbx607TXCKrLqK7bBLova6tpTBH24HxTkvS4Cyjf
bMGq3TiE2RKxEuvWrJvdKbtmHz+Ei17/BqDYJ3i8RcHJjLAPQHJtLBoghASjqoJy
0x12Ep6d9UpHCdhV+59J7Dbkwwufgg==
=fWs5
-----END PGP SIGNATURE-----

--gb+mduCjLD6PK4dt--


