Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA8606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOwQK4NY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2lh-0004yA-Fz; Thu, 05 Nov 2026 14:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kr-0004rL-Mc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:11 -0500
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2ko-0003lA-4y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:08 -0500
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3736964c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905444; x=1794510244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkyI+3liRauuD4xqvrjmkWmJgNooOrv+V/mBylavtjw=;
 b=SOwQK4NY92NkbsdqZEG9mc3Oze/gZ5g+XvDrWg1zvrFdpLV1oMe8nsUEEaKQ5bEGo2
 UfGZTnvT2QV0YCAgOcCuip2s77qOzUNKPY4ySw1kwSLE16knKU5o7/sNuq+CQ04ADiZY
 w/CPEPyYrXur6ogpVJL6N/Qsm1bGvbxriVhPBemkrpq4ONOFcITIyw2tR4ZFkp18HniG
 KpZ/NHGI7OO7N7waFxvPhlekgDvEgD7qreQTsSTiDWviNyCkVbF2Rj6p0aPm9BFyx8+P
 A5fFkP4Gre3AwcOus8U35l14G9wnN+Nyxfq7KEnHJsXXgAatxAH6Orz4E7sd9CvBlILR
 HJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905444; x=1794510244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TkyI+3liRauuD4xqvrjmkWmJgNooOrv+V/mBylavtjw=;
 b=PziA+xiHsNu8UGQNYgSWtDsflje+mG6JaecxGFXJHvxk6uevaaqn+zIB3RaZ15uKPd
 8vUlyMBOJtzfNrywqaBjkGZVcQ5Dp3efFD7BYFnpHCvxFpcrdlkCa5rgCysWgX00fs1u
 Kf/YpTbWFdWcIEhExjsq5OGrczlqBkayB2g5ejQGEAs1Fykveqle3ndxu916hbR6RtCx
 FpJCOrbKK+gFLVHTtisL/smXsq8KBDIgH/WTkKlDtelFp/SHx+V4fCSlqpW6s6TZtKDB
 2MmxWg4ppShIUMTYVKsLWRLcJWYnD9ciBO9RMwGh8tDjKSN6HI5FHcGvJxab9Novl8fb
 1bWw==
X-Gm-Message-State: APuU4Z+ENJ4qL+BdqTEvZbmjWDsYhcWa2Ltz24QlufOxpr9DK371LpAR
 XaCSn98xXfRa7f7G/7+dFPSzCN/Pr3HHRxJom0DJtssDiR3Rvzbyby0mMDIiCJqDbIE=
X-Gm-Gg: AYBFou1ASLK6IEO3qM+R72lKS0/zlFCBsB0y6FbKCTF8C1+aMrkBcOivknx579A+wMy
 296UlQ7LF3VtLZ3sfmE3LXzOR4lIfvrV6ZYiXHxr6gqbi82branl8AFhILpgQCF1mbyyK7BfqKR
 A9CfnWqJ4t8oH+XOrTvF3iBXfQrmM+XsXJE7L8cAVPbFGBNrF8bXseaOXstjPHiUknSQKWeh0+d
 MLPE8R8b7+WJyiNQJvtD96fwUTLuY+Z/DKXZ1adkjMfZU4H6V6TTYBsiRrXZB4e3yoJxEDSey/V
 LMBoqjzSWE35wQD+vMyQhkAoWlCe6/DSplM9QQuSML62hjnD5pIAKwVa7msl7H0au0ZDCpEzUj/
 zF5oLt4cEGUKaPoLTfUdux6o2p11/gl6+sz0wFb++UnKhIwgq3GRV1ASXLbW9cqQhz0FEiEHXrf
 PsKa/2wrIRU5UW0V21ONkEm9+URCfI3dtkgdVp5D+iqHhpBXyA2YSvVBlt5cljAvwLcvcfnGGMh
 vKBRu8Hv+q/k3ATml0WP9LD6Q83qqpuO2Z24jFffhXI8cFpwXtsIMO7qjpsEC23+vSnuzJav6ZI
 M0U2foZ62Bwy5WPUOZwFci2D4NjYORidpvkeUAhtQ2n+Zi0F
X-Received: by 2002:a05:7022:f513:b0:1a7:e1c6:6f33 with SMTP id
 a92af1059eb24-1ac5bbb5457mr24768113c88.30.1793905444414; 
 Thu, 05 Nov 2026 11:04:04 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:04:03 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 3/5] qom: add target_mask_filter()
Date: Fri,  6 Nov 2026 03:03:44 +0800
Message-ID: <20261105190346.1539-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

target_mask_filter() intersects any other mask with
target_mask_selected(). QEMU_ARCH_ALL stays unchanged. Tools
cannot select a target, so a mask other than QEMU_ARCH_ALL aborts
registration. System mode keeps the mask until a target is
selected, then keeps only that target's bit. Registration returns
NULL when the filtered mask is empty.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 qom/object.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index b7e1924e81..c224263112 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -16,6 +16,8 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
+#include "qemu/base-arch-defs.h"
+#include "qemu/target-info.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
@@ -88,6 +90,29 @@ static GHashTable *type_table;
 
 static bool enumerating_types;
 
+/**
+ * target_mask_filter:
+ * @mask: QEMU_ARCH_* mask to filter.
+ *
+ * QEMU_ARCH_ALL is unchanged for tools, user mode, and system mode.
+ *
+ * Tools return 0 from target_mask_selected() and cannot select a
+ * target, so any other mask aborts registration.
+ *
+ * Before system mode selects a target, target_mask_selected() is
+ * QEMU_ARCH_ALL and @mask is unchanged.
+ *
+ * When a target is selected, any other mask is intersected with
+ * QEMU_ARCH_BIT() of that target. User mode always has a target.
+ */
+static uint64_t target_mask_filter(uint64_t mask)
+{
+    if (mask == QEMU_ARCH_ALL) {
+        return mask;
+    }
+    return mask & target_mask_selected();
+}
+
 static void type_table_add(TypeImpl *ti)
 {
     assert(!enumerating_types);
@@ -174,6 +199,19 @@ static TypeImpl *type_register_internal(const TypeInfo *info, uint64_t targets)
         return NULL;
     }
 
+    /* Tools cannot select a target, so targets must be QEMU_ARCH_ALL. */
+    if (target_mask_selected() == 0 && targets != QEMU_ARCH_ALL) {
+        fprintf(stderr,
+                "Registering '%s' with targets other than QEMU_ARCH_ALL "
+                "in tools\n", info->name);
+        abort();
+    }
+
+    targets = target_mask_filter(targets);
+    if (!targets) {
+        return NULL;
+    }
+
     ti = type_new(info, targets);
 
     type_table_add(ti);
-- 
2.55.0.windows.3


