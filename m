Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513DCC61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrW-0001uu-RD; Wed, 26 Aug 2026 18:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrU-0001tr-RS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrS-0006fM-Pc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:48 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1578882a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782365; x=1788387165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n+dEv2CXGdQUWUzHVbk1BheHXV911tV5Sryp6N+Qyq0=;
 b=q5F0kMyrLKs+UoeBxHP9TuyfzfX0aW9+igRfi8k23CBMyjTJYQ0sHd0A8cB3fmmrMK
 euY/mU1qg37befL85Zvi8xqH+MBv9FqpmVPh7U6WFGMvwkGF3mrcmCScGFACz52jdd10
 0m1ShRQpf5XmzYLvNrIWeFsqIsXVC+Nuv3bQ5Dk5NRA+bGl9tWUEx1SQDmhQYBjh/1Ss
 FV0bmujD/QhfKBwPVreypRX3q/E+UbQp62u3jObEWHZvaAx8ExfVy4rgrIrO1YREFVp2
 0Ihi53uKfl1+EOtdt+lN2vCINXudHq+nxBS3cZBVLm7ggykFAuBJvoRmWk+2n8V09GSO
 cGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782365; x=1788387165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+dEv2CXGdQUWUzHVbk1BheHXV911tV5Sryp6N+Qyq0=;
 b=UwbIswnbyNx1MD2lqq3R80Z4Emc/656Y/AmAjKLPZrpMvyhIMCfCksbucZrr2M1tt0
 rL0xJk4KjOHmr5GH8/FWwECM1BZGyTWd7yeiaArnhupvAXiL8OutDBQpyuVPHOq8LEjy
 A9nDn4+/YGUq4oAKtqvuh30+MiJBcCoKNaTNRu6JZ9ycReQNdkWoXFUQwAyUVvIQ+Zw5
 VzmEKdjTI01LD7bMlKdFerHr5zesk1J5GHolqbtfKgGezcx4FPayfrzQNIv3ltCDZMAH
 oy9JHETXDw1WCjRXHVGlV9sy27Xb6LtNU3EjQNiytsLwxhb/mdWdjStiON5Xhq3gomGT
 d8Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4xEnXSF5mRr2VrrjRwVflktYfct/1PhftGQGRVaKjeQaXc7RTQW6h55rct+f6ox3Y+mKusLV7/yM5@nongnu.org
X-Gm-Message-State: AFuF++lUkuOCbqIWAfRy1/hcKQ5+jFvLTDzOwRdfH88Fs5IHnbaxbW1z
 nOElMJmm1PQrijgu3KTv/qihND8bAoaIOESJ2trW5ktOAEj4Ur9+0f6H
X-Gm-Gg: AR+sD115R4KRYTF2Oebn3yX2k4LchFwno6xPihTmLSwmxG26MgU2w86q6HmbIgrpEsn
 gOM1mT97HrGUavorPQFPsWUBUp7vZgsiwOPEQkm9/eYwTMM/b/qVqd0pdWuUL1Fy0RCHOjRvl1r
 RLqbEhPiwddERXMGLtDwXa/bqqa/qF30qZYa5DnwhEKy2kX70eVuWZ8/ln/hpk7ODMV+1kacZz0
 QF09dl/RP4sjPIk8J5CPQ80CmuApNE8OGDJzGvIAyOwo8oHr6Gf1s3hjLmx5Usf1nLWYp/5kzQ/
 nfJOh+U4c2ZFYJGJjCdBYtYBPVN3gYpDU5GiH5FqKhF3Ktul2xFABIF9EhoZqyFiTZI5lu2BSBv
 fT6uaI5cEewJ3sYVUac3Ma/IHqDyLgFxLdMyRgXclFnD2JZj264Lo1KdCWb+XEzhTHwEyhoPtTh
 SPy2/W3ShsgyKoBWA7QL7RwJQR0+StflnjwPmm1XbMI6JiLxIe4Q6N+7DofPHMIgdDoZDDhpwkl
 JzM/KkqjAfyLKvJEyq9yXubtMC5V+vZDkAvPy9d4PeIAT+6ywxUjhFEMRiFVNaZV6mhxUn3R6Ug
 xL9k603UeJ8NicEHib7O
X-Received: by 2002:a17:90b:4a01:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-3966d1bae93mr17737731a91.6.1787782364764; 
 Wed, 26 Aug 2026 15:12:44 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:44 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 16/16] hw/riscv/atlantis: Map the SoC through a memory
 container
Date: Thu, 27 Aug 2026 07:41:52 +0930
Message-ID: <20260826221154.54577-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Give the Atlantis SoC a 'memory' link property. The machine creates a
container MemoryRegion, maps it at address 0 of system memory, and
passes it to the SoC together with the machine RAM. The SoC maps devices
into the 'memory' container instead of system memory, allowing
TTAtlantisSoCState to be composed together with other SoCs in the
future.

This prepares the machine for adding other microcontrollers that share
the memory bus with the Ascalon complex (aka the Atlantis SoC), but with
their own view of the address map.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 5d4e4d133bd9..3923308b7c89 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -53,6 +53,7 @@ struct TTAtlantisState {
     /*< public >*/
     Notifier machine_done;
 
+    MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
 };
 
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d2b29ff1a477..b78b4a5ea31e 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -503,8 +503,10 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     ram_addr_t lo_ram_size, ram_size;
     int hart_count = s->num_harts;
 
-    s->memory = get_system_memory();
-
+    if (!s->memory) {
+        error_setg(errp, "'memory' link is not set");
+        return;
+    }
     if (!s->dram) {
         error_setg(errp, "'dram' link is not set");
         return;
@@ -523,6 +525,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
+    object_property_set_link(OBJECT(&s->cpus), "memory", OBJECT(s->memory),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
         return;
     }
@@ -614,6 +618,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
     DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
+    DEFINE_PROP_LINK("memory", TTAtlantisSoCState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
@@ -633,12 +639,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
     TTAtlantisSoCState *s = &ams->soc;
 
+    memory_region_init(&ams->soc_memory, OBJECT(machine),
+                       "tt-atlantis.soc-memory", UINT64_MAX);
+    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
+
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
     object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
                             &error_abort);
+
+    object_property_set_link(OBJECT(&ams->soc), "memory",
+                             OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
-- 
2.47.3


