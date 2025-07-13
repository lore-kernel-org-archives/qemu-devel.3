Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC0C83F25
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 07:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqpV-0004cU-Bz; Sun, 13 Jul 2025 03:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqn9-0001gW-6b
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqn6-00075e-8S
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qba/B8nkcDNXGY5H4F6ir2AhfDTclCqsUcw1qO1N4Ec=;
 b=G8reK5SOLhVTXmhsJq9AGOBwwqlfF8l64VVSbcmn2WIUuD5MDGXOc+Vc2pIFp/lnex7n0z
 ppB3dzQK3RW0gDvsylIvBrKw9Qb1l1VETKLhDaBbnv9UvTVAOSGfSbhhnUOk75Anvvl0LJ
 anCRYvrR0D9To0JMLFR7hdbAtTx+WxA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-MJ2jhx_RO5yZERCtBY2b-Q-1; Sun,
 13 Jul 2025 03:06:19 -0400
X-MC-Unique: MJ2jhx_RO5yZERCtBY2b-Q-1
X-Mimecast-MFC-AGG-ID: MJ2jhx_RO5yZERCtBY2b-Q_1752390378
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB7B6195608B; Sun, 13 Jul 2025 07:06:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE9FB30001A1; Sun, 13 Jul 2025 07:06:16 +0000 (UTC)
Date: Sun, 13 Jul 2025 03:06:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PULL v2 0/4] loongarch-to-apply queue
Message-ID: <20250713070614.GA204568@fedora>
References: <20250711071302.742014-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F2BFyLzL11Zeibmj"
Content-Disposition: inline
In-Reply-To: <20250711071302.742014-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--F2BFyLzL11Zeibmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--F2BFyLzL11Zeibmj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhzWuYACgkQnKSrs4Gr
c8g5Qgf+Il5q6VviCProEysBh8inAekTsuI9KGqLTp4M98WPIL7rGcMq8SXVOkl0
bs+xCz6y/kOlp3ZUGIZnwv75tcLuB5sD90VeRq11r+Qw0WO9JK9NDYPpfRRP3sRG
MxxzvyzFT9FDoNDJVU8fQCebUCu87Dx9COjcSZwXBL7rU+QW2D5KA09kRow5QZFc
dKXiik3aBV2MbCyzt1xeCprdCtjSvK3edGNCmqvFyO0VKjaw9yY59Lg5/3Kr23Yp
BhwKNMuDhWOv9Vy9c8Zy/ctOOc19yPNMlTVZQWp92Comtilh+cjteeSWApZUPO83
Mb899Wf3mwBZXD2xy4V6/wqar0uSSw==
=tiQ3
-----END PGP SIGNATURE-----

--F2BFyLzL11Zeibmj--


