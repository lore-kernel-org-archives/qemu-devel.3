Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB58C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNBQ-0001Z1-W7; Tue, 20 May 2025 09:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNBO-0001YR-Er
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNBL-0001ft-AN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747748338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukde8ayEduPbCa9lC8svME/6rNhUNLp2a9qMuY4MrPo=;
 b=Rog1wL/pOLCd8ZCOuvccbY+mVwfE/1KDvMXqRb4423VRsG84kEfaFnC01/PPZW4QjYTkjx
 dCndh2YSMNUkQDz7t3/aolTmTiZU3NWUW6g5K077nAGUtlVLY5zGZYodz85NO7iKcsrlj8
 REXrgOJPyN+hs6/TB6lSDSMXBTXlw3I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-d9L8rLBvOV2cb497L2zolg-1; Tue,
 20 May 2025 09:38:54 -0400
X-MC-Unique: d9L8rLBvOV2cb497L2zolg-1
X-Mimecast-MFC-AGG-ID: d9L8rLBvOV2cb497L2zolg_1747748333
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D70CB19560B1; Tue, 20 May 2025 13:38:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2408B19560AE; Tue, 20 May 2025 13:38:52 +0000 (UTC)
Date: Mon, 19 May 2025 17:17:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/6] Python patches
Message-ID: <20250519211718.GA58576@fedora>
References: <20250519170055.3693275-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jf80UbO3QUKPRyfp"
Content-Disposition: inline
In-Reply-To: <20250519170055.3693275-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.487, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--jf80UbO3QUKPRyfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--jf80UbO3QUKPRyfp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgrn94ACgkQnKSrs4Gr
c8hd2gf/ZPjRTqWQ8/w020RYYUu2JT6NhdTrKhDDw41IBARRJnLVOEF1klUDcqOA
2q+lCD4ElL6MfjClJdgMBmchzFyhckLP1tLMvwLw2x20hJ105V5d7ylcltzvQqVv
AuPa9i8TgF77tai35AVpSY6rnB33eLfegWYoAeHeg58ZCl8HLoC5632wxu3KDevO
fMOQpQOTevXcXxhc2XLadPlIZflP6YOIv0KNvDzEfL21x7jH/9U0FGOvk0fLLL5f
f6KQ9Z/4e5BBVIDTFu8zkjlf4BwUXSjEl1d6Gl7XM0I46osh8MySYtpwuIphrDd7
u8Qi5m/Trg2sXYp4oXFw0QQhEQ/xqw==
=7J2D
-----END PGP SIGNATURE-----

--jf80UbO3QUKPRyfp--


