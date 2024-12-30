Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09B3E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 23:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSPNT-0005ba-3t; Mon, 30 Dec 2024 18:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santiagorr@riseup.net>)
 id 1tSP5C-0002rI-EB
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 18:21:58 -0500
Received: from mx1.riseup.net ([198.252.153.129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santiagorr@riseup.net>)
 id 1tSP57-0003w1-Fv
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 18:21:58 -0500
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4YMXDZ4S39zDqLs;
 Mon, 30 Dec 2024 23:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1735600910; bh=rEiUtNHPO8psAyaOSK4furEFEkLfV4HWjuPL6yXLLfE=;
 h=Date:From:To:Subject:From;
 b=aPm4O+NXGSOQrBUmUfSZW92Ubg2FKZyrAnmhMGH4IkSNBWc2a3FKfqTZE1JUHO5cf
 Ts+8UXb/NYRh7tZd3tUfvFuo6s0TfW5JqnYbp7aANQKvl/QTG53ZWKOIsjPcoBG0OG
 d13LSPGJ6Fev+jLnjsyVPf3JJu8LOgUdmB66Lc0g=
X-Riseup-User-ID: 099E50E7ABF0CEE9B13BC02833B1BD519E095355867339F501A9D95E721CEA95
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YMXDY66cCzJrS0;
 Mon, 30 Dec 2024 23:21:49 +0000 (UTC)
Date: Mon, 30 Dec 2024 18:21:47 -0500
From: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
To: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Chuhong Yuan <hslester96@gmail.com>
Subject: Addressing CVE-2024-3446 in qemu versions shipped in debian bullseye
 and older
Message-ID: <Z3MrCyX8tVQMPjz7@voleno>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6zd4WvSoo+ou2MhV"
Content-Disposition: inline
Received-SPF: pass client-ip=198.252.153.129;
 envelope-from=santiagorr@riseup.net; helo=mx1.riseup.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Dec 2024 18:40:45 -0500
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


--6zd4WvSoo+ou2MhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello there,

(Please CC me since I am not subscribed to the QEMU devel list.)

I am working on backporting some CVE fixes to old Debian versions
(bullseye and previous), and I would like to ask you some help to
confirm if QEMU in those debian releases is affected by CVE-2024-3446 or
not. This is QEMU 5.2, 3.1 and 2.8.

On the 7.2 branch, the following four commits are required to fix
CVE-2024-3446:
https://gitlab.com/qemu-project/qemu/-/commit/e070e5e6748e3217028fa21aa30bb51f862368c8
https://gitlab.com/qemu-project/qemu/-/commit/6d37a308159766cb90ed745cfeb1880937b638ec
https://gitlab.com/qemu-project/qemu/-/commit/e7c2df3fd748a20a8b7a316d186b3ac77551f159
https://gitlab.com/qemu-project/qemu/-/commit/7aaf5f7778de4d75a169ab193f08857eb28db3a4

AFAICS, the qemu_bh_new calls were replaced with qemu_bh_new_guarded in
7.2.6.

Please note that 6d37a308159766cb90ed745cfeb1880937b638ec (and
ba28e0ff4d95b56dc334aac2730ab3651ffc3132) include this bug as reference:
https://bugs.launchpad.net/qemu/+bug/1888606. Could you please confirm
the CVE relates to the same issue?

I am unable to reproduce the issue. I've tried the reproducer found at
6d37a308 and the one from the ubuntu referenced bug. However comment #5
in the ubuntu bug mentions it was reproducible with QEMU 5.0, so I am
confused.

To summarise: it OK to affirm QEMU 5.x and older is unaffected by
CVE-2024-3446?

Thanks in advance, and happy new year!

 -- Santiago

--6zd4WvSoo+ou2MhV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR+lHTq7mkJOyB6t2Un3j1FEEiG7wUCZ3MrCgAKCRAn3j1FEEiG
754aAP46wRh7i2ijhaCIr/+hrfF1929hYliF5cFBotGd9ZtwcAD/eItlD/5nu2vD
pgOCtCkV1VaodAB3mniRU/goywja5AY=
=kkgD
-----END PGP SIGNATURE-----

--6zd4WvSoo+ou2MhV--

