Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788ECCEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGKr-0005Dk-TR; Tue, 06 Jan 2026 18:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKj-00057h-Tv
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:26 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKg-000114-Ry
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:25 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so764223f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767741561; x=1768346361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MSw6pM1Isj343x+S0mtnkdkQ6xtf+8KOtUuCijJ/iM=;
 b=PzNDPchUgvW134bzM3ckY+qeoHrqdn/y5ajzMreWVujfLLDWwmnLsUyNICcFrSbXyV
 YSfI6sIcIEkGqnnvplNEC3PzdSB15WwYxGbYgTj5J3uUvR30VuRFd1WDuvAaAddUSWQQ
 9GXBVoo8QxGOspsRR62JrmQY69IIKbrTmI1foGIJALXEk8svnFOEID+2G97+PX5uqZXr
 53mAq/rmmbeWVOLHOP4dJGJfPSwDnFwSLOh9Gon4ChxZReKDxYnRfTkE2io2+ByYeu+V
 +y/UTogdPVu4Otm9bxlgVWXGfoTVwa7FDrF2iyPM2zcLVk0+IiwWcb1siua4VjoAL5Pv
 I+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741561; x=1768346361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MSw6pM1Isj343x+S0mtnkdkQ6xtf+8KOtUuCijJ/iM=;
 b=DvHgbUf8q1n/rj6xbOJUM32MZ3nCedXH1lqDX0fWyRuQSVRcwNFxBDzscaJBZHwKhD
 fxp9t+l5A2FyfEL3ODMBkjfLVYECKEZ98NM6fBJ6Dh+1NiFFfNqCOe+jhyM0/IldIqFk
 TVLGhJHRyFr2P9rE8xIs2rmmUFewa1BAP/f64t+PvLG8X1gby9AT4M6UShlvahPkSkFD
 JIdiy2X77xU1ehQOC/pH5YScyBGpsoZ55O8ZknMNQ77cLMkZqGIt/OrWlgWjY/oayNjH
 bPbOxOyTGNgef6QKMzmqzRa1aHI/JQRXEsrScaXnWRhD1YzLJt9MHMvYdV8mU1WAwjxm
 OctQ==
X-Gm-Message-State: AOJu0YxWMJ5xd8O2FG5udvgCARAa3a6Esu/pQ6prEqMUMnNLB+URWOlU
 87p0WtoyrG6lolkXRBX+wpIlTlLIUM/0BFvCcl5Gj1GlIW02Dukp25GheT608IlrMyEWNPwVidr
 7e27r5qVDuw==
X-Gm-Gg: AY/fxX44yVGQ3lRz0vP/XNI3s5hxu3hUjWZnEmO8Z58ECuZF6HxD9mhEGvYU965KKpp
 nGkuHYOu1vwZI9oQojqyqumpcp+v/buCF7YVLEvIEsysNZbUElj5pOqF3TvFs6u3zkjNJBJ7BIW
 TEkbEETWGC9T0VqiKKh4u42esQYsLxkR+isVXId0vffadw5BPSe517M+DwBTevBn2PUXHPwYi7B
 M5OTkeIzCq/T1rB2YCiQKcupXYH1s0oC2fuYi6ag7YPdm7/VV9WWcazp2NuBNNd5ST/aFwTRG7+
 oRF01qmCQed9ZyQvjd3M/XEzoPMcIJG3bfYDq7RHpEDCC8eJwp80PHGQsYRqUOE6i3lUHbwAiox
 G63mutAVk20eYAB/UXDDBgFQ4vXMeX0G5ltIGu6O+H1xrNPCeFjf/oNJHy2awDNxvdxkBX4xqNh
 P5QMLCzCkX6++5CJdVNl34XWP7RR55h8nnJ1GuvmrXv6O0Z/21Naq7mLk24hrD
X-Google-Smtp-Source: AGHT+IFhOTFzCPaSSO0jICAUELJTem7A365yBYeKRFZ6R0EZuKOxmdBZJj7PGcudVsIGaP1SPOx2kA==
X-Received: by 2002:a05:6000:2dc6:b0:431:1d4:3a8a with SMTP id
 ffacd0b85a97d-432c3628301mr754519f8f.7.1767741560904; 
 Tue, 06 Jan 2026 15:19:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df91fsm7184522f8f.23.2026.01.06.15.19.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:19:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/5] target/i386: Restrict WatchPoint API to TCG
Date: Wed,  7 Jan 2026 00:19:03 +0100
Message-ID: <20260106231908.16756-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106231908.16756-1-philmd@linaro.org>
References: <20260106231908.16756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

Watchpoints are specific to the TCG accelerator. Restrict
the cpu_watchpoint_remove_all() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd7249..9831e2bc210 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9184,7 +9184,9 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
     env->dr[6] = DR6_FIXED_1;
     env->dr[7] = DR7_FIXED_1;
     cpu_breakpoint_remove_all(cs, BP_CPU);
-    cpu_watchpoint_remove_all(cs, BP_CPU);
+    if (tcg_enabled()) {
+        cpu_watchpoint_remove_all(cs, BP_CPU);
+    }
 
     cr4 = 0;
     xcr0 = XSTATE_FP_MASK;
-- 
2.52.0


