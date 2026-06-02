Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92689CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUVNy-00083K-JZ; Tue, 02 Jun 2026 16:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUVNw-000813-RF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUVNv-0007Ge-7s
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780430805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=huPhKchfmOUEWcTYwtHbxwXdFx1PhC5O5lzPaSl+oXs=;
 b=iFLiVU4mfWQ9KQjm6nZ6XF6gOlLrJexGr/gByOuwbg/VP/3z5hIzpzsMxWf1HTa8ahi8wY
 6O5TEug4x7ouUzXZkF5IbnsBsFBDSSsHrgNCwAdgF+E1wLVCI9Nk+55fJ0S3rzauQ5Z2wn
 IkZZam6O+vdx4meaiCJ4ZPUTZ2raxfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-FmUSP__BOBSDilO1UekERQ-1; Tue,
 02 Jun 2026 16:06:42 -0400
X-MC-Unique: FmUSP__BOBSDilO1UekERQ-1
X-Mimecast-MFC-AGG-ID: FmUSP__BOBSDilO1UekERQ_1780430801
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C7219560A6; Tue,  2 Jun 2026 20:06:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC1B330001A2; Tue,  2 Jun 2026 20:06:39 +0000 (UTC)
Date: Tue, 2 Jun 2026 16:06:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v11 0/5] Add full zoned storage emulation to the qcow2
 driver
Message-ID: <20260602200638.GB1043118@fedora>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iXIxiOskMfe+wvNr"
Content-Disposition: inline
In-Reply-To: <20260601214405.252818-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--iXIxiOskMfe+wvNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 11:44:00PM +0200, Sam Li wrote:
> This patch series add a new extension - zoned format - to the
> qcow2 driver, allowing full zoned storage emulation on a qcow2
> image file. A user can attach such an image to a guest and have
> it appear as a host-managed zoned block device.
>=20
> The zoned format is opt-in through a new qcow2 header extension
> that pins the zone geometry. Behind the extension is a dedicated
> zoned metadata region that stores one 8-byte write pointer (WP)
> per zone. The extension is gated by an incompatible bit, so an
> older qcow2 implementation cannot accidentally open the image.
>=20
> Each write pointer is routed through the write pointer cache,
> a Qcow2Cache object. The write pointer cache is written to disk
> after the qcow2 metadata is written, thus guaranteeing that
> the write pointer is updated after the corresponding data is
> written.
>=20
> Zone states are in memory. Read-only and offline states are
> device-internal events, which are not modelled in qcow2
> emulation for simplicity. The other zone states
> (closed, empty, full) can be inferred from write poiner
> values, presistent across QEMU reboots. The open states are
> kept in memory using open zone lists.
>=20
> To create a qcow2 file with the zoned format:
>=20
>     qemu-img create -f qcow2 zbc.qcow2 \
>         -o size=3D768M \
>         -o zone.size=3D64M \
>         -o zone.capacity=3D64M \
>         -o zone.conventional_zones=3D0 \
>         -o zone.max_append_bytes=3D4096 \
>         -o zone.max_open_zones=3D6 \
>         -o zone.max_active_zones=3D8 \
>         -o zone.mode=3Dhost-managed
>=20
> Then attach it to a guest via the QEMU command line:
>     -blockdev node-name=3Ddrive1,driver=3Dqcow2,\
>               file.driver=3Dfile,file.filename=3Dzbc.qcow2 \
>     -device virtio-blk-pci,drive=3Ddrive1 \

Please run `make check-block-qcow` and ensure the tests pass. In some
cases the test reference output may be outdated and you can simply copy
the <test>.out.bad file over the <test>.out reference file.

Thanks,
Stefan

--iXIxiOskMfe+wvNr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmofN84ACgkQnKSrs4Gr
c8h/Sgf+NrOVRVzVArFdFbj4o2iQNP/jDMsUopKR2Ehpl3MN2u21SjKvwp7m38no
Q7wFTZgh/slX6JHslP95lXYD6gGkxYFIBehOA1o2MdTTB16uw7CxYi7AIKegLZW0
J6ZrJaXyvcemXRqgIpe4nFeOswJhMXRXHzflXQcm/aE429Z+lRSvT0DDdRiCGt6O
PLr79XaK4SPxotKAAF2acK4+UHCWI7+STgScvkFJdto/4NS4vfFjNzRyERRC0mr0
iqqhV8Ia/enHPEwkguzfJNjGFEXsJS9jiLsVj68Vrdig3+xUtYD9hZYK40WYC+Sv
hQrcjbkK49P5oqLoivckjqP8PbI8ng==
=RUvg
-----END PGP SIGNATURE-----

--iXIxiOskMfe+wvNr--


