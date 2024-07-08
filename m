Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F7C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQk0M-0002z6-2O; Mon, 08 Jul 2024 04:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQk0E-0002qV-Jv
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQk0B-0006Df-Ik
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720428337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5vvyThLjz/CCzQ6le+qTa3R5al+8xwaGOIruyXZpKU=;
 b=NCd7gKDy4BJXNV2woO6nc42hfCqZliAvYEA6TwrRu76oZLv8LR4ibZcAlC0SnzAf3C4W6p
 n94urj0QKN2c/p493u1A2/lBQCbROxX4PHgDeULzQ8IFxTChZ5V5E0Skqh5F9XVXIHtPFz
 gfcBP+oTwAY9u1JIm+TXJ+OzZjI8KFM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-BtnCVUEwO0yMC3cnlSDW8w-1; Mon,
 08 Jul 2024 04:45:32 -0400
X-MC-Unique: BtnCVUEwO0yMC3cnlSDW8w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B41C1955BCC; Mon,  8 Jul 2024 08:45:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C55E719560AE; Mon,  8 Jul 2024 08:45:27 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:45:26 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 06/10] block/nvme: add reservation command protocol
 constants
Message-ID: <20240708084526.GF38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-7-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nhj1MREeXoeZOCVT"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-7-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Nhj1MREeXoeZOCVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 06:56:10PM +0800, Changqi Lu wrote:
> Add constants for the NVMe persistent command protocol.
> The constants include the reservation command opcode and
> reservation type values defined in section 7 of the NVMe
> 2.0 specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nhj1MREeXoeZOCVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLpyYACgkQnKSrs4Gr
c8gJzQf+JA0O3mxwV9JXaCIWLAy+bU8IF6gF5kDRNFTbL71a1RdXMw6j/s/Nuc4s
Js8fkhTCB1VdL/8XDtj6X3rjLbwdGbfh7eH5n3gl4d2H1tk5ZL/KhoYvqfvdVXIH
ncaz52fhfQCMOM6eQ6VoWtwtgMJcjmBMDJtoGW4jfUqa+RuJzMXsgKuI6gjC95ET
Fb8xWq0zMJB39IlDkV6CxM/nh6UDmoyEvy1oCEJuR9/0NAZoHZlBivpoEqa2vysy
IB5Z5DQbIrGHCCCRR6Wd4uhrCy18ZYlEQKHUxQltmTBgpjxEmH/SsmF0w5b+fM3i
abln5CKV6n9k/WNgkuz097ypFFYTbw==
=UTVK
-----END PGP SIGNATURE-----

--Nhj1MREeXoeZOCVT--


