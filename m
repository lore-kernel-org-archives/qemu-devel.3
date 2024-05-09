Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBBEC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58Vb-0000Il-Uv; Thu, 09 May 2024 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58Va-0000IW-CY
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58VY-0006qz-Vy
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715279324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emi2HaCz4pa7Itb2fl+cQV4JOrnHLMXAFJe+Hw0znBI=;
 b=L/X+4cvc5s+NeAndfjGwjNMo3L3HzBZ+m8gbQE12SvEQI8txkiV2mybs66m64/vFn5D6cU
 fJyJjSvBm1UazrrJL1qNEDUg/LN1hX2jpy6A9PfFtKarGbEpO+CODx8kykMt5cBWYXi1M4
 nOVDs+FqJsCOTW8MMuKb1l2CeuB0eV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-aDlcVVHQOsKBMofcTnqy-g-1; Thu, 09 May 2024 14:28:29 -0400
X-MC-Unique: aDlcVVHQOsKBMofcTnqy-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 697F5857A81;
 Thu,  9 May 2024 18:28:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA5FC20ACC81;
 Thu,  9 May 2024 18:28:27 +0000 (UTC)
Date: Thu, 9 May 2024 14:28:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 4/9] scsi/util: add helper functions for persistent
 reservation types conversion
Message-ID: <20240509182826.GF515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-5-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3ykSRyUmpbwjYX81"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-5-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--3ykSRyUmpbwjYX81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:24PM +0800, Changqi Lu wrote:
> This commit introduces two helper functions
> that facilitate the conversion between the
> persistent reservation types used in the SCSI
> protocol and those used in the block layer.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/scsi/utils.h |  5 +++++
>  scsi/utils.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3ykSRyUmpbwjYX81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9FcoACgkQnKSrs4Gr
c8ia9gf/a+HwHTWzKbLmlliGSkIALV1Y0lzUGKeZr1oRg8fyLo6iwkTnvJ6YeZ6m
NKVQ7OETcyT3RkIeJGL7Qtpm8jD7EX3PFpXC9MHHmvJKsqvOLsNYyvwvt0IaJq8D
to9seqOvYai7SC3GdQWAoyBSmVVof9JJ/begSOfHmu0NW/FBU0Np8cDouxF+XEwM
4Ed7uFQpAKZXfe7QZo0syy6SXH/IjzGVACT4rkvDzejx7ti5owSG/VOKzKQ1PBdF
cb3JwMDRWsc3lq8qU8qtZz01acm6Jr4PQ5NxVGRXXnIhgbbvZ276xfBU7GV0jP4B
3s6E1M+UbhFg9Pn6zFCwNg/De9GuWQ==
=VzV2
-----END PGP SIGNATURE-----

--3ykSRyUmpbwjYX81--


