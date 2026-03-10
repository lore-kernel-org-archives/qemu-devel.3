Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2332DEB104E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvLy-0008SL-15; Tue, 10 Mar 2026 07:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzvLw-0008S6-0O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:34:20 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzvLu-0004qs-1X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773142454; x=1773747254; i=lukasstraub2@web.de;
 bh=DaDglaZ6Mi0dj7UvfrOyQN3r2VzwKCvhLdpGS5+c5LI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KqZncdMNbqGZuW4jXrN5OKalD9uJDGfRStvRTsnkmSnKwmlXNSPNrETgejSrA8vq
 W7wySeiTK7cTwiVgzJGph36Mta+6z+1OVKe7fP6B0wDoYvl98gVCPRFkQY6A+NDWO
 LM5t9lAF8xgnS4BdTj6snrm8Z3qNWR0FGMGQgiZco0idiyX3MXLIlU5012iuTp8AO
 NHPTZIOPwLjgfbU8B7ZvLLbyxQfA9mH0JEN7dvrLFpZdKWANZom5NSvY6mnwgQiUA
 uvhctwSSlKyvZwqU0g+5rOUoe7dyB2OckIG+zLOSfRlWZDxrKckEm8lg7IIWwU0Jf
 1X9Jmwcuw9z7vvMCKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1vo9dD2gyL-001eLv; Tue, 10
 Mar 2026 12:34:14 +0100
Date: Tue, 10 Mar 2026 12:33:55 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Li
 Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
Message-ID: <20260310123355.15aa3f9a@penguin>
In-Reply-To: <20260302-colo_unit_test_multifd-v11-2-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-2-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w3qV5sNUgbjPnqh4eqr2Qao";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Rr2RYMfGioix1cri8rCxGaQO3gkcLDnDHC50PpcXAg5H9clEC8q
 jd/8swqpB8dc6pBDFuDOQ6DPG026lIRtpZuAG+tksEg5/7m1xZse9wI53Jvt84BktRDY4ll
 gzDT2PDpLLAx+YHGVCFk1UzGoL4u4wC1PAHZBE+/DvGuSsSqKC/ZxVds7bCjc70MiPxpfDx
 v4UQQSNi+Q/BRvDkgg+/w==
UI-OutboundReport: notjunk:1;M01:P0:OvJVrMnLy/E=;qE6kReo2xSHiELE1bwmM3jTBfqd
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

--Sig_/w3qV5sNUgbjPnqh4eqr2Qao
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  2 Mar 2026 12:43:32 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

> His last email to the mailing list is from December 2021:
> https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xf=
usion.com/
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff592384b366acc823f19a6596ea8f32446763b2..aa8f795783ba936ce2521e08a=
aca8de4a112ed33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3869,7 +3869,6 @@ F: include/qemu/yank.h
>  F: qapi/yank.json
> =20
>  COLO Framework
> -M: Hailiang Zhang <zhanghailiang@xfusion.com>
>  M: Lukas Straub <lukasstraub2@web.de>
>  S: Maintained
>  F: migration/colo*
>=20

Thank you Hailiang for the work you put into Qemu and the COLO
project in particular, without you this project would not have been
possible. It always has been a pleasure working with you.

Best regards,
Lukas Straub

--Sig_/w3qV5sNUgbjPnqh4eqr2Qao
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmwAaMACgkQNasLKJxd
sljjshAAu4FaDCu+2MsqXwRihBpbaiYmoJK4ADuyCdzlgepge1R3L27bwFMZS9VV
nEFmu92qXhad0W0iRMZ6JUXLBkDT967hVCXkhzXTWKvnh9nrz6DvoigC/8TIC61H
ukebgvm4xiDFIhx3wuqy27tL9RZGEpWmxd7/jw3a+rTeuDrLhiSG47Lv21ZA+2YS
5QWpAYJsUGK+JfVnz5wmU+fYHUCgC6Tok6vihq1Wdx0yqbhTuJgr/j2xFyN5Dj1+
MCTrkb5IC/eGklS+6TPm33waF3nLRLoarIJ9B7jZJgIfYc2Q9JPYQ2ZrAJbATMG1
sUy4nr3hqo6dMSKnXYdZCGiB281PaSpy+kwRRGS8pcUOUz4Ttzhitq2YvTNdp4rT
U9VpJQ1iZfMF1Dp0B2Rkv03U7hTinEupRANsfEfs7llH7rxz9ih5OSmiOiQdvgyH
R8kUcMg8cHPqkuCWUdwyN60P7/sAiQpzAZYsgWp8eqzBZT6Y0nK7x6pj03w3A9Py
CpfjnSrngD52hywVBcoTq9/f6A3Rfs4d0NV+FJHKDQpJ7SV6xs5b+vd7URWF88qF
6vxVUPoCVfCRj7BpNrTDuk6LS8YRSEUSkNaZHSSPlcd/ZLg57c5h8edehqcJt20U
rXWQmdcaSG1L1eppxAqCXm89ayJCf1dWtTDsT/+C4YQgA4l0is0=
=xisJ
-----END PGP SIGNATURE-----

--Sig_/w3qV5sNUgbjPnqh4eqr2Qao--

