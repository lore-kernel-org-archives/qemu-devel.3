Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881D8106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvG-0005sS-JK; Fri, 13 Mar 2026 02:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvE-0005i0-PE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvD-000746-1S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48540355459so15374775e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382973; x=1773987773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zwU8w/hWK7Lb+IdUfMpbVArjX56CliNBlAvM1YjgaM=;
 b=KuP27mm6ksHFf13xc6YgY+ki2gOB+O2a4q3vT+lLzgU8trOol9C/H7LWJidg8LWwM/
 Nu9VKtfp9Jg9KLb9z0KduMxoqCmTfD/UvXJu/U0WaB2Q0N7r0d19TkS5Ul7Aa4YQA5VA
 xIsujXhr7bCihvmzs6/RY3AdgRXistl9gcje+CkcrzTLij4+emoqGiHvU2aOgKlsqBpu
 96whgmNWoF9T/Ch7GRYLjQX2jv/IdnCtqn6r3dFE1lnfLpC3rxU7cCsic3izjRZNXPIU
 zBLCQAgbavd/RlrLxVNY+pQF2I71/yW55kXV5kj25WiY+0lXnozkykiraF25MMoZo6C0
 LKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382973; x=1773987773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zwU8w/hWK7Lb+IdUfMpbVArjX56CliNBlAvM1YjgaM=;
 b=rU4U7zLTU6ZvDVwZ8WRtc0XtaIHo4RkxVWaPyD6z4qZ25B+H1aBFZ/Br2njaBC0OBw
 eAfuYvyPWM2DG+7l/h0k4coJ4HycfQsESfd+Qp2W8o4C4Ny103UqmhFTpMTQc2J1PMDB
 jP8iKYATqNWlZrqdUlGtagKnBY0svRjEoX8G388JZQ6GIkJvAzF+wV4DQyYQmr7ywXFm
 xRvBDNIE3QQzCpwKO5d1ktGL8SBWLsvaBcdfklDB9LD921kFnOUWd9f6zsbPneohxloZ
 IUKQ5SLnNJclRrnun5k9ie+fva0ezlZiaXQ2M/q62G9C74SaKMlypSgeALe1MB7gTY/s
 MhYQ==
X-Gm-Message-State: AOJu0YwdUhCp19z7nDSKTkgOjv+TFEkKYVIkkU/OsGM0LdJ+QtK5WRpd
 Nda67MeqjWVWbU0EpTaEcN9W+lsXmdJICmYFRgS3wTFJbBjFzKsvvkamxYFTAOPzRx2hnuQWYO+
 mcmt/7/Q=
X-Gm-Gg: ATEYQzwR7TW2sITPrDfLkv8y2LaOOJZaebVdXy0ZyKHGwHz5qWY1cYPPyEOWOG5KMqq
 V9M7XW0jJVTSgfFvvwSq4eUCLZCuhWIgKGQFmj7p2AjTxiMaT+HTZIsKWyjiwFA/jW6e6gcD/Nm
 mDJKBbvevOJrvyTX/KPxfSh3otgfpfVlCoO9ExyiTv0gEekfgPYknCaQmvpEYWGAI9Kd5XGTM4m
 VNyIW7hcejlwLvlosPmHlG6BH3STsaGCPaFsJaV9GJsYAv84N1EOOEbnQX2MjFS7npAxMFq1ZpT
 SDm84fIHfhDfv3L+Z8P1KDI0G9bi0HIQbpDZMTjLuyBEW7jW4FRXOoiS1uM3Ocg4EV8PERIVN7T
 dE6E8jhMhMsgVpbjq59XvhRNun9OIrV1ivbdwt4cXQhxfHu9lVYjZuyA91AC5IWv/tyXX6LnMAT
 UrAJrpfsmUfzC9MA/zO8auQTYyM+nKZ2RU7ZpQWuZLytgSRG51Fh4HpGcishsSieNkLQmB7UsBG
 eVDEQ==
X-Received: by 2002:a05:600c:1f16:b0:485:3471:cffb with SMTP id
 5b1f17b1804b1-485566e2401mr30819125e9.15.1773382973210; 
 Thu, 12 Mar 2026 23:22:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm17061880f8f.5.2026.03.12.23.22.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 17/38] target/s390x/tcg: Include missing '*cpu.h' headers
Date: Fri, 13 Mar 2026 07:20:33 +0100
Message-ID: <20260313062055.2188-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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

The "hw/core/cpu.h" header (declaring run_on_cpu_data) and
"target/s390x/cpu.h" are indirectly included. Include them
explicitly otherwise we get when refactoring unrelated headers:

  ../target/s390x/tcg/tcg_s390x.h:17:44: error: unknown type name 'CPUS390XState'; did you mean 'CPUSH4State'?
     17 | G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
        |                                            ^~~~~~~~~~~~~
        |                                            CPUSH4State

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/tcg_s390x.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/tcg/tcg_s390x.h b/target/s390x/tcg/tcg_s390x.h
index 7c8aede80d2..975f60085ac 100644
--- a/target/s390x/tcg/tcg_s390x.h
+++ b/target/s390x/tcg/tcg_s390x.h
@@ -13,6 +13,9 @@
 #ifndef TCG_S390X_H
 #define TCG_S390X_H
 
+#include "target/s390x/cpu.h"
+#include "hw/core/cpu.h"
+
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
 G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
                                            uint32_t code, uintptr_t ra);
-- 
2.53.0


