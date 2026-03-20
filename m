Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC8510987A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPg-0000Vy-2B; Fri, 20 Mar 2026 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPU-0000OV-Jz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPR-0000BC-ST
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso624140f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022952; x=1774627752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icGx1lKtn2JaeqNOWfyUHnero/ZziN4kze8hbSKogNs=;
 b=yWaFrriQ3/q80clj9oiZGd5iiHwCr8NkOCndjOPNqdcV/fbfTy/IQjuDRFQVPruVMa
 xezUeBDIEznFfraW1H5NN+bF+iOyTNmr6xirpbVR+vR714lcVMEoR9WSS0aeT22F24I3
 wcGWuePWS6oISkSBLtYPWwKWkMvqJgSQ1NkkGn3PpWZZ91vQ+BUsQGIjEBOvYvR76OXP
 YShYQS9Jv1frMwnzV7BBztoETgfj5OmCyK6YluFfj6RHW06YWU/JWK0JIRJ7kXzMVWrR
 lUpQ8ohsxwmOlf2EFUbJiuGG5M/4mp02p9ZcMLjFm9iuxeKs6ULnGf/+RKRQgl/YTyNS
 upkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022952; x=1774627752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=icGx1lKtn2JaeqNOWfyUHnero/ZziN4kze8hbSKogNs=;
 b=QySs0aBfjhnOdcjhWpFmoNNCsBg3lyzqze4auEOGyT7yga8f9tehO0Ws1OBvvgbnsq
 FVcLQyLb4vE9GEKVDD4PZNn8H5PT2+fF+9w/pLBA7rEUgXPp/o4oHrVEGJj8drj6zNY7
 AoHoE9G1xQ0rtQ1wS9esqUyfrKkWK4HdiQzUkqnog29aIzwW6G+Isny4x/2E/7wvhCWZ
 RtK6wRxeFK51q+TpuODObrrDTw6OKjyzhTITKSOn/5pyyNDgNZLBQlhAdOzYsd4pgWN4
 zWIh0gCkpgUypadl3T46Fg6/wcetM26uS4PEkkvpGzkLgB0HYFB22RrYBpzOTdCJde9H
 PH3A==
X-Gm-Message-State: AOJu0YyPLjUREHeZPcJ4nYEd+Htyxa0VXC1GdPBO6gCud3zjLOrviHar
 hlkT7sOnX4YW1JqbkFLGNMEEvAsjNrJRjHQPggwh1/s6FBZ+0quTXQeJo+EBNiYlUKVOCGuDsHx
 k11jgR1w=
X-Gm-Gg: ATEYQzx/6VBpH1NJyLlrDc9rSHlQfVDJzdnSIhP7qNn+baVcI3FATnjgDM5SBcXdgy5
 NztKZHtjMB40rOU7NszP8KORQD9kDCN9emsvfd5dxSD+zbE61f2eXBQcqlrVZ3IMvp+cetSsHx0
 s58/RK/YpWntOYepLbaGgHcl3PvuwLHR00T6k/KIt7l1mZLvLwdB2x46Ltr4A3oIBGW+hm9mUuV
 5aK6Eoh2Iwq93P774jt+BRfS4aYD5xyhZq5CL0+LMUvjQZeGesv1xhUl84a5R6g1UN/d0L7flWm
 VWaqcKfFRbft0tNHQB69fKe8+XtxE1W7aFaeduBYptRK7wMwWFNBq90ioN2pwp5op3HKYwO9vrH
 1Z8lICi+tcWUqVw6Fl9SSuMbyupSPATmX6/2W6N7XV81oFRnLr2qFp+gc/Q0tR1bBYCWryHgcgq
 jEXFzRmzXm6qQ88uruRubYLVH1ixqLx86uDCraa/C0gRlHPwSGDPYRD79SPL0fBS6egId+uusi
X-Received: by 2002:a05:6000:2089:b0:43b:5188:f59f with SMTP id
 ffacd0b85a97d-43b64281b07mr6347628f8f.45.1774022951762; 
 Fri, 20 Mar 2026 09:09:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm8059695f8f.17.2026.03.20.09.09.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:09:11 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH-for-11.1 08/10] cpus: Introduce
 CPUClass::legacy_monitor_get_register() hook
Date: Fri, 20 Mar 2026 17:08:08 +0100
Message-ID: <20260320160811.28611-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Allow targets to register their legacy target_get_monitor_def()
in CPUClass; check it first in get_monitor_def() otherwise fall
back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 5 +++++
 monitor/hmp.c         | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 072f58bead5..8f9d62bfafb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -150,6 +150,9 @@ struct SysemuCPUOps;
  *          CPUState::cpu_ases.
  * @legacy_monitor_defs: Array of MonitorDef entries. This field is legacy,
  *                       use @gdb_core_xml_file to dump registers instead.
+ * @legacy_monitor_get_register: Callback to fill @pval with register @name.
+ *                               This field is legacy, use @gdb_core_xml_file
+ *                               to dump registers instead.
  *
  * Represents a CPU family or model.
  */
@@ -177,6 +180,8 @@ struct CPUClass {
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
     const MonitorDef *legacy_monitor_defs;
+    int (*legacy_monitor_get_register)(CPUState *cs, const char *name,
+                                       uint64_t *pval);
 
     void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 6dfc59725c2..ad253347892 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1628,7 +1628,11 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    ret = target_get_monitor_def(cs, name, &tmp);
+    if (cs->cc->legacy_monitor_get_register) {
+        ret = cs->cc->legacy_monitor_get_register(cs, name, &tmp);
+    } else {
+        ret = target_get_monitor_def(cs, name, &tmp);
+    }
     if (!ret) {
         *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
-- 
2.53.0


