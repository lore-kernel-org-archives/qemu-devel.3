Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51628606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=w2ROziMp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxX-0001wu-PG; Fri, 27 Nov 2026 00:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxU-0001my-Bq; Fri, 27 Nov 2026 00:57:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxS-0003p3-Kn; Fri, 27 Nov 2026 00:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=AKjhVvEcZ1AuHHvWH27hLwli9cPl922S0um8nC+so3w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w2ROziMpZCizHto2FcRjzGse3OHBAAq99l79Rrr9mtc2Uza9XgXsT7KNcLm27dv+u
 XyoRpq2eA7z+UxrUUhiEzj9f91UOnz6Iq3yfbWVRqqBsTzicwHsK8aNF371OBpLzXk
 AQFJBZUYtBcZ2ArTqx6XO8S4hL4wBYiUNZYhRWBECDs1iUUVbQL2tUwTi448l/MH4C
 1ReenvAiooo7+mXWmSa8hLBmir9heAdJG2i40mpwpqs62vAnBwQUaV7xSMDocY+icS
 Zt0/rMwnPIPP05yLTKNoHD84TERAxvHq8gQHkadZYnWtORWGB6W3Wx7aMb9eRLUrsj
 pRF3S/fyMTYOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 921881EA2E6;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F9C2469921;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 84AE0CF24E; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peng Fan <peng.fan@nxp.com>,
 Julian Vetter <julian.vetter@vates.tech>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 092/140] hw/xen: Mark legacy Xen backends as
 hotpluggable
Date: Fri, 27 Nov 2026 08:53:18 +0300
Message-ID: <20261127055421.39015-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peng Fan <peng.fan@nxp.com>

Commit 250e797ceada ("hw/xen: Have legacy Xen backend inherit from
DYNAMIC_SYS_BUS_DEVICE") changed TYPE_XENBACKEND to inherit from
TYPE_DYNAMIC_SYS_BUS_DEVICE, whose class sets hotpluggable = false.

Legacy Xen backends are created from xenstore at runtime, after the
machine is ready, so device_initfn() marks them as hotplugged. The new
class setting makes device_set_realized() reject them with:

  Device 'xen-backend' does not support hotplugging

Since xen_be_get_xendev() realizes the device with &error_fatal, QEMU
then exits. For example, "xl usbdev-attach" triggers this when the qusb
backend is created dynamically, killing the guest. The same flag also
causes qdev_unplug() to ignore these devices.

Override hotpluggable in xendev_class_init() to restore the behavior
before the offending commit.

Cc: qemu-stable@nongnu.org
Fixes: 250e797ceada ("hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Julian Vetter <julian.vetter@vates.tech>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 8c40d4495d19c2d2d5a97a432d9fb18e23cc8f66)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index bf58db0ca68..6de11762e19 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -640,6 +640,13 @@ static void xendev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /*
+     * Legacy Xen backends are created and destroyed dynamically from
+     * xenstore at runtime, after the machine has been initialized.
+     * TYPE_DYNAMIC_SYS_BUS_DEVICE marks devices as not hotpluggable,
+     * so override that here.
+     */
+    dc->hotpluggable = true;
     dc->bus_type = TYPE_XENSYSBUS;
 }
 
-- 
2.47.3


