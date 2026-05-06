Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BDCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclO-0007k6-La; Wed, 06 May 2026 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclM-0007ZX-Dx
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclK-0008O7-Mk
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso36235715e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075884; x=1778680684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rU3TesF61QskIMqznS2UEFkxHazsx8us4woLWPiBNh4=;
 b=cTbk3W/6lDqiWJbhzmcO2EaX7xjyosfV0nYcwNhFDCNIzQ4vfWrw7CGGgB/er+f73U
 Sx/19UP813lZd7Yetj5C8Nn3e96GaL6L0JeiHpcLAqdHkOyb9M4WwpZSUMski7V5XQgO
 I7RgT/Y4alY2IOidGp9yqeoJI6Jb0BsyOTWzxWI4oD5mypdMshK/CokVJ1k5F6HpmUCn
 7FlRqAmL+oi9RkJC/GDnYqFzo12aP+w+/J/3DUK+0PEwTJIsIrSEhTb62iQ4/3u1cfwl
 hf2v7UaXvKmIUCUqVpGGyCplbay55azMm8ryirp74te3tbNd56aZJYA1CyMGt4nbFJJg
 I2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075884; x=1778680684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rU3TesF61QskIMqznS2UEFkxHazsx8us4woLWPiBNh4=;
 b=A5DchQFqP6LPj2nDwAM313pn0o8FqHB03aCUbFFM/iN7dZQtQ8oEeyI0xXMQsa5Fdm
 ccLBOtKiWpdlnSWRvAtBd8/onQcEXpITwJfdvLPX6zv3C7bBWvgis4nh/OVR1Q+upHuy
 aEB7Od88rSBaI5aJw2FUuirQ4y7TpMTuad0rlrO48OH/xUrJ2WnOcjwUzLFJA+PheVer
 /PEqf+JIAkF9e1ExEyMqrYr0n+sKuW9ReKd9/N8no9xkRi8PGaykys5+jsw5zVOMazHf
 GsqqLQ58qfJapmGVa0SolWaIQ8ITcIKKJi/3qm5s2N2g895ifrASI6Z1/1yP9htAAZkN
 MvPw==
X-Gm-Message-State: AOJu0Yy4Qf4I+n/E0IC5Xj8+PtTKXTNr4Kq28E2IU6/qbY8v6ih/83pD
 gTaz7doRwCxgtuo4eN8RGhiOiMz6vBB+8eh2seUSjmMO6OVw5MQaqMgLJVz43rL4Tq5CL1EZNSB
 ZDnxMwYg=
X-Gm-Gg: AeBDiesg83HC5Vw6aZ0uqM1ujsLEPV/8vq1tpgPqUzvsABXb+FX1GC4OZ+JjGMdfJ8N
 J5MSMknEZ+p3e1h+xjZr/irURmhCgL5l7JcT8WMAZzl+hfng3VLsMvt8lMMj5wFV8Ea9mDZJDJE
 ix8ucJhlxPA7a0MxeyFkcdFVVbjoD6wIs6KfKDZXOLNoDBF2f8POgksEvbuvHva+4P5L9bcTZiE
 eFtUUqAPZN3m3wFVA8j227uwWqCH5bE58skMvy7vBaupXHpKKRGpJRsnTJlzm9kQ8pJsKlF4j7W
 k+vqowbRueZpCw5R+6kBE60zAQQF2e2JvcVRL8M6gMj3kZ5skWl7aVug5rDyQltlWsEUtPzHadK
 k+sxUWxgwyuTedMibu2dIatqwYrxvqAkS+RCmx9MRNvBWLzB2QGqNTrfqSbpURFzBCSp2NKOhkl
 IT2b7w5igKMDtk4L2RcWi4tBgL+ybbtLutkgXdyf/UlhR1H/RCwhi09YSDimbkDtTCAJG3z2QA4
 hNCDpWfxho=
X-Received: by 2002:a05:600c:c4a3:b0:48a:563c:c8d6 with SMTP id
 5b1f17b1804b1-48e51f24391mr59556075e9.7.1778075884102; 
 Wed, 06 May 2026 06:58:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm13573103f8f.25.2026.05.06.06.58.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 021/110] target/sparc/monitor: Dump all registers as 32-bit
Date: Wed,  6 May 2026 15:53:53 +0200
Message-ID: <20260506135524.20617-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All these SPARC64 registers are 32-bit since their introduction
in commit 3475187dd81 ("sparc64 merge"), see target/sparc/cpu.h:

  511 #if defined(TARGET_SPARC64)
  ...
  515     uint32_t asi;
  516     uint32_t pstate;
  ...
  519     uint32_t cansave, canrestore, otherwin, wstate, cleanwin;

Set MonitorDef::type to MD_I32 to dump them as 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260320091019.59902-2-philmd@linaro.org>
---
 target/sparc/monitor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index a60671a60a4..e9300ded4ad 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
 const MonitorDef monitor_defs[] = {
 #ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
+    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
+    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
+    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
+    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
+    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
+    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.53.0


