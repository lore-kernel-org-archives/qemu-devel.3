Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD419C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxzT-0007iY-50; Tue, 07 Jul 2026 01:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxzM-0007eV-Cs
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxzL-000497-0h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783400683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMrSv+yLREGEij7NgI1TlvfvypYcCdP2iCagwjADSlQ=;
 b=Vy5bR2wDg7HuRfaoQOkpOLjjw3Kg40QtUawaCUqadkCnIklkcbkQfgnpGDgZfplem/uAum
 dFCVwmmqzXeLYgeQ1xL37nt9TUoX3HFLwZFMzECcLRI5jlssCXSL21NeJ3itJJVPaB79SD
 8uE0DsUMG2iweTvi25xAhVNMmypLZGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-0hcHh4oeN0OQDCQPkmOYeQ-1; Tue,
 07 Jul 2026 01:04:40 -0400
X-MC-Unique: 0hcHh4oeN0OQDCQPkmOYeQ-1
X-Mimecast-MFC-AGG-ID: 0hcHh4oeN0OQDCQPkmOYeQ_1783400679
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E40D1955D61; Tue,  7 Jul 2026 05:04:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD76E36918; Tue,  7 Jul 2026 05:04:38 +0000 (UTC)
Date: Tue, 7 Jul 2026 07:04:37 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/49] target-arm queue
Message-ID: <20260707050437.GA524627@fedora>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RN7Tju3pOyIkL+Io"
Content-Disposition: inline
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--RN7Tju3pOyIkL+Io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--RN7Tju3pOyIkL+Io
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpMiOUACgkQnKSrs4Gr
c8hXKwf/dUGi4o4Z2RZ8p0QPxiLPUpeU1VkPU3x9Vv1mt3ojaHbg7NBLPQiaWEyj
r4JHgXwz3pRmOEO5qa+RVVrOWoC6kIPMHZ0FEpt1zGgli40CnspU4dYy9cfhl2dt
oR/gTLMfN2gDwS6UMpDa+ho757dxmMfelrEi+2/ztm3i5nTyj8YrjbRvBACp+PCy
415xvFXy7Wv5jOGq5mm1yHLj1mdSHSqv9gHNwlCbgc/8+hyFzTccOnYVC91WZo7p
0wTgiZJl8Mpbqvidy3OlrSmHQonvzuu6kaRJUVGEcbxalRXR/DnNTMgSD06HrZre
kf5dsHVDy1vcmnX/+SMSr6TCoo+baQ==
=FTuw
-----END PGP SIGNATURE-----

--RN7Tju3pOyIkL+Io--


