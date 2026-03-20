Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C8109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPW-0000Pe-8j; Fri, 20 Mar 2026 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cP8-0000Dn-NY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cP7-00007S-9j
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so6552095e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022931; x=1774627731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMnOlXN+D9n0MPCt+seKokGBkveTPzJtDpLcR65ZSEc=;
 b=S2qcYzGOZPpL+Om0M7jlqMo1QWTfckPd05XsX4EHcN1UAzvL8FwvV/hBQXhf/Pmi4H
 NWnz5PNHE6ZYZO8o2j2Outp5vljHEXaSm4LmRzsv+2v54zFuk7rog+UmCxH2H+q40O9T
 3KcGsxrl6m90xek4tllgR5krDptCfbmQdpEeYppP5yTE0jFpPPYmsoS4MSn56bBnYxwh
 OakDKBJstoDhhpBNfnFf89yLIdpWm7SocOfw33MZ75aR7GT3T9g4mu45PaLa7MpfBVaM
 ATcyDYjzBKq7m0Wvu+P1DDVxw8x9nLFuXMoMVGhXdbD6FLJIFbvemhvJgLkCCyvLf98E
 uWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022931; x=1774627731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMnOlXN+D9n0MPCt+seKokGBkveTPzJtDpLcR65ZSEc=;
 b=dWpEPOoTKFjpwGy3OPvI1G1qlqlvAt0EQqpAYuKmDAbIu5+rAQGGhMLJPTw/DJWfwc
 OWaGgWcAb4T1CVo75wkQCIKWrLoFYN2WTuIKjuR3GwBYzQEzfQBS/vkm5Db+OiIHcfSV
 C8dhS4jSdVQNTSoAD5xKuZAsCE7ZCKCdGaAaDjOc0GxJGAXBtXsqc3MKYLV7em4OMBVE
 wEyiqMDe0ymy48xoL5VtmYYNHspK5oSG8r95xZxnmNB8eMwgd+OKq+3qIDIHyDgrI3cg
 cHT7OLOy9sh9o2asNQSNYZQag8+y0vT8EbCfhH6ZD/TcANPct2aD1zIm95HXMK0oc/zH
 R4dQ==
X-Gm-Message-State: AOJu0YyHZlFCdyeOC0dVej2N6zhGnD9G4zt+EqWeRShpfCGnCihpT3qm
 /avzIwrQW9pNZjotOOkCy+gxKDeEj/BYPTlS2SgCuwHOq/up8l5pkhVWsLs/pv+rCYUWnYvjtvI
 qir2CFHE=
X-Gm-Gg: ATEYQzyliTnRBB7IPTW3Czzcym//0t8BK9PgGlFFLvneiL10Gi5XpL5hIzJ7GIPGOGP
 Z+2rBrYXWpqUL4Jlgl1hBz0o5+Ib3vl+eayY5qAgB63RtaUt6pCS4jRegsdLLquWmMEb7j6s2SN
 aOvXoh0QI5OjB5RAr71sf+h7XGUBVJuZICVLwBGEm2QNjAchWU7umLOUF+zBSVPZAQVE7S2lSIX
 APmN4BdibaJq9+J1vxLs9yfblWj4N/FJwLPIdCUjFnZmub2JaQjZaTVX/QWW7U4Vsmu6kHJgZtK
 PbOjZP60m2stR/WH8fhJH+hnxq0KlsU1l5NUX7CokGjnQ78QXFmgN/VdPyyUv7FG/WtygUxWdPK
 6nlrzLYOyCSBUUj/Dx+OmuAcCyXyF32SoMvuAMHXBfCIJl5WIeYykL6nqPs9yrboIXF/BnBYyKR
 h1BXZT9mNAAZjg+g9oF14kZCfWQ21Z4KMFAOY1hWy60Vq7WYJV243ZskwfuZloDTK4ZQZssGgz
X-Received: by 2002:a05:600c:8b0a:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-486fee0fb9emr55283885e9.22.1774022930523; 
 Fri, 20 Mar 2026 09:08:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487017210dcsm36789405e9.10.2026.03.20.09.08.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:50 -0700 (PDT)
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
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH-for-11.1 05/10] target/m68k: Replace legacy
 target_monitor_defs -> legacy_monitor_defs
Date: Fri, 20 Mar 2026 17:08:05 +0100
Message-ID: <20260320160811.28611-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Expose m68k_monitor_defs within target/m68k/ and register
it as CPUClass::legacy_monitor_defs hook.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.h     | 2 ++
 target/m68k/cpu.c     | 1 +
 target/m68k/monitor.c | 5 +----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d7f508a9e80..6f19b53158e 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -26,6 +26,8 @@
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
 
+extern const MonitorDef *m68k_monitor_defs;
+
 #define OS_BYTE     0
 #define OS_WORD     1
 #define OS_LONG     2
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90fc..fcb14a44793 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -655,6 +655,7 @@ static void m68k_cpu_class_init(ObjectClass *c, const void *data)
     cc->sysemu_ops = &m68k_sysemu_ops;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
+    cc->legacy_monitor_defs = m68k_monitor_defs;
 
     cc->tcg_ops = &m68k_tcg_ops;
 }
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..97ec2bd38bc 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -38,7 +38,4 @@ static const MonitorDef monitor_defs[] = {
     { NULL },
 };
 
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
+const MonitorDef *m68k_monitor_defs = monitor_defs;
-- 
2.53.0


