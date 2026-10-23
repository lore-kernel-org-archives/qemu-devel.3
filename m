Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84062606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UBqN2i3K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeN-0006g0-LE; Fri, 23 Oct 2026 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeH-0006bH-Ct
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeF-0004XH-F8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1e34ecb02so7490005e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778746; x=1793383546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CoEX9RGOQlXlmn/F3LALjy779wWjUioxxDaw3tYV6Rs=;
 b=UBqN2i3Ksd+WMrToHWqQbYbuQgiFaNsl7JQJF2iX788HwegGMCu8vUawHQvOItuagI
 0MKugh7HUhy73GPPTPjhbVyqNbcS5UHqQWSEn5YBb6ajDaxJwfv59v1jtYzZRPi7nNMw
 bDzDqVe1xY+YfBuNJco7SGeTi30+PYSIy7+99Da7zuC8FWhv8cco9Bnf5va1XTzbmPHV
 wIJtQHPAcxl8GSh1uNh4jMg8TYXjvd7HbVqVgEMiFQ2r+0gvRNljR6UqYul5S8sFJWZW
 x+O/rSz0G8BAONnGQF5rCTJmRJgkGFq9TFwvsOWMmNOM5G8tU/4NtPJlXECeIPcPfLxT
 nsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778746; x=1793383546;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CoEX9RGOQlXlmn/F3LALjy779wWjUioxxDaw3tYV6Rs=;
 b=yrTl++CZIiKZ3Kf/nKME77cP3MnK4mxYYCU7NNBrLvucapbL02etKKiVg8jS/fVUAE
 424skLSP8bCNh5Mt5x/ak6uJF99g8mBtqMuXG1Vt0qGCWL19OoP1NK6quPAQu9YZHZnb
 FKWXjOlvZeuMFJjxTb0UMQQZUAE7P6E8xxz2zfm3GfktbXy/wJ4nToIvwCgSYM2jOPNy
 osinIjtT6YpOqqs9licKzNRxrEt695hDuxGBJ/guS1STxuMHwS/4Uaamc2vxG6ZqYcRQ
 mROlUqSyE5dhjUcOJzDVg3y0FR5IvYo8+ReGFaJQKO4fefXSlF6VOokYcBkKLYmjanPY
 Cb8Q==
X-Gm-Message-State: AFq9FYJdSp5QEyVawr+TVQDQjteN0+JzcXNwnzKd+6i6ZzwvahjDBC8X
 QJHSRDQ+8rJjoQsnbnD42Bu1tQ1bAk3pT1Vm5AIHXZkPsYpHXAltHbT1LNZV/7D33gg=
X-Gm-Gg: AYBFou2xDZnTZ4vwB8JaecAwLaDo37npaaEUb/+TBywwYmoGny7SIrDFBdo1XIHxJqJ
 J4XrwB4h8MgkTli/Z5patfCKMo36ehf/6k8jTqEp+0VHrBPvWxzWMC0Aumo3vgXu3mG9g0OIWYi
 29psZBVls7e3zrEISCpd9lLaXNSChzg6VjiRLe1wzHaRI89LnPOSW19drOeYwrDgYLy6aMQ7FCR
 DwX2sEYdAedspbtr0h1CFbdabGLSoyWw1Quts6XuL07Nhc7kfY0g3peQyc0QiNGC+TVZbsGZqZT
 oHmGsXZk9CNeVoClnSOFVgXbAZFOPLSRUzVyTdqlrP2YZmtopViKP/LJJ5re36ZTVoKSrbpYJCN
 0W89m2GKUE6OhIo/1wvfwt+YNBclaPobsBmALr+cRjTTigbdyfM3Gu3gCLfCSxqLB8ErryJU9zE
 H9SszKvHoktiGEkF8WXrHTKHhhDjMS9QnulVl0CNSC8c2BQurBpwFDjcRp4fH36ngQqgR5zarvq
 JT+x+1yibKEhZX/pL7RNpsfmakA/xxOVwrzGHRiRyLRqjOrFSmrUNvb
X-Received: by 2002:a05:600c:34d4:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a211f114f5mr49065505e9.27.1792778745991; 
 Fri, 23 Oct 2026 11:05:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d41cef8sm1558570f8f.45.2026.10.23.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E403360A59;
 Fri, 23 Oct 2026 19:05:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 05/19] tests/functional: allow tuxrun tests to be passed "accel"
Date: Fri, 23 Oct 2026 19:05:23 +0100
Message-ID: <20261023180539.1574134-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For some tests we are about to add we want the flexibility to force
"kvm" so give them that ability.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


