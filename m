Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6E606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zAkn54NN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt1V-0000na-Ou; Mon, 19 Oct 2026 15:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt11-0000Tc-QZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0x-00035n-Lm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so13637835e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438038; x=1793042838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MHQd0Qy0dBcHtI75gMXm7six4cUubHGlUqUSK4SmkFQ=;
 b=zAkn54NNtHCpAW5SE673ldlyhajpq9gCg2DdRd4vcRcyjVVugq9Eo5bSF5n79+u+LR
 /MygJcpK7GzRZgn+8DBWo1c3qHXC50x7ARwpkeCJuQfijhXcQaG37WysykQ8Y7rJ8QLk
 tUZnIYGiEEInvhZpChy1nvqBlBD9oZzc+UjZMJIh4d15Wpu4Dq9vFZTXwmC7daIq4o2M
 OReEGSZ0MO4XkwWGdtloeopzLKXMsByYcPuUG4NDKY9ChkkePslzO7zi1g2LuU7ZTSGC
 o0egOF5wIBDrKJFFoo/BSiTP0Dl63ZaPrOp0SAU17MT0QCV0lqkqsADllaPTmlAwpnJp
 hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438038; x=1793042838;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MHQd0Qy0dBcHtI75gMXm7six4cUubHGlUqUSK4SmkFQ=;
 b=rcUUVxoeUwPw0Oyx4KAHJBcdGV2BoLtTncpGHr7p7768vEZTKVvd8rZ5biOAjNC93y
 53wXT5F4bu0uerzHXyXNPwQ9nII+q3XyLNFVJsFstaKKJrqIZzt84VlT7NNGZHyevoCr
 SGMtkQ5GtHIEpsGa9cV8azI+KyAvBBOZSBF7yBNHu++VpPbu95k9FZklj2e5/Et2QekK
 nyg/kRA8yIAOSpMw5OKKOwqBYfTlf0srywXBSwG+BQysopVDSqSAw3sRaURrPfO9vHLI
 4WmC+ryUPXlQHfeYD++q+cLqN5KTxK0qz7IsMQMVGmZJ+3R2lToCcyKL5VtQ37HGgre2
 k5jw==
X-Gm-Message-State: AFq9FYKRfSf6DQNcPLvitTSCYjZPKVDHummZcNlyiJtK8HA7r/bJXnSw
 jWIG5LJTxGtdvkUkyiH19Qbvv/Sik6dneNonmsmYNPMZt3sGjXjhfsc1I+FR9icRQJw=
X-Gm-Gg: AYBFou2oH170X8Jb6hgRBS6RUrJkIIghMapr6p78+zufLB6WWFSgz1u6z6AE9lGisfl
 Wnrv/Jm8RSWC86xp0Irka8izGbNZwroa9mQFxWws1IEXrcfeiZSz95p8Y6d2zUb7j8J0iQa3EUv
 qjCEb6hHcrrLwJnZboowwR7dkukY1XOEEVRHDleKTAHXYFRP7NXH3fpkPFmBUc/SqMgCwz3unBd
 N3JbvIxTww352JVWDVltaYCg0g/PK5fLXQqgqoYZsvhgYFTj1fo0S6B/oqXjNuaFCX0bfCTfQEA
 YDfZCwIT4yruaip8dIPInFgsqUnwR2ujojagegh7T18r5lFnsNkfJit2u/XPTUJW2FxzvhdQp1h
 OcWKFLK47jtZRBqAtDcvzKol/HxTO1Rx98eHQ2Byu0O4htls+3y91izd+NiFmS7DJCKh3353CMR
 IlEWZwlBp8F35O/vw0MRF/zE43hhyL95Exgjg6IFN9Xwk/Otxud2/bvAElT/6sE6fv0WlHk5w=
X-Received: by 2002:a05:600c:1f8d:b0:4a0:1b14:d00c with SMTP id
 5b1f17b1804b1-4a1d75ab306mr211469285e9.3.1792438037740; 
 Mon, 19 Oct 2026 12:27:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c9e9c3sm12611915e9.3.2026.10.19.12.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 833175FA65;
 Mon, 19 Oct 2026 20:27:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 05/19] tests/functional: allow tuxrun tests to be passed
 "accel"
Date: Mon, 19 Oct 2026 20:26:50 +0100
Message-ID: <20261019192704.3220373-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260930164649.433573-7-alex.bennee@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

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


