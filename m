Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B37CC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgZ-0007Vl-WB; Thu, 21 Mar 2024 11:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgT-0007D7-Pr
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgM-0001nA-79
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-414633f7a52so11074275e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036215; x=1711641015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LWS7xvFoegnF0mSZFeKjpH3HSq3m0fIT12twQQtV6g=;
 b=GIJEQf922Ov9ko0AHycgKkxdholgPW4TsZEYJIp/JtC+udhgtiBLppSC6DU9/YiIV8
 Moj4MlkPnPNxe9jAlF3mFtTcnwmjQNYFcPx+iHLDJ60Zl3YD1o52r8KyVGCcBW3sxfDh
 iiEkt3eNlNl9gSanFoiAPZB/S7+3J6oQxI2Zv7XqdPg09yDUlcCDyXZYf5dZ40lSbmuI
 BuaCPDmfnmbhvL0uWvQPU820GE3d0i/lXJ8tQ12q7VJD1v14R8mxLbyxjm66gTf2oXr3
 03Lk2CVMV5RyOjX6aCKLR/ur2E7Naet5SfMCaBkCcdoTRjimWet7TUqjMkZ11jlrdyxd
 FnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036215; x=1711641015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LWS7xvFoegnF0mSZFeKjpH3HSq3m0fIT12twQQtV6g=;
 b=w5qgDKXdBE2VNFwDtTI/jIS0T5R/MqIn6xd5UMxt6zFPUbMle7UsDjVoT+h4PxYp6T
 tAxXnKHmQoam3T82IJsBwDTt+hfqij1ffHhoTNY9agP3Jha3qOCdm5PdhY9V/cHM+NIS
 lM/lAzQCqL6y9phjMxiAFBm/vcUwjHUVQuwjimSSJIqmWGJ9KDr8dE+l2cTaHMdN6rr0
 IvYgYTsrOWQxbE1xmZZJRvtSHiDqtEjkLd3qcouOmgYAGAc8+lm0C6l66L9/70ka0FPD
 Q1ibQ8D9GAJUKuQIAPDms6eFNQy8miNl2WxrIQPXlgMTf0kDbuzyKru3ss4rklPa5Cfj
 VG4A==
X-Gm-Message-State: AOJu0Yz/0RrWgw75hp2556XG4QchdwrLuBr/uWXLTFQkilfccwVmT3rf
 juS6LenuKZpw58A5G0J7LENAWGZEBt62xQoXBYoKqJA50p0oFjAvZOpnFQfT18IUIvaizueo/g8
 hS18=
X-Google-Smtp-Source: AGHT+IEeQPhUy7k5Ot/s/fwB1HmG9WBBgDKW6+YXl8dX+9y6uFk/adnRBaAFqSwIZ5/3x8GqHetqlA==
X-Received: by 2002:a05:600c:4e8f:b0:414:1fc:2ef3 with SMTP id
 f15-20020a05600c4e8f00b0041401fc2ef3mr2378590wmq.29.1711036215092; 
 Thu, 21 Mar 2024 08:50:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 iv13-20020a05600c548d00b0041463334822sm134735wmb.26.2024.03.21.08.50.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 12/21] target/nios2: Replace qemu_printf() by
 monitor_printf() in monitor
Date: Thu, 21 Mar 2024 16:48:28 +0100
Message-ID: <20240321154838.95771-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/monitor.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
index c6043769e4..983c16d7f8 100644
--- a/target/nios2/monitor.c
+++ b/target/nios2/monitor.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
@@ -32,24 +31,24 @@ void nios2_info_mmu(Monitor *mon, CPUNios2State *env)
 {
     Nios2CPU *cpu = env_archcpu(env);
 
-    qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-                cpu->tlb_num_ways, cpu->tlb_num_entries,
-                cpu->pid_num_bits);
+    monitor_printf(mon, "MMU: ways %d, entries %d, pid bits %d\n",
+                   cpu->tlb_num_ways, cpu->tlb_num_entries,
+                   cpu->pid_num_bits);
 
     for (int i = 0; i < cpu->tlb_num_entries; i++) {
         Nios2TLBEntry *entry = &env->mmu.tlb[i];
-        qemu_printf("TLB[%d] = %08X %08X %c VPN %05X "
-                    "PID %02X %c PFN %05X %c%c%c%c\n",
-                    i, entry->tag, entry->data,
-                    (entry->tag & (1 << 10)) ? 'V' : '-',
-                    entry->tag >> 12,
-                    entry->tag & ((1 << cpu->pid_num_bits) - 1),
-                    (entry->tag & (1 << 11)) ? 'G' : '-',
-                    FIELD_EX32(entry->data, CR_TLBACC, PFN),
-                    (entry->data & CR_TLBACC_C) ? 'C' : '-',
-                    (entry->data & CR_TLBACC_R) ? 'R' : '-',
-                    (entry->data & CR_TLBACC_W) ? 'W' : '-',
-                    (entry->data & CR_TLBACC_X) ? 'X' : '-');
+        monitor_printf(mon, "TLB[%d] = %08X %08X %c VPN %05X "
+                       "PID %02X %c PFN %05X %c%c%c%c\n",
+                       i, entry->tag, entry->data,
+                       (entry->tag & (1 << 10)) ? 'V' : '-',
+                       entry->tag >> 12,
+                       entry->tag & ((1 << cpu->pid_num_bits) - 1),
+                       (entry->tag & (1 << 11)) ? 'G' : '-',
+                       FIELD_EX32(entry->data, CR_TLBACC, PFN),
+                       (entry->data & CR_TLBACC_C) ? 'C' : '-',
+                       (entry->data & CR_TLBACC_R) ? 'R' : '-',
+                       (entry->data & CR_TLBACC_W) ? 'W' : '-',
+                       (entry->data & CR_TLBACC_X) ? 'X' : '-');
     }
 }
 
-- 
2.41.0


