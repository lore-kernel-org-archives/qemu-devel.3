Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCCCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95zF-0007id-Oj; Tue, 22 Sep 2026 15:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95yz-0007fe-VW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95yy-0001j3-IH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790104606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9nKsLHcUYOkNmww3ns8XKnSnw+vXWYOFxQ9g6eT7B4=;
 b=UkByXW1WG/IXZ3Tb+2V/urmLMfV4ABW24J8e3069du3hSbuta7vraPicMVTm9/cHJ5d8Z7
 R1NWAnRUZ6MKQhoPwBJwpd596obCCyrnW9fi5ljkJB1VDpHfNPaOfS/gcEQThp21nWdDiv
 xi82HDKP9LqiVzcEzTtjI4sIaOEpk44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-CWtZmvhKOVatHtYF4OPcPA-1; Tue,
 22 Sep 2026 15:16:42 -0400
X-MC-Unique: CWtZmvhKOVatHtYF4OPcPA-1
X-Mimecast-MFC-AGG-ID: CWtZmvhKOVatHtYF4OPcPA_1790104601
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AED20180062D; Tue, 22 Sep 2026 19:16:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 470D441B; Tue, 22 Sep 2026 19:16:40 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:16:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 12/15] block: remove BlockLimits.max_append_sectors
Message-ID: <20260922191639.GF340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-13-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sCaqiKDs+L+wOsj8"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-13-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--sCaqiKDs+L+wOsj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:14PM +0200, Niklas Cassel wrote:
> The field described the largest zone append that a backend accepts. It
> had one writer and one reader, and neither is left.
>=20
> file-posix filled it from the zone_append_max_bytes queue attribute,
> which bounds REQ_OP_ZONE_APPEND, an operation it never issues: Linux has
> no userspace interface for one, so raw_co_zone_append() substitutes the
> write pointer of the zone for the offset and the request reaches the
> host as a plain pwritev().
>=20
> The transfer limit does not apply either, no more than it does to an
> ordinary write. This driver reports max_hw_transfer but never sets
> BlockLimits.max_transfer, which is what bdrv_aligned_pwritev() splits
> by, so a request of any size goes to the host kernel whole and is split
> there: on a null_blk device whose zone_append_max_bytes is 130560, a
> 16 MiB append completes and advances the write pointer by 16 MiB. That
> is safe for a sequential zone, as Linux issues the fragments of a split
> write in order, with zone write plugging since 6.10 and zone write
> locking before that.
>=20
> virtio-blk was the reader, and now takes what it reports to a guest from
> a property instead.
>=20
> Remove the field and the assignment that filled it. Keeping it would be
> worse than not having it: a driver that set it, believing something
> enforced it, would be silently ignored.
>=20
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c               | 5 -----
>  include/block/block_int-common.h | 3 ---
>  2 files changed, 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sCaqiKDs+L+wOsj8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqy1BcACgkQnKSrs4Gr
c8hwoAf8CrUQ9b9B6CitfPggqp4OEMlpSd/NFjACkJeTbyp1j4ahKjFOKmpgA3MX
lGbc4XjWOT89tPMf8bGviy0mQ36uqDQEseZfjj8kx4zYWF/ChSEOGYpGkly2jW8H
5qDks2C1maqvielDwPCafQegO7F5nbILgdHt1IznSsgR0C74Lmb+TdAbuBUfuj0C
q1SmS2JLsZPAChvKbMbck7l5k6R1vuZguXEU/0LjKHnyheV9TSNw6YxMdGm9YPdY
qrpPy9sAV2QMu3tdfi2j3XLglGgs0OMeEpVj/WEbXEetX6xvT1+8RvNKWtkKFrSb
5xFQ2Smt+T50N7r+N3EQ4rnFedL4zQ==
=+C5v
-----END PGP SIGNATURE-----

--sCaqiKDs+L+wOsj8--


