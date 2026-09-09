Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54783C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Mep-00078q-Ow; Wed, 09 Sep 2026 14:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4Men-00078I-CF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4Mej-0005wq-D2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788977059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOQJ0hNNquQxImLodx9/AREisOtKk08n2vBS8AnDR8g=;
 b=DahiO6hkTZkfJRKhesCRv5SfvZA/lv3TBx91lKEHJjKfSUgdquOe3OWEpe2VYS+0EEl1Ot
 90ejwn2umP3Z6l/tkizhsqfWxBMXL/ouAytqP4lWCUzjKdNMiOp9KnDTxyTqw1RNTQ/yID
 IWN/VXlQwG/dtrBdgxiEwPzbRQlY+KE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-SVS-YgyYMUKDeg2lVlKizA-1; Wed,
 09 Sep 2026 14:04:16 -0400
X-MC-Unique: SVS-YgyYMUKDeg2lVlKizA-1
X-Mimecast-MFC-AGG-ID: SVS-YgyYMUKDeg2lVlKizA_1788977054
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BF441954209; Wed,  9 Sep 2026 18:04:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1D8241A; Wed,  9 Sep 2026 18:04:12 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:04:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 01/12] block: widen BlockLimits.zone_size to uint64_t
Message-ID: <20260909180411.GA20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOLZX6nqzMYLsLWD"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-2-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

--YOLZX6nqzMYLsLWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:36PM +0200, Niklas Cassel wrote:
> From: Sam Li <faithilikerun@gmail.com>
>=20
> The zone-size field in BlockLimits is currently uint32_t, capping
> expressible zone sizes at 4 GiB. Real zoned-device protocols
> like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
> uint64_t to match.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c               | 2 +-
>  include/block/block_int-common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YOLZX6nqzMYLsLWD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhn5sACgkQnKSrs4Gr
c8hZegf9F/yYjth4MWtavoXpPA1YDo1dcaxB3SNpYH+DbuvDPurWYqRirx1ccryB
Z5zk1UxpSaSZpH8vGHg2Qt8PQal8hB4SoBKDhSKpPc10x04kw9aJAIBHvWYrC3qd
o5enCIpFZUVFLf6cHnoWW1cywN5qUzGts9Bc/djYg02SsSApPgkYK0wGOLzTwJKk
UgNRLWX/JMjyYDpNMd71uQhpgSX4f96on+AuPoQhX7J9VcbNmQLmoU3ph8wKY6wq
3B51nPYD69UARj4Ns5NPmr44BdgIpy6k4yZw/ll0ek3rMCeIhMRt4XPslxpVnGXT
IFk3AKTg9tMOtL0yfcmBY/kIHereUQ==
=ECec
-----END PGP SIGNATURE-----

--YOLZX6nqzMYLsLWD--


