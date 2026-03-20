Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC8D109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPV-0000Ol-31; Fri, 20 Mar 2026 12:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cP4-0000BY-Q5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cP2-0008WI-1P
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so17701165e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022924; x=1774627724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxangKbcKg6DThVnOgtvYQODpyhNQKOeoUuVdNKo2bk=;
 b=zk4IhcwnzNRB3cxoebI2usy+TH7RK8vxCo+JxV4RUDUaJeBjixPAcG9P5sAFQcnFG5
 9ARaZ6oOAr8uGa9cYyKw41MNKjlbe3FLYIKMSxIoNWVCO+5JLia71VbY0gofk+blpMnF
 xwQstsn9qO5RaU77FK7G7V/9KwXT7WaDPnmchuIQCu1zmR3ZF3PF1cEUEouAP7yJD254
 zFlPgyLar6S2wSSIit4f6TjnPYAzWjAZaS6OC91dw/FZscZDzXoddYW9qeFkpyTrRVli
 MxBHvbOirgIGoFoXN85xBhI2STMqpWKnqOiEMnWmQAlJjaix81BxG7ZgBn9tG7j3aO5C
 Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022924; x=1774627724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxangKbcKg6DThVnOgtvYQODpyhNQKOeoUuVdNKo2bk=;
 b=bvgveF+JNoySH8CbBXEwZcfws/NvuEmU/jctorplwqpSgj3BlNnRw9iAFXi4YsF/O/
 XFHilaOOJpH067RnWI9J6yARFeEoTT1mas6twRpD3buCJlJAGwc3VcT7qOQfko/UKK4/
 VmWSs8AUa4Gx8y1kAYmLV9xN1Ze6zzeAuIBfznmJexgpWzVC8kw+G7OErozpuLFWRaSi
 vZ3+FbQR3pP1Y7tdOrWsn0kCR1EqpvWMLG1Ywco2+v0tyL7D3Ej60lw1ixZvs9skUmk5
 hYd5+mCNuLD4E8+264Ecjc0uuYeD68KN81yoHBjX3zTMFLCojo0kOTOqgwbjkuyl26VD
 VbAw==
X-Gm-Message-State: AOJu0YwJ/UIn+EjAWt5yyXGonGahpifG+yEKABUDvS9qcgfpY+Pikw8F
 FzDBiQMF20uOx4P5UvZybi3LXHoZU/ztGkM6qZ2j1qA6ocrTff+rYH31EYvJA7JQtfipKCuIuk9
 Pnk/R11Y=
X-Gm-Gg: ATEYQzyion2WQkd5pIE5mmYjmQ8XwaW4PWeQC6w62+XMHeJoDFz5nIVK2QdupuzCjZS
 ENTfsWc3hbJexkEjQbvJcWlU8c5Q9RbmIsBFQXuLsOg2ac/51nG9pSGL2Xwym3F1KBri1aQoYjm
 dCBvi4PjkKZYbqasddvlNSKwUZt+0ZLYZ1nhsfuYa81Yly07zM8y7+hM3rJ/0wziCjnWoVJ4tXH
 rJ4azo/KXMYmAU+r/FdgergdaR+3R5tkIUCbHy1fN5M3kc0r2zXeebmkpLYY8E7duOpk1nCGcCF
 C8RUIYI8Hu6Ybl6b6T/xXqXSqgq3Ny7NibZuPDmw2aFWyLxqETkUaAWSwdIBNKPqhjTUzLFIbuQ
 6olCskY/EX9QPRrSgukb2jwlHgVaJDw1n8gEvIDqYT3StkUVh2DgIivdUba2/Pb+5T//bcrOxwF
 hgIuyy7VH8iDTGYWxB1P4QR5c1TRXIeNL6NpT0MRY9WV9i2s6TNg3Q9X8CM4AEKtBL+AH4RO8K
X-Received: by 2002:a05:600c:46cc:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-486fee230d1mr51481725e9.23.1774022923353; 
 Fri, 20 Mar 2026 09:08:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8359acsm70490645e9.12.2026.03.20.09.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 04/10] target/i386: Replace legacy
 target_monitor_defs -> legacy_monitor_defs
Date: Fri, 20 Mar 2026 17:08:04 +0100
Message-ID: <20260320160811.28611-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Expose x86_monitor_defs within target/i386/ and register
it as CPUClass::legacy_monitor_defs hook.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h     | 2 ++
 target/i386/cpu.c     | 1 +
 target/i386/monitor.c | 7 ++-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b0c730b3390..7420ee3b8ea 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -34,6 +34,8 @@
 #include "qemu/timer.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 
+extern const MonitorDef *x86_monitor_defs;
+
 #define XEN_NR_VIRQS 24
 
 #ifdef TARGET_X86_64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e483e8cd2..c5d9c51c1ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10745,6 +10745,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->gdb_core_xml_file = "i386-32bit.xml";
 #endif
     cc->disas_set_info = x86_disas_set_info;
+    cc->legacy_monitor_defs = x86_monitor_defs;
 
     dc->user_creatable = true;
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index ddc666d3451..9a0cc73bbf4 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -599,7 +599,7 @@ static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
     return env->eip + env->segs[R_CS].base;
 }
 
-const MonitorDef monitor_defs[] = {
+static const MonitorDef monitor_defs[] = {
 #define SEG(name, seg) \
     { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
     SEG("cs", R_CS)
@@ -612,7 +612,4 @@ const MonitorDef monitor_defs[] = {
     { NULL },
 };
 
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
+const MonitorDef *x86_monitor_defs = monitor_defs;
-- 
2.53.0


