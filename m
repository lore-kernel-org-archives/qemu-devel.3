Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A53AC3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 14:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzymr-0007Vs-DN; Wed, 02 Apr 2025 10:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzyml-0007VI-Pl
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzymY-0002iq-47
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743602965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9P8tBaTrmLhvJG0L5YAlEij5nhtkZUTzuQDaONHqN3k=;
 b=FNq7ZZtN0LaWwrz5SdqQnXC1UPITY6vfkZqfKoD/VURj+ijimFzmDuzW+uwVQ3bR1f/zES
 cPn0W0Quz10Q4YSS9jLkshzQazgexy9S78IwZodD9qMDSLbeuulQc7JcG8a3dN4IdJ4gym
 LPAF3SPBV7RnPMMqpZbmBBsrKBH8UCg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-RCoVC1TDP_OlYffiWRP7VQ-1; Wed,
 02 Apr 2025 10:09:21 -0400
X-MC-Unique: RCoVC1TDP_OlYffiWRP7VQ-1
X-Mimecast-MFC-AGG-ID: RCoVC1TDP_OlYffiWRP7VQ_1743602959
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 561101828B98; Wed,  2 Apr 2025 14:09:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 853651955BF1; Wed,  2 Apr 2025 14:09:15 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:09:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, thuth@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com
Subject: Re: [PATCH v3 2/3] include: Add a header to define host PCI MMIO
 functions
Message-ID: <20250402140914.GD304512@fedora>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250401172246.2688-3-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ET9m3FK9isD1suj2"
Content-Disposition: inline
In-Reply-To: <20250401172246.2688-3-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--ET9m3FK9isD1suj2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 10:22:45AM -0700, Farhan Ali wrote:
> Add a generic API for host PCI MMIO reads/writes
> (e.g. Linux VFIO BAR accesses). The functions access
> little endian memory and returns the result in
> host cpu endianness.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  include/qemu/host-pci-mmio.h | 116 +++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 include/qemu/host-pci-mmio.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ET9m3FK9isD1suj2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmftRQoACgkQnKSrs4Gr
c8gNeAgAuqCrUnKJaaGJSy+Vil7Wfz8JwYop8HPart6TXriOKG/We/6kY1Rl3Xkx
S/qRRIX3iSfv59MgyAkvUHJE1tEFi1iVK6bh7pDr6zWrYe8oXtfyqQzWjzsNRkdl
w37EfcgjmlWgaZ4FwCNYYfPJR20iFVoQXN1w/DWvpEJbvR5SwWiLb+3Tm3CegUK4
YpdWfjVFH7XvuXGSo63q0FxUA0kKZEJAwYOTF4lZhwzZo5v4Ccap0Zzj6wrdrF+G
rR6WMvSsBKoobrekIzBjtb8F7hQY1p1n7zSZ5ICyyPGpyVYs0cBbFKJfnTVETc71
WoLKFok6NpoSx8PZ8vSmIV9seFAIDw==
=1YrC
-----END PGP SIGNATURE-----

--ET9m3FK9isD1suj2--


