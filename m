Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8742CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMk-0005vD-Qa; Thu, 02 Oct 2025 05:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMh-0005uL-C8
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FME-0002VV-K4
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so644481f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396323; x=1760001123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSm4KVvbbOTFa1JZmBCvjF3UY+LV8hIWytdLij6sZA8=;
 b=qORbFQSigIbALDedrqC9JKFD831AM73Ex8Xh/SF5LrVZyJE+Noh5R2P0rj1Bxnim4d
 7/Ygp8Xf3k237Ywd9u22psiTdl006ISR7ChFMj/e8g82uBoPHo0NnmNgzbCIsLmDO1CT
 zf2Mhgs5TpKWU6JDEMCqIecjMeT/wXP/wlTsurxKqREtBjnWj/ML+4yLt+xVFRUci0tX
 msBPdILnLhTUv56/sDWcLuslyfU7i7qVLB6YlBy2b02IDeRZlVnjQ3o4nbjYpBQiEFf6
 hjRH4lKkVumj+Xpe6CKyMJJ24pfWRAMhxUrl5DKkH0r+Y/JU2MdHRJni1aYkntoBEZ3e
 FFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396323; x=1760001123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSm4KVvbbOTFa1JZmBCvjF3UY+LV8hIWytdLij6sZA8=;
 b=GDdP5924zIClCN35wlOq/xEkPVLz9SeinwbHaGTaM443jzzfCsi3A4YhlAjyxHYQ9Y
 yCzZQ3RtBx6rwp7qZTCdSYiSQ59Jp7B3ppQYt2ZJHO4gMaSatLcAie3k11ZXZ9yN2rfq
 QcFAZ054J/ZwoPTTXkj1ERZNPm/kScJo+ymDyx/PiwOPgXXstA+Njf9LI9prjv0EFkBW
 USwqZqAw6nEktllQsDKuZ96azGNnojKA84OB2HzXhbdMaHBRvvvOKAk+rSbFdbpyGU+j
 5HtqN3r8gtvwq6va4Meh//gOP2ckWI3hqua0MLzKBB0FlSRFizeq5MQTjWE9jGM0bl6K
 Marg==
X-Gm-Message-State: AOJu0Yz9jB6fwZH8cxe82WFubc9alkEPfUCyyclqcq6KI/A11yngnmy6
 5OQVidjgU7fFim/QpYZgG1ew7yCDg7j0//RgLJ8/oJIZk2D7BdOX0ENI8RFUzw9IuUqX3yqCiB4
 tu7kNDqJv8Q==
X-Gm-Gg: ASbGncvoew2jEz5SsNYK2Dfg072+jv4VY/vTdbERLkIiAzcapHWIAohNimGFhgHeweB
 Uaraf+fpV77+BwXs8Gu9xDvRPpCOC03JDJ5jQxeiXCOzbHol9I8SJ8ueTKWHM9U25V0rjo0b0V9
 4wl9ZMphaoMSTI9Pwe7/xYrJUa79gVTV1zHVerHdCJRXssoAmxH3O5JTXI9qBrULsW8jnIAawko
 Gm0P/ghKBYcZFigNFs+TcemT3Qdkoa2BCCpcnIlP1+xmFsXx9+fA77UiJE1bjQogovAhXqjW98R
 07TOlr2P/KMEn7jlMIKB/7fuqce6nTXfzd6jkQuKd1XAEIrK3i2v6q2TgP6ROvlwxLL05GoPwCz
 k8r/Bhev1FWxg2O+7KVyyPHUxo43G5N0fKsITgZ9BFJp1uN3Ls1q0m8H6wYvlYTS349vD2nz3wl
 +39qZRDprwofiO050bWL6oNvIEcp/1tg==
X-Google-Smtp-Source: AGHT+IGObj/hInLGUCJ0VAV7LU1qFtieMtgfWhVezOhZ2Uv3uLoidz1y69OMOk6XKTHolIB4jnl1Iw==
X-Received: by 2002:a05:6000:250c:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-425577e4a77mr3839778f8f.4.1759396323279; 
 Thu, 02 Oct 2025 02:12:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm2757857f8f.39.2025.10.02.02.12.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:12:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] target/s390x: Replace legacy
 cpu_physical_memory_[un]map() calls (2/3)
Date: Thu,  2 Oct 2025 11:11:29 +0200
Message-ID: <20251002091132.65703-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in cpu_[un]map_lowcore().
No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a6d4a1ce05d..b01b7d9bbbf 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -26,6 +26,7 @@
 #include "hw/s390x/ioinst.h"
 #include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "exec/target_page.h"
 #include "exec/watchpoint.h"
@@ -107,11 +108,13 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
 {
     LowCore *lowcore;
     hwaddr len = sizeof(LowCore);
+    CPUState *cs = env_cpu(env);
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, true);
+    lowcore = address_space_map(cs->as, env->psa, &len, true, attrs);
 
     if (len < sizeof(LowCore)) {
-        cpu_abort(env_cpu(env), "Could not map lowcore\n");
+        cpu_abort(cs, "Could not map lowcore\n");
     }
 
     return lowcore;
@@ -119,7 +122,9 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
 
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore)
 {
-    cpu_physical_memory_unmap(lowcore, sizeof(LowCore), 1, sizeof(LowCore));
+    AddressSpace *as = env_cpu(env)->as;
+
+    address_space_unmap(as, lowcore, sizeof(LowCore), true, sizeof(LowCore));
 }
 
 void do_restart_interrupt(CPUS390XState *env)
-- 
2.51.0


