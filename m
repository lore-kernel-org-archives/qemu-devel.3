Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0273DFD7F92
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvKI-000486-RP; Fri, 27 Feb 2026 05:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvK5-00044B-Ml
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvK1-0001zk-OT
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48372efa020so15253125e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772189025; x=1772793825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gS4nNCV4Z3Mkqwxzbo9UEetgSt1PI17fzLg36sz6RZo=;
 b=Y8V0eSOAHbRyUHTGIPgZrTjT2rgpwrxqRnB77MdhvM7NlolUMKlkI9h+0Dsh/iBRzj
 izo9xLnxmnCEgyd0XAXdjD3CnGmguVDlQs6UnAHnB2ZzxyWNuv17F9L8KyrLjq17VRmZ
 Oj7+NiA7psxN5CGyI8HCksjPYNqBLL6kZWTzFU12IpgetKSEfKC7+uKYV4h8FCulwdIn
 N7BzFlCClXSJBv6Ut0rtK2HrP5xVTcEsGpcctP84rWTbbYHTU+oTz+K6tYEIc4WsmNSj
 Tri38DUa4nNjgce+P6NMg5wJNcfEGBh5pJxBMfL0uvQnsqm5nNTclwGQg4OD2Z/GMIP0
 j/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772189025; x=1772793825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gS4nNCV4Z3Mkqwxzbo9UEetgSt1PI17fzLg36sz6RZo=;
 b=b9F1Iho1g/R3oFmX3a4MyvEifYSBtsW8QENffUgqG1/fRZkOO+H9M1LUjV+jgr4oph
 f8esH+Hyo2lThCcZO6YBt1tFWvDvCyHgUG2V6X8ZAZ4/73SVAxtu9fnIGf0LzIjOF0Vq
 VKj4cVVlffV4uOn8y1nB7qe+Qp9fG2TOJx/xCUx6JR3NY6vrJuQxuRFDHkTo5avyU3Jn
 EduGJMMlmPpH47qfYuRH9sxkH5tYmN4MSrX3lARSLDprfMdN11YWNvCFEjhFcGJEvcH6
 2NRCX1dakmU17oIK40I7EQtQfh8i2TsA1lul63d0de/C03o1PoDz+ktZjHHbsK6DBhzA
 i7zg==
X-Gm-Message-State: AOJu0YzpbPK03alzmzzJUeLYJ4KkUxWsQJyc5SwFzSDEMiXpGbWkaQAq
 SyCyisHEl4ESBhvsKk5B618kOmKR8IjrzuohEyMBRKiGGR7xaI/7UYA5QQUwrBNwLrB/bOlxmVU
 IsxF6euo=
X-Gm-Gg: ATEYQzwahd+ZWn+M03cYzGDrrzt8yhu80kO6YbdpR8jgEGPbOi+64SIgYZ8h15SiPTK
 BQsVCwsyUazNK4Z05+juBzIPlyJmpGVbxranlSFDO4+C/3fJDS7dFFNTEP0OafrHetui+7yshX6
 J+tvojXaE1ukdKmIRT01PFhFWUZWEp98YqNLyZ5Mxj6k/vBH/yvSenSfrjG7sS2i372eQQ7gbpf
 VxbBTMXWSwQ8dI3KtzelH3DSENf06E3X/2KUKnjVvGOnr+8sDmb+RTAC/9Deqaa5sGV0DP27dCT
 GrtMg8pkPgZCkv86I8P2XZAx7hsTroLlPSVxCYIYaIAj3bgKS2BAYPxiSLXwVif3ArMtGocE8zD
 N4TkKp9ujRU9bjyBTzbbonOXt2yFpifwezlXUrwm7XebAQxTfruO85XwLVROyy2DsEfnirpd0FH
 753v0WSAHsPmlkt4vINC8jAXU9vMO9jSkIXViAg2nC257pGDJMFnctWLnLDBNvAkl6WBZhEtFA
X-Received: by 2002:a05:600c:621b:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-483c9bb1e1fmr33038565e9.3.1772189025422; 
 Fri, 27 Feb 2026 02:43:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bffc17dasm104554355e9.2.2026.02.27.02.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:43:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 4/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Fri, 27 Feb 2026 11:43:14 +0100
Message-ID: <20260227104314.81038-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227104314.81038-1-philmd@linaro.org>
References: <20260227104314.81038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
with a single gdb_static_features[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                               | 14 --------------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 21 +++++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 21 insertions(+), 16 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

diff --git a/meson.build b/meson.build
index 56a746fed00..875a0bb1999 100644
--- a/meson.build
+++ b/meson.build
@@ -4221,7 +4221,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4301,19 +4300,6 @@ foreach target : target_dirs
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
index 15c666f5752..a25a5ae9fbf 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,6 +4,27 @@
 # types such as hwaddr.
 #
 
+gdbstub_xml_files = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
+      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
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


