Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678DAC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCl6l-0001RA-OF; Wed, 07 May 2025 16:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCl6h-0001Ot-DF
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCl6V-0006Yg-Pj
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746648649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjPv1iFcP/fVSIBXcu71YmzrCiUhHTHr+OKAEh1p+ns=;
 b=ZOsB5zd6m6X0hzfcrlzxx43IHaVmGNaFcdirxmaL/X6KTNKGTSqTKYTnTpiJ96LYvnMLBx
 k5DDFVfWM4H10BCu9p9tntGI+BxuA2VBiN98r5axdKrkbgh11sKmN1xx9sgfZKVlvA1zLX
 2zAKt46HJI1jL9HZsWBNRS4vtz1imJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-wbU8PyJkNFyy_1T12HCzrw-1; Wed,
 07 May 2025 16:10:41 -0400
X-MC-Unique: wbU8PyJkNFyy_1T12HCzrw-1
X-Mimecast-MFC-AGG-ID: wbU8PyJkNFyy_1T12HCzrw_1746648639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDC619560BC; Wed,  7 May 2025 20:10:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.248])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E07DF1956055; Wed,  7 May 2025 20:10:38 +0000 (UTC)
Date: Wed, 7 May 2025 16:10:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] target-arm queue
Message-ID: <20250507201037.GA9193@fedora>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a0DNhwSHNas+mm3C"
Content-Disposition: inline
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--a0DNhwSHNas+mm3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--a0DNhwSHNas+mm3C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgbvj0ACgkQnKSrs4Gr
c8h/8gf/ZqfleWFmrE/gAMqJfvjoXAGOoFZvsc8lpYkjxa71F8l0tl4cYl2ekKOc
elXkzSdyxyOsuPKWNb4dGTN7Qd+oiQgPEoLxQ2nQU1Vw+yBoUL5eEZPHwyPxP8L+
qbmc8RYoTTghk3FFGfgpDXYRWEC7JiwnCtnc96zaONRiBSM6jdHg9bxmP7ypdA2m
pX0wsbY8uWobgjFQllefS8ziR5hv6Jl6psGAwA6+y/1xAxSORTu3qBAKBE+CjRKe
7kru0ze9iRiNETGIW1LXFpcD5Kh6hvL2o4oiiDD7RiMyXrpN32LPjQ2Uzg1MzvLl
Rs3kskQXuIV9uCfz3YixApnQMvDx+w==
=cJUi
-----END PGP SIGNATURE-----

--a0DNhwSHNas+mm3C--


