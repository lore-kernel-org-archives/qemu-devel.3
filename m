Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48DAC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 09:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujx3J-0001RY-Ma; Thu, 07 Aug 2025 05:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ujx3H-0001MX-CA
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:36:47 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ujx3F-0001CI-Hy
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1754559402; x=1755164202; i=lukasstraub2@web.de;
 bh=ujxyfnavCqtP/DSeEj/N7PWCZEOE/eWtzTZrI/Lpq8c=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DnyggUEESO4JUlYUrI6Iyj5zIxF8kQ+p9YQI1ly1jEuAukQ5dDd444roWc2briOP
 w8PEEgv1/Fn2qv45+FQ8yTffcjlkfW30XkzSsdCz72CVUY1xr89kHhxgzNEqMphTf
 3O8XCnv36buoWSbqzNLT2rb2UywIBM5kSPnzZZgGAc7QnqgnWuwYtaa/lnH79UAqw
 3urG2okkc189eOI+OvArEpyxS6ppH56+rkTEkP2S/yWpDn2HWGPPldRy9Fke8nz/5
 FmQooG3facQqMeY89qKQfje87WQDG0r7prS5pDdDFLlZRnLBt9TT5hR4mDS3TCWG0
 J5kNFVKIPGaKXcOhag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.41.102]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMv4-1usAVr3up4-0050gy; Thu, 07
 Aug 2025 11:36:42 +0200
Date: Thu, 7 Aug 2025 11:36:39 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <20250807113639.66d1c5bf@penguin>
In-Reply-To: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s396KfKqNfH05w7CjiZ6dzq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IBoc3YAY5SPaZkma/LYB6drRdKSQMHnXSApgpMkK0pa0Rb87HRZ
 l7h2DVvxfNALTl1JrqWDyBxw8FIAw2NXZvndkytUw3aof2D/yfhS6JBc5cirdMgRnokqIK6
 TR0HexcL9ev5RAOc1Gdz4cAGl9uIak3Ik+d6FQoYPIT2y6us6rh67OM3pYLGLl3sitO9wS9
 3dOF+NZx8VTUKTBl27yBg==
UI-OutboundReport: notjunk:1;M01:P0:BI81IaOIFQQ=;SO0ywwGL5Sz4C8X8fhdujeUO5jj
 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
 km3+5CtcjUg==
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

--Sig_/s396KfKqNfH05w7CjiZ6dzq
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

--Sig_/s396KfKqNfH05w7CjiZ6dzq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmiUc6cACgkQNasLKJxd
slgegA/+KfF+RYJWFxHdv3HlmDr7VsstD9kPXATltplBeC3FMROaWW9nYSiRUGm6
/AivttNjn99ilfr7XwVCRytfNBOF5O0w626HjeKMChCMaGFVeWXr9qeaXSFc6qo7
I7KRoDKGqKDUFTodudQETbZA2z7xUIHJe8iCGIPl3y7QSAu5xA6RKUgQImE3vxWo
v4lYE55RmG96WPy6ZdPsCPoYKFGcs88g5d0vI/xIif5ktZT4TShL1DETBcL37yd0
mD4JX5/7xDa1PAfS2OKJ+12gqgRO+p1BIGJSvsUMNTLXGxrnjSXiNC25ryIET3Lt
uc1mjRoBHEz4bmBaAvq9uD48XJoWUh2j/zS5P/TRVXKFwZURuPouKlklcGCNseWb
9gmuM9P4OvhDw1R0uyVFtQhaaEugMgLIxuLuNV/EpYA0bWKs7ZaVkUg8oRkKqYom
AijlYTFRZMGOsklliqhTV344NM4aS7FQqXmigxHsxjUyRr8wG4UE8oLedQMeTCbX
QA76zg+dBa1uYOQZbQ7SCRJOi+s5Z1C0SXwVHc7go/ed1W1cfx67580jb5G/sG9X
bIwD1w+m/g85DaU7vNcdR5aqriKit5fReLbOHRdAog30zkKoQo3M6qAdXAnurQTN
vvB8rQSq9HTCsfa8jOkyYE2VdBWwl4JFcdWwRO0fKIzhjMwG7+8=
=WyJG
-----END PGP SIGNATURE-----

--Sig_/s396KfKqNfH05w7CjiZ6dzq--

