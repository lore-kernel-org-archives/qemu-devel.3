Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9493CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7zU-0000q2-IA; Tue, 21 Oct 2025 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7z2-0000GN-4k
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yx-0000yY-M5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so34539565e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036277; x=1761641077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiNDg4LVvxXZPHJPsAi2okquB/BtvFBYXh1pXELbRqU=;
 b=tMygp0z3nGYfqjltQ68kba0mh08AOO9wF2JIDVuvbFo0uEzQTNkm66LVvb7GCjQAlR
 ePYL1LEB0fDzIP5EQMexqQGZal+3AGzL+6woGPhvHpO3efXnecuzETSvqKy4OBU4i6Ey
 NOlmTYE0xjzsiNyI14ZqSDOS6VZUFGegXC8HRfsom0Gbt0nidCFtfk/t8YtV/khGp4Kk
 rDCfdZys4vH0He/SyRvYRwyCUVeVOpCXqKK068zrGCBIIUfg33v04eSCwk4/DKm2/yei
 R4GuG2Gjr1Hu/GFz1LGq9MHUhzlTkrQ1TXZDfPwwEkr9sWn5eGAJypB4UTGRJs0OVL8L
 Un9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036277; x=1761641077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiNDg4LVvxXZPHJPsAi2okquB/BtvFBYXh1pXELbRqU=;
 b=qmuae3w/Q2zrZ7vIyD0iLOm/7L2RDqlA2jegpnQZe9P3qDjrdZBS6uWcTlERrx+WMb
 x7e05jHjvIl9hRJ2xe255tAo0Zedkr0ouIEpSot7os8PqAgTzKbuPpLJCTsyzjuF4HtP
 Q6YLJ3t+cE+JCovcSG3VWKC5Ntj8zEFHct9NM9veXjUK6RHyxKTMlwo9SdUCeWlZhAut
 uXY8+DrukvBbzqlX9EpGI7bogF2FvzG4nii5l2D9fFA+t5AJx2UJQN6oe4P79YKEibWJ
 jZFNot29Attx/ZbW3KTr2l9Le2LXVPMQJVnkM4WuR3TqpCahdNdTIMdEyf8s/4DU1BDF
 LKgg==
X-Gm-Message-State: AOJu0YysKSxk/T8Gf1tEZHuvaR0fLLlYAGDjH5gh2IYrPkJqMEoKrHyw
 f5yQ8h3s8HLWei564C+sOaM1UomqG0CfFWGwTm8uDb+sX8ZLRYrrolyEzugctMg0ZCZtwt/GTSW
 3sgZhvuQ=
X-Gm-Gg: ASbGncvwTrrJbqzEuhCSRBVU8DyE9AhAdux2KjHMfdh7yeYBOGYIsEeVkeR/vRUe0ZT
 1fNLwiGlC4myzWxmVAaSAPKJ1IrDrPdgfrckj2liabkWiL/40/5MmC/bRM29OOBY0tD+4qXF9On
 UDtkrpviLQH/jFgNcVeWZU4SI1UKBl4tmUXGtGParD+Y0A3V8KA/5yHxlbC2gDY12xO9g0FuNmA
 gFUlyKJDt52ZGlrtveRycoK2jwcgvYaQMUCxXOgPmSn6hr3CiwXn7b0wvTgkE4l0fDPfMev/1wV
 ZR83tKCY6mjw9YH4kiyxgZhGJ1hb4UwiscZgOHKJX+aynDpR8xW4wVMZnSsWYn9udXv+GFnlo/F
 AMl1/Z0R0EgYnOK8bKovBDg8Vt5KsvTOrqgTgvkxnHRcBYz9mXDtd+2+WfjRa23imZdTn+oxNG4
 EzVyQqGtmTKrIj8ZlTcgbqc7jWOzWNOdWIa6hKItKdrZ06vkceTg==
X-Google-Smtp-Source: AGHT+IFhdkGQ+xzP76a1LK0Af58A5E8eJm2BpI+tUG3OCKUOZ2eJKgJRKsDfRIa0WxL1F37pxSSykw==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id
 5b1f17b1804b1-4711787617amr115466015e9.5.1761036276871; 
 Tue, 21 Oct 2025 01:44:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ba070sm19433697f8f.42.2025.10.21.01.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/11] ppc/spapr: remove deprecated machine pseries-4.1
Date: Tue, 21 Oct 2025 10:43:44 +0200
Message-ID: <20251021084346.73671-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Remove the pseries-4.1 machine specific logic as had been deprecated and
due for removal now as per policy.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  2 --
 hw/ppc/spapr.c         | 37 +------------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd783e92e15..60d9a8a0377 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,8 +141,6 @@ struct SpaprCapabilities {
 struct SpaprMachineClass {
     MachineClass parent_class;
 
-    bool linux_pci_probe;
-    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97736bba5a1..a06392beff1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1072,7 +1072,6 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
 static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int chosen;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
@@ -1143,9 +1142,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
          * We can deal with BAR reallocation just fine, advertise it
          * to the guest
          */
-        if (smc->linux_pci_probe) {
-            _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
-        }
+        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
 
         spapr_dt_ov5_platform_support(spapr, fdt, chosen);
     }
@@ -2589,7 +2586,6 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *ms = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err = NULL;
     bool vsmt_user = !!spapr->vsmt;
     int kvm_smt = kvmppc_smt_threads();
@@ -2625,15 +2621,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
             return;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else if (!smc->smp_threads_vsmt) {
-        /*
-         * Default VSMT value is tricky, because we need it to be as
-         * consistent as possible (for migration), but this requires
-         * changing it for at least some existing cases.  We pick 8 as
-         * the value that we'd get with KVM on POWER8, the
-         * overwhelmingly common case in production systems.
-         */
-        spapr->vsmt = MAX(8, smp_threads);
     } else {
         spapr->vsmt = smp_threads;
     }
@@ -4649,8 +4636,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->linux_pci_probe = true;
-    smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
@@ -4945,26 +4930,6 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 2);
 
-/*
- * pseries-4.1
- */
-static void spapr_machine_4_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        /* Only allow 4kiB and 64kiB IOMMU pagesizes */
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
-    };
-
-    spapr_machine_4_2_class_options(mc);
-    smc->linux_pci_probe = false;
-    smc->smp_threads_vsmt = false;
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(4, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


