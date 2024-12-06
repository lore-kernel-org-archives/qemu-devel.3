Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE195E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdjp-0005uG-NR; Fri, 06 Dec 2024 14:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdjo-0005tu-77
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdjm-0001dz-Mt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a83c6b01so16450605e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512297; x=1734117097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgcNNQUYfz24Ofcaa3/V/dRBkc53lWEecigpnwJFnlA=;
 b=dCdvq1DM0BTfnWliKjfgqLw7lJZmwV4sHC5KQy1OhGGCbJlEw7BbMdl+PeOtcHpBpb
 /9pyyuOjVmNI/MTAzmgw8oTDJy56oKHdZikt3NGB7qw65vyWA3kbh0hhoVw4XF74JfWN
 GEV8v2fZ0hs0/nUONKqTz2uA47n3Pehj8Wkf+jGXyVlFsS50k7gIaLqYcM4h7krh1rQS
 6hotQNpf59TCdUmfEHlzQoY/vhvpdUOzBmJ23vSjrCYWv9SRj9gT6kwOmUslcGJcK6Dz
 zicDySbniUB3nxt/5sNp9rq+UStcBKtGdXbUMVJn18nei7yh8R/Jx6WR1Gu4lRHQ5ujv
 rnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512297; x=1734117097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgcNNQUYfz24Ofcaa3/V/dRBkc53lWEecigpnwJFnlA=;
 b=XnO5nCwUQSB1SzKL5Il7btRsnja1Fno7pI/9M4/FFRWJ/CqtNNNoSDgRKEQbgzL4d5
 NXwWtaDKIhE64a2vQJuPTEn5E5VmwhnR7e/KJvuKJhs71EjT94CGNR8+ILB0Cbv5y5KV
 Jw7/lIjsPGi10lIuSM83+XWUrkPOXgtp/k82Z06QRYNjJf/MF2bdCmJHZmfIg0sRnXDU
 5IB33VXHzhYKyqBZbOQE1bapLmL0zIlhgfE8jWXh9hkVmQHMwDazv133nsokNXCJ+aYU
 /lF3LowDpQP4pCYjE9VB7LIxiSuFRPwsjCSUZh7mq1PcuEJb0AyqsjkenJj/ZVag3rqF
 im5w==
X-Gm-Message-State: AOJu0YzbLMQTa+PDpxO04bbQbs6MvvbSvYbeBsAeAkb6Z0OAPtWFdoiH
 wmtEBWiRA1xM3//ruYfxcfTpWWzrPIphjg3TRflxcuYjMQRnAg0I3efQcDW56sWvHI3qHy48L6d
 tNsQ=
X-Gm-Gg: ASbGncu1OnzDdKMMPx6gbrHqgqr/cfBlt+ilE3X1829ndxaasQHHBP3pBqHhNU2DEko
 BRtRZ6FS6Na1dhDsiARZOw3TcDGTBHioCCQ+vdVHaapWpIgXcV+UpLiC3droGjx6iE05/UsnUgM
 IEpbTX8t8hgk5C9CaGgCKp6E+r4XF41C131NibroLZPcEH32947x2aqjVWKqidU5Fzd8Y0Mjs32
 kzftEDKIE8T1AQFAltQ737JxdIV9hPUXQ0+K1lsaGKBWYuC+GTi+tYgDD9YKvkuIDw=
X-Google-Smtp-Source: AGHT+IHa08sSewuMjolYRRvxoGBAWXes5IaEwzPvDvpZBiW6JqK2fOLRR9cgeRSC6IKhe9NcSH1EKA==
X-Received: by 2002:a05:6000:1846:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-3862b3d5c9amr3188655f8f.40.1733512296763; 
 Fri, 06 Dec 2024 11:11:36 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d26b0sm66778295e9.9.2024.12.06.11.11.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 11:11:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/timer/hpet: Introduce hpet_add_fw_cfg_bytes()
Date: Fri,  6 Dec 2024 20:11:21 +0100
Message-ID: <20241206191124.9195-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206191124.9195-1-philmd@linaro.org>
References: <20241206191124.9195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Introduce hpet_add_fw_cfg_bytes() to restrict accesses
to hpet_cfg[] within hw/timer/hpet.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/timer/hpet.h |  2 ++
 hw/i386/fw_cfg.c        |  5 ++---
 hw/timer/hpet.c         | 10 ++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index d17a8d43199..d361ab9e931 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -85,4 +85,6 @@ static inline bool hpet_find(void)
     return object_resolve_path_type("", TYPE_HPET, NULL);
 }
 
+bool hpet_add_fw_cfg_bytes(FWCfgState *fw_cfg, Error **errp);
+
 #endif
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 0e4494627c2..16f806e76b1 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -26,8 +26,6 @@
 #include CONFIG_DEVICES
 #include "target/i386/cpu.h"
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
-
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
     static const struct {
@@ -149,7 +147,8 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    hpet_add_fw_cfg_bytes(fw_cfg, &error_fatal);
+
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5399f1b2a3f..9ca1424565f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -36,6 +36,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/timer/i8254.h"
+#include "hw/i386/fw_cfg.h"
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 #include "trace.h"
@@ -86,6 +87,8 @@ struct HPETState {
     uint8_t  hpet_id;           /* instance id */
 };
 
+struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
+
 static uint32_t hpet_in_legacy_mode(HPETState *s)
 {
     return s->config & HPET_CFG_LEGACY;
@@ -777,3 +780,10 @@ static void hpet_register_types(void)
 }
 
 type_init(hpet_register_types)
+
+bool hpet_add_fw_cfg_bytes(FWCfgState *fw_cfg, Error **errp)
+{
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+
+    return true;
+}
-- 
2.45.2


