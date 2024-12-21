Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27330E7718C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP3em-0008FC-NT; Sat, 21 Dec 2024 12:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3ek-0008Ei-Nl
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3ej-0003zu-57
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734803567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmFRwUlFcoCBftA+iyX7a+YTYesm6+7B5B7bbQsC/lU=;
 b=fyo++Ac+FN+cQNqB+DmVAu8APhBWhJ2i8yCbEZFzuSDOKeRMqlCqNmsvx/x0sgY6sJwsPY
 ZC1H4BWy6CTjG4JXwBGud6YJ5+ocxWEcI2j4qnQaEp0ADBQydHs0H2S9vkM16hKZs2gbIX
 p24nFlId6Eg8dAxcBcbl7gwDmCbx1nY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-2RGJxoaZMMOYxFe7teonLA-1; Sat,
 21 Dec 2024 12:52:45 -0500
X-MC-Unique: 2RGJxoaZMMOYxFe7teonLA-1
X-Mimecast-MFC-AGG-ID: 2RGJxoaZMMOYxFe7teonLA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F04319560A3; Sat, 21 Dec 2024 17:52:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7A7719560A2; Sat, 21 Dec 2024 17:52:43 +0000 (UTC)
Date: Sat, 21 Dec 2024 12:50:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/59] Accel & exec patches for 2024-12-20
Message-ID: <20241221175042.GA857280@fedora>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1/p9Yf8k73pVSdYK"
Content-Disposition: inline
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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


--1/p9Yf8k73pVSdYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--1/p9Yf8k73pVSdYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdm//IACgkQnKSrs4Gr
c8hplwgAodNPidLR6TJTQjUuH9p8apUrIssvKwX0gfsvfcVOZRewWGGuGr47XVqf
RW0a3IJE3ptCi5GWN/FFb/+DLWnHPy+jeXZmYZTMRK8ZGe6jhQbFVZYgiRa9bx+e
a48iRiVF/wMBtwKyfQtDwUABUuxnV9CeCeEN/VFKkDQ2J5zq2xzloC7wjHF+qHMR
DemLHeC6+4UeI6TKErbVar06zau9F5YWj852At2M/jbRmLB80J22a4gLjYCWgjUK
QHW23Yz5nfheMHbbPQPjOw61fQKKmiCmYpZ34+3Tl4+APfxea7eS9W0r5n1wZAOC
PJTkd/t4NuJvu5eaN1RpyenEGFREJg==
=WIlG
-----END PGP SIGNATURE-----

--1/p9Yf8k73pVSdYK--


