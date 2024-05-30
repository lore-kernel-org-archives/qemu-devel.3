Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD88C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaTr-00029q-PJ; Thu, 30 May 2024 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTZ-0001tr-Ke; Thu, 30 May 2024 03:45:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTL-000329-Gg; Thu, 30 May 2024 03:45:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f47784a2adso4414305ad.1; 
 Thu, 30 May 2024 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717055112; x=1717659912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FicYbNCOmL8X97Ki3IW5fEmYcntLrpNCwbZ1/ZtVHwc=;
 b=I+8Q9yjzRbk8ZEnAt5gAaGTqVALIwhtmVBaAC5cUNQ9i3OO9KJiAht1BWOecd4y6Og
 NPhdOoxFjtIV62zGz28cerjRl8tRCEIuzxAX1444dW/kHUYVLlfoGDWxa62+Hhw7D4CG
 6spOKSe8hbFrBqVPj8ZfOZE2jKY7GGD9KnazTStDTPV/rHJfFtseyd1aBErIlPjWuL4M
 2J/GfIApnfUAJaPRBh0zMSeNjIC/ci5f3dL7BfAfF8gPXjY2F3d6ZDfsJXMFbn7Z4eR/
 jlbIlioPWihJBPE+AjYP1s2wDxoIPfAwWGTdp+JMBpFtiYJUiIVaejYJJJlcIxe3nw3S
 N1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055112; x=1717659912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FicYbNCOmL8X97Ki3IW5fEmYcntLrpNCwbZ1/ZtVHwc=;
 b=OazeuxhbWQjdtlkex6tgsqW/1zWuVy9Ay9UcTYXIRI0vB/1GoHu077tkJDyQC1Lnvk
 IvnJXQcdzuzlKvLRQXSu3DEm16o6Jj3eLnFP6gGImEjie+RJzwIKKWUzMxYRoOwZm0Ax
 CVAu+b4OAGFSvqByBnrGo6/oCqb3srK5ESpe7KxGdou1Ie/PlB8jVCD5r5LKCHt7go2Q
 EJeqBaPdzroIMrVZze0n5qL5mA+2NDX7h2sud4mCDGpe6i6SS0Of0ci6s+AOMBA1fg7o
 aUvUurvPPBlstELCMdtvAJRxvYGdKb25HjLbdMZG7tPUZV0tQeEPwhQ6Y/F+4I3xuhX9
 0P7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBOunRv6DGu0wQKcpJ+UpwkS8GDSL2Xmgg5tkKYAzW3+VIxYvEhye8nE1p89aiiGoX7KNI/iwOpi0Dx7EtY5fAy9Du
X-Gm-Message-State: AOJu0YyO7gkTv1TCxXkpB6fugmyxfy5Dgbb/AsRinGiIaTUxhI9O40Ae
 ORWyYw4as11ZXVFM6qrR/uRlOAZNj8/skwLdkyyrcLy3H8TVEKdgx5NN2Q==
X-Google-Smtp-Source: AGHT+IEbF7yd8eHfCfzcj/CVVu2i9oizrMol9VZnl7yZnSoJzEqMYMFqmsz+/fSfccOjf0tSphJysw==
X-Received: by 2002:a17:902:da86:b0:1f4:7a5c:65d4 with SMTP id
 d9443c01a7336-1f6195fac0emr13263445ad.18.1717055112253; 
 Thu, 30 May 2024 00:45:12 -0700 (PDT)
Received: from wheely.local0.net ([1.146.118.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f61aa2e998sm8025335ad.62.2024.05.30.00.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:45:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v3 2/4] tests/qtest/migration-test: Quieten ppc64 QEMU warnings
Date: Thu, 30 May 2024 17:44:50 +1000
Message-ID: <20240530074453.21780-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530074453.21780-1-npiggin@gmail.com>
References: <20240530074453.21780-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
index b7e3406471..48f59822f4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -21,6 +21,7 @@
 #include "chardev/char.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
+#include "ppc-util.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
@@ -742,7 +743,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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


