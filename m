Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5BC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOy-0007xG-9x; Wed, 16 Sep 2026 04:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOw-0007ru-4X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:58 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOt-00052U-P4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:57 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso4947615e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548834; x=1790153634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pg0bQgdSVMUQdOP+pS6xC8ogAtGnUdIXIfDsr16ThzQ=;
 b=TYtrWKWeV1huDPG3Mm+Wx+DarJ6EggTd41rFfYV1xa1VFUtPvpTryIaV8rHqLN6g6g
 7oug2ySWwe+vUcbUcDtWPGfbRCqQK0n3jvBZKF2DU22rmBxB6+iNTXLOOamnUaVp90JB
 ZNA7odenK4qLzNvqQlKMbPfRC5R5YuXo4u+aoNthmKoEr1I1AI0HKCbpEy/JZQ7uRFUR
 Q2Bzc86rXWPxG9fDugsciEXPBqm+CdOYXSB+QzpriqQuTbtYyCScBmozESYvtJDNOqqk
 64AselvzznZb6NGjskRdAPFPWWiS1NLE+T5YCJvV50I3nMRyioO+grcEKXHGcbuZHBAD
 kCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548834; x=1790153634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pg0bQgdSVMUQdOP+pS6xC8ogAtGnUdIXIfDsr16ThzQ=;
 b=GJJDexAQ7D16fvtCFpf0yzRUBeYPlmasnv7MgsYJiW56x+eFrqAMPelo4J675+Tkpg
 YQpAE841vCGJ4bwPKbqJkftX0QXON307HeHz4iyjoi83lvihjJRo1n/mCegkeF7iXcJ6
 vEzVgrd+O30SM2k9pStrVNIJnV1ftQGNOh2T0rYzJUgOQ0OjXX+Jmjra5TyzDV8AwaRM
 6GFaE52F7syiPqyyaMSHX7yhdDoz33A+hKUEGnLiPcmRaXf9gdGqLyTB8xIs9ComQrmt
 R/3U8qPp2F5KnKcfgQagY/pwU0zQFxgTtjoa2VUYbjZiCj98LRHAobJ3hEGjxh3my/Cm
 uJ1A==
X-Gm-Message-State: AFuF++l/Lu03abm7apvRVvwYU5iUIvGhXblLUuJhMopvAf5KUFG4PqQQ
 HRfjxvQzM9hQGCr0nJpnI7BEmX6qgUL4qFlidVrAe+Dx4VhdaBMCxlGnkk7tFQN3H1o=
X-Gm-Gg: AYBFou2O578vox1EwCPhLlCmJ4pVeHA4+wf6VhGh+ooZgBhFPCKb7rcFJMqOQhWIe+p
 xNrHhH+/Ssj2X3Smfsw2nAgxVB27ER39CWW4TF/naYQPkcoNNBf21pMfbfmXB9GE2aGt7fhRdWU
 RW86tt0ijJrFxEIvWcRRu8f3EJv3B9HdGWxXzwvF65wSdBoBRiE6fcklsZeNXRAg6Lzi1vrg4Xr
 pimPbA96pb+xKexQ5+aurx+X7W80F4aamFtbkZmqXjnyNmQaj6SGK0mS01jG/EFPxcGSLhScGsR
 MdI/iZzbrUcjcLzs0y8y5glcVubYJn0P1vD2Z+Why/8074x8idcucnVrl/hFPAPWWI3L1A6cgMp
 /0LIydMV2fYQBnyoL8t39KiET3y/oqcxiVIuvQhEKKoLhgQD8TircJJh7ig5hwAujYwSaobB7Ag
 3+CIXjDs7uW9MOH7xV/gZrtUmXdKPcogSYL61nDl2DcUoslcTW4i79+WxCNFI/SXKnWcyjoi8=
X-Received: by 2002:a05:600c:3547:b0:49c:fa20:cbfb with SMTP id
 5b1f17b1804b1-49eb73253demr16754265e9.18.1789548834316; 
 Wed, 16 Sep 2026 01:53:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83fca34asm53701275e9.1.2026.09.16.01.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D337761926;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 13/17] tests/docker: swap --quiet for --verbose
Date: Wed, 16 Sep 2026 09:53:36 +0100
Message-ID: <20260916085341.1692742-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


