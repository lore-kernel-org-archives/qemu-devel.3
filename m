Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A703AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiBK-0008V2-9h; Fri, 19 Jul 2024 03:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBJ-0008Qv-2b
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBG-0002iv-DO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:32 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721374648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBcL1syjyGS1qWE3K7R757xdr/StDjGvbblnaUIALUM=;
 b=gnIOqJMi4jhe5rY3W+QA82MhYAK5aum08FZmJcqV5YZg5yoFx4jfbUWP0KZNST7Wik6y+4
 4kFASciUU+Ii5+HRPaZDh0Gvt3mNvNjGUxLbApXS23EElbBubUoLGomcjDspghSUFZodUB
 qVBdSRHM0t0Uo0oygPIVAQOniTNOiJ12AtqS7OKht3QALsoTZANfbOQAxMRP6gwPIxXblQ
 wTS6IdoXVCudJfftqP8NYV7baJz59kQ9RxgcOvffmwaW12PI6WWM+BcHQLk/s1t5nsRpES
 u1JxEkz2QXKfZOCfKebJ2KN2SQBFtrcf01HBlH7yHw8GG4G3MV+XDcMyPiMNLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721374648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBcL1syjyGS1qWE3K7R757xdr/StDjGvbblnaUIALUM=;
 b=q7KyU2CZpkDdcqPi/StHf2B//8VmzXvfn9crJhnQamPZWMytjkaz5WIqslYFmr10Kq0iNT
 nWseVK/xrbvzOCCA==
Date: Fri, 19 Jul 2024 09:37:23 +0200
Subject: [PATCH v6 2/4] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240719-qapi-firmware-json-v6-2-c2e3de390b58@linutronix.de>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
In-Reply-To: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721374646; l=1862;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gkYZ4XZ52nfLzPLf7IOMojsPGrZbXCzUZAx5qYcyj3E=;
 b=4XyFU9GdkmpB0aHaC3Bu/NmghcITGPeX2mpqgYvtC0+OEyDtkvkjEtIXo2Yg/ZP049bWRy9g/
 11EuEsQlcbTDj+Zt3Q2TWwq0IuHL16UZwTybyExWKXNa8vs4JRm6MVj
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

Claim "Since: 3.0" for the new enum, because that's correct for most of
its members, and the members are what matters in the interface.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index d5d4c17f230b..ae4179994479 100644
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
@@ -59,6 +62,27 @@
 { 'enum' : 'FirmwareDevice',
   'data' : [ 'flash', 'kernel', 'memory' ] }
 
+##
+# @FirmwareArchitecture:
+#
+# Enumeration of architectures for which Qemu uses additional
+# firmware files.
+#
+# @aarch64: 64-bit Arm.
+#
+# @arm: 32-bit Arm.
+#
+# @i386: 32-bit x86.
+#
+# @loongarch64: 64-bit LoongArch. (since: 7.1)
+#
+# @x86_64: 64-bit x86.
+#
+# Since: 3.0
+##
+{ 'enum' : 'FirmwareArchitecture',
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+
 ##
 # @FirmwareTarget:
 #
@@ -80,7 +104,7 @@
 # Since: 3.0
 ##
 { 'struct' : 'FirmwareTarget',
-  'data'   : { 'architecture' : 'SysEmuTarget',
+  'data'   : { 'architecture' : 'FirmwareArchitecture',
                'machines'     : [ 'str' ] } }
 
 ##

-- 
2.45.2


