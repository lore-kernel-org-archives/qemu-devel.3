Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F87606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm1 header.b=ezOxSeWo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rIT/sJqF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJQN-0006x8-7A; Mon, 26 Oct 2026 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJQD-0006wS-RD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:03:27 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJQ8-0004gt-1z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:03:22 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3AAD27A01C5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:03:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 08:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793016196; x=
 1793102596; bh=SvF+8ZYpjaVC0XYjFpvVb/CDzz30b0ppn2lujJXcQOA=; b=e
 zOxSeWog8bgi2dAfxV/4EV+tF4NPEHSIqc/Og0L5IsFKw65sFai121WVtviD9Y6H
 C6WYqQlBKrh/J1p72rlBqeqa7RxR0nSVbPVc+uTnMOCxOkia4VMjLitQ3FkiQqL8
 vSGsyLqOJWIcFopmkc/7zGdQIMILyaQ1v0UwaQouazGSywePdV9rmutdu7SlksW2
 BHx2rl8sMpoVHF8LXAVMLnB7nWzqNzDaiwKoeREMQkOt8lsmEFMpXIfOqtVEuOam
 oSL/UIE+VrvmAXh+izdBVzZeBKy6LRYwnQXcpkwClCYV6i/sStbVHXKYB4eaW7Zf
 +Iqsl+VVtuXPStMDhr0dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793016196; x=1793102596; bh=SvF+8ZYpjaVC0XYjFpvVb/CDzz30b0ppn2l
 ujJXcQOA=; b=rIT/sJqFlVeei3DW2fEigYHDRgKWYnf+DTc/3g+8cXQnW19ohaJ
 3e+GFo62r6G535xCNGLVZL+KOx9oicUZIF22i7ROn5Bh+3fnc1nuZ+R+TRzUPwr4
 TwX7XF9GiXuRyGBU/5eg3l9n65h2QL/64I/yn3fRWQm0EcH+gAQc+dSruIvJdpwU
 P9qTEegV4mACoDY6oOUsYNy0ylxZKFOyMRK66eCg7dbIaKUDXm2tJBYxZXkJ8JHq
 mbgqTjvu9wcrqcOrxwrvP6Cl05hd6cxgNso3MPtx8KfCeKzObmXzi7XxXI7HdYtA
 aS1pqLdCdQQNL2VTAzxxZZYSVYLq169U8yA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793016196; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:ZoOelggraQWB+qERTb8U5lgwtI0uTw8XkHozLlqRYCUgy81
 dBsk1M8SXO9pgsl/5NDDb4U+yipvhkQKI9w8CzDPJqkLnH1mjQiEVl3JGu8UjTb4
 0SFJlXIjhL6sZy1iKpbZViQpAUkDDPNxqJfH0sCl/tMkqPQanYbbizf1OpdTMEi2
 MOE3C8x1bFurSxTMtLNENCCMlg4lS9dds3eY9EtinWvXJzddLNcIvF+JlGCrOpUE
 0Si/uzWbmMAl99CcSZSJBYGbO1XMeaVl2v1ajiWySdcypzP6Qk9CLp5GzpVYxPQv
 gpGhLjp2YM0uhcmmZoywk7U77z82lccqI+7lEEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:yVnozFzZPQi07ZvO1P2RD097yaYA6bK88eqjmxITdKc=:btXtSpt1q5iPwXIK0vsyVaxnWfPMeoHqaor9ayKhUac=;
X-ME-Sender: <xms:hEHfagqbZfx3F0iibuyLP2sQlXF59-AOYqwSHGJ41guHxSCg9H53mQ>
 <xme:hEHfal0akSnGdNkwS-5QBkVVEmyqwVGLFPgmZs_l66YqW37EixQR3wEGfeQgjgnxP
 GBGbmT88sMx_6tgWyZypCfqJigoVMrsjOJ9JG4kT-6qtPSMIHU0NUWF0A>
