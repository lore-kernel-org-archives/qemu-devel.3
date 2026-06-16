Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1082CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSvb-0001JW-5S; Tue, 16 Jun 2026 08:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZSvY-0001I4-Fm; Tue, 16 Jun 2026 08:30:00 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZSvW-0005Lt-Gl; Tue, 16 Jun 2026 08:30:00 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 1BB491D00111;
 Tue, 16 Jun 2026 08:29:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 16 Jun 2026 08:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1781612996; x=
 1781699396; bh=uKx+TFDvtUVn6y3jJ4jPFX73HxQ3uhoYINvNlmgo0z8=; b=P
 9LHQ26/vrZqyl0i7GYiOIgtb6O8LVYF71Ar0Wrvpe9toYrSELGtcmHmFkNkBi8GU
 fRPCbtLj6OVXNY+DJdZ0AEC+bbABsM5wUeXf7d7b0AZqNEa71fPJ30YxO1lLxqvb
 6lGFq/RAcF3XASjRw9wSBnTeJhY1zkJBq7JhHC7RXOwtUvX1I6V46a/vLcbwUy69
 V3zKqlHnFqUPOYpI4x1SFfnBs4kiLAUSlVehU+O/V+b5w0uPxkSKRooIsdtZ9E9x
 2IAKzSsBQOMrDyEUSybvrj/D2CTNLD96jRFdmSQszgZLErCZ4xwccRHgC+wB6ERD
 snmjAx8+oS1aoaxJdgyIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781612996; x=1781699396; bh=uKx+TFDvtUVn6y3jJ4jPFX73HxQ3uhoYINv
 Nlmgo0z8=; b=Q3IHCLEsCCH2uooFg1amMuy8RBUdhCRaA1zQkOTcD6deDkOotGT
 gwTBB9bhV7tNLHK3rvmSazpxF0ZNgHtSXExYZD2sbTFpqfsgBaoQaD3pTwhGbLVj
 +mvTUJgAVVv2tDW7kD65B5Z0X7A5Nu2eKvflxKRou31p4tFmRmQw61SyWWouY2AV
 zAAQjiiPiO25y16Wy57cWsJ7KEuhvaKT4L+X+HA33SzAtPN3zur+XfpMJ35TG802
 hxrBRKHEl4sqSBm5yl8cwikYxJTRbLJGbS2q22y4WXrOvPwOXBkDvD0Tl/Dp6r2z
 l6QZbQjvSRXTLz/kaHIGegwxV8Y33B2hVjw==
X-ME-Sender: <xms:xEExavyAv3lhuy5T0TfSlJjVGeIO4K4dpLGjluWRjhJ8er-y4A1sgw>
 <xme:xEExaoPR9JBGPOr4aADwv7P75o-lifHBJCfXPE9zi-tBRd5Jw4eWi42w76iUrfzCM
 O2XYdLRuYGHSutNTj4EcPnaOabNoHaU6s_Ulu8NHjKwKM5tHcdBwHI>
X-ME-Received: <xmr:xEExaprs6UmSDAriDUNjPcHIldWNe2GApU1qwGjAsEtW4dyX8eDbc1HNoHJOEw>
X-ME-Proxy-Cause: dmFkZTEXsbztzjiblT+O/KEPJcrurjsa6fOi5mjopzjNx8TJAGwCdn9GGmoHvvComho8Ze
 FHpBfzzLytKBHPixNsMJIVUcsu3BBFcunZ7eCtXRztmSxxBArFq1T06hVeWRn/8hslgqbq
 jjDNqtYef86Nz4bfpcPE2US8uilwegS8IvYDfye+ZACNcCWML7fDpwm2ZZGIVrsAEi8JP6
 Isw9UxvUYfd7GvVIBiObF1APweDX2EdT1o9f8k8BVsLQpBt4Rap4rXWOJNrIJiGDA1Rq98
 nril3e49Ma0s866Kgle5nYGkJxdu1eH91fmrDRu+BxMAmHUkmL28gtsEp0P6/n8Ci7DXjb
 miHkW4gV0N7Mm2WCJO4rPQaBlEr5yIvMH2GPMtD7f+RgXKj8xZDuaHU7Uk15yBby+0zw0H
 n67ENRLnbWyoQsXg0Bf9ilIQptNUj3xA/viL7nebSb1/K4rstMmkhAdgls3C4MvkYBD20j
 aLR4nBFbnIQtWXKoMp61QaAhOcgkdCSzN430oAeOtTgJn74bR+GTKmjbPKUzdXSc+IVUuc
 lYeRBdNDiEaUKQ0uc8WGULXELbyNwk69tCjNnYfZZ8UCma5B313naAO1vS0WqS5568yDtM
 KUnK4RTB1HoZbHTwbphw9w021CRIeKHUcgcH/Yn7h5LhGoQvl2lxHoh4NDHQ
