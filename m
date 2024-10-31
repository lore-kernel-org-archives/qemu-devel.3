Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D5E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFy-0007I3-Dz; Wed, 30 Oct 2024 23:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFx-0007Hv-4A
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFv-0003uP-KI
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso4238615ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346834; x=1730951634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH0jRHToVF3C8lmDDZmUohZ5ReWzqmRHE5aVJm2dCjo=;
 b=clivB+/2ehshLhlGMP9qm65rZs2dCuQsmNzIoIQeIOghw7rCB+h/Es8N3h2e/1UWQj
 qp4zLA9p/hrkvdr0GM2hPUAaYSStZIqDOzYWI7ER8HY/wEc9RSLZBpIoItdKb/GE/clP
 /fc3VjqnGqKxiQKgt5YJcz3BtjKLKsCRCqCOCTS4Veq5rkOnB14Tda67TgK03G51/rgF
 5Vo/r5/oKzY3hP8Gj/c/AJt9vWu2oQzsVyDJMh0aBTNRGwc6FiSZY5451u0Gnn+DcPcB
 +3jzx8q8IWrd33dY81Fod9YGX5/As1+ptsuJdqvMu1077jcEI39LvLBDKimXxjtgAORU
 fFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346834; x=1730951634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH0jRHToVF3C8lmDDZmUohZ5ReWzqmRHE5aVJm2dCjo=;
 b=wfO9Gw+2t2CJyjc3ij2O+j0j+zVMHdu8iPB4KgI/z/H8AwetPet+km204ehBTKD46P
 3QY/XsR8Jdr+SWddaL8n7CJAsJ1t2dbpn+3JidKj5Nd3CX56JgwNnYtBFW76BY8+LyGU
 nwmrfbQehbrMeFssodH/YJPLa7be/NFBaNtPM9HnopDuEZ1G4m1pO48pIhvzyPb8UPYa
 0d8Ob/12YGLTLa9bRxuA+MYU2vHIqQsOXXdfIG2YApg4Lg2ES9M/nzmLUVdly7jGvXMk
 URrPSlwQjOTSWXtWekV8hVT7vKnh02LrSyP45vD/16NCdU8ND99Iexdxgf6GS0kEbdqk
 ctgg==
X-Gm-Message-State: AOJu0YzyP4C4zoxTrGJ0Urc5lvtEnlV7Ipw0jF+C2OHbUGDWwaPwAI6x
 BCEKxubqqc9xci1z8r83VZlNnKbcSzoYLsYqBewGY5LLxslJp1r9o0Q4fbYk
X-Google-Smtp-Source: AGHT+IGZfc+cl+nWT+b1TgT1INzemUp8OW1FODf/n2GrLZDCPTG3gyvTqNd1NTnjoOJeB7uhdTs5Fw==
X-Received: by 2002:a17:903:1205:b0:20b:a6f5:2780 with SMTP id
 d9443c01a7336-210c689c390mr214042315ad.17.1730346834002; 
 Wed, 30 Oct 2024 20:53:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/50] tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
Date: Thu, 31 Oct 2024 13:52:37 +1000
Message-ID: <20241031035319.731906-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

make check-avocado AVOCADO_TESTS=tests/avocado/tuxrun_baselines.py: \
TuxRunBaselineTest:test_riscv64_rv32

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240919055048.562-9-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/tuxrun_baselines.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 38064840da..366c262e32 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -222,3 +222,19 @@ def test_arm64be(self):
                  "rootfs.ext4.zst" :
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
+
+    def test_riscv64_rv32(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=tuxboot:riscv32
+        :avocado: tags=cpu:rv32
+        """
+        sums = { "Image" :
+                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
+                 "fw_jump.elf" :
+                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
+                 "rootfs.ext4.zst" :
+                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
+
+        self.common_tuxrun(csums=sums)
-- 
2.47.0


