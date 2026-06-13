Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF6CCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8cd-0007uA-PZ; Mon, 15 Jun 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ8cN-0007p9-RM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ8cE-0005c5-JB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781534906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tm5eGTJdKnfEKzHqPaouKQ2Yh8fsgZc5vt8wHmsohcg=;
 b=WRYPTYVnGDMaiPQe1AKUjmJXQj9rTimAJcNv98xK80/kCZvNFTjf+JL8WhZvmlFzWxDA8c
 iDhWLSXFrUf35IwhQ4r84cbFZ3PF4zqwcYZtD4pt/I5cnKctdVZrOFbjGXDNkMI4g8hwSB
 jZBlSeRULtvz7pPg5DA7w0FlBA7GXcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-FY71a_I5M-KKDCpX3WNePg-1; Mon,
 15 Jun 2026 10:48:19 -0400
X-MC-Unique: FY71a_I5M-KKDCpX3WNePg-1
X-Mimecast-MFC-AGG-ID: FY71a_I5M-KKDCpX3WNePg_1781534898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485E8180267F; Mon, 15 Jun 2026 14:48:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAD0C19541B2; Mon, 15 Jun 2026 14:48:17 +0000 (UTC)
Date: Sat, 13 Jun 2026 19:40:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] tcg patch queue
Message-ID: <20260613234051.GA360279@fedora>
References: <20260612175033.58007-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3u+BRhI1kfMgk/kQ"
Content-Disposition: inline
In-Reply-To: <20260612175033.58007-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--3u+BRhI1kfMgk/kQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--3u+BRhI1kfMgk/kQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmot6oMACgkQnKSrs4Gr
c8g71Af/aQVMCRCiNZnwI8q+QtuyRZQz+Iu+SbV3Ip4Hko510DtscWwysh5NKqBi
otMJkgp5NbqCelO4SPsIw3Q9QLRwqBMKVHC2bFjGRamBE3pK6f3xenbiydDLj5CG
wNIuwo3/GMn1GUrXEn1jf/m9CwbiewQgntmY2XUp+i8w2xJ721vkL0vCmz1TRy9s
EZFBipJhxwE53K6G3J4a7WwCHudwaFuPMHyv/akU7JePI6M2OtWKyEnAtS/C3Dkh
B//SwHpeO4IplKDpkbfuGjpEWJ/54GIVxFoeFK88BZTVVuuQPZFEwyMaN6xPQriU
N0qIaKru4YqmUD3QruDv0fAlCISeYQ==
=rOfw
-----END PGP SIGNATURE-----

--3u+BRhI1kfMgk/kQ--


