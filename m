Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F89CC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x75Zo-0005Yf-BR; Thu, 17 Sep 2026 02:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75Zk-0005Y9-Nt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75Zh-0001zk-8X
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789626382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5DibIkv1MFaLiHi6iX4a/PsrPdGaS5xbm6Y/aFfA+lI=;
 b=Vi18f/DNCj8yH8vtleyCPJan7MvgMo9SuB1xraspY3qqKYTlzPOiJe8GgE00WG/bUOtAcs
 2kvHzF6UQ093SgITn2JvUfgIQAfXCNZMoEtISIH1x2CHDPWPfY23kwprKVm3Rd6CUypF+W
 OeQZha1NTVNUgQKGsTMRIqdK0Vw7FpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-e4JNAtFbNrCFwpD5Yvtf0g-1; Thu,
 17 Sep 2026 02:26:20 -0400
X-MC-Unique: e4JNAtFbNrCFwpD5Yvtf0g-1
X-Mimecast-MFC-AGG-ID: e4JNAtFbNrCFwpD5Yvtf0g_1789626379
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBC961800C3C; Thu, 17 Sep 2026 06:26:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4922A180049F; Thu, 17 Sep 2026 06:26:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander von Gluck IV <kallisti5@unixzen.com>,
 John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org
Subject: [PATCH] tests/vm: Drop the broken Haiku VM
Date: Thu, 17 Sep 2026 08:26:15 +0200
Message-ID: <20260917062615.783485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Haiku VM has bitrotted again: At least since Haiku r1beta6 has
been released, the image does not work anymore. I tried to update
the script to use the r1beta6 repositories instead, but after the
update, the Haiku kernel only crashes during reboot.

Given the fact that hardly anybody seems to use this image and
that it is more often broken than working, let's stop wasting our
time here and simply remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 If somebody wants to see Haiku being tested more frequently again,
 it might be better to look into alternatives like Github actions.

 tests/vm/haiku.x86_64 | 124 ------------------------------------------
 1 file changed, 124 deletions(-)
 delete mode 100755 tests/vm/haiku.x86_64

diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
deleted file mode 100755
index 3ea48dc38a1..00000000000
--- a/tests/vm/haiku.x86_64
+++ /dev/null
@@ -1,124 +0,0 @@
-#!/usr/bin/env python3
-#
-# Haiku VM image
-#
-# Copyright 2020-2022 Haiku, Inc.
-#
-# Authors:
-#  Alexander von Gluck IV <kallisti5@unixzen.com>
-#
-# This code is licensed under the GPL version 2 or later.  See
-# the COPYING file in the top-level directory.
-#
-
-import os
-import re
-import sys
-import time
-import socket
-import subprocess
-import basevm
-
-VAGRANT_KEY_FILE = os.path.join(os.path.dirname(__file__),
-    "..", "keys", "vagrant")
-
-VAGRANT_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
-    "..", "keys", "vagrant.pub")
-
-HAIKU_CONFIG = {
-    'cpu'             : "max",
-    'machine'         : 'pc',
-    'guest_user'      : "vagrant",
-    'guest_pass'      : "",
-    'root_user'       : "vagrant",
-    'root_pass'       : "",
-    'ssh_key_file'    : VAGRANT_KEY_FILE,
-    'ssh_pub_key_file': VAGRANT_PUB_KEY_FILE,
-    'memory'          : "4G",
-    'extra_args'      : [],
-    'qemu_args'       : "-device VGA",
-    'dns'             : "",
-    'ssh_port'        : 0,
-    'install_cmds'    : "",
-    'boot_dev_type'   : "block",
-    'ssh_timeout'     : 1,
-}
-
-class HaikuVM(basevm.BaseVM):
-    name = "haiku"
-    arch = "x86_64"
-
-    link = "https://app.vagrantup.com/haiku-os/boxes/r1beta4-x86_64/versions/20230114/providers/libvirt.box"
-    csum = "6e72a2a470e03dbc3c5e808664e057bb4022b390dca88e4c7da6188f26f6a3c9"
-
-    poweroff = "shutdown"
-
-    requirements = [
-        "devel:libbz2",
-        "devel:libcapstone",
-        "devel:libcurl",
-        "devel:libfdt",
-        "devel:libgcrypt",
-        "devel:libgl",
-        "devel:libglib_2.0",
-        "devel:libgnutls",
-        "devel:libgpg_error",
-        "devel:libintl",
-        "devel:libjpeg",
-        "devel:liblzo2",
-        "devel:libncursesw",
-        "devel:libnettle",
-        "devel:libpixman_1",
-        "devel:libpng16",
-        "devel:libsdl2_2.0",
-        "devel:libslirp",
-        "devel:libsnappy",
-        "devel:libssh2",
-        "devel:libtasn1",
-        "devel:libusb_1.0",
-        "devel:libz",
-        "ninja",
-        "pip",
-        "tomli_python310",
-        "wheel_python310",
-        "setuptools_python310",
-    ]
-
-    BUILD_SCRIPT = """
-        set -e;
-        rm -rf /tmp/qemu-test.*
-        cd $(mktemp -d /tmp/qemu-test.XXXXXX);
-        mkdir src build; cd src;
-        tar -xf /dev/disk/virtual/virtio_block/1/raw;
-        mkdir -p /usr/bin
-        ln -s /boot/system/bin/env /usr/bin/env
-        cd ../build
-        ../src/configure {configure_opts};
-        make --output-sync -j{jobs} {target} {verbose};
-    """
-
-    def build_image(self, img):
-        self.print_step("Downloading disk image")
-        tarball = self._download_with_cache(self.link, sha256sum=self.csum)
-
-        self.print_step("Extracting disk image")
-
-        subprocess.check_call(["tar", "xzf", tarball, "box.img", "-O"],
-                              stdout=open(img, 'wb'))
-
-        self.print_step("Preparing disk image")
-        self.boot(img)
-
-        # Wait for ssh to be available.
-        self.wait_ssh(wait_root=True, cmd="exit 0")
-
-        # Install packages
-        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haiku/r1beta5/$(getarch)/current")
-        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haikuports/r1beta5/$(getarch)/current")
-        self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
-        self.graceful_shutdown()
-
-        self.print_step("All done")
-
-if __name__ == "__main__":
-    sys.exit(basevm.main(HaikuVM, config=HAIKU_CONFIG))
-- 
2.55.0


