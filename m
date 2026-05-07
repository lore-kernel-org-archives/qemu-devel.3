Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A772CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11y-0005V2-FJ; Thu, 07 May 2026 11:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11w-0005Ic-5U
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11u-00041N-AL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso9362635e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169169; x=1778773969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A/aN2QAxKTVLKMwN6ey26q9bUhfrDOPQ9xOMl/smTtk=;
 b=X6OTwgYQCSUGumxPduiHA8KvOC5D+lO2aUqwCJCh0Wscm9CBLf1+/gnLvEMDdOTDSX
 3zbBBiYc/6WzNDDBmZoTlIJ1AHj26Z24iMXX5FIXP8SU17oCf2Zf9igWpq49cfR5hzyy
 tFIA1f40tdt3DSSi1L0+npfFqVo4raNe0mNChvhY3/cs74l6E1M0/YKQs7eVjHNFsL5u
 ezcSSLYY2IB5BNG71BSZRNq0MtQ+JJRDG9YwXCbDl5ooYsThLKoIowyVl3sgfX6DDMHP
 K2qgPXhVVA7ZTE6K0WYnZ/TjIRdO2VvAlDkwXxsRaO1biH4Vv8y27+RnHAXN0WKXPBCG
 QZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169169; x=1778773969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A/aN2QAxKTVLKMwN6ey26q9bUhfrDOPQ9xOMl/smTtk=;
 b=UoWVsYzhxzQTnuQNN5U8C9H4RQoCMRRgDOkiLQNOuMrsupykVmhGAM9NVT7AdyDJLq
 Lv6BGvByRnAvuMi48qOABQuEsJe4mNVyZ/tHB707HD+VxX1KpX3FaK1WjX6vrjPRc8qf
 ganyU8tLrQ9d4Yxjw37Bhh2/uUzlaRGHDtbTaEqA6lnD98WdDY88zN8PcyX+S6OMEr/V
 9stJxATKB5ghSfxfPTkKTMf50qGFKdP9Nvdwuc1yhJsufngCNYlJ6RYvgQIoVYlb8oUI
 T0tUFbF4ONkMPcNvBzqmEj4Tz1/kTBbgM20LNj0tpoKP7C4J5jMequADMnRupl4SI3GP
 GLxQ==
X-Gm-Message-State: AOJu0Yw+mdF0FAorx8icMU+NJJ2D3vm1+FqACtH2TVeKulIUjTS/bC0s
 Qd2fKMM1sIkYcxq5yy539b2u8fFxk6sBKVE7rNRU8eQ00JAfptp3VhJ5w8asqnlCzKEGfIYS3ga
 GChUT
X-Gm-Gg: AeBDietB7t7K1s9qqHyiXgYsPXoh/7SKQWjJ/M9zhI2v3wJTGj4/HT9hHxGWwwJUbwM
 O4b/CGp808RT8v2JrM+QJ+KQVryLUNSeEsZvALMBMOOv+4Yhan/RxcVrVrNzn0gpjrKj1EnqQB/
 zsaSNcrK5uxFl3GJWFMrmIB8N7shuq3S2d7CHdsephCJKwghHMFIC9JcNCdx0JkEG5Nl784MQtW
 W2l2u9E45BZgAdFFdl9u0edGvlPl0knxP2SjPFGBhDyI6aNxoG1Wg/FL0v8PKr4pt5WBfRg6Nwd
 zk99uesmeDHZWje2v1SzklxTv38IwGYBa82GsJxnwH3BntiOhWwoo9BF8YfyAXNs0QitZEPIV86
 yUZHICSMqoBaQ3C2QNIAyklpj7mtxSrFXRCc5qP1BRHkkSS8TomH5VNHOjyvOjUSpeGfRDB2hqi
 R3UhFxvRgYOCX1M7xWjB6bMtRvEyRDMoS9aRoxAdALY0CtGKYMITpVXuvzpv2Ff32dFXcoDqu+A
 xzQHjvj+x4/wQ20GBkH2tEY4IA4TuU=
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48e51e0a620mr146357125e9.3.1778169168715; 
 Thu, 07 May 2026 08:52:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/67] target/arm: Add has_gcie property to enable FEAT_GCIE
