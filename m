Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9629A106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxN-0003S7-2J; Fri, 13 Mar 2026 02:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxG-0003GE-Pm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxC-0007LP-2Q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso1908682f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383096; x=1773987896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rppnz+6PlzCajgWKzX2Lj/8uj+aFNgQ4vudSnBtsgV0=;
 b=YEuEL7YAFDBy9EtixdTQZo3wvS8I3gHz4PvohCpVgwLsDLju7uADjflRpZW2/CVO0g
 wBNLf9VblEYv0arxBwbph1lwEV98mrM5Cl3eE1kc2O6e9LoBtld4q6g4irHX/VoxS2ni
 a3XJEcnNqw0joou2pERCaSO0tWt62DQGpvh50V8SlYYj3Z3HTJt2MX2RhXKheTLmcogs
 aNBdzjjd5YaipU+pFQC7XUOFfoCnokoRakT1F4WaHlBBMfinqXYYz5NX4gEb7A0zbG9U
 HkE4JWXyQy/bbv5IFjervjd+CX14kUp6ToaKR2S/7x9m7Hb2Kvqh2HCdQDcwpaPlfJDY
 hmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383096; x=1773987896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rppnz+6PlzCajgWKzX2Lj/8uj+aFNgQ4vudSnBtsgV0=;
 b=tS4pPjE88nw4fS59VZ9gMp8keB6TnTqWAF3hzPZ7uP5jG1vZRlxYKhkahPRuDolNdu
 B0YqFR8XiYM+vBef666gOIvWLcAubQVy1InvN4hWiWjQYi9ibPz4Y9tbxPdkRr/sB8JM
 CBSJHTHYbXJVdQnag2lhBjqiM4RJMZDxTsZT8I+J0D56rS6833ZDnsR+ZDc3tDsha9dQ
 D8o7gTdqmIqw1Hd/DHhAODJVCr3r3r3s3/yQ8Tc9RnGyXRCl3kqsXUvPzcL6tRdbyd5Y
 1e4IsTFy9yWkf1VT0FBuEpW35gnYTd+3Tntg5ksYmZCM2JVoQmr43ijBfkbXQ5br453m
 jpvw==
X-Gm-Message-State: AOJu0YxtBsuG7vO9XEfG5tzapUp7wgtnXBoXXB47thkcKwOzYlENP9Rq
 GpPqExpAdxsq76jGTuuGOUt9lQiKNntVOgkMJbCeQBGQqBIwZ1GYdodQO4cUbAuDyY2IJhT6DAX
 HFRU5Zac=
X-Gm-Gg: ATEYQzzdGChq9QXJLGSrhsd6isitzpuIqTcGhA8hnx3wiYrMAvmRk1pdV6gQa6NjPno
 jfir7AAUH9p+5d4CQGUEux6xIlo9ANlpYJfZXYWck7CTut65+iumvLqyGkG5Yqecu1RCDNDiBc/
 kpceTm4teHvLtJ7t2NNocljhJoaf2rIk5NQMB1Zgfzdkec5Q3Otu/S239WzQ+xDKxyJ607NDnQz
 yebWVLRRJVuBxHu+oDowTqjIWSMeF2jk/erwwGSz8FvEkmSt1Gi3/k7vlv6+k1S4SCb1fkXmZOy
 i/B5AvMvXIJ8BPu8ZIMM4SWT/QZ/18CaQbt9LDRTCj0ELk9C3kgvQvbR7N/nykpPXPk5cQ/g4WS
 f1Xdl/6I9/mJaJuNvqhEj+zkFarYG0CvBK9c6Q0ueDToK9h9JQzThtEHhTyCj53MmUoYVjXVvNK
 rlUD6mvKMVm6cJu3+DwSvWgf4zbqRDIEb51/mr7U/p1R2HG9D7BcYav5hiRWhY8ydL92r2EnqFY
 fhEIQ==
X-Received: by 2002:a5d:588e:0:b0:439:bf38:16f7 with SMTP id
 ffacd0b85a97d-43a04d85dd2mr4053107f8f.14.1773383096213; 
 Thu, 12 Mar 2026 23:24:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe226473sm13370758f8f.32.2026.03.12.23.24.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 35/38] hw/xtensa: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:51 +0100
Message-ID: <20260313062055.2188-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/xtensa_memory.h | 2 +-
 hw/xtensa/pic_cpu.c       | 2 +-
 hw/xtensa/xtfpga.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index af7e8025e3c..c86ad06685a 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -28,7 +28,7 @@
 #ifndef XTENSA_MEMORY_H
 #define XTENSA_MEMORY_H
 
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 
 void xtensa_create_memory_regions(const XtensaMemory *memory,
                                   const char *name,
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index c00167859a2..370a353f1e3 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/core/irq.h"
 #include "qemu/log.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index ed24720f94a..5e509216df8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-- 
2.53.0


