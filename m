Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048C5C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 15:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfhQz-00015y-Lx; Wed, 05 Feb 2025 10:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tfhQq-000156-7Y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tfhQo-0006Gq-AK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738769709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9PGMmVHgz4e4A7MlZj5upbHL3epFCgZSyYX0Gyl6HQ=;
 b=bp4YF3gkteftDf5OfdZPa/7M7vKku+lKzA3fgnewhHnxGeYMnlvj1pX7yfcNmmtv2H4onq
 m02JFy3Y6f4IGXeGfsaVUDCU1Ln30oOjGEDj2M6GdjpEbNuNBLE7+bsY42t94Qn5+osnOo
 52T26QtOVbuQ26C3uDaW1QUp+2ou36A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-SN3rtYn5NYu7lXOYxeBdCg-1; Wed,
 05 Feb 2025 10:35:07 -0500
X-MC-Unique: SN3rtYn5NYu7lXOYxeBdCg-1
X-Mimecast-MFC-AGG-ID: SN3rtYn5NYu7lXOYxeBdCg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC8221800875; Wed,  5 Feb 2025 15:35:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC41A1800358; Wed,  5 Feb 2025 15:35:03 +0000 (UTC)
Date: Wed, 5 Feb 2025 10:35:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/16] block: Managing inactive nodes (QSD migration)
Message-ID: <20250205153502.GA361641@fedora>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0VRgsb5VLfSzfLfy"
Content-Disposition: inline
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
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


--0VRgsb5VLfSzfLfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 10:13:51PM +0100, Kevin Wolf wrote:
> This series adds a mechanism that allows the user or management tool to
> manually activate and inactivate block nodes instead of fully relying on
> the automatic management in the migration code.
>=20
> One case where this is needed is for migration with shared storage and
> devices backed by qemu-storage-daemon, which as an external process is
> not involved in the VM migration. Management tools can manually
> orchestrate the handover in this scenario. The new qemu-iotests case
> qsd-migrate demonstrates this.
>=20
> There are other cases without qemu-storage-daemon where manual
> management is necessary. For example, after migration, the destination
> VM only activates images on 'cont', but after migrating a paused VM, the
> user may want to perform operations on a block node while the VM is
> still paused.
>=20
> This series adds support for block exports on an inactive node (needed
> for shared storage migration with qemu-storage-daemon) only to NBD.
> Adding it to other export types will be done in a future series.
>=20
> v3:
> - Moved bdrv_is_inactive() to patch 1 to fix the build [Fabiano]
> - Patch 5 ('block: Allow inactivating already inactive nodes') has
>   become patch 2 to fix the logical ordering [Eric]
> - Patch 8: Fixed typo in the documentation [Eric]
> - Patch 10: Fixed typo in the commit message [Stefan]
> - Added Patch 11: Drain nodes for setting inactive flag [Stefan]
> - Patch 14: Test reading inactive images from both sides [Eric]
> - Patch 16: Fix typo in a comment [Eric]
>=20
> v2:
> - Added a comprehensive test case that tests how inactive nodes
>   interoperate with many operations
> - Added a couple of fixes for bugs uncovered by the tests (that would
>   usually lead to crashes when an unsupported operation is performed on
>   inactive nodes)
> - Added 'active' status to query-block information
>=20
> Kevin Wolf (16):
>   block: Add 'active' field to BlockDeviceInfo
>   block: Allow inactivating already inactive nodes
>   block: Inactivate external snapshot overlays when necessary
>   migration/block-active: Remove global active flag
>   block: Don't attach inactive child to active node
>   block: Fix crash on block_resize on inactive node
>   block: Add option to create inactive nodes
>   block: Add blockdev-set-active QMP command
>   block: Support inactive nodes in blk_insert_bs()
>   block/export: Don't ignore image activation error in blk_exp_add()
>   block: Drain nodes before inactivating them
>   block/export: Add option to allow export of inactive nodes
>   nbd/server: Support inactive nodes
>   iotests: Add filter_qtest()
>   iotests: Add qsd-migrate case
>   iotests: Add (NBD-based) tests for inactive nodes
>=20
>  qapi/block-core.json                          |  44 ++-
>  qapi/block-export.json                        |  10 +-
>  include/block/block-common.h                  |   1 +
>  include/block/block-global-state.h            |   6 +
>  include/block/export.h                        |   3 +
>  migration/migration.h                         |   3 -
>  block.c                                       |  64 +++-
>  block/block-backend.c                         |  16 +-
>  block/export/export.c                         |  29 +-
>  block/monitor/block-hmp-cmds.c                |   5 +-
>  block/qapi.c                                  |   1 +
>  blockdev.c                                    |  48 +++
>  migration/block-active.c                      |  46 ---
>  migration/migration.c                         |   8 -
>  nbd/server.c                                  |  17 +
>  tests/qemu-iotests/iotests.py                 |   8 +
>  tests/qemu-iotests/041                        |   4 +-
>  tests/qemu-iotests/165                        |   4 +-
>  tests/qemu-iotests/184.out                    |   2 +
>  tests/qemu-iotests/191.out                    |  16 +
>  tests/qemu-iotests/273.out                    |   5 +
>  tests/qemu-iotests/tests/copy-before-write    |   3 +-
>  tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
>  .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
>  tests/qemu-iotests/tests/migrate-bitmaps-test |   7 +-
>  tests/qemu-iotests/tests/qsd-migrate          | 140 ++++++++
>  tests/qemu-iotests/tests/qsd-migrate.out      |  59 ++++
>  27 files changed, 1004 insertions(+), 87 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
>  create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
>  create mode 100755 tests/qemu-iotests/tests/qsd-migrate
>  create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out
>=20
> --=20
> 2.48.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0VRgsb5VLfSzfLfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmejhSYACgkQnKSrs4Gr
c8iOggf+OEh+qFZjj6AAtw/5wA9eob8yXJEPDXnAE7ILfdF1b2+q7GacMxVHc8n9
T5pV8Ugpipx8b0weeHMxS6bM8ZgUYEEqyLcFizHoHYuNVYVM/cD1LrYp41lXE7Kp
wMJBEh2L7jGabRIRB1seR8mH42kmkXtnWXiUYpIQ+Rt57tsGDZmMvUaXcSZ8Goy6
wdMyN/J1jedzq3GXmyJRYYpQ5mkUYSZtFRaEFJVTWBcZqVWlrlR9GFGJkcmOpaMc
oJBuKg4Ep6pe0Y8fJM8kavWJaUH9VXV+dgX/MoE9JG618Bp5iclHvkAC3DUEPmZz
LIbKAssSJHW3SLTfBZiNK2Qp/qixIg==
=Jukq
-----END PGP SIGNATURE-----

--0VRgsb5VLfSzfLfy--


