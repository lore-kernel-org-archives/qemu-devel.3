Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE87FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcq5-0007bd-FX; Wed, 06 May 2026 10:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoe-0006VQ-VS
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcod-0000oF-Cm
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso36263065e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076088; x=1778680888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FHDbajhituef8JDq8mnAuwhyeEDKI5Fzp0m93s4KOg8=;
 b=sChIyPzCqdfal/ux5P73obcet1rPAY9WygrMzpKjHLFFomxiJxUaoOmBS2VSatx3iB
 YfWSO5MpMZ2x2j26CLDzosQoSGtk60HmYApTQhIFurZcLCQBXU1QER3fKU6VZsjX5UmX
 tfYbz2sihXO6Gt5yLdLtwnEsM7x/g5L0slAWimcvc+e3QVVrDCkrbkuk6BZPjJdXwEC8
 GabWT5iHTPKJXM2kDadvLPrHJx3WoZXuHARvUghTm7dc/a9Lp+NbOQmXJJzZfbFBpphu
 DssqAv4R14A4VjsGrut+aaSGoRp7aw1plFX/JykKiM7ujhdrhlJNElpklqpIAgVGkskf
 RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076088; x=1778680888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FHDbajhituef8JDq8mnAuwhyeEDKI5Fzp0m93s4KOg8=;
 b=iR7y4pLbSbziOHXLTNivaM5xxj+YfR8K1apzM2GYcIbTTa0EYbc4ac1MQWfTCV/9BR
 BXg3CWiTbtuTcSyEpj0eco1RLx+w0bm4sCGBYZqmFq3cJKAmqVQ9Wk2h5qG+PZUKHUEU
 uYSzJe6IcckXbYJc0DddaB98j0HBNJyMc8twsnjiHtxZVX0khLixx3aR9xA/M5tIhHAD
 a6nehtsc8pjtcVFyKq+kLN8bv+B3C3iZqRdIFCxscpPZQi9WKAx6T/K4Cuv/F5MAbuiD
 6l3F/Z5M6uqHovop8bnwqDQ3QJWO+3Fe/T+MiuOhoDMdSNyIfkHTXmfEpj5ZLE+KpX+X
 t+qw==
X-Gm-Message-State: AOJu0YwkpcMq98X5DI+cWmtwl0P2MqisosFNym/wVvXUe58JphbgcG1k
 MAZ9kae3PbheRVRwwW7lD+Yy+UUsSnao9fWJjzrlBaiAKBvHIroBMaOiJd0pC3aKwv9ctZJ8Pnm
 ckJMoi+Q=
X-Gm-Gg: AeBDies53WaJ3Li26kQ/1xRLaJXEbQT67p0lV+U8Jk868kYYrdtw0zHQ0RceiR/sPQ0
 Nj0kY2i/7YBbgL8LsWuo6IFfC3PwH27JZ6sM08v7N7a88Ktova0Oh3F97pPRqCzNHtPY1ErORwO
 XEJty/0MvXEQtmUdrkk7rg7/v2q8HLM+vKNs91LPX/W7e+XEcSLIVP3qDYGwXTtXmWd02SiLtyi
 SfTdsAJd/dSQXRH2fhfF3KRv51Bz6Gg+18NrnYV0yAfFE6DSHmegBDlyzj36+Q31DMRo8ajpTN0
 4+oBQMEUvVGmHNvYpwmv+wtLeTS7SylHPF0ZzYpjBFzHE4cWS9N3jrtKEpOMDW3uahBMWDQ7xX5
 Bt8tZZ/HnsWvcXlDCOVfLCeLO4cn1n+Rr4c4hm3iq6IxG4Nr/vD139g0YVuDggMcA30HjhVN8Pw
 /ow3QMIn8kwnUisHB+I+hevD7Epv0f7xX8DQGRZRH4MKBQGWH43K/VGyjNu8mddZqqA4/GkMAL/
 ir14vSvLjs=
X-Received: by 2002:a05:600c:4448:b0:48e:526e:1040 with SMTP id
 5b1f17b1804b1-48e526e1226mr56998455e9.23.1778076087895; 
 Wed, 06 May 2026 07:01:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm46938855e9.11.2026.05.06.07.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 047/110] monitor: Introduce HMPCommand::arch_bitmask field
Date: Wed,  6 May 2026 15:54:19 +0200
Message-ID: <20260506135524.20617-48-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Add the @arch_bitmask field to the HMPCommand structure,
allowing to restrict a command to a set of target
architectures (represented by the QEMU_ARCH_* enum constants).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-12-philmd@linaro.org>
---
 monitor/monitor-internal.h | 11 ++++++++++-
 monitor/hmp-target.c       |  1 +
 monitor/hmp.c              |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 80b4a8150bf..eaf9a607783 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -82,7 +82,6 @@ typedef struct HMPCommand {
      * the formatted text.
      */
     HumanReadableText *(*cmd_info_hrt)(Error **errp);
-    bool coroutine;
     /*
      * @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -90,6 +89,16 @@ typedef struct HMPCommand {
      */
     struct HMPCommand *sub_table;
     void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
+
+    /* Keep non-pointer data at the end to minimize holes. */
+
+    /**
+     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+     *     Allow to restrict the command for a particular set of
+     *     target architectures.
+     */
+    uint32_t arch_bitmask;
+    bool coroutine;
 } HMPCommand;
 
 struct Monitor {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index da7dd7f31f2..f6dce326cf5 100644
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
index 0e5913fabb1..e881c26c305 100644
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


