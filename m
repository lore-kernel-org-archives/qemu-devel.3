Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23EFE7FDDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn127-0000EL-Mh; Mon, 02 Feb 2026 16:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn122-0008C5-RV; Mon, 02 Feb 2026 16:00:26 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn120-0004Dg-SC; Mon, 02 Feb 2026 16:00:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5EB8C1851A2;
 Mon, 02 Feb 2026 23:57:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1E47535B319;
 Mon, 02 Feb 2026 23:58:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alano Song <AlanoSong@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 22/74] hw/i2c/imx: Fix trace func name error
Date: Mon,  2 Feb 2026 23:57:33 +0300
Message-ID: <20260202205833.941615-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alano Song <AlanoSong@163.com>

Signed-off-by: Alano Song <AlanoSong@163.com>
Fixes: e589c0ea9c9 ("hw/i2c/imx_i2c: Convert DPRINTF() to trace events")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251218141144.51001-1-AlanoSong@163.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 3fbadbb3927a92db1932baee0c1188b05c0ac6b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


