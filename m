Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC1C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMUa-0005Eq-82; Thu, 18 Jul 2024 04:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUY-00054K-Jw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:58 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUW-0002WC-OD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:58 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721291264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZq3IhRbauWHu6szJR9OYc5OJgdDZeWUwH4DxCktR0M=;
 b=AhcL29ALkZvGY2d77l2SLgVuZO1ePkQTz2DQFg58mNm5u3EVcT/qwSjsCEIfn/RyyApxvR
 v3OBP93LF2RBXHV5sZNGX47uoDlWRRSeVloXJbO4SZGXXLjN723mg7NdbIZufGRfQZoMJH
 oIHEX2K5Ns0WxMsQxIMfdJzF00o0jlBAqMSMW7/ZYSX7SckWv9On4Zm3IH8mgOOT1hLi94
 ax1PX5i+hMX0S0yi0XqzNfly62SgR8Op/DzWWyUkxe6DSJ4A0rdTyISPywzwQnT0eAXKI/
 LIsABnpn3jdDygNS2VMThhLehpDlAqQvlHJ1epXqPC0CoCHdBexTIa5LD14abQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721291264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZq3IhRbauWHu6szJR9OYc5OJgdDZeWUwH4DxCktR0M=;
 b=uvtJQuVarq/S1SwwBRY8dQ7l7rWU6uO9Q9AYxxrCMdPCpvuuCoiGs8GCSoMuxR6csrp42r
 8CKJXez5+6GnapDg==
Date: Thu, 18 Jul 2024 10:27:39 +0200
Subject: [PATCH v4 2/3] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240718-qapi-firmware-json-v4-2-449ce672db5c@linutronix.de>
References: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
In-Reply-To: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721291263; l=1708;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Tgea5UFMchTgIegHd+6uSGpAuKHpdth+Ngd2mO6Tpjo=;
 b=pWy0emCUQngrUYlQEiSM5lqzHZmnEqxJ/DFeEv7fHvnwXLaLJOZkYDV6wHtSFxFnPwB44vHyF
 ba408KzvTrqCwAxP/soWW7aCmyKqr9nx4xgY8ENeFy9ovtE6nzhPy8p
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only a small subset of all architectures supported by qemu make use of
firmware files. Introduce and use a new enum to represent this.

This also removes the dependency to machine.json from the global qapi
definitions.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index a26fe81bf2fe..2eb0be11d595 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -14,7 +14,10 @@
 # = Firmware
 ##
 
-{ 'include' : 'machine.json' }
+{ 'pragma': {
+    'member-name-exceptions': [
+        'FirmwareArchitecture' # x86_64
+    ] } }
 
 ##
 # @FirmwareOSInterface:
@@ -59,6 +62,28 @@
 { 'enum' : 'FirmwareDevice',
   'data' : [ 'flash', 'kernel', 'memory' ] }
 
+##
+# @FirmwareArchitecture:
+#
+# Enumerations of architectures for which Qemu uses additional firmware files.
+# The values are a subset of the enum SysEmuTarget.
+#
+# @aarch64: 64-bit Arm.
+#
+# @arm: 32-bit Arm.
+#
+# @i386: 32-bit x86.
+#
+# @loongarch64: 64-bit LoongArch.
+#
+# @x86_64: 64-bit x86.
+#
+# Since: 9.1
+##
+{ 'enum' : 'FirmwareArchitecture',
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+
+
 ##
 # @FirmwareTarget:
 #
@@ -80,7 +105,7 @@
 # Since: 3.0
 ##
 { 'struct' : 'FirmwareTarget',
-  'data'   : { 'architecture' : 'SysEmuTarget',
+  'data'   : { 'architecture' : 'FirmwareArchitecture',
                'machines'     : [ 'str' ] } }
 
 ##

-- 
2.45.2


