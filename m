Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C913C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQo-0004uk-64; Tue, 18 Feb 2025 11:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQn-0004uR-2B
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:45 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQl-0000kS-El
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2e5so2338602f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896002; x=1740500802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0a66yVnUC0E5xDdPgIBrEynWgyX5dbe4KJOQ4kO7y1I=;
 b=FhVWBU41o3GwLXVax8qu1QmIjYesRP4jpuI9uItTdndzaINl5cTneDF/7LxTnX1TJS
 7N+YrlOceEAaA6CqzU/3lX1Deg88m1SPd3eDR55jYYJscsHdn2qzfhqyWsv7aKXGSUJd
 wcLmvVRYQ0KAfxmhGI/tVRSNZdu0jQBcKA4+RA7btg+1hEm21nNgFNitFVI8/il8ZvIN
 95VbNHy8dmeFPaylBS4dIHnDzvhzHM/mAlKK3+dUXatFAUH/4QM+idQMygtS/h6gW1+6
 gd1ktvmVjulBC5i5eYNjjTFi3/ikYur6vAJRB9S0xeD48wPoGWjMex31DyhcuCB1Xpef
 welA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896002; x=1740500802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0a66yVnUC0E5xDdPgIBrEynWgyX5dbe4KJOQ4kO7y1I=;
 b=NX6wxVtvgS2fAeHX/Bm1IQzcKOxguVDETNSvPaswEqchCgixDPL8vWEtORy8dw3E0W
 VOvXdVJ9UPyPgA5z4yONMYLGFP7QqYehlXXF4r/rbB/3I9vfCn4iezMcH2MW7PnGQAqh
 nkJZw5Yh4kZhz8BIUkn9blbN+0RaHZmhfn+qVg73fT7n6l5uNuJw15i42nkZ2g4aVe9W
 rMJm8XJ5tPOby4Vq9JMDAKQpKQsKMxb9XQtV9R1hwR7Q7o/Fkouy131TohovcV+NKbnt
 Ft5XffGdfploozYQEpiHzsnysopJ5Z/DdaW3L/qZnXQM8mNDCjyCMEUdq2QE/4XShBTb
 scTg==
X-Gm-Message-State: AOJu0Ywl0YYc1PPn6YUYcATqI02EI71bfg21avGNIOmWhX89F0SBpK63
 Z523drns2lNsSNRryd8+3FV6vPcDqZsq+5nsek8t0/fw18PNUI8dAMmUCDWkCvANXujT8a//Das
 zTCQ=
X-Gm-Gg: ASbGncsH4UQTBHcyhZxNu9sLn23u4574x9sMIm824ie2jErieBePqW8MkCgVzKeMQfJ
 U7bUKDAjpyG46owtzbf991PjgYG6Hjn8WqOQfifW7XGJXvwvMbULlumeq08BmOzgT9H3xOXf2Bu
 XAluETStNAxN3u0n4Wd9L4IrnMlVFTSaRoZag9XEPzBeahgQCxCavCCu1BGPf9J/qBEsMjPnC0s
 Lfp4b2fdmr5sAUGH1cEWDq9QFLyz3BKlynL+Ga54SoAMs+MXqkV3XWApJV1WA+tHfkT/3X6r6pq
 1VEkVo2CtYv3OwujZZr9aaTGqM70flP9FxJPl5gfq+luJp+utWzRRybIWe4lgQCcTw==
X-Google-Smtp-Source: AGHT+IGVAlgtubLuls4ng2ytjxZmkvsTq+0bRKUdjbgCyy9ok8Tw4Re7Q3OdU7d9IrlO5cAU3E/jjg==
X-Received: by 2002:a05:6000:1865:b0:38f:4d91:c123 with SMTP id
 ffacd0b85a97d-38f4d91c4abmr6004250f8f.32.1739896001712; 
 Tue, 18 Feb 2025 08:26:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43990f53847sm35276835e9.1.2025.02.18.08.26.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 4/8] hw/xen/xen-pvh: Reduce included headers
Date: Tue, 18 Feb 2025 17:26:14 +0100
Message-ID: <20250218162618.46167-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
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

Have "hw/xen/xen-pvh-common.h" include the bare minimal set
of headers. Adapt sources to avoid errors when refactoring
unrelated headers such:

    hw/i386/xen/xen-pvh.c: In function ‘xen_pvh_machine_class_init’:
    hw/i386/xen/xen-pvh.c:84:28: error: ‘TARGET_DEFAULT_CPU_TYPE’ undeclared (first use in this function)
       84 |     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
          |                            ^~~~~~~~~~~~~~~~~~~~~~~
    hw/xen/xen-pvh-common.c: In function ‘xen_pvh_init’:
    hw/xen/xen-pvh-common.c:217:43: error: ‘MiB’ undeclared (first use in this function)
      217 |         if (s->cfg.pci_ecam.size != 256 * MiB) {
          |                                           ^~~
    hw/xen/xen-hvm-common.c:18:6: error: no previous prototype for ‘xen_mr_is_memory’ [-Werror=missing-prototypes]
       18 | bool xen_mr_is_memory(MemoryRegion *mr)
          |      ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-pvh-common.h | 8 ++++----
 hw/i386/xen/xen-pvh.c           | 1 +
 hw/xen/xen-pvh-common.c         | 6 ++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 5cdd23c2f4d..17c5a58a5a4 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -9,11 +9,11 @@
 #ifndef XEN_PVH_COMMON_H__
 #define XEN_PVH_COMMON_H__
 
-#include <assert.h>
-#include "hw/sysbus.h"
-#include "hw/hw.h"
-#include "hw/xen/xen-hvm-common.h"
+#include "exec/memory.h"
+#include "qom/object.h"
+#include "hw/boards.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/xen/xen-hvm-common.h"
 
 #define TYPE_XEN_PVH_MACHINE MACHINE_TYPE_NAME("xen-pvh-base")
 OBJECT_DECLARE_TYPE(XenPVHMachineState, XenPVHMachineClass,
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33c10279763..f6356f2a7ed 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -14,6 +14,7 @@
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen-pvh-common.h"
+#include "target/i386/cpu.h"
 
 #define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 9c21fa858d3..19876ad7e8d 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -7,15 +7,13 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
+#include "qemu/units.h"
 #include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "system/system.h"
 #include "system/tpm.h"
 #include "system/tpm_backend.h"
+#include "system/runstate.h"
 #include "hw/xen/xen-pvh-common.h"
 #include "trace.h"
 
-- 
2.47.1


