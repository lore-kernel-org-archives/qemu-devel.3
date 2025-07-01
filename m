Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0809C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcEw-0005Tu-J6; Tue, 01 Jul 2025 10:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEE-0004jv-2a
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcE2-0007BL-7J
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so25120435e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381082; x=1751985882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=Jn1EzTazTHXr6P+qFtunVIDpEb8EuIDvD6+TeBxbcBK2j2lq+TOQ9n7o2BP/e/nKPZ
 aElLtqlQmzYzDXagAWBNLaptnWQNZZmQUngyQK+u7+2K2MYzgrf2STTjlTM7Hv14XInM
 CDCS7fEzeYzGjMnwM7dv/x6KFi2GMCslXKoyixlblfo8Dk9GhPIE4UGBVlC6HoWZ9bI6
 mAzbFoHXcrG+zwU0Xb0ZZlD/WpwwJuvhQm5y6FO3DMJxsfh7Re1Fk+W2wP344Q+tNyKB
 25VGOSG9zP+sqAhEiU5QGMKHAk4GB7kST02tc6GSWh0+6HoBKpjpXuTYch7IDSkWxC4H
 cyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381082; x=1751985882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=kLaw54R9JO6E+JA9AWhhcdEUVWLEWGKIGNB20Qp0rONxjnuASDQ3JXf0+eeP8Q4n0f
 sHiYKpumLNxe10MD4zwjqrN+/l5Y4Er53pf8TTZO232bVDZcl5MY75oXTP/OCAKDYl9s
 wyZJ5pLHKQa6lxmhL2gC5mIUQMVt3PBYqIsTtsLBCAInBMuGsgACu2IeCWeBHH1TlaxV
 r/QTYtMzI8cMiMMOuq3DQfPL2i5Iy3Ido0MhZ22lBmbTPiCMyMcU0NLmpuigDuGdTzbw
 Rn+JSKpmsdMEDMy9ho5AvC3Lv5hIRkPm8visSrNi+B6Lyl2CYErV0KUeVVb/2RmvBN4X
 0GAQ==
X-Gm-Message-State: AOJu0YxmWwO4GizTYJCrd4bPMR3e/ZrntftrEGqfr2IVnkADeHD3+mtQ
 qvbBURaQ4IjA6mx2e5rssLXoBRlxFbv74kSWFrFRiSHNjNrKlAsCWOAngli6ZCvLZQqXx9JE4zh
 c6Xgg
X-Gm-Gg: ASbGnctYhyafUfnwb5WhX+nmTnL/wK/dvT3RSXuNBvhiiJje50YtPeFM32oeP8KWQkm
 jtBIYRDa5HNjRYgAEzp4RV6sL7BeRyUBOTfpjtvuGS3Y43Vp15URl28bQlba8ki8RUEFH1fAMph
 vjW51KXuHsHWcio29MaRISBse9RAFkizABIDvlmF6jjEJnM4XU2QYex8KThGtIfQ/2A9rFmpysz
 FAe0moJlm03HdZWeexHbz0zfQanctdMqvMiSF761Eenx9CdCZvRDI+kOCAyCGRV6bXyRnq7mSNX
 ujpG4EosX6u/80hRWAKfU3s8lxxdIlE9BkiYNSdu34dKCxVDvrwcqr4YsQge9S2iL7K8nLLReLF
 eZjDb28IhqOIJyHp0yfgwhXiuWiatnU6jtS9I
X-Google-Smtp-Source: AGHT+IFsvJT9COcIqRNN0mYmgHgEJuZSEJrFfso5XYNsuShiImqWhlrV6XZ4a4vIRINrCeWo40lfpQ==
X-Received: by 2002:a05:600c:c4a7:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-45391b6b961mr153078425e9.1.1751381081961; 
 Tue, 01 Jul 2025 07:44:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6e9esm202069705e9.28.2025.07.01.07.44.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 50/68] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:39:58 +0200
Message-ID: <20250701144017.43487-51-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c91e18bc3dd..b61f08330f1 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -207,22 +207,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void hvf_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /*
-     * HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode.
-     */
-    assert(hvf_enabled());
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
@@ -369,7 +353,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_target_realize = hvf_arch_cpu_realize;
 
-    ops->create_vcpu_thread = hvf_start_vcpu_thread;
+    ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
-- 
2.49.0


