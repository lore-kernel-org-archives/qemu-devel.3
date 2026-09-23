Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ABCC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mus-0002lc-B8; Wed, 23 Sep 2026 09:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mr9-00008R-7C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:56 -0400
Received: from mail-dy2-x17.google.com ([2607:f8b0:4864:36::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mqt-0006oV-V4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:37 -0400
Received: by mail-dy2-x17.google.com with SMTP id
 5a478bee46e88-3286624d194so643231eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169451; x=1790774251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
 b=FhpTrE0vvrJyCJuY4jtfzKb61FUyxpPyJjwStCdeUGP/vr2OWG8zaL2n1TnIR654E0
 aqKzc8b6sYuxVJlnwvzNOhZfs5nnTIQkqBCDg2/GylXtQtDP5fZrtq+NwZWfA5vCHKA5
 OFM6Fxvu3QGgj6aQrCjb1uDMO9EdSZ4Gxh4Sdvxu7eOMfwo/2b/kdr2BEVJu6RKxAHIv
 bLHPxNSggKtLcIXC5A8nBPHETXYeDWXWeE+q84uklfdkfUd3AtlhMjItUH4ECbgbq51W
 2d44qQGSJshZ92MHQsF4DPA2Pf6JZF3df7zKODwC5CKZ9Lr6IroO29hJacBSa6Ov/f+J
 PPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169451; x=1790774251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
 b=SYAAyurNl97EKfKMMxGwIj/WRKnhYfoO3HPFgzXt42HlSL/oAAqaL/Z78maZv2YyeD
 aQ4NeynUO+ImldQQiOxJmLJYD/G+8A+Iav0Km/r9PUJf9J/RZxKhyULRNnxZqZwuC4Oz
 h0VmuLyMxz91JcTWxLXl92JW+oVlwN/49V5yAn+lcUjo3tYOUD84QhvCFsV2q6Uy14j6
 i2p76YJeVzg3KtAenkLwsdBde3UUvamYanGTXbUp04fQnkYYIssJoix5VdhVZ7m9C6V0
 DWKYoooCTy/fJSwK2DGgTRfToqL3NUCfzdoSCsJnSUYXuhg1JL2RJI4LEuiP9+wxDv9s
 YeIQ==
X-Gm-Message-State: AFuF++l2bDaEx3u5+/sabzbeUGaBQT7RpSF6nRuw/B4O2dgp4SimtY6W
 U8R2DVQCecWw1q2jDmDyzcXlgFHoRzzIV8CU3gq8wRmj+vUkdmIdpQHDr30Fdv/d8Dk=
X-Gm-Gg: AYBFou35sOgpDI/GbhswDsGYNvtIfDvxws2T/Geg4ApLd7iOTEiCIIO3UXFGKm2XijO
 uQoaKt/wD3lvk8IGTJYzFvr2CvNTPHpr25NXvGlxY+u+NNet9Qm76Ovxan5iGukY7vMdoG8ZVyx
 2Cef+/9uzzGEiGMVQtcLlJTWB//IHC7Ohr74qoMoqJa0fz8tm8vIvz6T0X18JuGNiD4aHs681bR
 iO09xePumL/QwvJklS+8djCl+94XgfLPER1oPFXLNVenRWEeVo+yZm4//FewUjrObqYv9MIEASZ
 kDtIwB9mBbVJTb8YQNyi4YIhjPNnUcssWEiL4nOdzf7W+PS1rECqaE4PK5XZV4PUWc9yYOmefmV
 Mv+wQ7FIo/f2fJTnDHhIAW+TYLiDpbizoDB9oASfiOi4LZA7qHXjat+9PEdbNGEPUQIaqIQMgPO
 2rn2q5IOG9D4Tn13kTk5vhwrqnm0R5gyMXCx/ZDwpAIZGECWaT08lfsDRDB6tW1F7dlRJLXQaH2
 NS2dxsih2JNLDkmPuOg1lrT/eZwviM=
X-Received: by 2002:a05:693c:228f:b0:33c:3134:1055 with SMTP id
 5a478bee46e88-33e8c53b899mr2375553eec.12.1790169445480; 
 Wed, 23 Sep 2026 06:17:25 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:17:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 004/114] target-info: rename target-info-impl.h to
 target-info-def.h
Date: Wed, 23 Sep 2026 21:14:38 +0800
Message-ID: <20260923131635.1894-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::17;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x17.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename the TargetInfo structure header and its include guard.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/{target-info-impl.h => target-info-def.h} | 4 ++--
 include/qemu/target-info-qom.h                         | 2 +-
 page-vary-common.c                                     | 2 +-
 page-vary-system.c                                     | 2 +-
 target-info-def.c                                      | 2 +-
 target-info-qom.c                                      | 2 +-
 target-info.c                                          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-def.h
similarity index 94%
rename from include/qemu/target-info-impl.h
rename to include/qemu/target-info-def.h
index cf42aabbc8b..8019d2c7196 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-def.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_TARGET_INFO_IMPL_H
-#define QEMU_TARGET_INFO_IMPL_H
+#ifndef QEMU_TARGET_INFO_DEF_H
+#define QEMU_TARGET_INFO_DEF_H
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..0f6772e65c3 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qom/object.h"
 
 #define TYPE_TARGET_INFO "target-info"
diff --git a/page-vary-common.c b/page-vary-common.c
index ddd08633788..5a4654725a8 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,7 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
diff --git a/page-vary-system.c b/page-vary-system.c
index 6c49c10e23b..9773685dc16 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
 #include "exec/tlb-flags.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
diff --git a/target-info-def.c b/target-info-def.c
index d121b8c0170..fa19cabc55f 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index 6965e4d1169..2b38673a3f8 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 
diff --git a/target-info.c b/target-info.c
index bba4503151a..9abe72b1f55 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.52.0.windows.1


