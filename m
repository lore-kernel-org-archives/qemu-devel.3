Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F0C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWl-0006Lq-1Z; Fri, 18 Sep 2026 10:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWE-0005nR-E2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:55 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWC-0007rB-Kv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:50 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso7772245e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741487; x=1790346287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tcotub2dz4LVURgEVs/Az7nuXWuCLmW3Um4pWzjy0uM=;
 b=ap+ws+11h4q8B4lLaxLZvV8D/87BhbDdQy03/GKLoLxPSSlzsxTK55Ma6PSmF1oMT4
 DZkAHrcUUBwnkG79Iqf2U6uhxg/hHhRm6bh+Rmpydv8xZtr3EAKS5hswVvDXNc80WwUz
 kHzkpCl23exRInGKKI+HWP1/ut0XjBkBNvWKuiJlSHLM4ulqoP5ruF2/sU0gu8xKZ4Uv
 L5AGciBo09vYbZF1YaEKquhvDgKP6SFgtSUBge0YUVZMO5APy0i1YuxaSsYFac6OxaxP
 Bfl1Pu5zq+Q8xMzsWFoFBRVCPLcqXN9enVKO/ng6DKjDz3zjcKzKRDcoK1fvEZxENFb0
 bKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741487; x=1790346287;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tcotub2dz4LVURgEVs/Az7nuXWuCLmW3Um4pWzjy0uM=;
 b=CSVDXZs4oGmTyJ0YP3KIeLfrjTa/RaTuUb3rWlFHNGFfQcoET5i1FVdhN+pZyGjwHE
 uFqPJCbQY6Uxme+XEGu0c/j/dvD6yBSJlaj+tX8/wcC/VskcyrT29iUnWKO3366MU/BE
 aFqAJ24CtlJ9rBut8w7O7pCgeeOtQ0GjNOxFBxxD6a2xIAZdhSKWmrdeHppL3V2KxOkT
 3Bdc0igW2oF3a9R5An/PFB2M/q1QT7FbuttZtCdT7/PgwwfrmOELE8AeJ4kc48lciGY2
 xa1L+tnfLazeATDA3S6STYswuGPlC5nr9Ke1P/OFB6szu1NzKGQX4DcGAUhVbYEgCyBi
 Xuyw==
X-Gm-Message-State: AFuF++kyFQWVwNQtao9S7HQf9ZW5aUtO9l39XybJBePp8arCvNhoLjxn
 CupK1eE3xjxEMyeGIXciAOPZebbnbmaJP96VnEvxuyY3D+1MU996EhhRawOSOBW3oQI=
X-Gm-Gg: AYBFou09FZCFK2eZFv6QbXmNtl7F/Eyug3idwEu/GFVkr/fVMBahOHf/0qeIdOs9YkQ
 NsMwByV+qxgzVn73277cFq3nuIJsYaIes9PLOZU105daLqV+V2nGL3HeoK4sWJrwFC8zbwv/v3c
 uY3VqEdBCsn6DLR1nHbFU966J37yPT71gkHb2iRM+LDgAXwWCC3dHa+bYwuiCYb9r2Wk002/YBB
 2y3OBmNR7Tajkhz7sWohBihUQHToAI4zr8jrnj23qV+hkobw9uEeYVgv9akHBh1Kk2gFD4Mh2X0
 1umTt7lWbXdfPwysisYVbfJySMfQWe99qeArdIHN7eDL4VEwOEeNlXAroYPiKsJPwWWhcoxeYHM
 7pGxTwWjdSfyZK0MUIlBEEHgRO21I9pT8J76uVjetvpCr6gB8nTVqPaQhUzsFud2a7xT+EclWLk
 TR/DUvhgT19WKX0MOrj7Cu2lY7lfeGbDSJS4RBUgUE2lRiaB2Lqg2MuqxOIVT2Ze/HtIThVKw=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49fc574a9bcmr30207485e9.25.1789741487268; 
 Fri, 18 Sep 2026 07:24:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cfd1dasm60821765e9.9.2026.09.18.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A81345FC4B;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/17] tests/docker: add container registry to configure and use
Date: Fri, 18 Sep 2026 15:24:21 +0100
Message-ID: <20260918142429.336497-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Previously we had the default baked into Makefile.include but as the
meson container logic will also benefit from it we update the configure
machinery.

For now we allow direct make invocations to override but for the
normal case it is in one place now.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260917165602.3405537-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 667fc7ca19b..af14a9c23ef 100755
--- a/configure
+++ b/configure
@@ -172,6 +172,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
+container_registry="registry.gitlab.com/qemu-project/qemu"
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -732,6 +733,9 @@ for opt do
   --container-command=*) container_command="$optarg"
                          meson_option_add -Dcontainer_command="$optarg"
   ;;
+  --container-registry=*) container_registry="$optarg"
+                          meson_option_add -Dcontainer_registry="$optarg"
+  ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
   --gdb=*) meson_option_add -Dgdb="$optarg"
@@ -1728,6 +1732,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
+if test -n "$container_registry"; then
+  echo "DOCKER_DEFAULT_REGISTRY=$container_registry" >> $config_host_mak
+fi
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
diff --git a/meson_options.txt b/meson_options.txt
index e3570a418aa..6c2de6296f7 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -393,6 +393,9 @@ option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
        description: 'command to build/run containers')
+option('container_registry', type: 'string',
+       value: 'registry.gitlab.com/qemu-project/qemu',
+       description: 'container registry to cache from')
 
 option('tcg_tests_cross_cc_aarch64', type: 'string',
        description: 'cc for aarch64 tcg tests')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 4ad8c1c5d35..08c9fbb62cd 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -12,6 +12,9 @@ meson_options_help() {
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
   printf "%s\n" '  --container-command=VALUE'
   printf "%s\n" '                           command to build/run containers'
+  printf "%s\n" '  --container-registry=VALUE'
+  printf "%s\n" '                           container registry to cache from'
+  printf "%s\n" '                           [registry.gitlab.com/qemu-project/qemu]'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-containers     use containers to cross compile tcg tests'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
@@ -286,6 +289,7 @@ _meson_option_parse() {
     --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
     --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
     --container-command=*) quote_sh "-Dcontainer_command=$2" ;;
+    --container-registry=*) quote_sh "-Dcontainer_registry=$2" ;;
     --enable-containers) printf "%s" -Dcontainers=true ;;
     --disable-containers) printf "%s" -Dcontainers=false ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0adddb6a5c6..74bf471f171 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -11,9 +11,7 @@ USER = $(if $(NOUSER),,$(shell id -un))
 UID = $(if $(NOUSER),,$(shell id -u))
 
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-ifeq ($(HOST_ARCH),x86_64)
-DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
-endif
+DOCKER_DEFAULT_REGISTRY ?= registry.gitlab.com/qemu-project/qemu
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
 CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5819fdf0bf3..482de73ac72 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -101,6 +101,9 @@ if get_option('containers')
   endif
 endif
 tcg_tests_summary += {'container command': container_command}
+if get_option('container_registry') != ''
+  tcg_tests_summary += {'container registry': get_option('container_registry')}
+endif
 
 # plugins come first, as we need to build the list
 test_plugins = {}
@@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
     if cc_dockerfile not in image_targets and has_docker
       cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
              '--add-current-user']
+      if get_option('container_registry') != ''
+        cmd += ['--registry', get_option('container_registry')]
+      endif
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
-- 
2.47.3


