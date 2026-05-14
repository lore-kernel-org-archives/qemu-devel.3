Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92752CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaxF-0002Gd-CT; Thu, 14 May 2026 14:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNax9-0002Fx-NO
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNax5-0002Ei-LJ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778783910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxAL9xKH2wG2fjYnvkndn4ldgX1yhMgKzinNdimvTRs=;
 b=FD/lSBOL7ZWnoGqSop38hgJo4g7g1YILkBgzyPagAxgl4+AlHgLFp5BWIK2lBUBxrR9ktR
 HlD602nrj3Eo5AkvfZosQ2eTa4EGeQjEaGoMZ2QIskVktpGKPUC/TZL8RkxTfhDvCfeF2F
 WB4aALIcEutnz98kIFZsjmCod2mo2h4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-5fLPPU9FOLWJhWE-2s5UuQ-1; Thu,
 14 May 2026 14:38:26 -0400
X-MC-Unique: 5fLPPU9FOLWJhWE-2s5UuQ-1
X-Mimecast-MFC-AGG-ID: 5fLPPU9FOLWJhWE-2s5UuQ_1778783905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 291301800612; Thu, 14 May 2026 18:38:25 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A8BC1955F2D; Thu, 14 May 2026 18:38:24 +0000 (UTC)
Date: Thu, 14 May 2026 14:38:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 0/4] Add full zoned storage emulation to qcow2 driver
Message-ID: <20260514183820.GA1535937@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D8EMBih6HjXlIlCB"
Content-Disposition: inline
In-Reply-To: <20260510175059.311814-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--D8EMBih6HjXlIlCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 07:50:55PM +0200, Sam Li wrote:
> This patch series add a new extension - zoned format - to the
> qcow2 driver thereby allowing full zoned storage emulation on
> the qcow2 img file. Users can attach such a qcow2 file to the
> guest as a zoned device.
>=20
> Write pointer are preserved in the zoned metadata. It will be
> recovered after power cycle. Meanwhile, any open (implicit or
> explicit) zone will show up as closed.
>=20
> Zone states are in memory. Read-only and offline states are
> device-internal events, which are not considerred in qcow2
> emulation for simplicity. The other zone states
> (closed, empty, full) can be inferred from write poiner
> values, presistent across QEMU reboots. The open states are
> kept in memory using open zone lists.
>=20

Hi Sam,
Thanks for picking up this work again!

> To create a qcow2 file with zoned format, use command like this:

A qemu-img create command-line is missing here in the cover letter.

>=20
> Then add it to the QEMU command line:
>     -blockdev node-name=3Ddrive1,driver=3Dqcow2,file.driver=3Dfile,file.f=
ilename=3D../qemu/test.qcow2 \
>     -device virtio-blk-pci,drive=3Ddrive1 \
>=20
> v9->v10:
> - add cross-boundary constraint for merging writes on zoned devices
> - extract call from assert() to fix image creation crash
>=20
> v8->v9:
> - fix compilation err after modifying types
>=20
> v7->v8:
> - sets default values for zoned img confurations [Markus, Damien]
> - changes the type of zone_size, zone_capacity from uint32_t to uint64_t =
[Stefan]
> - fix docs [Stefan]
> - modify append writes to increase concurrency [Damien, Stefan]
> - use tailqueue to track active zones [Stefan]
> - fix undefined behavior of ranges_overlap()
> - fix the iotest of case 2(1)
>=20
> v6->v7:
> - modify zone resource managemant (style) [Damien]
> - fix accessing list with negative index err
> - add some tests for zrm in iotests
> - address review comments [Markus]
>=20
> v5->v6:
> - fix docs and specs [Eric, Markus, Stefan]
> - add general sanity checks for zoned device configurations while creatio=
n and opening [Eric]
> - fix LRU when implicitly open a zone for a long time [Stefan]
>=20
> v4->v5:
> - add incompatible bit for zoned format [Eric]
> - fix and manage zone resources via LRU [Damien]
> - renaming functions and fields, spec changes [Markus, Damien]
> - add closed zone list
> - make qemu iotests for zoned device consecutive [Stefan]
>=20
> v3->v4:
> - use QLIST for implicit, explicit open zones management [Stefan]
> - keep zone states in memory and drop state bits in wp metadata structure=
 [Damien, Stefan]
> - change zone resource management and iotests accordingly
> - add tracing for number of implicit zones
> - address review comments [Stefan, Markus]:
>   * documentation, config, style
>=20
> v2->v3:
> - drop zoned_profile option [Klaus]
> - reformat doc comments of qcow2 [Markus]
> - add input validation and checks for zoned information [Stefan]
> - code style: format, comments, documentation, naming [Stefan]
> - add tracing function for wp tracking [Stefan]
> - reconstruct io path in check_zone_resources [Stefan]
>=20
> v1->v2:
> - add more tests to qemu-io zoned commands
> - make zone append change state to full when wp reaches end
> - add documentation to qcow2 zoned extension header
> - address review comments (Stefan):
>   * fix zoned_mata allocation size
>   * use bitwise or than addition
>   * fix wp index overflow and locking
>   * cleanups: comments, naming
>=20
> Sam Li (4):
>   docs/qcow2: add the zoned format feature
>   qcow2: add configurations for zoned format extension
>   qcow2: add zoned emulation capability
>   iotests: test the zoned format feature for qcow2 file
>=20
>  block/file-posix.c                       |    2 +-
>  block/qcow2.c                            | 1113 +++++++++++++++++++++-
>  block/qcow2.h                            |   39 +-
>  block/trace-events                       |    2 +
>  docs/interop/qcow2.rst                   |  110 ++-
>  docs/system/qemu-block-drivers.rst.inc   |   42 +
>  hw/block/virtio-blk.c                    |   22 +-
>  include/block/block_int-common.h         |   15 +-
>  include/qemu/queue.h                     |    1 +
>  include/qemu/range.h                     |    4 +
>  qapi/block-core.json                     |   70 +-
>  tests/qemu-iotests/tests/zoned-qcow2     |  150 +++
>  tests/qemu-iotests/tests/zoned-qcow2.out |  173 ++++
>  13 files changed, 1730 insertions(+), 13 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
>  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out
>=20
> --=20
> 2.43.0
>=20

--D8EMBih6HjXlIlCB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoGFpwACgkQnKSrs4Gr
c8jrgQgApOSRReXzAwsQqfdECiM6wfgpiKLfUpviaENZU3VIaTY3ylpO1f69rEOd
PCN25BSqTP0/Jwyz6JvyJbskwfrnxIRghK7P3nhIbGrP5PoeXfZ9W/Y62kROEPqS
i3sS/BAU6EU/3G+TG5Um5BQ5YI4C3UO6qu8Szz6JHIQbRDz1f7mjz4YEJ3wfaWIq
dbeeHCJiercZ9V0rNpIvap/71DFbaVUfNuwvUxWCqdxD/KlvgJqtu20t2SKWZDHL
Ym7imzNnNjmXl/yDnhI0Bkf2K1Fq1PlO4H8jzx2lR2dGbJxkTqp1AYywWoUkGV1i
fNR+k6FjVoL9M3Tkyy5pgF8INGQvRw==
=5n6I
-----END PGP SIGNATURE-----

--D8EMBih6HjXlIlCB--


