Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D3CC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUY56-0000Om-5f; Mon, 29 Jan 2024 15:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUY54-0000OT-Sb; Mon, 29 Jan 2024 15:18:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUY52-0006eD-T4; Mon, 29 Jan 2024 15:18:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8244D48726;
 Mon, 29 Jan 2024 23:18:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 274426E603;
 Mon, 29 Jan 2024 23:18:03 +0300 (MSK)
Received: (nullmailer pid 1288388 invoked by uid 1000);
 Mon, 29 Jan 2024 20:18:03 -0000
Subject: [ANNOUNCE] QEMU 8.2.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 29 Jan 2024 23:18:03 +0300
Message-Id: <1706559483.050357.1288382.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v8.2.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.2.tar.xz
  https://download.qemu.org/qemu-8.2.2.tar.xz.sig (signature)

v8.2.2 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

read
063472fa01 Michael Tokarev:
 Update version for 8.2.2 release
read
b79a2ef0d4 d2b668fca5 Cédric Le Goater:
 vfio/pci: Clear MSI-X IRQ index always
read
106aa13c5b 27eb8499ed Fabiano Rosas:
 migration: Fix use-after-free of migration state object
read
e589e5ade7 918f620d30 Markus Armbruster:
 migration: Plug memory leak on HMP migrate error path

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmW4B/sACgkQcBtPaxpp
PlkbsQf+M/HJfNprO4IhhPW1nkXneanYJXmIB+Tg80ZKlg8Xety0mPuBPgi1v3UI
r2vG4Ez/m6YyeJ4tzeXiU7EhIBOhTrgWnkxE++mU+5Hhu6pdFiu2znGP3tUnzmAO
qA4cuDqf06kMBCK00RXsc5HrMBG4wTELTtB7NngeadC+vqqVLnWqTYts/46yJliR
6TQTEvw6y8nfm78pS2S6yxzHYtT+A0Mzy1OOebeBzcTR2T9/EXTLcK05Il+Y80KQ
1JGmJNRsezFC53gdsDpms78GS7Mt7aYGKzyrOoW8hJrQHxmY/8B2pKeQqfyXupr0
s6NLW1xnK9K+baNTDANS3NkVgvuDmg==
=dRv0
-----END PGP SIGNATURE-----