X-ME-Proxy: <xmx:xEExan_jpfq282VJ_vdXsLwHUHrw8q1MYKsYwDBxI_C14SDa5OIDQQ>
 <xmx:xEExan2ZD1j3GVDmttnIr28VmV7PtQLEnIoIuRaJ93BqRPP58zBhHQ>
 <xmx:xEExaiBnC7F-NjlJtc_-J-5EUBF6pvl8PevchKksh7TMBznt3HPlOg>
 <xmx:xEExauBE4zSixzqa7EA2hz3y1Vg7x-IV0eJ5uN1Vgr8vbC3wCH6d3w>
 <xmx:xEExas4psJl1rZ8Xui2rCY63f5wldOf1YzvMQ_8GcxGBvnWzWQOd3gAr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 08:29:55 -0400 (EDT)
Date: Tue, 16 Jun 2026 14:29:55 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v10 0/8] hw/nvme: add basic live migration support
Message-ID: <ajFBw3dIFz_FFPuK@AALNPWKJENSEN.aal.scsc.local>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QL0RGe7Owf0p7zOt"
Content-Disposition: inline
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
Received-SPF: pass client-ip=202.12.124.146; envelope-from=its@irrelevant.dk;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--QL0RGe7Owf0p7zOt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alex,

Thanks for pushing through on this!

Applied to nvme.next!


Thanks,
Klaus

On Jun 11 20:08, Alexander Mikhalitsyn wrote:
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
> https://gitlab.com/mihalicyn/qemu/-/commits/nvme-live-migration
>=20
> Changelog for version 10:
> - build fix on Alpine Linux (PAGE_SIZE macro redefinition)
> - clang build fix [ thanks to Fabiano ]
> - format specifier change from %lx to 0x% PRIx64 in qtest (fix for win64 =
cross build)
> - I run the entire testsuite, (almost) all green now
>   https://gitlab.com/mihalicyn/qemu/-/pipelines/2594705360
>   all the failures I can see look unrelated to this patchset
> - I kept all RWB/ACK-tags in place (hope it is fine as all changes were t=
rivial)
>=20
> Changelog for version 9:
> - many trivial check-patch fixes here and there
> - disabled qtest on ppc64 (spapr bus) by adding qpci_check_buggy_msi() ch=
eck
>   [ we had a private discussion with Klaus and he told me that ppc64
>     tests are failing after debugging I found this old patch which wasn't=
 merged
>     for some reason https://lore.kernel.org/qemu-devel/20250502030446.883=
10-5-npiggin@gmail.com/ ]
> - I kept all RWB/ACK-tags in place (hope it is fine, cause really I hasn'=
t changed too much)
> - QEMU CI tests results https://gitlab.com/mihalicyn/qemu/-/pipelines/259=
3676152
>=20
> Changelog for version 8:
> - rebased
> - added Acked-by from Stefan
> - added RWB tag from Klaus
> - added RWB tag from Peter
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
>  MAINTAINERS                                   |    1 +
>  hw/nvme/ctrl.c                                | 1036 ++++++++++++++++-
>  hw/nvme/ns.c                                  |  164 +++
>  hw/nvme/nvme.h                                |   12 +
>  hw/nvme/trace-events                          |   10 +
>  include/block/nvme.h                          |   12 +
>  tests/functional/migration.py                 |   23 +-
>  tests/functional/x86_64/meson.build           |    1 +
>  .../functional/x86_64/test_nvme_migration.py  |  172 +++
>  tests/qtest/nvme-test.c                       |  419 +++++++
>  10 files changed, 1814 insertions(+), 36 deletions(-)
>  create mode 100755 tests/functional/x86_64/test_nvme_migration.py
>=20
> --=20
> 2.47.3
>=20
>=20

--QL0RGe7Owf0p7zOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmoxQcIACgkQTeGvMW1P
DemWPwf9Fg1hb/9SCgxPMF4vTIJFgRc89fpG2erPu4zZZCP4a+FE2Hh6Tjr08P6h
fwyzD7dWbqy49Mgj9QHz5twlkmq5DHVp+iC0MRvXF7BT/BDQApkTA7JNyOh2QIAw
wd1cqN5iiTOb7o+j6JzKqNnQOkrELtxN9qinq4JLNr2b2b5RqX16ZTCe96okPHht
+HDLhDfkfuf2Mo/Asa173BGsDPXwtuLFPaM7ks7rRzezoF9v2ApPRZTMN2BKhiHB
bftleryMKhKFz3N2ew8qA1MCGmTOi6drxNWId5GoauKG3qPx4KLU072O+lE7OYKV
3DjrJ51vQmeiHFNfCE5S7lQtz+pCNQ==
=q9Gk
-----END PGP SIGNATURE-----

--QL0RGe7Owf0p7zOt--

