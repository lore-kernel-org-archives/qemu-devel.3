Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7B1106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vu3-0001VR-9V; Fri, 13 Mar 2026 02:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vu1-0001R6-Kc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vu0-0006un-1P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso15455115e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382898; x=1773987698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHLXdrC7lRbUfVA8DRaY1znxZ2SnoyILAISU5P0bD5A=;
 b=VTj5S8OeKi02LZvhvkUR3Z9CIPqThXddNWO3rfwSYH5ayCy13lxhThPhbihKElCzp6
 4FUW70i1qaRQogaUWSBuooRVjpn01+OLQe0Lzi8dkBSsDUq9hdEwbilmPGrK2EsgI0E2
 J81dfTGP9k4WmnnAWWy34TlLzxqxspPXB/BKSajuvTWOBGRsXKWF80jvM29T6EIX++JN
 z6AQUvXaGi1VY6M0YrceEDabkCqYrZoxzew/GNM169DZyJZtaqwKCQPDGgPuyORulMNf
 erktnvZ8VZwXOvVzIrFt/ddHJg4RRvmCaFRR4PIweVXDAvpmBg5/kdr9Wz671QGpD4Qv
 20Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382898; x=1773987698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHLXdrC7lRbUfVA8DRaY1znxZ2SnoyILAISU5P0bD5A=;
 b=aXmWSf+DOPJYINsQUrkxunUVY3MK9mEUIn5Qn40yaRrH4u5Xrt4hY2EO/XeEyn9re2
 CHWt+R+a1jraQjv7H/YkjQ8La+DGjBhUVnd5KcvqYrj/ENE1DqYXLu016ncuOZ2Gh3mP
 jOIBldL2oQa+GTFom0DfsXZox8k499pxzGDMFt/+ldLHtwxihxFW9tYLDuWJXiH5vjiG
 Dut69EyPEf0+Q5uKHMgpOsiXD3s7gRDV5Uq0+y5coIZrim4WHBbEftJn0+ptvwdWnhmw
 27Vkj3fFZ5eCx0WryRtK7kQuIB5NzFDTWxH3v4cqmOVBSHpKuvlEwnNUzCxYmdHksE0W
 fZeQ==
X-Gm-Message-State: AOJu0Yx6aiITWYgpWmdxGtHVZzziQZwgeOt0DS0v73V4+lbNCKqNeJQS
 6vidRYP6m9Huptn3fNiPw9iHIkN6rRCNdYz4KEIOqYGtNEisIXy+FbH0upeM9fIpZlRyTsJoVVH
 x/FcLCxU=
X-Gm-Gg: ATEYQzxljvDnRjUCmvew9CNUD/6LcvTLrtwutkFaXa98mTO0kVkTnS3h9NuruPLwtZ+
 fljYAH4qQ7hv8UTieb7KRxIZYjfyDWM8doY7Y64TWOsYSpNyhGsnwE8eJVFR2Bo+fMkISvIkihO
 WeHEvMg22cHJzKk3I2ycWMUbnrWPoscfIxcnKHJYMHNHFKZKb1TT72dXrCrLmZIZ4F9tOzLGGxF
 h078rycoTy8WmvQy+QRXMyq6yTB0xGJt6ibT/SX6HCe1Vs8xx87q/01d15u1JR/X1C3t/luk6Sm
 v/SIb3DGtsPjbiSlFEojhYEfg/9PBb5T0PnvHHWLY8GofzuakG4Xnjs6HiXcRVk7fH9oz8+7m/M
 FLeS9cvsuwgHZNZ7VTl9+gpZ34mKiaeWJCQjzpmV8/ic92DW8/B3fSM//cs6fVXwyi9HFaUFRRy
 lWvj6a+mtLGi+RU5x6BJ3g4rGS+EjOGnCFGr5rvcp6a0Ja1ajIGMP9nKsXBP25S53XdsoAs7zK4
 ohkhQ==
X-Received: by 2002:a05:600c:4f8f:b0:485:345b:ccb7 with SMTP id
 5b1f17b1804b1-4855671028emr29944005e9.34.1773382898236; 
 Thu, 12 Mar 2026 23:21:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6b95sm180856455e9.6.2026.03.12.23.21.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 06/38] target/xtensa: Restrict inclusion of
 'exec/cpu-defs.h' header
Date: Fri, 13 Mar 2026 07:20:22 +0100
Message-ID: <20260313062055.2188-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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

Not all files including "target/xtensa/cpu.h" require the
"exec/cpu-defs.h": only 'cpu.c'. Restrict to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h | 1 -
 target/xtensa/cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 22192924841..dfd2ceab7cf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -31,7 +31,6 @@
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/core/clock.h"
 #include "xtensa-isa.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 86ec899a67c..dcf3cd84c84 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/cpu-defs.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 #include "qemu/module.h"
-- 
2.53.0


