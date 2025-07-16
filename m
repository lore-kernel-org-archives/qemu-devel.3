Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32305C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1Vt-0000zh-I0; Wed, 16 Jul 2025 08:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Ql-0005xX-0d
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Qi-0008Rl-0L
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PE2y4h9UeH/wZipXvjTPkcUsuxTM6r/4kgyukKqQPvk=;
 b=Z6nZ1MzT3v3BqsOSaWS25aI6LkD/JzOGmO1Ja3sbWQq+CzbFxuaF1NLLKwdG2UPEfHv/bw
 vjv0hxJP0Bw98rxfZBPHGbxzu4+WD9/yo9sUJavKr02OJZU8K+hjCki8NwZTqFTEdAHUSz
 XrLxSgC9JwPzQ/V3Wr1f4IZUVeyeASg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-D4kdhB5cMBWSJbvvAJplug-1; Wed,
 16 Jul 2025 08:40:07 -0400
X-MC-Unique: D4kdhB5cMBWSJbvvAJplug-1
X-Mimecast-MFC-AGG-ID: D4kdhB5cMBWSJbvvAJplug_1752669606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 004A01955F43; Wed, 16 Jul 2025 12:40:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 574DC180035E; Wed, 16 Jul 2025 12:40:05 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:40:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PULL 00/17] MIPS & Co. patches for 2025-07-15
Message-ID: <20250716124004.GA328102@fedora>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8uug8SfQHHWCAfjK"
Content-Disposition: inline
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--8uug8SfQHHWCAfjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--8uug8SfQHHWCAfjK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3naQACgkQnKSrs4Gr
c8giAwf/R4vinUG+HUw6q6KmM3l32Ud5vaF9ZeCPYNCFXSySNEsr3jKZM07Jn3OW
/aF4d5SH2BH7LDxb3JjkUqJ740oH+OcCpBbWmIoEht+CedjoLjyBzM05nyM3QtY6
D6GXsooHZROgYiDt31Jj1/aJC3DaWskq27wMLbMbOPWAubjjtYhwEStGP5msylDK
ja1ABDLVYP3H6JSCxMecumJxqjZcsTLbdU+3nHa2QqCEUk42ZaLvIp4BlqbjE7xQ
DRs35m9weTLq693UPXn1UitfQKvfRRN11RFGl8ets6ZOH8PPIqkfliA7PLImXMDh
5Om8oWhMbzdssLfQRLFU5mZB7HBLTA==
=0TMC
-----END PGP SIGNATURE-----

--8uug8SfQHHWCAfjK--


