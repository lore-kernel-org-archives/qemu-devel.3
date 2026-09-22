Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF62C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95nF-00045R-F8; Tue, 22 Sep 2026 15:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95nC-00044d-LT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95n4-0000G6-W4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790103864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxCyLO/4yRynX8cSzUI6iPRHeY5Sk262jGt08baOTJg=;
 b=g/jULdmw2neLM4c75Q7Hy53CJkV3+zEPVaeUPYRwrXoYUG5jZ0lqVrEruKmqkYQwP5PmUw
 vGrC2ZAk3eiU5u7WauhcexyCYQiFU4MH8kAouwRphfcMz9cuZBX81nsqgqidhxN0afr0VJ
 CL5upjQSHjE+Svhgb8o6dvsq9zJ5B0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-5iR4VAvbMqKVcwyaZ_Gljg-1; Tue,
 22 Sep 2026 15:04:22 -0400
X-MC-Unique: 5iR4VAvbMqKVcwyaZ_Gljg-1
X-Mimecast-MFC-AGG-ID: 5iR4VAvbMqKVcwyaZ_Gljg_1790103860
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B1F9195411B; Tue, 22 Sep 2026 19:04:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D89B1800446; Tue, 22 Sep 2026 19:04:19 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:04:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 09/15] block: reject a zone append that is larger than
 a zone
Message-ID: <20260922190418.GD340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-10-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ka00Bp1Cmz/t6zqI"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-10-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Ka00Bp1Cmz/t6zqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:11PM +0200, Niklas Cassel wrote:
> A zone append cannot cross a zone boundary, so a request larger than a
> zone can never be carried out.
>=20
> Nothing rejects one. The block layer does not look at the length at all,
> and raw_co_zone_append() writes qiov->size bytes at the write pointer
> once it has validated the offset, so the write runs past the end of the
> zone: on a disk with 8 MiB zones, an append of 8 MiB plus one block
> fills the zone and advances the write pointer of the zone after it.
>=20
> virtio-blk does compare the length, but against
> BlockLimits.max_append_sectors, which is how much the backend takes in
> one command and not how large a zone is. For a Linux block device that
> value is never larger than a zone, so virtio-blk is protected by what
> the backend happens to report rather than by the check it makes.
>=20
> Check the length in bdrv_co_zone_append(), next to the check that an
> append is a multiple of the sector size. Both are conditions of the
> operation rather than of a medium, so the block layer is where they hold
> for every caller and where no driver has to repeat them.
>=20
> The exact bound is tighter: a request also has to fit in the part of the
> zone that is still writable, which depends on the write pointer and so
> stays with the drivers.
>=20
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/io.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ka00Bp1Cmz/t6zqI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqy0TIACgkQnKSrs4Gr
c8gJawgAtcwK5MeyRNKt0/EIrzqHJFpwYoLo4b3dKBEWSCDbv7qVmgNKSCD8rU3h
pRR79KnlQAWxZWDI7BYUcARY67u0E8UevkmTAU19IeQ7WUSnoWslUndF3Fxxl4c7
CQFtwua/AliSV9sw/PD0MczT4EXo08tCcyFGDuwuQ6XmO4v1WYg994WtuIjKKHab
JEQf6ap6E1kJqochcoSvPSxgXEhGssgn+cUfkop3/6WKnvH95f730tLoSWWdSB/H
+E4AQg2pHhS3cBwKXgYt6vcjs65gbNZRyz7vEfN3miBqAuh5DzmGy+anIglqZlDC
39GEeT4dp4qB5vk62z5lW4cq616JHA==
=VpXE
-----END PGP SIGNATURE-----

--Ka00Bp1Cmz/t6zqI--


