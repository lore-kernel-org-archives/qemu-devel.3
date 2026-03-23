Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508AEF483D6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXX-0004mr-6S; Mon, 23 Mar 2026 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXT-0004aL-U5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXS-0000bB-CW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so29549025e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284840; x=1774889640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4MpTe1yv7uEMZE6CnXhL8F86Rr2QJaTOJmEJNZwsfqQ=;
 b=byq5oydEe/VlmG1/39r8cVdThxb1L6J6+hXpUnrRcCiktJKyi1auFwf+qaFr0KZbeZ
 SBLSpZxWWWXgxVosgrTkAy2pqdp8ntE3TG4kLUDE1ke5xpwY/66FISOTTFKmFBafg5iF
 FDZecwRthOVZf4KUi9pKgnC/ozQM8+EH3voUsRUk410lSN2LiqxB91wGXSpDzFYxk62q
 6jhzhRYaDyxtBrxz7P80HAW9ygb8qoRw5exN25x01SbIfOaj9i79w7jo8NA4ox7LFPKL
 JigmKHluFHTVgdqipD7sDm97ztlCxXW0RVmpag6KaxTV2Xn4fgcrtVM/ajQe3ebiht2B
 G9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284840; x=1774889640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4MpTe1yv7uEMZE6CnXhL8F86Rr2QJaTOJmEJNZwsfqQ=;
 b=aZg0dFOdSJaD8jEsoWLHWjf+BlNWJ3gtVA39IOXWuBRcobuOs5+cOskAQXQnd5Grms
 vVPxEKDRKpMhrZRLOjvv94fFhjAz8HXJ1G3IH3UbSc7S40kElVHMQIbvk3SAq7/NpE22
 ZfaoF83GEGrssudtsnlKZh++OKNTrR5CeO9A7Ykgk/XDQIb4Fb+JZ/lWakQMF+vHjS13
 EC2xHFPXKlWV3YZpcLcvVs5UVXaruh9N2AebXneadUmzfW2dZL9JcXMQZdxWMRusbxFg
 wZouUshCXSFA970Nl4OvfTrc3IoXoowJRabpZR9tXt7hnmmV+y5GBWgUUHm6OkiwIurG
 NG9g==
X-Gm-Message-State: AOJu0YyGD06XEHbP1/ayeBky3MlOKNcM1c/lz7IzDj4ntJfWUmBiFPcv
 JuB5RG3XxzCp/b6+/Xa9IHCdhuvC45A2nTjzntT8DSCPk25tA1l50BN+hvTr4tdPC0LElJ9z4g7
 SHX6IVAU=
X-Gm-Gg: ATEYQzxwqSL4FmQrNa3uJNZibrCzte6JcrvHxgEWqSiSUWnUz95EEs63jdD+49AhNbm
 gKIUV3AD+zmMb+oz7q3qVZ9DIOizeK22Cu/lyEbPRGf0mVkXRpY44ne5NyLDltILxhWC79TVXUU
 QTRkFncVK98VcvUxASFxGZgPlpfIlp7cqyhorkIYWUzG2k1ubtYLNCEj1RlxSPIvlaXpbUaez8a
 FHvc+B3Fi5vQgDFX3TNH4HOZCC613W/U7K/Fia65BM4bsguDjjnS44+vFUdXPk25cPFRwrKVrAL
 g4Ss/66bjuyPFNzJKQYIS54MOPmzB23XtbZxXnMSWj5jdyMK0Q+DpGb8i8IWVZzbOBEBE+1AaRZ
 i3NWPJRvzbCy51+TlCkLaegkatwt5ENL6fTyx0mN1f8GfS/xtCalX6fePdrpfhUqi8j3lxzIQb/
 UKommKn2wyae0npzxGQRdi4Gg6YmAXVRDZ67VrPV25hhJWDUmGjHmVARbRJ4K5yKunfvQ4wwmM
X-Received: by 2002:a05:600c:3212:b0:487:1c2:6a4c with SMTP id
 5b1f17b1804b1-48701c26b76mr91783185e9.4.1774284840485; 
 Mon, 23 Mar 2026 09:54:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm32046440f8f.17.2026.03.23.09.53.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/27] hw/hyperv: Fix SynIC not initialized except on first vCPU
Date: Mon, 23 Mar 2026 17:52:06 +0100
Message-ID: <20260323165218.96607-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Sourav Poddar <souravpoddar93042@gmail.com>

hyperv_is_synic_enabled() is a global flag that returns true after the
first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
hyperv_x86_synic_add(), leaving them without a synic object. This causes
get_synic() to return NULL, making hyperv_sint_route_new() fail and
triggering an assertion crash in hyperv_testdev.

Fix by introducing hyperv_is_synic_present() which checks per-CPU
whether a synic object is already attached instead of using the global
flag.

Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its not enabled")
Reported-by: Xudong Hao <xudong.hao@intel.com>
Co-authored-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Message-ID: <20260320154752.204725-1-anisinha@redhat.com>
[PMD: Reworded subject]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/hyperv/hyperv.h | 1 +
 hw/hyperv/hyperv.c         | 5 +++++
 target/i386/kvm/hyperv.c   | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278f..23091301d06 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
 bool hyperv_is_synic_enabled(void);
+bool hyperv_is_synic_present(CPUState *cs);
 
 /*
  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index aa278b179e6..a42c2850e35 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
+bool hyperv_is_synic_present(CPUState *cs)
+{
+    return get_synic(cs);
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index bd3c26d02b5..420c76b5ff5 100644
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


