Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DE5C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOf1-0008PQ-EP; Fri, 09 Feb 2024 06:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcs-0006X2-BX
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:59 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOco-0000pG-1Z
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:56 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59a8ee08c23so289839eaf.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476452; x=1708081252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qii4YSbAkSXUh1QBoKW9LgLlaF88+i4MvasNEAgf5CQ=;
 b=cT7waXcGCeq+rhBRonLDqKYro74RjRXXelrVlhqmjuHZF9EjKku8No2QSZZLn2GaZ8
 1u0Xh4EZ2U/fmcvZQd4ig69RY62oqNICpJQztoAvpgEMSM1R363+ZIX7RcYiDOMwdln/
 P3Za6mnvdA/UqmNqGVdEpSrJuh9KQLuKq2ktv2N4AVdbb1iAW/blkKHnMl0lJr/xuOyj
 U6uiOE34ewB1Vw2zkdtslFjb0X6J8uc/oHJyF2yIHWGyZ9+v4RdH+0Bu+SKwxDYI0whS
 qZMPWj38Eapt1vCGugS7iFI5DPWJhGLJB4FhQin3a32sF8IBmcZhnBfdoSJkCVknw1SK
 XkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476452; x=1708081252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qii4YSbAkSXUh1QBoKW9LgLlaF88+i4MvasNEAgf5CQ=;
 b=J0zHvjAV0R7CsXKAeS55Na0n9f45pIfamKmJjt34Wb/7jxBZdzeIR5HvCU8Xu2OW82
 0U1amTuihcum27sbqv9GFzPQ+YTUnFZUgl+0TBs673VwBrPSml2L9SQMI+C+p7dKetpC
 ajsnzbvascP5arxfdc1ruM8+dQElEtY8c8SmbEm4oi1DWnr02VqXvUGQqhhy/YQW+/QV
 355v7/0CgY8iD7MMAaF/rQJyQrPvJ0tOPT0+RC14kl0FeFcRH7UHo6DNfR8dMqWFF3EB
 aUXJi8fFaAeV39IBoXigTNmZFSKGV/MYILHD0rY6q2YRA0ctRTbu2FRBnYrU8FNw7oI2
 QcGw==
X-Gm-Message-State: AOJu0Yzees9Rwd7rMCfWQ4U4J4L6obmgYJBI9f93kEx8Pn/oToBRRYgh
 PiorVLPT2qDwHxbbKlaQvfFH45f4oho1kyZ0cLUlTuPdujpt34+vciJvbGV9/k5AZQ==
X-Google-Smtp-Source: AGHT+IFqmjS88liE74TqatcLXJ1HQuQuyndQ4bT+dRpMq1DWqgO/0hPCLcshrycmEOaYFO/9I1bUaA==
X-Received: by 2002:a05:6358:ed05:b0:175:d192:946 with SMTP id
 hy5-20020a056358ed0500b00175d1920946mr1272061rwb.2.1707476452621; 
 Fri, 09 Feb 2024 03:00:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtOyIVZRFuHUi9FJ8P4yH+MyYWURF0E4aiinHpCL19/jizX/6NdViKCGmPtaPT2f18RdbOYKXtYZqPccb1eCRx+2PSQUhCZXYNGelAm0+FXB6Bu0a1MH/bVhvBKguaQk/gRN7ACofXBeyfGmhNXrWfcii9HaUu
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/61] hw/riscv/virt.c: use g_autofree in
 create_fdt_socket_cpus()
Date: Fri,  9 Feb 2024 20:57:57 +1000
Message-ID: <20240209105813.3590056-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move all char pointers to the loop. Use g_autofree in all of them to
avoid the g_free() calls.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240122221529.86562-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f9fd1341fc..373b1dd96b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -215,12 +215,16 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     int cpu;
     uint32_t cpu_phandle;
     MachineState *ms = MACHINE(s);
-    char *name, *cpu_name, *core_name, *intc_name, *sv_name;
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
     uint8_t satp_mode_max;
 
     for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
         RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
+        g_autofree char *name = NULL;
+        g_autofree char *cpu_name = NULL;
+        g_autofree char *core_name = NULL;
+        g_autofree char *intc_name = NULL;
+        g_autofree char *sv_name = NULL;
 
         cpu_phandle = (*phandle)++;
 
@@ -233,12 +237,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             sv_name = g_strdup_printf("riscv,%s",
                                       satp_mode_str(satp_mode_max, is_32_bit));
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
-            g_free(sv_name);
         }
 
         name = riscv_isa_string(cpu_ptr);
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
-        g_free(name);
 
         if (cpu_ptr->cfg.ext_zicbom) {
             qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
@@ -277,10 +279,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
         core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
         qemu_fdt_add_subnode(ms->fdt, core_name);
         qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
-
-        g_free(core_name);
-        g_free(intc_name);
-        g_free(cpu_name);
     }
 }
 
-- 
2.43.0


