Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B501CCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrh-0004ZN-6O; Tue, 24 Sep 2024 18:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrf-0004St-9s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:35 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrd-0001dr-N7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso235701b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216311; x=1727821111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dbl+YTbLgXN5l8ttn3+mnl62ViQQVuJp9Z/85bpmJ90=;
 b=NCYCreyJFOr0e+VrQQ+3T4fDVe2k9hgUeg1h79ZW+vzEM1/Kht+rmMgVhL6E6AFPwK
 XbASKXEJ5iJh8et7L8RW/hk5/R92bNIcJfyJv+Qp4NYPDagpeiakuM9jCjqsNeatpvcT
 Lb4MNM54sCNjiMIXyJpFP0HYdHFLoSRV7GgRUrh89KOL74pKVX69Fdy4zNrMg1HS4JYj
 iAC6T8p3JS/toepk0yu0LByP0Fdvc3Wwy/VNiUz6XS3jgVE11NvDm+H76OUNlUctbdCi
 n7yJ2XajKos1FW6dxhe6A6/5PhoQ8Nl+HfvlmmcZsLHZZ56u55m3ztLUuPKnx6QDgFBh
 p2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216311; x=1727821111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dbl+YTbLgXN5l8ttn3+mnl62ViQQVuJp9Z/85bpmJ90=;
 b=Fc2ckkoM8mG18+qwgGgzq78bj+AOAALJdv6vmkP/88DBrQxtTODHAcG/QXheQ0C3yq
 cxX31m6csyCroaqXV2iEw/ff6EKEw6e/HZz4wK6n2BOIzjSKxTSkrulhqcL61U379uGx
 jDwEkyw/rRthaCBLvc9l48h37cJFrq9v04dLobFRQTn5LQW+SuiQKhcjSpKbLMOTfVdz
 5nXb7+Cf/Y0G/BVT0uyjSRXF+YOgg1mcKXsZReadUXJD+k6HY5GSSCdDNOt3k1hfXVx9
 Gghk8UGByF9pivnvm4AXnJQSbCGJP7QTg20WNh33MfxKX12u3mqRzqteVgTCcp+rmF89
 5m/g==
X-Gm-Message-State: AOJu0Yzxwqt1Lb/LjYceOY2exREq2Brhx1bJBKkct5BMA2bZdCHqCu1C
 3MEe0WaRBxYW4VnLph1mRM1n+/dnO0lBcNzlW2D5ow7K3FP9OrVhGS2nZg==
X-Google-Smtp-Source: AGHT+IHfibP0gk20EjBOkTF11aOd/OYBKLUfGn496tdVvKLFKXDyI4oZFiVv/JITy1zdoIp1d3FmKw==
X-Received: by 2002:a05:6a00:cca:b0:708:41c4:8849 with SMTP id
 d2e1a72fcca58-71b0b2bd30bmr894507b3a.9.1727216310902; 
 Tue, 24 Sep 2024 15:18:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Maria Klauchek <m.klauchek@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 10/47] target/riscv/cpu.c: Add 'fcsr' register to QEMU log
 as a part of F extension
Date: Wed, 25 Sep 2024 08:17:11 +1000
Message-ID: <20240924221751.2688389-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Maria Klauchek <m.klauchek@syntacore.com>

FCSR is a part of F extension. Print it to log if FPU option is enabled.

Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240902103433.18424-1-m.klauchek@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a1ca12077f..89bc3955ee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -823,6 +823,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
+        target_ulong val = 0;
+        RISCVException res = riscv_csrrw_debug(env, CSR_FCSR, &val, 0, 0);
+        if (res == RISCV_EXCP_NONE) {
+            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                    csr_ops[CSR_FCSR].name, val);
+        }
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s %016" PRIx64,
                          riscv_fpr_regnames[i], env->fpr[i]);
-- 
2.46.1


