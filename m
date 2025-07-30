Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D056FC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCOB-0005v9-FR; Wed, 30 Jul 2025 15:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhAKN-0006F0-8L
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhAKL-0002bh-Fk
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753895451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qw7eOKOp8OmsauRi5rExfKJMDe91Elglm7JpG7ZhRKA=;
 b=inoOWZr5bO9bSHJuj6f3DKZLHK+6OsG8eWedPpIOWE6k91ufoH5Pb1RAci1rd6cuYkHRJF
 Zg5RMhSf08w0kMhvonkj50HkjTQH2PZabXQqepFD7jr/uIg1aGguwWySS08/4K8ZHwqL+k
 Y1XPaoy47BGbphQG6I5jOTtQbVIcyxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-ZJauMBDvNvWzq8YzIoy4fg-1; Wed,
 30 Jul 2025 13:10:47 -0400
X-MC-Unique: ZJauMBDvNvWzq8YzIoy4fg-1
X-Mimecast-MFC-AGG-ID: ZJauMBDvNvWzq8YzIoy4fg_1753895446
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B24B19560B4; Wed, 30 Jul 2025 17:10:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.197])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAA63180035E; Wed, 30 Jul 2025 17:10:45 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:10:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 12/21] block: Move qemu_fcntl_addfl() into osdep.c
Message-ID: <20250730171044.GA74304@fedora>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-13-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SmtmOJUlHIoL/gWb"
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-13-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--SmtmOJUlHIoL/gWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:44:28PM +0200, Hanna Czenczek wrote:
> Move file-posix's helper to add a flag (or a set of flags) to an FD's
> existing set of flags into osdep.c for other places to use.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/qemu/osdep.h |  1 +
>  block/file-posix.c   | 17 +----------------
>  util/osdep.c         | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SmtmOJUlHIoL/gWb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiKUhQACgkQnKSrs4Gr
c8hIPwgAvREdArs/gl+Q+jCt74eub8whq0n2DKbdMEv0AtAcPUaTHE1gnF3GU2hQ
vGhW/i74lSpMfGfgMqFC5tGaVOIsU4G1ypZTuJ7Y5ohAbSiegT8d/oSUG/b0UY0y
GlyI7fp995Z51doP9C/20biSRxB31VSJNdEv2/ewcvGMJ3YAns8mMgmu5Z4OK7Sk
4tLT/8WGdOQ/WUXxNgmR7/A9pTk1qZamKaC/aqA4qU5X8p7E0Y8L9HztNsf67TXi
Lmd3FWwdUV4hTXVJ0jGqfxv+Jpz0CtYTX3bcUYepuqZZX8xRAFwV5JW0Zd71kxqR
hB0XyMgbtH5GIOomh3GtovbjbxFsqw==
=YCXi
-----END PGP SIGNATURE-----

--SmtmOJUlHIoL/gWb--


