Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F591CD6E57
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3CH-0004sh-Qn; Mon, 01 Jun 2026 10:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3CG-0004sQ-4F
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3CE-0005f1-Nq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780322449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VJDCSMfVPqTegNHoN+CdbSgy5Qcx/EoO6ueFGGF7Bjo=;
 b=gbCSmbigXK4VEGxGfchHpdLCyYuu4BTUddE3QIsSXCuZpUxKNk/xta1le61EfFIm7XzBCq
 BC7tRGKss+iBut2vBvg3t0tg2XP7wzGOaav6OfRq1WOZLEhDd7TZUJMC8FZfxByAPc2qSU
 KZurnhO7iIAiKOCa5V6EJYTvwrPzuNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-EvCU7xgkP2elLJr6p3zpOw-1; Mon,
 01 Jun 2026 10:00:44 -0400
X-MC-Unique: EvCU7xgkP2elLJr6p3zpOw-1
X-Mimecast-MFC-AGG-ID: EvCU7xgkP2elLJr6p3zpOw_1780322441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1709519560B8; Mon,  1 Jun 2026 14:00:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2E2219560A2; Mon,  1 Jun 2026 14:00:38 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:00:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PULL v3 00/10] Linux user next patches
Message-ID: <20260601140037.GA410684@fedora>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4prmIe6rGJvkufWh"
Content-Disposition: inline
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--4prmIe6rGJvkufWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--4prmIe6rGJvkufWh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodkIUACgkQnKSrs4Gr
c8gQNwf/YQ4yOVapw/DsX060R5bKfkBlKsFtOWuqN1UqnuiHc4qVhxmpk7j/E9DQ
iV0to+7mdAcKJDeMAd2Cg8eRKcuLVH4Sf2gqFp1AF5bWwhDLQl0TdjazE38MVz0w
uVXiXGZKMXSmhpoDzXGcwyodcAFIdOQpodiu/2q0sCOYy1/r/qK2ttVrAzQM/+bI
1obD5IdkByle8jQytqelO+WEeiEMpQEB7b6/M0n6Dn1iduJY8C8thiZbpq1ezaMq
ck3zPhUmgpaFTE1fvkPyznEoULX8uwfHTNNyOHASwaRhWZln1MIDR8V+7AnmR0Yl
FKEbfq3dfr7q58nZty7dSaVmgk1eSg==
=rVaN
-----END PGP SIGNATURE-----

--4prmIe6rGJvkufWh--


