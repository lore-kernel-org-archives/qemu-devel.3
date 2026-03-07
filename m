Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E9FC9EF9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 12:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyr8x-0005UD-Ks; Sat, 07 Mar 2026 07:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyr8t-0005Ti-Ry
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 07:52:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyr8r-0002UJ-SD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 07:52:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so117094815e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 04:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772887944; x=1773492744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ag6+elzpX6KdCT6AK+kx65CXgTT3Bx85wj16Mpz62kw=;
 b=xMxEJ4ezn/Or3jKrrDZTo9/N/ap+UN4nJTFw03yCOoW+M8xERXgM0/DZPnn/JVUta2
 XwYihyLu+NTZBtMIHZMM+d0MUe5VojhJkBY4f7jCrFyZ9t1hx8HpB8BEqIe1muacS6NS
 a4Y/uRkQHFnvUSMZ9UIIEW9bXDKXmg3z31lUgdCY+72YBmj9uTEmhAE0zzQ3YyHafiHI
 0YLmAyK3sQqrMerKFADyKHtYDkNh3puT77GRrzCp4xBHQDavoYirbo2AZGJk1k6mae2H
 EsnSuNHKDSU9Ys7NekPJ8hKtV/cPoCtAalngauBV1kV1cj9C5L8oxyLXisjhUTs8w/RK
 ZO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772887944; x=1773492744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ag6+elzpX6KdCT6AK+kx65CXgTT3Bx85wj16Mpz62kw=;
 b=SRDdUAc6+BXYe6gxIeUGrkybEosh9JRrIeOMcaiRD/t6sh16Gc9eexnq0reXMydFPz
 wk1SrRM/fla4DT2B5UnKP4Rw5l9rUD0TX4YoLaC+GT3ymwyd4D6lGtxL0vytFZbpk7iT
 suZklDQHLMmkT4Jf9GJFXudI5Q3uCYJA39R2TI4QlnDaZQyGdM26HQ664QDmXBoawkQ/
 qI0sVX6tQ/xrjZZM8xYLRH6aipw+icug3wEUKs413ebMx9ApbJBX/m6toMx/9UoQYIS0
 j+OowlZDTpLmnBALm4vZ4HmOg4YRhgq2yW7kKlSvYv7iMiatNMxOHAt6e+5EjfijD923
 pEzg==
X-Gm-Message-State: AOJu0YwbTDT000q+pUAYo4exeTU/pq3WL6S0BNvLwGbA7jJ70iXUiqoj
 w25PxDLc6qI180BMguCHHjXZLmD9p2M5OlyTq94Sxp2cxoGJHxM8uVHxX4lbqs8DimwF8pz+LKr
 9Z2Gf
X-Gm-Gg: ATEYQzzK9Vh2d77Zaaf5xkKnqM8p8ZGaJp67Ybkjw24RVeH92/T3ITA67pgzoc4Nd8n
 TC/RoxSmvYezWZWx9DuuFBDcdyJNeWBkeWXXSz9fq1yHJP4/4v6CnF5Dv5WOaW3mfbyDb08XQ/g
 zr+3psaU7VtpdRqJ1vMMM0K3u+QviuRLoCpDwxnv9G/pN0LsLip9mQ3yhw7M7fLhIDdWk8kMHzW
 Cl015PnwPMEISZ0Cbjqfck/C0DU+eckgLjo7H726/8310IUgN9bvgqFHjgQTDCVcKSvgjHynWWx
 opLgBoNWulTFms7KFffbXee8xjtcPUM3QgWDnT2NKOaIQT2kGwxLk+DqkLZqbolLvYA9qVrWd+H
 cSnjNeOuTcXJBjbKH3c2p6qEPH9UW4PASqwb6IT/glM2W/lqdqFGjZHtGSXBPARaay+Di4ZZwTl
 jGOFaOns4jmMl1ESPHO+jGHI4Dn6+gICSeLjW3nrf2SnlLuTcgmObyOK4qb/SQyboDnMj+YnsbQ
 th7LRgK9B1qbBwRYbh1bgkqgqTE8Eo=
X-Received: by 2002:a05:600c:a41:b0:485:2c61:9459 with SMTP id
 5b1f17b1804b1-4852c61bcd8mr47371795e9.8.1772887944255; 
 Sat, 07 Mar 2026 04:52:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb27a20sm395332455e9.9.2026.03.07.04.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 04:52:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
Date: Sat,  7 Mar 2026 12:52:22 +0000
Message-ID: <20260307125222.3656140-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The riscv-iommu device makes various allocations in its
instance_init method. These will leak when QMP inits an
object of this type to introspect it, as can be seen if you
run 'make check' with the address sanitizer enabled:

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x5d8415b6ed9d in calloc (/home/pm215/qemu/build/san/qemu-system-riscv32+0x1832d9d) (BuildId: fedcc313e48ba803d63837329c37fd609dd50849)
    #1 0x75c0502f1771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5d8416d09391 in riscv_iommu_instance_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu.c:2463:18
    #3 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #4 0x5d8417104ee9 in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
    #5 0x5d8417104ee9 in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
    #6 0x5d8417104db1 in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
    #7 0x5d8417106506 in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
    #8 0x5d8416d16a12 in riscv_iommu_sys_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu-sys.c:199:5
    #9 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #10 0x5d841710661f in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #11 0x5d841755d956 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

(and other similar backtraces).

Fix these by freeing the resources we allocate in instance_init in
instance_finalize.  In some cases we were freeing these in unrealize,
and in some cases not at all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 98345b1280..225394ea83 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2479,6 +2479,18 @@ static void riscv_iommu_instance_init(Object *obj)
     QLIST_INIT(&s->spaces);
 }
 
+static void riscv_iommu_instance_finalize(Object *obj)
+{
+    RISCVIOMMUState *s = RISCV_IOMMU(obj);
+
+    g_free(s->regs_rw);
+    g_free(s->regs_ro);
+    g_free(s->regs_wc);
+
+    g_hash_table_unref(s->ctx_cache);
+    g_hash_table_unref(s->iot_cache);
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
@@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
-    g_hash_table_unref(s->iot_cache);
-    g_hash_table_unref(s->ctx_cache);
-
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
         timer_free(s->hpm_timer);
@@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
     .instance_init = riscv_iommu_instance_init,
+    .instance_finalize = riscv_iommu_instance_finalize,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.43.0


