Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB3810987A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPo-0000YE-K8; Fri, 20 Mar 2026 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPN-0000IH-7H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPL-0000AK-0R
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so1472999f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022945; x=1774627745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSHR+Q0/Lx+3SnuhBRTWXv5gGgManK5h34FNx34FzIA=;
 b=RhPSetb4x/hd9Um35A9PLjkg7I5AoEJlPhPxtc2RnmMbu2nAQ+TKh7EtOHeish7eEs
 qL0f9tw+mUdoGx6DnZCbDwaGBzdX96dRoPntxj0TzM688CchpqGQwymTH0LOV3tn1Z6K
 GrneQ5x+zqmtcXT/ZDwN/EFc97RJqvJ+yOJ21j+Ro22qTGc1wBtcOf0nSbBRnPEHSh55
 NsQmiqc0xHcRA6FgzCubIJw2BkXDl5ZcHyuSNPDCZ+nCn7I+89blx64VE0bdgOjBRC6U
 vXdMc5DQga/2+M22Vt/Xx9DPevVxjts0wcbiv0pFdwOOrGmcZWZBovEsBfU62fa8lydf
 a8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022945; x=1774627745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XSHR+Q0/Lx+3SnuhBRTWXv5gGgManK5h34FNx34FzIA=;
 b=X18dtTD6o1J713uLUcQxNAzB3Qi2ZWchvDsaVdgKj55xo6byo/zQVpaWdXtfVlZYVm
 Th2YjHh7e02DVdQIbgdr+rIWHNZJGQwVPn0yu5eyPdteom90CX+OXIYTpmxozfUlMDM2
 NWJAp+PwbLzQAlmglgq3T7boAsRnnShMPg0W2OB1LmLkAxWS8iDTTYB63FwcW7diT5IS
 9UwuQfvfPpnAfF/0gv6vICzArLGyVQUgVm83xbXejEqw69poTis8Fr0Za1xUHa81FnzU
 QLwRg6Yi87Mxy0ajGDiIHhKadqi3DviDw6TnU9ptykU61OmcjbpDBAdcHge2qytky34p
 fwnA==
X-Gm-Message-State: AOJu0Yx2oipQVR56/kUgPHnYtxQfQh4+Jy8ybVyo0lAoJFAS5uiaiKfV
 qLL4TO6WVTPOyZu++7QjoVLsZarUzlMJVoWqNTmyO81HyG6PwCJ9wOZCNmJPDEWXSjPV38uchss
 W6km7Lj0=
X-Gm-Gg: ATEYQzzz2yjdRNatbYYv2q/ikNpuew1fiaA9natsu9hktsL4EhnyJydQCM8jh5FbWWY
 Ku0fzGoJuABdXVG1CdJslFuUkuQJQ0jfsb7UdvR2BFZJVzEssxldm9TG0wjZ5WaXplpbdNuF8DQ
 QuTs6cTZJA8EBIAlfBNfI5S4BHgXRaSyXUTR2P/4ZLSrVpBaKIUT2CiwYeQ4hqNPgfmqikOyEI4
 y1KaxyRDO08OD+PrlhvemfppvORJjdHYkbBsjY+Nvvs8KCJ9T/uehC0qloqC1l86l9X3lO60WrL
 Px17Nu6CyvDkNswZEJbxry9PpWjoSpo8dNxQcjXT9hDzmIK2yltyTDPEXiEdbhAcoDCQGglMyr4
 05G1HUFiJwYTYFNytqcjEM6qjNhp58c1kntlm8Hrif1ohFM/Bz8vwJ435w934ZiLwVtSG/Jl1gx
 873C3tXISh4jY5gnY5dBJZqYC3dxfG1gbkcffB/qhBNiEoTs9dhxzy3FujlqjQ/eZDqIyIbhwr
X-Received: by 2002:a05:6000:2f84:b0:43b:5462:1807 with SMTP id
 ffacd0b85a97d-43b64243233mr6619827f8f.11.1774022944644; 
 Fri, 20 Mar 2026 09:09:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae132sm7433997f8f.6.2026.03.20.09.09.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:09:04 -0700 (PDT)
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
Subject: [PATCH-for-11.1 07/10] monitor: Remove target_monitor_defs()
Date: Fri, 20 Mar 2026 17:08:07 +0100
Message-ID: <20260320160811.28611-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

target_monitor_defs() is now only a stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h       | 1 -
 monitor/hmp.c               | 2 +-
 stubs/target-monitor-defs.c | 7 -------
 stubs/meson.build           | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 stubs/target-monitor-defs.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a22cab4ae37..ea7e53060a0 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,7 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
 };
 
-const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
 CPUArchState *mon_get_cpu_env(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index a2b6269d0ff..6dfc59725c2 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1605,7 +1605,7 @@ void monitor_register_hmp_info_hrt(const char *name,
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
     CPUState *cs = mon_get_cpu(mon);
-    const MonitorDef *md = cs->cc->legacy_monitor_defs ?: target_monitor_defs();
+    const MonitorDef *md = cs->cc->legacy_monitor_defs;
     void *ptr;
     uint64_t tmp = 0;
     int ret;
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
deleted file mode 100644
index 0dd4cdb34f6..00000000000
--- a/stubs/target-monitor-defs.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return NULL;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 7189ff63ed5..10eb68ab55e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
   endif
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-arm-gic.c'))
-- 
2.53.0


