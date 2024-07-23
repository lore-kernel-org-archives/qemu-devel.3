Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FDCC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIZ-0005Vf-Fb; Tue, 23 Jul 2024 16:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIV-0005HW-CO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIT-000402-Jj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so44948115e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767184; x=1722371984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3ABXJMZuK4B1pMDKEQUPr16WMzhgKew8s6daG0+jWs=;
 b=kh7kmD0ubn5EzesGqCO9IllbKBVncUaGtCr5swW8oUW+n7PAmckkKZ6AFsCKRD3JE6
 eLRENYq2gbyu0ig2ftmOSo/iB0EpKh62xsRt7vWRVtV6pWo8pxPqfzZT9l+mr3Wwh0Kc
 OojoAaf9T2KRgtfg5GjUuams65H7rwnH+n13F1/qACvw4vN7dB97uMCpKqkossFcpz5N
 4RDEdq9QNCRJJdvLAagmIJJEOhqi5BvDEDqJ0ql6gERAqm7Jjdq253Fi6T6ykeZ0PHYX
 0CGR9MO9y/EFT8liibPdL9cj+z9gtv2Vd1+qHF7fbepaPR9K7mBdkvSBcdHpykxATxTL
 m6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767184; x=1722371984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3ABXJMZuK4B1pMDKEQUPr16WMzhgKew8s6daG0+jWs=;
 b=PAMXx5gSthZ/hx9rNBsuMohmHPbUgAyCeNXxON2FrALrx2W51rokyZQC/D8IbkYtCM
 hJa1Ino+yHL7R+6p/zFlL0K6c7Pw04SR/UAaMl00fOasL4Fdi/393QWpQwPEYILx2IEJ
 6/ZZf8lOsvMShNsAcxKx0BVuXznJgaVl4jpcf1i+QcRQktc3qtW96QRxbxtQ1HTQE6jc
 KbfMi1XMJUF6MJvzJVXu2a0T2O1flngfmFRh7JCYSdyo0Z+2jDrBfwUQ7yHI8QUBc4NZ
 mhsATysS8JXkuiXfaCxgVKAPJuw6onBxu940QKC9gT0cPq18+7At/urw222K6vev02UQ
 UxjQ==
X-Gm-Message-State: AOJu0YwxXjnByrls0Qa8y8a44FI+BQr88Jgq/khTJmITgkEVtnw/C+vN
 h4oR9uiSLmHrVJfYdHj28XafkTbTld0JRFFJYRDES59ww3EjWFs/tI+/3VqGf4ZkC3skec+UmRW
 w3g8=
X-Google-Smtp-Source: AGHT+IFgC5CyAp4R2oa08g2Qnx/boScJWTKQWrhU/93BBIPnaF9e6TvsFZ+o2eCV9XDLs/kQdvEzrw==
X-Received: by 2002:a05:600c:3514:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-427f956075dmr59895e9.19.1721767183733; 
 Tue, 23 Jul 2024 13:39:43 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9397337sm483385e9.23.2024.07.23.13.39.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/28] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
Date: Tue, 23 Jul 2024 22:38:35 +0200
Message-ID: <20240723203855.65033-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Only a small subset of all architectures supported by qemu make use of
firmware files. Introduce and use a new enum to represent this.

This also removes the dependency to machine.json from the global qapi
definitions.

Claim "Since: 3.0" for the new enum, because that's correct for most of
its members, and the members are what matters in the interface.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240719-qapi-firmware-json-v6-2-c2e3de390b58@linutronix.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/interop/firmware.json | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index d5d4c17f230..ae417999447 100644
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
2.41.0


