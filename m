Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E0CCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUra1-0003Wn-VN; Wed, 03 Jun 2026 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUra0-0003W8-Cr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUrZy-0008Tw-OJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780516122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpsebosbGVaayGEa6l+F+8dXXiukdvND4Ki8KHMedKE=;
 b=h41E3sm68hb2lUu16j0G7Ze5HwHEnoL4EaesBWWrM6/g4zEXkM1CX87ZOPEEMoJhkwJvFx
 9fluLz8UKJk797xbvESDIPxQii0lFxo/Aq2JxU+mjB8Br0mNM1dIUr0Z8vD7ww5FBamFXo
 Z2rNWi5TaSnA5k6Pf08e/Bd0yDlqVvw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-MeaYMi3hMs6D2LJ0JJCcQA-1; Wed,
 03 Jun 2026 15:48:38 -0400
X-MC-Unique: MeaYMi3hMs6D2LJ0JJCcQA-1
X-Mimecast-MFC-AGG-ID: MeaYMi3hMs6D2LJ0JJCcQA_1780516117
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A0F21956050; Wed,  3 Jun 2026 19:48:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA48830001A7; Wed,  3 Jun 2026 19:48:36 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:41:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 34/38] MAINTAINERS: Drop stale F: from "Linux io_uring"
Message-ID: <20260603164148.GB59214@fedora>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-35-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8yGPvjehQRLlZ0dN"
Content-Disposition: inline
In-Reply-To: <20260603064032.3733394-35-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--8yGPvjehQRLlZ0dN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we dropped stubs/io_uring.c.
> Update it now.
>=20
> Fixes: 047dabef97 (block/io_uring: use aio_add_sqe(), 2025-11-03)
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8yGPvjehQRLlZ0dN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmogWUwACgkQnKSrs4Gr
c8jmEAf/cNXVXCGxun8Z03i4pMljMED6+gLVVKMzDvE+YLkDWxMZVckSIHTBrH0i
rgz7ctOkm5KEp0YgQ0O3gyHIzXsEMaeqaG41Um+5IZmnUy8uadkyoUuUskeKT7dB
J+uF9tYjBzDx0/i7mrbns3ev19zroCAdn6aYTrgwSntG/C2gyiiwzHIJeRIuYfBa
Sk6X9U9dVSaUPpUXy/Uf5kEoyk3/1J8mwblE2VRjxdu3eW84cQdmSqgbwQI6MtQt
mui56Fou8uNgrlGoz+iL6QgUCGMSQ36SMjIUjNYhOEE/Qpyaz8GpGlAc6YKdgrAI
SqGHqO1kd32oUPtndL1ivWNot/pO0w==
=+0z9
-----END PGP SIGNATURE-----

--8yGPvjehQRLlZ0dN--


