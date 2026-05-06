Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C652CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgrB-0006Ns-7l; Wed, 06 May 2026 14:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgr9-0006Kf-Bh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgr7-0007Jg-JR
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778091620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+xp2JqS/xRFo62uPeqOI5dpVuIx3QJt38W3gMR4ZaI=;
 b=Bb8SUIaKs6KUkdVPv/V0v8j6wKjrLr2HNZPEPyYuXOwhUsxkP/wM3P+BDjwZrPGxS+66cf
 2dLy0+BGVscyuI9wkRDSubG6HA55I6sS7lTPQF4ybDbpHkFrc8rLjRZCSr1gSiO0FD7yEL
 QeFZypBRNPvUyZOB9vAl00xVVfJRNgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-kppGOHCzNAGSQMVMs3HWxA-1; Wed,
 06 May 2026 14:20:14 -0400
X-MC-Unique: kppGOHCzNAGSQMVMs3HWxA-1
X-Mimecast-MFC-AGG-ID: kppGOHCzNAGSQMVMs3HWxA_1778091614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E99AE19560B5; Wed,  6 May 2026 18:20:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 651B4300019F; Wed,  6 May 2026 18:20:13 +0000 (UTC)
Date: Wed, 6 May 2026 14:20:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 000/110] Single binary patches
Message-ID: <20260506182012.GA209056@fedora>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ipa+ovYkQpBNqHM7"
Content-Disposition: inline
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


--ipa+ovYkQpBNqHM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ipa+ovYkQpBNqHM7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7hlwACgkQnKSrs4Gr
c8j6Ngf9HRFZbIjilsBh80n6AhPBFXG9nFrbKeqiRD1jRLPTFhd4yvWmx5y5YJp0
r4BXU+T+hGEocepzkTrbY0H9IsZ+71w9gLyz+wNc6oXA8N8bW0Yc5Vs5TKgguiem
Gtfvhbb0CvQ2uFPyiDvUyDiWCH4+kJ73jwByMTk012Z+4yKXX7rhkIw6wxuiqwUE
R9zutCqEVVkLpgcroiAjUPE/QWhIHPTGnCk4k23iZrZrZkP/Tm4HsMyiM6Zdzi0V
lfsnnebjWoEVrWPOJxVLJWPj6BOWoVTuXaLDYkVWpZAu5UMRQAfbDv5PbjLXcDmi
fNOcGR5SZH9/rPKEQSFgvX/ThtMc7g==
=i9ni
-----END PGP SIGNATURE-----

--ipa+ovYkQpBNqHM7--


