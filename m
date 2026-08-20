Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D3DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtiT-00075N-Rp; Wed, 19 Aug 2026 23:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiR-00075B-9u
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiP-0003ox-My
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso16857655ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197516; x=1787802316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JtX66qmQh5hGei4ld9cb4CgJsixrU426wPgSFrendcA=;
 b=BOTf9BTCxaKt5+DSvfIhAF+8OMxFgfgHa0WuAsXaLlCivUx6E+uw/38qMmthTpdLT/
 iwoWzuuThFZbbWnDMMLoQq3x5/cZbEI+4YI2H5yLD6pVW2/Fym3rEHFWHWN8bRHQ/Q2u
 +0QYtznVZSTdiMDMV+jKLMNM7oWhuQWpZO7yD0drX+KOV6bAePEI4IeVyqX684mvZ4TN
 VFeo+fR2mTIYfQiHpazLs5PMhV3p7vDa6YKSBX+u73HnyWcYe4VgK0khkzpACM+2VOV5
 WqaadhwHuT3jzK4XdvkOqEfzKFlEPe6/5LTZD8+yY3XsFDd/Mh2sVV578YPZXSlRGfF5
 h7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197516; x=1787802316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JtX66qmQh5hGei4ld9cb4CgJsixrU426wPgSFrendcA=;
 b=fTFjzHhrYKM8ge8xQAHCLKncZTyMkG8pnnZNdWu99YssFWmbYmzY6hluA3AP9M6IOU
 5x+spkSx79YzdP/qjZ0K6zy/zE1Qjahxm5P9o7hq8f3h03cdGW9NQ2cMen0PMR3Bx3tB
 1taz5OCqwgBk/rDyoHVvn5k04dlQtbnH+3K/vi+vv/+96kcraQ5QpxUtVHJH/BGZwa5f
 zi1eseOULt063FHmKQG3PgBfHI0jfDNIidLkT5LZUXOvjMs5bJRzwBf2W0qW8P432/AC
 CP8G27FVTh8rem0l5EXFgbt8U0RjzN4JEKrE1MIjFXxezbqN7u2c4TMKtYAJvPCg1V9R
 vXWQ==
X-Gm-Message-State: AFuF++mKQgehfRmbunJy8hZkSv7se7wRRyhgcqgir3Xvmo5AwtylNkmK
 kE1+vJaA27Kaq8Fhgv9HgBsaHDaknzxWFSKEGFql3Y9mIBk3nMxLQNSVNLsw5Q==
X-Gm-Gg: AR+sD12SVv79XIxlGSDfyJw+6MVl0VsAouiR3qCu6rJhDohyimiEwRLWkaGLRz6yf+L
 XZerpuLXyba/pSxt/1ZqmE5LmNUC+Y4o0bVP0mTK4JQ+/lHVv3vnBs3Jh5H/UxEI+ZY15ai3mra
 CYWiwy126zNFesFiR8OqLl6H09eUhjAclH39n9LB5/ituogrE5tvH/LBqsmbzuifVTYHVLR09yl
 GjNjOkEQBGs0IzwU5zHsSigeEcrWs7MSC9tVApwjOgqZkZMM1b64QTbGVLeKoVhWwGCcEL4mcIA
 1WPgjyRtY+qC5LFPkVU4J3Fm/9oLqE/0eTpMOWOxO/gzrKcJRaeARb+LcPY/LqPaZFfRph8aLjH
 42ZfYBPQec6KIDAbl3lDDXUkRjE3Y7kVg0YjNa2xjTJZFqXt/DJ2EgQvYyG27gh8GYTONR7Aeiu
 B/xzzhhC19TQJpldnTdkZrVpGK1cFQUnef2Bnfg0oe0ftiZEmUc6zOLXIqF4NX0IhcwIKVwENrp
 j7o3A==
X-Received: by 2002:a17:90b:5624:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-39580a7c3dbmr18932291a91.6.1787197516157; 
 Wed, 19 Aug 2026 20:45:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/93] target/riscv/kvm: Synchronize privilege mode
Date: Thu, 20 Aug 2026 13:43:08 +1000
Message-ID: <20260820034430.1186695-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Xie Bo <xb@ultrarisc.com>

The KVM core register synchronization currently omits the vCPU privilege
mode. As a result, env.priv can be stale when the migration stream is saved
and the destination can restore the vCPU in the wrong mode.

Read and write the KVM core mode register together with the other core
registers. The generic RISC-V CPU VMState already carries env.priv, so no
migration format change is required.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808125157.1220511-2-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 97069bf597..f6ddd0db9b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -603,6 +603,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     }
     env->pc = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->priv = reg;
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
@@ -628,6 +634,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
         return ret;
     }
 
+    reg = env->priv;
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
-- 
2.54.0


