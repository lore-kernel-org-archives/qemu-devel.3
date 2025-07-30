Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D9EC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCYa-0000m2-J9; Wed, 30 Jul 2025 15:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhASq-0000p0-RR
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhASo-0003o6-Ma
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753895977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXWvDRpUq2SU3YiauxSzzr7PQmKce+bLyrCHVoWk/HU=;
 b=Qp1Clj8Bg77s9ZnaCXcFM/RhcB/kIQEsB1UJacmtCNQsgA1LAxNvU4K/5ihLetAK37CFJQ
 ha/jlhAo6zSdBygpC+WzeK3k4SwmpLUel0vBmbO410K2IJrgXdCjmVDBYcvIK949MNCUif
 ScXetJLyF4aXMCFOf4Une7blP9HW8EA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-JDJ9buQ1O-uTsvCzcq_hSg-1; Wed,
 30 Jul 2025 13:19:33 -0400
X-MC-Unique: JDJ9buQ1O-uTsvCzcq_hSg-1
X-Mimecast-MFC-AGG-ID: JDJ9buQ1O-uTsvCzcq_hSg_1753895972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 854141800447; Wed, 30 Jul 2025 17:19:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.197])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2EE3300018D; Wed, 30 Jul 2025 17:19:31 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:19:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 00/21] export/fuse: Use coroutines and multi-threading
Message-ID: <20250730171930.GE74304@fedora>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3dl+UcANUx8vxxhw"
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--3dl+UcANUx8vxxhw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:44:16PM +0200, Hanna Czenczek wrote:
> Hi,
>=20
> This series:
> - Fixes some bugs/minor inconveniences,
> - Removes libfuse from the request processing path,
> - Make the FUSE export use coroutines for request handling,
> - Introduces multi-threading into the FUSE export.
>=20
> More detail on the v1 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html
>=20
> v2 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-06/msg00040.html
>=20
>=20
> Changes from v2:
> - Patch 12: Moved qemu_fcntl_addfl() into the #ifndef _WIN32 section
>   where other fcntl() wrappers reside
> - Patch 13: Fixed comment to say `export` instead of `exp`; kept
>   Stefan=E2=80=99s R-b
> - Patch 15: Same as patch 13
> - Patch 18: In macro, use correct parameter `queue` instead of the
>   non-existing `q`
>=20
>=20
> git-backport-diff from v2:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/21:[----] [--] 'fuse: Copy write buffer content before polling'
> 002/21:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
> 003/21:[----] [--] 'fuse: Remove superfluous empty line'
> 004/21:[----] [--] 'fuse: Explicitly set inode ID to 1'
> 005/21:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
> 006/21:[----] [--] 'fuse: Fix mount options'
> 007/21:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
> 008/21:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
> 009/21:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
> 010/21:[----] [--] 'fuse: Add halted flag'
> 011/21:[----] [--] 'fuse: Rename length to blk_len in fuse_write()'
> 012/21:[----] [-C] 'block: Move qemu_fcntl_addfl() into osdep.c'
> 013/21:[0008] [FC] 'fuse: Manually process requests (without libfuse)'
> 014/21:[----] [--] 'fuse: Reduce max read size'
> 015/21:[0008] [FC] 'fuse: Process requests in coroutines'
> 016/21:[----] [--] 'block/export: Add multi-threading interface'
> 017/21:[----] [--] 'iotests/307: Test multi-thread export interface'
> 018/21:[0016] [FC] 'fuse: Implement multi-threading'
> 019/21:[----] [--] 'qapi/block-export: Document FUSE's multi-threading'
> 020/21:[----] [--] 'iotests/308: Add multi-threading sanity test'
> 021/21:[----] [--] 'fuse: Increase MAX_WRITE_SIZE with a second buffer'
>=20
>=20
> Hanna Czenczek (21):
>   fuse: Copy write buffer content before polling
>   fuse: Ensure init clean-up even with error_fatal
>   fuse: Remove superfluous empty line
>   fuse: Explicitly set inode ID to 1
>   fuse: Change setup_... to mount_fuse_export()
>   fuse: Fix mount options
>   fuse: Set direct_io and parallel_direct_writes
>   fuse: Introduce fuse_{at,de}tach_handlers()
>   fuse: Introduce fuse_{inc,dec}_in_flight()
>   fuse: Add halted flag
>   fuse: Rename length to blk_len in fuse_write()
>   block: Move qemu_fcntl_addfl() into osdep.c
>   fuse: Manually process requests (without libfuse)
>   fuse: Reduce max read size
>   fuse: Process requests in coroutines
>   block/export: Add multi-threading interface
>   iotests/307: Test multi-thread export interface
>   fuse: Implement multi-threading
>   qapi/block-export: Document FUSE's multi-threading
>   iotests/308: Add multi-threading sanity test
>   fuse: Increase MAX_WRITE_SIZE with a second buffer
>=20
>  qapi/block-export.json               |   39 +-
>  include/block/export.h               |   12 +-
>  include/qemu/osdep.h                 |    1 +
>  block/export/export.c                |   48 +-
>  block/export/fuse.c                  | 1181 ++++++++++++++++++++------
>  block/export/vduse-blk.c             |    7 +
>  block/export/vhost-user-blk-server.c |    8 +
>  block/file-posix.c                   |   17 +-
>  nbd/server.c                         |    6 +
>  util/osdep.c                         |   18 +
>  tests/qemu-iotests/307               |   47 +
>  tests/qemu-iotests/307.out           |   18 +
>  tests/qemu-iotests/308               |   55 +-
>  tests/qemu-iotests/308.out           |   61 +-
>  14 files changed, 1213 insertions(+), 305 deletions(-)
>=20
> --=20
> 2.49.0
>=20

Nice!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3dl+UcANUx8vxxhw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiKVCIACgkQnKSrs4Gr
c8gTeAf9FzRMBwvJvBousqwV0wFe+TZO+TMtEXxGJ46VzP+APZaAUaT1Zw/pR+Lk
U7+Utrx3L31HI76azXvEfFQUyjP5uPKeIrT4xQc830Ya0yvt1BbC3qK4jPr/fWBx
PlfhwS5v+PzeyJn3O4EyRJA+cy2yp1nGZzGdpESzKE6k6Y5/HTTqXPsaJ7+mp83x
FVS0IhKSjUb6BIEPQmglp/OgbaU1GHHwTHVJvsgt6Ow0L6NsY5Gvm9ihb8uQMFXF
9xpyFICVboIVhIyoc/pgwBnatlcoGhQVyvL8OGy0cHxSqhXG5qm1ZocITj76t1gX
X9Qr4FqAySCShHripsnxdNFq/p0X5g==
=Z1bU
-----END PGP SIGNATURE-----

--3dl+UcANUx8vxxhw--


