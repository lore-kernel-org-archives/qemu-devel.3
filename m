Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDABCC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfJ-0001fe-QD; Fri, 19 Apr 2024 12:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqec-00018J-Ic
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016C-RV
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34a3e0b31e6so1235173f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542390; x=1714147190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRM3PMgf67soEHO0QvvaQBhnswxt2iC+13Xw/Jq7gQ4=;
 b=JH4yNFKAhI5kc7APS5ixtFXVaBFysa1VbCN0yA7EYams+nU6rgTLNR/SQAUmnk6aEf
 KShv145l1kgaW6hQVQ9E/XyrbiW+uLeFtDbbT0iwRbCawTVZrdFsM2uCrT8s2pRP+yhU
 JeqI+ffj+gh6e7Zy6tZl2WDiEtpc0KMzkAiEBW/HLVnm+FIo+Axk8UuO8H4um+aue7kU
 ivo7pYt6xVpkybSg6FuR3hveyRRkSeBq/971x0ylgisExZyyJYZXaIOX8ow05esYRFWP
 N1uL6viH495hYylNFZRPk2vaj/FquyChNJdzUSHdYESxVPiWWBf4wMeiDT1QLGSXJOtR
 41bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542390; x=1714147190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRM3PMgf67soEHO0QvvaQBhnswxt2iC+13Xw/Jq7gQ4=;
 b=o0F2eLcRcZYD2KA/nqSFjnxOdafqCAQYyhfTKuDgHkUMVsbtrwQs78hGtD+quQt2Oc
 AN4M50wfbTYqyeIdpdMO4fbIGFk6Z3BNANv0vg1v5miVL/l0Sp2zPaHRkn9y8ex2lHcI
 cNVZe02ocKgxOa+h5hgLMb1SHN9xsvhAckGDqSHTbLguEjBNKlHK0xm6cr8foAr4EScH
 jY6fP53OoNManfC9sSBAqeE/GWjzBhSgT+VSqe8VKppW9Yq3lKWPcTv7FlKK9C0u/2lN
 IKoI3eZn5wZ9FRK4ACdNgbzVcVZQ10lCNEPTLxnP/H0Pv5jp4N4XKSj730pOOV1GfDgE
 Y08Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/v89Aa8oyZFYRfjB0yeuxmPOG5uxgtZrIcLip7ctR8o8FRibseYsqst66KWewjsVqTvXPdRyE3QM4ualAhs2pNzmfisY=
X-Gm-Message-State: AOJu0YzzLp5mjTFav/8yAJPllVJ4k5BlAqJzPWh5tocfWDhIc2ACBQv3
 cY2cG+0Zb1R/hXo72ROAmKEak/dIJCrMWLnh5F15kCOXq7S5AI8lgA21YES0psc=
X-Google-Smtp-Source: AGHT+IGVICopAXm0pEWgBvrgks5IfxQpCLgDaJmm8g+T7HOdc7+HvF5tidjUIpsGKu7caC1zxuWLOg==
X-Received: by 2002:adf:ff8a:0:b0:345:5f6a:cbf7 with SMTP id
 j10-20020adfff8a000000b003455f6acbf7mr1681426wrr.29.1713542390205; 
 Fri, 19 Apr 2024 08:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 05/22] hw/arm/virt: Add support for Arm RME
Date: Fri, 19 Apr 2024 16:56:53 +0100
Message-ID: <20240419155709.318866-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

When confidential-guest-support is enabled for the virt machine, call
the RME init function, and add the RME flag to the VM type.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2:
* Don't explicitly disable steal_time, it's now done through KVM capabilities
* Split patch
---
 hw/arm/virt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9a913aead..07ad31876e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -224,6 +224,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2111,10 +2116,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
@@ -2917,6 +2923,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int rme_vm_type = kvm_arm_rme_vm_type(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -2946,7 +2953,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | rme_vm_type;
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
-- 
2.44.0


