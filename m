Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FCAC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeN-0007Ho-Ih; Tue, 02 Jul 2024 01:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeJ-0007HL-M2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:53 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeG-0006QC-QI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:50 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e72224c395so42091251fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896506; x=1720501306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pioOxQHXqtuS3GWzOlUVjKUrOs3kssZvNj/hFMkYvgQ=;
 b=j41Vx1WAahxDirYnRwF8CTebPfHmRCKb68zjGYCnhUyN0Rm511mZ0HWjXHKEMgmNts
 Dga3JTjg15nXKlXqtlKtAW8Ec9CmA9XD4hg+7qvfjz4fd9rAAgBUjRBBArn1xavKtnuN
 FcqANJS/Z/n/UlPS/eitpJU1zDJlo2kO08wKkKwZavitTv801LXzsv9wc7sDuavhubZJ
 O7N4AbVswPTD1h7kXpM0dO6+9HsbWVeW4WMT4S99Uxqnu30cDDZkWNfhH+RMhoea/cqI
 L1VXBfwHXqWr0WVmN5iSOmxocd1GW5d/dO/L9+qI3G4B/9niMVSKfpwfHxz1AqJsVP4J
 OLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896506; x=1720501306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pioOxQHXqtuS3GWzOlUVjKUrOs3kssZvNj/hFMkYvgQ=;
 b=i+Km4gmNhD45Jw7+6P9qXsxXxA7FUl91ONdHRiY8iEBZ0hh4pme/yS9avSe1oX5v0C
 PtZ97fVmECGD3w7GuJNYgv7ozdgSljWCrPc9KjH4tkdLK/jitAPbNTD8qmysCY9CQ2hB
 Beb5k8hHZp79eCwY15sSNGaeQdSOzUBZV64GgCkg0o55xhQXI54GS91J0rI+n8O7j6RN
 gz3Xyj/G3uifQyd7fsVyJgWEtkAUJvL0toI6mErL02NYqMFuU9dEr2H2+cNMejxGTWS4
 o2FEWbsPZk6dqVriSCq0qDB9TGFn+gbw0Cj7pMK5LIDcHf4z0x3TmJ8LTnRXqjiC8LFz
 SK+w==
X-Gm-Message-State: AOJu0YyeyLOjj3psdO8yEVCFdDVcNGHDyzi/nZy97N9bA1RhGj14WRA4
 cgDKw4wpu3CqCZba+m3OaceiobcXuRRaTmrBMBRSbWl+eu/js1YkcUpXUN3f8ZgbnX/ZhyqrjTF
 8
X-Google-Smtp-Source: AGHT+IGPOLSS9t3Kup9Yb1o1nUjUrBZ3pzQUF+Zn7r4ji4h07sEweFLTzXSNEywgC6FdMmERaprtlw==
X-Received: by 2002:a2e:6d12:0:b0:2ec:95:d6fe with SMTP id
 38308e7fff4ca-2ee5e36eecfmr42345691fa.24.1719896506200; 
 Mon, 01 Jul 2024 22:01:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bcbsm180484155e9.35.2024.07.01.22.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/22] hw/ppc: convert 'spapr' machine definitions to use new
 macros
Date: Tue,  2 Jul 2024 07:00:55 +0200
Message-ID: <20240702050112.35907-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This changes the DEFINE_SPAPR_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number twice in two different formats in the calls
to DEFINE_SPAPR_MACHINE.

A DEFINE_SPAPR_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Due to the odd-ball '2.12-sxxm' machine type version, this
commit introduces a DEFINE_SPAPR_MACHINE_TAGGED helper to
allow defining of "tagged" machine types which have a string
suffix.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240620165742.1711389-5-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 97 +++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9908545e6..2785b6b303 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4804,26 +4804,35 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     mc->is_default = true;
 }
 
-#define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
-    static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
-                                                    void *data)      \
+#define DEFINE_SPAPR_MACHINE_IMPL(latest, ...)                       \
+    static void MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__)(     \
+        ObjectClass *oc,                                             \
+        void *data)                                                  \
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
-        spapr_machine_##suffix##_class_options(mc);                  \
+        MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
         if (latest) {                                                \
             spapr_machine_latest_class_options(mc);                  \
         }                                                            \
     }                                                                \
