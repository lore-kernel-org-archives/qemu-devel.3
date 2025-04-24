Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445C0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xo-0005uX-0I; Thu, 24 Apr 2025 18:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xl-0005mv-0j
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xj-000121-35
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so1066573f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533348; x=1746138148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9F/Xu2/QMqJcrb8r8k7kzBHlfm38hQBgPZ/Fp6QYoE=;
 b=eLirFQiRRoB6eBXtItcrmYKPHFRdqAeKOkZrRovdcHT1KdgvBxYe56vghzFetZcQai
 ngvHTp/z0LrPTubjNCew/QQz9a2QHZk0GgSMTQA7zJVSzUKNRjY4+UyrvWm6CGTdVNMH
 KSNllpFBeQl6Vlt6IT7LOqwtm1oneJLEMV43YVluJYdpPkKXEtiyZepCR20s+0hUK5cK
 AbuUGfaguNu+zQkK8dSGI/dDlRUn2i/0BB8YiOdFJQaQZww/mImDdkPjiKWX1NKIjVxC
 GYd+s++R4TCe3hjMOct2Bd8KQ0+tDYynamOLFTipQlY56hXsTWtsT3xeaZGSQUaYx0Ka
 XcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533348; x=1746138148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9F/Xu2/QMqJcrb8r8k7kzBHlfm38hQBgPZ/Fp6QYoE=;
 b=rqIGGvXbIzFfYnthRGlE9qx+leDs20EsqDgNHoBsihTC31eypaRWAD9RQr42aBgAQs
 gBfZSgL2qzdvwKfFKNerXPPuwtHyvk7l/ZrphwDfADB/p9jYXAo22gc401ySl7s6zzR/
 sBf3lHQYpkrOBfsAQn8fjHixRZG7piOh6seDm7EoVMI5qwWR7Hg7aAGLTsxFa345mG17
 swWF4ROrE1XZbwOWQ0lmfKG7RfIwh6asr9YxRPmz6bY96a6tOukhYEBRuvkbakgNlF9n
 WujZY6VGhF4pdTXNmTaGAiLlp8WkYz/IG2E3PSWqacCbWtCM/3HqYyRqg6YturZnF0FS
 rYfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG1fCHKJi+Rq19K4fYnAJNwHdM1tnrA0/VfN5r8SybjQSIEBodZKZHpfjyKLSPzDqs1ZxWlPJuvKxC@nongnu.org
X-Gm-Message-State: AOJu0YwnIcqH1X7O5cDvLKGYmJIRWPj3aSkG8eTBSXj5UtDI2HHe96ep
 QD6RfP17Wm68brFcApRoWTBCCqwP0hypGaPHWXNxZdBN1TJ+S7LS6gsHEkMV9as=
X-Gm-Gg: ASbGncs9FEbMOUNlWCxE3kJimIqicOynvP9CqvmgOz6/x5hwEtkdtRysufzgb+hs6S7
 4RSPAK03FpTRI1SAGqCfN7bt781O4FrBK6I2iNcOc2oOq2M2N6UrIcTnzjrWmqy4FX4bqoaWu4x
 qU1YtBXjhiy3aSHpqKt3vC3WBbSKHG6Lh3hwnEuBDciOsQNnh5L6rupdNp+mtzKeAupRc16FajG
 FtJfH8vVoLPwaFmF/BdXg6Ih3aXk3516zviPFQ+utnH7NU98aap6O4J6xoTLvXPNR0MP9s57ApS
 ewgbh/W3YrSrwKYXPEtFPCl5z3eEyNnH6r2lm/Ce/mKEKXwclgiN0hB887bvPZswHKW7fVXmK06
 qcjlAr1r3qPLTO1lPGYSqnpCNVA==
X-Google-Smtp-Source: AGHT+IG/2iBL8fd7z4WoNkt+sQnPOUL7UJxWVjg9s2R2z6Q0s/+AJPRZ10nuN6skUtI4McrWrhT/FQ==
X-Received: by 2002:a5d:64c3:0:b0:39c:dfb:9e8e with SMTP id
 ffacd0b85a97d-3a072a59b81mr709198f8f.8.1745533348547; 
 Thu, 24 Apr 2025 15:22:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm509704f8f.25.2025.04.24.15.22.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 15/21] hw/arm/virt: Register valid CPU types dynamically
Date: Fri, 25 Apr 2025 00:21:06 +0200
Message-ID: <20250424222112.36194-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Replace the static array returned as MachineClass::valid_cpu_types[]
by a runtime one generated by MachineClass::get_valid_cpu_types()
once the machine is created (its options being processed).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6185ac1046f..f29f541ea93 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3126,36 +3126,41 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
+{
+    GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
+
+#ifdef CONFIG_TCG
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
+#ifdef TARGET_AARCH64
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
+#endif /* TARGET_AARCH64 */
+#endif /* CONFIG_TCG */
+#ifdef TARGET_AARCH64
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
+        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+            g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
+#endif /* CONFIG_KVM || CONFIG_HVF */
+#endif /* TARGET_AARCH64 */
+    g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
+
+    return vct;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    static const char * const valid_cpu_types[] = {
-#ifdef CONFIG_TCG
-        ARM_CPU_TYPE_NAME("cortex-a7"),
-        ARM_CPU_TYPE_NAME("cortex-a15"),
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a35"),
-        ARM_CPU_TYPE_NAME("cortex-a55"),
-        ARM_CPU_TYPE_NAME("cortex-a72"),
-        ARM_CPU_TYPE_NAME("cortex-a76"),
-        ARM_CPU_TYPE_NAME("cortex-a710"),
-        ARM_CPU_TYPE_NAME("a64fx"),
-        ARM_CPU_TYPE_NAME("neoverse-n1"),
-        ARM_CPU_TYPE_NAME("neoverse-v1"),
-        ARM_CPU_TYPE_NAME("neoverse-n2"),
-#endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
-#ifdef TARGET_AARCH64
-        ARM_CPU_TYPE_NAME("cortex-a53"),
-        ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-        ARM_CPU_TYPE_NAME("host"),
-#endif /* CONFIG_KVM || CONFIG_HVF */
-#endif /* TARGET_AARCH64 */
-        ARM_CPU_TYPE_NAME("max"),
-        NULL
-    };
 
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
@@ -3183,7 +3188,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #else
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
 #endif
-    mc->valid_cpu_types = valid_cpu_types;
+    mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-- 
2.47.1


