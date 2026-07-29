Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93AC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1Hr-0007R0-QW; Wed, 29 Jul 2026 06:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp1Hq-0007QO-BS
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp1Ho-00056x-Bq
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785319995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FyDjsFmcAT0wgrAd0l2qQYjiXKHzzg3DMyDgVlsYRRg=;
 b=MAGymsrSwnt5vGoWwcy9QKvVft/7cRjWfuZUSjBwA3aACABz0vCpjjfRhAfcoVxGr4yuMC
 H0WrAnkHaJGlv0BhgTxuW8F5Qv0ZbNsTZWKDT6xFWxBbY+7A6M580pdIZJYlqYU6OkEqd+
 eHQgDmfYedJjk6vaOEiM/6pV3ndsAlE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-1ZQ0BGovPWeFgNVt60ATZg-1; Wed,
 29 Jul 2026 06:13:11 -0400
X-MC-Unique: 1ZQ0BGovPWeFgNVt60ATZg-1
X-Mimecast-MFC-AGG-ID: 1ZQ0BGovPWeFgNVt60ATZg_1785319990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3B5718002C1; Wed, 29 Jul 2026 10:13:09 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F27B81800480; Wed, 29 Jul 2026 10:13:08 +0000 (UTC)
Date: Wed, 29 Jul 2026 06:13:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/4] hw/nvme fixes
Message-ID: <20260729101307.GA1365019@fedora>
References: <20260728180018.3574-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HjKE82o84755e4ks"
Content-Disposition: inline
In-Reply-To: <20260728180018.3574-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--HjKE82o84755e4ks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--HjKE82o84755e4ks
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpp0jMACgkQnKSrs4Gr
c8glxQf/T27baiC4h1NiSGhPxK7w+G6ceezH5aR0Y+BPUGZcV1PczVyOtACXDfOu
J0TWCokRrEpc72aa5yOEguzhJl4Bt4tAJ/hHJ9tX0Dx/gWLRulcDB4QBmWHdIhnb
RwT5FOB3gn9jytzrFtWRJDPPe3BhCIVTKGhL2wEYcW4gfX3vFaaO5hKcby2/iola
5wmgwz3LzWPJp8q+zis5CsN0dM53FlITbLPg9Kd1IrihB5rhCt3EOl3Wzo3fbBgl
+3AsSq0N5JyRK3TroCny7/cFQLmRpInR1+L58/2H4t8GIXXqgfQ39EhK949ATGQV
BFE4nQMNmEMp+1gPo3AAGiI34Eoeew==
=B66K
-----END PGP SIGNATURE-----

--HjKE82o84755e4ks--


