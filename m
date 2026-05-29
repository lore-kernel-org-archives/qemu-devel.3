Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D127CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 09:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wStt9-0007Fb-Mn; Fri, 29 May 2026 05:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wStt7-0007FG-K2; Fri, 29 May 2026 05:52:21 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wStt5-00046s-5s; Fri, 29 May 2026 05:52:21 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 374AE7A00C2;
 Fri, 29 May 2026 05:52:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 05:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1780048334; x=
 1780134734; bh=oS3CnN5bjhCdVRAOgaVrN3vSOyLa7KFkCbhg9dfB6YI=; b=3
 SUENijVtzRarA4gCcKN/goupOVxzAZ/KWiLmXQAap4dsEWNeuz35W0vTcpVilTA8
 aCCNDQfh4sUwaQtZqgryxi93Xvdw1TTk3w34j1btxkxqk7Al+mRuLxOL+b2lWi1f
 szaO/sgkA+dIeDdrISPLWaAgMosTJGs1cIVmoNTv40Cm5N29LctaSB++ClsGfL3o
 CMeqHoi9oUb3bgz2Gubmg1gdYwpInhAsqlqS8yQ989iKoGbpI+mMTN0dS/erhb7E
 WAu7/gpX5yGCWrOggackgJw1tvU/h08J92a0mTudf//hE3JAlLkFLH0dZPXK0FLK
 ELhABuQWpkzW+sVuuy77A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1780048334; x=1780134734; bh=oS3CnN5bjhCdVRAOgaVrN3vSOyLa7KFkCbh
 g9dfB6YI=; b=jGaERkYtMviP5hsgeIt8i3ce862O6L/bQN8V2G4+O7pSl+8OUOX
 BELCb+0AEZUBJQ36zR4WxTh+wqOX8Jn3wviRobrV6IpWJkaagkw0S8Bt3ed14u4K
 N7a9Dcj2pP/ckY5263zdIuZgvRs22z9h0hAmyEjR41XykQwL+rA91GLntwFHS2kP
 bP3S063yCDJnovJoVRZAmJAZ5RmttLx8ATUeiueWuLweOtJ6AS2YwjdsZO9TGkfO
 veHoZlze7dDckISl8HphcnaRCYWO88DBeHVK1arLZv9/ocOi+GToj7MxMzREhREo
 236OGeWx5LWbuEL8WoLgU+HuLe+S7hV/CIg==
X-ME-Sender: <xms:zWEZal-kipjlLda0mcX2d9S_MjZL7_B_bXdg5WM18uQRs6WVldHAPQ>
 <xme:zWEZakp1efvIm6N6X6rLho6BtjLzED0Fuvq0KPCOaUiJ7mW4eQ6T9TuDniczD6kW8
 UuPuT7zsvoLMMXsTkZOUbdAZA9pzDxONVYDDBFO3WtSv_jCo_7YnII>
X-ME-Received: <xmr:zWEZaiDjV4y-0gpUtBu3g3ryf2wdKlgzEMsXNpuB4XUXk_upusKs1LUsUmXdW6_77Py59PahtZWbiDCNjBzF0M788z2h8kI>
X-ME-Proxy-Cause: dmFkZTEfEuZDCnRHDOOMzwSeDAE4CI4unmPDhWzVpEiB0jPs4WHSONBFYIWe/4viKw2tCp
 ZI7FE61YazB8i0Lwpt+n0dWi8WzFa9Cs9ZxHM+Rl/OZpJoGM+mK7yOUK/J8AdNbtionizj
 R6ypmHJCfBGcKywl3QcF/7zwtZpxwOgypaNCckOB2BRucNC+qHudGLJCCw+SUaO2qUJEiU
 AT1lwsmHPFGvOxGlYXu7pb6uRuZ0Yuh0x13HfV4rz2f4a0NWtED4hyLLs5rhy7BVk/gjS9
 DrUoDh+NLmw3iR+ZVLN1PAnkV6R4iO/KZxQFDkJx11urtVew/7NrGcdTSUEq85OB3b5IIo
 ZcBVL44qgN9gRzuVxvHLbiIqcdPNsASPXYPBanEOvzClV59vB1iOJsDVZ4qy4RQH8kc0Sq
 UnJSwOLm/z32jwL6yRX5VoT0BDTjqxN3t7xM0bu9/6dnUGv+WB1rCNRPFBtLwhOA3jiOeI
 Qi9X3GYQ2RBtHulA8R6qRJ9Ue+S4ydblnB/vdBE+kpyHQuGbIWkdtSea6XV2SssJe8D19e
 jP/KV4wLYyTv7ekzRHnbT0CFiDwObVWUPz+gK241Xyov1vdQIQNj0HJdoItKhfeGdKZkMg
 AwLLlAEn/4KD9Mu4MB84h0LSK/qHgPOfwE+/4hkB2UbmWCvAWpFQZFNGvw1g
