Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEE5FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKck0-0001hD-UR; Wed, 06 May 2026 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjv-0001S4-Ba
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjt-00081F-8F
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3960895f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075795; x=1778680595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ig64yb1+2KzdGiecHfvEaVLt05RY0JwdBl1I/EEybCU=;
 b=soadrskdmsOmF/AFxdQQdFMw6wf8+hiPa1smO/rqord0cRvg2ju/1lzQIM91rSx1/8
 b5nDWqjDQPforQfSr9bUGZZF9cArvsECcQL/fu+kDMrQ/m0LTijLFY95QmPtXL4Ji1Z4
 h+5EgZt2U2Rqg+Pj292iY51lTidgATa7ZDuMVprn+kzYRCtA7YBnu5J4xa6bDq7KdZS2
 1muFSd82gRQWaTu+QCl3bFDnP3LPJ/Rb3Jkv+pSwjeHaEfRhDKbHRX540JB4D25ISrxS
 x78NSu8iJd0oa6k1sfyYXOXh74EI/cncEUd0+SK5eapzO8ysTQq2NdiTVSp+FUXR+XKj
 PNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075795; x=1778680595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ig64yb1+2KzdGiecHfvEaVLt05RY0JwdBl1I/EEybCU=;
 b=D5a6/wCzqugKUIpsEnpVc8x42xDA8D81+7bvFrPlG9VYirtWyt5+8C1zxSueK+pVMo
 x7xV6Li5OLbAExcg8Mc3ub+D7sN9UmhwEk4r6z/2WyFjZHKOdB850LwQGxSw9HWhUnSn
 FVuXclS3LQg/nIqWh01eZv01ruN+mkjB+w2nKkgrnCiBqm/h6rJwSuTVSDTwwGD2/s7n
 vh5mcBxRtpbVJY9dBfhR7zKycyuqaMiYIaizrP7SBq7c1hoLdinQtDtp5Lqiq5W/3Aq3
 rdeugslnqxuWH+Vo/Vw9CJ6DMHzdcNPV3T4gD7vqPwOzAx1Egt4elboAcJ/4HT/v94EZ
 KI6A==
X-Gm-Message-State: AOJu0YzGvhPlW4557NxEu+31Hmq0W6uKvBjaB3EVu/TfrkvjdGTD7XQB
 5fT+tswlVwsYw+UraMY26WodJkI+3zQF5CVsiCdisDepQSyX72XDZPPh7Wql3PX7Ee9kz3XhrX2
 rjitY+Ko=
X-Gm-Gg: AeBDiesUBbbh4kwVayn381efWQKiIJBPGHphrCwU8+mFNBkP0dxLevaRkX0ANeipRw7
 JPKkUfg9BW3YA1vnxi/ANaACXSUxgi28uDV0rSLsyVwgAwr6qpiamkEeohYGf9cDQqug1Ix0cUi
 UyCfE0yygaICtU5icHQFidu6wK9JVqqrQ0h/cpWLQIK/4oMKGwkj879sxfQyUgXbbMfey6+A7/Z
 Wg8bBMMpu2VKIskTimzro2EOhhQ52coOlffFS9096gR9pJFnf6eglXh+mWbAV0fOlQdTZy249ep
 NFPjgCuGusZ1GHyep/p5/Cq57EjsJXLrVMSv4UX6uvhRmDBWW7Hrj+V+9SXn8Xuuws1DGdkgdvF
 56bqmHi+CoOcUxNvsYeaIMtjMcPjghlg1FSCt8E0VrPyCZqq2jTRR+LdP47ed6+DnyzYz0kAEHW
 LdP18BiLnGn1o11UBTHlp/OODuZLhtBZTKpf7Nvwgn91gUSg747EpAZaj/ewYuZ5crEccL8c1FD
 aqQwM5xCfg=
X-Received: by 2002:a05:6000:40c7:b0:450:e369:2dd1 with SMTP id
 ffacd0b85a97d-4515b05701fmr6177806f8f.2.1778075794516; 
 Wed, 06 May 2026 06:56:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505285e765sm12281704f8f.10.2026.05.06.06.56.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 009/110] target/ppc: Include missing 'exec/target_long.h' header
Date: Wed,  6 May 2026 15:53:41 +0200
Message-ID: <20260506135524.20617-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  target/ppc/cpu.h:1281:5: error: unknown type name 'target_ulong'
   1281 |     target_ulong gpr[32];  /* general purpose registers */
        |     ^
  hw/ppc/spapr_ovec.h:76:44: error: unknown type name 'target_ulong'
         76 | SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
            |                                            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-13-philmd@linaro.org>
---
 include/hw/ppc/spapr_ovec.h | 2 +-
 target/ppc/cpu.h            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index c3e8b98e7e2..8d67f492d02 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -37,7 +37,7 @@
 #ifndef SPAPR_OVEC_H
 #define SPAPR_OVEC_H
 
-#include "cpu.h"
+#include "exec/target_long.h"
 
 typedef struct SpaprOptionVector SpaprOptionVector;
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d637a50798f..a0df7a467ed 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -25,6 +25,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "cpu-qom.h"
 #include "qom/object.h"
 #include "hw/core/registerfields.h"
-- 
2.53.0


