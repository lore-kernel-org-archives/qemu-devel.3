Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A5C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNFh-0000xw-9V; Mon, 24 Aug 2026 01:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFJ-0000Z1-5S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFH-0006kC-JK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787549358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbgFy+i/MBg6WIUZ6vfnbgcVFnDOzreG7LA3LljSXG4=;
 b=RxCWsZmOUcxu72Ugf5ekucWhI8Qt90IUYWVRndce7YQEMYDcjf9lR9WihT5oMmZA/lJXv+
 GBYNThPkglYusNDUcwxeQ8Yd0CoD6P92SX54u5pefyfAwwAGUqBTSz5VEMUYuPdNqZE3Sq
 XEIpb5GiJcdu1U5iqWG4tHWH2p133KU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-1K0u2OdHMZylrx2CSoy4DA-1; Mon,
 24 Aug 2026 01:29:13 -0400
X-MC-Unique: 1K0u2OdHMZylrx2CSoy4DA-1
X-Mimecast-MFC-AGG-ID: 1K0u2OdHMZylrx2CSoy4DA_1787549352
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5721944DEA; Mon, 24 Aug 2026 05:29:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 222581800348; Mon, 24 Aug 2026 05:29:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 02/12] tests: add Python3.12 to centos9.docker
Date: Mon, 24 Aug 2026 01:28:48 -0400
Message-ID: <20260824052859.880475-3-jsnow@redhat.com>
In-Reply-To: <20260824052859.880475-1-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While we recently upgraded to Python 3.11 for the CentOS 9 container,
upgrade it even further to Python 3.12.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/dockerfiles/centos9.docker   | 12 ++++++------
 tests/lcitool/mappings.yml                | 12 ++++++------
 tests/lcitool/targets/centos-stream-9.yml |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 6f5c400c2db..8bfce395f9d 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y && \
                 pkgconfig \
                 pulseaudio-libs-devel \
                 python3-tomli \
-                python3.11 \
-                python3.11-pip \
-                python3.11-setuptools \
-                python3.11-wheel \
+                python3.12 \
+                python3.12-pip \
+                python3.12-setuptools \
+                python3.12-wheel \
                 rdma-core-devel \
                 rust \
                 rust-std-static \
@@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.11 install \
+RUN /usr/bin/pip3.12 install \
                      numpy \
                      opencv-python \
                      sphinx \
@@ -139,7 +139,7 @@ ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
 ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3.11"
+ENV PYTHON="/usr/bin/python3.12"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 2b317e0a61c..5c56e4aca1b 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -4,16 +4,16 @@ mappings:
     Ubuntu2204:
 
   python3:
-    CentOSStream9: python3.11
+    CentOSStream9: python3.12
 
   python3-devel:
-    CentOSStream9: python3.11-devel
+    CentOSStream9: python3.21-devel
 
   python3-pip:
-    CentOSStream9: python3.11-pip
+    CentOSStream9: python3.12-pip
 
   python3-setuptools:
-    CentOSStream9: python3.11-setuptools
+    CentOSStream9: python3.12-setuptools
 
   python3-sphinx:
     CentOSStream9:
@@ -28,10 +28,10 @@ mappings:
     CentOSStream9:
 
   python3-venv:
-    CentOSStream9: python3.11
+    CentOSStream9: python3.12
 
   python3-wheel:
-    CentOSStream9: python3.11-wheel
+    CentOSStream9: python3.12-wheel
 
   meson:
     # Use Meson from PyPI wherever Rust is enabled
diff --git a/tests/lcitool/targets/centos-stream-9.yml b/tests/lcitool/targets/centos-stream-9.yml
index c2d87f6cb4d..0d6801fd9a3 100644
--- a/tests/lcitool/targets/centos-stream-9.yml
+++ b/tests/lcitool/targets/centos-stream-9.yml
@@ -1,3 +1,3 @@
 paths:
-  pip3: /usr/bin/pip3.11
-  python: /usr/bin/python3.11
+  pip3: /usr/bin/pip3.12
+  python: /usr/bin/python3.12
-- 
2.55.0


