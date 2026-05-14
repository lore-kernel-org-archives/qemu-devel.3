Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA7CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNb6B-00042C-Eu; Thu, 14 May 2026 14:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNb68-00041X-M3
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNb66-00060D-By
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778784467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZJmOeQsC071mapwrrdbWZRAS65akymoSHYffPxYsn8=;
 b=N96NTImHUtqwmqUFGuIDfQt1accoEPtYfWTfFC60y4Uz0OR5kKigXJRbC+RoBugVz14sIc
 AmZrblXq8J2QOFIks6ua5EHSKQN8+CohdXE9bMCxzv3T9W4QBdOH8CpudKzgiXsOM7F1kf
 kZREoslx4TM+pceyRfXWesJAS3BIsCE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-hBs6Hh3IPEyvN1a5NgKtxw-1; Thu,
 14 May 2026 14:47:46 -0400
X-MC-Unique: hBs6Hh3IPEyvN1a5NgKtxw-1
X-Mimecast-MFC-AGG-ID: hBs6Hh3IPEyvN1a5NgKtxw_1778784465
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 971CD1956070; Thu, 14 May 2026 18:47:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 844771956053; Thu, 14 May 2026 18:47:43 +0000 (UTC)
Date: Thu, 14 May 2026 14:47:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 1/4] docs/qcow2: add the zoned format feature
Message-ID: <20260514184742.GB1535937@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Z/2vIya+qw6fpfR"
Content-Disposition: inline
In-Reply-To: <20260510175059.311814-2-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--4Z/2vIya+qw6fpfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 07:50:56PM +0200, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver.
> The qcow2 file then can emulate real zoned devices, either passed
> through by virtio-blk device or NVMe ZNS drive to the guest
> given zoned information.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 42 ++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bl=
ock-drivers.rst.inc
> index 384e95ba76..5066c943d5 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -172,6 +172,48 @@ This section describes each format and the options t=
hat are supported for it.
>      filename`` to check if the NOCOW flag is set or not (Capital 'C' is
>      NOCOW flag).
> =20
> +  .. option:: zone.mode
> +    If this is set to ``host-managed``, the image is an emulated zoned
> +    block device. This option is only valid to emulated zoned device fil=
es.
> +
> +  .. option:: zone.size
> +
> +    The size of a zone in bytes. The device is divided into zones of this
> +    size with the exception of the last zone, which may be smaller.

This option is required when zone.mode=3Dhost-managed?

It would be useful to indicate whether each option listed here is
required or has a default value when absent.

> +
> +  .. option:: zone.capacity
> +
> +    The initial capacity value, in bytes, for all zones. The capacity mu=
st
> +    be less than or equal to zone size. If the last zone is smaller, then
> +    its capacity is capped.
> +
> +    The zone capacity is per zone and may be different between zones in =
real
> +    devices. QCow2 sets all zones to the same capacity.

This defaults to zone.size?

> +
> +  .. option:: zone.conventional_zones
> +
> +    The number of conventional zones of the zoned device.

This defaults to (size + size.size - 1) / zone.size?

> +
> +  .. option:: zone.max_active_zones
> +
> +    The limit of the zones with implicit open, explicit open or closed s=
tate.
> +
> +    The max active zones must be less or equal to the number of SWR
> +    (sequential write required) zones of the device.

This defaults to (size + size.size - 1) / zone.size?

> +
> +  .. option:: zone.max_open_zones
> +
> +    The maximal allowed open zones. The max open zones must not be large=
r than
> +    the max active zones.
> +
> +    If the limits of open zones or active zones are equal to the number =
of
> +    SWR zones, then it is the same as having no limits.

This defaults to max_active_zones?

> +  .. option:: zone.max_append_bytes
> +
> +    The number of bytes in a zone append request that can be issued to t=
he
> +    device. It must be 512-byte aligned and less than the zone capacity.

Is there a default?

> +
>  .. program:: image-formats
>  .. option:: qed
> =20
> --=20
> 2.43.0
>=20

--4Z/2vIya+qw6fpfR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoGGM4ACgkQnKSrs4Gr
c8jPFwgAqiGHlzEIw3cHZo+rKOv4L4A4lEAHsHkvaFTu9bRloYqsA8mmYrGLD3X0
d/8g7Fmpm8W9ojMI1hoQ4JOfShUe9mfT3UHqettXP6tET4qp6QNdhz3ZYaDuB7j6
AzzaNi0jRzOm9GFxkTRUWXhSEQAiJmsGg2JF2peaw4Bhp0rgugIZhGZS8q1o+4rl
KtWprfp++JWGa793cU8RwEQWjOFxL5Rx0lxOIumeLZ1F5eRw7e/Oobh72OfIzSvc
IPOl3uIlmEUVTw4PTIY/Ij85/8o3Tcy9XvQ9PcsLDOB2+9sUuDX/QBV4ZHVAwgtq
UtE5Xmivy504jSNqKsZ33Ek5PTFMmQ==
=xwf5
-----END PGP SIGNATURE-----

--4Z/2vIya+qw6fpfR--


