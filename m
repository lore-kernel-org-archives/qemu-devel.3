Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E53C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weIMp-0005LO-97; Mon, 29 Jun 2026 16:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weIMU-0005IJ-PL; Mon, 29 Jun 2026 16:13:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weIMR-0004QP-Cx; Mon, 29 Jun 2026 16:13:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id C5B688065C;
 Mon, 29 Jun 2026 23:13:34 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:946::1:3])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XDkBj9EZYOs0-E9KjMSDI; Mon, 29 Jun 2026 23:13:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782764014;
 bh=APrLuPJVmFA5ePa5w3kawd8BPOgvoMfTZisIY2pAZz4=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=qgkOauoowX/TdCcFmPEh0lUV2PzU+49ZA1r7inmehxsHReipvTRCH0zKKyhuZdtfJ
 3VYua9gHC70CUWAKjEBiwz7Kf0zEvxThN52TIJnvcEgb4FdBzohDfONhxV1qmV4QNp
 qDRlHezDT2pWeOG2f1fVPP+udFWVVYF0Vky11lLo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanha@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: [PATCH] tests/../test_hotplug_blk: drop unused nic
Date: Mon, 29 Jun 2026 23:13:32 +0300
Message-ID: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

The test doesn't need any networking, so drop the net card.
Also the test will break if at some moment q35 aliase refers
to machine type with default virtio-net nic, which will clash with
virtio-blk in the test, and

   self.wait_for_console_pattern('virtio_blk virtio0: [vda]')

will not work.

Let's make the test a bit more resistant to experiments with
machine type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/x86_64/test_hotplug_blk.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/x86_64/test_hotplug_blk.py b/tests/functional/x86_64/test_hotplug_blk.py
index 7ddbfefc21..a9b43fe2e9 100755
--- a/tests/functional/x86_64/test_hotplug_blk.py
+++ b/tests/functional/x86_64/test_hotplug_blk.py
@@ -66,6 +66,7 @@ def test(self) -> None:
         self.set_machine('q35')
 
         self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args("-nic", "none")  # avoid creating default nic
         self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
         self.vm.add_args('-m', '1G')
         self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
-- 
2.43.0


