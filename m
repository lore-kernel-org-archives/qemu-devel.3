Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF04C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklZ-0005fV-Hy; Mon, 11 Mar 2024 14:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklX-0005Yb-J5; Mon, 11 Mar 2024 14:52:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklV-00058W-W3; Mon, 11 Mar 2024 14:52:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd9568fc51so12800985ad.2; 
 Mon, 11 Mar 2024 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183167; x=1710787967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW7L9Z7tkLffGlK67l1yTKsB0/citIESoZVxrL0mhNE=;
 b=YvzKgxW0ZlXEkAirxmN/wSuuA+4f6YHXKmy7u5unY8/T5C335DcvN82ipJm7p86tEH
 1Tn3p65TX9e7C1nRs6W8kvKr6H06MfZQNHw8D/ddFlNs5W8xBmdS2fNhTOcCrE8ivF+S
 2+6osjgoMxYYoYaKRWXJihwlCp27vNLqTOqY6B69YGNXIWzjIFvrkmxzXprX1kj7O2+4
 HjJ9akzJAkilSIhrNWoBqrk/OBgHu/Hgn2SGCwBrsoFgyQgmGwRSi1/rOlExEkaHBwSn
 cN1g14FLKpzP9UPTRcuCqeq/kYgp+nxrRdbv4bF+SMu8kwyrIX20q7Va0EW84eyR2ppN
 r+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183167; x=1710787967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW7L9Z7tkLffGlK67l1yTKsB0/citIESoZVxrL0mhNE=;
 b=N0/zN7JymCtjj8l3KOJYQvR+V7TZdaDeafh3zgKN2/g/9g84Z8WNCXyS5BNdkLIR9R
 6KmPoJ2ms52reu0UFXRe319zJmYJveggVx/464LBhp12KIph7lU8ZdhgxEr/4KmBcvnQ
 1dcnfCSg4BBjBC4iHWaxRKnKhT+4nqYWVKka3NkpMcAk5cm/OUVCy6evhNNvYK7B1q9b
 YzzzCUMFZsn7MLgmNlDrwLegbN0e/IvEx6OejGqzKp4dO9QiPZHxByN1qIv/dizuky9C
 quQq6GmFlAudF34TRj8I4mKXpdXW/ypLcsAWrDAllb+1ylSfJpT317Ea56hdsdAIfhBp
 EeBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbiwUdnLOdK8aG5YnuHTGxZp4qMIfYC7J5vyDsx2YzSEFAxMKTdUdUM+N2s47GnGB4vtLFHmuTsVpNCn4r0Sk5pMVIn9w=
X-Gm-Message-State: AOJu0Yyms0q2hM7rX9m2D0OTqQiLFmxbO0TeEPCBpyXuzhWfCSsZjpJF
 MzsCDkXa1HZ9sA/Z/6DmVD3t1NWCimS2NkhmHYp8hKFf2rGwS/xUYvmqMUwZKTY=
X-Google-Smtp-Source: AGHT+IF5YjC8dOtA+fkuZXtmS/aNNk2q7cCKjmDP5O7I3W7EHjLnN2W6qj6L3NLqLTbTf9dmf/d4CA==
X-Received: by 2002:a17:902:7403:b0:1dc:518e:45b7 with SMTP id
 g3-20020a170902740300b001dc518e45b7mr6920200pll.49.1710183167034; 
 Mon, 11 Mar 2024 11:52:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 11/13] target/ppc: Make checkstop actually stop the system
Date: Tue, 12 Mar 2024 04:51:53 +1000
Message-ID: <20240311185200.2185753-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run. Make it stop the machine with
qemu_system_guest_panicked.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 98952de267..9aca4a1489 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -432,15 +434,22 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
         return;
     }
 
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+
     /* Machine check exception is not enabled. Enter checkstop state. */
     fprintf(stderr, "Machine check while not allowed. "
             "Entering checkstop state\n");
     if (qemu_log_separate()) {
         qemu_log("Machine check while not allowed. "
                  "Entering checkstop state\n");
-    }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    qemu_system_guest_panicked(NULL);
+
+    cpu_loop_exit_noexc(cs);
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.42.0


