Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9D9CFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIq-0006s1-TC; Wed, 07 Jan 2026 08:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIc-0006VK-Ce
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIa-0000PP-IF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso12707735e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791402; x=1768396202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czp5yyWlwc6urTTQl3IpGdpJOCaMKTZPyFgVAzx0mpQ=;
 b=jM+Ou0Vz7nRRJqG2mXIJhOxlYCHrKLQfN+dxGCi/HPRv0MLeaskhiYGA/gJVZkDZHC
 IGkZb/SFoAsuEpq1HPsQmsw3Bh63pW2pI5p3byxSYsXiWXWF6uddx93vH+SSK1U79UfT
 rf86tzLqhcYAmBZKUpDGgS5pJ8Yh90u40dhw59b3ZC/Gk1562iiTwVW6HLZm0GjtYHRT
 1YaLMLfmAIimR5R5Kwz15f5AcRHf0Sa4b2h5GJMbH8wtvanZKv0q1sCzrGKp8GKqIxMp
 obGfDiwW8zKcJ7pZPniosr1mhKfyhCCRg+nxTBxkAk9IVbFe5oDlC8m+Bzd15BABQ96h
 709w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791402; x=1768396202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=czp5yyWlwc6urTTQl3IpGdpJOCaMKTZPyFgVAzx0mpQ=;
 b=leXbLGFdSJrrAH/J3eWSaj5ea+GxBCjyA9dudAoupHB07onqWtAyjMcZXZeUZUTrQe
 wZRxMQnzSzo6rDS90P5CMdHiPtWXVg74sp4WzhK9nT6+j7yGXK+21G6PuUy7CWf17zud
 wuC+lZojaNMPvLPBVhy1zTmUa9KQg4SA6Ist+529sBsDODsjzc86wf5KMcrb4CihO/oS
 E3tIv3Rr27lMWyQdoU9BhNeRLLUhT0LFZQ4iImcN5t4DQeapqFainpBYL4fA9NpohD/u
 wQps5On4BvreF6t6kJubZ+E8W8EkYUEbNRbIUdwsknzDSpZKpEea9IoBdVyYC1Dpfddo
 Giyg==
X-Gm-Message-State: AOJu0YyYP3us0tx9eHzYu1U5b+at2vpfqRnE3a4BJbadsYYmD3Fuug1k
 DadcvjBlXfotP38rFNYUa2m3M90mxXCxQ1jgYtjDVBqgGzPBjSNQ5atrWHrP4cRYjLg04SgGucd
 hns10ilg=
X-Gm-Gg: AY/fxX7Ndova0quWitf9uduEzQYNnixnv23EGpAzdxLLKp6jITSFSmTVonHSrxL+y6W
 gu5fnSvJgrQXXJuNQf0Ba2RU7Y3U82cu/TY7MRU/Sc4H2GQy5yBgE3NLtm864GDikg3qorZoz5Y
 jmdWSOMN6TOMyHQ5nTqOoKsnGe/YeR4FW/9XiWnaNHcMj1ULxnAiromEGgQMntmV2T1hdOUtW1q
 ER2R+gyjWIyFY8TPuEa60fEg1PI9pmWi3Ol9wEmBg+YGJJjz1dOThyVk34FVeKEbdAU9P4121EO
 bEOclDOIwNoH7mtkPjH8xindFh6cI9FeoyOHJVdmOvK/nkuDW5DSccFv3t+GDurWgdlF2W2s12d
 bJuLjA0PIAICOTKC4OiFJQRKbG0iIN7B6arzAaTQUhK04/jwJc2YzugDxLJhoAnIkfWGZj15BYn
 BZovGU2aJWL1pULAP+6zy1cV3JJM5K10zNco/VnXYzQ5SYFEv3rU7kqLXw3Aas
X-Google-Smtp-Source: AGHT+IFgSwIWrHXxV7pbPQDHfk3IiG2ikAdGSCWpz9UXZ5cj3qJ4JIOxYRlLSj1uCj83QpNeEjTbcw==
X-Received: by 2002:a05:600c:4e0e:b0:47a:7fd0:9eea with SMTP id
 5b1f17b1804b1-47d84b1a31fmr30402095e9.3.1767791402354; 
 Wed, 07 Jan 2026 05:10:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717d9e7sm11171785e9.8.2026.01.07.05.10.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:10:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 16/18] target/s390x: Un-inline KVM Protected Virtualization
 stubs
Date: Wed,  7 Jan 2026 14:08:04 +0100
Message-ID: <20260107130807.69870-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/pv.h    | 27 ------------
 target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index e266fc3d545..ea4b4ec3403 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -20,7 +20,6 @@ struct S390PVResponse {
     uint16_t rc;
 };
 
-#ifdef CONFIG_KVM
 bool s390_is_pv(void);
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
@@ -43,31 +42,5 @@ int kvm_s390_dump_init(void);
 int kvm_s390_dump_cpu(S390CPU *cpu, void *buff);
 int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest);
 int kvm_s390_dump_completion_data(void *buff);
-#else /* CONFIG_KVM */
-static inline bool s390_is_pv(void) { return false; }
-static inline int s390_pv_query_info(void) { return 0; }
-static inline int s390_pv_vm_enable(void) { return 0; }
-static inline void s390_pv_vm_disable(void) {}
-static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
-static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
-                                        struct S390PVResponse *pv_resp,
-                                        Error **errp) { return 0; }
-static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
-                                 struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_prep_reset(void) {}
-static inline int s390_pv_verify(struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_unshare(void) {}
-static inline void s390_pv_inject_reset_error(CPUState *cs,
-                                              struct S390PVResponse pv_resp) {};
-static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
-static inline bool kvm_s390_pv_info_basic_valid(void) { return false; }
-static inline int kvm_s390_dump_init(void) { return 0; }
-static inline int kvm_s390_dump_cpu(S390CPU *cpu, void *buff) { return 0; }
-static inline int kvm_s390_dump_mem_state(uint64_t addr, size_t len,
-                                          void *dest) { return 0; }
-static inline int kvm_s390_dump_completion_data(void *buff) { return 0; }
-#endif /* CONFIG_KVM */
 
 #endif /* HW_S390_PV_H */
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 5fd63b9a7e3..046e1f922b7 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -5,8 +5,102 @@
 #include "qemu/osdep.h"
 
 #include "kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 
 int kvm_s390_get_protected_dump(void)
 {
     return false;
 }
+
+bool s390_is_pv(void)
+{
+    return false;
+}
+
+int s390_pv_query_info(void)
+{
+    return 0;
+}
+
+int s390_pv_vm_enable(void)
+{
+    return 0;
+}
+
+void s390_pv_vm_disable(void)
+{
+}
+
+bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
+{
+    return false;
+}
+
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          struct S390PVResponse *pv_resp, Error **errp)
+{
+    return 0;
+}
+
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
+                   struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_prep_reset(void)
+{
+}
+
+int s390_pv_verify(struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_unshare(void)
+{
+}
+
+void s390_pv_inject_reset_error(CPUState *cs, struct S390PVResponse pv_resp)
+{
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_cpu(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_mem_state(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_completion_data(void)
+{
+    return 0;
+}
+
+bool kvm_s390_pv_info_basic_valid(void)
+{
+    return false;
+}
+
+int kvm_s390_dump_init(void)
+{
+    return 0;
+}
+
+int kvm_s390_dump_cpu(S390CPU *cpu, void *buff)
+{
+    return 0;
+}
+
+int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest)
+{
+    return 0;
+}
+
+int kvm_s390_dump_completion_data(void *buff)
+{
+    return 0;
+}
-- 
2.52.0


