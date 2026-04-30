Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75EFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVJ9-0003H0-PN; Thu, 30 Apr 2026 13:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIr-0003C7-OR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIq-00005J-AI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPqhvnOIZOoBKwvRX+FaVd0Hs3tgFfY5FwD78sA2LWg=;
 b=Q5Y36ic6tf8B9mkr7rfwVXrULr+1FBdckBUKuXnI1gsaW7s5KNIzY89RkHadSqbs3upMy6
 BVz1SOjK50UKJ1KxoYUHMt8naeANC5KVAOIeUB6rdB6iCo9GAn51iVC/vtlJk2clZUh42m
 KQPcN64THo9R3sNXbgLp0/UWGo9rHto=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-gf-QWh4HMYCsXdKZ5Zcnzg-1; Thu,
 30 Apr 2026 13:35:52 -0400
X-MC-Unique: gf-QWh4HMYCsXdKZ5Zcnzg-1
X-Mimecast-MFC-AGG-ID: gf-QWh4HMYCsXdKZ5Zcnzg_1777570550
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD8C1956052; Thu, 30 Apr 2026 17:35:49 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069DA1800577; Thu, 30 Apr 2026 17:35:48 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/3] tcg patch queue
Message-ID: <20260430173548.GA31818@fedora>
References: <20260429220155.24546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z/w0HNV2TcSw8rR4"
Content-Disposition: inline
In-Reply-To: <20260429220155.24546-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Z/w0HNV2TcSw8rR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Z/w0HNV2TcSw8rR4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzkvMACgkQnKSrs4Gr
c8iO2QgAnpfcGX65hLssAOWvHYdp9IGs3rxcfmzAO1b2Z/z5yJ+SVH5iIqUkbtlh
QPWZ5sMHF0eCtTJg/KjmCR6UkxFMmjGmzDVseViPodpDuDRrgNifY6v9E+S+IRA7
z8Q35R5imZrxJRoG1O05Ov4J/lxruWvBfJqyzI8i5+PvOXEE2HCB57nsTRvO/s2e
fx7dDHYu+1i2fouCkByoNyWn8JLVPK4MlL7p88enEsUJzTnbylhQmaQoxOdPi8a6
4WFl4kcPTLNE3uj1UCHHlWXY5EZRugLv2m3le8IjUMNucxmKXsfakNKD6N5PQ3RP
7Ke2rtRxa+1bn5wP6K4cyUOnx7acqw==
=6r4q
-----END PGP SIGNATURE-----

--Z/w0HNV2TcSw8rR4--


