Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA576E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuQj-0000rF-Kz; Thu, 12 Dec 2024 20:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQc-0000nB-IG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQT-00037c-Ub
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734053103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBgOE1GQd+62Mr1uCDbaaB8qoYu/cNXThgmIyVWFcgM=;
 b=crLxkI6hUgogwrAzmmFhh0CB8sOBC3Dtg2H5Wgq4r3xhtthYmUpChElD70/6jTThxrxqw5
 1rq9BvjS0KEBhQLooq8Ot8aA5HxCfZN0e7ENUjOBTPlqhTYaEit2/4RAmaN00dnJAp8Yni
 XTD7SDyi3A2YBW5cFuZgTSptn/FtzGw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-WHW_Cwy6M_qBiav-juaq6Q-1; Thu,
 12 Dec 2024 20:24:59 -0500
X-MC-Unique: WHW_Cwy6M_qBiav-juaq6Q-1
X-Mimecast-MFC-AGG-ID: WHW_Cwy6M_qBiav-juaq6Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87F28195608A; Fri, 13 Dec 2024 01:24:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C758B195394B; Fri, 13 Dec 2024 01:24:57 +0000 (UTC)
Date: Thu, 12 Dec 2024 20:20:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/26] First s390x and functional testing patches for v10.0
Message-ID: <20241213012028.GA395382@fedora>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PVtSF1U52KJfXO+C"
Content-Disposition: inline
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--PVtSF1U52KJfXO+C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--PVtSF1U52KJfXO+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdbi9wACgkQnKSrs4Gr
c8iTPwf/SSsjVRPsWXriTP1xL5wyFOhcGm5gi9Pdif0T0bvHCD043QA9FdioLpt7
z4mh+w/RbcQBYm9mmEs0VbZhtPJ+IlNuJpBHANVadKj1/Hn0ek78pNruOoL/Ie+8
XAsEuUAdVJE2ivRJLRHLJUY2p8HcN7lBqiQ27RUdpUXyIQUZ1U/H92aZw/DlfiU9
B2ldYAlUBUuaJZIXkup7hfb2xbDpo6d1922S0GaVwPocWrw6Uyf2LATlzko9aJn2
7Gc8vXATVcssytxnFD+RtueobP8BIFc/e/p7SX3wmn+zlwfEVkq6nQuFy5E8A4uW
F+03e+IO0ACOVjGrwpiA8BR0kN5JlQ==
=O/7x
-----END PGP SIGNATURE-----

--PVtSF1U52KJfXO+C--


