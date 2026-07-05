Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18992C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdu-0008QJ-O5; Sun, 05 Jul 2026 00:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcO-00058R-BI
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc4-0004KT-M0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so21323615ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226271; x=1783831071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzGgogh2drGaxG2qqYgsAosa8MuuctrHRN1e6nlJ7Xc=;
 b=uKjt+Dx4aCL0WzWIrbnUuopi0G6s7rc4FHZwBVAhpEBQrD65nvoNIJbPzEeiLJZo6O
 WQWSNsTOhcqGkv46uAgqlKBsN2Inn9YFha0WlnfCslc8stgjn021MDP9cvsAIzb8qxOS
 76l7YLT0iXVMfrMciIirBoIYX23BnCzu28LcUROWMAIYK5bIKayN0fpHJTlxjQ01KUXx
 DOFm2yJVx6V39mc4yLzlcxzRgx+LuiT1pHXZiNn+5c1Vjbl7g/q2uX/iMNAFoM80BB9l
 Z2Tl+cXyMCw/O9lmU5raD7u8zqtmC5ARDz1EtezWuPQMLEYeGbQRmFdnW9frh/x/iVLQ
 jXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226271; x=1783831071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzGgogh2drGaxG2qqYgsAosa8MuuctrHRN1e6nlJ7Xc=;
 b=AmQjhWL5SA5vTOWzqW6KE6YiSEVdUWkbGW70wANsCpzTsFJWLUZOa7f1nZKYO2/0fQ
 zC91qt1/SYbGrDs/7cU9QWCO+BZy4Oi4jOHpMSRsGvZyGE4JJtsYVRAS2Av7hbdEfCRn
 u92pXya1GDXskdvvbkmZD0u0FgGouj0p0zlMipYUZ/wYOgHdw/qMLNMpGMToiI7y07bq
 C60MuQ/idXVvUXdZ+G4n2EsDS4aTattJHNRBlwXuCcz5nkpIszG4ayE92tfXVGksv1qx
 JidADTsWc/samuebGR8oW4Lpt9EmDSd4vyF3mJsUPFsopsP0CyKcqoP4zRhrBpcgnAt1
 +WqA==
X-Gm-Message-State: AOJu0YwHhozi/Rk8hAjeGaaQRMNvEtNHT5XtBDtIylhZCham3GampQl4
 hvIBRGmH9H/HE+4jhoj1Cv+8LAopfZ7iU5D9XTeLOkswqQEZUwm6THsk0wh0OIr6+HN63z7BsjI
 FpiND
X-Gm-Gg: AfdE7ckZrOAblHpBwftTEbfHgiTfMuBrI+7Oy88cmc/TjjFRut5kjDzPKqEnnlL4G+f
 M3CLl9+6TE1JQ7uMr/M+U9dbgQPW28Fl9e588kLgGXTRxQ+s8EsgtS+iVXQi3pk3gyN2gVsxpda
 Ovrn/EIFnDrAAeD5I3x7Eyb69JUlcw9Bd7i+w0oJilRiCkJ2KN2E8NYcx33hceBQePQTXYY+lfg
 lPKgtFk1s5vL03mfz7vLGk2CHikYyKrpYnP8n3l+oZIwaIfEDi1vDEzdl0Vb6cmQjybxNIkxVfA
 Tl7cnscZ0vubjXdcFtXYHG760kipJVDPxw6zCJC6U7sRnnVzWvasJ9/bYbqu8GeFRVK2f4MMh1z
 h1dOLgLPpF/wtyzkS9KfZaz6rbI5B8xZXfNhpuKN7rSPEdVI/WYr0d/+TexNchHIWhpKEEaPJ0V
 ATty5QChCuhIDZc63fedepBIu7S68gssWQfoNtWkPHmhjObQ8=
X-Received: by 2002:a17:902:da2d:b0:2c9:97a8:afe8 with SMTP id
 d9443c01a7336-2cbb9eef2e6mr53420945ad.43.1783226270860; 
 Sat, 04 Jul 2026 21:37:50 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 28/46] exec/breakpoint: Add CPUWatchpoint.hitlast
Date: Sat,  4 Jul 2026 21:37:07 -0700
Message-ID: <20260705043725.1373137-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Allow the debug_check_watchpoint callback to see the
entire range that triggered the query.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 1 +
 accel/tcg/watchpoint.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 254762c9b2..175d0cc670 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -36,6 +36,7 @@ struct CPUBreakpoint {
 struct CPUWatchpoint {
     IntervalTreeNode itree;
     vaddr hitaddr;
+    vaddr hitlast;
     MemTxAttrs hitattrs;
     BreakpointFlags flags;
     unsigned id;
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index a7ce5fa9dd..edd1d5708b 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -89,6 +89,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 wp->flags |= flags << BP_HIT_SHIFT;
                 wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitlast = MIN(last, wp->itree.last);
                 wp->hitattrs = attrs;
 
                 found_wp = wp;
@@ -109,6 +110,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 wp->flags |= flags << BP_HIT_SHIFT;
                 wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitlast = MIN(last, wp->itree.last);
                 wp->hitattrs = attrs;
 
                 if (tcg_ops->debug_check_watchpoint
-- 
2.43.0


