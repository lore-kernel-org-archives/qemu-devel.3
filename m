Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3F7D2A54D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 21:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRGzp-0008Bq-8c; Thu, 04 Dec 2025 16:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vRGzk-0008BA-P0
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 16:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vRGzj-0008Gd-0u
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 16:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764884169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cWok/lfrbEvXg2wZaOcBRH/TnBra1n5BhfFH7kros6Q=;
 b=Zlcoo0WcuLwi9ND/XHkH4uVIdwuA1sTP6dgfuGbWijQ4jkdXg7JW1h841U8clh3bCI0OQd
 XtOoajiCGYbh1zdeXGU1E5/nUzO1vKF9YwSpuVyWzHhRFkVw7imS6KqERnjjGTkL7eVUBC
 hzx4uHtAvP6gkzMcgJ7DRLdzrmZ3hJY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-KgFA27wnNCifdWUL24xD2w-1; Thu,
 04 Dec 2025 16:36:06 -0500
X-MC-Unique: KgFA27wnNCifdWUL24xD2w-1
X-Mimecast-MFC-AGG-ID: KgFA27wnNCifdWUL24xD2w_1764884165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 390401956052; Thu,  4 Dec 2025 21:36:05 +0000 (UTC)
Received: from localhost (unknown [10.2.17.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB7B819560B4; Thu,  4 Dec 2025 21:36:03 +0000 (UTC)
Date: Thu, 4 Dec 2025 16:36:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio: Fix crash when sriov-pf is set for
 non-PCI-Express device
Message-ID: <20251204213602.GA1259496@fedora>
References: <20251204172657.174391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4sED2GAmKfDTipmW"
Content-Disposition: inline
In-Reply-To: <20251204172657.174391-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--4sED2GAmKfDTipmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 06:26:57PM +0100, Kevin Wolf wrote:
> Setting the sriov-pf property on devices that aren't PCI Express causes
> an assertion failure:
>=20
>     $ qemu-system-x86_64 \
>         -blockdev null-co,node-name=3Dnull \
>         -blockdev null-co,node-name=3Dnull2 \
>         -device virtio-blk,drive=3Dnull,id=3Dpf \
>         -device virtio-blk,sriov-pf=3Dpf,drive=3Dnull2
>     qemu-system-x86_64: ../hw/pci/pcie.c:1062: void pcie_add_capability(P=
CIDevice *, uint16_t, uint8_t, uint16_t, uint16_t): Assertion `offset >=3D =
PCI_CONFIG_SPACE_SIZE' failed.
>=20
> This is because proxy->last_pcie_cap_offset is only initialised to a
> non-zero value in virtio_pci_realize() if it's a PCI Express device, and
> then virtio_pci_device_plugged() still tries to use it.
>=20
> To fix this, just skip the SR-IOV code for !pci_is_express(). Then the
> next thing pci_qdev_realize() does is call pcie_sriov_register_device(),
> which returns the appropriate error.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: d0c280d3fac6 ('pcie_sriov: Make a PCI device with user-created VF =
ARI-capable')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4sED2GAmKfDTipmW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkx/sIACgkQnKSrs4Gr
c8h+ggf/Rrj3ztca9d//W409galiAASHwkgKFvh03B4pjgS3TAA6dkcZPn9Ra4yb
MRpEl2InU27FVh1/sXB0iIHE3+hAvFIDBxuGQdJqSDDIQiaLbTawzaY5W3epSjAH
Gu/gQV3/ywFGQ9ZyaipKmmsWNsp9Kt19Ce9+62z6T4rYOFNyzjsJgtnU3ZNXvVkM
AxSw9T/AGhwfYzBhxE7QtuKZMtxa+bKeXxMs+vBDPlf5rBn8RG6LjqLn0TwH2U4F
0Ivo9Ij8ndMu4rRkpbZFCjfWISpgV8vpuvXkXDlUjp44TnKHwGh2t62P2Dd81KVj
IYZAYQ/AcgY+qLlcZJLjiojh5BXjtQ==
=/78L
-----END PGP SIGNATURE-----

--4sED2GAmKfDTipmW--


