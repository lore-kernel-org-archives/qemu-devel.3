Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA3BF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxE-0005Am-Bx; Fri, 10 Apr 2026 15:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxC-0004vf-93
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxA-0002yo-9s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso1560328f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850942; x=1776455742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRKFl/rXH5Np5OO3Lz1ftI+bdnLkrX94FQ8eyhGxyK0=;
 b=RRTetaQoSo96KlAZyHq2RnfnsStzQJQ9LbwGgRm3lZkKxuGNpyCo/rODV9CDc8U4IP
 yEx02aAdPElSZQ4Sbl7od3KKqJlv8X1vMvkKYck2LxJsQkDfRwUh+90fi7ooOziyLh8h
 VtRXo2ERx9DJ5WKAVKCTOiT/42FBeN8wZEg3Ghk+qCJdTxVO69zNqeHspgKj5DSgWzc7
 s+r8hDJUT36npVL51ac9xwOKcL2VjIFhSSP9YCVvs6+HMjR38l5DlifIwUtx8MSeQtjG
 nt7JoPkKdDBW/oH1iioVh2m3VZoDASZIXhZNdygXQfVc83gcsbOBjyeFvDAC9jgIstqx
 iZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850942; x=1776455742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KRKFl/rXH5Np5OO3Lz1ftI+bdnLkrX94FQ8eyhGxyK0=;
 b=CaYo9DX627U9WPYLBS1L1YJg+ZWrByRD5wuQIV8oxqKFzvOJHkdqG4s+MTcIUPZkbV
 0jyUe4m9LWLHKDAYxslfiK5TBtWw4zqVSjn57Qm52asRSBU0uLHgemFTiDv1II2rUDKa
 4tyjOZJcH8Gf2RIvESMVNOhIUV28D2sLrrjsC6M4rJMWHSp583f6NkIYRimUtxleSp1f
 rZLSHdGsH0qFWzMjj7lUfD3yyDTp1p+C4DWGKwkN4v9cWhnVr3h4qP1Osya3bdT+pu+F
 cqa6s9XkuApr4dtEvVyqmPgGHFy6QICFfF5vp+fvadxvhf5ogXNNOkeOl/kv2P0dWkhQ
 xVvw==
X-Gm-Message-State: AOJu0YyG2UeSDtcEvN6w5r2EZhsCI7fJ/MQvYEFt9XhSeKT73UFM1xs6
 i7geWeN8s4xzfVhVhKXfwsn87aCEtN8VPwDy6Rwr80euE//MIT486j7++AA6xJi7lKC529WyO8W
 yGMj3PkI=
X-Gm-Gg: AeBDiesa32FOuP4rugxYsImD9a+uVkbNCZgrwvri5zXPE1l1yEkP99S7KSYI4/GIeWG
 BbIcuL10Qn09NeLicb9QtpsRJ8P7O1ghr92/l02DFGOC5+Sy/az0t/p1qn28bjGdQUs7Wqe3P++
 YF6cL5HK0QAH5PCjCI0o2NlkhWnq75R+ocfvozfAgqW3fUgP/qqmkXdx6/ALysw+yJ5YaLKRuGd
 Iz4x3OSpW/ZFMNTGBclzgjyax80A8KbxCiIlWOCWxYnRtb+ngpsTuqqlAuGutapab4qPwIQAKuv
 UtCiBo6jvU8mzJKsf99xHt14rprxpT2dU5np6TrA0p2hLLMQQ7fOraxhsNtUXPN8OFhTeocC+2R
 vsjnDhgZbFTxXorxehifKk5CRMA5slD9X0erqUZf/Y3EquuspTo7sPuiApyGFBxvfCmjCby493p
 VQbRdv6L1pCGEEyDmQVoBYXxS6YCRykBEBbXBB7JH9E1isO2pwar6dEfUiL6ePwD1hPQSAohGg
X-Received: by 2002:a05:6000:26cf:b0:43b:4212:2ee8 with SMTP id
 ffacd0b85a97d-43d642b9daamr6511764f8f.24.1775850942417; 
 Fri, 10 Apr 2026 12:55:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63ab84cdsm9885795f8f.0.2026.04.10.12.55.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/27] monitor: Introduce HMPCommand::arch_bitmask field
Date: Fri, 10 Apr 2026 21:53:13 +0200
Message-ID: <20260410195323.17937-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Add the @arch_bitmask field to the HMPCommand structure,
allowing to restrict a command to a set of target
architectures (represented by the QEMU_ARCH_* enum constants).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/monitor-internal.h | 6 ++++++
 monitor/hmp-target.c       | 1 +
 monitor/hmp.c              | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3ecd394ecf6..78281928e7a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -74,6 +74,12 @@ typedef struct HMPCommand {
     const char *params;
     const char *help;
     const char *flags; /* p=preconfig */
+    /**
+     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+     *     Allow to restrict the command for a particular set of
+     *     target architectures.
+     */
+    uint32_t arch_bitmask;
     void (*cmd)(Monitor *mon, const QDict *qdict);
     /*
      * If implementing a command that takes no arguments and simply
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index d07e545ef7e..9d8dcb8835a 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3b9e180c1ca..c1e99c462b8 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -36,6 +36,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "exec/gdbstub.h"
@@ -219,6 +220,9 @@ static bool cmd_can_preconfig(const HMPCommand *cmd)
 
 static bool cmd_available(const HMPCommand *cmd)
 {
+    if (cmd->arch_bitmask && !qemu_arch_available(cmd->arch_bitmask)) {
+        return false;
+    }
     return phase_check(PHASE_MACHINE_READY) || cmd_can_preconfig(cmd);
 }
 
-- 
2.53.0


