Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EF8CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJRs-0005PG-Gd; Mon, 12 Oct 2026 13:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRP-0005DV-Qh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:02 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRH-00075c-Uh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:03:56 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5bccc96684dso319784e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824628; x=1792429428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oi8B9wLidZFsxFcu1TlHnandfveqEHU3fKwKxId/dS0=;
 b=JqwfHmvbVQOKzKTzd5ciEuarVhX6IBA0NKsxNBm+DQJwxeuWOXKUBCus2ZVGjf8roO
 fJLYv5yAbU9OyyGNJhnIvW7rj0fY11PoWjK02Pq9rxDW45neJNesKn5HYr0unY+VX05e
 y0lNg/sGSjvfatIk7Um4WtVuBpzR7bcehi9poTL8SP8CbkhBmzrfu39CN84nN/A0vHnt
 qR2kN0AX58matkuPPZCyPLchu+v6oeKMqVzsPAEebqAX6Ij4YVZ1UmcvP4Pk5oB0onsI
 Ig0888E0KO+kvhEqQC3IXCMKrE9nawMMWM8F+WXOo7RIlUxKYly/Hon3VJieiIjtBEZH
 J2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824628; x=1792429428;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oi8B9wLidZFsxFcu1TlHnandfveqEHU3fKwKxId/dS0=;
 b=yeOX8kp0yifrlc2nPLDZ3FiUBhtMp639syjAgMP8HIcx25TmnBvQpskC1MDibwh/6h
 OnYL2xikzQVa3XEfAv/79ffANvDuQrwqdVP/610SmSqVPsAgZBVhjtAxMAL5oJNnqgyw
 sJDK6DyeeBxVtBOdrQra2QR3RVMVQGe474DaSnIf34vNvFrb5yLSk9X4RqrT8XPg9jqy
 CzSOY073jfZzcetCeY+eoQ+ffHLi4E1+UFw5PL6hZ7btbrFKGYRMxPBDIvNLSAPJZta7
 9Qx49TczDvLIQmGnECjf/6kopHALfUoVwPVnp7u9EYTE6pIqrpOD8QcXWI+UqUf6conw
 RfCQ==
X-Gm-Message-State: AFq9FYJiuERilw6cIxGQzvvALX/GYX/4xd62kFWBH4ZNMoFknB6Fa+Kk
 JavA1UtiUn2OsQkAY0BeJZ5eYU9MzhzaNj0h6teFQMBwUH4Y6+/qw8WFNAwk7JCYlA0=
X-Gm-Gg: AYBFou0ZV6KYVoxsl0v091TgWB9JAFPSBLe4uU65OD2HFHiz8vaUpq3YO5rcsPN62t4
 uxSKQcgmbV6dq452vavsHFunkvzjmAP2aKNBsfBW+XZKMuHJ6EsoBW1VwGa1/Pw23VdUdQNQcwQ
 hI450I2buYJ6djYeXwgtyvBSzv+GW4DOzBhOfBCcPFa/Ueqh6hgj/RwB45U1DrSLKcd9mQqkmpc
 0v4U92tR+TbisY4J3MH4qCOmqB8Lqdtg6iLXAwFS2hKVJxF+wOyrAU8O5OfDPWG/LxQNx7fL/DW
 hjAoLieiGpieXu1X4RFMJJZH2fFBBiXFD031uCVB/SaJunCcOAW5T8otcdJXJLMhBnyVyiIQmXE
 5Fej8MgLYuPUIkvL4oa0VOx5ppoLhSWaBbhr9R8sUljBNoK7V38AbCsyplK54uH+LV+06jWTX0Y
 C2JYeOtjrAMdRbvvoSqeCc70jAH5cDx5H7BRgL8Dsr6Bqn8WGqpAi5RSwIBgw58jYweMIMCw==
X-Received: by 2002:a05:6512:6885:20b0:5bc:e13b:3922 with SMTP id
 2adb3069b0e04-5bce13b3d4dmr1972370e87.0.1791824628223; 
 Mon, 12 Oct 2026 10:03:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac5265sm410054f8f.41.2026.10.12.10.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D57B5F9E2;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 04/16] tests/functional: allow tuxrun tests to be passed
 "accel"
Date: Mon, 12 Oct 2026 18:03:18 +0100
Message-ID: <20261012170330.1144446-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

For some tests we are about to add we want the flexibility to force
"kvm" so give them that ability.

Message-ID: <20260930164649.433573-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix the sh4 direct call to prepare run.
---
 tests/functional/qemu_test/tuxruntest.py | 9 +++++++--
 tests/functional/sh4/test_tuxrun.py      | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 6c442ff0dc4..ca1589fea37 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -65,7 +65,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
 
         return (kernel_image, disk_image, dtb)
 
-    def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
+    def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
         """
         Setup to run and add the common parameters to the system
         """
@@ -79,6 +79,10 @@ def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
         self.kcmd_line += f" root=/dev/{self.root}"
         self.kcmd_line += f" console={self.console}"
 
+        # have we specified an accelerator?
+        if accel:
+            self.vm.add_args('-accel', accel)
+
         self.vm.add_args('-kernel', kernel,
                          '-append', self.kcmd_line,
                          '-blockdev', blockdev)
@@ -118,6 +122,7 @@ def run_tuxtest_tests(self, haltmsg):
     def common_tuxrun(self,
                       kernel_asset,
                       rootfs_asset,
+                      accel=None,
                       dtb_asset=None,
                       drive="virtio-blk-device",
                       haltmsg="reboot: System halted",
@@ -130,7 +135,7 @@ def common_tuxrun(self,
         (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
                                                        dtb_asset)
 
-        self.prepare_run(kernel, disk, drive, dtb, console_index)
+        self.prepare_run(accel, kernel, disk, drive, dtb, console_index)
         self.vm.launch()
         self.run_tuxtest_tests(haltmsg)
         os.remove(disk)
diff --git a/tests/functional/sh4/test_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
index 1748f8c7eff..42b503585b2 100755
--- a/tests/functional/sh4/test_tuxrun.py
+++ b/tests/functional/sh4/test_tuxrun.py
@@ -35,7 +35,7 @@ def test_sh4(self):
                                                        self.ASSET_SH4_ROOTFS)
 
         # the console comes on the second serial port
-        self.prepare_run(kernel, disk,
+        self.prepare_run(None, kernel, disk,
                          "driver=ide-hd,bus=ide.0,unit=0",
                          console_index=1)
         self.vm.launch()
-- 
2.47.3


