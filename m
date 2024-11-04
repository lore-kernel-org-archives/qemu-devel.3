Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECBD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krK-0006Oi-UQ; Sun, 03 Nov 2024 19:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr3-0005N9-Fy; Sun, 03 Nov 2024 19:22:04 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr1-0002jw-9T; Sun, 03 Nov 2024 19:22:01 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso2512910b3a.3; 
 Sun, 03 Nov 2024 16:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679717; x=1731284517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjrKzQxSpQ20SJEUNd7c887GiOBsc4dW1KUxIdtg7vI=;
 b=SnGs5zbu6ZacGjy+8Hu9FtjH2H1L3jJZG4VOqdQswsesS0F8JDl9HYBvS3jNJyBRwJ
 1nPMArdFAQrEHvS+NGl0GVTCnJVk2B0dBXPwlsaoGNfMezO2wXdam9LxE+VTRC0FwcBO
 WtaOa4/IDiQRGrUDfVIH+azJGl9csSG73GvmTeGeitxIpyHkBrA4rGFcqgvGW5D8TK+/
 NSRmMFqew9YvNPhfTH6gHGzid+sVRQdOYPFIcn2Nr8HYoP+HfCumdFDGrH0YO1mKacfF
 L2TtXgCm+4T/8U9HWhIFkYwJQshCKxD11Sp/RNnMIhV3PgX845Ldg0p9yW2An/1tQs+c
 EDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679717; x=1731284517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjrKzQxSpQ20SJEUNd7c887GiOBsc4dW1KUxIdtg7vI=;
 b=REK/LWt8UXJhb+g9R2M9ZvQD7EHT0iR1AqRMh84bt9wsEKvYI7NRn24MbldetO0zZx
 59nQTfsQYi92gfao3+3Hyn5Ipzt9fsXV2L6h2iji3zl+BFLJewcTOV23nQhRVAE4MJ++
 OhmI/wIqXrJtFK/RS2h8l/oagghY9UYmvTnMGebnFe9Dud6DweOE4S01L4WagXXGrBMA
 vhcNAaGQoB5yFefIca9kGcDdz4lsSj5XdcJXTNvCXpuKo2KoWqNN8rSLYZuFRkpRfs+C
 XQpAGWMMSu1O8abRcxPHDEVCShKTBHG05gbRp17lj4eco0OiHkHHolNvX3mcU+k8ANR2
 FMYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5SHiT38/9PC5MHaRdO3Yrokg7MwEx1oW7to453Egyspj/wemlthQNh4Nv838f2ODIWdJJ/qQ25w==@nongnu.org
X-Gm-Message-State: AOJu0YxtLTVr5N7famX+bU+IMS2bjsx6j6GDbNttI0TrdBIPObNI64O4
 cBE2e7D5MuaoLzbUYxdG2kwsmUXu6wA1/pYtsZTN55BTQzMcQoLvs9hS1g==
X-Google-Smtp-Source: AGHT+IG/KHQNSr8NID9bxbR/QYbTbrey8O/A5mNKLYKasroBxemDPgnWuT5T16b054v9I7yCmg9cOA==
X-Received: by 2002:a05:6a21:1690:b0:1d9:3456:b794 with SMTP id
 adf61e73a8af0-1d9a84bcdd6mr45310503637.38.1730679716499; 
 Sun, 03 Nov 2024 16:21:56 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 46/67] hw/ppc: Implement -dtb support for PowerNV
Date: Mon,  4 Nov 2024 10:18:35 +1000
Message-ID: <20241104001900.682660-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Currently any device tree passed with -dtb option in QEMU, was ignored
by the PowerNV code.

Read and pass the passed -dtb to the kernel, thus enabling easier
debugging with custom DTBs.

The existing behaviour when -dtb is 'not' passed, is preserved as-is.

But when a '-dtb' is passed, it completely overrides any dtb nodes or
changes QEMU might have done, such as '-append' arguments to the kernel
(which are mentioned in /chosen/bootargs in the dtb), hence add warning
when -dtb is being used

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 795acc289f..f0f0d7567d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,21 +736,27 @@ static void pnv_reset(MachineState *machine, ResetType type)
         }
     }
 
-    fdt = pnv_dt_create(machine);
-
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+    if (machine->fdt) {
+        fdt = machine->fdt;
+    } else {
+        fdt = pnv_dt_create(machine);
+        /* Pack resulting tree */
+        _FDT((fdt_pack(fdt)));
+    }
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
-    /*
-     * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-     * the existing machine->fdt to avoid leaking it during
-     * a reset.
-     */
-    g_free(machine->fdt);
-    machine->fdt = fdt;
+    /* Update machine->fdt with latest fdt */
+    if (machine->fdt != fdt) {
+        /*
+         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
+         * the existing machine->fdt to avoid leaking it during
+         * a reset.
+         */
+        g_free(machine->fdt);
+        machine->fdt = fdt;
+    }
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
@@ -952,6 +958,14 @@ static void pnv_init(MachineState *machine)
         g_free(sz);
         exit(EXIT_FAILURE);
     }
+
+    /* checks for invalid option combinations */
+    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
+        error_report("-append and -dtb cannot be used together, as passed"
+                " command line is ignored in case of custom dtb");
+        exit(EXIT_FAILURE);
+    }
+
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /*
@@ -1003,6 +1017,21 @@ static void pnv_init(MachineState *machine)
         }
     }
 
+    /* load dtb if passed */
+    if (machine->dtb) {
+        int fdt_size;
+
+        warn_report("with manually passed dtb, some options like '-append'"
+                " will get ignored and the dtb passed will be used as-is");
+
+        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
+        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+        if (!machine->fdt) {
+            error_report("Could not load dtb '%s'", machine->dtb);
+            exit(1);
+        }
+    }
+
     /* MSIs are supported on this platform */
     msi_nonbroken = true;
 
-- 
2.45.2


