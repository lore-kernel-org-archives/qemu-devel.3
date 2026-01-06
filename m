Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1723BCFD65E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWQf-0007vU-JN; Wed, 07 Jan 2026 11:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdWQA-0007g9-Ga
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdWQ0-0001rh-Sx
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767803393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I0d7MQXM0Q5fKOKqDa3agwlZubTI8n8wh0onanY0HqA=;
 b=ITWiXHLctaBFwwnDcGm/ih+JZCZGZtEq/eiCExv6oLVol5cg8xPjiT2p6X5ryqhRHSzbOQ
 wOjNjPtfPqamFT+W15oeODFEkkRLEYweKJCBBgBqEo6hbiLjE3je01h/qvXQaqNF/6AJYS
 kduIkv0lgZbUMGaqFf2YXpSbOaDPbM0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-2n82RnB3NXqXWrl6gffllA-1; Wed,
 07 Jan 2026 11:29:50 -0500
X-MC-Unique: 2n82RnB3NXqXWrl6gffllA-1
X-Mimecast-MFC-AGG-ID: 2n82RnB3NXqXWrl6gffllA_1767803388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41B061800365; Wed,  7 Jan 2026 16:29:48 +0000 (UTC)
Received: from localhost (unknown [10.2.17.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 210181956048; Wed,  7 Jan 2026 16:29:47 +0000 (UTC)
Date: Tue, 6 Jan 2026 15:24:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chandan Somani <csomani@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] qdev: Free property array on release
Message-ID: <20260106202418.GD123256@fedora>
References: <20251222055009.1050567-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RIDi9ywGUaD0ukxI"
Content-Disposition: inline
In-Reply-To: <20251222055009.1050567-1-csomani@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--RIDi9ywGUaD0ukxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 09:50:05PM -0800, Chandan Somani wrote:
> Before this patch, users of the property array would free the
> array themselves in their cleanup functions. This causes
> inconsistencies where some users leak the array and some free them.
>=20
> This patch makes it so that the property array's release function
> frees the property array (instead of just its elements). It fixes any
> leaks and requires less code.
>=20
> Signed-off-by: Chandan Somani <csomani@redhat.com>
> ---
>  block/accounting.c                |  1 -
>  hw/core/qdev-properties.c         | 20 ++++++++++----------
>  hw/input/stellaris_gamepad.c      |  8 --------
>  hw/intc/arm_gicv3_common.c        |  8 --------
>  hw/intc/rx_icu.c                  |  8 --------
>  hw/misc/arm_sysctl.c              |  2 --
>  hw/misc/mps2-scc.c                |  8 --------
>  hw/net/rocker/rocker.c            |  1 -
>  hw/nvram/xlnx-efuse.c             |  8 --------
>  hw/nvram/xlnx-versal-efuse-ctrl.c |  8 --------
>  10 files changed, 10 insertions(+), 62 deletions(-)

Missing hw/virtio/virtio-iommu-pci.c?

The following DEFINE_PROP_ARRAY() users unintentionally leak their
arrays and are fixed by this patch (I think it's worth mentioning this
in the commit description):
- hw/display/apple-gfx-mmio.m
- hw/display/apple-gfx-pci.m
- hw/net/virtio-net.c
- hw/riscv/riscv_hart.c

> @@ -686,14 +684,16 @@ static void release_prop_array(Object *obj, const c=
har *name, void *opaque)
>      char *elem =3D *arrayptr;
>      int i;
> =20
> -    if (!prop->arrayinfo->release) {
> -        return;
> +    if (prop->arrayinfo->release) {
> +        for (i =3D 0; i < *alenptr; i++) {
> +            Property elem_prop =3D array_elem_prop(obj, prop, name, elem=
);
> +            prop->arrayinfo->release(obj, NULL, &elem_prop);
> +            elem +=3D prop->arrayfieldsize;
> +        }
>      }
> =20
> -    for (i =3D 0; i < *alenptr; i++) {
> -        Property elem_prop =3D array_elem_prop(obj, prop, name, elem);
> -        prop->arrayinfo->release(obj, NULL, &elem_prop);
> -        elem +=3D prop->arrayfieldsize;
> +    if (*arrayptr) {
> +        g_free(*arrayptr);

It is safe to call g_free(NULL), so if (*arrayptr) is unnecessary.

--RIDi9ywGUaD0ukxI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmldb3IACgkQnKSrs4Gr
c8jFPgf9GLUOSNgiPP6cCvoCjHC2Fz82w0AKejoigDo7j8OU//i974CKyRWm62Y4
6chEmIK4QRczxuRBhU5tgNviJY6ayW458iE1DbqI8JYjUnY1JfDZvfUL0WD/xwTU
AzsGF96C5F+9mW8w9CJxJ71l9ssASLDM4ebGNBcez+0xCR8V/aOwpR1r6hDn5PWe
mI0HYBsddUDztGghql1pYHAOnaohTaOnEdExh5aQZaxS/V6aJz9+TUrWkIyysLKn
CzoIh0alUumYhqTJ/uT7Zu6AGcj6shclDTflvAUl9/rh1UkO8RvvVOfCdvCHs6FJ
d4VArCirUgV5htdw1scHHQ8Jjq+gSQ==
=eOs0
-----END PGP SIGNATURE-----

--RIDi9ywGUaD0ukxI--


