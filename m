Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFF5C3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS7V-0005aP-4q; Thu, 04 Jul 2024 15:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7I-0005Qr-7l
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7F-0005yp-So
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720121257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHV8wl+Pus2NH49jvpcoUty6bro1WXgA4OJ/Kgs9kt4=;
 b=cvYDl1T95WO8hgmg9pgecUUlCer/1T315jRgQSKL4nVRj1y8rzLTMP19KEq8E1/6Hhj/LP
 ly+YMXMjUYkusBgkMiVwVt9ipCruxJTVHapqTc6ywip23dwwxvJX0q1hQz14Sa9tpxA5/u
 8XGlvP5NXbUTzGeIjSaiTREWkSoD/Js=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-2qGrhBxgO6OaUnX2gfNwTA-1; Thu,
 04 Jul 2024 15:27:35 -0400
X-MC-Unique: 2qGrhBxgO6OaUnX2gfNwTA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B1921955F44; Thu,  4 Jul 2024 19:27:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F9D63000180; Thu,  4 Jul 2024 19:27:31 +0000 (UTC)
Date: Thu, 4 Jul 2024 20:31:21 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 09/10] hw/nvme: add reservation protocal command
Message-ID: <20240704183121.GI2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IMlp+wL29SW9zATo"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-10-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--IMlp+wL29SW9zATo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I will skip this since Klaus Jensen's review is required for NVMe anyway.

Stefan

--IMlp+wL29SW9zATo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaG6nkACgkQnKSrs4Gr
c8g8vAf9EOgcyMtRE5l5IJto/yD53wnm5rCWJTZofp55JQ6Ozx2HYup9OLrdU0Dw
1MfRZdOOmT8oraNYtZhTDlEvY/As8gVwH+66jayEDqXNRh7oJCYxcQW7nBNfpwTJ
oLn2r5bv3eHm+dc/tuLJSeZA5SLp/SDF+rMR3Zh3xsFinebrHFbUQPjX+nc6sw5C
9qB7xVrMYxIYBDObYFTeJvJ9DGl0iOvpv0at5Aq7syi+0VeeEshAccvPWJe/0lvI
eTJRFz1MLv6fXQQNvqhh27sSY15CjQEVSpNLlgjmlN9ZOYwthjtS2L6Ys/K0O7V8
TviElI89sBwgET0m8vDjsHpE3GSYGQ==
=JEGm
-----END PGP SIGNATURE-----

--IMlp+wL29SW9zATo--


