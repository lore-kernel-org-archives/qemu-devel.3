Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F1C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbK-0002Wc-SK; Wed, 16 Sep 2026 11:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb7-0002Jn-Gr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:58 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb5-0001Vq-4m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:57 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so7762425e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572643; x=1790177443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pg0bQgdSVMUQdOP+pS6xC8ogAtGnUdIXIfDsr16ThzQ=;
 b=dc8t4lnwVHGqYiKNcFnnOWh3Kpl1grPTQ6xiLEzapOgx88g1HFS8/DAUE2gRUfsfA5
 L6IUGq1IQbxJH7QzGltNOSQ3iJytO8n30FkMcYyf+1nxaEkgn10to8SUeoSYiMZFlNBv
 bx0S8EW9JHj0begPodq8/U/jf9/Mgmo9xtABMPz20rU5uu64TlcHyqNHvb/kfOV8dfRs
 4A4BSJa1FZ9vliWlEqn7NKQttEqx115ZCx/8dGYPbu/VcnghAWuOq/g8k+tUkfPHfMFR
 5UNjKvdUja7DWbH5BrSGB/yiv2n6SF/BPK8jTzwarx6zT6hdkNO6PYxcssTUV/RLE26u
 ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572643; x=1790177443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pg0bQgdSVMUQdOP+pS6xC8ogAtGnUdIXIfDsr16ThzQ=;
 b=a2Fqnd6aBwItAnlo3YyvnSK6PxWwSHH68AQ4A0BMGECJP6TKLVjonBGmO8lWP5wCnE
 lp1y7vgq3aR4ccLlFDly9iharHh+n+XoG28Y4yY+TJetzNgS7A1zzTH7zLzP+qayYYwP
 F3khjdAbA6v0SsqkEYb6HuqWk3XpnXhG4dWR/MixRlBnWvEYO8HP/7tXtM486gOZj0ex
 9+1HbGiaZzY1tGYDhGd5Ur+ePXGDIVYxgb8bZ25LwRS8p/KQ34oBSQB67fSMdrk+ZG/7
 oGe5p+SarKFhaw2J9BPVINbSXZDQd/I7GId/hQO9M9ScVO6UXxAYiwGk9N2RiMUL3yk0
 3mPA==
X-Gm-Message-State: AFuF++kaqdcdNw7h//y1BX725lGn6DqCW1wRO2edbOWgHDWQV8a+Kok2
 ZYs++/ZHAGJBV8d/g+9tYsPpernYUPZqcUijiEVxVutjyUebVaEJYms7UYcezG3FOaw=
X-Gm-Gg: AYBFou2S36P46WDSKX7q6RfcCFgZoHs0bcI5/b46QhZpduG8FcFrkS/mgaHrmjF2PJz
 ic8qj/E5ZCvdAI5pnWbfqIf1uvow8vEH5MGq3kSndEPOhYCCB4L4HrsBpw7FLBiRR0+g+1aXwen
 sdv0z58yJBPlKvVS+VbaTixkUUdLwgAwqJbWU9n1n7X8+WaIOs1CPTEVa9HN31LKp9ChSNfq0mo
 55lMhp/KMwajl00LnRJBIgOWa8qKHSmYXmwIiW8YeQ7unWypDwvNZeIdMs67kR0FpMZD++mnstB
 ToVok4ffLpAPx/50AjUYm1j7zDQwX1XP28n1ILYijtbME1Pqjjhy6aC25w4yGQ9CAOl9Om8OSYG
 5k2nYXJLR89OAWWXjEQm1QfdSGHcWEES/wf06M8nETKpvBzESePMaMLng5wcb2ZL11H+sV7kWFo
 RxlJl5D5yHbcyxvhCzqXNuu+nYsaxAvRDvJBzzWrs8cUpLK4NIsAEjTNB71BG4sIbcGiwnvhw=
X-Received: by 2002:a05:600c:c8f:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49eb733c62dmr38210525e9.27.1789572642798; 
 Wed, 16 Sep 2026 08:30:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1b98a6sm41535e9.13.2026.09.16.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8E66619F7;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 14/19] tests/docker: swap --quiet for --verbose
Date: Wed, 16 Sep 2026 16:30:07 +0100
Message-ID: <20260916153013.2134555-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Running the docker build in meson spams the output so default to quiet
and make --verbose the options. If we want to expose verbosity in
meson we can deal with that later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - dropped accidental libvirt-ci inclusion
---
 tests/docker/Makefile.include | 10 +++++-----
 tests/docker/docker.py        | 22 ++++++++++++----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74bf471f171..85825d74dfb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -72,13 +72,13 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
