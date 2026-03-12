Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F048BFED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xii-0004U1-KJ; Thu, 12 Mar 2026 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xig-0004Ta-ST
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xif-00042n-7V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ae50a33ff8so4837515ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289939; x=1773894739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5bWYpDFMhGnOIHvbiRtGBp6ev0UQZkezNXRRwkOVA0=;
 b=ZTep3PSPcxvTlHjztedWKx8epejjnU2dEmSNDZXiYIn2vpQF9D4V8m11OX3OpDq88p
 /qaEHQ8/u6BxwJPw02hixlIXXb0FjUHiVW9PYJNkPiXTohVOOUUKJcQNW8GBejWIWZtK
 AXHqKv4apbW7+ahH8JkDd9+/smArWJbG3t08IvcAN5XgLm/96AZttTL+iEpqfQ0TYV2o
 gQYfIYcWM4D2EmZnZZvi5dT431HY4EYZ+rY99gj4cm29M2yH57q4N9A7jsY+s/paL0b2
 Gw7aWgnTBMaS1X+ejPR2P00iWtIoo7MHVG1CoWEMB3TgWXpykNCZh0GXdEAvHTcg3qOt
 phOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289939; x=1773894739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5bWYpDFMhGnOIHvbiRtGBp6ev0UQZkezNXRRwkOVA0=;
 b=tkz9kqdttiXvdZHM1m5ZvfPR15vloTbtZkrjiztgvinDJXm4MI7bTlm5teFSTR0O8v
 3ASBIugepSMUWhLkI0BGlxtqcwW7+/+ZKYEVq5tbXc0d5Md77qwbe15fPdqWy4FIuywU
 HTngKAVuoLB5JlQFfQ+jAAtk+M6+oZ1lRfRr3qAmFxIjgJPZiZA2M/knW7rIORGBi3Cq
 F2m/m+h/O4bm0aFQHy9k8SdNnp1vrHEyUs+ZIIOpR+pQ7Q3nHMrHQyfVk6yIeMSSDkVC
 wwyKRt+4ztXWf8Oefp/o+JvsQLGcuIPa3T/HfTExRcyEongopOOILNaEvK/MnSy1Hcsf
 8dgA==
X-Gm-Message-State: AOJu0YwJk984nI8fonmMSKf5xxtzn4QZfnwoC6FskC1hDsoTMXgma8kl
 xEHVEWC8JePhEfBuN0PBqdZvR6AYgId/S0HckbFnSwhy2NYzqNJhinEsVrOjVXZy
X-Gm-Gg: ATEYQzw10Q9D0+eAnSwodzSc03HsJp6W1V2eyPA9hutH7ZJm2pOxxFLPVuInKqMJHHS
 jcslSwEn1VQxuGl721m76EspHCrcJR+IOYWpCyc/5boV+9ylpPOQrYyme33Q5LlBrII4xcSolNS
 NumMbFa23EqRpD3oNgfrtsdI+Fj8hgIEz4hKYPYgL9gZ3VLtCvLBK40kavus1yzdURuBUylpXOt
 gkNCvxmnnCRGxgpkoIIssCmzfB6ig8ic5e2j7VrRVGcYwSMTtyMTxO6SK+i6F7Ko7qdk8M9nlD4
 oiuTXKPxxO4LNy6/5OoAfXAvbuLjhzESTpHPfydsOE3w9KxQZlAx68Ckn+lpcupjTZ/EfpTqoXa
 BtnZUGPX3Dju4crkZPIzOQdiV6fmRTMbvmdN+WW2ytLW8IL3uAXllW84gNeZWYsPPgM77B1tn83
 z3TNTh0v+eF334CbWGN33WmHk25pm4O01GJmQCmrHe0w==
X-Received: by 2002:a17:902:d541:b0:2ae:8077:b1c1 with SMTP id
 d9443c01a7336-2aeae89289dmr46255145ad.30.1773289938823; 
 Wed, 11 Mar 2026 21:32:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/7] hw/riscv: microchip_pfsoc: Don't call qdev_get_machine in
 soc init
Date: Thu, 12 Mar 2026 14:31:53 +1000
Message-ID: <20260312043158.4191378-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-riscv64 -S -display none -M virt -device microchip.pfsoc,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of setting the CPU
num-harts in the init function let's set it in realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4ff83e4940..73cc229c54 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -143,7 +143,6 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
 
 static void microchip_pfsoc_soc_instance_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     MicrochipPFSoCState *s = MICROCHIP_PFSOC(obj);
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
@@ -162,7 +161,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
                             TYPE_RISCV_HART_ARRAY);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
+    /* Set the `num-harts` property later as the machine is potentially not
+     * created yet.
+     */
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
                          TYPE_RISCV_CPU_SIFIVE_U54);
@@ -204,6 +205,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     int i;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
     /*
      * The cluster must be realized after the RISC-V hart array container,
-- 
2.53.0


