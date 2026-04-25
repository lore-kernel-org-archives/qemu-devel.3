Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5086EFF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjAI-0004WQ-97; Sat, 25 Apr 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAG-0004VX-9Y
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAE-0002cj-V9
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3J5E0YwHOY3wnrKn/YdTD3hwdUSB/RcCwBdbi4No7qI=;
 b=EH755rRrd3Cq1zjZTojOo3tFlJgZnSossDKkkZEI9iUQtFqM9qivSmQNJ1Tg1Jgexb4xCa
 jmTHAHMJEW0E1FXyCCTn97mih6DZBl/GCBNBFmSpPnPEmlBgJ0/LXfSyVaauQ6Ja61WPKk
 pCMSa6crHpfeHmrabEYNHGwGkPV2WXk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-Xy0pPmluOrW_ckV3pGcwjQ-1; Sat,
 25 Apr 2026 15:59:40 -0400
X-MC-Unique: Xy0pPmluOrW_ckV3pGcwjQ-1
X-Mimecast-MFC-AGG-ID: Xy0pPmluOrW_ckV3pGcwjQ_1777147179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD6F0195608B; Sat, 25 Apr 2026 19:59:38 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05B851800351; Sat, 25 Apr 2026 19:59:37 +0000 (UTC)
Date: Sat, 25 Apr 2026 12:59:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v4 00/62] Misc HW patches for 2026-04-22
Message-ID: <20260425165907.GA144177@fedora>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bI90uyPQ/ye1UTUl"
Content-Disposition: inline
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--bI90uyPQ/ye1UTUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--bI90uyPQ/ye1UTUl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmns8toACgkQnKSrs4Gr
c8hq3ggAxJjVnY765x7sA0iQbLetioQ5WrSJoafy1osPnuSPqKPPpMvjjligtZdu
ItJrz7vyJj9uwHZNYN+kuA3rK3/yZRO98WAIYa1c2GT5eacf+93JhTbTiooq/aPo
kLZa2tYL48z3Dr7vyB2fLkHGbtoOOAi9gzw6s/pRExzQF2jSvbRpwV8059IB2pCc
jRsbtJ6ez4l3s4OVoy1aYG7wKm7ZhjM9TzwAIX8OWimwm16TYq5pk0/Qrh7otKjp
Zwka6I5ny9b0l9dZtqzp+6UxmZXHtAcLg4nEG7fsaDijKYYiO6JwX88N0/QbL1c5
UUWUGP48d28+Uf7pJz1J8elX/SQvtQ==
=MerT
-----END PGP SIGNATURE-----

--bI90uyPQ/ye1UTUl--


