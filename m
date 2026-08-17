Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71002C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvurC-0002QU-0H; Mon, 17 Aug 2026 06:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqp-0001sP-5e; Mon, 17 Aug 2026 06:45:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqn-00043m-AB; Mon, 17 Aug 2026 06:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=udj1uJpaXi4OHWyJ74EdT710dnNlm5D93AeEwtcbOZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cQpdBpvvE4iFpwphBjvyH1fxJWibveDQ0mZQpuisdCcRQEAKMFAgYjlsClIc+G7vd
 3P48L27Mma2xWAsyEA/iV8CO9zw0aLnVImjMBgl79xVZ5H+N6KA2dIEgHGt6RW0zFy
 cklgKZHYeXRVIh1/NiDO5fK35DYqU1m5YJM0d42JK92PbjHhOd88kgWc42vgxvwVnn
 Xxw6DAvk+yQ6ZNP+nVxpBSzkvBGdy3hYdt3TbkHJ4eeC/OsLaWCURvzXG3dQJmh3xE
 ehmftg+DIv9hwbj9OK3cOa0CwH/Ev8Z/K47Wa81ShmxvdJyzHMJ+VZNJ9hHl4Yf3hC
 4xVQB7qk/A0TA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 918A61CBB75;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9336C40D206;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1DB8B30E62; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 136/161] pc-bios/s390-ccw.img: update s390x bios
Date: Mon, 17 Aug 2026 13:42:50 +0300
Message-ID: <20260817104344.2047346-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Update the s390x bios with fixes for intermittent errors when IPLing
from PCI devices.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit f4b7ae0a9ee41baad3b6c1e2b55611793de013cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index 48ac78c8945..e24a93e14a8 100644
Binary files a/pc-bios/s390-ccw.img and b/pc-bios/s390-ccw.img differ
-- 
2.47.3


