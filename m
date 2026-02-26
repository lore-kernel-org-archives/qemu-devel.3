Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599CFD9E1B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkA8-0006Ze-A1; Thu, 26 Feb 2026 17:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvkA6-0006Yo-2N
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:48:50 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvkA4-0001og-Cb
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:48:49 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4398913af88so1228881f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772146125; x=1772750925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AesqWR3A+DEHGL6xXHBfjeeZ/wNOVnM51V+UKn6f6YY=;
 b=rAGocMYn7RDiHw7K1XYGo/RMf8HhU2cInJVWQ7KBxW+T8onEGMG0BC60cTJ+2vhGue
 KrD1QiTBVMaNScGZHzUaaz+He1F0n2zILYCXz9xUT5OEQwhX0eOlBjRJ9+PzL3utxzjd
 hKPbKfdOVC7uK4MrVWVyX1MYoLcVpGGfR1Wg9XJ1pz8mZsO4ygjGu9LtFUJ07EBS+92N
 x6zXabzYsBg0iJ/J4DJuIt1KyUE44iWafyIqkriv2BRBQw1q1P/3fp9u+w1F/toZPOGd
 gSGX6BdyGhaRINhqE43x+6HFPir0QutkzHfECI5mCbrwNzMXsU8hwCdERn2IleCkh/Vs
 jBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772146125; x=1772750925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AesqWR3A+DEHGL6xXHBfjeeZ/wNOVnM51V+UKn6f6YY=;
 b=O7ZpenFoArOXlSWk1n1blxTNsC0F6CJ3rhB8Wrh3dbRtRgjTwXFDk8m5ZP60OHySGC
 G3/B9Z3l1LzL241BnMAs0iYac/aCu//9TbE/sttQRuA1VSTTA7UjCmvFyRTauwMmjDIs
 z8I6UzOPhSEO5hQ8tI1Nd7ApNGLMjS6H51aqlYQECK+mvc4OCuNhdmI7wja5p61gNJwX
 L3vmdu1lVFB8/RbBfiR4Kp+v9AHlBf97dFMBOKIxCTKM3HPfb85wlsJht5FfM4RrK2ZB
 AfOEOroBTe8OG3qVWdGFVsKa7Q8N6OPyWFgXK83rgoP+nQRpe5NavfTAHOu/h/lWKVT+
 Ow6A==
X-Gm-Message-State: AOJu0YyGRoJl7fg7KEHanhAo9MPASUi3p+3dYqzV9iQ/vZ4g2nchnWAz
 p+Ola/jHpfyVNRfjnbXBIyzoJon1B6Wi8O/h3iOfoTtS4etLKatK6QcFJ6ducCyG1PsYVyKA5DK
 iFzHR6aI=
X-Gm-Gg: ATEYQzy2NcqImkNEkpLwFwdxyAJz+FhiRKGYZox75QrVxSMIyJFFTfFi+y6Zoeg2Nfr
 qJlKZVhKoZmiXO5JQTh+yhvgzzms0VZ40ql9KOHqKmS6c3KCt+hWaH3c4Wa6HwJ5fiu42s3QlrX
 fuzwkKOtsof14d7T+UvGhuFu8RiwUnFq8hAGIzZhlnqgBfQ/t8MVkY7mBfKDxt4MWMgZpP29i+l
 bexP+AkA21MSwyT4Tj8hd7IwuInIqyAA5ARkS7NJNZ1w5DOa8Sy1EeKxSXBYWTMPg5S15fTHpCm
 LIS7XSo4gVaArwlnGmc5kM+ppqEhRgffkN52OZw+7Kn4V9ZIKk+WpreOCaeH0psC0VRX+7vkXQx
 opPhrTygoW+791y+etTxVonAga2885/qGXJgFm97Cz+SdZ+RYSb+EIV3ZNIYms2x4npj2G/J4YI
 5xJdrDdm74TACfC6rLwwuEytd4BexxIM8VlSMCJZqvgr0W2uKM1KBQazlVEokrFvIedPyn64T2
X-Received: by 2002:a05:6000:616:b0:437:6dac:458a with SMTP id
 ffacd0b85a97d-4399de38672mr809841f8f.57.1772146125231; 
 Thu, 26 Feb 2026 14:48:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c764546sm2613774f8f.29.2026.02.26.14.48.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:48:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Thu, 26 Feb 2026 23:48:42 +0100
Message-ID: <20260226224842.36130-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

gdb_static_features[] only contains strings, nothing target-specific.
Instead of generating one file per target, generate a single file
with a single gdb_static_features[] array. Remove the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build       | 25 +++++++++++++++----------
 stubs/gdbstub.c   |  6 ------
 stubs/meson.build |  2 --
 3 files changed, 15 insertions(+), 18 deletions(-)
 delete mode 100644 stubs/gdbstub.c

diff --git a/meson.build b/meson.build
index 451cb28149f..6d73ee40ea3 100644
--- a/meson.build
+++ b/meson.build
@@ -3867,6 +3867,21 @@ subdir('linux-user')
 subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
+feature_to_c = find_program('scripts/feature_to_c.py')
+gdbstub_xml = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml += config_target['TARGET_XML_FILES'].split()
+  endif
+endforeach
+gdbstub_xml = custom_target('gdbstub-xml.c',
+                            output: 'gdbstub-xml.c',
+                            input: files(gdbstub_xml),
+                            command: [feature_to_c, '@INPUT@'],
+                            capture: true)
+common_ss.add(gdbstub_xml)
+
 ##############################################
 # Internal static_libraries and dependencies #
 ##############################################
@@ -4218,7 +4233,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4298,15 +4312,6 @@ foreach target : target_dirs
     endif
   endif
 
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(config_target['TARGET_XML_FILES'].split()),
-                                command: [feature_to_c, '@INPUT@'],
-                                capture: true)
-    arch_srcs += gdbstub_xml
-  endif
-
   if target in config_target_info
     arch_srcs += config_target_info[target]
   else
diff --git a/stubs/gdbstub.c b/stubs/gdbstub.c
deleted file mode 100644
index 580e20702b2..00000000000
--- a/stubs/gdbstub.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "exec/gdbstub.h"       /* gdb_static_features */
-
-const GDBFeature gdb_static_features[] = {
-  { NULL }
-};
diff --git a/stubs/meson.build b/stubs/meson.build
index 8a07059500d..1e0f6f47377 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,8 +89,6 @@ if have_system
 endif
 
 if have_system or have_user
-  stub_ss.add(files('gdbstub.c'))
-
   # Also included in have_system for --disable-tcg builds
   stub_ss.add(files('replay.c'))
 
-- 
2.52.0


