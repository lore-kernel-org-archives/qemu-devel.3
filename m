Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF33C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 19:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU9F3-00079A-HI; Tue, 24 Jun 2025 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU9F1-00078x-Uf
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU9Ez-0001Za-SS
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750793011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtojxKi41nyKFFaz7gbM2bfOj1ptuj6n7SL6VUc9QA0=;
 b=L1yDVVtBYE6Yi32xGY2xV5U57IFTf7mVzo5rO5btnumTr+9mxgxGUfqoGOErMxdpVZ8Vp2
 bckDdWk3AtdzejGHaptK6xyuoV4BjTWK6JTU9r6ORNauvS+PaVrN0/vmDv8GxyXOvMQPBi
 HJlnBvt12rNvsObFS6fH48SURx1FFXQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-VhYVvMCXMIihP5TutYTwqQ-1; Tue,
 24 Jun 2025 15:23:27 -0400
X-MC-Unique: VhYVvMCXMIihP5TutYTwqQ-1
X-Mimecast-MFC-AGG-ID: VhYVvMCXMIihP5TutYTwqQ_1750793006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D150719560A5; Tue, 24 Jun 2025 19:23:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A796F18003FC; Tue, 24 Jun 2025 19:23:24 +0000 (UTC)
Date: Tue, 24 Jun 2025 15:23:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 stevensd@chromium.org, hi@alyssa.is,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 4/7] vhost_user: Add frontend get_shmem_config command
Message-ID: <20250624192323.GB19307@fedora>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DFvGo3/qslGvz039"
Content-Disposition: inline
In-Reply-To: <20250609144729.884027-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--DFvGo3/qslGvz039
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 04:47:26PM +0200, Albert Esteve wrote:
> The frontend can use this command to retrieve
> VirtIO Shared Memory Regions configuration from
> the backend. The response contains the number of
> shared memory regions, their size, and shmid.
>=20
> This is useful when the frontend is unaware of
> specific backend type and configuration,
> for example, in the `vhost-user-device` case.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c            | 43 +++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h | 10 +++++++
>  include/hw/virtio/vhost-user.h    |  1 +
>  include/hw/virtio/virtio.h        |  2 ++
>  4 files changed, 56 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DFvGo3/qslGvz039
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha+ysACgkQnKSrs4Gr
c8jowwf/fxnutAZIYNQNf1qab1VQeWx9WBstxHHapp7CBYf2/EVaRnQISFTTUNLT
bkpH2IOD0WWczJq5nNxc3aHJGQ6gJis/vNbI+PpeouXP1pXOh5lNIK/wgKe9Nula
gHkCaNVGmfrMrVa2yBzykpnZFciZ+DtgvMb/1Em310JOCsoy0pVYEVXIF6+XY5Hg
zaN4eB9ILtUa8h4RZc4w79xT+WNnG1oZ0ITu+6uF8H1s5jcSnam+qRadEQmXKthn
fDmFTi9yoR2bDgIG38pICY1FoCCecbUrzHUGFngrXpPMmxHR0JW8XLGuCfHEn2tz
tK57Mz6V0JagwXSRkmvsr3zI12qD5w==
=QEaI
-----END PGP SIGNATURE-----

--DFvGo3/qslGvz039--


