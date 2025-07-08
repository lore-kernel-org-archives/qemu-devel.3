Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979BC83F21
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 07:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqpu-0004wV-Dd; Sun, 13 Jul 2025 03:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqn9-0001gV-6k
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqn6-00075x-AJ
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVZAKUsLSG9+8K2HPiK0ZvJ8x9Mj4mDPC0lADvB08iE=;
 b=XatlBp46nHYZCbjF7gcOl03iYqyRmFrZOpf3Wk1sWpk2JVdL1DNchryD7Xr+Z4Ic0QHzCi
 EthGwixKGsO+1vFRG1nUStELb2dpJXpj67kXKooDkor5Pk7HpMfnTAnrJ3pQe3kicyTf8c
 3139t6I0p4qYNDXt8aFvOK47WBJlB3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-eN6JDvCKNaOO2Tqny0kuCg-1; Sun,
 13 Jul 2025 03:06:24 -0400
X-MC-Unique: eN6JDvCKNaOO2Tqny0kuCg-1
X-Mimecast-MFC-AGG-ID: eN6JDvCKNaOO2Tqny0kuCg_1752390383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3095618002ED; Sun, 13 Jul 2025 07:06:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 674DE1800285; Sun, 13 Jul 2025 07:06:22 +0000 (UTC)
Date: Tue, 8 Jul 2025 03:25:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/36] Accelerators patches for 2025-07-04
Message-ID: <20250708072542.GA115449@fedora>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CKgtyt63H3SaNUVC"
Content-Disposition: inline
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--CKgtyt63H3SaNUVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--CKgtyt63H3SaNUVC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhsx/YACgkQnKSrs4Gr
c8iHUgf/Q/lpY5bsp+T+nuwUYv1ujpTBKYrOMOFR4s65kb8fDHm7jPRTsn1dbOWZ
nimC5MBh9G7Y5CQsFX/MHe8HV7MuQJQp2xmztgoFhht4OfizwZgnICKLFLzEsu2F
dkT4MTKnrLwUieiruhk2x7+jeJGJVfFFMYS064RLzSbQtWK9Q/hjotNAKsYVfpgD
pFEUs9c2BRzNZpZXghpd7NN7zuKmMhX6OHvJfg/wcAx+prBOieL/a3Jk1duRuqQ7
1PpsZVTBLBbWaoJ0S6/Uv5P3F8d3PmlyWi0/9+nTvrWmsMW1geBJKE2004NVw5Bf
0CS481q8mTW0JYQff95qd0RKjojCDQ==
=ZJPa
-----END PGP SIGNATURE-----

--CKgtyt63H3SaNUVC--


