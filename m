Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A7DC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 09:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujwzu-0006uu-P9; Thu, 07 Aug 2025 05:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ujwzr-0006kD-6N
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:33:15 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ujwzp-0000T6-Ay
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1754559187; x=1755163987; i=lukasstraub2@web.de;
 bh=ipXNjyEn0wPskowb52MaZ4/0Y9rdf/FANi+bIX5yBqM=;
 h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HsUpQU+GPqbZK6E8nWd5phoeadGYE3YQxFiCZhADyBgOWSwmMUBT5VhfCwNaCo0m
 x2GvkuYVddeosB21/CqAPO2Oo8fTMO3JTUs726tD7Tnt6TVD0PWqJ6K0wbNs34XY9
 lzLJSXj7B7N7P2HdsVQsCePXOnzfS5JxHEXw1aG33zCvow6OG+LZc8KlzBa9NOGQX
 qhQuXRGldYgp4IyzvbZYgS2vmqzBNL8nht0VC6MJYfjFMFTN7+oKaKHDqbT7GjBos
 /CBHfVYswjCDxSt8RqfSNwhhYspKM/M6WedpY4VAceVSpzPgAzhWqL+z4Y71ojF/3
 rzEppc3o3rTICjNqcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.41.102]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1unTlu2o69-007uJ0 for
 <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 11:33:07 +0200
Date: Thu, 7 Aug 2025 11:32:58 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <20250807113258.686571ca@penguin>
In-Reply-To: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sn8SVRqroBO.K7AnaZM57ZN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:bQfqYriePsxoLXUP9TFEqiFch3uXYsn3T7yJSK6F83wwIcPjTE3
 T3TQMP5uyVkgw5fpKF2T/4D3VS9ukjjRZUee/aCisj5ysuas6A8/YNLKjXB8MTeehJZITtJ
 ogaGeRmqzh7CaxMLwOf5XL+ETybcid6X+f4hTIUF9K/ZC/AuHuhQOHo1IEVvXw0hP1HT/bu
 sLUShol3Q8QKHz54PyqgA==
UI-OutboundReport: notjunk:1;M01:P0:qqgW3KZrhWY=;DeMMQmHe1GF/iw/xMEMuW+m3cXT
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/sn8SVRqroBO.K7AnaZM57ZN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  7 Aug 2025 10:41:17 +0800
yong.huang@smartx.com wrote:

> From: Hyman Huang <yong.huang@smartx.com>
>=20
> When there are network issues like missing TCP ACKs on the send
> side=C2=A0during the multifd live migration. At the send side, the error
> "Connection timed out" is thrown out and source QEMU process stop
> sending data, at the receive side, The IO-channels may be blocked
> at recvmsg() and thus the=C2=A0main loop gets stuck and fails to respond
> to QMP commands consequently.
> ...

Hi Hyman Huang,

Have you tried the 'yank' command to shutdown the sockets? It exactly
meant to recover from hangs and should solve your issue.

https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-feature

Best regards,
Lukas Straub

--Sig_/sn8SVRqroBO.K7AnaZM57ZN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmiUcsoACgkQNasLKJxd
sliuWBAAnEmpNhzoXkg+56MhxxAiwLqCQgICyYCJSIK2dBQ82Rvc/nx5+tFaeKBS
bCymoH/PW2Xm73w38jWnqp8RqpzQO9pcNWDFdJ/rPR7W2XnwfM7E5DoQEk31J/w1
NBz+UsGJVJTAH1hNW9XXORTf30W0RGKRcGK80S96CEL+3FBTXXAmpO1xALyDbfn6
iv6uyz2H6waJUihZ32Yiu8r4Y7aPQ7idS0ixX5QVOeY2S4G1eYOmONJ22/i4/oD4
In0XywJCnpA+Hb5usR1uB9P+Olsp3OkhppsqEYhTi34s1PJOBifil1IQs+er1epv
R8IW5d+bOHegB3gdPm+CCT1yNJDN6rY9vZrO876YZkZ9yDNOYJMpjny/n1L70YTn
v+WDyMCqdxctQxVuDf5Pjxt73vE6H7QPXYzemOKxH66VKlBG9sjgjgmnjCHBzoKr
lbag2sKMprb+aIKBgU79vkyqthVAVfj6RleVZBZhImgV58/vDlNSuxTkJKWi44es
aX4oLidxB9TQW7W3Zkmw+gR4jy0Sj1748lJ0vhpBedTJTzF5XW+d8B8ThJvVWCNw
EJzRPBqjN8XfBXAKQW/XlgMH/Kngy7ZuHPE9/WXsuXsSe4vMwLOMo1JlabgmGWOb
3FudtQWdfHD94ReFm/1LSutu+GsMEhvIKw6hzQomJboOGiMUEvU=
=nfx7
-----END PGP SIGNATURE-----

--Sig_/sn8SVRqroBO.K7AnaZM57ZN--

