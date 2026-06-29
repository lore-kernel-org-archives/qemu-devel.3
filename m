Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D6FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGj9-0002dv-5P; Mon, 29 Jun 2026 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGj3-0002ae-4q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGj1-0003qu-R9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/0AgUGRv95JRFpd3bzMaQYpolq/O60EXtUUcGEZzPw=;
 b=CBvPssqTpH0BsKZC9QOJvIZsq5QQYRa5R+p7ZmWekZGsVVbZc54m+ahd1J8chQG4J/0ZY8
 6cFj53MT60vye5v/taqDbrZciXQS3rPF9fNLsDNcY6HTt+ZG7Jp+a7xjoIt1Rd4SlBTIlV
 2G4XZTEBhvVBsQGv+FN2LbH2uWa/h+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-uLizxdOSM7uB2Okw7HDxBw-1; Mon,
 29 Jun 2026 14:28:50 -0400
X-MC-Unique: uLizxdOSM7uB2Okw7HDxBw-1
X-Mimecast-MFC-AGG-ID: uLizxdOSM7uB2Okw7HDxBw_1782757728
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 554221955F18; Mon, 29 Jun 2026 18:28:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44EA53000B55; Mon, 29 Jun 2026 18:28:45 +0000 (UTC)
Date: Mon, 29 Jun 2026 20:28:40 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
Message-ID: <20260629182840.GA383283@fedora>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yYgBD+YxmpdyQssR"
Content-Disposition: inline
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--yYgBD+YxmpdyQssR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--yYgBD+YxmpdyQssR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCuVgACgkQnKSrs4Gr
c8jJBAf/dsEU0y4JRATk02YOqUoxN9NsWaU3MkskaCewZTV6ti9GRpd/ZmnwDafW
88y6YAfK43uD1FIY51gP4FSSzxkYo1ygsehPz89o0ByWbdxTyyhnnEpr76mXcJI6
ZmiyABowf0jnBaShK+qMOWFbVoTyh7olF8MM1W1sS3mS7jRh0/8j15OSJwUTaXv0
qJgpDz1uf6Js2wcTP5RfUdBd5jBYd/cSg+QOHkfp42t8DRi44gJTOlpRTEanH5Vv
30t3E0ojo+t+1I/2LSvU/180p7hs1U1bVsO2y0eVfQcsiShkAwbk0z97hmjWVUZ+
tkcHZ9l2HT+XQO+PwAHYEslsFezesQ==
=YmKo
-----END PGP SIGNATURE-----

--yYgBD+YxmpdyQssR--


