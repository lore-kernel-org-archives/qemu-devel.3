Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D40EF364BE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAwU8-0003cT-Lw; Thu, 09 Apr 2026 17:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAwU6-0003bl-RK
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAwU4-0003jJ-GY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775768415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTSN74Q0fLu2ja67fDRVvufeWhfWew7w8f7WnYKnbAY=;
 b=aM5qRwUXleFtGqYDBff9ys5fsotBvEpnaZwyiQFoBEe5TV+EMyUIUZe0mU6S5hM0+c+Hb7
 MOsjQuRpJLgL2kpnViimEDcWO61kW8AC1baR20njc8SITe9jJVEqVj38kqGTrjp2biGvS0
 0i5SkehpFjQmJAFeIJY2QneAMAqy2fw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-PGTYN7HeO5G6-jPpdStZvA-1; Thu,
 09 Apr 2026 17:00:13 -0400
X-MC-Unique: PGTYN7HeO5G6-jPpdStZvA-1
X-Mimecast-MFC-AGG-ID: PGTYN7HeO5G6-jPpdStZvA_1775768411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D5E1956080; Thu,  9 Apr 2026 21:00:11 +0000 (UTC)
Received: from localhost (unknown [10.44.34.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F41FB3000C16; Thu,  9 Apr 2026 21:00:09 +0000 (UTC)
Date: Thu, 9 Apr 2026 17:00:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <20260409210007.GA461870@fedora>
References: <20260409070114.11313-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rXDJNL5tS8FVxHtZ"
Content-Disposition: inline
In-Reply-To: <20260409070114.11313-1-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--rXDJNL5tS8FVxHtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 09:01:09AM +0200, mr-083 wrote:
> This series adds two features that together enable transparent NVMe disk
> hot-swap simulation in QEMU, matching the behavior of physical NVMe
> drives being pulled and reinserted in the same PCIe slot.
>=20
> Problem:
> Currently, hot-swapping an NVMe disk in QEMU requires removing the
> entire NVMe controller via device_del, which causes the Linux guest to
> assign a new controller number on re-add (e.g. nvme2 becomes nvme4).
> This breaks storage software that tracks drives by device name.

Hi mr-083,
Neat, I was looking for something like this recently!

> Solution:
> Patch 1 adds hotplug support for nvme-ns devices on the NvmeBus, with
> proper Asynchronous Event Notification (AEN) so the guest kernel detects
> namespace changes. This allows namespace-level hot-swap without removing
> the NVMe controller.
>=20
> Patch 2 adds a drive_insert HMP command that reconnects a host block
> device file to an existing guest device after drive_del. This is the
> counterpart to drive_del for non-removable devices where
> blockdev-change-medium cannot be used.
>=20
> The recommended hot-swap sequence is:
>   1. drive_del <drive-id>          # disconnect backing store
>   2. drive_insert <device> <file>  # reconnect backing store

Is it possible to achieve this with device_del + device_add instead of
introducing a new monitor command?

device_del nvme-ns2
blockdev-del nvme-ns2-blk      (or drive_del)
=2E..
blockdev-add nvme-ns2-blk,...  (or drive_add)
device_add nvme-ns,id=3Dnvme-ns2,nsid=3D2,drive=3Dnvme-ns2-blk

>   3. pcie_aer_inject_error <port> SDN  # trigger controller reset

Is NVMe AEN insufficient to get the guest to recognize the Namespace
change? I looked at the Linux NVMe driver code recently and got the
impression it would process changes to the Namespace list upon receiving
the NVMe AEN.

> After this sequence, the guest sees the same controller and namespace
> names (e.g. /dev/nvme2n1 remains /dev/nvme2n1), and the NVMe driver
> recovers transparently via the standard AER recovery path.
>=20
> Tested with:
> - Linux 6.1 guest on QEMU aarch64 with HVF (macOS)
> - NVMe subsystem model with multipath disabled
> - DirectPV and MinIO AIStor storage stack
>=20
> mr-083 (2):
>   hw/nvme: add namespace hotplug support
>   block/monitor: add drive_insert HMP command
>=20
>  block/monitor/block-hmp-cmds.c | 59 +++++++++++++++++++++++
>  hmp-commands.hx                | 18 +++++++
>  hw/nvme/ctrl.c                 | 85 ++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c                   |  1 +
>  hw/nvme/subsys.c               |  2 +
>  include/block/block-hmp-cmds.h |  1 +
>  6 files changed, 166 insertions(+)
>=20
> --
> 2.50.1 (Apple Git-155)
>=20

--rXDJNL5tS8FVxHtZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnYE1cACgkQnKSrs4Gr
c8hD5Qf8CvWRma01WQ5kB1KGqeQyv0APZjMwCjImp4lYpsmURZSJLNVyssK8ctvo
NKpCrMbtIRk4Wzqq+epkser1z/X7xY4yk+uPWOCvH0wXU27IjGrr21GE79hb8pSq
jj9kaND8g8huS2EMl7MNVaGENFb+IvaiYGytLREaqsfDa8GFenh1lh3U/pOHN/JB
Nl5W684LGUToZ1P2BTDw8fFZ5zaVx+aSILLQwjHbv/chPekc5Sy3ILQlRF4Midj8
58U4KWLpuNpDYMgWa3NWLx5tXT4OMfOOo8vKlN93m4NqWyGym3e9NpyoQCzbsa+t
Y0O8nRbLteaVyr1+58KbPEQlBSbwVA==
=CC3V
-----END PGP SIGNATURE-----

--rXDJNL5tS8FVxHtZ--


