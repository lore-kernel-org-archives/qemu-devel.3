Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1D6C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOG-0004A5-Sj; Tue, 25 Mar 2025 00:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO2-0003sG-2d
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO0-0005tR-3P
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:37 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso8328515a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878773; x=1743483573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Id5pPosDfyEQ/m8+tZSrdDNfNTCKXAcrGpGPGvWGZxY=;
 b=TSeIP6c3ghjxERHzQYkUL0ghewjcjRX5eCZYfJMPx5E5PuWK7LEM2kZg+NJMIbrUbX
 GD7KRu/EXPK0qnzK51rLwQfltU7Estv9sFFxCW0aX+KpDQtr2DLQxTan3xO1R25Kifkv
 qHDHz8G/t8qMBAfXSUzrtv8a1M/fDZ/l1V9FDKvfbaSik1QZyWLA7dtEOIZTD0wVUfw7
 XyG/gf6qzEiF1LO8zKJL3A7hKS+Oy7T5SIp2o/ExQiNXrXssJ68tz9/blPQZSKYR9+Gy
 DHKPgV9HSaW8tpVVDlI3onHCpLEUwm4T0g24ZGCqRPMo7AmN47dR8BjOYXLxjKUTQhZ8
 RQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878773; x=1743483573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Id5pPosDfyEQ/m8+tZSrdDNfNTCKXAcrGpGPGvWGZxY=;
 b=PDCX7SruUakh/nvMujfbhSJGm0ttwImPyWvm8u/1h7FUojQDmKSwhs5xmquDGnGB9Q
 ZIaleKhX8U1yiMrnmJPeC6kMp2VZaJjzN7Gw2z3XYXLZeoSZgxHOV/RgO0x77uOkdEHf
 d1yBc3qpIFu6xzyAG4/NY0o2+/6XiG0UKvXs+E6EzsVQVcltttQk6M9hycOEQiQazC8Y
 NRXPMmrX2JqT8PgI5DQqg8IBPrwBwDJmqOJeeEFCBdj17UqhG6lzXRvFSKWzuRn1BA95
 zfMcFPJDsWVnp6H4bN5ZFB5CuYoV4l9KR9SP/ceRBPjacUyatuvwDk9tsezR+teGm/ZY
 IhUQ==
X-Gm-Message-State: AOJu0YyqGtum7F2hy10+Mn/G8JGZZPwYVeaOt7FJZfoDpDkFUyMrTG1h
 i/s2sdKt80s65v/ENhLxPY/9CQyDEDEWfoPoB6H7EtGDPjxCcyN+h4cvqhLTUXzzbetvc3QMkEZ
 T
X-Gm-Gg: ASbGncvl3UrT/OqZ2piJJ6AZkqsDvOxiql38XdMXkfiEJs1VVSzpCMnT+5aI2u4om8N
 7aDcNsmKipL3M9SO6x9YOscgaWOdRSnULQife1f4+P0MfrnjolTHop2RWfqdFbRn12nnWd74gO8
 pxJ7xtidSrxqf2ER2Aue1peP1y4ddzFCYv1By1pXEu0oX62WGkqmZadBc/aQKKuDVNBZ7Hrk8wC
 fzPhZg93SzWsqWdQiOCput1K6Y6BtujjZos5rTjgK9wDFOKAjs/e8Fwz5kupQab8Q2UqT4RxBRz
 Us06CjeceefnkicKCftnrINB/c5Qw3/uiIyycXbbuRgD
X-Google-Smtp-Source: AGHT+IE3ojZ3dw6zf0DQN1QqM31clL7OO0QTiS/Hm2mkhOEWn1LSr74m3PtPxOJna5YJtYoKHucVJA==
X-Received: by 2002:a17:90b:1b46:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-3030fe7f1a6mr19332641a91.13.1742878773114; 
 Mon, 24 Mar 2025 21:59:33 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/29] accel/tcg: fix missing includes for
 TARGET_HAS_PRECISE_SMC
Date: Mon, 24 Mar 2025 21:58:57 -0700
Message-Id: <20250325045915.994760-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Note: this was caught by a test regression for s390x-softmmu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 1 +
 accel/tcg/tb-maint.c  | 1 +
 accel/tcg/user-exec.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ec02b40e84..f267da60838 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,6 +38,7 @@
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
+#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d5899ad0475..efe90d2d695 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
+#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
 #include "exec/exec-all.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 667c5e03543..9d82d22bf40 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "cpu.h"
 #include "exec/vaddr.h"
 #include "exec/exec-all.h"
 #include "exec/tlb-flags.h"
-- 
2.39.5


