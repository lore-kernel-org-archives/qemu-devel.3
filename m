Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BD606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h3sLf/rf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wp-0008TZ-HV; Tue, 20 Oct 2026 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wn-0008Sc-B1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wl-0004N5-Q2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so40629475e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499282; x=1793104082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UeL+8vC6aQ3VQwZWZxW58agudbTa7NuDqzjt9yofRd4=;
 b=h3sLf/rf71u9cPs1k64kTqm/Mq3k3pLh/U3UQOI3HS0Xb8z6XuXmTt4FwsD4GahdIZ
 m1AVpoLlXIYdqJpF//mZZ/XStFY06vTpxYnDtbGuHYp2W5VMwjBi/dn+EZlZfBKRwLQE
 62Gbg/uJrOBTHBG1rvHFAHVUspn+H62ovXpEbprCiA9nEQAfnbAqcXz0VvIqnPvl6Wcy
 C8xK81colyWpBpIj6IWl722t6hopnhNWqJBY/2tWPq1C7LwN12oLICZKYxrWZiUK4r+P
 vxjCpoz65qazQ3UxGPJwJjpJtjbd2j9/whbbW/KWJfIOFs88hAKcOhjRLPDdwxdyd+xj
 ZLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499282; x=1793104082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UeL+8vC6aQ3VQwZWZxW58agudbTa7NuDqzjt9yofRd4=;
 b=q8A9yWm97MH8huIECt3BHTfihXPqs/rPKCQeeTCEDvahXPIWGKtlp3O0NunDlxFA4x
 jeoJkpjm3q42N+NAEzYxF6lSK6Cmb/i6Ipfn7UCH1LhHK6aDl1MblZbHRfblOeW0xMMF
 pEfrankqmX/0nohJjYc7/iSMaEYV0LpZQyss+a3m31YGqrGAmeNXZkHSuinDo+gehXbx
 1ahZOJw8iomqKes8femfs55ku38Ch8G5wJ5I34EJtPX0ax7M3CckHzfR2l1ve1EGdlU1
 N4aJvdeDJwFyKI2n7V6PXZhU9lfAT/cMYBcKontdxnJOtJKlqH1cjBw1AenQI6fFzn+Z
 BviA==
X-Gm-Message-State: AFq9FYLvhcarpqWlUe9QL1yfJSVuTvJjFZCWMpNjoR4Ay0ChgaPyHzDY
 0oZjf5UPalZ8VKIBI9zmvf3qKajpz4+rZh/JgLZbAEFdu3lTUJRNcMNCZXXZ8pJfNkLKDhfqSyP
 +NG9f/28=
X-Gm-Gg: AYBFou3EdbHmuUqGK1eDyWhFkm/aHEjxDrSgTEzNRnIQT5wsN2dkVbIFGDtjm0p0rER
 ascWNh6vbPNE27sb2sDSFu3Yj7C1fd/fdLj+DA4+PRNejvQO6yQXWTvLj7rICZcwMzi+eXcBjWr
 +ZdJkng3P5MTjG8geh+KHstEDYAqVP86nwWfATGtcCLUFZ2LMtT44FddiF30GPayBUdgXdQY+9D
 KD42oS4wNpVOT697UT0ha9R9RfXgLAI3IAPgUJRJrVdpkIgaMs6lKlF9JlGLw9gSKk0iUns/qep
 zla/J89Vdsk+xnQgyNJ80cIC6/8xTyLNNX86RKAvYsKri578o9Kd63Soo/ddvEFaz+iXDBnJ3le
 LNjD27yKRzntLV1KclFIjL5o6HHegQr7fjjDCPpmdRaCkHl0CKY19K/bSoWyfwKZosPLl5UTteo
 pb7s1rskCMc4tMKkWcwwagI9M59iD9zjuL8FFBxE3l63hTSKwnk42MEY29RFkQiGYRAZB0F6+qX
 UFgnRvCeJou4lVO/qpa1G09+XvO8vxVI+co8Kqggs+ozmRVWtbDhiM3AFJ0YDZC2KghOACvztdH
 ARU=
X-Received: by 2002:a05:600c:46c7:b0:4a1:f9e6:f418 with SMTP id
 5b1f17b1804b1-4a1f9e6f45amr15744215e9.34.1792499282222; 
 Tue, 20 Oct 2026 05:28:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:28:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 4/5] target/rx: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:51 +0100
Message-ID: <20261020122752.3651914-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert rx to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/cpu.h    |  3 ++-
 target/rx/cpu.c    |  2 +-
 target/rx/helper.c | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 64ba48a7329..8ec704a9f72 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -136,7 +136,8 @@ struct RXCPUClass {
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr rx_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool rx_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                TranslateForDebugResult *result);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..0bcfec1d7c0 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -209,7 +209,7 @@ static void rx_cpu_init(Object *obj)
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .has_work = rx_cpu_has_work,
-    .get_phys_addr_debug = rx_cpu_get_phys_addr_debug,
+    .translate_for_debug = rx_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps rx_tcg_ops = {
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0f99279bbaa..1f73fed6efd 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -147,7 +147,13 @@ bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-hwaddr rx_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool rx_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result)
 {
-    return addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.43.0


