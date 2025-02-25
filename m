Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57CAC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL3-0002Pv-Gy; Tue, 25 Feb 2025 13:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ5-0008K5-GQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:32 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ2-0002CL-7r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:22 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso51940075e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506718; x=1741111518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ywe1k/zTO8EsX/iWW8wptwgphl5GHzPa/yPNvAW+RHQ=;
 b=kEkQlo0oIKWac6eW6Dq5uSuRh5vXz6/kbxJzRax017j91HkX9glIux34u9kESRyUVg
 jmlZElXzL1IT20tQC3t7J07dVYCecHywHYlEu88F9KcPqUdW3byUBXFK8qq+fRJ+O0TO
 41Xv3/eXWwPbK+fcXiRrbCpAdiyX7kn30NXmmu8t7qqbr4rODhXksfuPdwY19rSLfcT+
 z7faJTjua8Y8n6W/vbpOJXFQ3NFNnXPgTkNBYizQD8wQ9xcOhw6PpaiwypCFK2JE6PJl
 XhX7jLmXC1L+ltLz9PO5ciTYaNt0oQkvwM7rilgMM4dH5s0ICjCZRJKH3EfzGtk0gdgE
 BRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506718; x=1741111518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ywe1k/zTO8EsX/iWW8wptwgphl5GHzPa/yPNvAW+RHQ=;
 b=EQkdhcwX7bNGCUZIgN5Y/6+17B02aOmSdMNW2bF7i4Gt0MHqGqLAiVpVWXiSI+zxiN
 PdEDx32JJJb2CgFf7ik2BIpmd99mNDFAzz/TMrkBSPW5uu61/shsom+g2wSbg13/pgwv
 RcxlEUoCesQZYv2GJy5zUFy4gFa+V1g012HTGOKsjhg8kWqiJkYmlN0JV1JH7u81AyAU
 4MXpku8pnOfRtdkMMJLYTQPWyenmqgNzF41WBE4itgNgK0UcJYVG5WEZBcWDsOn4Je9i
 Q+jqZsLZpBvLGg02a1g3jD3XWIin6rQEhNYjhY92M5y10TxNYoMekhZZaUP1Fq/SzN5f
 TPKw==
X-Gm-Message-State: AOJu0YxMw+GkW/k12B1nMjAL7Ktq6lOHu5NFwbSh67GY+nbCzjyhXKPe
 TKDWayow1lDBnbaPzYTC6OK3AvCsGqVJw6TQQsW9iIXXXSAMOsQ/Y3tcIz5Q/j61Om0O5HFahr3
 4
X-Gm-Gg: ASbGncvgRHkm0TsrD9Y/MKmcSecrlXQ8Lbq/YdMQngWDVRlFX2JPB6tkdUighyKPxQj
 e483KkPtAwjBts14j/XJF207dzba8y3gqf2DwP4oETXy2ylIHiyr0yyCGXMI9KupY9Sj1NtQTqU
 WBiuDTEtTVL6N8piu15YomGDPbQPdtM/fXBc+szeHe9bCqPECs3VEzEUOlqnOAtHDJkcHYPlK1Y
 lY9dpqwW/xseqwaRT3YjYRF81J0hDcRfoa0HMYWdVSqwcvbqWvp+kbXOLL4O9sOqCGVMAJoVt/l
 WqM9I5e127lfT+PG/06+crEGvkLQa1il
X-Google-Smtp-Source: AGHT+IEsrQLUNeBqnOLMkcYNEGiqXDLqUmia4pEEJFSSLudibKC0v22L5Sxk4gaR2C5gCeSs8zmLgQ==
X-Received: by 2002:a05:600c:3148:b0:43a:b0ac:b10c with SMTP id
 5b1f17b1804b1-43ab9027824mr4378505e9.26.1740506718342; 
 Tue, 25 Feb 2025 10:05:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/43] hw/openrisc: Support monitor dumpdtb command
Date: Tue, 25 Feb 2025 18:04:30 +0000
Message-ID: <20250225180510.1318207-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The openrisc machines don't set MachineState::fdt to point to their
DTB blob.  This means that although the command line '-machine
dumpdtb=file.dtb' option works, the equivalent QMP and HMP monitor
commands do not, but instead produce the error "This machine doesn't
have a FDT".

Set MachineState::fdt in openrisc_load_fdt(), when we write it to
guest memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250206151214.2947842-3-peter.maydell@linaro.org
---
 include/hw/openrisc/boot.h | 3 ++-
 hw/openrisc/boot.c         | 7 +++++--
 hw/openrisc/openrisc_sim.c | 2 +-
 hw/openrisc/virt.c         | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/openrisc/boot.h b/include/hw/openrisc/boot.h
index 25a313d63a1..9b4d88072c4 100644
--- a/include/hw/openrisc/boot.h
+++ b/include/hw/openrisc/boot.h
@@ -20,6 +20,7 @@
 #define OPENRISC_BOOT_H
 
 #include "exec/cpu-defs.h"
+#include "hw/boards.h"
 
 hwaddr openrisc_load_kernel(ram_addr_t ram_size,
                             const char *kernel_filename,
@@ -28,7 +29,7 @@ hwaddr openrisc_load_kernel(ram_addr_t ram_size,
 hwaddr openrisc_load_initrd(void *fdt, const char *filename,
                             hwaddr load_start, uint64_t mem_size);
 
-uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
+uint32_t openrisc_load_fdt(MachineState *ms, void *fdt, hwaddr load_start,
                            uint64_t mem_size);
 
 #endif /* OPENRISC_BOOT_H */
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 0f08df812dc..72e2756af05 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -90,8 +90,8 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
     return start + size;
 }
 
-uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
-                           uint64_t mem_size)
+uint32_t openrisc_load_fdt(MachineState *ms, void *fdt,
+                           hwaddr load_start, uint64_t mem_size)
 {
     uint32_t fdt_addr;
     int ret;
@@ -111,6 +111,9 @@ uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
     /* copy in the device tree */
     qemu_fdt_dumpdtb(fdt, fdtsize);
 
+    /* Save FDT for dumpdtb monitor command */
+    ms->fdt = fdt;
+
     rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e0da4067ba3..d9e0744922a 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -354,7 +354,7 @@ static void openrisc_sim_init(MachineState *machine)
                                              machine->initrd_filename,
                                              load_addr, machine->ram_size);
         }
-        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
+        boot_info.fdt_addr = openrisc_load_fdt(machine, state->fdt, load_addr,
                                                machine->ram_size);
     }
 }
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 7b60bf85094..9afe407b00a 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -540,7 +540,7 @@ static void openrisc_virt_init(MachineState *machine)
                                              machine->initrd_filename,
                                              load_addr, machine->ram_size);
         }
-        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
+        boot_info.fdt_addr = openrisc_load_fdt(machine, state->fdt, load_addr,
                                                machine->ram_size);
     }
 }
-- 
2.43.0


