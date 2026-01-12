Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BC9CF45D9
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmu-000520-Vw; Mon, 12 Jan 2026 17:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmO-0004Ie-Oe
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:57 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmM-0003R3-UE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:56 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso4379902f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258373; x=1768863173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rdVLZxVjYF88V5kiH+uJe9J4w9b8W2Bh6K03hg4BsyY=;
 b=yWgNIBA/mDkq3eajqjLlDp4+c6hBZ1poaTxPf8x0S2hsgb6dkgkfqHFIErPXATS/o8
 aN/H7XW3ZRZmxhSF/ibcatQHMWcFYsBocTUmilYU8vU3G9Z3hYc3O8jZo2vLSmHnoMdf
 K80S9F3WlqWSyQEBksjGod6jc0UWnx/WoXjh1h8Rik//rJzs5hWrTzHUsp1OC6RuDnoG
 Vjfruat0YvI4r9z95wwPb77nUP6oO2CuGLfNcIh1kQT3LtX5LyfvlcFTbjmd+BR+3UXI
 1WgTowTP1UWF0Asmb5/HhoQKMhYDshJKKzjf8CYo4VdNHDKoHAJVFQXzm2ApGiNs+iPe
 serA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258373; x=1768863173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rdVLZxVjYF88V5kiH+uJe9J4w9b8W2Bh6K03hg4BsyY=;
 b=rJw/WMGcHgU6Xdtz6pDklAhsuUjpxrUIuui4jaYM1+PZnUp2c3L8/Qx/99y1QLuYNJ
 SCENDNoG1mrwJOMaI8bbw8KZ4sYEFErgAkja0Ry1i21lME65q/Pdv1ksI7iN7ZLWqD4n
 h7xIpQg1NEGy12Hrtfs8tmVysPl2lT08mVp4YHajSXQTUT0+Foy0ky32p1DCespuBki3
 WzpOJF+gCf3mPaCBHTV5spV0gbc2agm8bwj+zmNomI0WeaR4riVZoTI+xYDLZheAOIYC
 Pr0OaEPmkn7my+pcOxQYs5W4Sw18QFesXg5pOT6MXJNtdo50hlScCJ/qVw76pepznWZa
 5y+g==
X-Gm-Message-State: AOJu0Yy3HCnVexGJMDG3tzU2bsUDpvGcvoxXldGs4v2c6t9XwbP/KFdF
 LCFxOQXiXsdyDoCFT+mxcPCS5AA9Gsccdu+RajC+AqgqpOZ9lJ6lVsXrrV5g52x+R1SccASBx/O
 JFVM3pWQ=
X-Gm-Gg: AY/fxX4OxlbSXhPq607uArHFceqm/g99iy8S11WyAu1eTi9Ql080Q5yfEytuJFEM0Qm
 iaQcJLDkmMWOpGiNTS5LlHPrFC55smrcDpV3a0gkH7o/c3mJLyflEZfexL7bVbSWx0W1Cq2f0x4
 l8Mbt29lkPMjkVKJofIl13gs9VwEiTca/wF5/HZNfhZTph95YOedowRRTas/a17Jn9S6R0KAbxJ
 Eii/XiGAzcR0j3BcMFvTiZSxMEuwiRiTo9V0RJ8q9JulR5SnzGavl91t0uHXwCjKVVi+cGgNnx2
 toqVb2jzZVuMswtkfuG14LCMb4lbmnr4oXv3Zmeyx4rB56h6ygaOBmyWmmXuB7OnRUkJqT8KG9G
 csRF9u5yMgMkorR5b3jl62SKGlHhZmXEPuZDwrtE2EH9gb3XqSsMnzwfUB1ACSRblzogQdO8L0M
 N6AZ9nkR7LYvRsNJ0oE0ZDPEwJhmH4uD9HyZPlAt3/GfZUEm71bExBCTNM1czI
X-Google-Smtp-Source: AGHT+IEt14fKURBv9OtPQro/dz8DxA0lEVnP17wPvRShXxQPvEN0dbCZMZ0x837MBRGJXu7iaJwKrA==
X-Received: by 2002:a05:6000:1819:b0:431:9b2:61c1 with SMTP id
 ffacd0b85a97d-432c3629b3fmr16737050f8f.6.1768258373137; 
 Mon, 12 Jan 2026 14:52:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm40391534f8f.16.2026.01.12.14.52.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/61] target/microblaze: Avoid target-specific migration
 headers in machine.c
Date: Mon, 12 Jan 2026 23:48:29 +0100
Message-ID: <20260112224857.42068-35-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header requiered:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-4-philmd@linaro.org>
---
 target/microblaze/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index 48efa546d39..f930ff86091 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 
 static const VMStateField vmstate_mmu_fields[] = {
-- 
2.52.0


