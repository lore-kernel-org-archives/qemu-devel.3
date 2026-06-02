Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D271CD6E64
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURva-0004tm-PK; Tue, 02 Jun 2026 12:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvT-0004ra-GD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvR-0001N0-Gf
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780417507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t5M6S4Movqjkg+/i/MtzJrUIubVGOlbnkRMufktihc=;
 b=heglr0X0emut6PwpGL7hh/pw8+C39whJuZhx/LMC/Jy+j8Pr0PRDX6mWHdc4LFOr4MVlrP
 GWsa8O8QEB31U79ZFzE9TYYMd0DTCMHFPGfrvwlH+649jna6SWA2jnJOFFfdkww+9orsci
 Z5aqyzbgGOePqrnsGD/mooXsREOLlSo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-15n8lkekPpePGU5eDVbhZg-1; Tue,
 02 Jun 2026 12:25:02 -0400
X-MC-Unique: 15n8lkekPpePGU5eDVbhZg-1
X-Mimecast-MFC-AGG-ID: 15n8lkekPpePGU5eDVbhZg_1780417501
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6306C1956096; Tue,  2 Jun 2026 16:25:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EBB318004A3; Tue,  2 Jun 2026 16:25:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] gitlab: remove x64-freebsd-14-build Cirrus job
Date: Tue,  2 Jun 2026 12:24:54 -0400
Message-ID: <20260602162457.828969-2-stefanha@redhat.com>
In-Reply-To: <20260602162457.828969-1-stefanha@redhat.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cirrus has shut down and the x64-freebsd-14-build is failing:
https://gitlab.com/qemu-project/qemu/-/jobs/14656732122

Remove the x64-freebsd-14-build job to get the CI pipeline passing
again. The next commit will be to remove Cirrus integration from the
GitLab YAML and lcitool since it is no longer used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                         |  2 --
 .gitlab-ci.d/cirrus.yml             | 14 --------------
 .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------
 tests/lcitool/refresh               |  5 -----
 4 files changed, 37 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars

diff --git a/MAINTAINERS b/MAINTAINERS
index 7752917d8c..4ff33eb630 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4511,9 +4511,7 @@ W: https://travis-ci.org/qemu/qemu
 FreeBSD Hosted Continuous Integration
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
-F: .gitlab-ci.d/cirrus/freebsd*
 F: tests/vm/freebsd
-W: https://cirrus-ci.com/github/qemu/qemu
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index b71ab090b6..4769d00c67 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -30,17 +30,3 @@
     - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
   variables:
     QEMU_JOB_CIRRUS: 1
-
-x64-freebsd-14-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: freebsd-14
-    CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image_family
-    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
-    CIRRUS_VM_CPUS: 8
-    CIRRUS_VM_RAM: 8G
-    UPDATE_COMMAND: pkg update; pkg upgrade -y
-    INSTALL_COMMAND: pkg install -y
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
-    TEST_TARGETS: check
diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
deleted file mode 100644
index 98fbde6cc6..0000000000
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables freebsd-14 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-CCACHE='/usr/local/bin/ccache'
-CPAN_PKGS=''
-CROSS_PKGS=''
-MAKE='/usr/local/bin/gmake'
-NINJA='/usr/local/bin/ninja'
-PACKAGING_COMMAND='pkg'
-PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-setuptools py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-wheel python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
-PYPI_PKGS=''
-PYTHON='/usr/local/bin/python3'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 96ee861cbf..e903a33f7a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -303,11 +303,6 @@ try:
                         enable_rust=False,
                         trailer="".join(debian_all_test_cross_compilers))
 
-    #
-    # Cirrus packages lists for GitLab
-    #
-    generate_cirrus("freebsd-14")
-
     #
     # GitLab packages lists
     #
-- 
2.54.0


