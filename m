Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DE5C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWgp-0002EX-Bi; Tue, 03 Jun 2025 14:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgl-0002DR-R1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgi-0006jY-Vi
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748976520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nx7HjSj3swg/74cDHFXJUsFoMFXl4jtmMAcHbuKY7PA=;
 b=AYRxJOaeIPlQTSm40gZ73qOtXl4eipJkiQ4a4RmneGtF0EYOP7EhDoxKk0SKuo84e/Yv5c
 2jRv9AL9/FOf1r+tE61rVj4ZoPlzRQsHyeofYltSPDqJ4okNnL9ebRq+SQQbzrS8nZ9zQc
 sCk9D0SlYsvXjgKYw3a5XivHVHwE2Ng=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-HUfUhuCeNpu84shqeHgJjA-1; Tue,
 03 Jun 2025 14:48:37 -0400
X-MC-Unique: HUfUhuCeNpu84shqeHgJjA-1
X-Mimecast-MFC-AGG-ID: HUfUhuCeNpu84shqeHgJjA_1748976516
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FAEC19560AF; Tue,  3 Jun 2025 18:48:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 560FC30002C1; Tue,  3 Jun 2025 18:48:34 +0000 (UTC)
Date: Tue, 3 Jun 2025 11:51:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20250603155153.GA354362@fedora>
References: <20250602222933.336883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UARPAllqL9nYmjJF"
Content-Disposition: inline
In-Reply-To: <20250602222933.336883-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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


--UARPAllqL9nYmjJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--UARPAllqL9nYmjJF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg/GhkACgkQnKSrs4Gr
c8hzfAgAyV4/cmsyP5K9uwrDCtzLTsESstTBdXGNsHCEJDMVxN7KsvY4ge1FDdT6
ZpTUOHmrQDO16hRKnJ3XqzdyOI8hiyKN5G4UUGKrfR5oWzQO+PphqB1Q20Qz747R
NM3zc3EreHF7Jsesm8D74TCIiMfFeQn95oqMlRXCbuz455HLhMhtbdHhErAiLOXp
sBheB0iFWB5nBVEtEEwN23pWkot2bmIOUrCFLttXjCmk4BvzPQ6llYJpIKhkuWgp
ha15WxT823Lp+8JRFwPpZkN8nB6G00KSSCyj+upMwNCtmnVfwnTuINjSF5cul6eM
AJ8nZ1Zz+FK7nCMXTGa4OZ00e7koHQ==
=uFcK
-----END PGP SIGNATURE-----

--UARPAllqL9nYmjJF--


