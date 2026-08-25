Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA8DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 23:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz0ia-0004Pg-14; Tue, 25 Aug 2026 19:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wz0iX-0004PD-Sf
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wz0iW-00010I-Ht
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787701087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uY1Ei8cpGGYRbwH5KoBBtCLy+m1lTh55e7SovAxyvOk=;
 b=glXCTufXnfHGDU04L0TdI1OYn5rbI1VQdYeXGM/fNgzwSykIJzkE7WPLVevoojqx2rGhn8
 wZeVPYXxt72eoRVyUDaPvUHbSGliOkkC/pC7HTy4svvyOjjxt8QAn/r+fi+p7D8kb2Ta9O
 QdhWDE3VcTFIvo/pz2+giBwnNSyN5jM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-j1oCng8eM9OUwdKLp07m0w-1; Tue,
 25 Aug 2026 19:38:04 -0400
X-MC-Unique: j1oCng8eM9OUwdKLp07m0w-1
X-Mimecast-MFC-AGG-ID: j1oCng8eM9OUwdKLp07m0w_1787701083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2744190F9F8; Tue, 25 Aug 2026 23:38:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C141418005B4; Tue, 25 Aug 2026 23:38:01 +0000 (UTC)
Date: Tue, 25 Aug 2026 19:35:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v14 2/6] block: widen BlockLimits.zone_size to uint64_t
Message-ID: <20260825233545.GB282683@fedora>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
 <20260708221615.346155-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DCYonRAFWkZ99TDb"
Content-Disposition: inline
In-Reply-To: <20260708221615.346155-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

--DCYonRAFWkZ99TDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 12:16:11AM +0200, Sam Li wrote:
> The zone-size field in BlockLimits is currently uint32_t, capping
> expressible zone sizes at 4 GiB. Real zoned-device protocols
> like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
> uint64_t to match.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c               | 2 +-
>  include/block/block_int-common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DCYonRAFWkZ99TDb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqOJtEACgkQnKSrs4Gr
c8ikowgAmQOTUONWDoJrJn99ylrfP28r+985dWUCl27JyTB6pQ59hMeOUlBSEpqE
v4dBXBw6Sjgyx9fCV0PlxugxOsZWkYIdruIJYXjnEDGTlqFmkcHmwkINQxTkulci
b7R6F9tY+jTjgqL06RZO4uSG63rUFanbihZvQW/2HnwqBHFIDW//fpQhraqVn+pl
hmadqn24l8vgPvA0rJTa5/K9XOIn7xdSZIR2MuAqgB8VLblwAHxKHvHUU95+IRLC
XAqcFNKnJF2Yp0VJ2Q2jZKTpvkqRfnr6NK7tr5j19gWKS0kwF8kCQWyzp4fnkYvE
bJvvn4VFr7aIeEpNCJzuqRMuQmTDkA==
=UOTO
-----END PGP SIGNATURE-----

--DCYonRAFWkZ99TDb--


