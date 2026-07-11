Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054CC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 08:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiTF4-00058P-2L; Sat, 11 Jul 2026 04:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiTF3-000581-0l
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiTF0-000719-JE
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783759157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2hrXWouDdpVXrwHzumjxDJzWQX/J05t2XVg/krAfAc=;
 b=F/RHwrVm0VKZb6jwJA7gAPx/4kND0So2z/xKpDupR9tBls6SMsacOUmu76gRXZSuGoIRYz
 c1Bfwl626Xk+HRFPsZ0pwGDj5AV0/dD3sfHh9W5MKtwbSHhaEDfhLSJe7WaDhRCNWRJ42S
 /uhs4lcIXKD7kNfxEG2wzxvdFl7GZi8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-SxikvekaP7S2KXkpmrviyQ-1; Sat,
 11 Jul 2026 04:39:13 -0400
X-MC-Unique: SxikvekaP7S2KXkpmrviyQ-1
X-Mimecast-MFC-AGG-ID: SxikvekaP7S2KXkpmrviyQ_1783759152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FD851800365; Sat, 11 Jul 2026 08:39:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6F3319560A0; Sat, 11 Jul 2026 08:39:11 +0000 (UTC)
Date: Sat, 11 Jul 2026 10:39:10 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PULL v1 0/3] Merge tpm 2026/07/10 v1
Message-ID: <20260711083910.GA637702@fedora>
References: <20260710144108.621828-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hcyXh1sxX1slxsY3"
Content-Disposition: inline
In-Reply-To: <20260710144108.621828-1-stefanb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--hcyXh1sxX1slxsY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--hcyXh1sxX1slxsY3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpSAS4ACgkQnKSrs4Gr
c8hKkQgAjd0S/vF3jNs36yf1UhxzpWc++L9na8EdYVFK0Xr0QLePSZG1jSmk0m2h
QuwAH7v6AYxPibohZaMoPGKm+mW1d/wIt1H7w707RuYq3lJVhmljfhc9gJsWXWv6
ZKGv5tazpJIWYfkIw0aiAuMCVYtGmSiz9vERzm/YYqsmescqvAGYrCQczRLBD7Te
3C0nZGzTNLp1UdSEBPg/9Ak2w+XInaQGw3KLKZt7FyI64bpulFWlefGNE/U0598B
rtr3YgyOI2z8ZgroTFUolZWU4q6uYvnkArUxsBnJ4ze8kqbuwh3Ogo5aEZ06jzpV
ZTPAVt/WNyqfg3sJy5QbBbcYJleklg==
=ByIk
-----END PGP SIGNATURE-----

--hcyXh1sxX1slxsY3--


