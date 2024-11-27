Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B122D609AD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 08:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGDE0-00088q-Er; Wed, 27 Nov 2024 03:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tGDDx-00087d-Iq; Wed, 27 Nov 2024 03:16:37 -0500
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tGDDv-0005wL-1j; Wed, 27 Nov 2024 03:16:37 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8844C114019A;
 Wed, 27 Nov 2024 03:16:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 27 Nov 2024 03:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1732695391; x=
 1732781791; bh=olMhW4OiO5EykqY+hTKu0JqNsVmaHUE/mCUghmYJToE=; b=C
 J45tWB+AZpyuFfo127BqzdQ1qyjX+V6yPVlA0XekoPkYU/xokH7QlWEO7y69tiDc
 dFxUDpctYSb/6h4BGTx2tNn0ZJWPjkmVh8lNnyQMUVeb2hBtfii+dbGMgCGnAn2Q
 ZlvNAa+iWM1KQPeN/P+buBSqCjzBYZGyJIS4o47D13Ozwjj4yjsSAks6Sn4whJ7e
 UHZXmFI5QCxSALGPZH55jgJmKuxI3RfjexF4ZnT7Xxc+FO77ymsvL3j7AKTqeKkD
 SkG2HSPGDLnr/4Azy5TSFHBdsV+7/TjsJxsnPbHdROciCvnzyvgc6abRsm8h2A7g
 AQSI12SO4ysR2UeHh/csw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1732695391; x=1732781791; bh=olMhW4OiO5EykqY+hTKu0JqNsVmaHUE/mCU
 ghmYJToE=; b=o1ciY1SSZwD1Sp2HhqNIWMAMWS344+Lpzpv0RKpUx5x2ywCiPUp
 dxVp66vJwgr5qY2y0sCw5W1KlAzhhZGg1KsOorze7ObR9feSJ3SJea5F5Z7QKiYE
 zEYEoq1yfb7aVDD1aeKCa0mP9zMBuGgLYdG85PTPGqFZe4yZJphNrw0zirmTZGuI
 /HCP5L3n9qQqnJ/RWpSsRAy4ZivsOK3FI8OabF8rnNJA2Zb11X123AVBF3laGzHr
 sMtnTPivHLZHUCOczoWSHKt4pOoP9KLpCBh1+ZW9hEobUmnWeACyusswmPpwoFGN
 1/nvJ9CSpuA7P2yA+doNvqYaDdYXq72HNKg==
X-ME-Sender: <xms:XdVGZ_1TtsFmuFb_Dktae1ylQ67-bRrVfQ5G3CLdISUmWy-9fxNl-Q>
 <xme:XdVGZ-EsSWUgBguKG3hbT-QuQHv8VuRhtn0ZKg0PWgX6oNHfXKrGQV0O12Lm3GzoA
 -sogfm1G9go5UWKsh4>
X-ME-Received: <xmr:XdVGZ_6ZRlO0tkJ0GmW9UAfvoWbPOYSYaNE3jeMaD0xV6-TtvMP-_mi61J4a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdduudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepieehheevhfeggefhheehfeeugffgkeetkeefueet
 hedvleffffevfffftefhgedunecuffhomhgrihhnpehophgvnhgtohhmphhuthgvrdhorh
 hgpdhnvhhmvgigphhrvghsshdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprh
 gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehssggrthgvshes
 rhgrihhthhhlihhnrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehjrdhgrhgrnhgrughoshesshgrmhhsuhhnghdrtgho
 mhdprhgtphhtthhopehjrghvihgvrhdrghhonhiisehsrghmshhunhhgrdgtohhmpdhrtg
 hpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:XtVGZ00xdWKB1Rm9DJMFrq6sthxq9q_fkC0I6Qr4C7vP9d5iEcLvdw>
 <xmx:XtVGZyHwcKvZqZyYZ9jExjLUloMqe3hFUyLaTUbNvWt74rU2tiV-wA>
 <xmx:XtVGZ1-AJvTR4b97fOVguNvEz3nWpbYw7-LuwfgY44bJndXTkYzHCA>
 <xmx:XtVGZ_mT67fzzDzWflvgdaq-3n3xLwqizONBSobGuTlNeRy-TpKzMQ>
 <xmx:X9VGZwb-5_CMnZqhi5J0xTV_TXW2qd5lBKo7y9ywwhoGJSA_CktCH6mT>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 03:16:29 -0500 (EST)
Date: Wed, 27 Nov 2024 09:16:28 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Stephen Bates <sbates@raithlin.com>
Cc: qemu-devel@nongnu.org, j.granados@samsung.com, javier.gonz@samsung.com,
 qemu-block@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH v1 1/1] hw/nvme: Add OCP SMART / Health Information
 Extended Log Page
