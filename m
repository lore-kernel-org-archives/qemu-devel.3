Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A1106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwI-0000Jp-3q; Fri, 13 Mar 2026 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vw7-00005n-J0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vw0-0007Dz-Cw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so18700515e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383021; x=1773987821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ujva1C4esbGqaWwr4Zai0iO4SD/zstCnPI43jRsjM8=;
 b=xwxuJPH9quNH8T4naofcDfgo1A7uA/+BADxGE56EwYffX+0z5g6TtaW9UCxVlgTJxA
 ziOjtBlwNRPbBAHzjXHWRH3aLbKwHdh5yqHowSC3V7EswQflAJPX4hYvsqhufu6hW4cA
 XNmKBDO+GjKnZV5vNeThh1gyyC7ygKtvN5UoYhtEgKwh9kh6IsdIS0x+rBHO9/fed2uy
 He+SzA+/yQqzN0f7QshXEofQKWsg39E6GsiWP7suzuMC3HY8fdwp9bra+OAcFT38U8+P
 cOPtrvN+qOOmP9HepD4ia9bUEGn1CwOu/q1v6K2Q4OiNNycBGqnQWi99IJ8PegfHOZnF
 M47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383021; x=1773987821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ujva1C4esbGqaWwr4Zai0iO4SD/zstCnPI43jRsjM8=;
 b=BXl8FOJtuuP+fbg1eUAMmTxnwPnBJ1BbVN8HhWVJ+IWAJNIIzktOQi3nNG+VTcXf8V
 RTGMdQCTerum7T7DrU8mx7Lr6B/9wfBMVJH1VpxVK0JBwn2vR20L3BJLloSF5GZa4tAp
 V8kkBjpsIFvwNMaQaJOyhV30sktNstcvlVKGCt2TLrguTzMUCXA4gZbleYE0zxQJBA5T
 5B7nhIyBQ6qPL0jygytsnWUzUWnT0JtcImCAdRv65ogfYYwQwRPDwtBbGkz16wZAyTWn
 4kTthrRXPrK+UW26k/xzXzFkw8HDradOSjY3f29gOH/jvn2AxKoqQZHFh425rf6XqAUf
 dcvg==
X-Gm-Message-State: AOJu0Ywz8pPJBuGYQjXq/caRgDPYvMKlInci6Fr+cM/pyM76Plpxgpo7
 gxoCUaDg6jDybtbR6RDVBfjaznB3yjnnEHIbrPjCYGN9Uz8+b4ByC19AX11xDOMRaAvQX+OYkS5
 kM9WzdB0=
X-Gm-Gg: ATEYQzw6Awe59f2lQ48Qm0eyIod057NDcMQ85UDiXmCRCjIcaNqLBN54+Z7rl9KRBVk
 aUSp2dVj3ODVzkePhMjt/187Ng/aWluRxOwMWWxZhnHrA/5/T5t6zdwaKYyfYKCmb/CUsa05EBu
 6+Mt6axbvWBxbzVY63grs3tYBWCJSV+6jXnnvpBJHW3LXUuN2UdaDsO/D3yxUuv1TuVKS7dQRVg
 gc37II1i7I0o3juuQQ+bnOgfUmrE7/k3jTM6pDBG97ANMw68C8DQzXsGgFDyeIE0oazJ7BoRHYE
 1LoEyVWfMsgXajhCqz8ABMw+HREUDzgxcbYdEmDSUsxbd1jDJ/azm4y8Mp4JUSnrcGmRB4pXnpX
 usuQ3x6XoJILMFb91mQn7dCnKobbRZTCK+GMKzvBRSfgwV4FkcDuNl5lx2p91FmyliqTS5UgxoM
 AqZwopmE5DkUnv2vRZrMWOaX3dg0lVqc/E22iEwIgSJ6vzTEQZDDGUB2R4DkNCn4BOq0fvpq7AC
 oxrS+KM7x4d9tt+
X-Received: by 2002:a05:600c:3552:b0:485:46fd:100a with SMTP id
 5b1f17b1804b1-4855670299dmr27922075e9.25.1773383020726; 
 Thu, 12 Mar 2026 23:23:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm180544445e9.4.2026.03.12.23.23.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 24/38] hw/i386: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:40 +0100
Message-ID: <20260313062055.2188-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/apic_internal.h | 2 +-
 hw/i386/multiboot.c             | 2 +-
 hw/i386/pc_sysfw_ovmf.c         | 2 +-
 hw/i386/vmmouse.c               | 2 +-
 hw/isa/lpc_ich9.c               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 0cb06bbc76c..a26d53bb9d9 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -21,7 +21,7 @@
 #ifndef QEMU_APIC_INTERNAL_H
 #define QEMU_APIC_INTERNAL_H
 
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/i386/apic.h"
 #include "system/memory.h"
 #include "qemu/timer.h"
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 0e960a15dda..d544b62afbd 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/option.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "multiboot.h"
 #include "hw/core/loader.h"
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index da947c3ca41..196eb0c83ed 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "hw/i386/pc.h"
 #include "exec/target_page.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 
 #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index c1aeeca0c9a..20ebb0dbbf6 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -29,7 +29,7 @@
 #include "hw/input/i8042.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "qom/object.h"
 
 #include "trace.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 51dc680029d..9cec18a378c 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -30,7 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/i386/cpu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
-- 
2.53.0


