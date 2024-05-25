Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDECC25B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 03:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAhqt-0006fC-By; Fri, 24 May 2024 23:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqs-0006er-5r; Fri, 24 May 2024 23:13:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqp-0004pF-5u; Fri, 24 May 2024 23:13:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f6765226d0so3693224b3a.3; 
 Fri, 24 May 2024 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716606821; x=1717211621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzD8EfQ/EhvSdLMQvyJg5EvWSbu7FiDHBlj47lHYMbw=;
 b=YCnFi/PtIDNB3LR5NEdPxbraIEzgnju9XslOKd3IahaIL1CZ3ad4jUczG51k6QKTV/
 XZtW+CVLu1avZ7jzrBydKS60HfLLb5tPwmkdM8e7TtT2+IZXwL7tl6/9HA074nadn44K
 p1DxA0pePHh9ZBXqyHfkJ9AiVVtNhJyU0JUSfBDpA3nYdCghxs0D8Rj9O4WsLKeOLezw
 4C+WC/5eFkIkwPU/FHLYRpsk95615Wk2g3nHhtUGf0HTUn+qSkQobsq2NdX0rHR7Rv5A
 dpdBke5MMmhK29XaBoOwhPpM2q3I5IvNiR6/xTQW+VPo0yq6BYrO+DVPk62rKJnzZbyP
 S1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716606821; x=1717211621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzD8EfQ/EhvSdLMQvyJg5EvWSbu7FiDHBlj47lHYMbw=;
 b=HhGpu+T2TaZirNqzj9LlK2A9tr/T4y2TYQqQ3M70jCJQfsr4e+WGnAgOC1VYHC6ykY
 SUWMrUQxuwgNOyEgCks0RtXtXic5Twd0yJQMt4Mx/IT9ujBwa5WCzcWxeSfiJ14dDygI
 0OkBx+Slq/PYzwRioaXMIz+nn3qlOPNnQpVLo84LsCXZr9d7/3+4H4Jh4o379IUUvHMr
 YQhwShqFQAK9Nl9t1NA1bDyBIRs1R5Uo3rDN0U+Fz1H9lFALE3qFlhuop0DSbzBTvpbm
 pDjImdW9s4E/2C+ZFPIO5JIqdOA38A2g5GbebTv/ezYF6B/mR0wjfzoHU5yKzxMQ5B61
 VPGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKHkYiFpZnaVNYJhmwcLPV0fcSaZwMuMm4eOTu3QWsj4BJsJEqiGWGqccviNCtXW29qsW6RVM2KDnBiqNbMEFJyvOxo6OG7XtoG9tCiXe+7aVfxcArun3580k=
X-Gm-Message-State: AOJu0Yy+q2nlpdT5DPEfg1CII4P/I5Mkg+CtGZCii5ToEUpNymXKqOKM
 8ibcAD/aDpj5D+JCSAPVOIRNYcH3d3qIdZN4TYz8BgG8NQgby4ve23zKyQ==
X-Google-Smtp-Source: AGHT+IHFSeCk1C4jNFDY9PAtABM7S6CArJLmkgw46kzkNTqydXALa6px1rFz29gx5Bo1TS6tQYQBIA==
X-Received: by 2002:a05:6a00:e8b:b0:6f8:caf2:eeb1 with SMTP id
 d2e1a72fcca58-6f8f33b1ad2mr4421167b3a.15.1716606821163; 
 Fri, 24 May 2024 20:13:41 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05a363sm1744306b3a.64.2024.05.24.20.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 20:13:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/3] tests/qtest/migration-test: Quieten ppc64 QEMU warnigns
Date: Sat, 25 May 2024 13:13:27 +1000
Message-ID: <20240525031330.196609-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525031330.196609-1-npiggin@gmail.com>
References: <20240525031330.196609-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471..c13535c37d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -21,6 +21,7 @@
 #include "chardev/char.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
+#include "libqos/libqos-spapr.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
@@ -742,7 +743,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "until'", end_address, start_address);
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
-        arch_opts = g_strdup("-nodefaults");
+        arch_opts = g_strdup_printf("-nodefaults "
+                        "-machine " PSERIES_DEFAULT_CAPABILITIES);
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
-- 
2.43.0


