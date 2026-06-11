Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3161CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXktp-0000K6-Nx; Thu, 11 Jun 2026 15:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXkto-0000Jp-KX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXktn-000784-98
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781205426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2Kz6KTNsc4Iu/3mMO3lu2s7tZAfngcBwZM0nTWTRtA=;
 b=IPaIndSjCg4tW3ceqRWwCWfQLIn/vPGGoF/urrkyujUymLmA15dn/IvClgN+G2aTojpymO
 RDf8R0pxqC6D1AAEB3JQGUCCxVMlM7ZwYZLFadtWBCo1QQ8s1YdLO4Q6Y+9F0ohH5Kuy+g
 SNrojyPliQIjNGivTk/DWXxnR+bsTT8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-HqIQIdvjNqCRZ6Eimd89AQ-1; Thu,
 11 Jun 2026 15:17:02 -0400
X-MC-Unique: HqIQIdvjNqCRZ6Eimd89AQ-1
X-Mimecast-MFC-AGG-ID: HqIQIdvjNqCRZ6Eimd89AQ_1781205421
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4FB119560BE; Thu, 11 Jun 2026 19:17:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A13B1955BC4; Thu, 11 Jun 2026 19:17:00 +0000 (UTC)
Date: Thu, 11 Jun 2026 15:16:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PULL v3 0/8] Linux user patches
Message-ID: <20260611191658.GA228529@fedora>
References: <20260610164549.5699-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5E5ShtZS8t5+Xtw"
Content-Disposition: inline
In-Reply-To: <20260610164549.5699-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--G5E5ShtZS8t5+Xtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--G5E5ShtZS8t5+Xtw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmorCaoACgkQnKSrs4Gr
c8g+fQf/bjuvaJJVaqDi9f/UwMvb8K83zELQ3Ynxk6mGTR9ASymsdSKPAPZ/qW+t
HnyqVFQ1keNUo9ezBv04pr9/odZod4gVxh8vJ6GVA2hp60Q6FlCX/unh64Lhp7H1
O1LaH9ptr1Svujrvm1UklbaLBvMvepkEDpdyWqm46r2wm6TyS74rSPcvtF2SrZXW
n6YVKBkuo87xorFw+ISRh6ctTQiipHrDOLzsjckqaYLFH87TcFiRMSRqWK6bORMr
Ox71FKxfLas6nSGgcfG0xNbkIGk/5Yxaw7+w2h11XgWLaWASZdOswBUdh6hq0+li
eiu9KOHNzlLUEQqA2/B0Sdh8wVsEeA==
=ddFv
-----END PGP SIGNATURE-----

--G5E5ShtZS8t5+Xtw--


