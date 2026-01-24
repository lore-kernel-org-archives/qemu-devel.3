Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0DED715E7
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 13:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjdVs-0005hf-2p; Sat, 24 Jan 2026 08:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vjdVe-0005f2-Rr
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 08:17:03 -0500
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vjdVY-0003Wd-91
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VX
 g2ZsBcYXWMh0aWHXhcDrWx0TXjrismPg6INzZ+Q1U=; b=Z6ol5zI2PtyMj0CQtQ
 E1UF3oWDHDXNoiGUcexM9V/UO+1QUbZU/Bca7IP1it1gtyzM2NKqwYh80aGZ1leP
 pPRq8dA0M3D/x1EJbjIkQxpBSsYVSjCj36kCATPwSxEMEDg6fndX+6oefj0qn3mq
 iA9+gV06K4F+Bko+I/D6Kns7M=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wDHz1D8xXRpiJ99Iw--.27637S2; 
 Sat, 24 Jan 2026 21:15:42 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, crauer@google.com, joel@jms.id.au,
 jonathan.cameron@huawei.com, philmd@linaro.org, ani@anisinha.ca,
 cminyard@mvista.com, Alano Song <AlanoSong@163.com>
Subject: [PATCH v2 0/1] hw/i2c/dw: Add DesignWare I2C controller emulator
Date: Sat, 24 Jan 2026 21:15:36 +0800
Message-ID: <20260124131537.78942-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHz1D8xXRpiJ99Iw--.27637S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1UtrWDJF45WrWrGF4rXwb_yoW8Jr13pw
 4DKr1fAr4YvF1xuan3ZF18GrWrGa1kJrsIgF9xJw17ZrWayF17Ar1kKr1Fya47JrW0gr47
 tr17trn8CwnYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvtC5UUUUU=
X-Originating-IP: [240e:36a:14f2:5500:b654:ca9d:81bb:532f]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9h8oPGl0xf+ntAAA3J
Received-SPF: pass client-ip=220.197.31.5; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

v1: Initial version:
    1) Add DesignWare I2C controller according to DesignWare
       I2C databook v2.01a.
    2) Confirmed under v6.18 kernel driver.
    3) The slave mode is not implemented, cause this feature
       is usually not used.
    4) The 10 bit slave address is not implemented, cause
       this feature is usually not used, and not supported
       by qemu I2C core bus currently.
v2: Refine according to review comments:
    1) Define registers by using registerfields.
    2) Use SPDX license.
    3) Confirmed under v6.18 kernel driver.

------

This patch seems to be a duplicate of Joel & Chris's work:
https://lore.kernel.org/qemu-devel/20260109123211.368869-1-joel@jms.id.au/

It's just a coincidence, :)
But it's okay even if it not been merged, I just want share it and hope
it can help others.

Signed-off-by: Alano Song <AlanoSong@163.com>

Alano Song (1):
  hw/i2c/dw: Add DesignWare I2C controller emulator

 hw/i2c/Kconfig          |   4 +
 hw/i2c/dw_i2c.c         | 515 ++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build      |   1 +
 hw/i2c/trace-events     |   4 +
 include/hw/i2c/dw_i2c.h | 131 ++++++++++
 5 files changed, 655 insertions(+)
 create mode 100644 hw/i2c/dw_i2c.c
 create mode 100644 include/hw/i2c/dw_i2c.h

-- 
2.43.0


