Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9B1099B54
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 06:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3phv-0006h7-R7; Sat, 21 Mar 2026 02:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <souravpoddar93042@gmail.com>)
 id 1w3phu-0006gw-DK
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 02:21:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <souravpoddar93042@gmail.com>)
 id 1w3phs-0002QP-4M
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 02:21:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso628479b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774074066; x=1774678866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSQ89Q5UIkC/UY+OjRqSF7k7yNwRVgyzOGoYEVv2A2w=;
 b=XuK3TSJjnNL9586xnnOD12pO79nrANq2gOMQkXLMklHHk7+abtLN/RoD7MxW93SBZ+
 OO+7cfzOYgEACIoz39cbMndSSl5U54fn/FXgY2bwYgiRgkFXmmLLukLvJxK4OQCuc8nE
 6zxQ4N4myMN1ikbx52kwoYpSI+XNG/pfFePnleuf03IsXXr+KwmSHIBM89W4ho6uV4Ce
 FJgINuLN+WjlO2znTbQij8+dSID4ueBjAneqmTfT8XjJtRC71xF5XGjDQymYyBJUB2DA
 iOc4emxked1AtyePAnoBDLxDBr5V6ivxKfTdp03tiWOq49oOx7YVCPQAXtFduVjzCUld
 rQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774074066; x=1774678866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSQ89Q5UIkC/UY+OjRqSF7k7yNwRVgyzOGoYEVv2A2w=;
 b=Zw+k1x/2eJkuHjc3jWj0YlVrRYytEGf2YAI6kzfoPE2AU0Y5hrO1nkN00wnOVIUQMd
 FNNURyerPYo9T9odDMfJFypUmAVIjpYVF/KFN/twI42IaNTnck5KxNB4iIUfJdZhtjnA
 raGQfiiDU9coiwGymFsgVJfYv4aGuG0IS31Pdzh1OnI0UWcAhkrlQBfkD8b0G0ee0Oao
 jUyJRAVc/+J8099qLSy6DO9CvZrQuDxrY0f7wR+GXVR2kJ15wv3vWfssmEwVGdxtiPy5
 lt96N4CbRJ1H19fuqtqdrRi+FWjvG5JnGvLRh8lk5D9xwstPWRU/Dhd+dZP698MTVyEm
 Q7pA==
X-Gm-Message-State: AOJu0YzlA4oSGFYForPfEwckUyNQ9MYktyx0lxco45YmlkiHqc3GVt26
 C6SRVOSmJuN8+Azp8pnmeTiUzIfoy/IzNaFIKjYC4zqYqot1/xXv8BKqLGCrHSFt
X-Gm-Gg: ATEYQzwPJJhVVu3FrHsHCG5ovYNU9iWgCyutFsWSvPgyt5C10ZxlVwBF6p7sKUaDcOq
 C/2au0+coRW7mSHR5nopkQxYoQU9EbpnBm7NWGK+xRtnSvAHUuCpgGK0IqZOAUrJkw3s/3ZJ6kY
 rhtZ0hC2VPsEIhBHbgLECgftkOsZ4yzr/WqqoEKU4+DkyJuC790EHP2pNBuTgZiwXSx7aEjb84x
 7t1UxVRQL53NRJXKVyW0VjOTabBdbJnMVDbQxuIKEgvq2CBGlGbjnj7Mk6EJzay2zjPOJ20aKy+
 p3W4s/Z9p+j4UdumtXlQ2Wind2xqCTHhuBiIjwoaeEZialh4ng8op/7yI3oNnj7eHvXBEUjS5yw
 2ol21LcSur98TSCE7B3H6bZpQnYTX/v9VlJc9RcmMr/a3Q0mJiYIRk1OwM2SMYL82/1+opi9Ley
 gsjqsALu55Fzcac8dTaXapdWGd0MQd
X-Received: by 2002:a05:6a20:7f9c:b0:398:7ca0:5d32 with SMTP id
 adf61e73a8af0-39bceb47129mr5010478637.43.1774074066097; 
 Fri, 20 Mar 2026 23:21:06 -0700 (PDT)
Received: from kishu ([2409:40e2:15c:a951:bd6d:7ea:4443:ff50])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bbeff2sm3750429b3a.20.2026.03.20.23.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 23:21:05 -0700 (PDT)
From: Sourav Poddar <souravpoddar93042@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anisinha@redhat.com, philippe.mathieu.daude@gmail.com,
 Sourav Poddar <souravpoddar93042@gmail.com>
Subject: [PATCH] hw/hyperv: fix SynIC not initialized for CPUs after the first
Date: Sat, 21 Mar 2026 11:50:55 +0530
Message-ID: <20260321062055.20839-1-souravpoddar93042@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=souravpoddar93042@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hyperv_is_synic_enabled() is a global flag that returns true after the
first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
hyperv_x86_synic_add() in hyperv_enable_synic(), leaving them without
a synic object. This causes get_synic() to return NULL, making
hyperv_sint_route_new() fail and triggering an assertion crash in
hyperv_testdev.

Fix by introducing hyperv_is_synic_present() which checks per-CPU
whether a synic object is already attached instead of using the global
flag.

Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its not enabled")
Reported-by: Xudong Hao
Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
---
 hw/hyperv/hyperv.c         | 5 +++++
 include/hw/hyperv/hyperv.h | 1 +
 target/i386/kvm/hyperv.c   | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..ff53cbc699 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
+bool hyperv_is_synic_present(CPUState *cs)
+{
+    return get_synic(cs) != NULL;
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278..23091301d0 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
 bool hyperv_is_synic_enabled(void);
+bool hyperv_is_synic_present(CPUState *cs);
 
 /*
  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index bd3c26d02b..420c76b5ff 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -27,7 +27,7 @@ int hyperv_x86_synic_add(X86CPU *cpu)
 int hyperv_enable_synic(X86CPU *cpu)
 {
     int ret = 0;
-    if (!hyperv_is_synic_enabled()) {
+    if (!hyperv_is_synic_present(CPU(cpu))) {
         ret = hyperv_x86_synic_add(cpu);
     }
     return ret;
-- 
2.53.0


