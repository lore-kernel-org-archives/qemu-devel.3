Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EDACD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 19:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9NT-0005Gn-OQ; Thu, 21 May 2026 15:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ9NR-0005G2-VU
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ9NQ-0006fG-5C
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779392894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZrjSR6/jgQfvhvphefoPMveQElQflSuxBFvNz6cGgRA=;
 b=D8yGuB28zlL+xqjKKp3I1YprQXttZSYdpvkbjt1EtZ57/gHkDA93EDK97P+XcxfFARdikK
 kOeMQGBbNqpY6Kr5mbzO2GvB+NCkvxlBqevGzUNyBubswX3ogdoZ/X+L0fCAIJ7U/oTnqc
 h59E0ZOFtdq6vhtBYjA0OuMEG0cV42U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-WT6pWO7JNU6AgfccL_HcgA-1; Thu,
 21 May 2026 15:48:11 -0400
X-MC-Unique: WT6pWO7JNU6AgfccL_HcgA-1
X-Mimecast-MFC-AGG-ID: WT6pWO7JNU6AgfccL_HcgA_1779392890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9591956054; Thu, 21 May 2026 19:48:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC7AE180034E; Thu, 21 May 2026 19:48:09 +0000 (UTC)
Date: Thu, 21 May 2026 10:56:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 35/39] MAINTAINERS: Drop stale F: from "Linux io_uring"
Message-ID: <20260521145631.GD464582@fedora>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-36-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zpl7r9upFA5uwsET"
Content-Disposition: inline
In-Reply-To: <20260521080511.999266-36-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Zpl7r9upFA5uwsET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:05:07AM +0200, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we dropped stubs/io_uring.c.
> Update it now.
>=20
> Fixes: 047dabef97 (block/io_uring: use aio_add_sqe(), 2025-11-03)
> Cc: Julia Suvorova <jusual@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zpl7r9upFA5uwsET
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPHR8ACgkQnKSrs4Gr
c8i2Ngf+Ou0NPNQWSD6oc53GetoftTJxVbL18XxU1XUUtIHckb7zD0Ibq+AnNR/S
UFyEge923ZaZGUoij4J5409v43JRORzgZDZdHDYIzSfdh1Q29U7oEkqztXwHCivG
CTzIe7bkj5L2Jsr7D6rxB3tkx+dI762ql6Hywr0iNKEx88xUZRQ0GZA9FLjDixEt
QaVuN095eBGktSpcfKwInWlsRQqRFL7lJAjoZMADf9/4+OBwdSvvDTziou1tnppB
LFtHy1I1l+0th+v0QwSNIe/65hqEPUxdHfoyfgze2WkoQSvXmYPx5M9+yEq312v1
l4kAYmFZoNsnRQ7xuz6ktyYY1+WHLQ==
=9ZI1
-----END PGP SIGNATURE-----

--Zpl7r9upFA5uwsET--


