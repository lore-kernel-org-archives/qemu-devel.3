Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A3CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd06-0001z9-49; Tue, 04 Mar 2025 19:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd05-0001yv-Cv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd03-0007Rs-LH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390f5556579so2602337f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135958; x=1741740758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+9rUxQ7+saDFqF8IM1RLmO8AxUwJBcx8QYoMNWV/dk=;
 b=JvJ2wlYCr5ctaiGriYQ1VvCpgdH5y9F1Rnx0NiSj/wU09QkszKpDpsEHT1ICv0dA22
 PzING1Pt5bgLn5aBphaLJpbr0+i0mFxk03PCgcxzvcmX0EOtByM60gIM2eeiQBsGg4Zg
 /Bk8kMk07nR+NRWaiu7PZkuXXW1ehDLZ6PBTvKXaVJYh1NVCp3yZjTo49iTUXAPVajHc
 tEzpqJzO9u1go6t31P+DfnzgRjcl05tMgvOrIv4/4nQfNJYV/U8uKegrn56cl6EAG621
 ZeYt7N+Dk1MclggNK+zNVa1vJpkdPPRHAo7tUUIdC9iBrQKiZA0yio+b4oZ/B/izHXBd
 to3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135958; x=1741740758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+9rUxQ7+saDFqF8IM1RLmO8AxUwJBcx8QYoMNWV/dk=;
 b=hpaZ81/WHmTe8rHTblqZvwX4zvmneIDvcjnMAGDPmoJfYWbQIUH+UWZKGFMEy2fdv4
 cau9Rgeza1+8sCl0N648JeEIihB+KskErslACO+BuuhoyDytdRAVCELzBfCux/Yay5ME
 68sx00MOPgHae7GM2DUVdHQvS7V11iMBKh/6hTAJuKqrEae7jixclXS3AarkdEQsSGw6
 kOi7RNabvxpPrjVxlCnIPF3V35fI4+9zFDD06BD9dxDBShxQobUtBlY0nl1Sv8R2Afu2
 Pmzi7/UW5+0FMKUoFfciHPxWn0SV5ytz4Wk7X8WNhzQaXjbvlyYJjapwfoxtFDsFy3d8
 Vuuw==
X-Gm-Message-State: AOJu0Yx5h4QJln6mo/fow9DoJhxL1f4DhiDxt3GNdw3SiKffKfgS3MHQ
 4eyu7g04jHn/6bhoYg8CRKwcQD/nKgUDJWcynTDEepIBK/1Bwzd3n8VDMWe7SWYgJFsWLWhwJix
 BTFA=
X-Gm-Gg: ASbGnct4WAAU1RcO5qRiRShvXlT1yVd4t6a1sOMAF2XR/YgAiUoFigWIO+fTIvweedv
 4O8Buh9ztpl7I/iVLpcepzzsaElSHjL5P3RtGoExu7kiQDBddqDjdJfwGm+BWw8EWpDtZCnEHxl
 jNfLkQw7EVcPpvXPK/IADn02GuvJpSzmQCfMZYDeDsKJaLXW+xzSryzvtHiLe5cnaK3idmHP3po
 l/ldCX8zuSDC2td6HD/TD4dYVZZcaBtP7ftSC+Tt646QvwZBVHKgIIILH0HVc1Fi7Xs7kwXlcs/
 QEbtIg59Aq8V+OLvuxVuIlCA6I2L0vtN2YFhuQfy+qojyerFgxVKt3cM8jd7ImEfjGn9rVUdXJv
 cNr+M3RdRVXsMAiWykOg=
X-Google-Smtp-Source: AGHT+IGdyoEU2pvZRgT47UMA78C71xO/YTWGipOanziM0npLvMA4Idpzgu5NgXlMJQIF0OzJskBnCA==
X-Received: by 2002:a5d:5849:0:b0:390:fdba:ac7 with SMTP id
 ffacd0b85a97d-3911f7c8629mr557172f8f.51.1741135957753; 
 Tue, 04 Mar 2025 16:52:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485dba4sm19547475f8f.92.2025.03.04.16.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 02/11] system: Open-code qemu_init_arch_modules() using
 target_name()
Date: Wed,  5 Mar 2025 01:52:16 +0100
Message-ID: <20250305005225.95051-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Mostly revert commit c80cafa0c73 ("system: Add qemu_init_arch_modules")
but using target_name() instead of the target specific 'TARGET_NAME'
definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/arch_init.h | 2 --
 system/arch_init.c         | 9 ---------
 system/vl.c                | 7 ++++++-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 5b1c1026f3a..d8b77440487 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -27,6 +27,4 @@ enum {
 
 extern const uint32_t arch_type;
 
-void qemu_init_arch_modules(void);
-
 #endif
diff --git a/system/arch_init.c b/system/arch_init.c
index ea0842b7410..b9147af93cb 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,15 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "system/arch_init.h"
 
 const uint32_t arch_type = QEMU_ARCH;
-
-void qemu_init_arch_modules(void)
-{
-#ifdef CONFIG_MODULES
-    module_init_info(qemu_modinfo);
-    module_allow_arch(TARGET_NAME);
-#endif
-}
diff --git a/system/vl.c b/system/vl.c
index 8f776684ec8..04f78466c41 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -26,6 +26,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/module.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -78,6 +79,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
@@ -2885,7 +2887,10 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    qemu_init_arch_modules();
+#ifdef CONFIG_MODULES
+    module_init_info(qemu_modinfo);
+    module_allow_arch(target_name());
+#endif
 
     qemu_init_subsystems();
 
-- 
2.47.1


