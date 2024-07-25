Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B32C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JV-0001P7-1r; Thu, 25 Jul 2024 19:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JK-0000kl-P6; Thu, 25 Jul 2024 19:55:50 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JI-000108-Sj; Thu, 25 Jul 2024 19:55:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cdadce1a57so315705a91.2; 
 Thu, 25 Jul 2024 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951747; x=1722556547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHlxYwrr7y+TDyTGITO+2F55IlAj3JG/hAH0hQ7ZGIo=;
 b=RhopzTawGpS5hI+K+//AxzvaLDFW3JvYKP0+PJchQ01hmlhCKTP3kQ9O9T5iftb1jF
 fhPGu9IcCOZKemZtYpu+uPfXoRsHrbXaMyWAX4O3tSSWOk9DOc4rJpsob5TpV5W71d1q
 c2p/JM6G6t4mTL7y0pifv5SIlfM3BHrZ+hOFG35DX0APtBcpEI8K32I9PqweUYUIthqc
 sq2yxofn25p34dzrYfgn5ldkAkVxs2X1Kk6eb+bNaVgzu7ccpJxcFQ8uhCJExqIZtztD
 E0VQvCH+VzCcSuLjwAwSBbylAKSHnTCoaP5yIvKpdnJvHoqveX3Wj4no1Y4HHZ8AYJjA
 9a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951747; x=1722556547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHlxYwrr7y+TDyTGITO+2F55IlAj3JG/hAH0hQ7ZGIo=;
 b=eWPZN9tC1x58KWW7+6G9CwrojLHtobh49zhnEBgaFaGXoK5dypx6VnFGmEWrv/5dEj
 PjqfeEf9vz4H8LHSCNHn1IS/n00Bkf3LfXasSxJoAGhSIg8+3xXxNm0WGccffWnxWUgy
 iszUMHua2bZ6zeFChc2zqhKNyvSUhtYzp3LIKcLQrt/XPz9I8tVTOwQNDDoKbpD094Zx
 ePBS+5JLFQj4HYgd7i6ebKVg0g2hy6Om/un6OFTvH4gbeLxkPV5NBCPWHnT3ADHZ8VJg
 sI9zFxy0ukzx7JDjar3FrwZ2K4qOEpQvJPqpV4Y34d6DxbDJ4h7cM5tal9IdIQNXn/aB
 xrwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeKWoKGqLdGNVJ0CKbaLU5XhyDmuieO/TZ3L+zM9CcsKAn5Y3V9LkQhP+o6T88mP5MqASScmEftt5gGBljUmdbdSiA
X-Gm-Message-State: AOJu0YzzZqUXG8ht9tzwIttng68DGJRbOVoIKkb7JjPsi8QrNmngb8xk
 uO0ZnpgRzgKqRgXPqAQGCcBhMuHAJL/MgpFo1HJfumlueMEI77P6DbSk7Q==
X-Google-Smtp-Source: AGHT+IGXn8FhUIfY7ycEyTXoiBdJro6SpQOyF4+iSTIa9kfsQlYrJIesUFgZbO0UTLk/eC7vdlw3RA==
X-Received: by 2002:a17:90a:bc8b:b0:2c9:a015:ac2e with SMTP id
 98e67ed59e1d1-2cf2379fb79mr4925216a91.14.1721951746765; 
 Thu, 25 Jul 2024 16:55:46 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 22/96] ppc/pnv: use class attribute to limit SMT threads for
 different machines
Date: Fri, 26 Jul 2024 09:52:55 +1000
Message-ID: <20240725235410.451624-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

Use a class attribute to specify the number of SMT threads per core
permitted for different machines, 8 for powernv8 and 4 for powernv9/10.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c         | 12 +++++++++---
 include/hw/ppc/pnv.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 91ff1be21f..a84e0e0e30 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -899,6 +899,7 @@ static void pnv_init(MachineState *machine)
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
+    int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -997,17 +998,19 @@ static void pnv_init(MachineState *machine)
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
-    if (machine->smp.threads > 8) {
-        error_report("Cannot support more than 8 threads/core "
-                     "on a powernv machine");
+    if (machine->smp.threads > max_smt_threads) {
+        error_report("Cannot support more than %d threads/core "
+                     "on %s machine", max_smt_threads, mc->desc);
         exit(1);
     }
+
     if (!is_power_of_2(machine->smp.threads)) {
         error_report("Cannot support %d threads/core on a powernv"
                      "machine because it must be a power of 2",
                      machine->smp.threads);
         exit(1);
     }
+
     /*
      * TODO: should we decide on how many chips we can create based
      * on #cores and Venice vs. Murano vs. Naples chip type etc...,
@@ -2490,6 +2493,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 8;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
@@ -2514,6 +2518,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
@@ -2538,6 +2543,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b136146..1993dededf 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     /*< public >*/
     const char *compat;
     int compat_size;
+    int max_smt_threads;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
     void (*i2c_init)(PnvMachineState *pnv);
-- 
2.45.2


