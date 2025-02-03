Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF4DC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1az-00057v-7X; Mon, 03 Feb 2025 13:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1aw-00057K-Hk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1au-0005pH-H3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WcE8RO/WqVj98QtmRoz22s/cTT5kEhfgbsspVsxa2NE=;
 b=W45ebdou2nWgV43fL+vmVnYyowqlOPNTJWqIj5QZ8hEZmxWCnDWVPU5UIqnwzT0wyRTkjh
 kgpT+mgYhIXQvG1svPSO1hrWewvoEffixK09VIG5o5BqIsuTMr0LBwppgPKcNdRVVnxlVf
 2kLHEgb3MfbFAi31OTOHIRbm4gSQe98=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-owGdt7T5P1qBX9KpyilC4Q-1; Mon,
 03 Feb 2025 13:54:48 -0500
X-MC-Unique: owGdt7T5P1qBX9KpyilC4Q-1
X-Mimecast-MFC-AGG-ID: owGdt7T5P1qBX9KpyilC4Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325F519560B4; Mon,  3 Feb 2025 18:54:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 589731800360; Mon,  3 Feb 2025 18:54:45 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:54:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/15] block: Add blockdev-set-active QMP command
Message-ID: <20250203185444.GJ268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WsxZbAqrnnOXe0tJ"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-9-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--WsxZbAqrnnOXe0tJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:39PM +0100, Kevin Wolf wrote:
> The system emulator tries to automatically activate and inactivate block
> nodes at the right point during migration. However, there are still
> cases where it's necessary that the user can do this manually.
>=20
> Images are only activated on the destination VM of a migration when the
> VM is actually resumed. If the VM was paused, this doesn't happen
> automatically. The user may want to perform some operation on a block
> device (e.g. taking a snapshot or starting a block job) without also
> resuming the VM yet. This is an example where a manual command is
> necessary.
>=20
> Another example is VM migration when the image files are opened by an
> external qemu-storage-daemon instance on each side. In this case, the
> process that needs to hand over the images isn't even part of the
> migration and can't know when the migration completes. Management tools
> need a way to explicitly inactivate images on the source and activate
> them on the destination.
>=20
> This adds a new blockdev-set-active QMP command that lets the user
> change the status of individual nodes (this is necessary in
> qemu-storage-daemon because it could be serving multiple VMs and only
> one of them migrates at a time). For convenience, operating on all
> devices (like QEMU does automatically during migration) is offered as an
> option, too, and can be used in the context of single VM.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json               | 32 ++++++++++++++++++++++++++++++
>  include/block/block-global-state.h |  3 +++
>  block.c                            | 21 ++++++++++++++++++++
>  blockdev.c                         | 32 ++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WsxZbAqrnnOXe0tJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehEPQACgkQnKSrs4Gr
c8jhvQf/UuTNpiGdjJ3Gv5xI6OairynZPIQX4uJe8vokMYcdkSHoJVOzBqVFjtd+
qGq/QaeJVEkyOQtjVtflh8qUxNbjV/mVsE3vcTfrjaSVuUn2NUgNKP//TLD9JGf/
V9p0bZfHRHfJwdKoYBqg3ATzpnXiYo0MwRq+hGKMuYt+w0tCu2ega+A8PVEtJEvW
Y+StpwgmVZ/a9mZxS7OIEC8123WpiVkkjS8ZPgERpq2WcobQpJuOAMNk48VJJNJX
zJPMLDEosa3OmajqmzEwxCEFd+uc4L306ZKuxSp4vSX+GxcN0n9875ud/J33uJdM
NTDo0nq9zlZnsOhsyLx/ppA231puaw==
=Sj5v
-----END PGP SIGNATURE-----

--WsxZbAqrnnOXe0tJ--