X-ME-Received: <xmr:hEHfan4yZcEO0WVbDfBter0JW0KxYCHrA9SnWZOZIZhi9kpGbk0DZrl2udD8>
X-ME-Proxy-Cause: dmFkZTGrV8QQ62CJhkh4FtVr7v/vEB8pFP62TV5hz/9lv7dUQMoN5Exk3GK76aYrAFcaKD
 oVILAMb/qHggC9SzwQHHEZf0Pso0NRQ7M3dlczbjdf4y7qKqncbMToDH/44bjffnIVIWdf
 ssdZkpmk6WkqvKY51my3DfzWMntARk4aCzsPh9aEhf3YX2pn/BSuZXFZB6sH8OsGgBZwOj
 ducWMD0KU9+5hIqOCkxxqE6F6uJDfOx8jov4BRUcWyjReiXnE5EQt8tvomNK+xpUQbCSZF
 FR9m/s6bJbvmY8X128JOYV6kn278xRzJi5hnaGq/j2hKAeOy2mq7h9t+CkmVvoa4XIqojI
 bDCYBCuj3AWoBuhWDRoLzlQRmgmWKY6zgGI5IP8dP3m/r1hhXqAyfuZN2p6I9pAffpRhyM
 HX+2KogxrjAncPn7qDvA5tlfwORK5xw4rQlnxkal9j+u57cEBVZbyvMpgoRvc+m0VG+xG/
 0qUmJ1klXucncgar2L2G9ojKld9tTWpW4lPDLVP/tAcoNciujcFLRQcJ/ZgvsQUriJxSw6
 PplFpV8xMTI6zl6u/8cPMBEIfOT/TULohWrHjbRLXyBvPixYbyyrWwd+Ts0si0NWj8745G
 1BSPtVk4GXB+p1trHccKUqXroMiicMXZYkYO5TqspAfjIspnWROZEGXBsaew
X-ME-Proxy: <xmx:hEHfahTt7NvOwsH4CGaWXaVTAu6f3cbRrK3fs_tfTkIVoDZljgZVkA>
 <xmx:hEHfasUm_5m1NwhTY-IJhkIlQJkpMhM_9S-QaelpDI9XIK8hxaZE0w>
 <xmx:hEHfamEWn6jMuBqGezj4hxCG6MjQoIpYcpyAvu61ZiNQB2DFYtRcBA>
 <xmx:hEHfavd-QqS2HZUbPU5kbuyCDAsphPBSkmVFYUmaz9YLUqQKB5lGVQ>
 <xmx:hEHfavorYNEbYmwmAo3Zw6cdSFhm7ZNZgHmtTQeriyW71kJK8I-Aau57>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 08:03:15 -0400 (EDT)
