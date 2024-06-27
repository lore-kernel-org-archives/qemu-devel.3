Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00E3C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwy-0005BY-M9; Thu, 27 Jun 2024 06:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwt-0005AY-Lr
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:51 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwo-0001fl-MY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:51 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6fa0d077694so3602203a34.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482505; x=1720087305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rwQsSYLKQgi4K97lVRX96DE9ZTfnP0leAGSv9Zh3mk=;
 b=DKl2IhAWV9Voa/EI9v/4ZV4WmNo4oeJfoN+G9GPNwT6pPGPKqT30RgNLSHXj/swq5Y
 SepFzYqNoamHaksnJDjvLd3+SnMzTyBXLuwRu4mN0vMB5cSjstDxWcGxMlAYq/IhFSUo
 2OXRmfYoN+P4T7vjfZpwq4x7Uo5pc2EhTjc2v1nbW6SZZrnTGUs2W590oDLrdYldVOMc
 uvf8e4axQw9ENF+/ZduhkbaVNIlcKJtN6gpq6VLDhPc9+rQ+4jcqLeApyf+U3NeewXBu
 nAwTGfbY+CblqRWC6QNdLn24JSTaD0S0mi4LUcjLe9HcCvf4lqycEWJLT5U/8WOB05H6
 ZXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482505; x=1720087305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rwQsSYLKQgi4K97lVRX96DE9ZTfnP0leAGSv9Zh3mk=;
 b=GpnU9ZvqiAW6QdzfYT4vPLWXoAbVNvAcsaeTTFiKR2nArxzv16c6Z4uBUrioeCevz2
 MOQ8gZDue1YpnL0r9OQCLZZvoBI8EkhpO7+xafu6vWRywNpG+NepIO4ypDM+AzOkMDOd
 GXgUqvTp+4GBAobEqQ7zTeJ6vub6L767ziPPgr2KU10ygwtepy8CHWGUDUpN2HMlR53u
 rZqavFVqZg58RmV58Pyihh6DTrRj78KpVWUf/6AWcZqY4ANALRkqs3byGUvAGYUNcQAS
 TtuxfNVSkBj/4FfNygZDdGEo7lMDYLlenIFPl5xCMqNQxRA50Gl/AljdleNIWWm0gIT1
 Zu4Q==
X-Gm-Message-State: AOJu0Yzsn+Yxw/w2lpCKStYRtZNdiKIVhSQShPmjsYG0UvB/DI5QRkvk
 t64QxBQLZ/ReRUBG2RGO7iW9JSeGN5K2ZnQm/3FlM3wKT3iE+mOvKaJ2x8X1
X-Google-Smtp-Source: AGHT+IEAdpCuXdHD4ZYfF65M15BUKtMZ63gCMbHAlTpoJGh9ZLVRDdgQrosXr4m1VYlOqg14l3Zc9A==
X-Received: by 2002:a05:6870:4208:b0:258:3c97:f091 with SMTP id
 586e51a60fabf-25d06bc9224mr13719286fac.9.1719482504729; 
 Thu, 27 Jun 2024 03:01:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Du <duchao@eswincomputing.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/32] target/riscv/kvm: handle the exit with debug reason
Date: Thu, 27 Jun 2024 20:00:34 +1000
Message-ID: <20240627100053.150937-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x334.google.com
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

From: Chao Du <duchao@eswincomputing.com>

If the breakpoint belongs to the userspace then set the ret value.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606014501.20763-3-duchao@eswincomputing.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 748fe5980f..1047961fed 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1555,6 +1555,21 @@ static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+static bool kvm_riscv_handle_debug(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    /* Ensure PC is synchronised */
+    kvm_cpu_synchronize_state(cs);
+
+    if (kvm_find_sw_breakpoint(cs, env->pc)) {
+        return true;
+    }
+
+    return false;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -1565,6 +1580,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_RISCV_CSR:
         ret = kvm_riscv_handle_csr(cs, run);
         break;
+    case KVM_EXIT_DEBUG:
+        if (kvm_riscv_handle_debug(cs)) {
+            ret = EXCP_DEBUG;
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
-- 
2.45.2


