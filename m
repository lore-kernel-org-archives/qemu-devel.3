Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C40BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACjH-0000hv-VY; Wed, 30 Apr 2025 15:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uACjF-0000db-Ts
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uACjD-0001mO-T4
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVsPPeo/3hi9Kp5pib9bQ5vdnnlj6gJq3BCNvo/8WQM=;
 b=SJ7PpOhoGG6N5n+Z4bc19Ia9STINR29fJ61TJPjExe+wljHRxGerj6yEeGIy+nivFl35yJ
 ebUz7E+Cl9q8v9/QDrrK7V4DYjrRHVkn9zytdZ1k45uaOcS8U+NK1YxLEVF3nOHRwGswDh
 +3R5CkmB91nDk2FUfpnY3GBSM9Hu4d4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-BdDQnqm5OSSNpXPM02OL7Q-1; Wed,
 30 Apr 2025 15:04:15 -0400
X-MC-Unique: BdDQnqm5OSSNpXPM02OL7Q-1
X-Mimecast-MFC-AGG-ID: BdDQnqm5OSSNpXPM02OL7Q_1746039854
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F6B8180087F; Wed, 30 Apr 2025 19:04:14 +0000 (UTC)
Received: from localhost (unknown [10.2.17.53])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2573319560A3; Wed, 30 Apr 2025 19:04:14 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:04:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 000/161] tcg patch queue
Message-ID: <20250430190412.GA65517@fedora>
References: <20250429174320.1841700-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yION2rIz57In7yks"
Content-Disposition: inline
In-Reply-To: <20250429174320.1841700-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--yION2rIz57In7yks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--yION2rIz57In7yks
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgSdCwACgkQnKSrs4Gr
c8g9QAf/UNXxexHyUt19SJM6XK3sA2kptUCc+J4pn5uvJ4LbyKQrC6Qw2F2BmO9g
DgdGOPu/OkHBirTiaiopzo0R6o4ayWuJTJUh6L04/9xxDl/GnsFRg+8aRpqQzu4R
nB3i+wevFKmAyW4NtBxER6uooCrlj23jvpq2nalK7W/LJpKSNb7HI1w2AorqWB9f
ZyxI8XGgTF7FH4MkMMEeEMouw6ZmB3xrevZylgp3jkrecPzy35trWJnsf/pqtCmB
EtYYHPpWq/VnCGYrTPM3fUQxwf4OwSa8/SRBZZr76jSm1wviriadBqKlkZkkdSxA
Mvxh5ThaJmCc4jN1Zz3X/92uPrMiyQ==
=BvyF
-----END PGP SIGNATURE-----

--yION2rIz57In7yks--


