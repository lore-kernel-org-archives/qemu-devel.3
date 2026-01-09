Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DAD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56n-0004Yv-HR; Fri, 09 Jan 2026 00:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56l-0004TL-SM
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:23 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56k-0003jV-C9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:23 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-34c3259da34so2530197a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936741; x=1768541541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM1OSwmbskx8FpsKvVfPsELTkyQFwRb0pY9suz60zd8=;
 b=f5EnQ/pie/XBjyzkMZM1eqUF0xtnqQMAMJalc96LhqDM44M7HivOYFnUH4lD/YMYJt
 rUJGEIvERR0bp/twbPae6kAAVa6mWslzQ2K8lcf8p4Ydz4ua7tZ/2KViK8fN8eOJfoJj
 /injQy/DiNfPh9zwL7ZYuP/qH//10XegMgGzJSamUpz6+TnY+aqBQdiM2dXFQr77eEc6
 5FeiyGkzotyTWi2sWAip+VIPY5lDpkc/8R8VZPoY7EIIxHk2+7Jfombjcxx7wQkhqOH9
 1AVtG4CTsUqlL6bhzoUd91qugCSHXso3wxopcP4dJPtEQBb9nzbovo4cKqAGg0jLB26l
 z6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936741; x=1768541541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gM1OSwmbskx8FpsKvVfPsELTkyQFwRb0pY9suz60zd8=;
 b=FojeuG5nDB1FpCQQz6fOxyUyH+7GLxUtO0vzSyyuRvFz7djFsWfIHg9SFeV3J8Q/ZD
 HFWiO2a8WuFQE8a9uVVStRZAr/bEZlBSHVcl7yOmZbELbZAId+6bpVMxg/q26/v+pd4u
 mzXCwWuy9EwNpkEdhYrPNx+L78+SLFr+5aKV9MGqrTlQKcaMbnAD4K4we0f7t6QNlQDT
 Z9yxKLX3qhk58dJoWzA0oPTK7LbX7FMzHWHlpucDq16o40Pn18F1HW0Ni2i/JgZQckGx
 pkYAFOGR/NZQ0qRpyiGykA/hKgtEU9sevAKHL/bZpdqMOypcDfcPaa87TIbcBPM2RZ6N
 302g==
X-Gm-Message-State: AOJu0YyIZoAQqBFaP0Crj2dmHF+AScLVdeamhvoCRcgIbEqQ2mB4TpDv
 b4BNzGE+3nQSpPJsZV/mqOPgRYvhxkfm/zV0aKeWuVfzdqxqtRzX988WnjJ8VdfLemIVwwS+i3f
 CdiemCFQ=
X-Gm-Gg: AY/fxX63qUB7uI2dqdGoFvL8/hMVL1OrxE36VJAjBC/sJnRhHr5CDjhBuQF6k60lfrZ
 UU+gr5lSJrd1dX/TFZ5a+6u3O0XEmCFJGyOErWad7M+a494/nyM2p0lxBs7Rpwvi5AqnNFxHTCF
 vI43EflSqjkZlhyo/OuslidhljmnINQogM33jJ9f07TmWjlCaiLYBHRDjEirefvI7RQUTVFQGxV
 UOp67WEOy07wvQ5dJLZBY5cE62XzuinxOG1GS5zG+2CCUl0R3o+j94/MkfzK/ZTJFhrEumqhzFq
 CjL4W+BCYoF3GwVrlXKbK4iwyve1+VPhyU3ufpP0hysmyTJtlP5jTY8EcIOVcpy2YsL/NSHBffx
 5xtUxUyI6mMVKUMDbwu/D8cceb+xtvBYmvkV3h8uXeebETqzoi8PjzIAQO0Wmwlz3FcjiX9QSKT
 Q9qBlJQief95ij0PGcxK2szZVyBySD4J3r7+UFZvDtAqrhMrueXPgmQmw6+ZXs8YFa
X-Google-Smtp-Source: AGHT+IElig69ReiGa40Ktao8vPJJtrZFGK/NVaVb7rLwmfEM/y28s6ZOl+X6mflXm6/pCb/bd7l0Eg==
X-Received: by 2002:a17:90b:57c4:b0:34c:a211:e52a with SMTP id
 98e67ed59e1d1-34f68cae46emr8219312a91.27.1767936740765; 
 Thu, 08 Jan 2026 21:32:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 18/29] target/arm/tcg/translate-neon.c: make compilation unit
 common
Date: Thu,  8 Jan 2026 21:31:47 -0800
Message-ID: <20260109053158.2800705-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1042.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-neon.c | 2 ++
 target/arm/tcg/meson.build      | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index e3c7d9217ba..50448198c89 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -21,6 +21,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index c0c31a88ba5..23986de320b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-  'translate-neon.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -62,6 +61,9 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+  decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
+  decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
+  decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
   files(
   'cpregs-at.c',
   'hflags.c',
@@ -69,6 +71,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
@@ -77,6 +80,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
-- 
2.47.3


