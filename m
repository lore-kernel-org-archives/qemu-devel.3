Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF0AC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1W8O-0002qJ-4v; Tue, 01 Sep 2026 17:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1W8F-0002ps-WE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1W8B-0008AS-JT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788298499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzSOUQXrV/MJjSZQvXmYHH1VOAIwgFiTLNUhuGjgUoQ=;
 b=Z79s9zBzOyNRPTwk2sgIMkKMx7Ty+EbIWOVzaSh28r5g0MsdvS2YYaxddge+XoHo8Wsu7h
 S6SPyUidL0C/XmDfBL2FTxPcY3n+QSUBBT0++gpVfqXBmJscuYQea4WLwX5d1v0rYDtbWx
 kksz35cedR2ZOTQFXQLvclIZEAql7B8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-cxjJohVGMzeTW83kkz2kcA-1; Tue,
 01 Sept 2026 17:34:55 -0400
X-MC-Unique: cxjJohVGMzeTW83kkz2kcA-1
X-Mimecast-MFC-AGG-ID: cxjJohVGMzeTW83kkz2kcA_1788298494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40156192DD43; Tue,  1 Sep 2026 21:34:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72B6118005B8; Tue,  1 Sep 2026 21:34:53 +0000 (UTC)
Date: Tue, 1 Sep 2026 17:34:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Huiba Li <lihuiba@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [RFC] block: add an overlaybd image format driver
Message-ID: <20260901213451.GA738050@fedora>
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XnxkcbvDN/FWB7ti"
Content-Disposition: inline
In-Reply-To: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--XnxkcbvDN/FWB7ti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

By the way, I see that overylaybd already supports tcmu-runner, so I
guess you've decided that the benefits of integrating directly into QEMU
are worth it.

Stefan

--XnxkcbvDN/FWB7ti
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqXRPsACgkQnKSrs4Gr
c8gPpwf/SlHqzUXhxAAUTFEO84IZc2OTp7Dvzm0fGHVCI+uBIkoLZOXq/lzf5Zyg
MuLvtQQba9JqaLtthuGW4YbdIs3wz73FV9gQclZzlFyukMhBbX97Vr6PlbDKPM7p
Wu0roZIZQHp68HLQWMcl8afhUm2T7sROKpcrKibedLvsqkPgnt+BrF35gpeC5TcS
96qpA7sVQ7hCEtjZsfVJO4aKRay+PnZ9rIBf3DElvZ6XyHFfDzr+SqxPa7LTlGzB
zbpxZzyuhgGZraWVxL6Kr0HcYVCy5fpxXLtvxhFAsyg/Hwog/Kl0ikasqZkLxOyC
0yLh3YiSGvNPi+E1JHXXX0ku2ztj5w==
=vAtb
-----END PGP SIGNATURE-----

--XnxkcbvDN/FWB7ti--


