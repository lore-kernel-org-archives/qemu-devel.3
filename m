Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D1C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MM2-0006Sw-L0; Fri, 04 Sep 2026 01:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM0-0006Pm-Hv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLy-0001IZ-RT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84e27035206so481695b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499241; x=1789104041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/D7yhKa4OqeSFN40OQSvYMiA0aWxSRcj9I0uxSn48hQ=;
 b=Xka5mg1TUSFhvkn25eQZWLHxpOEiNSPnjm5caJ9ohxK1Ul9AvctlU8BSLJdJJvyQ3S
 Ap/KrMXFALjQv+EgerNAb3Cz/qEQZGA/YVsF/oM24CV7Q1fNngNHXTN6Fz2tRanQM9tV
 /XJuWR1aCMRJQJlwWjOWTB0U+Dfg+Axetaa6o+9NiWPWuwQa3VoDuxiF9qXCaN9W86al
 uKx/ajv2YMTgPkQGJURWoZOrx6yecWlVjOv5dAMZQSwlVWvP1/jhU2L0sfNsKDhPKHIW
 LEHLOTNegifFLX5WrAfDtRvyz4qtAtnpCwYIdJwAZhwgnbD+idBWkMJkkkksx4KnsPSr
 GJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499241; x=1789104041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/D7yhKa4OqeSFN40OQSvYMiA0aWxSRcj9I0uxSn48hQ=;
 b=R7U+qSaRkT26W/LwNguMbKN5RurKchkyXWSLd5S1KG5T7JDMVSfINKLXmbKkpsy5nI
 jtqisMf58gZgb1rIc6MkWrqG9mwVUzzDn5Br9nDo7wsEHVMc44VEftbceqB/HU/OnF4g
 w7So5n9ZxOLmddzFUX2C8MyJfK8hYcZogvCT6bkZx6Pogoo8UYoLcTGmo9iBn51Uis4z
 ULWKS5N8ftmrk2dA+k2jWzh6qzBGf7yySe5f4rdbFlaha+W4PNaOtWUJ+ANB53yc8+rf
 u7H5IINdOGfn/juRqUc1VQ8bYDPG5lWIH6qNBN0HqoAoAL0Ux+kogVfQ5JYEdI3wqnmc
 513A==
X-Gm-Message-State: AFuF++m3XnrPWMxxTRdTvLuITsWUgnk6/lJi10APJUAV5Jzc1CRzCJ2+
 Cgzp+YeAhmp3Isi+MEAIgZEhnFZ3QBTubB2CoxgsJT9cD3mCj0e70p8y5CjBVg==
X-Gm-Gg: AYBFou15fKt+7eFutouRb6pnxPwLXeJXHMIFObGirF4UKYz6b//pItNtSal5bDjI6rM
 ZIP7sKGhsOAPCcAnzurklRPsV2bE3WD+CDJl1Bl5fXGRuwcJKbnglP0LNSF7ghCY5/i6PyTrxq7
 pXyqrAcrrfape53t1b/M4CzAV2YYVFLr06bLDHFi6YnFHa1j4e/0udtFaUIKdnLof4hGOAosD+8
 WD1H5jz/Qh0TgiC8gHrsqTjPRPTOvID73oYFHH9WjjSqf5dlUagTjniW09o8Y8P1x4SsKjUS7kZ
 lLMAtbv9Qo1ju4FEuUj0J1v1vB+FTMngzcy3ViLV9zBP+raJjT90FA379rcWDV9svBqf9bj9WJ/
 WgCuJVRJs91YdaxMQWLsyyftrgDkyq+XVwIfmCBBlTAJ4isoWqj4uSlHRyFYzS8UXrQFCEmgmtj
 xq8Fe6pCCjMg8WE6xwMaAcNXptfVbOqf6SdA/YyTpJIMFoulRHHR6Nh22tJ3aRPqzfgFSfyTxNc
 H4Bl5e327zQOYU7MMQ=
X-Received: by 2002:a05:6a00:1950:b0:85c:3922:25d5 with SMTP id
 d2e1a72fcca58-8616aa68194mr5468737b3a.21.1788499240863; 
 Thu, 03 Sep 2026 22:20:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/47] hw/riscv/fdt-common, virt.c: add riscv_create_fdt_flash()
Date: Fri,  4 Sep 2026 15:19:11 +1000
Message-ID: <20260904051943.799041-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Add a common helper to create a cfi-flash compatible flash subnode.

This change only affects the existing 'virt' board for now but it will
be used by the future 'riscv-server-ref' board in the future.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260828203918.350131-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  1 +
 hw/riscv/fdt-common.c         | 12 ++++++++++++
 hw/riscv/virt.c               | 18 ++----------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 371971d79d..b422da6aef 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -38,4 +38,5 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            uint32_t cells_size, uint32_t ndev_sources,
                            bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 3a8da03cfb..6fcc1ce21f 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -283,3 +283,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
                     fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
 }
+
+void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
+{
+    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, flashbase, 2, flashsize,
+                                 2, flashbase + flashsize, 2, flashsize);
+    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ef97d04031..fec5f6d17a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -866,21 +866,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
     }
 }
 
-static void create_fdt_flash(RISCVVirtState *s)
-{
-    MachineState *ms = MACHINE(s);
-    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
-    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
-
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, flashbase, 2, flashsize,
-                                 2, flashbase + flashsize, 2, flashsize);
-    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
-}
-
 static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -1042,7 +1027,8 @@ static void create_fdt(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s);
+    riscv_create_fdt_flash(ms->fdt, s->memmap[VIRT_FLASH].base,
+                           s->memmap[VIRT_FLASH].size / 2);
     create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
-- 
2.55.0


