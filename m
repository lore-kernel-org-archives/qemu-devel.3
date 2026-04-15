Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2B0F41998
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzQs-0003lP-7u; Wed, 15 Apr 2026 08:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCzQq-0003ie-EG
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCzQo-0000YX-T0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776256402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVEfwBTuSqjCg2cgyxQCYaRQplz8l1nc6AU8GGQX5nI=;
 b=QJNYvXIXUAaMMgAReRrQc0/U6Wy3Kjk4eAroWAAN8aNgaRaFIosa0LGPII9Wb/H1Dcmh+i
 oqzffEZFCTxtF+nTLHZ6gVIRnAy+R2h18yzIueL77hYPMtoKam/ma0a0JuA15vsh4WjgfY
 kXYKfimF9ioRUv83M7aR2LMhAujYWJs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-gBBquqiVMfaB4bbHy1cG3Q-1; Wed,
 15 Apr 2026 08:33:15 -0400
X-MC-Unique: gBBquqiVMfaB4bbHy1cG3Q-1
X-Mimecast-MFC-AGG-ID: gBBquqiVMfaB4bbHy1cG3Q_1776256394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10410180036E; Wed, 15 Apr 2026 12:33:14 +0000 (UTC)
Received: from localhost (unknown [10.44.34.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D50B019560B1; Wed, 15 Apr 2026 12:33:12 +0000 (UTC)
Date: Wed, 15 Apr 2026 08:33:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: mr-083 <matthieu@minio.io>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, its@irrelevant.dk, kbusch@kernel.org,
 mr-083 <matthieu@min.io>
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Message-ID: <20260415123310.GA163810@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
 <ad9s9CRT0niUAPQn@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9KxhcO7phLF/Tze"
Content-Disposition: inline
In-Reply-To: <ad9s9CRT0niUAPQn@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--j9KxhcO7phLF/Tze
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 11:48:20AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
> > Add a drive_insert HMP command that reconnects a host block device file
> > to an existing guest device whose backing store was previously removed
> > with drive_del.
> >=20
> > After drive_del, the BlockBackend remains attached to the guest device
> > but has no BlockDriverState (shown as "[not inserted]" in info block).
> > drive_insert opens the specified file, finds the device's BlockBackend
> > by iterating all backends and matching the attached device ID, then
> > calls blk_insert_bs() to reconnect the backing store.
> >=20
> > This complements drive_del for non-removable devices (such as NVMe
> > namespaces) where blockdev-change-medium cannot be used. Combined with
> > PCIe AER Surprise Down error injection to trigger a controller reset,
> > this enables complete NVMe disk hot-swap simulation where the guest
> > sees the same device names throughout.
> >=20
> > Example usage:
> >   drive_del drv0             # remove backing store
> >   drive_insert ns0 disk.qcow2  # reconnect backing
> >   pcie_aer_inject_error rp0 SDN  # trigger controller reset
> >=20
> > Signed-off-by: Matthieu Receveur <matthieu@min.io>
> > ---
> >  block/monitor/block-hmp-cmds.c | 59 ++++++++++++++++++++++++++++++++++
> >  hmp-commands.hx                | 18 +++++++++++
>=20
> I see v3 has dropped this new command, but in case you have plans
> to re-introduce it..

I suggest splitting this into two separate patch series since two
different use cases are being addressed:

1. --device nvme-ns hotplug using NVMe AEN. Allows users to attach and
   detach storage to the NVMe controller at runtime (without PCI
   hotplug).

2. PCIe Surprise Down and AER. Allows testing of PCI error recovery in
   guest drivers.

Stefan

--j9KxhcO7phLF/Tze
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnfhYYACgkQnKSrs4Gr
c8hWLwgAoE9Yj92RUc9f/sdcz7TYIPkSAX3GwNvNhXcO1kpBzHQCq0nPCigTsdHq
pgaKSNRYWPlyYVV5pBTtLEeDyyMd2eQ2EhF+Tji40KVE9GANDyDL6xhDdPlWiVxR
SoY651efbjESCCSVW91S+D6jaVYIArl3kYBXiIC2z8xWE93Zi/2JFL945ve08XDB
jWkERbOZu9G47yEqQWnzrka6DZILOYN4KRvyB1hELOjVqHFRz3Umz2FXyYCote0h
4iIAV6h5rgwlUjbGbxymnFIiZHKuDNnSuY6fl0dBVy+akIE1NhmoOHwehZv2YbnB
+2w6ub6LdOmaPJdBU5df/IPeB89ruw==
=Ioju
-----END PGP SIGNATURE-----

--j9KxhcO7phLF/Tze--


