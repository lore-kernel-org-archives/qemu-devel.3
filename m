Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77F1C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Esh-0003xV-Di; Tue, 22 Apr 2025 10:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7EsZ-0003qu-Cf
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7EsW-000402-Ne
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745333139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/5xLk5pIH8bLbAMtocpw8pMR6Om8530G3WFagABZqg=;
 b=Qven80a7gTeDGNeTF4+SJEK53ZHkHvrup+OsezlvMnYIDWeaZoV7yw86L3DHtwXZKJS+EO
 YO8s5HBlLsiluqHLiSy15iI9VVOa56jWeaiFOPBNaEJULjSq+e2HGMEi7aP4aDKv/CHnmM
 fAc91QptbKOekk7OpA6q1VWQque4+Ec=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-C3yBgnDPNu62P16HFKST-Q-1; Tue,
 22 Apr 2025 10:45:37 -0400
X-MC-Unique: C3yBgnDPNu62P16HFKST-Q-1
X-Mimecast-MFC-AGG-ID: C3yBgnDPNu62P16HFKST-Q_1745333135
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8131E1955DCF; Tue, 22 Apr 2025 14:45:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA7F819560A3; Tue, 22 Apr 2025 14:45:33 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:45:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
Subject: Re: [PATCH v5 2/3] include: Add a header to define host PCI MMIO
 functions
Message-ID: <20250422144532.GG301197@fedora>
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-3-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2Iz+JRzdXjaQxwXR"
Content-Disposition: inline
In-Reply-To: <20250417173801.827-3-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--2Iz+JRzdXjaQxwXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:38:00AM -0700, Farhan Ali wrote:
> Add a generic API for host PCI MMIO reads/writes
> (e.g. Linux VFIO BAR accesses). The functions access
> little endian memory and returns the result in
> host cpu endianness.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  include/qemu/host-pci-mmio.h | 141 +++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 include/qemu/host-pci-mmio.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2Iz+JRzdXjaQxwXR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHq4wACgkQnKSrs4Gr
c8iZYwgApwBt+wlmXP27f8mtPrpsWN7l66Uahfx/+1Bu2MlJkztkelC08oCn4eif
Sv1OZ7qDLHqiT2QZWT47KAEfC+BT4r5kF0wLhuZugDDYpYuNl2jG53kemUOrQlKT
/KFWIkgcuzDmkqz7XCbAy/TJr+uermYuJorqNMgEWhCWzokUX8E2wpCtgdwiZrZt
7R1+FziCskGuGVKsLnW+8tjQVPPBnEdVtWUfY1Lqnz01+oc5Yv8g3Uuur9llw66w
5mpApC446g06kYCVzNdJ3090ftJ//YamKps26sxKcd2DtSUy8xK5HbevmCRQEaz8
tYqrcMHdXF8w0U1f2Th6JqLvajQ/Dg==
=8K7H
-----END PGP SIGNATURE-----

--2Iz+JRzdXjaQxwXR--


