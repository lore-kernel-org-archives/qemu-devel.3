Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E9ECD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGvq-0000TW-Vv; Thu, 18 Jun 2026 13:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGvo-0000IH-Kd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGvn-0008Fz-2Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmfP74aOdeclrKfaBj5IW1hYZ8EprkbcWy2gkEHg/KI=;
 b=LqTLZ/5mLUbOCUGUGj3P2UwuKzmRhU3UCuGG4F6H/hJTJf1aL8+w/qXb8j0C7nVglQgXMh
 cJ0EY2Js5fHnN62EKUta7p5S3ygw0SMtahEKIBCcXtpmE5y4b/vVUNpoMK8tZKXhqpFRwI
 ste/PxleP8bXceNhFC8YJRFreZvtCV8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-k5TtPWFNP0qZfiZk07D9jA-1; Thu,
 18 Jun 2026 13:53:32 -0400
X-MC-Unique: k5TtPWFNP0qZfiZk07D9jA-1
X-Mimecast-MFC-AGG-ID: k5TtPWFNP0qZfiZk07D9jA_1781805211
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C0E1955F6D
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 17:53:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52F38195604E; Thu, 18 Jun 2026 17:53:31 +0000 (UTC)
Date: Thu, 18 Jun 2026 13:53:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [GIT PULL 00/27] UI patches for 2026-06-17
Message-ID: <20260618175330.GA748506@fedora>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vus5auDys4ZIdhAv"
Content-Disposition: inline
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--vus5auDys4ZIdhAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--vus5auDys4ZIdhAv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0MJoACgkQnKSrs4Gr
c8hanwf/RdV3EHcmaDz0OWThUh9e0D8Wk2CLq3WSzL0EP/UULsa4OfuDxtv8Z5RW
qu/oPszeGhT8sNVVYNjQXNPilAV0cosWQv0/WkjHVGwiwwwV6hx3JV7n4DQfls7j
IF5hQQcQWrvJRAgA8QgfgkHoukHmEf7wWxBKQMvgKFptw6+e7jDPjxyvd2zSto0z
RHrl4WBXUCgoWn9VNxRPjlYJAFI56o8fKxXHX8sWPbM6Q4HXmKMTQvXHNZDkXhrP
3nkonD+aLmXUrQJY5tvmVWuBL9iaMD/mtCHtbw4GHH2YOYil8zRQeNmKXOJGMgPo
mcdWj5iEumYyfmghBI2XM8f5PGi8Ew==
=AIyO
-----END PGP SIGNATURE-----

--vus5auDys4ZIdhAv--


