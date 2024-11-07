Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F43D5AE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8trQ-0006Rq-60; Wed, 06 Nov 2024 23:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trO-0006Pv-F3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:11:06 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trM-00051b-Ma
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:11:06 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso437536a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952663; x=1731557463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJit+aB1hSEY7Z10W4rtdeM1AjZpq2DQ/M5egNktBGY=;
 b=d4wj0lB1icjmUm0xr//8jtTO0/1HoU3NlDYhBjSIAoD4mEyIRV+Xj9mFDqD6I3GA1E
 onzZjVqn298IPVHyMHeuf7+H97FUEUUU6zaxkKxey0nMoip5wSzt56P1kQWEJQi3LWLr
 IlM9UmbhxUd3kqO2niIFQYfQUarxPb5ivS9zih0/3u5qu+FPw3ErUh26/FSUFD4Xytdg
 kOGcMfqzOgf5CDU2+W+jsDFFjCN+yIAm51spYMiAYqzqfV/yrr3sNidI3/LY7TCA8J+p
 /x8z5sbDogO/1jNAo9xppLT2o8ufa27UOpP3JCB+WFZBWIHXclJTxv07kt8HvMG0PbRB
 Lvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952663; x=1731557463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJit+aB1hSEY7Z10W4rtdeM1AjZpq2DQ/M5egNktBGY=;
 b=tyHctCgX17LYX5vmhS0vrDDXMRo8fUSO8AeEevTBp+1jgex0k0c2pBjxbBRyzaey1s
 N/zBFlOZJbx8RS8lXIHdh4IzC9VPHFnnuMbAbrzWIMti/0SBSn9qZa7ngi47ubARrwWZ
 wVVDCoh9E3dkGva7LFmr9ohEmV5lvmeYF7+q6DBj0sxH7LGtnGKKmo9ccQUWZu4bimVd
 QeFcdLaRz9c4ibDTh6ApX0stAs7//jEgsYq8Uy6Dc/7H4xryiyZWIyWyVZOUleWA5qQ4
 9clEFle3HUGlfkvQqIk/uTEv58r6P/5Kinv4vaJ8csOfHT93ZV4no84xIRsBSbGS2Duu
 deTA==
X-Gm-Message-State: AOJu0YxBoWtTBNEbVUmi/fUH4/JDTbr3fqSZvlnNF6M3HIoolVlhHHDZ
 jRyfkF9jWYIG721apk/DdUEBDYa0AlnmP6osZYUCToaAgDMUsT2UtQKv8w==
X-Google-Smtp-Source: AGHT+IH/UQCq6y7TUDAwiEg6MJpScbUOExO/H+J9oKNDVL0DrEN7pB+pBbzpmtX3r+hHng+GENzv4w==
X-Received: by 2002:a17:902:e890:b0:20c:8abc:733a with SMTP id
 d9443c01a7336-210c6ca8b77mr597730125ad.53.1730952662904; 
 Wed, 06 Nov 2024 20:11:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:11:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 12/12] tests/functional: Convert the RV32-on-RV64 riscv test
Date: Thu,  7 Nov 2024 14:10:16 +1000
Message-ID: <20241107041016.40800-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

A straggler that has been added to the Avocado framework while the
conversion to the functional framework was already in progress...
Move it over now, too!

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20241105103519.341304-1-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/tuxrun_baselines.py       | 16 ----------------
 tests/functional/test_riscv64_tuxrun.py | 13 +++++++++++++
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 366c262e32..38064840da 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -222,19 +222,3 @@ def test_arm64be(self):
                  "rootfs.ext4.zst" :
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
-
-    def test_riscv64_rv32(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:riscv32
-        :avocado: tags=cpu:rv32
-        """
-        sums = { "Image" :
-                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
-                 "fw_jump.elf" :
-                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
-                 "rootfs.ext4.zst" :
-                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
-
-        self.common_tuxrun(csums=sums)
diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
index 13501628f9..4e2449539c 100755
--- a/tests/functional/test_riscv64_tuxrun.py
+++ b/tests/functional/test_riscv64_tuxrun.py
@@ -23,6 +23,13 @@ class TuxRunRiscV64Test(TuxRunBaselineTest):
         'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
         'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
 
+    ASSET_RISCV32_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/Image',
+        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
+    ASSET_RISCV32_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
+        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
+
     def test_riscv64(self):
         self.set_machine('virt')
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
@@ -34,5 +41,11 @@ def test_riscv64_maxcpu(self):
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
                            rootfs_asset=self.ASSET_RISCV64_ROOTFS)
 
+    def test_riscv64_rv32(self):
+        self.set_machine('virt')
+        self.cpu='rv32'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV32_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV32_ROOTFS)
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.0