-    static const TypeInfo spapr_machine_##suffix##_info = {          \
-        .name = MACHINE_TYPE_NAME("pseries-" verstr),                \
-        .parent = TYPE_SPAPR_MACHINE,                                \
-        .class_init = spapr_machine_##suffix##_class_init,           \
-    };                                                               \
-    static void spapr_machine_register_##suffix(void)                \
+    static const TypeInfo MACHINE_VER_SYM(info, spapr, __VA_ARGS__) = \
     {                                                                \
-        type_register(&spapr_machine_##suffix##_info);               \
+        .name = MACHINE_VER_TYPE_NAME("pseries", __VA_ARGS__),       \
+        .parent = TYPE_SPAPR_MACHINE,                                \
+        .class_init = MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__), \
+    };                                                               \
+    static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
+    {                                                                \
+        type_register(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
     }                                                                \
-    type_init(spapr_machine_register_##suffix)
+    type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
+
+#define DEFINE_SPAPR_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_SPAPR_MACHINE_IMPL(true, major, minor)
+#define DEFINE_SPAPR_MACHINE(major, minor) \
+    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
+#define DEFINE_SPAPR_MACHINE_TAGGED(major, minor, tag) \
+    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor, _, tag)
 
 /*
  * pseries-9.1
@@ -4833,7 +4842,7 @@ static void spapr_machine_9_1_class_options(MachineClass *mc)
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE(9_1, "9.1", true);
+DEFINE_SPAPR_MACHINE_AS_LATEST(9, 1);
 
 /*
  * pseries-9.0
@@ -4844,7 +4853,7 @@ static void spapr_machine_9_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(9_0, "9.0", false);
+DEFINE_SPAPR_MACHINE(9, 0);
 
 /*
  * pseries-8.2
@@ -4855,7 +4864,7 @@ static void spapr_machine_8_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_2, "8.2", false);
+DEFINE_SPAPR_MACHINE(8, 2);
 
 /*
  * pseries-8.1
@@ -4866,7 +4875,7 @@ static void spapr_machine_8_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_1, "8.1", false);
+DEFINE_SPAPR_MACHINE(8, 1);
 
 /*
  * pseries-8.0
@@ -4877,7 +4886,7 @@ static void spapr_machine_8_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_0, "8.0", false);
+DEFINE_SPAPR_MACHINE(8, 0);
 
 /*
  * pseries-7.2
@@ -4888,7 +4897,7 @@ static void spapr_machine_7_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_2, "7.2", false);
+DEFINE_SPAPR_MACHINE(7, 2);
 
 /*
  * pseries-7.1
@@ -4899,7 +4908,7 @@ static void spapr_machine_7_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_1, "7.1", false);
+DEFINE_SPAPR_MACHINE(7, 1);
 
 /*
  * pseries-7.0
@@ -4910,7 +4919,7 @@ static void spapr_machine_7_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_0, "7.0", false);
+DEFINE_SPAPR_MACHINE(7, 0);
 
 /*
  * pseries-6.2
@@ -4921,7 +4930,7 @@ static void spapr_machine_6_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(6_2, "6.2", false);
+DEFINE_SPAPR_MACHINE(6, 2);
 
 /*
  * pseries-6.1
@@ -4936,7 +4945,7 @@ static void spapr_machine_6_1_class_options(MachineClass *mc)
     mc->smp_props.prefer_sockets = true;
 }
 
-DEFINE_SPAPR_MACHINE(6_1, "6.1", false);
+DEFINE_SPAPR_MACHINE(6, 1);
 
 /*
  * pseries-6.0
@@ -4947,7 +4956,7 @@ static void spapr_machine_6_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(6_0, "6.0", false);
+DEFINE_SPAPR_MACHINE(6, 0);
 
 /*
  * pseries-5.2
@@ -4958,7 +4967,7 @@ static void spapr_machine_5_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(5_2, "5.2", false);
+DEFINE_SPAPR_MACHINE(5, 2);
 
 /*
  * pseries-5.1
@@ -4972,7 +4981,7 @@ static void spapr_machine_5_1_class_options(MachineClass *mc)
     smc->pre_5_2_numa_associativity = true;
 }
 
-DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
+DEFINE_SPAPR_MACHINE(5, 1);
 
 /*
  * pseries-5.0
@@ -4991,7 +5000,7 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
     smc->pre_5_1_assoc_refpoints = true;
 }
 
-DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
+DEFINE_SPAPR_MACHINE(5, 0);
 
 /*
  * pseries-4.2
@@ -5008,7 +5017,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
     mc->nvdimm_supported = false;
 }
 
-DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
+DEFINE_SPAPR_MACHINE(4, 2);
 
 /*
  * pseries-4.1
@@ -5028,7 +5037,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
+DEFINE_SPAPR_MACHINE(4, 1);
 
 /*
  * pseries-4.0
@@ -5055,7 +5064,7 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
     smc->pre_4_1_migration = true;
 }
 
-DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
+DEFINE_SPAPR_MACHINE(4, 0);
 
 /*
  * pseries-3.1
@@ -5077,7 +5086,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
 }
 
-DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
+DEFINE_SPAPR_MACHINE(3, 1);
 
 /*
  * pseries-3.0
@@ -5095,7 +5104,7 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
     smc->irq = &spapr_irq_xics_legacy;
 }
 
-DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
+DEFINE_SPAPR_MACHINE(3, 0);
 
 /*
  * pseries-2.12
@@ -5120,7 +5129,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
 }
 
-DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
+DEFINE_SPAPR_MACHINE(2, 12);
 
 static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 {
@@ -5132,7 +5141,7 @@ static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_FIXED_CCD;
 }
 
-DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false);
+DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
 
 /*
  * pseries-2.11
@@ -5148,7 +5157,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
-DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
+DEFINE_SPAPR_MACHINE(2, 11);
 
 /*
  * pseries-2.10
@@ -5160,7 +5169,7 @@ static void spapr_machine_2_10_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
 }
 
-DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
+DEFINE_SPAPR_MACHINE(2, 10);
 
 /*
  * pseries-2.9
@@ -5180,7 +5189,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
 
-DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
+DEFINE_SPAPR_MACHINE(2, 9);
 
 /*
  * pseries-2.8
@@ -5198,7 +5207,7 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
     mc->numa_mem_align_shift = 23;
 }
 
-DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
+DEFINE_SPAPR_MACHINE(2, 8);
 
 /*
  * pseries-2.7
@@ -5273,7 +5282,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
     smc->phb_placement = phb_placement_2_7;
 }
 
-DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
+DEFINE_SPAPR_MACHINE(2, 7);
 
 /*
  * pseries-2.6
@@ -5291,7 +5300,7 @@ static void spapr_machine_2_6_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
+DEFINE_SPAPR_MACHINE(2, 6);
 
 /*
  * pseries-2.5
@@ -5310,7 +5319,7 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
+DEFINE_SPAPR_MACHINE(2, 5);
 
 /*
  * pseries-2.4
@@ -5325,7 +5334,7 @@ static void spapr_machine_2_4_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
 }
 
-DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
+DEFINE_SPAPR_MACHINE(2, 4);
 
 /*
  * pseries-2.3
@@ -5340,7 +5349,7 @@ static void spapr_machine_2_3_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
+DEFINE_SPAPR_MACHINE(2, 3);
 
 /*
  * pseries-2.2
@@ -5357,7 +5366,7 @@ static void spapr_machine_2_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
 }
-DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
+DEFINE_SPAPR_MACHINE(2, 2);
 
 /*
  * pseries-2.1
@@ -5368,7 +5377,7 @@ static void spapr_machine_2_1_class_options(MachineClass *mc)
     spapr_machine_2_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);
 }
-DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
+DEFINE_SPAPR_MACHINE(2, 1);
 
 static void spapr_machine_register_types(void)
 {
-- 
2.41.0


