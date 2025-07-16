Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19422C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1WM-0001Dq-82; Wed, 16 Jul 2025 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1S3-0006bi-5L
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1S1-0000Nd-5p
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06YoYnLjv2nvQZl5YA5wtTvuJP2M1i+E9WUF0tyNmJ0=;
 b=hWqd7VgZIQTVNVu9yJDQmU7Dpj+fz3rod5LU5aurp13nYeeD5wag/rKstNq/2z6AHFCxbB
 Rojx9chyHutNT95y+BOeIySgdZBV7HP4frpVRtRcEwOpXY/h0dp0JxZeemROcnjfB4Gmbt
 9f001QF/4YuYBA53DwXzPB5HxdUgLVo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-7pCSE9uNNUmM0j45WDh_wg-1; Wed,
 16 Jul 2025 08:41:26 -0400
X-MC-Unique: 7pCSE9uNNUmM0j45WDh_wg-1
X-Mimecast-MFC-AGG-ID: 7pCSE9uNNUmM0j45WDh_wg_1752669686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 118091955F43; Wed, 16 Jul 2025 12:41:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F508180035E; Wed, 16 Jul 2025 12:41:25 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:41:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Accelerators patches for 2025-07-15
Message-ID: <20250716124124.GA328360@fedora>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HXvPhIMaHt2OlSrn"
Content-Disposition: inline
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--HXvPhIMaHt2OlSrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--HXvPhIMaHt2OlSrn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3nfQACgkQnKSrs4Gr
c8gahwf/TGDBE+4bepIXM/WumQYBcDTRpF+dc/p9RTvw+tLVZMLfhcen9P280svw
Bodivr+Eyj3AKG0hYeSnIvhg10nqnpIl6wmR6j6xiRwiviKWI0lrx4K3CJXkbIVG
S9vAcJn/RjrzmqzdMvdlEX0+qDxCjHOpflCpE82rKmO5z9g1fyf1TPML9TJDZIiB
QabCiaDBpg9QAAWXNQ9opAbjSDA1IzDrnuJ9eZ+dqBXVTWz/2G0H2OE+iQ9v6kEq
+Ec4R+57Mt4yNpGentflcbx8NUaXfUWE/yiQb8t4e3Qse33QaI8WNQbV9Fx7OGbE
zI2QD8g7yx2cCJzajrdr+JstOj0Zvg==
=htjk
-----END PGP SIGNATURE-----

--HXvPhIMaHt2OlSrn--


