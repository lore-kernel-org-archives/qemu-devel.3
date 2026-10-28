Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC8606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Nrlask3S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKu-0007ky-4z; Wed, 28 Oct 2026 00:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKj-0007cE-Hq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKh-0001fz-TS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:17 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cd5e295c8a6so30375a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161933; x=1793766733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AELHiQVuS8sMWiSCO4SoXVSgjVkl2maGXmVrCr1lfb0=;
 b=Nrlask3Si/f3SRGybj/S64PEYMyC/y/gKk7SPWln+twaq0n3h4m8zvwBYa1ijvU78T
 D9rXOkTU8oUF1fjWT2CqKsAATaPQBhgV+yjgN1Y1TEbVobHU6kg95XUDLeMCiQ7mBkBX
 u5ddVx4gME5xs2iyAIR5GiDOwEw2y3B6FaRj+QKLD1d77ckR31NKOEHZiz604TzyaLZP
 9cisWdFn2V4tUEQgNa3YcVmVLVjQOAbndvAR59urY7u3BISZeDBc/YeOa2ew+o/l2VSw
 2Zxo9DJMU0ko/m04VQbT69uUk0vVs+KQ3ihrbcJhciAtB4j94HaogGkucYXbQ0OEYb++
 QiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161933; x=1793766733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AELHiQVuS8sMWiSCO4SoXVSgjVkl2maGXmVrCr1lfb0=;
 b=CliHjQRx47vBSxbzk/HfLrSoN9heQMN/7X80lr93iICDGlDOvVQ5VsPoikY+dJlQb1
 lpdyLw7q6JIyKM03Qg7nWEkGKy6smwAifW1Q5NFhQ1UWpEDdU6tYeXNnfLYo8tUXK7Gd
 t/noRV29WD4KH2XEXrFWXTbsrOHE0xBl4+kNj7NFjE4KD2ZfwaKp4FVMq9lV4H57O4yv
 wPQLeYjIL4Szoe/uW1U6sWB+5alcTheV9GKQ/GZxPwQKSgvHZ7y2YdEOAA9htC9Ovu0F
 4/qbROugag8uyB1vaCM6SLCZiB6+ooYdyb+4GMFnGhhjn4nRv3vIPFvfyDWohJHHvAkA
 jLVg==
X-Gm-Message-State: AFq9FYLikml3S24AW3+uDTKhJZegfndZOIH9kN90l62CQ8MvBQO6YqRz
 xAJM3TJOtIYy2nCjLzbt3ozLRu4F3SyfM2R9gCATBbvEsEtj731Mv0dNLuXhNWDMnkWlmDxruE/
 FG78y
X-Gm-Gg: AYBFou07Qa53O3H21YKmqOlNr13M4mWdRhCL7aM+lqC648QpTikWDkJTkZSiQaly8xb
 BE+ZDFfEcg7XFQNkbPq2RHL6jkvzDZax/hX+/5fPJv2mmW5iGDsBu/kP7cUW/GMmVLJqq6oFARL
 7fU2gYIiehe+8XQ4vCejT/Qh+8yVWc8BJjhETCL32+Gg5cUr8M8YPqUYbHrXS1yfZT9ogdq/d8X
 akFyEYtgJUJGkdaX8LLtMp3u0LUsgTQO08ACrLFw22DMuDECNm7Ttr7xzg9coMBKRcaYXLCiWJS
 smenEpshp0GPNoHotxoBwU1/93Cq0NJfoprIDLpXy4qbM93UMptwBjlRGm8brY9WoIDItWltEbP
 bt/YazV5keVP87dWxeilYTpAMg+u74zQ/nKO8sQ7qnQ9EiBWr7UONvOvHfAF/Jt4pp7i8e1Clgm
 9sG+US5Q3skPZZh3+hJAMi6IPcFT9aKuc/RQoCTUdFmhYSdebojJoHFQQhCfQOOY8UyRKfEfnk/
 lgdiB4t0SCTiwhhw7pGLxnqdqvZ1zz5wcz9iKhjOUuSbjuNvr73/k2iK8H7MyfzZSiZN1v6jUvx
 wyM3Fb/LrJtSkaeqMTXRk220nxBDsx2JKDa1P1G7sJ27zPYBY8EbDVhF3P+feXHNP/VI4YlIHS3
 HqippDHCryQD0tpDwopCUjBI=
X-Received: by 2002:a17:90b:1d05:b0:3ab:be66:ddc5 with SMTP id
 98e67ed59e1d1-3ae5832117bmr1468375a91.6.1793161933109; 
 Tue, 27 Oct 2026 21:32:13 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:32:12 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 09/10] tests/functional/riscv64: Add rcpu to tt-atlantis
 tests
Date: Wed, 28 Oct 2026 14:30:58 +1000
Message-ID: <20261028043059.600498-10-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=portias@tenstorrent.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This updates the tt_atlantis test to test Ascalon boot with the rcpu
enabled and disabled. There is currently no code executing on the rcpu
but this tests that the rcpu model does not break Ascalon boot.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 tests/functional/riscv64/test_tt_atlantis.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
index 48abd5cd27..940ddfd895 100755
--- a/tests/functional/riscv64/test_tt_atlantis.py
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -22,8 +22,10 @@ class TTAtlantis(LinuxKernelTest):
          'rootfs.ext2.gz'),
         'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
 
-    def do_test_riscv64_tt_atlantis(self, connect_disk):
+    def do_test_riscv64_tt_atlantis(self, connect_disk, rcpu):
         self.set_machine('tt-atlantis')
+        if not rcpu:
+            self.machine += ',rcpu=off'
         kernel_path = self.ASSET_KERNEL.fetch()
         rootfs_path = self.uncompress(self.ASSET_ROOTFS)
 
@@ -48,9 +50,13 @@ def do_test_riscv64_tt_atlantis(self, connect_disk):
         self.vm.launch()
         self.wait_for_console_pattern(pattern)
 
+    def test_riscv64_tt_atlantis_rcpu(self):
+        # test with the rcpu enabled
+        self.do_test_riscv64_tt_atlantis(False, True)
+
     def test_riscv64_tt_atlantis(self):
         # tt-atlantis machine has no PCI host yet, so no disk
-        self.do_test_riscv64_tt_atlantis(False)
+        self.do_test_riscv64_tt_atlantis(False, False)
 
 
 if __name__ == '__main__':
-- 
2.43.0


