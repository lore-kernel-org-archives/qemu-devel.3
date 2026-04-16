Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C138F8D776
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSc1-0001rS-LX; Thu, 16 Apr 2026 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDSbx-0001q5-6c
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDSbv-0002CS-A3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776368565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuYKXzY/dT1prCAUF+XAZfKm+aQRp9FKDF6kurzfCYk=;
 b=LwvoaqSmQii0V1TgJHMfJQJp6vEIQSBRFydR7X0mexUwChe/EwOsKSw4adHfgYKGjv24Wa
 LPSVXu1/S5e0H2Vmqw9eTHrSIGwN2IjXC13Jf60VNkBZAcuLh2vis/p8m8gg+kTdeGjBi7
 TUyaf5HMrCT9Mqr9BCy3yJQZiewmvSU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-lRMp6mmvM3aN3CL-ak-xKw-1; Thu,
 16 Apr 2026 15:42:40 -0400
X-MC-Unique: lRMp6mmvM3aN3CL-ak-xKw-1
X-Mimecast-MFC-AGG-ID: lRMp6mmvM3aN3CL-ak-xKw_1776368559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C22701956056; Thu, 16 Apr 2026 19:42:38 +0000 (UTC)
Received: from localhost (unknown [10.44.48.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7471830001A4; Thu, 16 Apr 2026 19:42:37 +0000 (UTC)
Date: Thu, 16 Apr 2026 15:42:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Subject: Re: [PATCH v4] hw/nvme: add namespace hotplug support
Message-ID: <20260416194234.GA258343@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260415173852.71135-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XICr/xxE8Ini9PdR"
Content-Disposition: inline
In-Reply-To: <20260415173852.71135-1-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--XICr/xxE8Ini9PdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 07:38:52PM +0200, mr-083 wrote:
> Add hotplug support for nvme-ns devices on the NvmeBus. This enables
> NVMe namespace-level hot-add and hot-remove via device_add and
> device_del with proper Asynchronous Event Notification (AEN), so the
> guest kernel can react to namespace topology changes.
>=20
> Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
> hotplug handler with proper plug and unplug callbacks:
>=20
> - plug: attach namespace to all started controllers and send an
>   Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
>   the guest kernel rescans namespaces and adds the block device
> - unplug: drain in-flight I/O, detach from all controllers, send
>   AEN, then unrealize the device. The guest kernel rescans and
>   removes the block device.
>=20
> The plug handler skips controllers that haven't started yet
> (qs_created =3D=3D false) to avoid interfering with boot-time namespace
> attachment in nvme_start_ctrl().
>=20
> The unplug handler drains in-flight I/O via nvme_ns_drain() before
> detaching the namespace from controllers, so pending requests can
> complete normally without touching freed state.
>=20
> For symmetry with nvme_ns_realize() which sets subsys->namespaces[nsid],
> nvme_ns_unrealize() now clears that slot too making the namespace
> lifecycle complete.
>=20
> Both the controller bus and subsystem bus are configured as hotplug
> handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
> may reparent to the subsystem bus during realize.
>=20
> Example hot-swap sequence using the NVMe subsystem model:
>=20
>   # Boot with: -device nvme-subsys,id=3Dsubsys0
>   #            -device nvme,id=3Dctrl0,subsys=3Dsubsys0
>   #            -device nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>=20
>   device_del ns0             # guest receives AEN, removes /dev/nvme0n1
>   drive_del drv0
>   drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone
>   device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>                               # guest receives AEN, adds /dev/nvme0n1
>=20
> Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
> namespace list automatically).
>=20
> Signed-off-by: Matthieu <matthieu@min.io>
> ---
>  hw/nvme/ctrl.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c     |  8 +++++
>  hw/nvme/subsys.c |  2 ++
>  3 files changed, 98 insertions(+)

This is useful functionality because PCI hotplug is cumbersome as it
requires preallocating PCIe root ports at guest creation time. Users may
not know how many devices they will eventually hotplug, and so it's
convenient to hotplug multiple namespaces onto an existing NVMe PCI
controller.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XICr/xxE8Ini9PdR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnhO6oACgkQnKSrs4Gr
c8glCggAuEP9HRhKNrO0c5/2wOVsl7XIEJnM7TY2AEeEGLSZGqTkhMXhcwDktEyI
NWw/BT+pFpPwBodgBOl3GpsQmsOarne/J4Zh+jA4jM6lZUuv/so1/RJhbJ+a1u2U
lSm5eZhYyxaUskaFC6b2WLQOb4T+Pw/8C+c5UCutUeHb3tJeuEgUcb9yF5rY4y3u
gXzcZVs5j3cHASqUkFy7SgCVeU+7k6AX2iOHjizgQByKZCutFvz8yOETuEwcaiwq
pF9Ntdmt3RkW9kLFzTdMcq2DIlUt91EQpnwpU8Yg8hiMg+UFYp0dCFB08zM5K4Tr
RbH91071KVqnv0KpJCrBzpLZyLiW6A==
=UAtd
-----END PGP SIGNATURE-----

--XICr/xxE8Ini9PdR--


