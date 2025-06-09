Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA46C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOh0m-0005BO-35; Mon, 09 Jun 2025 14:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOh0k-0005BC-Pu
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOh0i-00028Z-OW
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749492855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8zGJXuFZ6AeHQN6dAqilQUq3X9rwtX2jadrmCZ1d9vg=;
 b=irY9yfofk5a6MRIKItc0YyGEGMbfXqZnANwYd2BPzG2t8U9iNX/HEr7EIXbzooEsMpXxw8
 D/rWpj6EoqN0UIheUh4M9uW1o8nsSQ6yWdDoLDQsUmBsBbPAD1KaHHv9B8P/OB9TedPXwy
 4VNxIOQxQh5Chaa6pPdOVNRxJpAzgsA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-znHvV--aND6QGcJ-Qusklw-1; Mon,
 09 Jun 2025 14:14:13 -0400
X-MC-Unique: znHvV--aND6QGcJ-Qusklw-1
X-Mimecast-MFC-AGG-ID: znHvV--aND6QGcJ-Qusklw_1749492852
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B41819560B1; Mon,  9 Jun 2025 18:14:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E36C6195608D; Mon,  9 Jun 2025 18:14:11 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:14:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 00/21] export/fuse: Use coroutines and multi-threading
Message-ID: <20250609181410.GL29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q2DlW5LuS1CwSake"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--q2DlW5LuS1CwSake
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:27:52PM +0200, Hanna Czenczek wrote:
> Hi,
>=20
> This series:
> - Fixes some bugs/minor inconveniences,
> - Removes libfuse from the request processing path,
> - Make the FUSE export use coroutines for request handling,
> - Introduces multi-threading into the FUSE export.
>=20
> More detail on the v1 cover letter:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html
>=20
>=20
> Changes from v1:
> - Patch 1: Clarified =E2=80=9Cpolling=E2=80=9D to be `aio_poll()`
> - Patch 11 (new): Pulled out from patch 13 (prev. 11)
> - Patch 12 (new): Suggested by Eric
> - Patch 13 (prev. 11):
>   - Drop false polling handlers
>   - Use qemu_fcntl_addfl() instead of fcntl(F_SETFL) to keep
>     pre-existing FD flags
>   - Add a note that the buffer returned by read needs to be freed via
>     qemu_vfree()
>   - Pulled out a variable rename into the new patch 11
> - Patch 15 (prev. 13):
>   - Simplified the co_read_from_fuse_fd() interface thanks to no longer
>     needing to support poll handlers
>   - Increment in-flight counter before entering the coroutine to make it
>     more obvious how tihs ensures that the export pointer remains valid
>     throughout
> - Patch 16 (new): Add a common multi-threading interface for exports
>   instead of a specific one just for FUSE
> - Patch 17 (new): Test cases for this new interface
> - Patch 18 (prev. 14):
>   - Drop the contrasting with virtio-blk from the commit message;
>     explaining the interface is no longer necessary now that it=E2=80=99s
>     introduced separately in patch 16.
>   - Generally, the interface definition is removed in favor of the new
>     one in patch 16.
>   - Some rebase conflicts (due to other changes earlier in this series).
> - Patch 19 (new): Stefan suggested adding an explicit note for users on
>   how multi-threading behaves with FUSE, not least because in the future
>   this behavior may depend on the specific implementation features
>   chosen (io-uring or not).  Because the actual multi-thread interface
>   is now on the common export options, it is no longer obvious where to
>   put this implementation note; I decided to put it into the general
>   description of the FUSE export options, inside of this dedicated
>   patch.
> - Patch 20 (new): Simple sanity test for FUSE multi-threading (just test
>   that e.g. nothing crashes when running qemu-img bench on top)
> - Patch 21 (prev. 15): Rebase conflict due to the changes in patch 15;
>   kept Stefan=E2=80=99s R-b anyway
>=20
>=20
> Review notes/suggestions I deliberately did not follow in v2:
> - Stefan suggested to make patch 1 simpler and more robust by allocating
>   a new buffer for each request.  This is indeed a simple change (for
>   patch 1) that I wouldn=E2=80=99t mind, and that I also started to imple=
ment.
>   However, eventually I decided against it:
>   The problem doesn=E2=80=99t disappear with the rest of the series, it
>   basically stays the exact same; though instead of an implicit
>   aio_poll() leading to nested polling, it turns into an implicit
>   coroutine yield doing pretty much the same.
>   For performance, it is better not to allocate a new buffer for each
>   request; we only really need a bounce buffer for writes, as there is
>   no other case where we=E2=80=99d continue to read the request buffer af=
ter
>   yielding.  Therefore, the final state I would like to have after this
>   series is to use a common request buffer for all requests on a single
>   queue, only using a bounce buffer for writes.
>   With that, I think it=E2=80=99s better to implement exactly that right =
=66rom
>   the start, rather than introducing a new intermediate state.
>=20
>=20
> git-backport-diff from v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/21:[0012] [FC] 'fuse: Copy write buffer content before polling'
> 002/21:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
> 003/21:[----] [--] 'fuse: Remove superfluous empty line'
> 004/21:[----] [--] 'fuse: Explicitly set inode ID to 1'
> 005/21:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
> 006/21:[----] [--] 'fuse: Fix mount options'
> 007/21:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
> 008/21:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
> 009/21:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
> 010/21:[----] [--] 'fuse: Add halted flag'
> 011/21:[down] 'fuse: Rename length to blk_len in fuse_write()'
> 012/21:[down] 'block: Move qemu_fcntl_addfl() into osdep.c'
> 013/21:[0077] [FC] 'fuse: Manually process requests (without libfuse)'
> 014/21:[----] [--] 'fuse: Reduce max read size'
> 015/21:[0061] [FC] 'fuse: Process requests in coroutines'
> 016/21:[down] 'block/export: Add multi-threading interface'
> 017/21:[down] 'iotests/307: Test multi-thread export interface'
> 018/21:[0077] [FC] 'fuse: Implement multi-threading'
> 019/21:[down] 'qapi/block-export: Document FUSE's multi-threading'
> 020/21:[down] 'iotests/308: Add multi-threading sanity test'
> 021/21:[0002] [FC] 'fuse: Increase MAX_WRITE_SIZE with a second buffer'
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

Nice, looks like there are some goodies in here that Brian can use in
his FUSE-over-io_uring project, like the new iothread=3D['iothread0',
'iothread1', ...] syntax for specifying multiple IOThreads.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--q2DlW5LuS1CwSake
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHJHIACgkQnKSrs4Gr
c8jk/gf9H9jPUsyGSvCPTv7K1pJbGfzOQ2dv+2Lc7Gm3KKjVFW+7vEeL/50gbxZ4
aHZtL+V7U4GhgFbrlU+CJL4WA5qg4ra4lO7Gz6TW0IOj8zXCVhUh1sgDgyEOSCfD
TWwhnoWTzTui+MXp+P+fx92gIT3RNGXs0a1lTXsqGyZQeOmsGcKr6O16WpruaN+v
mjfhasYFTDnCorXDYxCLxIBK4NDi1r5A5VHe0M4ZiEyC9xFgIrBftU09ONlQdY61
IMKi+KqP1Ha3tWrdVvsiixBGEWM2yhAC+6T8h+siaYcDEZy54P4xdxA8GTuhIphE
uFBeBDVLP2rmrLzC8Wn45Rcini9K0A==
=frzO
-----END PGP SIGNATURE-----

--q2DlW5LuS1CwSake--


