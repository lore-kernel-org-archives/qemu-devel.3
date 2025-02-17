Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B086AC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwM8-0006I8-85; Mon, 17 Feb 2025 03:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwLz-0005bp-Ok
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwLv-00017M-Qc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c8eb195aso84873555ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780381; x=1740385181; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aEhrJGTrK4HquXpUTZoqEf2aT92LTkcD02ZKWBhuP+I=;
 b=ZlukgPEFBdtottawNOXVXCqXVLERy2Kwj/Pp6mHI2AZ/YI6MwFTt+y0+3x05xQ5RVv
 pSMgPV5bBzgIF1RqNUTZP1ND0hRhtE/VVCsWFfNq75beDtzsUr7i8Mf4XjZD4OnoQd/B
 rNHb917q8Rwq6fObHrYaPfI8UZaLtj0ssy5iuuDfVefijSEANEpgWo8vCAcInyqEtsQo
 L/MKd8yCle3r8C73pDWrvkxKBfa5G+hK4rqoLybJXjJJ4uNSMJ5YCoJsxMiI758N6UWi
 WOoklMx/+VRPZVukEQLg+PG980ePEwnTagb9CmBAMULcQ94t6bnWifXITNMwCWwOLt/c
 g8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780381; x=1740385181;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEhrJGTrK4HquXpUTZoqEf2aT92LTkcD02ZKWBhuP+I=;
 b=VSoGu/QdpR0bYW8VJ/ZfWtoPWyFPb4qmgbdVEYi/vprDZY09ym+9a0PyPgxhG4IDbO
 6UjRH+HM/6x7kIqG2F8qV8kOgV/bRQVoJcVcle+R1yGfaIG/eyHTZTInkdUGdZnRyWvz
 RCsqsQjSJ0PX2mwFpJvm+gD9cuAG3pJuqlkFzWVUU0ldnPScHdEWpmSGMuJoC2w3QryD
 sU8noRwl4KMcuL90ARLYANgaTHXCCxtDWgoiTLjazUzzWm/Qb3RQoiB7V1grNfzsbwwJ
 tgDPobXBOr0hzPECSyMxVuZZc9Hz93qiUxC0NVF2SFk+DntwwcyaPKuYvtbsWAy/5FfY
 EKEA==
X-Gm-Message-State: AOJu0YywVxcwOT3clL6NVXcpahCVCFjlYaUnBv5oJ2RNksKrtn5nflDm
 URHWLOFTWzrOo9K1Y/MsOqPv+ysps62Tu5ztbQOnMnUwxR+01nSxcV65DoNUlMqfCJOzhi5VmOm
 rLUjNAmtItRMgloKnpZf4inEwwNOjsqD3i+UlO2UTvyrdS5nYCVgejVpIH9xW1e5vLhizGLFRW9
 eaKojoMaEtGUR3As05U4ryMYizNefnK/lMc+MlcWYJCg==
X-Gm-Gg: ASbGncsMU/I9mHuJ3HJ+U0jSEeAU2kRhfRBgldNjVU9JPd9wlPciV/HyxGJL6AkwnYb
 XyNU6SRXhMulXaB4vLKybYtqW12chxEPailQcRGRPj+2RKs/41phv5ek9mr3irWZSuCGXzCv8ED
 He2cDF2sY4WSbA351aqviRccqxUzL9FZbVP/l/mnqVslmJt4/GZCLmpEug4rwHnMqMispT2uPCT
 CKACq30k37bX9WnHgAQoilCen/dEekpyvOlJAxBf+FBzy5WyRsAmQ48JXdzz8haSIhm+j8njr9z
 gOGRTo2BRWUUiuLDZ9Egvf/lMmjnppyte/TCe/MgyGpFhQ==
X-Google-Smtp-Source: AGHT+IHImZVpKPU6lfzfJNVcHRO2/kSa1dloFxwbc3nndzw1W877OHvb7T2Zk10LFl4ZWPp8JmC6kw==
X-Received: by 2002:a17:902:ce89:b0:221:183:5bea with SMTP id
 d9443c01a7336-221040d74d8mr150238495ad.50.1739780381116; 
 Mon, 17 Feb 2025 00:19:41 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d5e6sm66023445ad.173.2025.02.17.00.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:19:40 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/4] hw/riscv/virt: KVM AIA refinement
Date: Mon, 17 Feb 2025 16:19:23 +0800
Message-Id: <20250217081927.10613-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081927.10613-1-yongxuan.wang@sifive.com>
References: <20250217081927.10613-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

