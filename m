Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23998C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdnO-0004O6-Ow; Mon, 09 Jun 2025 10:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOdnM-0004Nf-FI
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOdnL-0008Fd-4A
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749480494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ycHjZ5PRH/HXZmKtA3tqEywPxmYdSfn4wThBF7cfZM=;
 b=TlYd7BiGoN6ihMt2E6q6GlK1EkPmbJLo/6ExSsuFqOA5uX2eF9ub5op8beVMsImu6cILAD
 2p6BrhrVD03DAkiYYivuRClpiKhsTK/ciMfuFjYNkEjOz0IDIv24IaKZ/u1uLx/ElTsMLB
 0axO4OoP6qyFETuiKSLkKVFCNlXVY/U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-zqeS6837N1K7Hi2uG8lrSg-1; Mon,
 09 Jun 2025 10:48:12 -0400
X-MC-Unique: zqeS6837N1K7Hi2uG8lrSg-1
X-Mimecast-MFC-AGG-ID: zqeS6837N1K7Hi2uG8lrSg_1749480492
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28E51809C96; Mon,  9 Jun 2025 14:48:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B87719560B0; Mon,  9 Jun 2025 14:48:11 +0000 (UTC)
Date: Mon, 9 Jun 2025 10:48:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 11/21] fuse: Rename length to blk_len in fuse_write()
Message-ID: <20250609144810.GE29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-12-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x2CtQXzX6rnkBlzc"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-12-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--x2CtQXzX6rnkBlzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:03PM +0200, Hanna Czenczek wrote:
> The term "length" is ambiguous, use "blk_len" instead to be clear.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x2CtQXzX6rnkBlzc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhG9CoACgkQnKSrs4Gr
c8hqYwgAk4typ5xLxZ1ou/YdWDqO5BEBbtQjoP6cfXyDBKpoul1xwbZmkkoDa0LI
6qeSiZrj4Ej8WheIVupjGexu4LuZMWdQnIU7A2Q+GBrjKPWmXmXKJwtWDgLhNfuL
rDBWSffi9gWjXA7Ur8D4oTi1yqyEljrBmt8yErQ243LpdmWQinFTcC9rNc3BrY3R
SjoeNQfhGjsLv/QHyOh5MTJo2Hh9RRMM2lUL5fmIJYUNK5dWnD369GbcdXW6FFuG
zAtjGFBgE1WarhWfZ+YFu0OFxv1LHPiqv1TlapTAk5wMLgmpQYsiwiDWTBCmdXNf
1KsxY3DZSDO9NjNQR8ZR07PCl5KcKA==
=K+bT
-----END PGP SIGNATURE-----

--x2CtQXzX6rnkBlzc--


