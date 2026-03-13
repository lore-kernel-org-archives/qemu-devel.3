Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA72F106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vx0-0002s6-O0; Fri, 13 Mar 2026 02:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwo-0002Oi-3X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwm-0007Io-CZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:33 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1325559f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383070; x=1773987870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxfs9J3zv/viMZHXgXVONHohwb6PyhZF7Pg/vNqVUTE=;
 b=nFKdgHq1dca8QXOoSji8WYJGg1j8sUKhf8B0vl3kTzfqP3cwj7+uozhbEBhdA8OSde
 RphdGEy4UWFeh2r2THdWZriM+35rhxlN49h9NAwNitEV44B+z5yHJKWdPlRevVuq6jUS
 Hbjh2KQH8Jrqqyyvim6XVp5xjfjefbLFw5anm+MZG40m9deqNY438PUKS3SaBbt0oiXX
 pUtDCbNdVTd3koDvS2Rzif2pf7d5eJROaFa/9OvPOL9Ljw8+2x4BpxS9yo2dShOVK4zI
 uWLmK210IYLOKOsk77J9B+Y1xhZsfbvibZW2p7vVATw5Ag+4wuU6NAMSn4ppaubvP69k
 CHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383070; x=1773987870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sxfs9J3zv/viMZHXgXVONHohwb6PyhZF7Pg/vNqVUTE=;
 b=Z/SJtelj6wDbLl3ftGLNTcmzo5D9yfm0tHwf/EAKlCud0p6VViKPIIzjNDBDqGVSG1
 mvn8TUVxjUxcJBnmBrTGIFXqFeLp6CHUcAsrCZgjMRZUbBZGSiuthysSJQ0BPX66875H
 i5VnzhiGy4wF7Ehhzleq3d9IvBK3DDW4fglAo/YGgy8d0WdTeEsSZt1MWHMKGV+pgO3j
 n5DhEy+G0G4BuuWjLSQcjwmjaOlwYIxF/VBNEBQZlRPyS/R/0pxVPKnO9oLBx66N3VpM
 fqf+XFSYONMTKW00XpEz+g5po3jhfHkWvTZRnWHaht9QBu1/uQQhF8KvCReDtD6VxYBe
 Bskg==
X-Gm-Message-State: AOJu0Ywt7TPpPpJ8Z+NLaQnpYhBz8QdVEOiFWgyBs04RF2kfmLhGdpSI
 5rkc5/uUqHFsAeSWOZrak9cDHLjNBq/aSSkeXCpZ5Srw03OS/BJWhAcNMMOdecwr+qfVqLqAADV
 WWYblX44=
X-Gm-Gg: ATEYQzxYdM+xswlOUmDD9hxeR2oE7CoOrE2BmcBD1KhVY9jilA0S9pJ52zj7NevS7EL
 H/i78o+MGRp+K9CXwXG9Q3akYa4l6w2jrDToHnAnmC6D7M26aOhGA07eRU71twEzVnyidmU0V5t
 ebk3L1H7rVHvM2frFWQPBgp9o41u93JUUH0InwfDgtCp998NRAhnRvPNvfz7dcX/JcNUapmMbQN
 0FjG2WP+396o19WHGuI4bJVc/T6Mw//vhvy59TPzBEX5fIi57i9aelaXC68Q/cFMgfBJciz+Esg
 MBWFsB1KScAVjFpmx6uLLYsxbPZI/GIAeXZFN2AF+6cCTdMXatNmi6VtikAD3JzZAqjSX6kU91x
 MpAbxpGYEO5NBzsD+sKUhr3nPu4YE6xi1I+IOU9IEGSoyy9eooPseNaffBWGm/1gLZF2ve25Rug
 94Txpa0e2BtGTw3OU5QX0MpvnHEAweD5QryGHxy8pfcKwhuKVIF22mQiV+zJ0U6XuKBNgr65SBO
 Fzu2w==
X-Received: by 2002:a5d:5d02:0:b0:439:d769:ec56 with SMTP id
 ffacd0b85a97d-43a04d15665mr4355357f8f.0.1773383069819; 
 Thu, 12 Mar 2026 23:24:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b544sm15717098f8f.20.2026.03.12.23.24.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 31/38] hw/s390x: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:47 +0100
Message-ID: <20260313062055.2188-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 hw/s390x/ipl.h            | 2 +-
 hw/s390x/s390-hypercall.h | 2 +-
 hw/s390x/ap-bridge.c      | 2 +-
 hw/s390x/s390-hypercall.c | 2 +-
 hw/s390x/s390-stattrib.c  | 2 +-
 hw/s390x/tod-tcg.c        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 403cd08450d..fac30763df2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -13,7 +13,7 @@
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
 
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "exec/target_page.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index 4f07209128c..c5a2b17e858 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -12,7 +12,7 @@
 #ifndef HW_S390_HYPERCALL_H
 #define HW_S390_HYPERCALL_H
 
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 #define DIAG500_VIRTIO_NOTIFY           0 /* legacy, implemented as a NOP */
 #define DIAG500_VIRTIO_RESET            1 /* legacy */
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 5cdbf098074..c7e49d966ba 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -14,7 +14,7 @@
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "hw/s390x/ap-bridge.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 static char *ap_bus_get_dev_path(DeviceState *dev)
 {
diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index 508dd97ca0d..71dc717d08a 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index d808ece3b92..2e83aa211cd 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
 #define CMMA_BLOCK_SIZE  (512 * KiB)
diff --git a/hw/s390x/tod-tcg.c b/hw/s390x/tod-tcg.c
index 0cc96624e1b..448b531b2ea 100644
--- a/hw/s390x/tod-tcg.c
+++ b/hw/s390x/tod-tcg.c
@@ -14,7 +14,7 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "tcg/tcg_s390x.h"
 #include "system/rtc.h"
 
-- 
2.53.0


