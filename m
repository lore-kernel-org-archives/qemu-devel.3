Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMUc-0005Sj-60; Thu, 18 Jul 2024 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUa-0005H0-5L
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:28:00 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUX-0002WG-NO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:59 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721291264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmZB4XwFunCnoC/FQ6QnBDumKGSssPizQ8tHdXR/z08=;
 b=uzQEFA1s2ecoe80+G0wwKjdtzI4cqzxSBzj3F6/golaUoi/Sbs3tYBOsSk7XINcWdBaI5F
 auAfDUK2jdYA5Mldv6kR6gUXR5VHz2GaRys7MPKS2gXq5IvgSBgdh4tYJS/fsWNdzF5Saj
 0nistxmOhfI35KOR0Ad6L75fb9tVliJUu9vf3Nt4barEswsgSs3KHXFHvz12P9EdTUOkN7
 hQ/UNLMyIDN3B2ap8RHtaIQTSvOsRJ7RmlrOgQvkrzVWWfO2PMqs45lWsul7ONM68w89y1
 F+eOoW6q2d4Ospzg/fUwNsrEuT8YQnMI+snNR/OkQxo+trnRELVKiR9OyTIhHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721291264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmZB4XwFunCnoC/FQ6QnBDumKGSssPizQ8tHdXR/z08=;
 b=Vl/YL37dtaNQ+HybLjcyAPVvZrcKYRQRr+tmMr9bHiy+Rfw90BTnRxvKJvCqzX5NcN24Iv
 OFIuCMcbtACcXaCA==
Date: Thu, 18 Jul 2024 10:27:38 +0200
Subject: [PATCH v4 1/3] docs/interop/firmware.json: add new enum FirmwareFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240718-qapi-firmware-json-v4-1-449ce672db5c@linutronix.de>
References: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
In-Reply-To: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721291263; l=1407;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L4+B74F9a35lXUy1Ep2m0jTKC7wqqLH5EyNaxqvfb7s=;
 b=Plksh+QxCSIwzY54Z8hGbNp10cVshuXhaRvgM+cfa5oOk8IKkrV68gOcDi7cyi2pcloCXd2AP
 eZuXBJem6chDGzuvAm+ZOGKAJ/z+EDtdj0OL1YcyNC54Q47gwhzGrmS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Only a small subset of all blockdev drivers make sense for firmware
images. Introduce and use a new enum to represent this.

This also reduces the dependency on firmware.json from the global qapi
definitions.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c1041..a26fe81bf2fe 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -15,7 +15,6 @@
 ##
 
 { 'include' : 'machine.json' }
-{ 'include' : 'block-core.json' }
 
 ##
 # @FirmwareOSInterface:
@@ -200,6 +199,20 @@
              'enrolled-keys', 'requires-smm', 'secure-boot',
              'verbose-dynamic', 'verbose-static' ] }
 
+##
+# @FirmwareFormat:
+#
+# Formats that are supported for firmware images.
+#
+# @raw: Raw disk image format.
+#
+# @qcow2: QEMU image format.
+#
+# Since: 9.1
+##
+{ 'enum': 'FirmwareFormat',
+  'data': [ 'raw', 'qcow2' ] }
+
 ##
 # @FirmwareFlashFile:
 #
@@ -219,7 +232,7 @@
 ##
 { 'struct' : 'FirmwareFlashFile',
   'data'   : { 'filename' : 'str',
-               'format'   : 'BlockdevDriver' } }
+               'format'   : 'FirmwareFormat' } }
 
 
 ##

-- 
2.45.2


