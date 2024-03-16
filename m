Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AB0C54E68
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 22:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlcNr-0008M6-VD; Sat, 16 Mar 2024 18:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1rlcNo-0008LK-Sy; Sat, 16 Mar 2024 18:20:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1rlcNl-00024M-4W; Sat, 16 Mar 2024 18:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1710627594; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=ix8sF1MN6xB1JBV5AXuwKKMKZvo64/VACZ/x9p8/RGZ8UN6BZqcJE9L1HDuEwpI82n
 2SUwC2M/jijDE6L9YweM5lWwTRYQHC0SqBkxhdJ8huxeu8w2Dymf9wPwCIvQOT2KzBs8
 CQfWF3gK+48iNR5JhMvDPMr9Snck7L86WH4PvSAyToIT7ekeQLwEijtzEeUj7/1p3RHm
 zKi0zkCWxD9wszY8Q4lcYgYG9PZXZFj1zTWlZ/pj+xuKJvdZTsxpeetCAtXiW9yqpDLk
 oxBp0FWl9MAlJr3zaqFXGSEGUschkCclbkmHuRuKN29f91ekI7yxvbovie7tghOqA7Um
 s7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710627594;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=iZyv4IpApPtziIJScL2M8KCWo7Soiq4nqfVzRGgQQFo=;
 b=DrjgfzTCxG+XO6MG3hbaPvaKcPLHJzp1EW2D20Lln7a/Lf13EIll5QI7D0InYm9bPJ
 9A4JMHQP8j8ijouIxW7VzSrptF3m5vpO93VwQsdLf1ZTO1Cvp7dS/UnaS8U/u+AlpBLc
 PsX3mrVeoAUWdS6/u5FWQVahinCi0qSnNYR9OXfsRcHkazfc5jYpxj+8RyeU8BjTrpbG
 Wfi6WUH701osNdPS/NRa5P5qWAY+udSnv7UAx82quv2bqh1c+izekLtM184DqDa0KxqD
 aWGhQMdSDshbLTAuU4tOyqzWtFpVYXk0l8iMVR0vrjKkzth/Ui/E7bZTjgjiWKoC7rB6
 1VVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710627594;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=iZyv4IpApPtziIJScL2M8KCWo7Soiq4nqfVzRGgQQFo=;
 b=MyRs/iz8OxdkNFuZAamh+1Lu0Lur3GHaTAPCKvZMTX5KHdoqTFuW5ICKx+gYXcd6mg
 XKMJQJqcAW7pGdojz6EOo9qvH2m7936fqM4k+LXToueP7ZJLKa/WBykM/h28M1mQN2iO
 RET1eEkbbv5vavXImGSKUPcZaoYw+aOlTcs+4pfv2XbUY6PH8hMNWMf7+Pb+Og+O5gyx
 LSfehtIw52v2AsnC5gcsgyQdqPf53Pa1U42jYwBH5VV+8BVKvf6nfgyOVLkHyU8+xvQt
 js7OAdBCq8xU4iF3MC5SXtTTBfu6Iq3lvBibpaGKW9ThfwAEEmTkou3kJMxFJ0gukivt
 ktxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710627594;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=iZyv4IpApPtziIJScL2M8KCWo7Soiq4nqfVzRGgQQFo=;
 b=e9J7irnZEI4AhqLs35mSpljmXTNmACCj41VjAgeshUnDikn7KUKeiujA303zPEJNnT
 cBigAlvMOkUlWqeTumDw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5ABaIaxjsvWV3+5zoB6xJde0knZVA/JvNMMXDFQ=="
Received: from sender by smtp.strato.de (RZmta 50.2.2 AUTH)
 with ESMTPSA id 6fe76102GMJr7E9
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 16 Mar 2024 23:19:53 +0100 (CET)
Date: Sat, 16 Mar 2024 23:19:45 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: Regression in v7.2.10 - ui-dbus.so requires -fPIC
Message-ID: <20240316231945.7bcfac09.olaf@aepfle.de>
In-Reply-To: <4b803768-09df-4b6c-a745-f0158543310d@tls.msk.ru>
References: <20240314220038.1aaae79f.olaf@aepfle.de>
 <4b803768-09df-4b6c-a745-f0158543310d@tls.msk.ru>
X-Mailer: Claws Mail (olh) 20240223T214820.cce9f45c hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R1Htl.DcerOtgfDBq=BflaN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.221; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--Sig_/R1Htl.DcerOtgfDBq=BflaN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sat, 16 Mar 2024 22:40:14 +0300 Michael Tokarev <mjt@tls.msk.ru>:

>      meson: ensure dbus-display generated code is built before other units
>      (cherry picked from commit 1222070e772833c6875e0ca63565db12c22df39e)

"static_library" is used often. Some use the 'pic' option, which fixes the =
issue.

I think every usage that ends up in a shared library requires 'pic:true'.


Olaf

--Sig_/R1Htl.DcerOtgfDBq=BflaN
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmX2GwEACgkQ86SN7mm1
DoBHrw//fwdYdEyS8yvQHtzhd+vngHveF+UMjYZAuhQ9wYr6WhI5xU7TBIMhUudu
aQIMm/Gaw4RQr2HKqKloojmCXvVGPe4qcvx/jSVBU8St4pONKNnYaggjr+zG0xyG
CFDEAroqMYhqsmuU9pZP+IRCmgjuq/I3K5oOi7jupOmwfCNrt61AdfvpTKS2auj9
DihaVvhyBVPAZu9Fbm9rLUXilril7lUa6xWHk4cdEOYhm1qb/Y7k2fGiQmMW6ieN
RnIUCGyuIFY6F6+XitXmH7p3GN2x9SSqPyIakd/7CktAfGfgEl3B48mHqy9KXNfo
Dz+qtbFLQPBUkWuI+x6zoZ50q9CrtfnTAM9QJGGEV1JGun+d3SoJZDdsk4B+DRo9
+gUjKAAu8wFhhl4Spd+mioB4ifQolHboa8gwswQisA0EzufbPQQ8VZfT/JnzIOM3
cSitERqX8blBHMo+N2P6+3aZUrMvZ6rzO1eu9gT2+W9FM0QBTwGooxGOgM5yxoz0
S4C3aUp/hrbxijP32V/saa99FH90fW7asaFxj6/6d+ruB9Wu9/m8/+IiUruelHrm
2Z0l7XpObBbUbxH0ACYMXVk034PFeet7yB/6gwBDkwrKQ6gBpXIBd2oRMZ26vi2R
fqNlx1azpRSqtwZLBGXjaEVrNYG1n3Z5G6PKqqX7u7NL7uB33aE=
=7EG4
-----END PGP SIGNATURE-----

--Sig_/R1Htl.DcerOtgfDBq=BflaN--

