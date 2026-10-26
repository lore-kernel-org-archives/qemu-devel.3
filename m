Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976D606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm1 header.b=cp2+NuWN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bnNJm7J+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJHj-0004TN-3e; Mon, 26 Oct 2026 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJHf-0004Sk-T5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:54:35 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xLJHd-0003NW-IC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:54:35 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5C31E14009F2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 07:54:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 07:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793015672; x=
 1793102072; bh=bliULwMeKkYSvRlz4LUMaMgEDV6UOCvkhYpuaerp2HI=; b=c
 p2+NuWNnPGrtyvA0eBJ88Fug+UzdWURQZ9OtDUi6P/GCl96BpS8GwyHRc0t+oegx
 PrrdfjWo1PJB5LU5/5+GDtiRYnRL39A3qV2jay6DjQ/XEyVJwzfqu7ssbWB7IPnW
 FgVhlUzekvsKGSV0KHXPrB2lFfC+C1Fn7wEJL8+y7V1z7xMpzkARPBhZcImK9xAs
 4I/a7jh4naEx0LnEWdh0w1KDxAMF/jcO8zK6oyoGnc4qsfWSWpMwYCwyo9kZ3Pn8
 MsE6mZJu62fqjxRhQEcgZfBAp5+6LH0lsT9i5GQnYg1i+EVDT+D10zF+cGIbUY4y
 OvyX/d7MoGQ5g31Xy0dTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793015672; x=1793102072; bh=bliULwMeKkYSvRlz4LUMaMgEDV6UOCvkhYp
 uaerp2HI=; b=bnNJm7J+IZ4BPztXLfuv051pWuq+QCooIMkoeEp4iL45XrEfsdm
 xNulUkDbNQvHQ+B9uZmSX2F6+34m4Cz0awBf4nbLsVIzvTaVIGUk6orEUhh+MZte
 tOOPPfrgA4yqV1CxnZAPzxMQ5PjTEX4pLgPVt0bzr32FAMAR8/oYJKsjQP2nL2NP
 DephJhywV6IflztGJl78C9KmSfGzY5PNJluyI5gEL80Klm3GlaaSiG7JZh4nM4L5
 vSX+fxu5C9urv8D2Z1cb2CMQmiIXrfK5Yy5dCodeXfE3YDPHA31+WkIIG8WONAl8
 3mrZIoNorUOwLgByy4mOyWjjMWWMz0IhwWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015672; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:jdQzURYnqwn1jXTjBRavGWhuBh/zF0RPA4lMjS1PI+xZ/y8
 tCkEOPqqLXqaoG+hePe3/6RlrKsVld8JwjoMNJ1+0vM+2g3cOz4SvAwoXSxkZyZ/
 S+gfh04KbWjRgeFed3rn7wetkShAwW80lgA2S/1eQ1o2Pr8u/1U/kvkPVt/9hbXL
 eY3+8QlxVdah1H0CCKSIupHpdZksml6Lhw4NlX6SQPJ+5mxGFqEuvVPGx7Dyew2h
 7uAeNf4pfUWWsOQAl43uk/OKIXuWWyWVThnoNG71gk73EDwHz/EMqa12t7unCUJw
 xgHO1i+W158vCiPYvLDBY+31oqSURAG77PddbnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:9w06iVSZPQjosFyYn3uYv3LSQSjdYv4wpag4arJIPSs=:tysue5mySB4b0JqBSQHy8rkV93gDLAAqKbsDNxeb9IU=;
X-ME-Sender: <xms:dz_faoa1wESwxnfaxZYzl2rOPy0tX_QHQeqk-ushK37Eq3V1ehei7Q>
 <xme:dz_favarY9WGK4dkZvBlza3KpngV4AevN03RyzkkRLUL5eDv1loQHGf7gSN8RHoXw
 GocQvzdLZoco8EfufCxyDQdkt4zjucLXRS53n0KN8fewBX1aEeGePI>
X-ME-Received: <xmr:dz_falKMesUcLOoGEoC744Q5Qr2X4PLV2micIempi2-48HCyFkGLnAbNukqFxw>
X-ME-Proxy-Cause: dmFkZTGa4oJsC7hSe7QZNhXaSOAYy4Bf6YrgNG1swlvBtip5N8Q4PDuFKxeQsxrRrprTEH
 E5SfcOZqnzBnjwrMwTZ3QsSq6SXxRImpHaDC2xZ9aJyObPdjPqBSOmuSWSF7R7o7pOaulx
 y+dAzKuwE/G6pbnMw1T38tcL6QyuSwvFbiXjAGC5P0AWnBB4C7wOvgOfrjriIzKes4aNmW
 ZmM61rdgnlkJzLpeAfXhS1uDJZslbUJX5s/TVTguT6ujCnojUka+BoimJxog7iNa0DoF96
 v5BAVDoNARMi8QFDd5lOY1d1cIk3Jo8YNnkIFp5ykfItplXpyrtVRgsX/sRILETUIeosKl
 CWLt/Nc2aPvd9x457wH4YcloyG4nagMtNb4ceSd9Q8dnUbQpDacSrIgnuinP+ADtY8hjA/
 iRIDK7QgZrVC1qvZGqOvForczXcsy6LJB4CF7jDKihL5ZrtW5eWDWmBTdKHEWpdbG6dBO8
 6ZGryKgexYJ+t65tLyrhSmWmmb8QkpFi10yw5P7bQEb31xgAmxSe7U2pDc53aXYrLYKZM0
 dzNkAwKe6gSrYXcTZy2vfbsOOqGnKV4MtrhrfG/AO22vpf0JPbjBtmpFmMSvHlb0W0ARuC
 4yNSbf0sOmLJySKCOxCU9rqaoHQ+u8Z+GN9Wm4SbreTgomyEZIconQ630kvQ
