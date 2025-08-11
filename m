Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991A7CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 20:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulZNN-0007xr-UD; Mon, 11 Aug 2025 16:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZN6-0007wI-Ed
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZMz-0007PD-K4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754945026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dc5A4k3LJzMj4VlOSZmhiyYoSuA3/M92Q5e5X77ilYU=;
 b=ec/cKi/Rhwrn4YmvmDCmlJQJy3Xy+qDyafrO1VuHGmlssOcCqVou94PfICAOOnmsgdT/od
 TS/1zd7FPjLwUI/pNfcAQTJsfRxGP7v2vDBviwsztjSyqoxQ488zf7Li/lbOtmb5UZb46L
 0QAiDW734vCf9+HcsLZrvRNGEcPSG0Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-jo9MdSPyPhC2zg9NBQA-9g-1; Mon,
 11 Aug 2025 16:43:44 -0400
X-MC-Unique: jo9MdSPyPhC2zg9NBQA-9g-1
X-Mimecast-MFC-AGG-ID: jo9MdSPyPhC2zg9NBQA-9g_1754945024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E171956096
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 20:43:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F35019560AB; Mon, 11 Aug 2025 20:43:42 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:43:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/3] vfio queue
Message-ID: <20250811204342.GA77945@fedora>
References: <20250810160118.450430-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gWQD4yr0+Md29bLh"
Content-Disposition: inline
In-Reply-To: <20250810160118.450430-1-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--gWQD4yr0+Md29bLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--gWQD4yr0+Md29bLh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiaVf0ACgkQnKSrs4Gr
c8gWBgf+Il12zizaBEePMiSdCSLIk/DihDMMyxZgdEFumA89xF61lXJnTihJWBN+
lTx+LIePZRVtDypUlJPmFvoN4NV7bXHj9K9nz0mvtgeTnCHDyhhgPlzEzPD1ibVO
nKvFYFEsINSzJJ205oZqZWVIuq31hv0znKEBMkB1t7764lMcifL819J3i5UvnkzM
r3I2gIXxOwbdVn16hoixs1hBt/b+akMSc9cgXvw+MbR8+jLp7ZOEPS+wVNNYjDNp
TnQokGUYdFfh7sC9mTHPu7Eko7Y7Fxjrjz8cA0fnI4B6CkL4pX+OxDqPOKFyYELY
EpyTN86D5xET+OFTGU8SoWDQIbS2Jw==
=Ptto
-----END PGP SIGNATURE-----

--gWQD4yr0+Md29bLh--


