Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C47EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQRm-0007jn-Uq; Fri, 06 Feb 2026 13:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRj-0007iA-E0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRh-00054W-2k
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so14821335e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402043; x=1771006843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOzC//luueUoLOzpB6BmpxSYIFKhPzwuSOFEodMkyfQ=;
 b=Cxfy+/v/soHDMkBW/QM4G+hswstDoj+ek+PWzWBqm+oTQUQQ6lEa5r1sp1Of/poCP2
 L0LKWPE5NJxxYzsEEu7EBiJxVd6g7Un5j64H4+YcU1powuYjDh97evK4WY0/J2oL4lSP
 Usq0VOciq1yCrxa4dN/ZJjzAVVeecrKhNLUokVy0C5ZQ75/pfUJkhYFdGAuXprA3L+TG
 /tFPFY69PAi7qHLaF9GcXRuEKwZtWM6StC76EzkxZJMjufug9YgKRrE0U0vvYvvjI58A
 JM7Qxlpw+mFNQi0GlMLv/YkNvMS3URUajlW1+tR+P38bLNCxwk3Zr+cM4tcTQrArZ3aB
 fdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402043; x=1771006843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DOzC//luueUoLOzpB6BmpxSYIFKhPzwuSOFEodMkyfQ=;
 b=up24LvzqDKvjDixDB2vRkNh5w7gROfmsX5fduM4qGG5nhTd6kyGqR2SBH8gGoQHJWe
 BC4SCWbs/BrF/APLN42xwbp2Cou82CQMfX9tMMJOf1b0Mx6jkGfpnWvTO6Wim/8WZY2s
 aWlGC8WWAoKNIlFJ41zHk0UCAFFkNrRF0PX9sWyghZ8VMZgkkUUlJkx1Wk8R3etZihTh
 SbeoWY1vySNaUF8RJSqYChCf94iaIncL/ktLNyM9HMZN8Z5NrUqa1oG7sAIZmg1sbqZw
 deeVLieu+NMHmWW7hd28FEyPoak8AZlV/jUETCkEn9ZKIf4TCYxcMppRB0PhMH2+p1Zp
 1mPQ==
X-Gm-Message-State: AOJu0Yw1jN6nKZT/49pvAHu67ZuDJ8N3hjk5i/smhhfHf4tofgoEH9wY
 /Ntt4UBx/FTKHQlpmImJfzkkS428nb7Gl/8QrMWEVQiLhW82GOZT3sETLF9pMSJHxyVI00aVcbv
 95flw/dg=
X-Gm-Gg: AZuq6aIBsuioW1Vpu/14jqpjkLTlB0OSxBGeowuh13Q0MSmfRQ9389JiQQO7HEVN6SJ
 ri4Hq4pyzQyHRH1QFm5ydURi6ijGI8J5UDzm+Qys56TahpruWX/P5j8iyIyUTljNkmmVhuz/ohw
 +Npp7wrbg5/D5aT2UDeDNcRHm3YLMFAkQ0tlbhXhEjaCF/xs/XjepzduHy0fQBkJ4J9SBnEpUM7
 N77JmvR0d16INLFR8EVLitRERH18iDYTYytV8E2FF7nMliSY4yDmvyCuKOcBN0Bc6ETilfxR207
 n+NQ5KeKj80pKJhwHc53Tl+KwYT3PG9rXKd5Dp3b/JSlDymGVaOE7qPVDfjydcEI0D9KPWOcSWi
 WXB8QjAml4zlzeNE469IKnQe9aelzJJvaSU1sSGrnHlnAyWLhfmpXLkJCL+HdMat9Xoufymrz02
 Y4k2zibyJB+3HdB2Pa9v9VDWQVfoPcS4TOS7YYbrDdL9T+rf97hEejHgFggNT0SsGDtOPzDpM=
X-Received: by 2002:a05:600c:8489:b0:47e:e61d:b8d2 with SMTP id
 5b1f17b1804b1-4832021ebd6mr53818175e9.27.1770402042634; 
 Fri, 06 Feb 2026 10:20:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm141357485e9.14.2026.02.06.10.20.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/10] target/s390x: Add more unreachable KVM stubs
Date: Fri,  6 Feb 2026 19:19:49 +0100
Message-ID: <20260206181953.18683-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Next patch will move s390x system objects from the target
specific source set to the common one. Unfortunately the
kvm_enabled() macro won't be evaluable at built-time
anymore. Add stubs for KVM symbols unreachable at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/kvm/stubs.c | 76 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 046e1f922b7..196127baa51 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -4,8 +4,9 @@
 
 #include "qemu/osdep.h"
 
-#include "kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
+#include "target/s390x/cpu_models.h"
 
 int kvm_s390_get_protected_dump(void)
 {
@@ -104,3 +105,76 @@ int kvm_s390_dump_completion_data(void *buff)
 {
     return 0;
 }
+
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
+                       bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_get_hpage_1m(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_cmma_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_crypto_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_set_diag318(CPUState *cs, uint64_t diag318_info)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_topology_set_mtcr(uint64_t attr)
+{
+    g_assert_not_reached();
+}
-- 
2.52.0


