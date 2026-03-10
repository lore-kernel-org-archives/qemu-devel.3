Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1BFD88C5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05IV-0004o0-VB; Tue, 10 Mar 2026 18:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05IG-0004QG-Qa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:11:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05IF-0002Rj-7K
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:11:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso39757015e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180669; x=1773785469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8ZSWTRc08ExH1rnCtqpock1Z5jkgGW0xJjAXZvGINU=;
 b=QikDnaXR/a7nn/XdlBgvm4qBCj7Me9gRYyugq4+YKpYxQSKCqLekeuokuaHP1JTzHs
 cq1QKWzrWEwBL6PhQLtbC8wI/ZeK3Af7r/EEDr4vmkCr7hubpHMf3dX+0xgo9yGlZcJh
 sHDmSDTsRXddO9mSXvs32vTEVh5e4DlNO1EOmSXEyeKNLdd0Mpbll8+Z2TIjDI0FOfHW
 1ngMwMHrpx4IuBZsqgIstvCFTsL5476JN78TAufK9i5cqCsoC1nRl+4u5nYzJMd/Hs2M
 3fd4B2oBRH+/Hlw4PKPgD+6VymA+eMcokyvXWpjW/hPtCeSErvu0YwlVKXqwqD4sKw9i
 7iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180669; x=1773785469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8ZSWTRc08ExH1rnCtqpock1Z5jkgGW0xJjAXZvGINU=;
 b=gNOV0IIRHiWVrouRe3fbQ0d+xgvJJNw2t/9RTgojR9V6a+APls4SeEiu+3AaLvlPHJ
 iPKoxpuRfUsvj9ulSIpX9koTwcmnm707441YmRnlcvJyg0hw73RsURjwXkP83m3LIHPw
 fYR+/9KV2lFoPc/Ela3olwuwSgMgC2vGYi+tO8JCzbY26QfiCg1yT0w5qhrMulC8OqJ/
 VHEM3nhh6oUDCyjRVYoTEiFObUHV714ACKVN8oqadO8pr02OZUqlJ24aK8xMR+2ICXWy
 Nvx1SbnkMbAQH3swp3Z8HUnZSmkfy3GvA/S24mjSxdkxmBeLwaFGQZXBAcnNrMqg+1f0
 cHOQ==
X-Gm-Message-State: AOJu0YzHrZDTozXkWTFpaVmcF2Uw1IT2jRu0zVlR+BOWeXdz9CI9lgSE
 hXbUWKiOeLVtX8RG8jREi/ZjePmrZ/ius4P2pKg/AfmhCGyOMTFYgJg0x3jT33PqnOhTA3qFAmC
 5sQpyTvQ=
X-Gm-Gg: ATEYQzykfmhmh428m3xnRbmKGyzhtKz9Eis5DgsUsZp8nsd1B89jfWQr4hf+nZ5foAK
 r/pifVQpdy53Kz4NNEBvwYzdVSBJJ3bUArdP9oyKMKBZfFQBrjnAEngHgmHPz+19CPKXTtvjhB6
 R2/DINzyc2OROHGvXrpO/98fGYShkvYkH09g6IXwLulH5bLK1l+ammgnyt2/dfvnEEOmR6lZLyP
 4K8nyZcUBSXEZCa3jKSfrYxqh/OdypBa2aIpwKUlUY87A71VyHODwh1uQ2T/2J48V0GQ1lU6BZU
 W46gKAsYoFkoTyjbNaqe1jkPLIxDgJfymx1avyIXiv/fIhl8xM6YF/957faEzMd2HjX5ltf9jf1
 zoU3V1taDmletseAMBcTnZ6lZwdVy+Sq5LFM8yX7KtkjscNaNO2pDfTrf0Iu4oXjqcJPbQfK/4W
 QyUDOPVm4NXjxqnwLp+E7iXCSlQ7dUXLsqXZ+1CCX3kE7efRQvOJMHb8ReizE5uHsh0muVaJgI
X-Received: by 2002:a05:600c:1395:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-4854b1080cfmr5808845e9.21.1773180669523; 
 Tue, 10 Mar 2026 15:11:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0fa41csm2507425e9.29.2026.03.10.15.11.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 12/12] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Tue, 10 Mar 2026 22:59:15 +0100
Message-ID: <20260310215916.55815-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

gdb_static_features[] does not depend on target-specific code.
Instead of generating one file per target, generate a single file
with a single gdb_static_features[] array.

Co-developed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                               | 14 --------------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 23 +++++++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 23 insertions(+), 16 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

diff --git a/meson.build b/meson.build
index 503cde5ea90..538efb7092d 100644
--- a/meson.build
+++ b/meson.build
@@ -4248,7 +4248,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4328,19 +4327,6 @@ foreach target : target_dirs
     endif
   endif
 
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml_files = []
-    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
-      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
-    endforeach
-    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(gdbstub_xml_files),
-                                command: [feature_to_c, '@INPUT@'],
-                                capture: true)
-    arch_srcs += gdbstub_xml
-  endif
-
   if target in config_target_info
     arch_srcs += config_target_info[target]
   else
diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
similarity index 100%
rename from stubs/gdbstub.c
rename to gdbstub/gdb-xml-stub.c
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 15c666f5752..b61d2e915c1 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,6 +4,29 @@
 # types such as hwaddr.
 #
 
+gdbstub_xml_files = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
+      if not gdbstub_xml_files.contains('gdb-xml/' + gdbstub_xml)
+        gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
+      endif
+    endforeach
+  endif
+endforeach
+if gdbstub_xml_files.length() > 0
+  feature_to_c = find_program('../scripts/feature_to_c.py')
+  gdbstub_xml = custom_target('gdbstub-xml.c',
+                              output: 'gdbstub-xml.c',
+                              input: files(gdbstub_xml_files),
+                              command: [feature_to_c, '@INPUT@'],
+                              capture: true)
+else
+  gdbstub_xml = files('gdb-xml-stub.c')
+endif
+common_ss.add(gdbstub_xml)
+
 # We build two versions of gdbstub, one for each mode
 user_ss.add(files(
   'gdbstub.c',
diff --git a/stubs/meson.build b/stubs/meson.build
index fad796a49da..7189ff63ed5 100644
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
2.53.0