Date: Thu,  7 May 2026 16:51:41 +0100
Message-ID: <20260507155154.1886557-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Add a has_gcie QOM property to the CPU which allows the board code to
enable FEAT_GCIE, the GICv5 CPU interface.

Enabling the GICv5 CPU interface comes with a significant
restriction: because the GICv5 architecture is Armv9, it assumes the
Armv9 requirement that only EL0 (userspace) may be in AArch32.  So
there are no GIC control system registers defined for AArch32.  We
force AArch32 at ELs 1, 2 and 3 to disabled, to avoid a guest being
able to get into an EL where interrupts are completely broken.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-55-peter.maydell@linaro.org
---
 target/arm/cpu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 29346609e4..330e9be473 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1270,6 +1270,9 @@ static const Property arm_cpu_has_el2_property =
 
 static const Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
+
+static const Property arm_cpu_has_gcie_property =
+            DEFINE_PROP_BOOL("has_gcie", ARMCPU, has_gcie, false);
 #endif
 
 static const Property arm_cpu_cfgend_property =
@@ -1526,6 +1529,11 @@ static void arm_cpu_post_init(Object *obj)
         object_property_add_uint64_ptr(obj, "rvbar",
                                        &cpu->rvbar_prop,
                                        OBJ_PROP_FLAG_READWRITE);
+
+        /* We only allow GICv5 on a 64-bit v8 CPU */
+        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_gcie_property);
+        }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
@@ -1826,6 +1834,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                        current_accel_name());
             return;
         }
+        if (cpu->has_gcie) {
+            error_setg(errp,
+                       "Cannot enable %s when guest CPU has GICv5 enabled",
+                       current_accel_name());
+            return;
+        }
     }
 #endif
 
@@ -2163,6 +2177,37 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         FIELD_DP32_IDREG(isar, ID_PFR1, VIRTUALIZATION, 0);
     }
 
+    /* Report FEAT_GCIE in our ID registers if property was set */
+    FIELD_DP64_IDREG(isar, ID_AA64PFR2, GCIE, cpu->has_gcie);
+    if (cpu_isar_feature(aa64_gcie, cpu)) {
+        if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
+            /*
+             * We only create the have_gcie property for AArch64 CPUs,
+             * but the user might have tried aarch64=off with has_gcie=on.
+             */
+            error_setg(errp, "Cannot both enable has_gcie and disable aarch64");
+            return;
+        }
+
+        /*
+         * FEAT_GCIE implies Armv9, which implies no AArch32 above EL0.
+         * Usually we don't strictly insist on this kind of feature
+         * dependency, but in this case we enforce it, because the
+         * GICv5 CPU interface has no AArch32 versions of its system
+         * registers, so interrupts wouldn't work if we allowed AArch32
+         * in EL1 or above. Downgrade "AArch32 and AArch64" to "AArch64".
+         */
+        if (cpu_isar_feature(aa64_aa32_el3, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 1);
+        }
+        if (cpu_isar_feature(aa64_aa32_el2, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL2, 1);
+        }
+        if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL1, 1);
+        }
+    }
+
     if (cpu_isar_feature(aa64_mte, cpu)) {
         /*
          * The architectural range of GM blocksize is 2-6, however qemu
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9d2c27f7df..a0a1d7fbe3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1031,6 +1031,8 @@ struct ArchCPU {
     bool has_neon;
     /* CPU has M-profile DSP extension */
     bool has_dsp;
+    /* CPU has FEAT_GCIE GICv5 CPU interface */
+    bool has_gcie;
 
     /* CPU has memory protection unit */
     bool has_mpu;
-- 
2.43.0


