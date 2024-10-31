Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE009E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MI8-0005rr-Dz; Wed, 30 Oct 2024 23:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHz-00051i-1E
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHx-0004HJ-8R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso4919695ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346960; x=1730951760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aKG6/GDIk+GibaacYIfY/1qVD+NPgMlgMMI0fejrUs=;
 b=MuMNXn/Mv18q0aUVMpTEkKKr9bsGCl3f1tGYPWJzu5cGt3avkTy7BdzDPuoTPQXUPQ
 wtmAr8Yx++UQ29y3/LbKF6860hxYX8M5qUoYSEvmLmD5pPpa+pp1Yk7aHjk4WFE/mm6I
 qhJhciC3nzm4Her7OpOVP/Z7Ztmb+/WoamVJM8s1QVkNC5bgE1LXNBp1RHBquppsXmzL
 xFwqvIrfuo4Q6VG//Y8FYqEqn+xVsQXaGpUB0e7ymNBzqY0Ouvz/hd+1vB4FwOKixWTM
 t/WK2KkISYDm6mMe+bQxxiiOn0oo+dnipb7m3qoxm092STtDWFRXWG7QnahpoyO5oGiv
 N1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346960; x=1730951760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aKG6/GDIk+GibaacYIfY/1qVD+NPgMlgMMI0fejrUs=;
 b=U2iIfqhRRa7ki/DU7S1IeFt/FhVlKBe+zmxkkgVIu4W0ZcUscLoI5FDjB1u5oST4m+
 l4l6KxelkOfal607MJpq3oCOpEEOGGL1BEcX3Uj54hes+azU8UzSUfUOvwYfHRpyfNn4
 PBNDUB7jZu5k/dvXwsQ1Xey+rAaIWgduos0M00HMD5W/zUZUgmJOCbUj8jBc1DurZSB0
 BleY9JeWredaP9TO2BBtVqVuHjN3l4j+Milhx6YwkkwEpF/Da3UOHEGNAGrb3FwaFBfK
 rdrNfJKruQ32ZLFo5eHE95bc8M0Po1pY7VVlfMZ17ZIEEnHg3Grro9mcvaxcrcVeqp6f
 BVcA==
X-Gm-Message-State: AOJu0YzMdfOWaz8lFCSy/zf9cxrHdx1f7/0XaOVaS7buPUmIFolFCH6t
 Rha0ywLI8xiA29okPw1ZsA74IYcIYAbO2OEmx+McWXYQqlnbKTWam9pfhEkD
X-Google-Smtp-Source: AGHT+IHQF4f8x6/5BZ/KzbYJL3ZkT3+wvI1rUU+uuidfU3ohnMrShMCaZM/Bd0CoZCbVjYFNV4qu8w==
X-Received: by 2002:a17:902:e883:b0:20c:895d:b41c with SMTP id
 d9443c01a7336-210c6c7596bmr238668575ad.41.1730346959613; 
 Wed, 30 Oct 2024 20:55:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/50] target/riscv/kvm: set 'aia_mode' to default in error path
Date: Thu, 31 Oct 2024 13:53:16 +1000
Message-ID: <20241031035319.731906-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20241028182037.290171-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.47.0


