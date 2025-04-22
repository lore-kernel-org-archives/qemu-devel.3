Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790BEC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Eqs-0002Bc-5W; Tue, 22 Apr 2025 10:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7Eqn-000273-EK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7Eql-0003kE-IF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745333029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oh5jbjH5Jt0GcKZEJHaCdlSW5ODr9EKLxabyMzr99Lw=;
 b=cZzmmUaIKsSLEt4UInyjzL33r671gwTFNbBxmeqZpzWMR93oB8FvBJKMSSBBxs+83zkFv1
 gW4N2pN4tK1XY7CZqKgTaCZQPOsCOmab3ZqkM4klCubD5mKFycaDsRGJJHq3ChRrOKNGHH
 L5wlaa3VhZ3fogX6L+wOMApv8irZpUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-0dFZqxr9OSmELEq6EMQRaA-1; Tue,
 22 Apr 2025 10:43:43 -0400
X-MC-Unique: 0dFZqxr9OSmELEq6EMQRaA-1
X-Mimecast-MFC-AGG-ID: 0dFZqxr9OSmELEq6EMQRaA_1745333022
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C9F1955D84; Tue, 22 Apr 2025 14:43:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC546195608D; Tue, 22 Apr 2025 14:43:40 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:43:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2.5 02/11] file-posix, gluster: Handle zero block status
 hint better
Message-ID: <20250422144339.GF301197@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250418215412.404558-3-eblake@redhat.com>
 <20250418215412.404558-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TVMKjij3SHcCTd96"
Content-Disposition: inline
In-Reply-To: <20250418215412.404558-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--TVMKjij3SHcCTd96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:52:47PM -0500, Eric Blake wrote:
> Although the previous patch to change 'bool want_zero' into a bitmask
> made no semantic change, it is now time to differentiate.  When the
> caller specifically wants to know what parts of the file read as zero,
> we need to use lseek and actually reporting holes, rather than
> short-circuiting and advertising full allocation.
>=20
> This change will be utilized in later patches to let mirroring
> optimize for the case when the destination already reads as zeroes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Compared to v2, also adjust the gluster driver which copies file-posix.
>=20
>  block/file-posix.c | 3 ++-
>  block/gluster.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TVMKjij3SHcCTd96
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHqxsACgkQnKSrs4Gr
c8hZ/QgAiJxwx7RphWA31BSLqp41hmtaNe7xhVAVcGQB9vxpZpzPf8uzjkMXkm0c
q4yzie4aeHwX6U7bmUCLWaioOgG3aHnKEYgTXNjB7CDBLVuWULZzASRp2RJxlyNh
MdnEjcDHKxQ7kEceQDjSlHffqIOF6rppyKNaP0i0airMTFxVYrIxlygJMd2T9ciP
EwwckR+/qeMNUEg4x/RmpOtrCdz0868MwGm5VdvwRyPLbeEWAVtb5CMMdutAXrn8
icsF1pHw/msYMVjfZhumBLfV7QqsOomAcNUtMBDOe1FllECiKyEdKSjgpIe8Ekkm
vjwhm76NOmIZSshI8EBfv+TNHa5kKw==
=ySCZ
-----END PGP SIGNATURE-----

--TVMKjij3SHcCTd96--