KVM AIA is only needed to be set when the virt machine use the AIA MSI.
So we can move the KVM AIA configuration into virt_create_aia() to reduce
the condition checking.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/riscv/virt.c | 79 +++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dae46f4733cd..a52117ef71ee 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,14 +58,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 
-/* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
-static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
-{
-    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
-
-    return riscv_is_kvm_aia_aplic_imsic(msimode);
-}
-
 static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
 {
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
@@ -1298,10 +1290,12 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
     return ret;
 }
 
-static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
+static DeviceState *virt_create_aia(RISCVVirtState *s,
                                     const MemMapEntry *memmap, int socket,
                                     int base_hartid, int hart_count)
 {
+    RISCVVirtAIAType aia_type = s->aia_type;
+    int aia_guests = s->aia_guests;
     int i;
     hwaddr addr = 0;
     uint32_t guest_bits;
@@ -1309,6 +1303,28 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
     DeviceState *aplic_m = NULL;
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
 
+    if (!kvm_enabled()) {
+        /* Per-socket M-level APLIC */
+        aplic_m = riscv_aplic_create(memmap[VIRT_APLIC_M].base +
+                                     socket * memmap[VIRT_APLIC_M].size,
+                                     memmap[VIRT_APLIC_M].size,
+                                     (msimode) ? 0 : base_hartid,
+                                     (msimode) ? 0 : hart_count,
+                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
+                                     msimode, true, NULL);
+    }
+
+    /* Per-socket S-level APLIC */
+    aplic_s = riscv_aplic_create(memmap[VIRT_APLIC_S].base +
+                                 socket * memmap[VIRT_APLIC_S].size,
+                                 memmap[VIRT_APLIC_S].size,
+                                 (msimode) ? 0 : base_hartid,
+                                 (msimode) ? 0 : hart_count,
+                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
+                                 msimode, false, aplic_m);
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
@@ -1329,32 +1345,20 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                base_hartid + i, false, 1 + aia_guests,
                                VIRT_IRQCHIP_NUM_MSIS);
         }
-    }
 
-    if (!kvm_enabled()) {
-        /* Per-socket M-level APLIC */
-        aplic_m = riscv_aplic_create(memmap[VIRT_APLIC_M].base +
-                                     socket * memmap[VIRT_APLIC_M].size,
-                                     memmap[VIRT_APLIC_M].size,
-                                     (msimode) ? 0 : base_hartid,
-                                     (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
-                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
-                                     msimode, true, NULL);
-    }
 
-    /* Per-socket S-level APLIC */
-    aplic_s = riscv_aplic_create(memmap[VIRT_APLIC_S].base +
-                                 socket * memmap[VIRT_APLIC_S].size,
-                                 memmap[VIRT_APLIC_S].size,
-                                 (msimode) ? 0 : base_hartid,
-                                 (msimode) ? 0 : hart_count,
+        if (kvm_irqchip_in_kernel()) {
+            kvm_riscv_aia_create(MACHINE(s), IMSIC_MMIO_GROUP_MIN_SHIFT,
                                  VIRT_IRQCHIP_NUM_SOURCES,
-                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
-                                 msimode, false, aplic_m);
+                                 VIRT_IRQCHIP_NUM_MSIS,
+                                 memmap[VIRT_APLIC_S].base,
+                                 memmap[VIRT_IMSIC_S].base,
+                                 aia_guests);
+        }
 
-    if (kvm_enabled() && msimode) {
-        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
+        if (kvm_enabled()) {
+            riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
+        }
     }
 
     return kvm_enabled() ? aplic_s : aplic_m;
@@ -1621,9 +1625,8 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(memmap, i,
                                              base_hartid, hart_count);
         } else {
-            s->irqchip[i] = virt_create_aia(s->aia_type, s->aia_guests,
-                                            memmap, i, base_hartid,
-                                            hart_count);
+            s->irqchip[i] = virt_create_aia(s, memmap, i,
+                                            base_hartid, hart_count);
         }
 
         /* Try to use different IRQCHIP instance based device type */
@@ -1641,14 +1644,6 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
-        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
-                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
-                             memmap[VIRT_APLIC_S].base,
-                             memmap[VIRT_IMSIC_S].base,
-                             s->aia_guests);
-    }
-
     if (riscv_is_32bit(&s->soc[0])) {
 #if HOST_LONG_BITS == 64
         /* limit RAM size in a 32-bit system */
-- 
2.17.1


