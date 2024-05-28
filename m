Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2070AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkxX-0007uS-UT; Mon, 27 May 2024 20:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkxN-0007rp-An; Mon, 27 May 2024 20:44:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkxJ-0001oq-1h; Mon, 27 May 2024 20:44:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso2424445ad.0; 
 Mon, 27 May 2024 17:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716857083; x=1717461883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13qmKqCPl+qGgTh3whvODJy15pxSC172gp95suOonmc=;
 b=ktOhS8zBej8S3MVRznLK2TD9gE4e+N6UmI85qc6q8A+7jphJZxSCP/SCGTo02XtYez
 G/KkXiWhULwq3+15uJWfNL749DaVL6KkJc/uneR/5CMOTgB711iZnI+O8KA5dzV2acvY
 VwyLkPizsi3URuFMgWFIH1bq6ortRCiKPdaaURrtTBiV2SXLRMphnIu76qooM9OUb2oU
 NeEDCvtXj7QgHtRHhnhrJzKlGsRv2Gxh2BLYw72m4MzU+R3jXZKeJg50iasgStxm07C5
 aspSVNyBxsx8qBFYubFQTMsiqI0cbC8PpX7ltrcYaFZG2c3JcqJRjJNMGF86GtKfooVH
 lxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716857083; x=1717461883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13qmKqCPl+qGgTh3whvODJy15pxSC172gp95suOonmc=;
 b=WG+vFDklZbWpYU7h13wPMKDy3bscOpLKzvzU+rThMsZ5HyShtawKpYBTqn5GEL+fqY
 1iX/5iKlt5ck0L7BRvS71K2wicwBXFXtmAUiBbnv0cry+x/czIDREAkX3dq6a+4DH0yI
 qro+h4hlIg0xszmGPwWG9KwKD5jebV14x3Zx+sAC3T4t9gac5IabaeDggqK9Ul0aS6xN
 J0Sm+h/4CW/YPa2Jbu6BoxmVKQsmIqeyAfwoQhVnjXKOIXaC5tdrr7pkYvLy/tMOjXfP
 T2JOzOveEhA1RNjYYCuh/FxW64jYb8NKlIrrdekcac6FvDIhVMQtefP8vsdL7Y6XQ+px
 LQyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJaM992AbXmOPP/13l71juKU1ve7AJOU9o/uBqW6rdTKuwGSlWXx5aE5Ts8GN0XqQZmtMmWUK/8P6hrFydXSYK1Lp+
X-Gm-Message-State: AOJu0YzOSsBj45/tcuewI8Jg3nUtGvN5IuAlBJ78wkIx2r3B1RYZvuq9
 B5CtXQRa8Xjy/WgoYjM6BeKtKQm0OY1Q4tziHOpa9b3OoLQ/oQy0Y3XCmg==
X-Google-Smtp-Source: AGHT+IHho8N4Wfr+wNsnqgG170+dK+nw+JuD9vitgprk7NO3/3f6BNvewcZPFvefH+LYfIaNycQ7Vw==
X-Received: by 2002:a17:902:e810:b0:1f2:f613:f0a1 with SMTP id
 d9443c01a7336-1f449901d09mr123073875ad.64.1716857082819; 
 Mon, 27 May 2024 17:44:42 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:44:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 4/6] tests/qtest/migration-test: Quieten ppc64 QEMU warnigns
Date: Tue, 28 May 2024 10:42:08 +1000
Message-ID: <20240528004211.564010-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528004211.564010-1-npiggin@gmail.com>
References: <20240528004211.564010-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8247ed98f2..7d64696f7a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -21,6 +21,7 @@
 #include "chardev/char.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
+#include "ppc-util.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
@@ -750,7 +751,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "until'", end_address, start_address);
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
-        arch_opts = g_strdup("-nodefaults");
+        arch_opts = g_strdup("-nodefaults "
+                             "-machine " PSERIES_DEFAULT_CAPABILITIES);
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
-- 
2.43.0


