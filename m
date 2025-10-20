Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82903CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoAu-0002WW-ED; Mon, 20 Oct 2025 07:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAr-0002VT-Sc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAp-00016n-9y
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso30198895e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960133; x=1761564933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S13OAGdaDHxB33SgD+W/tXYSpC7CzxHFsXBICbw81Dc=;
 b=kj67OZKSGcMiA4SXtYRpbADnh3rN4SxKMAVYAyin44Eb92BJFb2KcfHC3McTOlVkln
 56OEq3ZOJfWRmAroQYbvDqyeBMB0hBVIxLr6rzsqk+RdtLH1ZkPuJR9zXZRpH2Yf46vJ
 1XNXO2SkQ18saYhYrBOWFgO3ONiSieeYi+qM94rjKqCHsy3ZTU7kiLaSlYzrPdhHkr/j
 yGlzUPD1jUDe7TPdhbnKIq4x6IjblfaoKEoiSJoafzuKBHGa7v5oFq4a4xFqyu5NS9dA
 f1XrNeDhh28I+E8obDK69GqC4pF2QA6feS0sFarjfXt8W2ka9xO4WrKsuk4rctqza+IL
 4Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960133; x=1761564933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S13OAGdaDHxB33SgD+W/tXYSpC7CzxHFsXBICbw81Dc=;
 b=wHRaoh2VV2ZNGe1+OoraWEw716Ofapm7NxmUbA3rgd4fD+lplsY3+WzJIrZRohUC8E
 0SzIGrXMiLB1tnftna16SMUYV+JXGgKQwzxLRh0yJHVxjeZGPDdS4nnHynRgt/boCait
 ecFMGNhnXshQog78LQ6htigm3KeuAVnNr4OlFsnuVsEYAq6uunagHx4pa6CCnv5tuGjL
 5B4NKes1vlEnD5T0NgO2h0ykxHI2dvhSvFG8NNEQ4A8uWPREZ23l2fs5cwUma9+ewilA
 DwBMzUFoR9Nw4HwfdhpqoZveOrQm3xaUmhSOd6/IqRtqr17SCIT4FU8NTNtFRD2uU5bO
 5mlw==
X-Gm-Message-State: AOJu0Yy56jREPInDRPTuOu6hA5zGbkAWV4c29weXmKcqwVzJcN8PknZC
 HlucxIcI4wqSEveRf+Jw1CHG1V3OcyXrTaCV6tLj3Uqzfgibd9lnrwsUBl+TLm0+Jc8Sc5885/i
 jpFRiCE4=
X-Gm-Gg: ASbGncvWd782wH0tN/q8HL4DrKwYPllmtXMzWQ/mi+bfnE/30BhYYt7geiz3t5Bu/Sc
 SOhT1+DQLv65tgr3ia2QFqda3ev2wT39ErBXc4DVBKg43YR2oLjrCOFeFhbrHJKNZWbxvMkMZwN
 Ucy9LwUswsOXViM9OCo3MSCXUO8xUdAbcvfO9c/gqi2cge3lwJP1r22xHNoqAcx6C+U8HRE+aTK
 n/1CdHeGX8EN8c2lbz1sEJNhRSzGPgndMS5NpxJDBE7vuplm7jHuLICw8rt6exQYXeOh3JK/+Wn
 QsR0crTHPI2+O6M2o6Qg4jLlEORlAJYx6TcEoV6hTKhFnKxFVAit67pUts/c6hv8GyyG4veWDXO
 4s5ZxCMoGtNC7+9+Z8U5LXtcHV4h7ooZAxMP/cdU4r3wREwoU9HTh0npnK4OmvQe04Pm+7hQODw
 pGmZij9O82/wftYUZ+Os5bqw3EkZbyQ+lHlTfRI30mOVN22OcMDQ==
X-Google-Smtp-Source: AGHT+IHDgvdsyRBoa6BCavsmZEBa5Tkw6MjsxGG/H09wCivMI1OQ9hkaGo/cc3BuEl5TEQ0UmvIeFA==
X-Received: by 2002:a05:600c:8183:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4711724e5bcmr94251665e9.7.1760960133000; 
 Mon, 20 Oct 2025 04:35:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5bbc50sm15087183f8f.21.2025.10.20.04.35.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 04:35:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/18] hw/ppc/spapr: Remove SpaprMachineClass::linux_pci_probe
 field
Date: Mon, 20 Oct 2025 13:35:19 +0200
Message-ID: <20251020113521.81495-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The SpaprMachineClass::linux_pci_probe field was only used by the
pseries-4.1 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 3 ---
 hw/ppc/spapr.c         | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1629baf12ac..60d9a8a0377 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -139,11 +139,8 @@ struct SpaprCapabilities {
  * SpaprMachineClass:
  */
 struct SpaprMachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
-    /*< public >*/
-    bool linux_pci_probe;
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c8558e47db2..30ffcbf3d2b 100644
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
@@ -4638,7 +4635,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->linux_pci_probe = true;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
-- 
2.51.0


