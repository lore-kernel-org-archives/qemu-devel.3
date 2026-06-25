Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4DCDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcqf8-00046L-AT; Thu, 25 Jun 2026 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcqf6-00045s-Kp
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcqf5-0007l5-Ak
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782419218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+8oqf1+yYZZsjkKK5IwwMm+A2C+t3xDClHyC+CU3nI=;
 b=DHESxGiGE2VqT8F2B48twqvxp+nqyGDUb84mJy6wo7QgQv8LrFI1C0WVZz1G8J08Kt/Pn1
 4rHe0lk4OtFhx9ePEgeJjMtwErcd4j1YUlUBmJ44pKTbw0ZPU1Z01N1kfn8avS9rbmimjc
 7MLB3C3uRB0PXQDDyR1LI7Wq+FzBCXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-VmsyX-yCMrOMnA28c6sekQ-1; Thu,
 25 Jun 2026 16:26:52 -0400
X-MC-Unique: VmsyX-yCMrOMnA28c6sekQ-1
X-Mimecast-MFC-AGG-ID: VmsyX-yCMrOMnA28c6sekQ_1782419211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F0081955DBF; Thu, 25 Jun 2026 20:26:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.255])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE5551800361; Thu, 25 Jun 2026 20:26:50 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:26:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] CI update for 2026-06-23
Message-ID: <20260625202649.GA265061@fedora>
References: <20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ou6vej50KLdHeNnQ"
Content-Disposition: inline
In-Reply-To: <20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--ou6vej50KLdHeNnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ou6vej50KLdHeNnQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9jwkACgkQnKSrs4Gr
c8iUHwgAvuYNTkvyZ9B3TANfFhyfYjuihZxckEr7dkXXI2kLjZxPy4MPdQSqxvjM
wgvoU081Ip/IkBzTqh3ctwMOjloZ7m82VnRMlpo8ZaaRddM0zqO5AzjlrecBs415
t1owbVbf+XMANtQe4JVh/YHbu+FG+vv5ltlema+EbQrgAXx/q8meoG4+5q04mHwv
Q54o/pcJkH5cdzaUF7sN1+y3vWdoc/26V/2pX44p06l2sFJZtH7MM0clSxycfffQ
0jjo4KsqBiuDjtCMGVJR8+CuZjTudzuUwAHKkSwlNTVvIuIgH0AdD6ChK0OMyzF8
cwMudixg35W52jN14jGVaYLd8nyPvg==
=Bxs/
-----END PGP SIGNATURE-----

--ou6vej50KLdHeNnQ--


