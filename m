Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF13E68950
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MIB-0006IN-Mo; Wed, 30 Oct 2024 23:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MI1-0005J9-Mx
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MI0-0004HW-3w
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so4516355ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346962; x=1730951762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGB6EViGKzXgGKp4ADLj+8M+6zxt1fVYVDy4kQQmz9M=;
 b=QTyLzJMo0ikpnHHWunUsYjjG5RpVKKpBs3DlEvQjLKVp+Dkn5MQo8FNLhNNeYem6Zc
 q07fsOAWfc99WNFkpiJxhT67hBXQTbcZ6WbU6a1VF4L/1fVXmivaRVqHFIx8JP77g2Lf
 CXk7JpiNBStzlmWmBDPzdHqdnOcfdJsNOmKwKZ5Vmx1N6Kqa7pFP6SQn02vxdp0ulL+y
 MThCEiiWevicg0lg5BdBERBz1weCWI9+xaqx6kOBexBdaIuG/lXOSS8tsdjQE616SHvy
 U/yFcu4rMbREqfrex/g5h9rCgX09187YB+vu/SY/NU6LUrvCSpZW8/Mu9aNFgTR9qSP4
 O4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346962; x=1730951762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGB6EViGKzXgGKp4ADLj+8M+6zxt1fVYVDy4kQQmz9M=;
 b=Bar98807PQ2HsTIPHNswMo75X2+E+Bh9MuBuSyDQunV+XCSZ1PDTE7jCPCVwUTiW9S
 btb4yxt8qaBDU/7Hf58ljFIpwPMRy4YTwrbZ4i8V1XKBvPMl61kJmDzeZsMHlak+e9jP
 BQ+e53TjgpNFEaD+4zwxqwFvGGRKhmQscfyDuaKzjlnjkPWI/s35Py2BNOYheIJuqA1e
 cJq6ebsqGiHcxPULMIph/ZSYw/YaVS3yfetClXFrqcHrieKfieG6FI0fH5GLB9XLl7La
 BBeEdTAEgjKy6j5xGuiGXYAR9rQMd2ByH4ttvvGN1qelrTUYjMN3wslAv/HqLvvE6F+n
 GVOQ==
X-Gm-Message-State: AOJu0YwSmwc3OKAnCkHTtRyikeSiEH2ranxbBd15h0fb6/DPxlrWNhL2
 k0v9edSL2fPOROM1UNnXv3ecMLwq98JUP1rVUWDD7w8AzBU28gg/mZFtFRXU
X-Google-Smtp-Source: AGHT+IEMOlGfDlFYrx8f6rcB0D18fs5djbU+62gFVqpWuuJjDPlZW3IaH+CO2Bg0WGmn8OLq6dBthQ==
X-Received: by 2002:a17:903:2a8e:b0:20c:9936:f0ab with SMTP id
 d9443c01a7336-210c6c71167mr264584125ad.47.1730346962322; 
 Wed, 30 Oct 2024 20:56:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:56:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/50] target/riscv/kvm: clarify how 'riscv-aia' default works
Date: Thu, 31 Oct 2024 13:53:17 +1000
Message-ID: <20241031035319.731906-50-alistair.francis@wdc.com>
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

We do not have control in the default 'riscv-aia' default value. We can
try to set it to a specific value, in this case 'auto', but there's no
guarantee that the host will accept it.

Couple with this we're always doing a 'qemu_log' to inform whether we're
ended up using the host default or if we managed to set the AIA mode to
the QEMU default we wanted to set.

Change the 'riscv-aia' description to better reflect how the option
works, and remove the two informative 'qemu_log' that are now unneeded:
if no message shows, riscv-aia was set to the default or uset-set value.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241028182037.290171-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index acc713c56a..cbda4596da 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1676,9 +1676,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
                                   riscv_set_kvm_aia);
     object_class_property_set_description(oc, "riscv-aia",
-                                          "Set KVM AIA mode. Valid values are "
-                                          "emul, hwaccel, and auto. Default "
-                                          "is auto.");
+        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
+        "Changing KVM AIA modes relies on host support. Defaults to 'auto' "
+        "if the host supports it");
     object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
                                     "auto");
 }
@@ -1712,10 +1712,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    if (default_aia_mode == aia_mode) {
-        qemu_log("KVM AIA: using default host mode '%s'\n",
-                  kvm_aia_mode_str(default_aia_mode));
-    } else {
+    if (default_aia_mode != aia_mode) {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
@@ -1727,9 +1724,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
             /* failed to change AIA mode, use default */
             aia_mode = default_aia_mode;
-        } else {
-            qemu_log("KVM AIA: setting current mode to %s\n",
-                     kvm_aia_mode_str(aia_mode));
         }
     }
 
-- 
2.47.0


