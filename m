Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3349C44525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkoG-00046q-SL; Mon, 20 Jul 2026 06:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlkoF-00046Y-0A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlkoD-0004Qq-Cd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784541672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gtmJEmy6yimi+cbH+pChXLKQ1VxAIylLK5cEoPfqmr0=;
 b=AWlB5O9G+ykWMxk2C7M066GZxXEAd1Gd9yG/9eWRQXn+tEw5NVkmixGNQB6oiiJD754nw/
 ghDGnPfW3EWPMExQtS118U7riv+3WHxeXXnpkIqIkQUATYZXdWjFq11o6CQa/V/DiCX74w
 Soc6saUu7nPgYWzsK/Kf5XpwnoSaqBg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-iF8xaq6xMGy7ijxYT-opWg-1; Mon,
 20 Jul 2026 06:01:10 -0400
X-MC-Unique: iF8xaq6xMGy7ijxYT-opWg-1
X-Mimecast-MFC-AGG-ID: iF8xaq6xMGy7ijxYT-opWg_1784541669
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8B561955F6E; Mon, 20 Jul 2026 10:01:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B8651588; Mon, 20 Jul 2026 10:01:08 +0000 (UTC)
Date: Mon, 20 Jul 2026 06:01:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, stefanha@redhat.com
Subject: Re: [PULL 00/12] Hexagon fix queue
Message-ID: <20260720100107.GA816167@fedora>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zrY9Yk7YB+PugLGc"
Content-Disposition: inline
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--zrY9Yk7YB+PugLGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--zrY9Yk7YB+PugLGc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpd8eMACgkQnKSrs4Gr
c8hqkwgAx/mxrWh/oKE5wxGg7i9QUe/D45pkuya9C1XnUKVFcuTFjDc4oRQpPUZZ
+2tF0NJepoRgNen6ug115MUtLx1mVRzOGQReQxUo9IJZtExvIN1vjSPn+MpQbw6R
rZVDF87TdUn3L3Vy7Y1eXO7so6gXsswjklPrlw3OQTSOtOu9kTS0SQWEqCJxJxov
LFlnmdY8jrpeCW+t6fNHp9QzxgZW5kvQ50r2MH+gvmPtdnNZsNoZ2qii4Woac0sZ
Veu2K14fcW+vqCtw9491owIcdIEZi+Y3QgQ0YLJMgnaRvHIUs539eFtRyrkm9W+E
VT6lF4JpGiOeZTjJHbxGq2TPVkJVPA==
=lutd
-----END PGP SIGNATURE-----

--zrY9Yk7YB+PugLGc--


