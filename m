Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07C5C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLti-0004ea-99; Thu, 04 Jul 2024 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLtY-0004QJ-DI; Thu, 04 Jul 2024 08:49:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLtW-0006R4-Fc; Thu, 04 Jul 2024 08:49:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56885773A1;
 Thu,  4 Jul 2024 15:48:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D5A69FE786;
 Thu,  4 Jul 2024 15:48:26 +0300 (MSK)
Received: (nullmailer pid 1471786 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 07/17] Update lcitool and fedora to 37
Date: Thu,  4 Jul 2024 15:48:14 +0300
Message-Id: <20240704124826.1471715-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fedora 35 is EOL.

Update to upstream lcitool, that dropped f35 and added f37.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230110132700.833690-7-marcandre.lureau@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230124180127.1881110-11-alex.bennee@linaro.org>
(cherry picked from commit 0054dc8bde408d61257bacdb489bbacc4ca5cde5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index 75383ba185..cc5d1ac4be 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw32 fedora-35 qemu
+#  $ lcitool dockerfile --layers all --cross mingw32 fedora-37 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:35
+FROM registry.fedoraproject.org/fedora:37
 
 RUN dnf install -y nosync && \
     echo -e '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 98c03dc13b..cabbf4edfc 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw64 fedora-35 qemu
+#  $ lcitool dockerfile --layers all --cross mingw64 fedora-37 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:35
+FROM registry.fedoraproject.org/fedora:37
 
 RUN dnf install -y nosync && \
     echo -e '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index d200c7fc10..f44b005000 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-35 qemu
+#  $ lcitool dockerfile --layers all fedora-37 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:35
+FROM registry.fedoraproject.org/fedora:37
 
 RUN dnf install -y nosync && \
     echo -e '#!/bin/sh\n\
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index e3eb28cf2e..319a534c22 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit e3eb28cf2e17fbcf7fe7e19505ee432b8ec5bbb5
+Subproject commit 319a534c220f53fc8670254cac25d6f662c82112
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fa966e4009..a5ea0efc3b 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -111,7 +111,7 @@ try:
     generate_dockerfile("centos8", "centos-stream-8")
     generate_dockerfile("debian-amd64", "debian-11",
                         trailer="".join(debian11_extras))
-    generate_dockerfile("fedora", "fedora-35")
+    generate_dockerfile("fedora", "fedora-37")
     generate_dockerfile("opensuse-leap", "opensuse-leap-153")
     generate_dockerfile("ubuntu2004", "ubuntu-2004",
                         trailer="".join(ubuntu2004_tsanhack))
@@ -161,12 +161,12 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win32-cross", "fedora-35",
+    generate_dockerfile("fedora-win32-cross", "fedora-37",
                         cross="mingw32",
                         trailer=cross_build("i686-w64-mingw32-",
                                             "i386-softmmu"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-35",
+    generate_dockerfile("fedora-win64-cross", "fedora-37",
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
                                             "x86_64-softmmu"))
-- 
2.39.2


