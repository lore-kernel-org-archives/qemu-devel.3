Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA00109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IU7-0003sZ-Tz; Thu, 19 Mar 2026 14:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IU7-0003rw-2H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IU5-00013a-GM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so11625035e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946360; x=1774551160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQpjTeiDB4ugZhG/LoGHrXNYNzWgqM1WygHLL3iJQjU=;
 b=tAI3AB8kfSdXS/KHCDsmL8ar70j2yxuKN89KBiVRUem04c0y/dzOXmzT29EfEmgCXV
 vuIPu0Cl3X5cD1k2JljpfmkCkWYQ0ayAXi2n6yht5WcAhTiYXDuhECI7hglCcEcvi2ls
 ntUwjxwb5vtlhnakq3jotEXxcm2O41Vctn72uZoiRG+pONqTaEr36as8N2ZrbK+8qSxo
 054WQnd5Gm8G7f1qv0Y4KWVPPsHJCbJ722f5LSLACXceVh1rIMg2cXXSOaSsVl3dSIr/
 5e9d9xctuyZd1fsvivgdPuQ1n/gQ9vjX6reLHhl4C8Kf6X8f8fgYgniFavYbpQtd8hp1
 PXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946360; x=1774551160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eQpjTeiDB4ugZhG/LoGHrXNYNzWgqM1WygHLL3iJQjU=;
 b=FY4dZjO90/s0nWCngAgLDvCtqQG46/9pNC9pa/6BvuJqULQpTcRKz4aEthw4vZhgJj
 ieD6bCA58+RIHZ/hRQJ7oxDm1q062yVBP1XZS9qVvQAfqbwlSuW8dY4ZXEqxhriY40jz
 hSU2i3M2925V/zXyNfW12LUQMaCqPXoceF7217SzlKevBcAnZDj0A8CM7c9qm/QTtb4c
 hxV2OBDfmH1r9lTLFiwXSkhATK9bDXbCtF0TH+rq72FHc1W6h8FRkUXQ3qn459q5iTHx
 bUefq3nqrLqCz4OayO8bJHg8gMEei2KXryc7o7c97WPMf3jm+PfzK4V3aL2hFOiGe+B6
 ru0g==
X-Gm-Message-State: AOJu0YyFr8CivmK5NyymmEgnaCJ6zqOBbrb8g9+B3wx/WSN4VwL5uF/w
 oj7UyWUVOUjKNqysAO2yllwNRIjNpDE8hboOXkYfWN0oOSNr5jTis33GgV/PoGINbULbM/i5xeC
 EOnwaWuA=
X-Gm-Gg: ATEYQzwBbOmvKt6RWTlwC6479MIUmR4KHtVBp4bV5D3a+3pXs9+DyuzULkYLqK+6gvC
 xOifibRcPBCbCJHkbgu5B9anu51vfPSu7KqJ6u+wdoiAVeHJEd+Zfuz6KoM6El3OJgWHnzudltb
 ggm60eC4zve7FXFKdRJyLW6mfGAf9ZAHyBSQRxrhsHlRhn30fpeS1uCNKVk7WUW5m3Zsy3abdqK
 scxsXuUXy600Z8cHcIEahT/ZQOgvv2l2DpB0weEvQoHjrOorihZf7+VIj0bKnJ5IKfm9NgA5Mzv
 /K+oOOIVPi8VGPIznMHFSgFj1kSJpqPJKo9PyASAXiyYQYeyb4E7IR1Imvdavpap7xs0T8FNrRB
 UzVZALbJJxpnEZQHDQpC6MuqiwXrW2BFWE+9TPP9SkWD7aaLy/ayheohupP8BW3Jh6iVxZ1KcTr
 XAuhF3qEVbYq7crdl1T/4BNHqh8EyHkUKSb5cwbsahFLMdrUxnbmKtsN0cgoRiB8swmMTXB3m8
X-Received: by 2002:a05:600c:8b24:b0:485:3dfc:57c with SMTP id
 5b1f17b1804b1-486fee0fcf6mr2504505e9.21.1773946359546; 
 Thu, 19 Mar 2026 11:52:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff109b95sm934755e9.1.2026.03.19.11.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (kvm)
Date: Thu, 19 Mar 2026 19:52:02 +0100
Message-ID: <20260319185203.11799-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
References: <20260319185203.11799-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 54d28e37d4d..bd22f6f0188 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -36,6 +36,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/log.h"
+#include "system/memory.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
 #include "system/runstate.h"
@@ -1664,13 +1665,16 @@ static void unmanageable_intercept(S390CPU *cpu, S390CrashReason reason,
 /* try to detect pgm check loops */
 static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = CPU(cpu);
     PSW oldpsw, newpsw;
 
-    newpsw.mask = ldq_be_phys(cs->as, cpu->env.psa +
-                              offsetof(LowCore, program_new_psw));
-    newpsw.addr = ldq_be_phys(cs->as, cpu->env.psa +
-                              offsetof(LowCore, program_new_psw) + 8);
+    newpsw.mask = address_space_ldq_be(cs->as, cpu->env.psa +
+                                       offsetof(LowCore, program_new_psw),
+                                       attrs, NULL);
+    newpsw.addr = address_space_ldq_be(cs->as, cpu->env.psa +
+                                       offsetof(LowCore, program_new_psw) + 8,
+                                       attrs, NULL);
     oldpsw.mask  = run->psw_mask;
     oldpsw.addr  = run->psw_addr;
     /*
-- 
2.53.0


