Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE02CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUvC-0004ue-K1; Mon, 11 May 2026 14:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUvA-0004sv-GE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUv8-0004Ck-4g
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778522396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERtsniumwKSbi60W6pFWHhCtZPwfSu5kaKXsSqd5AKg=;
 b=bf0gA9rvWdd4EctzXVeCP6TAqLdPww9sfeQUBWp8m22xD/oKHn4xv1M7rE4cm06vaMcNeL
 t841Kq4J7oEfLz9Dc8nRxucHmq+e4Ps3vLoTDwHJKBp3sRjOeQ2Y4oRvzY1wvQNKpdGSi3
 RUMbQx674s1UnkXwnt90aWQ8ucqL22U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-0cg6QHAwPzyHeqyqUy5xhw-1; Mon,
 11 May 2026 13:59:52 -0400
X-MC-Unique: 0cg6QHAwPzyHeqyqUy5xhw-1
X-Mimecast-MFC-AGG-ID: 0cg6QHAwPzyHeqyqUy5xhw_1778522390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 511F41955DE2; Mon, 11 May 2026 17:59:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0D401800465; Mon, 11 May 2026 17:59:46 +0000 (UTC)
Date: Mon, 11 May 2026 13:59:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v7 0/8] hw/nvme: add basic live migration support
Message-ID: <20260511175944.GC536999@fedora>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dlyw/wRC0XpqNivX"
Content-Disposition: inline
In-Reply-To: <20260511151131.483217-1-alexander@mihalicyn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Dlyw/wRC0XpqNivX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 05:11:23PM +0200, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Dear friends,
>=20
> This patchset adds basic live migration support for
> QEMU emulated NVMe device.
>=20
> Implementation has some limitations:
> - only one NVMe namespace is supported
> - SMART counters are not preserved
> - CMB is not supported
> - PMR is not supported
> - SPDM is not supported
> - SR-IOV is not supported
>=20
> I believe this is something I can support in next patchset versions or
> separately on-demand (when usecase appears).
>=20
> Testing.
>=20
> This patch series was manually tested on:
> - Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVM=
e disk
>   (root disk was virtio-scsi):
>=20
> time fio --name=3Dnvme-verify \
>     --filename=3D/dev/nvme0n1 \
>     --size=3D5G \
>     --rw=3Drandwrite \
>     --bs=3D4k \
>     --iodepth=3D16 \
>     --numjobs=3D1 \
>     --direct=3D0 \
>     --ioengine=3Dio_uring \
>     --verify=3Dcrc32c \
>     --verify_fatal=3D1
>=20
> - Windows Server 2022 VM (NVMe drive was a *root* disk) with opened brows=
er
>   playing video.
>=20
> No defects were found.
>=20
> Git tree:
> https://github.com/mihalicyn/qemu/commits/nvme-live-migration
>=20
> Changelog for version 7:
> - rebased on top of recent main
> - addressed review comments from Stefan Hajnoczi:
>   - better incoming migration stream validation (SQ/CQids correctness)
>   - endianness bugs are fixed in qtest (validated on s390x)
> - added RWB tags from Klaus
>=20
> Changelog for version 6:
> - rebased on top of:
>   https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null
>   (see also https://lore.kernel.org/all/20260401202844.673494-1-peterx@re=
dhat.com)
> - addressed review comments from Stefan Hajnoczi:
>   - supported "full CQ" case by serializing NvmeRequest state
>   - added qtest for NVMe device migration with full CQ
>=20
> Changelog for version 5:
> - rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-v=
sementsov@yandex-team.ru/
>   (as Peter has requested)
>=20
> Changelog for version 4:
> - vmstate dynamic array support reworked as suggested by Peter Xu
>   VMS_ARRAY_OF_POINTER_ALLOW_NULL flag was introduced
>   qtests were added
> - NVMe migration blockers were reworked as Klaus has requested earlier
>   Now, instead of having "deny list" approach, we have more strict pattern
>   of NVMe features filtering and it should be harded to break migration w=
hen
>   adding new NVMe features.
>=20
> Changelog for version 3:
> - rebased
> - simple functional test was added (in accordance with Klaus Jensen's rev=
iew comment)
>   $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build
>=20
> Changelog for version 2:
> - full support for AERs (in-flight requests and queued events too)
>=20
> Kind regards,
> Alex
>=20
> Alexander Mikhalitsyn (8):
>   tests/functional/migration: add VM launch/configure hooks
>   hw/nvme: add migration blockers for non-supported cases
>   hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
>   hw/nvme: set CQE.sq_id earlier in nvme_process_sq
>   hw/nvme: unmap req->sg earlier in nvme_enqueue_req_completion
>   hw/nvme: add basic live migration support
>   tests/functional/x86_64: add migration test for NVMe device
>   tests/qtest/nvme-test: add migration test with full CQ
>=20
>  hw/nvme/ctrl.c                                | 1007 ++++++++++++++++-
>  hw/nvme/ns.c                                  |  160 +++
>  hw/nvme/nvme.h                                |   12 +
>  hw/nvme/trace-events                          |   10 +
>  include/block/nvme.h                          |   12 +
>  tests/functional/migration.py                 |   22 +-
>  tests/functional/x86_64/meson.build           |    1 +
>  .../functional/x86_64/test_nvme_migration.py  |  159 +++
>  tests/qtest/nvme-test.c                       |  395 +++++++
>  9 files changed, 1742 insertions(+), 36 deletions(-)
>  create mode 100755 tests/functional/x86_64/test_nvme_migration.py
>=20
> --=20
> 2.47.3
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--Dlyw/wRC0XpqNivX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoCGRAACgkQnKSrs4Gr
c8hkqwf/XDDJ9QIFUD4n1PRh79jPuqpYmwksfapzEUAb4qq7LY4OWiolsJzkdfw1
QHU1Ot19654ppbMcHUpFN0QVOt7OmWRqvRd4rZru6Q94PaqYKuKygdUCToUVI6+8
LMV31YfC0T0xyOVNgKF5yOwlaoPUSkpHG3Zp3VrfmKVlKgpY0BL5spsX1Nusc/Cj
+CZrFhj84BVnzHXiutBOD4Ez6wtK56K6Z0PM6ybKFivF06g3uYv5AmHWrT72hSte
ncwZ8iMzwfnp+dKv5HCx12Eh2sa6DEGe4uPzeZ1lLxMJ1/7BaOZcIx+ct8JyQk/m
zpLdzFO9ldMhF32mWGb6sCmQdMo1/g==
=Ss5J
-----END PGP SIGNATURE-----

--Dlyw/wRC0XpqNivX--


