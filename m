Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96839106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vcc-0001XV-4j; Wed, 25 Mar 2026 17:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcX-0001Lv-7T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcU-0001iX-RZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so2792105e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473508; x=1775078308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik5dNOPzzIxkGj0tgUhxiCaEIrTWAFn/Zu/ILMDzmRk=;
 b=l962iEv6Hf+vqgql/+m3hG9OEuUq+COmY83zckbTgYN1qpxiBfRkImjUmFSh9uD1B5
 se65jCagGyFaMpKXyi6e4/cmLXdq147t5g2aWZRJZXA3lyTIUKAcL6XkveNqqlIaT9Sa
 Y/wjGB+FYlky2lfHF7g5d0Tj/D0VuEUQv9hqR9RWIueNjwawVwwiEICtVrmZShNY1Urm
 7BNOuAcJIQJbbF6TouDAQVfQhtgpbxM8e0+VaIkpNzsG8//PVChUyElpl7H4n9ywVc9C
 4cOhQf4GEsqBdUFkkVIrJlQeiiDKm21TPrs8ww2xB4QlQk3yh+QnNy/FIVDqqHQyU3Uk
 /8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473508; x=1775078308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ik5dNOPzzIxkGj0tgUhxiCaEIrTWAFn/Zu/ILMDzmRk=;
 b=sk3TWSnC2LemtttZSqZMZiUCKNVyRiMxB4XVGmet9i0/JGsGhbqgKnG5mSnCMK2RSU
 3B4NVnfN262qmDKKgnhWBSj+bW0rtz2RQtXNfeAOY37MNmnO/KmqkoO/QclgYEmzCzW4
 mGY867NRZOvc46Eus/7ctSWCtwNT0IMctTnJsjAo3ENl4EKJZEg5ahqyQZ21C7A1mlAx
 Y4MD9ijoqy5CRlbnYSbqui7wu+cn0/OhcL5L2KA77MIQBxfNQdoPL3qvvhK9BKT50k8L
 1iWXsrIipNTqtuiEDGfd102hAWwSLKA6Uk0aZKnPdDwXyL+A0EGSNM8ZSsAT3uj8lwyn
 dVFg==
X-Gm-Message-State: AOJu0Yze8J0g2427k/MzZxFO4eZ4+GmFBATuIeD3frBtca3pa5oaLJD2
 eSyao1INiDqS+DfiveREW4VSX4oM8fdccHmNQXko76hTJ/4Hnx8lJKZFQ6+NqoACk7mUzWW/ZPQ
 kHx+mdW0=
X-Gm-Gg: ATEYQzwmXMXt6PBJt6jaxt8NwXcZPz9EeUBwTYqmd+RQhpbIbINt7NcUjw1T3DkhrpY
 gAVSmsTujqvgB+0mF/ZlC3N4QtHQxZtes2x8Vmb7rtZAUM/Bt09QT8kW2qVZGwCvHhuIuJcb76N
 qoaaOxjq+RjPeNMp5KclIHjr1yNM5l3mV+vIVfOkkwvS5ObhedjE4BA3Sm7en6rr4ioJPP70D6i
 1BChmwtwbtrv9HgxVcpsQ2eCS/S2hXEL9CvQUm7+UJ5pS13uKlu4PPDS9D0eEfsOMDVDtKIJI0O
 thajlbOEAMO/o0NXmDjI7qY58m2idaPAiII1vLC5l/4iE6qPN6GKGQ4kYodZyPtdEKo1PrJ0zDM
 5sD0VV7QP8CX7tTEYQ1s3ByhtCkxyIS1XGdSi9Mp5b2yTsR0oa9bWc+KMtRXf//9ku2tDw4migH
 SZ1F28U3/NZtGPTK5j5RP02Y02xaHCSzqULiG2SYogmc7Z14AOrTfKuzuQ9tKpG4PZq869fMKm
X-Received: by 2002:a05:600c:1f12:b0:486:fdca:ea8d with SMTP id
 5b1f17b1804b1-48716050758mr71567905e9.25.1774473507719; 
 Wed, 25 Mar 2026 14:18:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb08e9esm8608925e9.0.2026.03.25.14.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.1 08/10] target/i386: Inline VMSTATE_UINTTL_SUB_ARRAY()
 macro
Date: Wed, 25 Mar 2026 22:17:26 +0100
Message-ID: <20260325211728.89204-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The x86 target is the single one using the VMSTATE_UINTTL_SUB_ARRAY
macro. Inline it to avoid further uses of this legacy macro on other
targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h | 4 ----
 target/i386/machine.c   | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 82a81b5d895..ea411d863ad 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -12,16 +12,12 @@
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
-#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
-    VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
-#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
-    VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
 #define vmstate_info_uinttl vmstate_info_uint32
 #endif
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 1f5c517e562..16b65bddcdd 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1770,7 +1770,11 @@ const VMStateDescription vmstate_x86_cpu = {
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
+#if TARGET_LONG_BITS == 64
+        VMSTATE_UINT64_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
+#else
+        VMSTATE_UINT32_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
+#endif
         VMSTATE_UINTTL(env.eip, X86CPU),
         VMSTATE_UINTTL(env.eflags, X86CPU),
         VMSTATE_UINT32(env.hflags, X86CPU),
-- 
2.53.0


