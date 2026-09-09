Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C581C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4N8C-0004sY-RJ; Wed, 09 Sep 2026 14:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N8B-0004ro-HI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N89-0006OD-OE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788978884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKBEDnilrgkpBOOrh+dbk3UgtghIabGDsl/Pvs4j0NA=;
 b=MlPrcpkg7CG/uE57cIr8LHqyFoeThz1WySjEQowimhI07a6EZ4SBzt5svwT0fNnU+kRcHR
 lZRYkP8psids0P1UAndEN15iutzznpSWcsYGr5MqMNA3ipB6hXO81Fhzooni1lyxCKPW4j
 7krNXzRphIDEOfSLeLUU/HPAAtim3P4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-sJbQ6i2mOiqQRvKZHAoumg-1; Wed,
 09 Sep 2026 14:34:40 -0400
X-MC-Unique: sJbQ6i2mOiqQRvKZHAoumg-1
X-Mimecast-MFC-AGG-ID: sJbQ6i2mOiqQRvKZHAoumg_1788978879
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A4AB1954193; Wed,  9 Sep 2026 18:34:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 780D818004D4; Wed,  9 Sep 2026 18:34:38 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:34:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 06/12] hw/block: reject a zoned device whose write
 pointers are unaddressable
Message-ID: <20260909183437.GE20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-7-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/YfYVLxMu9XUzckv"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-7-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--/YfYVLxMu9XUzckv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:41PM +0200, Niklas Cassel wrote:
> The write pointers of a zoned device outlive any particular use of it,
> whether the device keeps them itself or a backend records them, while the
> logical block size is a property of the frontend and is chosen afresh
> every time the device is attached. Nothing ties the two together. A zone
> written while the device was configured with logical_block_size=3D512
> leaves a write pointer that is a multiple of 512, and attaching the same
> device with logical_block_size=3D4096 makes that pointer unaddressable.
>=20
> Such a pointer is not merely misaligned. The guest addresses the device
> in logical blocks, and a zone report expresses the write pointer in 512
> byte sectors, so the guest is told about a position that does not fall on
> a logical block boundary. It can neither read nor write there, and the
> zone can only be recovered by resetting it. The reverse direction is
> harmless: a pointer laid down with a larger logical block size is still a
> multiple of a smaller one.
>=20
> On a zoned null_blk device with a logical block size of 512, a 512 byte
> append to a sequential zone leaves the write pointer half a logical block
> into it:
>=20
>   $ qemu-io --image-opts -n driver=3Dhost_device,filename=3D/dev/nullb0 \
>         -c "zap -p 0x20000000 0x200" -c "zrp 0x20000000 1"
>   start: 0x100000, len 0x80000, cap 0x80000, wptr 0x100001, zcond:2
>=20
> Attaching that disk with logical_block_size=3D4096 handed the guest a zone
> it could not write to.
>=20
> Check at realize time that the zone size and every write pointer of a
> sequential zone are multiples of the write granularity that the device is
> about to report, and refuse to start otherwise. The write pointers are
> already held in memory by the driver, so this costs no I/O.
>=20
> The check uses blkconf_zone_write_granularity(), the same value that a
> frontend reports to its guest and validates requests against, so the
> three cannot disagree.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/block.c         | 46 ++++++++++++++++++++++++++++++++++++++++
>  hw/block/virtio-blk.c    |  4 ++++
>  include/hw/block/block.h |  1 +
>  3 files changed, 51 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/YfYVLxMu9XUzckv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhpr0ACgkQnKSrs4Gr
c8i5GQf9GRuQe4uIKY+PBDjNMFuevEATbGCDhyQplgBt6XHQu3k6yyV3Dx8wLxez
6TWoga1Sd53eKW0CSxU3Nh2RFOWXaNDRWgaGf6Snub6VriVtNw4yTsXbspUo6qAs
wJMNeLINiVNgzR4S8MNM8m0imXUTLwdK4Mt2rBUHJXj9B4/0ntabVneO9xpDvV8/
L3it9qvVQVd3QdwXNejVcxEz3yXo9URbibj8f359NxMMXxBZgwp6mUGXFeBMmXiB
EVgEQToOQVQvxuWYChR4vWKzYgHKSBhDfjwzRCjF5cWMk4Rs8iomHdezJ3wE2wWb
Lv+6N8RPObMvWOP7zky/CeHJHMKhyw==
=UxR4
-----END PGP SIGNATURE-----

--/YfYVLxMu9XUzckv--


