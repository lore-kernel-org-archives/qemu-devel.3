Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1002C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41dK-0002kC-UX; Tue, 08 Sep 2026 15:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x41dK-0002k2-5I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x41dI-0005MZ-0E
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788896246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PlNATPs/mNkqoX/CDLK2bQgCTH0IiXUqOR4XH+3FPA8=;
 b=SQ6ib09Y/OZA9HtHqXqjj9o+506D4RCXbW357uzuxPM83duOtof3JLQzF3M1sfBhqrxH9E
 9uoj9ilF7C22jX1RsNJPyK297zakFEMt8Wo2NHcguJxYBrhvPtO+H7r+FGVTwEAA/+cL5+
 PFVx2cfOvWU4GUsvY8x6Bhnow/pF4e0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-SHMlK7qINFCA0lfRHMqlmw-1; Tue,
 08 Sep 2026 15:37:24 -0400
X-MC-Unique: SHMlK7qINFCA0lfRHMqlmw-1
X-Mimecast-MFC-AGG-ID: SHMlK7qINFCA0lfRHMqlmw_1788896243
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F56B195396C; Tue,  8 Sep 2026 19:37:23 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 835921955F0E; Tue,  8 Sep 2026 19:37:21 +0000 (UTC)
Date: Tue, 8 Sep 2026 15:37:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-scsi: set dataplane_started to false upon failure
Message-ID: <20260908193720.GA16472@fedora>
References: <20260825154854.263819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f1ccJ9zOQ0bXqvn9"
Content-Disposition: inline
In-Reply-To: <20260825154854.263819-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--f1ccJ9zOQ0bXqvn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:48:54AM -0400, Stefan Hajnoczi wrote:
> Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
> dataplane_started to true when virtio_scsi_dataplane_start() fails. This
> is likely a typo since dataplane is not functional after failure.
>=20
> The non-ioeventfd fallback is broken because dataplane_started is true
> after virtio_scsi_dataplane_start() failure. As a result, the following
> assertion failure occurs when a virtio-scsi device exceeds the open file
> descriptor ulimit when setting up notifiers (eventfds):
>=20
>   $ ulimit -n 104 # exact number can vary based on QEMU version
>   $ qemu-system-x86_64 -M q35,accel=3Dkvm -m 1G -cpu host -smp 14 \
>          --blockdev file,node-name=3Ddrive0,filename=3Dtest.img,cache.dir=
ect=3Don,aio=3Dnative \
>          --blockdev file,node-name=3Ddrive1,filename=3Ddata01.img,cache.d=
irect=3Don,aio=3Dnative \
>          --device virtio-scsi-pci,id=3Dvirtio-scsi-pci0 \
>          --device scsi-hd,drive=3Ddrive0,bus=3Dvirtio-scsi-pci0.0 \
>          --device virtio-scsi-pci,id=3Dvirtio-scsi-pci1 \
>          --device scsi-hd,drive=3Ddrive1,bus=3Dvirtio-scsi-pci1.0
>   qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel k=
vm is set.
>   qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower=
).
>   qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: A=
ssertion `!s->dataplane_started' failed.
>   Aborted                    (core dumped)
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Ping

Paolo: Can you take this through your SCSI tree? Thanks!

Stefan

> Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
> Buglink: https://redhat.atlassian.net/browse/RHEL-193328
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/scsi/virtio-scsi-dataplane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-datapl=
ane.c
> index 95f13fb7c28..bcb6e441335 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -230,7 +230,7 @@ fail_host_notifiers:
>  fail_guest_notifiers:
>      s->dataplane_fenced =3D true;
>      s->dataplane_starting =3D false;
> -    s->dataplane_started =3D true;
> +    s->dataplane_started =3D false;
>      return -ENOSYS;
>  }
> =20
> --=20
> 2.55.0
>=20
>=20

--f1ccJ9zOQ0bXqvn9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqgY/AACgkQnKSrs4Gr
c8gc8QgAnSgIoERG2sB/aD2KwA+kdvzp24O3OmKrR58fApdcCngSgHAx+yCqWY2F
b65nL7F0aZgL19mEGIpYencZd3stQtvwDvqV7wUcgYlUQby3rxroiWvJPtWxO1hP
hzYLGAWmz2xAhGsKt3pQauA8dA1Ng/eogc9oNfm5I6OEkvZOvKYsavch8bPLinmZ
hA7DxiRV38liUWkGaLHS3K5GB2GruHGba8SPlxuAjpo/S08/uyKJNBVkcDT+SLnA
yuE2pF34oLN0S0KxfBRy3o6zjHJjooWUPncO5+d9odmqQYPOzyq+xQOpJnmd7KI4
mM+VONx0W6rPTpegbbsVNAPQ7aJOcQ==
=sC0r
-----END PGP SIGNATURE-----

--f1ccJ9zOQ0bXqvn9--


