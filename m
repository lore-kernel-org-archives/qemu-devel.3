Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63A9C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJQ-0006Dl-Rz; Fri, 04 Sep 2026 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJI-00069M-2x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-0006qu-Td
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso611750f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525978; x=1789130778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5pzU9NQq9i0J3atcrg5nBD4Rsxyi2P0O+j51qexP5Po=;
 b=IFei5jnzY1arbvF2+F8mXw27I/Zz2PP08p3l8F56c9MFBn2ApAy2DaMxPKzV19NLih
 HHhd7aiMFRKt4DeDXbjgpWUMR+z/GloX4wDl4PhOhKyk2ab2jQn/lbratnGpNXoC8WJ4
 W8CoaPy+Dd/KawBiFS7hAgIec46CwNsyDKDmNOM7il2fjjSRnAEASnPXywz3bSz6qw+R
 d7N+97f8LHAO2zG1TfKKJ8mSbOMvK9tSrsKNewsoIxnrB89iRN68qrm+HTXRrEBOWZNT
 +aR1IpKEEyqQ38o4eFp0BwAua0xsOuyiT1UAdu1dlC/z+//SE0HNbmRprfS1CEnsR29r
 UqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525978; x=1789130778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5pzU9NQq9i0J3atcrg5nBD4Rsxyi2P0O+j51qexP5Po=;
 b=DRyQwEAkquaUyEbV4WO46/sVSFTft9qe4KLrW/RTVEqkc8Uw7Gtyzh2UZqU4roeVAN
 HxHj72cED9fq7l/hghqEMklebNXvRdOS1Uc8eSaxgWnnLTDdYHuHk7Vfemz+bsHSwy/M
 vUUs8/W651Ahe+OYFl57zyUAURPjiwx9Edc7x2+NR6ELxPDZ2MlujfzlreXURD2f891B
 K8IXfBFghPBLZ6H2d7CEc0+8F6pGEJiP9+AaBLJ3I0wrfafufR3vLux2G48BBElko4WB
 kZ40MWW9sUrFRYTnQGWPgmNgyc+pzGTQEuvw1/qM6IUnj2qP6J2AE9pLZidn2xOxENKq
 XM6A==
X-Gm-Message-State: AFuF++mbLgNQPCdUIlGb4YWNweUd8wsF7umuLpBwKOZRu0srLuDQKYrd
 lJeJfSuadLfMRAJDPLP9QG+8hbkRSOE+VVblpXm+vfSeOAPJYbAGba0RkR5IRPdUnI4=
X-Gm-Gg: AYBFou1ariiRVn2OpxHx2+lkvLHQjCFjhMd27txMc7wi446OeukTnMsoAFosI/42cQ+
 TaYC84eEgjV6R809MdsvQSlJ9xGaasCzq6xDQ0ljyN7iwauKgVmtVxmKyeS5G4abncO+W7AdmJm
 O0hMYsXWBjiroLAYsbTOv7yFr4228rNshJfJViS3Y7GnTHtc3mitxpqtnx94sgIc3a/VYhVuAk1
 OCRy96+CC05XuO2+xaJ1MxWuDhPfBxN6dJd6fgicequFjtaA+gsD474O7mffFR07ADsdo02IPgo
 V/8MphHfWq9Kkv5LCmpnZnFATciTrZyg8dAmJwyZ4XIItrY1ybrh7tMq99XBDfv8bOxjPTD+Ej2
 c0k+BlMyxwR2/Px4yUKsANjFUwJaXwc25CNpWTUpAJS82MZAGfe9ppWHEeIqjlKoUCjcC5uAbFG
 PeWmxfdJZzMdebHzQmv1uU7s6gfmT5BjUfinkuM7vjiDyVvxejudDIsfeeWqeizHXqjnKHklg=
X-Received: by 2002:a05:6000:4304:b0:482:e22f:a2b2 with SMTP id
 ffacd0b85a97d-485872dbea1mr7388528f8f.20.1788525977664; 
 Fri, 04 Sep 2026 05:46:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm7261771f8f.12.2026.09.04.05.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C50D613D8;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 013/105] tests/tcg/meson.build: test gdb support and introduce
 gdb_arch
Date: Fri,  4 Sep 2026 13:44:27 +0100
Message-ID: <20260904124604.2207440-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-14-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b51750b016..3714fe4dc0d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,11 @@
 env = find_program('env')
 
+gdb_progs = ['gdb-multiarch', 'gdb']
+if config_host.has_key('GDB')
+  gdb_progs = [config_host['GDB'], gdb_progs]
+endif
+gdb = find_program(gdb_progs, required: false)
+
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
 #
@@ -7,6 +13,7 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': cross_compiler,
 #     'folder': 'folder_for_test_src_files',
+#     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -34,6 +41,18 @@ tcg_tests = {}
 # declared using 'test_name'.
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
+gdb_arch_supported = {}
+gdb_version = '0'
+if gdb.found()
+  gdb_version = gdb.version()
+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
+                           gdb,
+                           check: true)
+  foreach arch: gdb_arch.stdout().split()
+    gdb_arch_supported += {arch: true}
+  endforeach
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -47,7 +66,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'qemu', 'tests']
+    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -56,6 +75,7 @@ foreach target, plan: tcg_tests
 
   cc = plan['cc']
   folder = plan['folder']
+  gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
   tests = plan['tests']
 
-- 
2.47.3


