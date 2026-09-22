Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EABCC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95hg-00021n-QB; Tue, 22 Sep 2026 14:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95hJ-0001zK-37
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95hG-00089r-Vl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790103508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfEL5GEn9vEFI9yqtEcnhMHBgKRYMRsJQCuZtJWl3Ls=;
 b=e6sK4OaUlAXzrDlxYR+YKHoBtqESgBrVW5gqu5DcwAZZ5kmN314MqbHXtIu27M9VPwAsxX
 x7ht0OWZjrOSHDP+vd7H0JJl/fxs0OjyQ3nc/+Ex5e/ZkltItwUuek91hMKKpoaXG/T7rU
 uJdTb2g43lx1zfVyjrlviiOunExGV30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-Ob5J_uCqPz64LDDQdP9cog-1; Tue,
 22 Sep 2026 14:58:23 -0400
X-MC-Unique: Ob5J_uCqPz64LDDQdP9cog-1
X-Mimecast-MFC-AGG-ID: Ob5J_uCqPz64LDDQdP9cog_1790103501
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B069019539B5; Tue, 22 Sep 2026 18:58:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C028741B; Tue, 22 Sep 2026 18:58:20 +0000 (UTC)
Date: Tue, 22 Sep 2026 14:58:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 05/15] hw/block: derive the zone write granularity
 from the block sizes
Message-ID: <20260922185819.GB340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-6-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="obe6NLHSlNOQgMdP"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-6-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

--obe6NLHSlNOQgMdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:07PM +0200, Niklas Cassel wrote:
> For ZBC/ZAC devices the write granularity is the physical block size, so
> a 512e SMR disk exposed through a host_device backend has a logical block
> size of 512 and a zone write granularity of 4096. We told the guest
> driver 512 while raw_co_zone_append() rejects anything that is not 4096
> byte aligned, so the driver saw a plain I/O error for a request it had
> been told was valid.
>=20
> Report the larger of the logical and the physical block size instead.
> Both are properties of the device model, so the value that a guest is
> given does not change when it is migrated to a host whose disks differ,
> which a value taken from BlockLimits would. It is also what a guest
> derives for itself: blk_validate_zoned_limits() raises
> zone_write_granularity to the logical block size, and for a SCSI disk
> sd_zbc_read_zones() takes it from the physical block size.
>=20
> blkconf_blocksizes() rejects a logical block size larger than the
> physical block size, so this is the physical block size in practice. It
> is expressed as the larger of the two because that is the constraint
> which applies: a guest cannot issue a write finer than the logical block
> size, and the medium cannot take one finer than the physical block size.
>=20
> Add it as a helper next to blkconf_blocksizes(), since it is derived from
> a BlockConf, and use it for the zone append offset check in
> check_zoned_request(), which validated against bs->bl.write_granularity.
> The value reported to the driver and the value that requests are
> validated against then cannot drift apart. The helper cannot return zero
> because blkconf_blocksizes() always leaves a logical block size behind,
> so the check no longer needs to guard against an unset granularity.
>=20
> Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned d=
evices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/block.c                 |  5 +++++
>  hw/block/virtio-blk.c            | 13 +++++++------
>  include/block/block_int-common.h |  7 +++++++
>  include/hw/block/block.h         | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--obe6NLHSlNOQgMdP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqyz8sACgkQnKSrs4Gr
c8iK0wf+KGQGe26gGGAgwnjDfl+8UM7s55jTW0TSkz6siY15Q43FAP60sSdI6l3J
LCwf0g274W8Kd2v1GzYNa//1XsvLb1UrJOe6eGjNAzVcp9UyS7VOfm383zrA7YPI
SuCZJkLoq/lFAWAxolGP5SZYIar1iYhqQiDxreF0GfLfGKCFPQkzxEd4H8ICgTTz
RWmua8M358CK/qABatos7ywRTcKZbuhCd8LYHI+W3h6n7sDEerTcZfubxq06yR07
h+71vVwNzDnvNPMSgpPp71Na5Un+krfbfCyAIinnUlJQ8+aDwaNIzpjc9scdojay
e1n5S3Vrs6z28xOMM5NnQ3ST0WMuWg==
=z20z
-----END PGP SIGNATURE-----

--obe6NLHSlNOQgMdP--


