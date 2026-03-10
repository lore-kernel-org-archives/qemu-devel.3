Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B3FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06PV-0005EM-Rj; Tue, 10 Mar 2026 19:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06PU-00056R-Fq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06PS-0000IP-Ld
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so45734205e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184961; x=1773789761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sfnpXAGB2kx+qinEz/cRMAujTXvnPWzujmbrG3qqBo=;
 b=YSezm5ATroaTXnOjRWjT+FHyw4EIto1L5ZA/jD/vV4dv+4T6sOXNOWnOmukepOQWFO
 ANxl20ESDKs5/SgxO4FZuujuXPYW1XAAAqGtu8oE4/oM+5vIR712Gydg3ww1hfaHXPwr
 at/5S6UiQ5sVAZMWObrm/Jye8KlPMrdVP3U0ebDIg3OE9UU0trOQIwtfXwxqgEeV5GoC
 0zMGyUvqLa46BADbMCtFKqGUQZiP4GjCv0+WSUnIdfZrSXypAQyI3RmNbWXFB/SwEiK0
 YF26uQ86K3OdhmLLepUzxzSbmbpW84Am4t1sVc0QjjPGp8hWYZFOmTUfL6LRzbAYF15q
 PN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184961; x=1773789761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5sfnpXAGB2kx+qinEz/cRMAujTXvnPWzujmbrG3qqBo=;
 b=QUHupWAR7rPVIZWOCRuZM955zkTy6wGhfmNlxU9DXq02dQBM+SWfOL+8LOlsmfbh9N
 Juf6xnQ21SLuBs9EikaHNV7QLenIwlJTN2jmY4eekpjXnlUCtohw9aOMFbd8VJVvvDdy
 2pQ60rokWVIzRyXgFjk8yyGvscKOsN0kwqQKtXAnkkdyKP54wJkzapT/yndr6tGAp+cL
 SfUWO0JjA4hGNQ9dSjQDPuAoTIzT3AUeCurtrKnBGdJFLv4mYimSWsKpF1/tveOukR2n
 J1q2g3+tyZmWd/jYAjSNdaBQxo9gxfzGYEPD1mBZqszhmstk9kbrDuJ3zdwg2xiYaUsy
 uYRg==
X-Gm-Message-State: AOJu0YxfvUVAYbGgQwUgX4NQBCbybxkbvDnDeFLZpQOBhe8zWps1B8N0
 eocr3eQdtjBVTh1q4hwDhxPPFske18A7pqXvTLk8FLBfHZu6GVoOGf7OOuP7IuipQ0Obe8CQVcD
 B0E7icVo=
X-Gm-Gg: ATEYQzzFriRFHboMc8K9DyG7Jh1kb1OrxOvNT6wH7W9txOyEFS1wSm7d11WLTJPlriU
 f7rl+kAuXqoaRlJHlQ4j9sH2lSt2o17wiq+ef0mfxFEI4tWLXq2UERI0oj5Iw3deCCpVxWGPirQ
 7YDF0VtKDL3kDXEJrwZR4XW4wn60zjH8bLwi/o0GQj8gyFBHDOaoZ1KrFZn62Q+9XwytRu9oMV2
 Lvzpau/TqOFU0IZ0BimcJkj30/SIShO6sh4FrT1/hbPrjkDsFUhAPeXfs7LhLCnNyppIh5ieIXw
 23AVq/rVXsFF3SZiVgFaxK49lx/vh3Gu1KB5JvYeAbZSU26HFypItZ3tvAe9Oa/rMnVZK/8oeAd
 7RfuuT/jawLlfzoogs2Y3hYjN38AAa4KZ74nzdryzIxpZzkkXYhp4b87B9NGdgIRiCNePXNItXv
 u/tek6jSakSrJBMZfU6/axPzjvBm76GwQzLm5e4aQVk+iuShHr6CEOv3Sge7ncrwbZ14at+iGd
X-Received: by 2002:a05:600c:46d2:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-4854b10c835mr8313695e9.23.1773184960690; 
 Tue, 10 Mar 2026 16:22:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0cc00asm5758435e9.7.2026.03.10.16.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:22:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 16/16] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Wed, 11 Mar 2026 00:20:44 +0100
Message-ID: <20260310232045.58440-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


