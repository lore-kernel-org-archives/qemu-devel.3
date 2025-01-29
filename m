Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6573BC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 20:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdEcS-000467-2y; Wed, 29 Jan 2025 15:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdEcG-00044m-4l
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdEcE-00016m-KF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738182288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iqrebWusiKDKbXzQ/dfuOvpGvWxGw+HqkWLlOCM6VOU=;
 b=Dl0tiTLdYqZNOaF3Ccw5yrTNPRKcEVm3mRv4XEkP8MZAAA1kN/5YuxqpWjMT26P+5I5g28
 bjKUStJUXC6wM5i5afpZhHohjlZmHqOD+qv9e2+/Va/sWhkGdOFHKAdgDETCeJpuM/URTM
 pTjV+zpgumbmKBbP4d9G124yqNR8AZc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-fntTB4S4PrKJohtctnhChg-1; Wed,
 29 Jan 2025 15:24:45 -0500
X-MC-Unique: fntTB4S4PrKJohtctnhChg-1
X-Mimecast-MFC-AGG-ID: fntTB4S4PrKJohtctnhChg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7A5180034F; Wed, 29 Jan 2025 20:24:42 +0000 (UTC)
Received: from localhost (unknown [10.2.17.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08D8719560AA; Wed, 29 Jan 2025 20:24:40 +0000 (UTC)
Date: Wed, 29 Jan 2025 14:17:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/36] target-arm queue
Message-ID: <20250129191743.GA193481@fedora>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="48KAmklPXh+OWBah"
Content-Disposition: inline
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--48KAmklPXh+OWBah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--48KAmklPXh+OWBah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeaftcACgkQnKSrs4Gr
c8hxowf/ZnTB9je361X5qpj/5RdLkPHx0f4zyEytvruhVNB7uIgeTfXW+5su2yhG
g6V2VuU6qypvjs1OTgyPsRf5sKm9ghAao+qaYxdR/aE5y2o8bKrwgqnANvC1coMZ
EIPtFW1MYd3sryPqLMghlHXflggs1k+HHwt9xTz0HBr4WAjcmGKi5fcz8Ccwappz
kIA2VK72qwEqbZ+YFQyp3y2E/hyiLT5x1xrUnww0BrFCRngpm01zT5JXr/g3ayMa
2EEqoAhQdTGytSM8Epn87iP2qr5dnKNT24dfjuBXba3V/LSQHrFNmf7+Ym53kNNU
2T//iEdOkY+fet6YfloJztYGAZm74A==
=MxZU
-----END PGP SIGNATURE-----

--48KAmklPXh+OWBah--


