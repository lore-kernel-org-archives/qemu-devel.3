Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F44AD339AE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5UMM-0000We-DX; Mon, 28 Oct 2024 14:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5UME-0000TK-05
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:20:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5UMC-0003bn-E8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:20:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cb47387ceso40902235ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730139647; x=1730744447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cq9Je+3AItTZSsjAKo4U1dBtK51Yj0NveU6wRA1QTeM=;
 b=a2m35KT6t4/IhHQ8IhYglaUWLNWuJZMBiFECU5YUEqITXBI87mbpeWcIwi/a46kDFt
 QTFOJySkOYMziXyljNRXEmJp2BIspFPUM1brzyFu7r3hN1SQpdk8i+ZgkWmqdZc5iqWl
 701FXmADwzEpSTxZ2m4GXf43rAgwFV6Q7M+3InuxwD5Rukk6kXs8/Q6d/k3/s4CnYf+k
 uLQkbxQ55vxbimYj9p3N2xgAsCQ8tIuGRU/yybu+EG9SvRupMV534c6a13ythQwl4kRy
 ckKxP1WzUE4UrfmvUTmG1EFJlC+nL2kDFVjQ0AwmoJne8j5fSJbxtP34EALqNfSG9ir4
 W4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139647; x=1730744447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cq9Je+3AItTZSsjAKo4U1dBtK51Yj0NveU6wRA1QTeM=;
 b=vmYu9n4Y8B4i7P+D/tDDr1QxOsRIxmoZ2QaLhK2cgTIf+3sVofYaBaqmuckGCMZRab
 teEbcpeULOPZNiKr0uboy+hXcK5D5XhhCphEEHYwS/rXrQyZeHRa4k2pZlUq9lZIg4a3
 CCslw836nT70dn6yIqkouL+PZBl3Caoa/byHa5ryMLW8HzYftyX37JtrAhoxtWpEDV3O
 a9mpLeiTVfbcpn/sQFmMoGyzVUzQoUXGXAOPFtRU82eLjdeukSaqCLZyTZOEW7F5hnfC
 5oiwWP/juujD7VRb9JvymFv+7kHEI/78Io1IkcCU5QeNC/YduuuNSVf0EdGLJpMbYJkR
 72qg==
X-Gm-Message-State: AOJu0YxESJpdvNmU0UFqDqzZeVqcPbkmPM43i4Hu+A2Ixi5hgjJ2r/kr
 m9dDunYGVW2S4TXJt2apLLpMN9sqdbi4t8I1Azr2K2WWTnIuaO8FRjV8wdnl8PyUZ93ZgucYraj
 z
X-Google-Smtp-Source: AGHT+IGnwbG+cdQtxOv+szUgMnrltyRu3m9iMSVmFpMRWnMQJ93We1bTXf+WGv/wCL0odlgp/Eg4OQ==
X-Received: by 2002:a17:903:22c5:b0:20c:d18c:1704 with SMTP id
 d9443c01a7336-210c68c6f57mr122401185ad.23.1730139646649; 
 Mon, 28 Oct 2024 11:20:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf471fesm53637505ad.51.2024.10.28.11.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 11:20:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] target/riscv/kvm: set 'aia_mode' to default in error
 path
Date: Mon, 28 Oct 2024 15:20:36 -0300
Message-ID: <20241028182037.290171-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028182037.290171-1-dbarboza@ventanamicro.com>
References: <20241028182037.290171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

When failing to set the selected AIA mode, 'aia_mode' is left untouched.
This means that 'aia_mode' will not reflect the actual AIA mode,
retrieved in 'default_aia_mode',

This is benign for now, but it will impact QMP query commands that will
expose the 'aia_mode' value, retrieving the wrong value.

Set 'aia_mode' to 'default_aia_mode' if we fail to change the AIA mode
in KVM.

While we're at it, rework the log/warning messages to be a bit less
verbose. Instead of:

KVM AIA: default mode is emul
qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode

We can use a single warning message:

qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode 'auto', using default host mode 'emul'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8233a32102..acc713c56a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1711,18 +1711,26 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         error_report("KVM AIA: failed to get current KVM AIA mode");
         exit(1);
     }
-    qemu_log("KVM AIA: default mode is %s\n",
-             kvm_aia_mode_str(default_aia_mode));
 
-    if (default_aia_mode != aia_mode) {
+    if (default_aia_mode == aia_mode) {
+        qemu_log("KVM AIA: using default host mode '%s'\n",
+                  kvm_aia_mode_str(default_aia_mode));
+    } else {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
-        if (ret < 0)
-            warn_report("KVM AIA: failed to set KVM AIA mode");
-        else
-            qemu_log("KVM AIA: set current mode to %s\n",
+        if (ret < 0) {
+            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using "
+                        "default host mode '%s'",
+                        kvm_aia_mode_str(aia_mode),
+                        kvm_aia_mode_str(default_aia_mode));
+
+            /* failed to change AIA mode, use default */
+            aia_mode = default_aia_mode;
+        } else {
+            qemu_log("KVM AIA: setting current mode to %s\n",
                      kvm_aia_mode_str(aia_mode));
+        }
     }
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-- 
2.45.2


