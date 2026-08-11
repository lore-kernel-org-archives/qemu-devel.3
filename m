Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF21C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmnx-0007mK-9u; Tue, 11 Aug 2026 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtmnq-0007li-VV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtmnn-00030O-NO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786455957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Po2cA2dKamkDo82ntrIwJzQhmnqMPvPZLGNVu2Jp5Hg=;
 b=G/jTmCamOF908rdy2ZnqIxpjLwDMKiDnkZFtkyEXr+qny5uTYsWhXL5hE1UK8g5Nf2jWNS
 bmgAxYNFhNlgFbJ3+4p+kFpW77/Allsl1tSg9FNGqL9c5iBMCbBYGSLisDKh6hdiV5qQu+
 2C1p3Jf1jCsQHt6gVoDYYRM9jky30PI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-bwyE8HPJPR-Nc3KNFbZLBg-1; Tue,
 11 Aug 2026 09:45:53 -0400
X-MC-Unique: bwyE8HPJPR-Nc3KNFbZLBg-1
X-Mimecast-MFC-AGG-ID: bwyE8HPJPR-Nc3KNFbZLBg_1786455952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C1DF19560AD; Tue, 11 Aug 2026 13:45:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ABD33001D3A; Tue, 11 Aug 2026 13:45:50 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:45:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] file-posix: fix zone write granularity assignment for
 zoned block devices
Message-ID: <20260811134549.GA111558@fedora>
References: <20260807180257.813627-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OEnuH8379rdU68xN"
Content-Disposition: inline
In-Reply-To: <20260807180257.813627-1-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

--OEnuH8379rdU68xN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 08:02:57PM +0200, Niklas Cassel wrote:
> In the ZBC and ZAC specifications, the requirement is that the write
> granularity matches the physical block size.
>=20
> However, in the ZNS specification, the requirement is simply that the
> write granularity matches the logical block size.
>=20
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da805a4fa4fa376bbc145762bb8b09caa2fa8af48
>=20
> In Linux, there is a zone_write_granularity sysfs property which abstracts
> this away by providing, so let's make use of it.
>=20
> Currently, it is theoretically possible that QEMU presents an inflated
> write granularity for NVMe devices where the physical block size is larger
> than the logical block size.
>=20
> Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers=
")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OEnuH8379rdU68xN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7J40ACgkQnKSrs4Gr
c8hjlwgAuILaq8ttw4fP417fpBcfNajs+uawNlZ7MEHdbJfdBTlcIw+GYnMmVk4t
B07IArugkdqD6L1PM+fRQ0obJECYeJs9Veb8+KGaU5wPYwTJbyuTa4mQYkA0cLKm
nOlWIDAL/3F0GqwvFRTkuVq2ALlcIjL0fj6j/Jos1126UaYAYr30VmVnDHGsm3I/
imWojDJrtqv6J5WtvUCO9QzDyohSkh+cVLXMIUE6WcSV4ZkgpNIXoUfENx0zh6k3
kpE0yGZdCQapfcU8EjakSjpvY+1KMmPiIxs4muwE5wtrO6xZHRsNavL+vcAhc6Fn
e5llSHyLah/iWvQP3Wm0TeunwET38A==
=RDnW
-----END PGP SIGNATURE-----

--OEnuH8379rdU68xN--


