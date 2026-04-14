Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F74BF9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCi0s-0000W2-GS; Tue, 14 Apr 2026 13:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCi0q-0000VZ-SO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCi0p-0007ts-0K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776189440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+vzaEKabxdv0/3CjORshcJXEpntjnx8/hX1P+eHVG7A=;
 b=Fkp/pHsO+qjtZpMJgCvXBWyAzyevCbpZ8KMmqaTaomrrzlO8a4GjgHekdkB4n8Bf4MH8U9
 GxRepRxgXQ5FhE01RVJ7SL9v7TfSoEysGQ5R6fP7Tf3Xh9Q1Nlf6xH5rNiWaiaw5aP1UZR
 wee1s9wazsdyuJt3bVUSe2q0IWfagvE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-dPsxRGMFM_CbTN7NoCmzKA-1; Tue,
 14 Apr 2026 13:57:17 -0400
X-MC-Unique: dPsxRGMFM_CbTN7NoCmzKA-1
X-Mimecast-MFC-AGG-ID: dPsxRGMFM_CbTN7NoCmzKA_1776189435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BAE5180034E; Tue, 14 Apr 2026 17:57:14 +0000 (UTC)
Received: from localhost (unknown [10.44.50.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E72D195608E; Tue, 14 Apr 2026 17:57:12 +0000 (UTC)
Date: Tue, 14 Apr 2026 13:57:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>, kwolf@redhat.com
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Message-ID: <20260414175710.GA136064@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CPETiYvycK+BqAR0"
Content-Disposition: inline
In-Reply-To: <20260409060155.94704-3-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--CPETiYvycK+BqAR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
> Add a drive_insert HMP command that reconnects a host block device file
> to an existing guest device whose backing store was previously removed
> with drive_del.
>=20
> After drive_del, the BlockBackend remains attached to the guest device
> but has no BlockDriverState (shown as "[not inserted]" in info block).
> drive_insert opens the specified file, finds the device's BlockBackend
> by iterating all backends and matching the attached device ID, then
> calls blk_insert_bs() to reconnect the backing store.
>=20
> This complements drive_del for non-removable devices (such as NVMe
> namespaces) where blockdev-change-medium cannot be used. Combined with
> PCIe AER Surprise Down error injection to trigger a controller reset,
> this enables complete NVMe disk hot-swap simulation where the guest
> sees the same device names throughout.
>=20
> Example usage:
>   drive_del drv0             # remove backing store
>   drive_insert ns0 disk.qcow2  # reconnect backing
>   pcie_aer_inject_error rp0 SDN  # trigger controller reset

This approach does not delete the `--device nvme-ns` but instead
replaces the BlockBackend's root node so that the existing NVMe
Namespace changes the underlying storage.

Questions about this approach:
1. NVMe AEN is not involved at all?
2. Does the guest have access to the new storage as soon as drive_insert
   completes and the PCIe AER is just to kick the guest driver (e.g.
   getting it to update the size of the guest Linux block device)?

Stefan

--CPETiYvycK+BqAR0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnef/YACgkQnKSrs4Gr
c8gWXwgAyj+zrgRhWWvZUZZYK4vU81UPE6HSv0G7aDS8tJVhNRDdCPEyyp9iaiq6
MEs0jPgzBRv0cv+NhvyGsL9N83Se8zTsHOM4ul5Cr3ErpWxIkxcfroed2HPgiwsC
0+2dJBEmtwCyS+/geJOu9W33RmUSroD7w3M3A9vQ3uLmOmF6cObRumv+K7+OfBzd
cprnRZMrJaPaZLCJ0AfKNqaq4gAHrFwU2SAPkc/W4XT8nWEoqBZG/0ZvAxxJDSFo
HXC0dgxlzSSfp1LB5jtw5In2RaSgOjkYxFh8kRcW8MA0jf3DMgEsdXaNheuZKBgq
VVddJVVKphjP566OJr98BMx0QfxyaA==
=dmz4
-----END PGP SIGNATURE-----

--CPETiYvycK+BqAR0--


