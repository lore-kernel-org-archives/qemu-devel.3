Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F5F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRiD-0000w8-7Y; Mon, 13 Apr 2026 20:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiB-0000ku-A5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRi9-0003Tf-Lb
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf906b007so2985560f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126780; x=1776731580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWkinHow/eylS7JBe+fWXt/Nq4YrC48hyztEBorpfGw=;
 b=nK3t8jmhtQO5RI4gnnisp8pJg3GE/3iuDWY0WOyZK/2z7rW0lJAX5FSIBncYFvvDmu
 xhTjXen1rgEw6oP75MQ+9cyKr1iF6fo3MeMEEPDHFvBj86/j1YuMIJHlUHoEDadUbMxV
 KOTQ/K4e2N9TkQZ7onCVK6+1cu4Ci8qDNiirQ5p4an6Jn22Sq990K/a4Wdfb9efGQkTJ
 Ppjlo1tkZkMbQMz1NY2PmqwBnKpeMU/E/fgK2rqPsmAd7jRZfzCv+e//T3nX0kZaJqY9
 kh/FVGYVsGlvslS06eFJI2l8hBizpQM/y4zvnvqXkKgHZBMDW4b5JmSQf6P+gDedvwRh
 nSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126780; x=1776731580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWkinHow/eylS7JBe+fWXt/Nq4YrC48hyztEBorpfGw=;
 b=VZFgXZPhDic3kCSutU1mmX20pyRzXemS+WNEtZye+fz2xL/Z6/gLghpUpfnhbVE5ey
 ZScdqLDid3fahuPRnxnkJ1EWw98L9QRIeTidSwjVShh7Yo2XgTJHGQX8y3vVP2geEh5H
 gFVdskF+odL8d3Iq0su0ekJtMCU/SNFzckZ2Tur9c/q27csIjJiZce0nCTxi0i040y8m
 W7Ja35d+KFGa+wJxGwXLfte9vbY50oZhYsAlHOtjVrDXRZsn+HwxEu3Ia+IW1ilFr8EM
 /FjKkG23o2bLGjhZPTkNuee74gs8e1s00H2OmlBK/FHx5PhXyHurUchdqf+jyeaIcNhd
 rP2A==
X-Gm-Message-State: AOJu0YzxaTVOnn2bp6VcbdBSW7FGiSUjNYhNHKiZUerEgy2Bpk6CSUgI
 IzXbPHdUD9AZy84RSyoG1GuK6jbYefYxUJy4lVS6Ax5upBv/uJQDu/BsuxsPq2BCJGpAGI4JHD/
 hOhHSh+I=
X-Gm-Gg: AeBDiesIk6sktejIhiD58K2j2ncuU6Jq0PR+m7jj7diiTg3wfz7bUn1weLyOJd9rh0h
 CbjT6wKYOY11Y6uy/Uv9n/yk9hi1VS7nFdHq8+SNY+Ct1j143xmmq1Qa2cnjaHBBJ6+GGoIKl3g
 x5XpvAJ63XGks63VOM3NDkYdg/v2GBfYBuEXEVPZ42Z5JecdHUmDn101sFNHF6pyenoeoE1r1Qj
 V/oV/bIaIYSK/walK8mj/Ejbvh9XkoqU6ydoABwDD29/7ICEpI5sdWOypwpStEoqDir+UWuSn2t
 VBKhSzOMXTjACUs5v3z3eaQCfKaV76LG5iKUoEZPUxmCr3/xlfWuKeJwyWw4ffKm5riyx7nt6pu
 3Z/DVzQyg4Z2dqE7buzp75tRgVXlDDzrhkYnXZPww6ptbfyj8BqicJszNBJ8gWw5HvgKRizMoDr
 vDz7MtvF8X2PvgK1VpNZFE/S0GvuZ5AQWAYnReY1m8uz1tjAGTstxF67bmbUm/678KvJN0c5vL
X-Received: by 2002:a05:6000:200f:b0:43b:9a9f:8956 with SMTP id
 ffacd0b85a97d-43d6428e889mr21221402f8f.22.1776126779907; 
 Mon, 13 Apr 2026 17:32:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46713sm37894676f8f.21.2026.04.13.17.32.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 24/27] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Tue, 14 Apr 2026 02:29:56 +0200
Message-ID: <20260414003001.97571-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Restrict m68k_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c     | 18 ++++++++++++++++++
 target/m68k/monitor.c | 21 ---------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90fc..f704a6af613 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,6 +25,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
+#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -602,11 +603,28 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+static const MonitorDef m68k_monitor_defs[] = {
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { NULL },
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .monitor_defs = m68k_monitor_defs,
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..3e0df40a6b8 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -21,24 +21,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
     dump_mmu(env1);
 }
-
-static const MonitorDef monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


