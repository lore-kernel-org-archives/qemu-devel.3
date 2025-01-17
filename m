Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60421C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfMr-0007nS-3p; Fri, 17 Jan 2025 00:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMP-0007T6-1I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:37 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMM-00064I-LM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:36 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21bc1512a63so34464525ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093453; x=1737698253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUehjOG3PrlgTPgdJIY8hZ6AHJgb7hHIonBDupfXjbM=;
 b=NSQ1vYDaCuBBQhqBMxx6d5ACF1zCv2r822zczznNhOfb4cCSWZQ/EoS7BsXElNvwK2
 vCZdL8qeifFCTSMxL/NpuKnniVuoAyWUAAGMj4Q53JAE4SpetIpiPc99IXPkuDkm3njD
 w/CBaHonq77l7vJvQFCrCkB9OPJrMmGa+xNAHgDmMOr7DWbKEoz/tLN5C/DK5Rv2v5oE
 8NY9CqUgPg5dcuki3n+hhqETsWuaAka0wMApYR5Jd4bkpzCOn772jn7USqc2YZZ7KbKh
 bmhhU+wws32jSbR/2235eVYtFDDrugzGkENbwRL52Qau/1WdA1vhGAPhU0CE1USFaeaX
 JpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093453; x=1737698253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUehjOG3PrlgTPgdJIY8hZ6AHJgb7hHIonBDupfXjbM=;
 b=FqxRNcYjGJjdnOACkJ9Bnou+OPVu+r/Br64+0o5KK2JFuLZ0thsQMeGwnGU1jp0OOG
 AYE+/UIjcvzwifxghVz1VTfMmu/z0kX9iBUHvPlKLZEkEKJ/5irM0A8uOPJx7v7wdnOQ
 UVgDOt3GmKejWtKtA/v3VJuLBEfeDL5bxFU8HWffveZRSnm+hY8porhurkbfrdLgaFc2
 3IG0A9Y7kQQtJz3PrgdbTAGnopsZMZdDlqk1bXQh9M16SyL+wqh5Pjkpc4Z3umgKwnj7
 fp2GUm8p02eOflX6Qsex91uQp91kldDoMuBBIfeHysFv2P23UFBSBdAjDB5KPBGtBdGk
 27Pw==
X-Gm-Message-State: AOJu0YxGSHZv87g8FY8N5jp6V0cb8QgNMxwTx2e3AbTwMzRo6mRt1yqK
 /V2Db4HeXmbP/yo+V4s1J2mQpY2fjOwszwBypuFcCWH3d0Zi11lF6/qBRg==
X-Gm-Gg: ASbGncs78jEIBV6bFDXsJI7d+wzTDK90cW2fBa8AQ+M6ky7amBmntBIMbTNgqifPfA3
 7KUNB1n1B29vAAEE4h3oGclU0GgMSO7+DLtZQ0W3ddKK5+QJc86C2RPrLC4NS+HwtDK4EziET6N
 OmGOAkjI1TWY2yP2WKhJe496fQ9xEEBL7ya6+btOwR3dkRAWBdHpL5JfumkgBqe+6dgLMLFYlp7
 PCXkM1qzIsmD4m+V192jJcpFv16jevQrkT/CFq67CC0Q9uI0NEqttZ4tubrYFWXMxwqjEvMFN5Y
 W8Poj9BZOujq8GQeWGlU47x57EerQ+nvKFqJkHBOE1oKJWwqlXD8UARpWHeB
X-Google-Smtp-Source: AGHT+IEgM2EoiD6P7zeQLFLXcRhLiUfYplQbksOFW4B8XxEJtuOCfG/NJbTa+c6BMPgnznNF2uS0Tw==
X-Received: by 2002:a17:902:cf01:b0:215:5ea2:654b with SMTP id
 d9443c01a7336-21c3553b6efmr27408765ad.1.1737093452998; 
 Thu, 16 Jan 2025 21:57:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/50] hw/riscv/virt: Remove unnecessary use of &first_cpu
Date: Fri, 17 Jan 2025 15:55:29 +1000
Message-ID: <20250117055552.108376-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

virt_machine_init() creates the HARTs vCPUs, then later
virt_machine_done() calls create_fdt_sockets(), so the
latter has access to the first vCPU via:

  RISCVVirtState {
    RISCVHartArrayState {
      RISCVCPU *harts;
      ...

    } soc[VIRT_SOCKETS_MAX];
    ...

  } s;

Directly use that instead of the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250112231344.34632-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9e8876be29..241389d72f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
                           kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(RISCV_CPU(first_cpu)) :
+                          kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
-- 
2.47.1