X-ME-Proxy: <xmx:dz_fajtLi9m2DAgbGhxTM8JG4fk24SX-i3vlkZv-B02VrbVpVPS5ew>
 <xmx:dz_fahXfZ9E3Skj9IXexk-beqW8BFBuMCI720XIsLkQlA3mCLx6-vg>
 <xmx:dz_famiPj2YZ_BMynecANc7fAdP6RCpzdpMyRlQOKAE7DUl_QI-iKQ>
 <xmx:dz_fahqvV4sY-BUR7qqmX4vigIFUssiq7E22i5FpVxfkmnBmKiIZIQ>
 <xmx:eD_fau-rPbuugcAtOGVsmR16G1sY7ZcpQEi4UqLg46qaGtCXCTbDIirE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:54:31 -0400 (EDT)
Date: Mon, 26 Oct 2026 12:54:30 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH RESEND 0/5] Add Multiple Atomicity Mode (MAM) support
Message-ID: <at8_c-gf2CsyY5Ha@AALNPWKJENSEN.aal.scsc.local>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bsiUH64KB2b+06NK"
Content-Disposition: inline
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-a6-smtp.messagingengine.com
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

--bsiUH64KB2b+06NK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 26 11:13, Daniel Gomez wrote:
> Add Multiple Atomicity Mode (MAM) emulation support. MAM is a superset
> of Single Atomicity Mode (SAM): per the NVMe spec, a write command that
> crosses a Namespace Atomic Boundary is divided into LBA subranges, each
> written atomically. The emulation reuses the atomic write support from
> commit ebd1568fc732 ("hw/nvme: add atomic write support"): when MAM is
> enabled, the size and boundary limits that decide whether a write is
> atomic no longer apply, so the whole command is serialized as one atomic
> write.
>=20
> A namespace enables it with atomic.map=3Don alongside
> the existing per-namespace atomicity parameters. Example:
>=20
>     -device nvme,serial=3Dfoo,id=3Dnvme0 \
>     -drive file=3Dnvme0.qcow2,if=3Dnone,format=3Dqcow2,id=3Dnvme0-ns0 \
>     -device nvme-ns,drive=3Dnvme0-ns0,bus=3Dnvme0,atomic.nawun=3D7,\
>       atomic.nawupf=3D7,atomic.nabsn=3D7,atomic.nabspf=3D7,atomic.mam=3Don
>=20
> Quering the result with nvme-cli:
> nvme id-ns -H /dev/nvme0n1 | head
> NVME Identify Namespace 1:
> nsze    : 0x500000      Total size in logical blocks
> ncap    : 0x500000      Maximum size in logical blocks
> nuse    : 0x500000      Current size in logical blocks
> nsfeat  : 0x76
>   [7:7] : 0     NPRG, NPRA and NORS are Not Supported
>   [6:6] : 0x1   Multiple Atomicity Mode applies to write operations
>=20
> While at it, fix endianness issues on the atomic write command path
> (first patch) and update hw/nvme docs with atomic writes section.
>=20
> Baseline: nvme.next branch; tree: https://gitlab.com/birkelund/qemu
>=20
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
> Daniel Gomez (5):
>       hw/nvme: fix endianness handling in the atomic write path
>       hw/nvme: add missing atomic.* fields in usage
>       docs: add hw/nvme atomics section
>       hw/nvme: add multiple atomicity mode support
>       docs: update hw/nvme atomics with mam
>=20
>  docs/system/devices/nvme.rst | 47 ++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/nvme/ctrl.c               | 40 +++++++++++++++++++++++--------------
>  hw/nvme/ns.c                 | 27 ++++++++++++++++++++++++-
>  hw/nvme/nvme.h               |  1 +
>  4 files changed, 97 insertions(+), 18 deletions(-)
> ---
> base-commit: 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5
> change-id: 20260824-nvme-mam-3af8616d6e37
>=20
> Best regards,
> --=20
> Daniel Gomez <da.gomez@samsung.com>
>=20
>=20

--bsiUH64KB2b+06NK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmrfP3MACgkQTeGvMW1P
Delcogf/V+QvMENwcgMC2gNO3U8tfx07PXnxhCytEe78v07QjLQVC7jonhw8MiUi
QN6UGWZwLrFsRPWC1k917NoSyT7VAgFttqkBh4UGR8d8JA8kNwkfHPwKZOd/x8Dk
bgUfxh/YGx1azWrQL6fSoENHnast2Rd/sJwqrnPE94Cpgta+LXEpSayCEyukO+BF
2vcmVO22KBbToeLY+vyinKfK7a18Ztua4pJVsoBfChrt+vFedTEYMO8H8B/rXDsS
EiyFmiGy5vGkKD9D45V7pcppuQGIy3GnnpPCxppHDJD3dO33efZR3gqDvIVKuacC
3OzE7aw1IkYNpuG+h/l7eePkQi5W9w==
=34LK
-----END PGP SIGNATURE-----

--bsiUH64KB2b+06NK--

