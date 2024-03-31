Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7737BCD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphp-0002qP-Dm; Sun, 31 Mar 2024 03:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphn-0002o2-OI; Sun, 31 Mar 2024 03:34:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphm-00026v-8H; Sun, 31 Mar 2024 03:34:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e74aa08d15so2535956b3a.1; 
 Sun, 31 Mar 2024 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870452; x=1712475252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xF5OBXNYP6ZI81AmsCFRz0Xuc8TKtQnpsKPSIbYJa3o=;
 b=Ao5r3aEuc4c3pgVdMww6B6LEzLVBuNlWIafyzQdnzKZj1P6exgpy9a0CJoApROUfTt
 GiUoDMfR73M+SeXuu06R4jYBYDp3eMbYldWDaRi2fkDZnlw3xWYm5IMIsLf/XvsOguf7
 ObBmLn3er7UA+aV5uZy3aWMT4IJjCQRsLv3Us4vMC1lkUi3wi4I5BCWmu6l5iinST/ro
 nUA0MXGwq1QDkFw1J8bf/npUByM8HTLGwYd+UhoaCrSFF1r3Ok5d4KVDdLe0zWv/JBL1
 wY6zUYhqDC2zTD8d+y0XP4blt57bPz9xAVX8qImGKELvFwKUpXtl7Xlv+RN5jWUIApzK
 98SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870452; x=1712475252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xF5OBXNYP6ZI81AmsCFRz0Xuc8TKtQnpsKPSIbYJa3o=;
 b=O5DsBTM/4q8Xmo8uI2rOs+UKHZAa/o/chmQAu3uwFzIuTehJa4FtcsEEMivn3oH7ak
 pUq0Vs2+sdZ52R6UM3B/Tp7Xb33/oZJ15PIVwIrJx+uWLOFjF2RVfZPsnM+KHfkk50rM
 0c2Ij0+WOqXK+cI7Zxw86skGfba5sgmd7GK3YZ+e4vIGZL3rta4W6fE3TtJYjbI95NJp
 8K16/8+fCTNiPqaNOUaBLpmVMq0h5aCxxYrBpY8KHEZXS0c6zXjapB4Hw0VSb0wI8ksU
 pD0ryNUctJ+4kq7tW+HCXW4Ed9qeXeayR8itxomkeMXQy8bHv11QypW9P7ZpiX4QDeHO
 TT2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi/300MKPTqUM3U0yesNk5IUvzBhQ1lSWE9mlSKO1VJqxEzALhOdBskpIT7SeTZpAHqDmuczeLZsb99KPjs28PhYSI
X-Gm-Message-State: AOJu0Yw/wxe0+jPL1E6eH69/ZUe0QAESmromL9S/7U0LsRXqn0G0Y5xW
 dLAwwkZlIQxitjaDhU9mqWT9sybojtOOGHiJ+CgW3fllOIXNTWb9B3gv0Ldny3k=
X-Google-Smtp-Source: AGHT+IETTOw2Vn+VyN+Rls/DoBmIk8j2yt9iBvJ3c/qB/ud1ToNEatvTOz5tmvmpoU2miRCkh3J+Bw==
X-Received: by 2002:a05:6a00:1992:b0:6ea:e2ec:9622 with SMTP id
 d18-20020a056a00199200b006eae2ec9622mr8610538pfl.20.1711870452321; 
 Sun, 31 Mar 2024 00:34:12 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 2/8] hw/ppc/spapr: Include missing 'sysemu/tcg.h' header
Date: Sun, 31 Mar 2024 17:33:39 +1000
Message-ID: <20240331073349.88324-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"sysemu/tcg.h" declares tcg_enabled(), and is implicitly included.
Include it explicitly to avoid the following error when refactoring
headers:

  hw/ppc/spapr.c:2612:9: error: call to undeclared function 'tcg_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    if (tcg_enabled()) {
        ^

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c417f9dd52..e9bc97fee0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
+#include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-- 
2.43.0


