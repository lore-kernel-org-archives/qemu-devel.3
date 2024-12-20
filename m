Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADC2E7718D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfkM-0001Yv-P5; Fri, 20 Dec 2024 11:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOfkI-0001F8-Og
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOfkH-0000Dd-89
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734711655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrRHC/6G/EOar4rFTLATSV4Px7fRM4Xig0ejfkJGGS8=;
 b=bSITYr58uBizI6xgQewSdY0q3sQecusEtPTB+RAqyaBE6+MdjeBxIguvbGUaTm2QHhgfuG
 FkhXWDYxvy2WF2Irz0+Unc7QMHGZnv6HO6lgbJZX40E3GXAmu0gbIZVLcV71UnqRsE/CdD
 YxfHeuHDHJYDkadjnM5UGUGQZqOVC4o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-jZy5iSuwOo2V0LfOhzM0wQ-1; Fri,
 20 Dec 2024 11:20:49 -0500
X-MC-Unique: jZy5iSuwOo2V0LfOhzM0wQ-1
X-Mimecast-MFC-AGG-ID: jZy5iSuwOo2V0LfOhzM0wQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEAB01944B0B; Fri, 20 Dec 2024 16:20:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7FE719560AD; Fri, 20 Dec 2024 16:20:46 +0000 (UTC)
Date: Fri, 20 Dec 2024 11:20:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL 00/18] loongarch-to-apply queue
Message-ID: <20241220162044.GA731185@fedora>
References: <20241219075502.3164644-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uFelMDjAQIjmk2oK"
Content-Disposition: inline
In-Reply-To: <20241219075502.3164644-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--uFelMDjAQIjmk2oK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--uFelMDjAQIjmk2oK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdlmVwACgkQnKSrs4Gr
c8i9JggAthJl6cUUSBVOn287hTD+La6yHP06QpvgQls1e/5yDQ1UqRojifsmleth
fhz9pKtndHaQn+J2D/G9PERu4RlgQCj0ZdTdwMzHmbhnMMYGO9I5XX95Is+mnoqv
47t8wqVtfaREhgRO3ZEWA9AppRvY+BRoU1Sbwxz/pltGtrTdqCA55GlGUN2VKIi2
fUu5yhiAeEHoB8eJ5D32BTQ5X5C01FJUxU6Z9WK6JCZYA5nOkydUkG9Y5wXv9HnY
iziZo8mxb9RvOzGEE8Se7Rd+xhLQjQDIMFAaAvsAh7PUZQCXj4AmILfb9gLKr02W
OARcZDX1LjDjpmGmFymKwQNKDP9TQA==
=i/SI
-----END PGP SIGNATURE-----

--uFelMDjAQIjmk2oK--