Date: Mon, 26 Oct 2026 13:03:14 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Message-ID: <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9meNJhmufUKKcH75"
Content-Disposition: inline
In-Reply-To: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--9meNJhmufUKKcH75
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 26 11:11, Daniel Gomez wrote:
> Raise the QEMU NVMe controller's MDTS beyond the 2 MiB cap.
>=20
> Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
> needed the 2 MiB cap because dma_blk_io() submitted the full sglist
> in one preadv()/pwritev() call, which the host kernel rejects when the
> iovec count exceeds IOV_MAX. This series moves the IOV_MAX bound down to
> dma_blk_cb(), where we batch in IOV_MAX chunks when necessary.
>=20
> dma_blk_cb() now breaks its accumulation at IOV_MAX and submits the
> next chunk via the existing re-entry path. With that the DMA-path
> nvme_map_addr() guard and the MDTS cap are removed. The cap stays only
> for CMB/PMR, whose transfers go through a different path and are still
> bounded by IOV_MAX.
>=20
> This series builds cleanly under ubsan with large mdts and passes the
> following fio tests on a 4k LBA QEMU NVMe device:
>=20
> fio \
>     --name=3Dmdts-stress \
>     --filename=3D/mnt/mdts/stress.fio \
>     --rw=3Drandwrite \
>     --bs=3D8M \
>     --ioengine=3Dpsync \
>     --direct=3D0 \
>     --numjobs=3D8 \
>     --time_based \
>     --runtime=3D600 \
>     --fsync=3D8 \
>     --end_fsync=3D1 \
>     --group_reporting \
>     --refill_buffers \
>     --norandommap \
>     --offset_align=3D32k
>=20
> fio --name=3Ddemo --filename=3D/dev/nvme0n1 \
>     --rw=3Dwrite --bs=3D8M --size=3D8M --direct=3D1 \
>     --iomem_align=3D4 --verify=3Dcrc32c --do_verify=3D0
>=20
> fio --name=3Ddemo --filename=3D/dev/nvme0n1 \
>     --rw=3Dwrite --bs=3D8M --size=3D8M --direct=3D1 \
>     --verify=3Dcrc32c --verify_only
>=20
> ---
> Changes in v3:
> - Apply review/ack trailers from Keith and Jesper
> - Drop reproducer in commit message from patch 1 as unrelated
> - Apply nvme_mdts_max_iovs() helper from Jesper
> - Use params local instead of n->params in CMB/PMR check.
> - Update commit message from last patch
> - Link to v2: https://lore.kernel.org/qemu-devel/20260819-align-nvme-mdts=
-with-linux-v2-0-351ac2dfed64@samsung.com
>=20
> Changes in v2:
> - Update cover letter.
> - Rebase on top of nvme.next branch, tree:
> https://gitlab.com/birkelund/qemu
> - Keep the 2 MiB mdts cap for CMB/PMR configurations (Klaus)
> - Fix the `mem` leak reported by Keith
> - Drop NVME_MDTS_MAX, ie. unlimited mdts as long as Linux host supports
> it.
> Allowing larger mdts, also meant we needed to:
> - Clamp the mdts and zasl shifts to stay within uint64_t
> - Cap qemu_iovec_init() to IOV_MAX when the sg list is large
> - Keep IO chunks aligned when chunking at IOV_MAX
> - Fix the wrong bytes being discarded in the discard path
> - Link to v1: https://lore.kernel.org/qemu-devel/20260529-align-nvme-mdts=
-with-linux-v1-0-221d4d21ab43@samsung.com
>=20
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Jesper Devantier <foss@defmacro.it>
> Cc: qemu-block@nongnu.org
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: GOST <gost.dev@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>=20
> ---
> Daniel Gomez (7):
>       dma-helpers: fix unaligned discard_back
>       dma-helpers: ensure IOV_MAX chunks end aligned
>       dma-helpers: cap iovec allocation at IOV_MAX
>       dma-helpers: chunk dma_blk_cb at IOV_MAX
>       hw/nvme: clamp mdts and zasl shifts
>       hw/nvme: drop DMA-path IOV_MAX guard
>       hw/nvme: cap mdts for CMB/PMR-only
>=20
>  hw/nvme/ctrl.c       | 25 +++++++++++++++++--------
>  system/dma-helpers.c | 19 ++++++++++++++++---
>  2 files changed, 33 insertions(+), 11 deletions(-)
> ---
> base-commit: 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5
> change-id: 20260528-align-nvme-mdts-with-linux-67d618f6730b
>=20
> Best regards,
> --=20
> Daniel Gomez <da.gomez@samsung.com>
>=20
>=20

I've been holding out on this because I'd really like an Acked-by from a
Memory API maintainer (system/dma-helpers.c).

--9meNJhmufUKKcH75
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmrfQYIACgkQTeGvMW1P
Del2IAf/YABNyu+yG+5BiAbC5wansZdhDJRNFnMWcTQtA2Bkh1d52X/NnyeHfHz7
8UfIazQeXWJKw6+T3p6Hnv2Dp0SsTZLismwHXfMkCfmlOcX5S1iYNeejXbJPO7vi
8pvSr4GIU5ABnsI0ZZEX17L6AP4KaAjyO2t/wpnq4g6ehvo6lgb1MrBMDzvs/gsK
YLnWoxxD3IlDobNMcSHkMImwz6zTVFtLxcFkEbzxZgy4B8HU0Z83Ze0eNiARmnru
qaYZwBPOK/bYJ49MT/VyNIMUKCT3X7o13DOXhJLDCnEingReEFmda3HCV9BzYFxN
24FXSn/IZdZQyyLPo2TTxXIpBqX+iw==
=DZml
-----END PGP SIGNATURE-----

--9meNJhmufUKKcH75--

