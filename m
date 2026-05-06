Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FB4CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmd-0002MU-OL; Wed, 06 May 2026 09:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmb-0002E6-Tp
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcma-0000Ac-1G
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so32478325e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075961; x=1778680761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FprVQ5wR1d4Vf79cPTC1JLTTgXx+APXAerAyuJrHnZE=;
 b=Of+t8LVk7glJv9xWVnWX2/LxXT0k9izf7E6CjdcBuczIqz8xKL+Y6HaYuh7vUZpsKD
 Axb6d7JfoyXLNv3S54+0tPBisFiRLkf+0ZV98nR/x9cxkKMK3YoAaPoH4yO+SQXOQ2o6
 tZ0x2h8PjAhxptDZyNvMQUHbYgYawWzIPSzy8XgeGGeIbSHnK8HFAbCENAqcX2OJrEDh
 ochQ56t9LmZus1+8MA4BgCO1bOo6M2dYJX7nw2PgOVBf4o2DUi1dr9DeVzj5wT0AQOB/
 4cqJnkoPswWVbzJenkDdL8EIVhRg74odhCkRamknlOdbb+BQlVYxAEW9N3/aJiSpNvWG
 jWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075961; x=1778680761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FprVQ5wR1d4Vf79cPTC1JLTTgXx+APXAerAyuJrHnZE=;
 b=VeRQtvqU5uEzdW/qXYhMCjTqSyDvwoTha/UdV7K2PChXaFt3Q2wPJrGQ8h4Ahy8vVY
 iNqCBlZ+1akDylWaJazn/7Ss3nsZl+a3a2Q4LMEP7dO0TBJZpTrK3gIolxtQXZ/fs29j
 BDZ/ls3yyV1JFloTw9YZPMSRmuGuzxAsmlZAmjpnYrqZINlIyN41AvPDUsNxYdVCMW78
 A25WBdDk4ZUCetaPrqdJabkbXqqSMeIaUj/Qy6nKFwKLvtcB7zFMobgX2GHaepBvx+oO
 oKe0jdhF4yBxJlz4ZEkHByOtfWZHlemjHPHOu05Bw2McLLBtb2zOgn1sWFm4WGD52OgO
 WzLA==
X-Gm-Message-State: AOJu0Yy5xdXIU+JUKD4gBRfvsOeSIT+tIoptbGXo4Pgms8fafopgwqgf
 DX4kbORP0uULyYlavZzKlDSJHgR6H80iM2qF04a4D1jpHZquZoe4clkHKnjoEX8MbW4flqUJnj3
 6hW0MiFM=
X-Gm-Gg: AeBDies0XZPtIk4ZVSZGKq9cuzmaOMKP2iwnsMeyr6yvVYQuRxo4l6NkY8pBb5AApSy
 v53RBAkY7GeO9nWZuP50RTLxORBV3oTFDiRjqR1UcZQZAp3MLYDDWkR6O7CDkbhA7JFLRZZvHR0
 oHi5+SkUSGYh0SYrkwysGTvoGul1GN5Ui8k5EEDRZ1wKAE/czKmXy9dt9/dJ11j//jSFtbZUd5y
 zjXtwEUNPvnzeKvSrlCmxvRjgs5/ojNHiaGxHeqOcJVzYbDLzfNQ1ru2UPV52AXcEGLLZs+uwBH
 DKUuo8UtkElGYAgAYnEp/JWdRjlg7KJulLxNFuRK1tJGX5ujOLu8KWIDNDBrqMMHQmOmzwQLrI/
 r5uXldd7aF7kli3af8OueaC5Y16kYWyKsIbWCesD406L2K8pIYD7+GcafT4gIzetMbeWYOuSqsP
 7SDE5iliLBhmjDGhG9tn7QfO3TbdULUCBBgAy9OyZ+jGHOMYxSlup/1gdZyMs3BrXB9/CuwqhiP
 67qn7NFj9k=
X-Received: by 2002:a05:600c:1d11:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-48e51f2c7eemr62085325e9.10.1778075960896; 
 Wed, 06 May 2026 06:59:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538c4ae1sm47137335e9.12.2026.05.06.06.59.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 031/110] target/sparc: Inline qemu_get/put_betl()
Date: Wed,  6 May 2026 15:54:03 +0200
Message-ID: <20260506135524.20617-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Use TargetInfo target_long_bits() helper at runtime to migrate
the FSR register as 32 or 64-bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-6-philmd@linaro.org>
---
 include/migration/cpu.h |  4 ----
 target/sparc/machine.c  | 17 +++++++++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index bb8ecfbeea5..87ca977a3fd 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -8,8 +8,6 @@
 #include "migration/vmstate.h"
 
 #if TARGET_LONG_BITS == 64
-#define qemu_put_betl qemu_put_be64
-#define qemu_get_betl qemu_get_be64
 #define qemu_put_betls qemu_put_be64s
 #define qemu_get_betls qemu_get_be64s
 
@@ -21,8 +19,6 @@
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
-#define qemu_put_betl qemu_put_be32
-#define qemu_get_betl qemu_get_be32
 #define qemu_put_betls qemu_put_be32s
 #define qemu_get_betls qemu_get_be32s
 
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 4dd75aff74a..0a449f2f8c6 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,8 +1,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/target-info.h"
 #include "qemu/timer.h"
 
 #include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 
 #ifdef TARGET_SPARC64
 static const VMStateDescription vmstate_cpu_timer = {
@@ -86,9 +88,13 @@ static int get_fsr(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field)
 {
     SPARCCPU *cpu = opaque;
-    target_ulong val = qemu_get_betl(f);
 
-    cpu_put_fsr(&cpu->env, val);
+    if (target_long_bits() == 64) {
+        cpu_put_fsr(&cpu->env, qemu_get_be64(f));
+    } else {
+        cpu_put_fsr(&cpu->env, qemu_get_be32(f));
+    }
+
     return 0;
 }
 
@@ -96,9 +102,12 @@ static int put_fsr(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field, JSONWriter *vmdesc)
 {
     SPARCCPU *cpu = opaque;
-    target_ulong val = cpu_get_fsr(&cpu->env);
 
-    qemu_put_betl(f, val);
+    if (target_long_bits() == 64) {
+        qemu_put_be64(f, cpu_get_fsr(&cpu->env));
+    } else {
+        qemu_put_be32(f, cpu_get_fsr(&cpu->env));
+    }
     return 0;
 }
 
-- 
2.53.0


