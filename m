Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F690FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0a-0000ZD-Fv; Mon, 27 Apr 2026 04:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0Z-0000Y6-1h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0X-0001FW-Ez
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483487335c2so96617065e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277276; x=1777882076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CUaWTZovjDgyCAn2d0HALI7PgHwWvhiaIIr4lldEoLI=;
 b=OlmxYBXKMNX/s24tGU0hfp1ldWYvmQZ8ErQzKn7N9IqelE/JxqwxBDYAw006l/e0iU
 WFA76SgaJ5TBDFgJRHw/HSHKKJXUSn2dHSX32oXmoKjXQGVnN3/TvI+dx1C4R49AWmM/
 pD9bZoUMFh1I0eh723KMDcNcIWZInc6USW7UCnTclCr67MVHcSFfqlO0SY4ntfq5B4DN
 hsy6kr/apD3mxrudeggEpedn8TR0dtd3WdVrWlbrpRQBQrUOAF2orgOPkXsDSyIgxvvZ
 6qtza+A5za7GVpChnM7ScmxAsnAPWcvW5OIM95X6hoXZ1sVEbh/1LrdXOVQ3A+P2KQO5
 ttMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277276; x=1777882076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CUaWTZovjDgyCAn2d0HALI7PgHwWvhiaIIr4lldEoLI=;
 b=UTPIdgI9X0v3C/QZqaC3epdvu3f+oqyL8z+zXlcA/BxVcAnK6iP9DpUxlHLPN83kcS
 G+4mifoVjsK5scejmyjsUL/MDRj3RgGhsbILxmmYD95Odyf/JYYtHy8kzs1/7MqZijWn
 5MfC2jFpS/XnlWenIOF4MCe52NAF1bO+3C0atw4IFWz6Mby2t8+ln/sDPA1Whh0OHI14
 9KJAF1V0aJeihLhQCu3Ovdc64h2b518kyyjqadHR2058MiK5TFf9K+P8oGsJzYNGkpFS
 fBb5CiI/GCttMwSoN1eT1ewGHeMxrDFwX9hdDqcM4/pOIIolry6irk5LLzbYjsPTwX7Q
 szmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ioAHKdaT4VEEKAWgl94ecsdy2Fkv/Jhsvtch2+VKXmEMYM8ZEZJSlJwzwqBgiQSNhpWx75EIHLl2X@nongnu.org
X-Gm-Message-State: AOJu0YzRSyp2uawI+RHrKSFIsXK2PJAcIXzaYmE5aD/Yia4SVsiGsXqJ
 pBtcXbd45fnFbbsv+hwTkfEwl0VC1tWJ9/mCb/jtV9wOFVpY7zpDk7CnjRKPdyA+ngQVyhc3ZTQ
 SG6HQg80=
X-Gm-Gg: AeBDievyAALxtTIOhTmlfeQHmMzk6rMdKpmll5gL5XwAjVg2LdXyFGn/8nQpeNmcsdJ
 W+Xsk1oTUIVS4GGjUazWXb9p2nYwAyl4ZQVz+LCntbE84enQbzEJBK6Zkp7KacEGUhZULxjRbZp
 dvsIywPrq/vGgiI4CTZW5AACyT+5uhDdNCPMPOWzolAGm+R4R1xt9IXr+ImTfKqdUh9k1n5aUAi
 52SkBQFecqh6qmdK2EQrRxM+VV82lxhUnxYTmXRu3A2aS3AH/HKWkFPcFbT2hVfM4GJ5i1XvEjQ
 gsOCb2REg7nTcPrnYk+NsuGHdiyHDEQczBHB80XRXEFp4MkfHCq9bTqyYmJPQ/wTlV1hXAM8u2f
 JMAac3snac4DUBSHzDgBsMD/xaw1zwLcQ3Mbl+uyMsCyUBVmRC2wEo7ElWpJPDlLj2IOt3YwE7+
 PlUyCFPO0ISWWJcUVLNC86j4Mt+tDe3fvz0weiz6WrFTQTs3xhzQx85yrfcjeASCKkfWtklWe1J
 G3QJMQD65E=
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-488fb7930famr600071025e9.24.1777277275775; 
 Mon, 27 Apr 2026 01:07:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm448330885e9.13.2026.04.27.01.07.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:07:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 02/32] target/sparc/monitor: Dump all registers as 32-bit
Date: Mon, 27 Apr 2026 10:07:08 +0200
Message-ID: <20260427080738.77138-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Set MonitorDef::type to MD_I32 to dump them as 32-bit. This removes
a pointless unsigned sign-extension on 64-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


