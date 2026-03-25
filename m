Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A71093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vbr-0000uX-VO; Wed, 25 Mar 2026 17:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbp-0000s1-ES
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbm-00015Y-Vm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso2512425e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473465; x=1775078265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfJwMXjluZgiTP+augjPX/N9RW5TR5jPeS41ZUSD62g=;
 b=AZhlndkTp5ewLI9TiBhe7U4Vf+ftBZbvbqCIauZaad8AgHbLyEEXo45EhDQcigsHvg
 g5CVs2DaLk7i6QJ5oseAgWY20sltBSUdQFYfK9A07+9yOrmEiKuUR4MBOfBDstNNIbpE
 vHB8xW7VqKxFCj0ms+Bf/tmXByucjYqnojjqEYI52aEdAnfriarjO9WQ1YmKy2inpjG1
 3TDG+1GKN8B8dwMCQh0IpBP5/wN8YZbBmS1iL8wqZqAgSIjOJaN7pyGTQAUZUTuq7jZo
 FE7Ols75m0sF1k4oXbE08O3BGakPDRW3w0VRFhB3cCrJKvpPN2yhlrKKp1sauzMRMBC/
 CTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473465; x=1775078265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kfJwMXjluZgiTP+augjPX/N9RW5TR5jPeS41ZUSD62g=;
 b=l/SdJ1T0kWNivfPZ4xpJeSftIcXtCLudPD5wNhoJLVm3UTlmtnJW7dLJv27VeX0hqz
 WAaAgkoHLIH6nt98ergvuPg9AZcBfXKI6V4BQ8JgjJVhXRObecSe9dnWycZ3PQbXg63A
 llpidlvuJc6cKV9B9fgLPVPiPRUoM5/92McQa21kM66VLUR3ZQWC6953/iHW6J+tvQ1f
 BwHc10yVwBlOpQRzrWo6jawePxqnHB6JvLbaTMb/xtiS2IR5wg7BzsL6DNhE5INHszqq
 LdGTgJv9GxdygQ3yT5Wc1fti/4iLRyCxhI5WPXRaVr+7HFcqFwHNEJBXNbHqF6gYS/z/
 rR+A==
X-Gm-Message-State: AOJu0Yy4xd6x7Xhb366MDEJMZJlY4+f6qQlcQG5K+j2KJP2TjHzcTNij
 qLwSetmEQz/IK2Qy6olb9+qEr3D0gUWAmJzXE9oB/JEecyupGov1rU1wzRGuUmWByVzwD0S4Vrn
 4QkZo2Uc=
X-Gm-Gg: ATEYQzxwCPxw+IXv801igvJaeyUsfly0U9VG+3hCNEek4JGovTe77EtrmPPuyRs6+GO
 kgPhEXAlPo980trRwXkA40jXmvRAAh/sgXMwmUbV4JQbbcJZvdTuAOHZfy9s/FQGmd30nXOnrnh
 LpaborHtLnhIK8CJ5osH7sHjO4/lGX10lGFqy3DP9LdsOZpKcxY3Tk5khceaATTC2EooZfhPRcD
 A+8Kb7vFVyiOsIZ8HL4c9TlN5hhirsdBy6ULXTKctgCEjDdEQwLIMOi4TZ6g0JU1SCLuS+3FFFu
 0H3vrpbnFGzwbkNnLGaeY1dKx7GLA3YF04M7kuPoh+bYwCRLkk9AlHZCoJBjfniQAxwnGHYN9BG
 R5PEEjcSJ3VfyX+0v7gQsfSu2mpmdAXdcAC6568uKjG3X3EY0akNn4SdewnN4xBjZgpOovusa84
 P9UI+GoP8DshKZDSpSEkF8FrAEdlZhj3mASff+9XK9/NXTSRptiEUy7mCAED5N6sCJRgkkGoLw
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb54 with SMTP id
 5b1f17b1804b1-48716039b83mr72870265e9.20.1774473465043; 
 Wed, 25 Mar 2026 14:17:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3cb42sm7864125e9.9.2026.03.25.14.17.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:17:44 -0700 (PDT)
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
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH-for-11.1 02/10] target/loongarch: Avoid target-specific
 migration headers in machine.c
Date: Wed, 25 Mar 2026 22:17:20 +0100
Message-ID: <20260325211728.89204-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header required:
"migration/qemu-file-types.h" which is not target-specific.
This allows to build this file as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/machine.c   | 2 +-
 target/loongarch/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 28b9079d04e..4db53fec267 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/vmstate.h"
 #include "system/tcg.h"
 #include "vec.h"
 
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 2ae96d68695..c5a2953b29c 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -10,6 +10,7 @@ loongarch_user_ss.add(files('gdbstub.c'))
 
 loongarch_common_system_ss = ss.source_set()
 loongarch_common_system_ss.add(files('gdbstub.c'))
+loongarch_common_system_ss.add(files('machine.c'))
 
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
@@ -17,7 +18,6 @@ loongarch_system_ss.add(files(
   'cpu_helper.c',
   'csr.c',
   'loongarch-qmp-cmds.c',
-  'machine.c',
 ))
 
 common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
-- 
2.53.0


