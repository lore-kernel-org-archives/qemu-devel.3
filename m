Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 22:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGQ0D-0003II-GK; Sat, 17 May 2025 18:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ0B-0003I1-LX
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ0A-0006ja-85
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747520849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Osk7304AWhSm/Toiw8zmeYa3zyLJmwlT2OKgTnTT5o=;
 b=Ad1KpZxdjmmOuem0/ws5R57mz71xgxqOIrAU07/EkXBlA7JWtBxP3mMjEieeuXYUfU7gVS
 MA15FuGqPlb31lAsCg3i/8aBzOwRZlVRJ7lK3+PCgB6FhsWH4CbORAtcgt6/RcF5rCcpuI
 rRbveJqnygkKA80s/ztZxVrNEHy/JJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-nxbPUq0pPjatklyF28wT8Q-1; Sat,
 17 May 2025 18:27:26 -0400
X-MC-Unique: nxbPUq0pPjatklyF28wT8Q-1
X-Mimecast-MFC-AGG-ID: nxbPUq0pPjatklyF28wT8Q_1747520844
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C431818003FC; Sat, 17 May 2025 22:27:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5893830001AB; Sat, 17 May 2025 22:27:22 +0000 (UTC)
Date: Thu, 15 May 2025 17:53:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/1] nvme queue
Message-ID: <20250515215330.GA423693@fedora>
References: <20250515120148.11804-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRtgM7ibc8KYWSdj"
Content-Disposition: inline
In-Reply-To: <20250515120148.11804-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--MRtgM7ibc8KYWSdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--MRtgM7ibc8KYWSdj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgmYloACgkQnKSrs4Gr
c8g0tAf/Zc6BOSPLlmWdBxDGnHfpNEp8DUlw7FuEEmUvObrK3sYe0oeU8+j93sM5
ZzLo+Suiuv+LSvYfMQVLiqliR5Opjzd5BHAApcIy3/yvTJP960leShbnwQJE16HK
rzYrYP3SaPud+ppSKi66LpvnLH5Yoo6aWbm63EEf4W70ZmBG0EfaFZ2SijkxGIre
/PiZZ9prRz4MIE+QOLk+edFNPPQVzLVqF6NhJBuz+RogrYOho2XwH2rqyrWUVcLx
tA5yFcN0h0dnWpiOeBsnNm1c20ToX+h4w/FRglwTmACYGHiC09sCLcIg8AtXhYCM
j2woSh+IqYjCbrshe4KLX8mydlhvgw==
=0P8A
-----END PGP SIGNATURE-----

--MRtgM7ibc8KYWSdj--


