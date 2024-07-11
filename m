Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07525C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtUh-0000UJ-V0; Thu, 11 Jul 2024 09:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtUb-0008Q9-5L
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtUZ-0000vZ-Ee
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720703146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSljTmurUcn8WIzF0h+QKaC90d/t7k+56iTs36qfYaU=;
 b=eyp1AAu8vblaTmLi65PlW5E5MZ234QzWon4PR8Mp5gO967ODNmdapcd6FAP3fC+xyW6jou
 sfGgVl9WkPPgPJ+JFmQr+Gps3wstzu7oONS0wDfAQu2xcY0tSm4O9Mdqdgj1Iz45o/WVoi
 AeBoNNkkPdyDn1lO4AWHOx3pzrPTBM4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-k4pyt-fNMFm9NDBKcd7Lpg-1; Thu,
 11 Jul 2024 09:05:39 -0400
X-MC-Unique: k4pyt-fNMFm9NDBKcd7Lpg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A20D195609D; Thu, 11 Jul 2024 13:05:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63FC51955F40; Thu, 11 Jul 2024 13:05:35 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:05:34 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v8 10/10] block/iscsi: add persistent reservation in/out
 driver
Message-ID: <20240711130534.GE16124@fedora.home>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
 <20240709024706.4108-11-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="igb3IckrnkWjROQ9"
Content-Disposition: inline
In-Reply-To: <20240709024706.4108-11-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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


--igb3IckrnkWjROQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 10:47:06AM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations for iscsi driver.
> The following methods are implemented: bdrv_co_pr_read_keys,
> bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
> bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/iscsi.c | 425 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 425 insertions(+)

Aside from the g_free() issue I commented on:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--igb3IckrnkWjROQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaP2J0ACgkQnKSrs4Gr
c8gxDQf/ezxRflyESh642gQ5Ga7LkWxqnVkq3TH/oofoH2Vvw/fMVgIXC03EAu4v
P6+ajjCkS0cDZgcsDGEr/fOGbjGWdDJQpr6GZtvqBVYE9hPzniwRE2Z4EEpVyByX
GtKlp4XTv1NRt6zk2yAzbP/fRXSzU+aFnljEmPMwo5/4uIUuP/GkCN2p0ab+AB6G
vqgolFvOpS0z9vcRW0i2931qOmYtFQTQ6clweAsZqzPhSOIP2XVvml/QR1k2e8KR
oNqPrguYME7hDVgt3NNj15iMqM03AcZXYFGZiuU47r6/oY32Zmjxsjzg1jV1WJ7n
pqjjXwD1tlDAoSL1eifbzxbqMH2X2g==
=WbMP
-----END PGP SIGNATURE-----

--igb3IckrnkWjROQ9--


