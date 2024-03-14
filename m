Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F7BC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 21:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rksCA-0003P1-1P; Thu, 14 Mar 2024 17:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1rksC8-0003O2-2j
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:00:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1rksC6-0007iC-Az
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1710450048; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=FY5oE175THP6/kKNwtGw9+YVGFjG5f5uxyW6wdzYeFpbi/R4HxrSLYDuNfxbR6rvgi
 zi1rkneuqABDjeEzrmmvPUtvkYb6cMScH4CHxPlV3WMGDtJCYPnWA9iQ5CzcB+miyxVp
 cGlNO7eN8DzOcQUbaLpWOwbCAEo2vIaZwGHwCupP3jw0ygJc1mkUNPcvASd7qH/K2oY+
 5jdTy8PHMlohMGoaqoOdpAAVFVxJBHDMzYxMo5GcBPmwE55Jd0IuU7gKtt3caLRvRYW5
 c1B995Q0wVv1J0gHZPcbY9ezucuUCWfAMzdKsseqzDnZrd8hBU0Pzw2+1oefQQqPyIpS
 GIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710450048;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=x1EV4L0okCKI7QasZUxX4Pl/TC1PnUyBxbcARD+jOCA=;
 b=jGAl2tFVoGxIglosbcYwq2VvwPuQSuzs5+DMoM7t4ytkPVrqUyKTMsr8fIJFCyQfIW
 nYoL+hsKexPAoQDz1GU/3NioJ7TsYClz3OEB80S5ifupgy2DQtLTz2BNzEq0IHiD10dT
 2ZYDNvR3oooctwM91gCh9NaK0Gtjfz8vgQw5DIBfQeEKwwtbZ2wARwRh7iIiY6vg/wzH
 SK/4QZXeqXtvKky+wjPRYLeFqcK2EsgpChx3s/KgebRWtinn7P4H63kjn+McsiQyOrCT
 QtaZHKV66VJ7KAXTYCtQsSqqOGDpN1R6D1bHXSJY/3Mip/0cARpJwwJacWEM66hNlirX
 zreA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710450048;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=x1EV4L0okCKI7QasZUxX4Pl/TC1PnUyBxbcARD+jOCA=;
 b=j0DYypQVphn9XdHNmYzG+Bji24BPatdplmfPufv2IA1tG/ZVbloWKFE0WB7KNv1KBv
 RezeDx774/oDNfXIyHAXFb7NXqIxSKtfLBdTRzq8o5nnFz115vHwchESfmpy2/nzQR76
 0wikAJ1B3ESZxUxYn4Im/oRHdJHqrrONb2cSuUtXJ3BL+XPXI4T6rJf2M0WArMXqpab5
 BDmBZhFhkoxFKxC6saoSzdtVWvypQZTxpE8+36o5c73GP2Sn2g17SRBJRMW861caCMnY
 6sHJ4DfWRFHmaNFv+mBKogYio4W6we5ax0JUR6ekTmkJ79NRgpWGlMPf+wFeE/0Bj8T0
 gFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710450048;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=x1EV4L0okCKI7QasZUxX4Pl/TC1PnUyBxbcARD+jOCA=;
 b=IHKbIZxbvfnl9Ir0Xb4rlFcG8gFdyHPF75cDhsyr2TaoalZhnVcCwQRDPk3URb41Dg
 NY/fnsAGHa8WaZdq//Cw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5ABaIaxjsvWV3+5zoB6xJde0knZVA/JvNMMXDFQ=="
Received: from sender by smtp.strato.de (RZmta 50.2.2 AUTH)
 with ESMTPSA id Dfe7e402EL0m0dP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate) for <qemu-devel@nongnu.org>;
 Thu, 14 Mar 2024 22:00:48 +0100 (CET)
Date: Thu, 14 Mar 2024 22:00:38 +0100
From: Olaf Hering <olaf@aepfle.de>
To: qemu-devel@nongnu.org
Subject: Regression in v7.2.10 - ui-dbus.so requires -fPIC
Message-ID: <20240314220038.1aaae79f.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240223T214820.cce9f45c hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GYfzay0mcrWe3xuGjh9Xt7z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.23; envelope-from=olaf@aepfle.de;
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

--Sig_/GYfzay0mcrWe3xuGjh9Xt7z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

ui-dbus.so is a shared library. But it is apparently handled differently
than all the other shared libraries: it is not compiled with -fPIC.

As a result it fails to link. Not sure why this happens only here.
Everything up to v7.2.9 was fine.

Looking at some random other library like libui-spice-core.a,
every object is compiled with -fPIC.=20

But ui/dbus-display1.c is compiled with -fPIE instead.

Is this intentional?=20

Olaf

ld: ui/libdbus-display1.a.p/meson-generated_.._dbus-display1.c.o: warning: =
relocation against `qemu_dbus_display1_audio_get_type' in read-only section=
 `.text'

--Sig_/GYfzay0mcrWe3xuGjh9Xt7z
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmXzZXYACgkQ86SN7mm1
DoDYmg//UuS4zVk3UFj871N+h5nUVY1Z2JTRo1KGjvOscUKZzlVsWfW9k2wk3YYX
LWEGvjlnU+PMDrYdF6T8M6gSk2zLsou485J0Rmca17/JXrL3oa5NSVFhAtxuTKW4
ZlJzBabDzn2V4j985eZ1GclTlqRBNDo4SzBE2KC03aROPCfkQf+om7kNzmqI6OqV
wiEBuASnVQhXff8YLqX8+HwQtjCRi770gqTU+x9PX691zNOfa8FjGgeNcfJ7QSn9
v8JlWMLDA3Zm1BfXCExagqALj6QoSsVOT2f/w+/Hw6Vffu5O7e6P6WAvBsiJu9sB
XRgpyYCx/FwsadCeg2onIm8uYeEuH5mb8S2LxVTlGKtrsCQHrC76Vx5vGVIPcjTO
qHfvXhOYvXOML31feoKJfa64hiAKaiQNOqtFLTHOJQxvVLNdc1j2ldLRLY4qDD+l
yKicu4PUv3GphNuuOC/rcS7ps77VGozKCMRlyukqekmY2FG13kWBZToPdG7pRo8T
k29H9+UsZUVtVo2Ombx7Mm8du9FJTApPXTso8zPjkyc12xk/fikSIciOZzmsQTJR
8A7rFKMRKrrs57TbLeOwmxAD13j7EMbR7UOpK53uKEg0aH3zZqtEX2zXY+BmIvRv
glbAOGLrs1mZu2b90PrneidDjJWWxRv9KZbtGlPmFyTryLeK8Rk=
=tfIM
-----END PGP SIGNATURE-----

--Sig_/GYfzay0mcrWe3xuGjh9Xt7z--

