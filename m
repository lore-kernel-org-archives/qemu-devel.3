Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85214C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taa5A-0007jo-Gs; Wed, 22 Jan 2025 07:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1taa57-0007jV-21
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1taa4r-0004rG-Ul
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737549803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxBO5MwNbvCqH4gqnD72gQhqt5mGgaJSYPuyRBKECnw=;
 b=jHtOT42NOB9NUWrb5FrFKZnaUnYwcRgDthVh8FfA7FxU3BwMwSfWkYVqUThE2u9xzMJ9+l
 q6zJDBCUiKNUb3DwpwmS0iZdbaNnfVqqAvWQtFVTgNuwYmdqNKPcMvVrWeRZGTqgIimody
 lSkpk/BPzk75oG7M5K2B1X248ogy7NY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-22y8l-9DMhKJLSy6Jl_OiA-1; Wed,
 22 Jan 2025 07:43:20 -0500
X-MC-Unique: 22y8l-9DMhKJLSy6Jl_OiA-1
X-Mimecast-MFC-AGG-ID: 22y8l-9DMhKJLSy6Jl_OiA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CC921956050; Wed, 22 Jan 2025 12:43:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFB7919560A7; Wed, 22 Jan 2025 12:43:17 +0000 (UTC)
Date: Wed, 22 Jan 2025 07:43:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/68] tcg patch queue
Message-ID: <20250122124317.GA153812@fedora>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eTL39CzMVsxuuzwT"
Content-Disposition: inline
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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


--eTL39CzMVsxuuzwT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--eTL39CzMVsxuuzwT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeQ5+QACgkQnKSrs4Gr
c8iFkwf+JKEd8rcsjAuV65wT1S081E3R9BJ3Bmv5gDudsnb+bvBS/4cWrJa5ZBY0
C69G7Q/DRZH0M6mkfzFnd5sUvOtWRdAJ9zsy17X1wiqWyI93O5C0L1uFHp103mFm
79PaujfKWG5TJfFHP3kdI/AyZ4xiXyjObIdVbMYKP4QCdekEpn42s7WmQ340RZ1G
2nZs3TqyBR7q9aj30J3sZKUvo+pr7TJ1ZlafvyOHv3RpbkX0bxdDBHinlQ+pLUke
H5F0eF48/WKGrXNMtsmvHTjDeDnjGOU5YsSppJ6NI7MMWRUSBGlOsxO1QEI+CQ14
z4yFAibXeXLUgJcBnzTKCfWZ9cPBpw==
=d1j5
-----END PGP SIGNATURE-----

--eTL39CzMVsxuuzwT--