X-ME-Proxy: <xmx:zWEZaux4yNc1Jftv3E8LR-Y1FUdUjsi7uB03L0rxsrnHEAxMukAHrQ>
 <xmx:zWEZan1g0wn-d-bIBUGKk1SC7elsaSoirE935mRpfUPriivaXTFNPA>
 <xmx:zWEZamzRm_93TUNLPEL16Cl2ATh5xVAU_fTSVdJJJZ1gFwUU2NhFng>
 <xmx:zWEZamEHxNJf9T4R5RgutNqO9qb1hiBuZ9oROkKRnd-_k6fUJjaPDw>
 <xmx:zmEZaqe94R3bpimI0rVQQss-E-PlSdlF4t_k9G3dMqzCE41c-hHkSndt>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 05:52:13 -0400 (EDT)
Date: Fri, 29 May 2026 11:52:11 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 jaeyeong <fin@spl.team>, qemu-block@nongnu.org,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PATCH] hw/nvme: FDP set FDP events - fixes
Message-ID: <ahlhy1QdldQe-1dg@AALNPWKJENSEN.aal.scsc.local>
References: <20260520-patch-review-20260518131523-654-v1-1-ea64f249177c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wzLc6EUyHB7BXaBr"
Content-Disposition: inline
In-Reply-To: <20260520-patch-review-20260518131523-654-v1-1-ea64f249177c@samsung.com>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--wzLc6EUyHB7BXaBr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 20 09:35, Jesper Devantier wrote:
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
> Addresses an issue reported whereby user-provided event type values
> could trigger two issues:
>=20
>  1. if provided event_type =3D=3D 0xff -> out-of-bounds access
>=20
>  2. if provided event_type > 7 -> generate a value too large for the
>     u8 event mask.
>=20
> This patch fixes (1) by correctly adjusting the length of the look-up
> array to be 256 values.
> This patch fixes (2) by:
>   a. changing the event_type mask to 64bit, matching
>      NvmeRuHandle.event_filter
>   b. Matching the behavior of Get Feature - FDP Events by skipping
>      event type values which we do not support.
>      5.2.26.1.21 of the 2.3 Base specification does not explicitly
>      tell us to reject unsupported event type values.
>   c. Documenting in the event type lookup table, that supporting
>      event types greater than 63 requires refactoring the masking
>      code.
>=20
> Reported-by: jaeyeong <fin@spl.team>
> Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
> ---
> Adresses issues raised by Jaeyeong (thanks!) regarding the
> handling of the user-supplied list of event types to track.
>=20
> As reported, the event mask is much too small to cover the legal
> range of 256 values (0-255) and would fail even for event types
> 0x80 and 0x81 which caused shifts of 32 and 33 places - beyond
> the limit of the u8 event mask.
>=20
> Secondarily, the report also pointed out that unsupported event
> types would cause a lookup in the bit-shift table to return 0,
> meaning unsupported events would effectively toggle the
> tracking of the event type 0x0 (RU not fully written).
>=20
> This patch skips processing of unsupported event types,
> increases the event filter mask size to accommodate currently
> supported event types and documents behavior in the lookup
> table.
>=20
> Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 22 ++++++++++++++++------
>  hw/nvme/nvme.h |  9 ++++++++-
>  2 files changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 815f39173c..d60a680dbc 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6244,10 +6244,6 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCt=
rl *n, NvmeNamespace *ns,
>      for (uint8_t event_type =3D 0; event_type < FDP_EVT_MAX; event_type+=
+) {
>          uint8_t shift =3D nvme_fdp_evf_shifts[event_type];
>          if (!shift && event_type) {
> -            /*
> -             * only first entry (event_type =3D=3D 0) has a shift value =
of 0
> -             * other entries are simply unpopulated.
> -             */
>              continue;
>          }
> =20
> @@ -6492,9 +6488,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtr=
l *n, NvmeNamespace *ns,
>      uint8_t noet =3D (cdw11 >> 16) & 0xff;
>      uint16_t ret, ruhid;
>      uint8_t enable =3D le32_to_cpu(cmd->cdw12) & 0x1;
> -    uint8_t event_mask =3D 0;
> +    uint64_t event_mask =3D 0;
>      unsigned int i;
> -    g_autofree uint8_t *events =3D g_malloc0(noet);
> +    g_autofree uint8_t *events =3D NULL;
>      NvmeRuHandle *ruh =3D NULL;
> =20
>      assert(ns);
> @@ -6507,15 +6503,29 @@ static uint16_t nvme_set_feature_fdp_events(NvmeC=
trl *n, NvmeNamespace *ns,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> +    if (unlikely(noet =3D=3D 0)) {
> +        return NVME_SUCCESS;
> +    }
> +
>      ruhid =3D ns->fdp.phs[ph];
>      ruh =3D &n->subsys->endgrp.fdp.ruhs[ruhid];
> =20
> +    events =3D g_malloc0(noet);
> +
>      ret =3D nvme_h2c(n, events, noet, req);
>      if (ret) {
>          return ret;
>      }
> =20
>      for (i =3D 0; i < noet; i++) {
> +        /*
> +         * We ignore requests to enable tracking of unsupported FDP even=
t types
> +         */
> +        uint8_t event_type =3D events[i];
> +        uint8_t shift =3D nvme_fdp_evf_shifts[event_type];
> +        if (!shift && event_type) {
> +            continue;
> +        }
>          event_mask |=3D (1 << nvme_fdp_evf_shifts[events[i]]);
>      }
> =20
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 5ef3ebee29..9de9f347c5 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -160,7 +160,14 @@ typedef struct NvmeZone {
>  #define NVME_FDP_MAX_NS_RUHS 32u
>  #define FDPVSS 0
> =20
> -static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX] =3D {
> +/*
> + * NOTE: Apart from event type 0, any event type with a shift value of 0=
 is
> + * considered unsupported and thus skipped in get/set features calls.
> + *
> + * NOTE: NvmeRuHandle uses a 64bit event mask - refactor to support even=
t types
> + *       of 63 or greater.
> + */
> +static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX + 1] =3D {
>      /* Host events */
>      [FDP_EVT_RU_NOT_FULLY_WRITTEN]      =3D 0,
>      [FDP_EVT_RU_ATL_EXCEEDED]           =3D 1,
>=20
> ---
> base-commit: 91190a4303223c7971856f6b37f221cc91c62689
> change-id: 20260519-patch-review-20260518131523-654-6799b6319f8e
>=20
> Best regards,
> --=20
> Jesper Wendel Devantier <j.devantier@samsung.com>
>=20
>=20

--wzLc6EUyHB7BXaBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmoZYcgACgkQTeGvMW1P
Demj8gf+J8ZoJAqLKzCbWo0mvbPCFga/NWDaVuec1dA0xBBXHhjl7EAZwMLElPLC
6hfVRAsaplD08g9+DL01PSJFI8lfi1iE8sydirFHIiwk/0Aip/uIKBwrbMvFI33p
vkVFbVNED+2b2CEPFTuS2+/JntHWSnxkyPUl3pkUOLObDFMT7OK3MTOZ8ooxpoxf
At1fnLOK83IIvWGO6qL5NNXLBHmEJaYUkNXVNU7n3ky+miiN5KWOXmPozScXIybp
CIYWCI9jJD4YG2iwGPgQHybQNeI4lkm1z6jY0HJpJe6NG3IZHrGchPGTu8crIUYJ
M0ADiel7am1wTiarw/LQrYXuDQc47A==
=1mVl
-----END PGP SIGNATURE-----

--wzLc6EUyHB7BXaBr--

