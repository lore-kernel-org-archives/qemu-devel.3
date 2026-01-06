Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C5CFD65F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWQg-0007xr-O8; Wed, 07 Jan 2026 11:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdWQA-0007gS-L1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdWQ5-0001uJ-J6
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767803396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPUM7xp70huD4IuUbDkUYYOBKT+O4jmJgBR2AsgrLjE=;
 b=GIRf77LV2WC4FhCAHjfDJpMC0WywE3TF7Zt0GYOr25OjtoGlzBeEBY7TtiX0Fh8EuNppqZ
 Ij40ujMdHNKY1DEbnRCwvy0dINnfQLOkYxYcB1Fx8wFXIaVJwIDSMJCei+0JgYRQo5eyV0
 U4Ca6gp2cra8EDSNaim/sW8GmyIOU8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-eU5LK5EPOieJ8ReMjpi1sA-1; Wed,
 07 Jan 2026 11:29:52 -0500
X-MC-Unique: eU5LK5EPOieJ8ReMjpi1sA-1
X-Mimecast-MFC-AGG-ID: eU5LK5EPOieJ8ReMjpi1sA_1767803391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EACD1956048; Wed,  7 Jan 2026 16:29:51 +0000 (UTC)
Received: from localhost (unknown [10.2.17.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44DC7180009E; Wed,  7 Jan 2026 16:29:50 +0000 (UTC)
Date: Tue, 6 Jan 2026 15:30:18 -0500
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
Message-ID: <20260106203018.GE123256@fedora>
References: <20251222055009.1050567-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9flY5MmdH5labrY"
Content-Disposition: inline
In-Reply-To: <20251222055009.1050567-1-csomani@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--j9flY5MmdH5labrY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 09:50:05PM -0800, Chandan Somani wrote:
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
>      }

Optional cleanup to protect against use-after-free and similar issues:

*arrayptr =3D NULL;
*alenptr =3D 0;

--j9flY5MmdH5labrY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmldcNoACgkQnKSrs4Gr
c8gb6wgAyEkIglCk/yO+5KgEcW6d70AQnJ4wxSj3huiLCVi2DOUeXaCm1uTi676E
7X8B3F4GE35GosrqZDSyYM+DSLxravGf6iTr0p6KS6q8qDvJcLLUxbmNJwaKxUDm
novCP1ki9tu53chW1bux4PkWg8NIEDG9AAxy4EnGsxLYMnENXISUvIMtjDQHKeko
mSATSi3uE7/ZMHZJJ1bMJ05/7L7X+a4J3+Q77y1Xy45MEXmJac3yetbqKd+miVLe
dx/2E0aaZIrPND5o+jKy/QO2kFTwF+WipoWSyjZMWZFB8MhunH8VzK3rlgHVF34b
O/fmR/vt5zcJkb5P6CC9QB/ei9ec2A==
=8a3e
-----END PGP SIGNATURE-----

--j9flY5MmdH5labrY--


