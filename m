Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC0F8D775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSlO-0004GS-Aq; Thu, 16 Apr 2026 15:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDSlF-0004Ft-0k
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDSlC-0004h2-7X
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776369140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggQtieDdbug4MvR4EdSB0lZHe7gF9fQZ6xaokz7e7bQ=;
 b=HtGMLvUfMuBtKoFbVodIpBNwAKKbw+bhpIdhgdmWHljLHruoTPwdO8hilRZVtsrqBmrRuv
 KqFTRst/0XVBrv10+JJo2DF5ed2H96WsaM1NamCWyB2jpuo533Hank5aU6gghk42aLYn/i
 kXc/POXqBllrqxw6OSHPF8HkI7AjZ0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-VBxl6ntqN3eF-df_4xWIQg-1; Thu,
 16 Apr 2026 15:52:16 -0400
X-MC-Unique: VBxl6ntqN3eF-df_4xWIQg-1
X-Mimecast-MFC-AGG-ID: VBxl6ntqN3eF-df_4xWIQg_1776369132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5412619560AA; Thu, 16 Apr 2026 19:52:12 +0000 (UTC)
Received: from localhost (unknown [10.44.48.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 954FC1800446; Thu, 16 Apr 2026 19:52:10 +0000 (UTC)
Date: Thu, 16 Apr 2026 15:52:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matthieu Rolla <matthieu@minio.io>
Cc: =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Message-ID: <20260416195208.GB258343@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
 <ad9s9CRT0niUAPQn@redhat.com>
 <7E17AD80-CF52-44FC-A0FE-29B481EF5B40@minio.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sOgxC4cYjq/PLA2P"
Content-Disposition: inline
In-Reply-To: <7E17AD80-CF52-44FC-A0FE-29B481EF5B40@minio.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--sOgxC4cYjq/PLA2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 02:32:39PM +0200, Matthieu Rolla wrote:
> Thanks Daniel,=20
>=20
> It makes sense Thanks.=20
>=20
> Looking at the existing code, blockdev-insert-medium already does the bac=
kend/frontend association via blk_insert_bs(), but is restricted to removab=
le devices.=20
> A new QMP command like blockdev-attach could reuse the same logic without=
 the removable restriction, paired with blockdev-add for creating the block=
 node.
>=20
> Would that be a better approach ?=20

Hi Matthieu,
I was wondering whether the blockdev needs to be changed at all. Since
the disk image remains the same, is it sufficient to inject the PCIe SDN
and then recover the NVMe PCI controller?

I don't understand the test scenario well enough, but it seems like
you're testing at the PCIe level here rather than nothin NVMe- or
blockdev-specific. Therefore blockdev commands may not be necessary.

If the testing can be done completely at the PCIe level then that would
also allow other device types to be tested in the same way, which would
be nice.

Stefan

--sOgxC4cYjq/PLA2P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnhPecACgkQnKSrs4Gr
c8gUpgf3TtuBFC4KYnaO98Boo4Vleum/I/gCdlXm+YQ5uSMQ0sHMZ9N5trbNs9+o
D3vbX6e5vBMI260ihBbucZjQr+9WCQXiu8h+jLNbf+xpoRfLnAtM6CUgv0t9UGgx
2PWnq9Ec9+lVekFoYMbjszCldoiUW8jgsaJBIBnX2GtvAkA7Nkxggejc1SxOjOaY
xNErGCM0s0fIWXax/t5Q0roGb5mVzcUgo0Hb0G7OK9vwrOUhE+aaFuYZkuFGVH6f
0is7ls0cAKEOuYce6Q8AbussfxCsgQclywh8g01DO//W/uSziRLoFutG8R6SDqck
vfjKGm7Qj5nMaYPdBN54oYWCoPqF
=8WjN
-----END PGP SIGNATURE-----

--sOgxC4cYjq/PLA2P--


