Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4650C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6u7-0001ET-7E; Thu, 23 Jan 2025 18:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tT-0008EJ-Je
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tR-0004Qm-6N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283dedso15517665e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675947; x=1738280747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmeiNXwxDOryj9Nk89BSf7ntmaAiV2ODrxL67LjT3oE=;
 b=vGlj5meywuVKnA1SL/5HRmNpQdWd3c8qUEOiN1gHr4RIvHoWLJOAer6AaL9HRExYIr
 De1SG0IRAiCHIqrYkOPa42TF+dvLGtLj7DLiXviFvIVRHSQuU4jw4p0zRqvo4OzMxABl
 5QsY+3rpGwuQmGZOndUCn9qSoSaN7BSXHUS+uE1NOSvsjDXUwdnT0Yi8IoWT9Vl0u8DY
 GYb9tIULpGPm2t8egwWHJrhAxN/iYdph7LL2xkbpYq3Q5kpL890xvYQYFqTUPDq0Qb0r
 /Dl3iwSK5RXqU5mjvbHtfj58uvP4Gax0hG+/eb/MAOdg7uAWd5ApxOHor0G1QQ4gm5nj
 lJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675947; x=1738280747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmeiNXwxDOryj9Nk89BSf7ntmaAiV2ODrxL67LjT3oE=;
 b=dFlURCs3XLcis91GNZAvleiI0hoEMynLUTTTGUopbYYNRs3G42jMr3ZyNKQLqrDt3I
 Mkhe5BV97FwL+5MCzawObZhZj/8agemHpYf6GseYBplmUbJd84bgMgGIbGFk1CkMifo1
 6ueK9/IUabIsT/uhx9t4zajY6lMKlZMAQjLgKawJBiO1n6GkD6qIMC8u/umZQTfS0uCN
 evaQhtR4SQd9IH/DFxXgzL4RwQbXmFNXX+DEDdBCMvMviA/gtMGgJQRi94fAEEAC2+ee
 SU5BFAtEEhkgLK2WXFuyfMegS7boDnHbzCXgXzUvR1eDYcsouYW+zBjX0hrrU/rAiRna
 951g==
X-Gm-Message-State: AOJu0YyWLcXs+bPKNlaBlNd3+/MiZ6GC5kN2NZIVa/SwPKEUHQv87yPv
 Kwh4BdVFItMNrKubXKjGsW8aILo/t3W+3vaEhZovWjeNYhGz7KhHGSXWQnM9rz/jkkxwkMow5mi
 cIKo=
X-Gm-Gg: ASbGncssgs7Vt9+uQc9tXOx4feipGh+u5CgfMEhNSOMMQxGkxssQxjPFcZKy6VHyXle
 dBozGEQ9/Cl6O6EPd+b3MMq+2umJ/bePKuqNXrDyC3C34bPvwUEZP3CJeEAZOxn9CQSaiyuGuJe
 rUnRXmZ26Tf7xeN6bacIFDaWTROtgCa8TAvtq/LF1B0We12xAe86+D+D9kJr5jC3/doUqEp4826
 zN8FFMzCmTRyalKU2V+aCfnvwKxx6k43wZjQ6Trs8vvwjBLDiNaZ6Hwn/mAE4n5GqjeuUnXlIBP
 TX6KtueN7tiRXfLKwESaVioLDvLUtnkfeDznTImUQOSPhjAsZN24p6Y=
X-Google-Smtp-Source: AGHT+IEFJ1SeJWoUW3YaXnTGBs2yrvL22hVEarb/siWyosLBI70zXEF7xcr/1TRnUm9/lQBURa7m3g==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-4389141c12emr225835175e9.22.1737675947213; 
 Thu, 23 Jan 2025 15:45:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f355sm7138595e9.4.2025.01.23.15.45.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/20] cpus: Restrict cpu_common_post_load() code to TCG
Date: Fri, 24 Jan 2025 00:44:10 +0100
Message-ID: <20250123234415.59850-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

CPU_INTERRUPT_EXIT was removed in commit 3098dba01c7
("Use a dedicated function to request exit from execution
loop"), tlb_flush() and tb_flush() are related to TCG
accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index a2999e7c3c0..c05ef1ff096 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -45,22 +45,27 @@
 #ifndef CONFIG_USER_ONLY
 static int cpu_common_post_load(void *opaque, int version_id)
 {
-    CPUState *cpu = opaque;
+#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
+        CPUState *cpu = opaque;
 
-    /*
-     * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-     * version_id is increased.
-     */
-    cpu->interrupt_request &= ~0x01;
-    tlb_flush(cpu);
+        /*
+         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+         * version_id is increased.
+         */
+        cpu->interrupt_request &= ~0x01;
 
-    /*
-     * loadvm has just updated the content of RAM, bypassing the
-     * usual mechanisms that ensure we flush TBs for writes to
-     * memory we've translated code from. So we must flush all TBs,
-     * which will now be stale.
-     */
-    tb_flush(cpu);
+        tlb_flush(cpu);
+
+        /*
+         * loadvm has just updated the content of RAM, bypassing the
+         * usual mechanisms that ensure we flush TBs for writes to
+         * memory we've translated code from. So we must flush all TBs,
+         * which will now be stale.
+         */
+        tb_flush(cpu);
+    }
+#endif
 
     return 0;
 }
-- 
2.47.1


