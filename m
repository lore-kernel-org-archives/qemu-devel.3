Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B083C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKiG-0006S8-WF; Tue, 18 Feb 2025 05:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKi9-0006Rd-FV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKi5-0007D0-Eg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739874007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXQJmYQK11EfjSZwsIP9gHrFqRUM4HkPSSKDS1AtAsc=;
 b=RQfqbGdiFgMREV2h/3n3tPM7PFk3Py39oH7LJ1zXPzgf/i39NZN1bgg6gDU1R9yq4OQkNL
 8qqavStKp2SfhuKA3dnog746gszw5+LzOWOYh5v823ouZMk/0SiWXYPD8R19Hg3KAL5dOI
 LG66HRyci4JFwo8MV1Evbd3z3pqiCMY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-ep_07aMIMTmDGNrdqIlEGQ-1; Tue,
 18 Feb 2025 05:20:03 -0500
X-MC-Unique: ep_07aMIMTmDGNrdqIlEGQ-1
X-Mimecast-MFC-AGG-ID: ep_07aMIMTmDGNrdqIlEGQ_1739874002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C58371800879; Tue, 18 Feb 2025 10:20:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AC331955BD4; Tue, 18 Feb 2025 10:19:59 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:19:57 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 1/9] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20250218101957.GG10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hdzd0184wa0JZKBe"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--Hdzd0184wa0JZKBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:04PM +0100, Albert Esteve wrote:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce37..47d0ddb820 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3063,6 +3063,75 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev)
> +{
> +    ++vdev->n_shmem_regions;
> +    vdev->shmem_list =3D g_renew(VirtSharedMemory, vdev->shmem_list,
> +                               vdev->n_shmem_regions);
> +    vdev->shmem_list[vdev->n_shmem_regions - 1].mr =3D g_new0(MemoryRegi=
on, 1);
> +    QTAILQ_INIT(&vdev->shmem_list[vdev->n_shmem_regions - 1].mmaps);
> +    return &vdev->shmem_list[vdev->n_shmem_regions - 1];
> +}

On second thought, it would be easier to change shmem_list's type to
VirtSharedMemory** and g_renew(VirtSharedMemory*, ...). That way the
array approach can be kept without worrying about reallocating the
VirtSharedMemory structs themselves. Only the array of pointers is
reallocated.

Stefan

--Hdzd0184wa0JZKBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0XswACgkQnKSrs4Gr
c8hVAwf7Bc6FGpBWsNrIQw7eYdvaCsHIigp9yRzb6v3elwxW5NksCwQiiAeWrBNo
teEqtY/IWOsz3VMAbOiUNPWPeslNgFIfDyD+6t3wuA5JFiQw/1Rk3EsTmhvTUHrn
7Rygycp46e23tKFXfSMY/NDEY+2dQMhcWVjEK6dpSHWigp3NgRsENDY7cVkP3OHt
IfS5BSCE1xsOyqAocFlyyAf8ljmK7zaIYsqg+X5HqQNOrHCgrndqwgKg5uUzRThp
QFUYF9ALM49SeiDvRE7AH3CxTLryvUaGghEicIZzYwIuCHEi+45uabMcBPPexeRQ
a5nkU/W+q9Kn0ChmOmH7gTH1wvrItg==
=EVoH
-----END PGP SIGNATURE-----

--Hdzd0184wa0JZKBe--


