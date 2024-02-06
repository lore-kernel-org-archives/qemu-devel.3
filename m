Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833AFC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 18:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQMd-0001Tr-0p; Tue, 06 Feb 2024 13:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQMZ-0001TJ-6U
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 13:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQMV-00049J-Sv
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 13:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707244802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G74dM3H4Xk7RodEG3GyYM3V8KytwHj3oMSJhSR0hXDQ=;
 b=dgvYn5s0EOif+MoBchDSCiLlYVU3CYA7pt5wguZ7ngwGYkjTt6o6yGVzL3ZuXhlRVoACAl
 aa8JIwA6xy3Cg8NY5SJRavxljoCK5mnwZL0Ts/2o4WkGIV5V8Wc02XhQWcsZv4jz1FKOKi
 1Mi1BEsYAoLWQiIpMAtkXGX/fJM5Fj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-lG-Qb6hxMAOrBtpqbF-jUA-1; Tue, 06 Feb 2024 13:40:00 -0500
X-MC-Unique: lG-Qb6hxMAOrBtpqbF-jUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4353101FA2C;
 Tue,  6 Feb 2024 18:39:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D092C0FDCB;
 Tue,  6 Feb 2024 18:39:58 +0000 (UTC)
Date: Tue, 6 Feb 2024 13:39:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 0/3] virtio: Re-enable notifications after drain
Message-ID: <20240206183957.GE66397@fedora>
References: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OVggj7Yg2H2CVuep"
Content-Disposition: inline
In-Reply-To: <20240202153158.788922-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--OVggj7Yg2H2CVuep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 04:31:55PM +0100, Hanna Czenczek wrote:
> v1:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2024-01/msg00336.html
>=20
>=20
> Hi,
>=20
> This is basically the same series as v1: When using
> aio_set_event_notifier_poll(), the io_poll_end() callback is only
> invoked when polling ends, not when the notifier is being removed while
> in a polling section.  This can leave the virtqueue notifier disabled
> during drained sections, which however is not a bad thing.  We just need
> to ensure they are re-enabled after the drain, and kick the virtqueue
> once to pick up all the requests that came in during the drained
> section.
>=20
> Patch 1 is a technically unrelated fix, but addresses a problem that
> became visible with patch 2 applied.
>=20
> Patch 3 is a small (optional) clean-up patch.
>=20
>=20
> v2:
> - Changed the title of this series and patch 2 (was: "Keep notifications
>   disabled durin drain"): Keeping the notifier disabled was something
>   the initial RFC did, this version (v1 too) just ensures the notifier
>   is enabled after the drain, regardless of its state before.
>=20
> - Use event_notifier_set() instead of virtio_queue_notify() in patch 2
>=20
> - Added patch 3
>=20
>=20
> Hanna Czenczek (3):
>   virtio-scsi: Attach event vq notifier with no_poll
>   virtio: Re-enable notifications after drain
>   virtio-blk: Use ioeventfd_attach in start_ioeventfd
>=20
>  include/block/aio.h   |  7 ++++++-
>  hw/block/virtio-blk.c | 21 ++++++++++-----------
>  hw/scsi/virtio-scsi.c |  7 ++++++-
>  hw/virtio/virtio.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.43.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OVggj7Yg2H2CVuep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCfP0ACgkQnKSrs4Gr
c8geeQgAvXuGz7ZlWurHBJp4as/DJELijVFxQ30a3I9uN/ZWO+8L26iG2LXZL7rG
Mf331MoIqza5jSMM22WUohKJ99dq5a06ECLinEbRlhIDAL0ryR9jglA8lRN8e6Rt
TIUFrB07PpY9mjtf1Aj9GGqeF+7lWdBoiSlGC5ciRCHBXycVUNQdg9luBXSu1F85
e654d3liDeyPk+I9epyJ6U9vR90JHMEqaKoaysSojXcI6hkeOhndoX9dRBWn4mb7
kVEG85oefmi6xDqY7G1yQF5e+U6K5GM85aK8iuNGLyWQUvZQMPLE8zTnimJeT0Th
fspyoOsjp1vGTd4BdIKgiDNrfvjl0w==
=oyc4
-----END PGP SIGNATURE-----

--OVggj7Yg2H2CVuep--


