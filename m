Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C194C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYPA-0004GB-Tn; Mon, 10 Feb 2025 13:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYP8-0004Ft-Fb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thYP6-0003o0-Qx
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739211667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JhxeWK7+rYJv6Ds42FD2PCvLeOuAuMSV5JQHd0f8b20=;
 b=FnnvWddNldOLQUbptc8itajLyykd+AbvtwRAt7tunLP+wb243eAAacrBgNlURA/VUcwKN1
 GOCY1XaQ1qLA2gYGYB+GnjPlpUcsJLLs0fjGR8c5oS3RU/N1nSbM6/BN8qB0UqC+G+lHgg
 KjzIOuQpiH67MycQHQXbR2HQo5G+pjE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-SWOX3942Nh-_H0ZeVgqIOw-1; Mon,
 10 Feb 2025 13:21:04 -0500
X-MC-Unique: SWOX3942Nh-_H0ZeVgqIOw-1
X-Mimecast-MFC-AGG-ID: SWOX3942Nh-_H0ZeVgqIOw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5CDE1955D4F
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 18:21:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C5AD1800115; Mon, 10 Feb 2025 18:21:02 +0000 (UTC)
Date: Mon, 10 Feb 2025 13:21:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 0/9] Rust, TCG, x86 patches for 2025-02-07
Message-ID: <20250210182101.GA118292@fedora>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Xvzk6MWmWb2w1eG"
Content-Disposition: inline
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--9Xvzk6MWmWb2w1eG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--9Xvzk6MWmWb2w1eG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqQ40ACgkQnKSrs4Gr
c8jhoAf+LnKOTHue9XW2lJv/gBHnAgN6I2oC80aU4qCNIsq1/MACI6/tlf+rH/gk
IR2PDFAACWL69itPy7K6zQ6SgzAoO1FPDV7/LrmpKGerA6Xr1r/udJKIcrvtManK
cIgsf8w8VBVt0xenqs7l9fyEscWduRK1638JkNwR1JeItXc7BTSAGAIjR7KBm8al
jU5zMPmB6EjwNP6TFSp5R9XVKHqg3TZuqg1dTkUZxs3oiClgIExtuwbt1pDmbsiK
NaE/DSXzAQ5Y0VX3zkHQbDFXGqnI3cDQuOC63lNJOUyCY6XQah7e7ysQNg3d6sjg
y3jBn3nyI1NJXcE0jD7vuoPscGPyBA==
=cTSX
-----END PGP SIGNATURE-----

--9Xvzk6MWmWb2w1eG--


