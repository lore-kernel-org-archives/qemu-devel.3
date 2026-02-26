Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981AFFC5929
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYqz-0000Yg-IV; Thu, 26 Feb 2026 05:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvYqy-0000YL-1U
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:44:20 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvYqw-000835-Gp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772102648; x=1772707448; i=lukasstraub2@web.de;
 bh=lOms5HAf/Xw1AjB30LW3lbVKSQ2lU44XYp+h+ieUd/M=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kBv6yQ2wLHWt666Y+tSLmJgQrmrQDFjGFgP7FxpYaXMrh0vBBT58RUjkyYceNw7M
 cU2bJRV5pRwe/Z+LYyXUXP0wtnAbUqR9pgI1j/uZTgvxUNh2We132YKVr3+Ti8zEI
 eEYUNSyfMULiSQk4OmijXOArYT2mBm9qyr7Cnhkz0VkEGesJ5AOTlU53DrcXi0RRe
 NqeXKexHyMJepOAjgELkfJlBBFKPyRM2tMY8DiwR/Na56lgMVE8KszxPRg7xh35dw
 DTDjgqOe/KUEcbMouZwPGTaOSgKtK/noRmgHi5EojC4FBef+vRqvHXmJI6C0c7NLV
 ZHqvU70WM64LkQcvmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1wIT124BDX-00INbV; Thu, 26
 Feb 2026 11:44:08 +0100
Date: Thu, 26 Feb 2026 11:44:05 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Juan Quintela
 <quintela@trasno.org>
Subject: Re: [PATCH v10 00/19] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <20260226114405.2cc0c538@penguin>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NxUXauA98UXZ=.pygZo2bN2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:dyNnRHbe6Iscsc9ysFdYSqHrXto4+xQWpMBjy54M+gYEDYOMUSa
 VuFYPNoC6Ncj3YWfdIWTwAxX9OvICtHHz98ELwa2NZTRxjkpsD/73CkU6tjGF+bsemomAyU
 lEkki8kxpia3/K6SbPsi5zGFk3fjC1ZfnvdG14IzMc0dcB/1v1KWEP2byP58RTD3GPT+SBx
 iC52purU5v+qSFCMHcm0w==
UI-OutboundReport: notjunk:1;M01:P0:DyDd6hOJXaQ=;H2ovm0KYmdJNG9BI2ZhpcZ5UTff
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/NxUXauA98UXZ=.pygZo2bN2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2026 20:51:22 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello everyone,
> This has some cleanups for and adds multifd support and migration unit te=
sts
> for COLO migration.
>=20
> Regards,
> Lukas
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Changes in v10:
> - multifd: always kick the main thread
> - always open the return path socket on source
> - Link to v9: https://lore.kernel.org/qemu-devel/20260218-colo_unit_test_=
multifd-v9-0-d8dbdb0ca6f6@web.de
>=20

Gentle ping.

Best regards,
Lukas Straub

--Sig_/NxUXauA98UXZ=.pygZo2bN2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmgI/UACgkQNasLKJxd
slgqAg//XYQjvvpUPaU3s2oASjCVZriH51grWS7C+hFIZwOo+6fquCw0fK191vnF
qxvyeyv0K6p0XNQOvoIpG1DzyyJmZJtFpBAnjQ7e3nRMusBSKylS+mvaxNHxGntO
oqcFbv5r5rBUDt7bYtj9ATrlwTdPMM90TSeXWzGOBrEoXDgwCURV+LKrZuuk8gXP
HJMT81BFlRp7gQn6mfPXD9DhndAUrq6Yxf7qrWOUU/7fdn/jCJM4HHLBnclHHroZ
j0GzW9goolN3yItaFM6HJGH/zK9tLH2SWeoscBr4CEuNMfyqJOP4UiZA7lW/LgJH
3xzDYXO50sGp5ABtinW6WxPJ6AMWufrgk/e8VEvROj16lMgdnyVzdirj9IdJ3M3T
v1llCBHb5rRGquIpEsMv/vQOvuTp9RHmfeFf6r3oNJLn/nPRDsC8WsmINGcBKAE/
aearx/Q9EDnHsTDqdCLX4GjdCq3CyGHNOHz9Aqc32Y8Y2Dvloezzh92Ln8B7uWYv
fl3FDx3WmXvMNfXaL2xwWj9OpqErN/90909QkZCIqTM655RtwvDoBPc/1kMrr/Au
QtLMzw9XrqaoN+LltCqt5tg78BMF+h8ij7GUkgGJmsCDkMHb8T2e6y933NsQ7DhN
yMoIG58WwIIHZQlkoRMTzclAVfHSpKNz4UhP5UYe9jSokft9SVc=
=0reQ
-----END PGP SIGNATURE-----

--Sig_/NxUXauA98UXZ=.pygZo2bN2--

