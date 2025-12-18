Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634F7D6D22A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 14:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWEkA-00058q-K3; Thu, 18 Dec 2025 09:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vWEk0-00057I-U4
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:12:30 -0500
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vWEjv-0001Fj-FB
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=p/
 WXD4iRHWOMIcPfG6IqSWNQIOsEDs5kB5GU3e5Ie5A=; b=BAiUvrDM0t8G8j1IEs
 k+osCPixwZTlm4hxHZRQlfPSznaPTU1uzWYdO0r1/0Hw48ZFWpkY2z8whAeY0vJb
 +nSD4U2NmT2TaJGfQ0h0XvyCqpy29i3/xE0cY5oewrbV6aanVQ4HqTaDoi6LcsWz
 AdMXXgf1PZNTnlBfXcamxJr6g=
Received: from alano.. (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgDX0bujC0RpBlCjHw--.122S2;
 Thu, 18 Dec 2025 22:11:49 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: cminyard@mvista.com,
	Alano Song <AlanoSong@163.com>
Subject: [PATCH] hw/i2c/imx: Fix trace func name error
Date: Thu, 18 Dec 2025 22:11:44 +0800
Message-ID: <20251218141144.51001-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgDX0bujC0RpBlCjHw--.122S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF45JryrAF15Xw43CFyrXrb_yoWxCFg_u3
 s7JrykAry5Xrn3X3Z5Zw4UJr4j9w1Ika1I9r48KF1Yg3Z8tr12kFsrWa93Zry8JrsFgF98
 ZryDXFnxtrsFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREw0ePUUUUU==
X-Originating-IP: [240e:36a:140a:ca00:19a4:5cc3:8075:8e99]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0wZXa2lEC6aa4wAA3Q
Received-SPF: pass client-ip=117.135.210.5; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Alano Song <AlanoSong@163.com>

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/i2c/imx_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index d26177c85d..22b10e4166 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -151,8 +151,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
 {
     IMXI2CState *s = IMX_I2C(opaque);
 
-    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
-                       offset, value);
+    trace_imx_i2c_write(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
+                        offset, value);
 
     value &= 0xff;
 
-- 
2.43.0