Message-ID: <Z0bVROPeF0WCaHsL@AALNPWKJENSEN.aal.scsc.local>
References: <Zz-yyOolT5iWH7E7@snoc-pinewood>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zWoZDql8+tBEu+3J"
Content-Disposition: inline
In-Reply-To: <Zz-yyOolT5iWH7E7@snoc-pinewood>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--zWoZDql8+tBEu+3J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Nov 21 15:23, Stephen Bates wrote:
> The Open Compute Project [1] includes a Datacenter NVMe
> SSD Specification [2]. The most recent version of this specification
> (as of November 2024) is 2.6.1. This specification layers on top of
> the NVM Express specifications [3] to provide additional
> functionality. A key part of of this is the 512 Byte OCP SMART / Health
> Information Extended log page that is defined in Section 4.8.6 of the
> specification.
>=20
> We add a controller argument (ocp) that toggles on/off the SMART log
> extended structure.  To accommodate different vendor specific specificati=
ons
> like OCP, we add a multiplexing function (nvme_vendor_specific_log) which
> will route to the different log functions based on arguments and log ids.
> We only return the OCP extended SMART log when the command is 0xC0 and ocp
> has been turned on in the nvme argumants.
>=20
> Though we add the whole nvme SMART log extended structure, we only popula=
te
> the physical_media_units_{read,written}, log_page_version and
> log_page_uuid.
>=20
> This patch is based on work done by Joel but has been modified enough
> that he requested a co-developed-by tag rather than a signed-off-by.
>=20
> [1]: https://www.opencompute.org/
> [2]: https://www.opencompute.org/documents/datacenter-nvme-ssd-specificat=
ion-v2-6-1-pdf
> [3]: https://nvmexpress.org/specifications/
>=20
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> Co-developed-by: Joel Granados <j.granados@samsung.com>

LGTM, but see a few comments below.

> diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
> index d2b1ca9645..6509b35fcb 100644
> --- a/docs/system/devices/nvme.rst
> +++ b/docs/system/devices/nvme.rst
> @@ -53,6 +53,13 @@ parameters.
>    Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
>    previously used.
> =20
> +``ocp`` (default: ``off``)
> +  The Open Compute Project defines the Datacenter NVMe SSD Specification=
 that
> +  sits on top of NVMe. It describes additional commands and NVMe behavio=
rs
> +  specific for the Datacenter. When this option is ``on`` OCP features s=
uch as
> +  the SMART / Health information extended log become available in the
> +  controller. We emulate version 5 of this log page.
> +

Do you think we would need to differentiate between version of the
specification?

> @@ -5113,6 +5152,23 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint=
8_t csi, uint32_t buf_len,
>      return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
>  }
> =20
> +static uint16_t nvme_vendor_specific_log(NvmeCtrl *n, uint8_t rae,
> +                                         uint32_t buf_len, uint64_t off,
> +                                         NvmeRequest *req, uint8_t lid)
> +{
> +    switch (lid) {
> +    case 0xc0:

Let's do an enum for these log pages.

>  typedef struct NvmeCtrl {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 5298bc4a28..df8e45e396 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1015,6 +1015,40 @@ typedef struct QEMU_PACKED NvmeSmartLog {
>      uint8_t     reserved2[320];
>  } NvmeSmartLog;
> =20
> +typedef struct QEMU_PACKED NvmeSmartLogExtended {
> +    uint64_t    physical_media_units_written[2];
> +    uint64_t    physical_media_units_read[2];
> +    uint64_t    bad_user_blocks;
> +    uint64_t    bad_system_nand_blocks;
> +    uint64_t    xor_recovery_count;
> +    uint64_t    uncorrectable_read_error_count;
> +    uint64_t    soft_ecc_error_count;
> +    uint64_t    end2end_correction_counts;
> +    uint8_t     system_data_percent_used;
> +    uint8_t     refresh_counts[7];
> +    uint64_t    user_data_erase_counts;
> +    uint16_t    thermal_throttling_stat_and_count;
> +    uint16_t    dssd_spec_version[3];
> +    uint64_t    pcie_correctable_error_count;
> +    uint32_t    incomplete_shutdowns;
> +    uint32_t    rsvd116;
> +    uint8_t     percent_free_blocks;
> +    uint8_t     rsvd121[7];
> +    uint16_t    capacity_health;
> +    uint8_t     nvme_errata_ver;
> +    uint8_t     rsvd131[5];
> +    uint64_t    unaligned_io;
> +    uint64_t    security_ver_num;
> +    uint64_t    total_nuse;
> +    uint64_t    plp_start_count[2];
> +    uint64_t    endurance_estimate[2];
> +    uint64_t    pcie_retraining_count;
> +    uint64_t    power_state_change_count;
> +    uint8_t     rsvd208[286];
> +    uint16_t    log_page_version;
> +    uint64_t    log_page_guid[2];
> +} NvmeSmartLogExtended;

Please add a QEMU_BUILD_BUG_ON to check the size.

--zWoZDql8+tBEu+3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmdG1VsACgkQTeGvMW1P
DekwCgf/eLWfe+82LPUF1BA3ODl3euOohonP3Yb4Tk1Abx3/71si4QhwEXxiyqNo
UOj71imOaJ1ztEX+GXeeSTIvX7y5ahHFMfdc43SVS5wqbt9yLYH+NCsf/RzPeOtO
TCHS+vvyXR7uk7qU6CeLzQo/1zW+9c70u+LGMNowAF+ZqHzSNKq4lK9PoxEnm3Sm
YVi0OepcrEEDcyqCk4bfQE+HiVtL4weOIbpZYSo5T3SrhUmdeedUTr0Uny6CnHzB
L5KnuUuROIyhMFdMBSwXo5aPAGmnT9hRI6GCWBcPyDZUCgZUsWyS7wE4r7BCwVID
trtTt1+IO6SaVg3YJ5cg0D/oK6RmYA==
=ee6R
-----END PGP SIGNATURE-----

--zWoZDql8+tBEu+3J--