-			$(if $(DOCKER_V),,--quiet) $(if $(NOCACHE),--no-cache) 	\
+			$(if $(DOCKER_V),--verbose) $(if $(NOCACHE),--no-cache) \
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
 			"BUILD","binfmt debian-$* (debootstrapped)"),		\
 		$(call quiet-command,						\
-			$(DOCKER_SCRIPT) check --quiet qemu/debian-$* $< || 	\
+			$(DOCKER_SCRIPT) check qemu/debian-$* $< || 		\
 			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
 			"CHECK", "debian-$* exists"))
 
@@ -103,17 +103,17 @@ debian-toolchain-run = \
 	$(if $(NOCACHE)$(NOFETCH),					\
 		$(call quiet-command,					\
 			$(DOCKER_SCRIPT) build -t qemu/$1 -f $< 	\
-			$(if $(DOCKER_V),,--quiet) 			\
+			$(if $(DOCKER_V),--verbose) 			\
 			$(if $(NOCACHE),--no-cache)			\
 			--registry $(DOCKER_REGISTRY) --extra-files	\
 			$(DOCKER_FILES_DIR)/$1.d/build-toolchain.sh,	\
 			"BUILD", $1),				        \
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),,--quiet) \
+			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),--verbose) \
 				qemu/$1 $(DOCKER_REGISTRY),		\
 			"FETCH", $1)					\
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),,--quiet) \
+			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),--verbose) \
 				qemu/$1 				\
 				$(if $(NOUSER),,--add-current-user) 	\
 			"PREPARE", $1))
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d7eb4cf6811..10cb4cbde11 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -312,8 +312,8 @@ class SubCommand(object):
     name = None  # Subcommand name
 
     def shared_args(self, parser):
-        parser.add_argument("--quiet", action="store_true",
-                            help="Run quietly unless an error occurred")
+        parser.add_argument("--verbose", "-v", action="store_true",
+                            help="Run verbosely (default is quiet)")
 
     def args(self, parser):
         """Setup argument parser"""
@@ -341,7 +341,8 @@ def args(self, parser):
                             -- to avoid confusion about its flags""")
 
     def run(self, args, argv):
-        return Docker(args.command).run(args.cmd, args.keep, quiet=args.quiet,
+        return Docker(args.command).run(args.cmd, args.keep,
+                                        quiet=not args.verbose,
                                         as_user=args.run_as_current_user)
 
 
@@ -390,7 +391,7 @@ def run(self, args, argv):
         # Is there a .pre file to run in the build context?
         docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
         if os.path.exists(docker_pre):
-            stdout = DEVNULL if args.quiet else None
+            stdout = None if args.verbose else DEVNULL
             rc = subprocess.call(os.path.realpath(docker_pre),
                                  cwd=docker_dir, stdout=stdout)
             if rc == 3:
@@ -416,7 +417,7 @@ def run(self, args, argv):
                  for k, v in os.environ.items()
                  if k.lower() in FILTERED_ENV_NAMES]
         dkr.build_image(tag, docker_dir, args.dockerfile,
-                        quiet=args.quiet, user=args.user,
+                        quiet=not args.verbose, user=args.user,
                         argv=argv, registry=args.registry)
 
         rmtree(docker_dir)
@@ -435,9 +436,9 @@ def args(self, parser):
 
     def run(self, args, argv):
         dkr = Docker(args.command)
-        dkr.command(cmd="pull", quiet=args.quiet,
+        dkr.command(cmd="pull", quiet=not args.verbose,
                     argv=["%s/%s" % (args.registry, args.tag)])
-        dkr.command(cmd="tag", quiet=args.quiet,
+        dkr.command(cmd="tag", quiet=not args.verbose,
                     argv=["%s/%s" % (args.registry, args.tag), args.tag])
 
 
@@ -513,7 +514,7 @@ def run(self, args, argv):
 
         # Run the build with our tarball context
         dkr = Docker(args.command)
-        dkr.update_image(args.tag, tmp, quiet=args.quiet)
+        dkr.update_image(args.tag, tmp, quiet=not args.verbose)
 
         return 0
 
@@ -532,7 +533,8 @@ class ImagesCommand(SubCommand):
     name = "images"
 
     def run(self, args, argv):
-        return Docker(args.command).command("images", argv, args.quiet)
+        return Docker(args.command).command("images", argv,
+                                            quiet=not args.verbose)
 
 
 class ProbeCommand(SubCommand):
@@ -574,7 +576,7 @@ def run(self, args, argv):
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
         cmd += [args.image, args.cc]
         cmd += argv
-        return Docker(args.command).run(cmd, False, quiet=args.quiet,
+        return Docker(args.command).run(cmd, False, quiet=not args.verbose,
                                         as_user=True)
 
 
-- 
2.47.3


