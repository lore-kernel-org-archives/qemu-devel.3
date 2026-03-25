Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F16106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VcY-0001OT-Rp; Wed, 25 Mar 2026 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcC-0001EH-2X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vc9-0001Z2-Fk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483487335c2so3628355e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473487; x=1775078287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYU4i5VAwkEHAw1VrKk7PiVi7f6gEyJjDsvkpa8kUyc=;
 b=HXoqK/fxUR3IONC/u5TWuAwb+5EqkXZmJKDUu+QP3K/g2Lu9xyZK966qok1aChPo4P
 mYQS/XvCmUvnbZHW4y+QlS+6GPfMQXk3mvcug56rLr2eqADhpdjKBgZHpfO7+yHRQTVo
 2WL3lHUwTpDomk/Ev0zg24ho+XBA3iuxZi5W3bm258DsspMOkapbLqLB5zv6Yeu7aG26
 Tw9l9ZlQj5zeWVDokfZ4gL5eb4a18ZRLupLB0ZrT01qILSZmtAY/32Qkwb5I0Haz7D1O
 LTYZXGQ02IXrLOW57pAd7CiplGPi3bJAudOVKzIkBeh1rDkyFNsFlAhO7YKpC8b2dXYB
 jlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473487; x=1775078287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pYU4i5VAwkEHAw1VrKk7PiVi7f6gEyJjDsvkpa8kUyc=;
 b=OofzY4asfJMm9SuyV2JkpOmNwuZ9dR+41aWfoj46aaDAUW9FHGA78B6WQeFJi/3xJb
 VQey6yxj2bP71nbDiu9C5xJmJCfna4jzrGV51ZnPLSK/ISNTiRB3Xb1xTAk/RQeHLv2p
 InM09OuNL/jiY81wId2bndoIh7QQ7G025AvKnosZBpdyQUgaecrNqlUh3yXPJra0pHwk
 dEjZsjUAipMG4P71kP5U5Ks7PzI6U+Z6Gm1lsYpxNWyTU1KlilEgEjwjR6UC/WddPaSU
 aMUgK3ubmqlzAIlLScbrSosy2ixY6aeO69yVwILLNVUMMuE8IiXTxphrPExulKM9etjD
 /x2w==
X-Gm-Message-State: AOJu0YxfWgB3wKmBueWJM1q6S1GMAj0FhXzDPmi4Dv24RCMgkmt6ZcFr
 C5bMFYwYVu6HbJTvPNh2pTcGVLPlIwn24MBsk592b/SmRKVpRzO9QWA5PIf+BVk52JGwzslkpJL
 kmAkk1vo=
X-Gm-Gg: ATEYQzzaHJD+ivSBtstbZLNqL4jvXEeVEoW65+CzdC0mHzlyXT+Le+YNv6iEDWMNp/7
 D3xG15IUormeJQxe6Wh4vAh4yOJy9gXKy3/2WMYBiY2sKplATZoQwFenqt8FsIm2zh5JxiK8xoX
 vrIVh5FvNRh/cySnlHPjod5SCVeJZO3E/TPzWUBiNGkNm3q0BzF3uj0Zs1uGgzZ66VAMfdGC80a
 iN2fiokZ14E+3BI6f7inphVNrr3hO5fQHYJFQ3ziOWMe1hWCA6wMLF6iZo9rosY4CxGZJ7nudY4
 SMItCg7o+udHacLmNbAbSFbeM1FPFhM3sKsdGs+xIaRd7SwUZ29S4CXxvnjgwr2ti6WeoRC9tNH
 bcSf5Z5IKYzd9Bl8p6PQAKb3V3YMXT8EQYb3eoxKRNUJwCtEVP/Y8DvbjynFMMZzF46qtitW9Nc
 5/EtrYzGn3wGZ6tF8BeOFEMfI4ugNBrCr5aAyRqFGk6OQebfc94R9BYxv4C7wZ4OxRYR1o9nWzZ
 5f7EXahHgo=
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id
 5b1f17b1804b1-4871606730amr71524315e9.28.1774473486772; 
 Wed, 25 Mar 2026 14:18:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711709e95sm159875045e9.8.2026.03.25.14.18.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:06 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 05/10] target/sparc: Inline qemu_get/put_betl()
Date: Wed, 25 Mar 2026 22:17:23 +0100
Message-ID: <20260325211728.89204-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Use TargetInfo target_long_bits() helper at runtime to migrate
the FSR register as 32 or 64-bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


