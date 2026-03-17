Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA00FEDA0A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZhU-0005qI-Ne; Tue, 17 Mar 2026 15:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhT-0005k2-Bb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhR-0006Zb-O5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-485409ab264so1475185e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774208; x=1774379008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ysQHAl7anKuv2NxlFYNUxI/74Xn6F2ooA9p5oUbI8tM=;
 b=DjIv+DCntsqIHi8FpDyVDXLjVLfFQHRnIdWWKZSQje0wjWYijx7BY0AuEzzHi86o+k
 1VoZVBzf+0B9YebCAEXAeKmqNUosuEcoiteBi1x87YcKH0JGPhi/2r9VwiqDVOB2vI4g
 kXSJ5z/rq0+0EddHQgXcnL+GeHfyC4brIZUTsZsHgfNGb3WftADRjySfOivOFIzLutSL
 YSazQKkdPcK9slAfX0oi49kE77nNoUK53ffzYA+bJC3ShynZiXZMwlBhDMQeche9VtwT
 ysCfBlklOzMhrMnoGlBH9u+3wj8XW/UkhROLDUpqC04XSGaJV4++Xg/UmzD0uaos63f5
 7tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774208; x=1774379008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ysQHAl7anKuv2NxlFYNUxI/74Xn6F2ooA9p5oUbI8tM=;
 b=gfi38kyd6FjZlONe5St1RozSaglqlN2Lo8Pysfk4kjSUbWLJGfGNKntuLyH8858X/7
 UvYnC8FAHu3hBT/XlWhLSmAgtgGnnzjzDVABtIVBZ1k481eFZ9wnoDJ6QdjkoB8d8uqm
 +UYtVWzMJTAqwgdxp+sk6H/rspHqzplR6bTb7XuCLlUTPwQeqrzFM8E+ZpkXayW7EnpA
 2vqRWE1SpH+qOnUrO+5DPHGOjYwLLVunegDjagII/TtHVuafcHxrGepLz6eVW0Xw1N1C
 /MHA0pN0DD8K+RyxIvKhcCgFdUBwdfYeFu6oLWqfD5IvuToe+Gsl/8WLJICddU2Q+WnK
 T2zQ==
X-Gm-Message-State: AOJu0YwD/eKg4EcGdewv/kdm4fj64YzggjnUIat8TLie0+l0pVunSzty
 wSiYmPEeNs8Y1vMtrWYBGE3amtOu1KDTHy6YWIG5sQ6AnMj77ZXpPkI2IJFu7W1x/EVN3CJP1IN
 AAELxA40=
X-Gm-Gg: ATEYQzwK0txCgC70dCvtNLsOQ7JQGGPR0irxUM9Fw2qdnQix2q4Lc8D+IVMFvbcdXbP
 i1oW0Qlg9I8QVKZJEfLYXyVSgjf9QfNYU6bkXIm/ufmISHmXgP9KOEzMstmN/6e9nL93tMAkn59
 yfLgbhjWEse0scg9RvAVSJlLbp7uGAto32rMmB7tXMd480W7XOKtObgM6qfS6DOU2x6nXu8dAup
 TYzVdiFiQndDMJw0b0UAlVcASw6wsqnAmkSdz6hefliDakBiHy4LDx3FXb7dznp8guNZvLfadYm
 hrtSSAYnJUt/4dcu81PYNTZ5JEaRlfRST0a7c5zXDZSD0Oe3QuyjitILJJAgQ64XgPe+/Zgy5QW
 keU5DqVau0iE3hkYe97caIQUSdTkBEj/N4/EKTT0ty+1+aCwNlHPYjBgov8wkqcTYJUaHxGQz4M
 cQy2sKZJbbmKLx423+kVlc3j3oEKXSoq12TwGXPXzb/jfPfkPztdlsNN1szO3oQdK+kOcZ5iMX6
 XvRasiFKMM=
X-Received: by 2002:a05:600c:a00e:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-486f40a604bmr16308875e9.4.1773774207609; 
 Tue, 17 Mar 2026 12:03:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaeca12sm153177035e9.12.2026.03.17.12.03.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:03:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] target/ppc: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Date: Tue, 17 Mar 2026 20:02:50 +0100
Message-ID: <20260317190250.70506-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
References: <20260317190250.70506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Get the target page bits at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-3-philmd@linaro.org>
---
 target/ppc/mmu-booke.c   | 3 ++-
 target/ppc/mmu-hash64.c  | 3 ++-
 target/ppc/mmu-radix64.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b0..9cc66c613b7 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 #include "cpu.h"
 #include "internal.h"
@@ -492,7 +493,7 @@ bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     if (ret == 0) {
         *raddrp = raddr;
         *protp = prot;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     } else if (!guest_visible) {
         return false;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d026abadd11..2c33d98001d 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "system/hw_accel.h"
@@ -1065,7 +1066,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
         *raddrp = raddr;
         *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     }
 
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 33ac3412901..a09ba2b8d1a 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory.h"
@@ -717,7 +718,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
            }
         }
         *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     }
 
-- 
2.53.0


