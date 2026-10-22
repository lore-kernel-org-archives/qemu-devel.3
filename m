Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2B606A337
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K4tKjPn9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsO8-00015M-Jz; Thu, 22 Oct 2026 08:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNv-00013f-4a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNs-0007K9-Pt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso19236755e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673943; x=1793278743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xSWfTn1fmXqw14gMpKz+sBJ/waSif06t4nW1Y/9R7Z0=;
 b=K4tKjPn9gwkxI9boW/0UaAAHalQP7UU62cLjwJCFE0kmEncxZDKhRMu6//FNsyA+Hy
 AS8uq2V0fCLHyibehiD5BXMGtt9vq5rS05pv9W6DQJX+AdgJtAqI1+P9c4jPzuGhTpw3
 oIPPp7I4i7XRw8F01YK7uYWuM/r1wxTGdqig5XWKBo0ZSalYkkFU0ArVCgeF6VLXjBFm
 brz812J0+cj4UFXJH63VjVEQww7x6N6GF5uY/TWClAzU413JW60yQlvO/1lGB4bCitAz
 TfgxTk7EGsEtXcRgiVQP9f2msh0kfZwje63ZLoHd18dz+N57vZTEqf6tb9NtYWSl/TKp
 OAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673943; x=1793278743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xSWfTn1fmXqw14gMpKz+sBJ/waSif06t4nW1Y/9R7Z0=;
 b=TF+fuOfLlq3yNG6+DJztNZtonzZl06YUdriOIJbKQkC7uGiYItE3eCJF7PKUh9L2vG
 NQYlP129EYzcz/2lxYgTDvDSg+79QIPmYr6eo9EO+/KQItY14y5fQIQT+ZpI9ha5k9zJ
 zeq+VzL64n7o4DpAYmBxBorUzrI2jS07H6ygF5pT0ZAxjEdgkL1SELgoDL8YkwwsnHvH
 I+apryW/a7TZz3ohz4HEmKNQxp0NYj8DorLKL0mQnoiQNj0fhq8qT63CNLfKq+mcXARh
 zUJeRH2Hdlg+1eMpTP62fJwjS1Osr/9DyiJueiZL19ehKxl7bRqqd9qOIY2SSeyfS8nc
 X3zQ==
X-Gm-Message-State: AFq9FYICXkcohV7IXTau/Krn60Cf4tKeR4ZS41+trLycaiRO4UdjSt19
 ZsigYPHqOMV0NubpUo0BaOj7+vckdo5g2tCjvdD76QvAT0CDMpRCOzGWd7vPtgOcQWSyhsab83i
 RrELT28o=
X-Gm-Gg: AYBFou0Kiq2mrrvkZn1kE9yFc0jJhxc6NBuL4OACvUq6dURfWOZgz9ORxo0YYKOowpo
 eLb93q7vhEMW92cPCASULYhExYj6M1LbOSd3aGN8W3xpiSMM3eFazglsGy08iAbxf+UKvjBdxJG
 nUcNygSzWPtAylJUvjsTbA3m+PI83EJBuY/MJGk9bXLJdqLhyUW7OH6E7zVKJ8kiEcjA5SeF7HW
 On3sgCbGFO2veau9D7Oz2FHIS5W7etny4HbF2oDCWFnZ1pt6rzvMC+wOEvRX5KlNGMImWHwhTcu
 mdvNlb6uK0GqhPYkdmu2hCea6ZjUYDNnbUrFVl7rhz9s7IKYw3qn2MPx5/ABQKyU7/5DBEUjNlF
 nmisdvHrJZU8+CT/r+xGaEH2brJYIcJw+dOzmlMW+RElMTP11dRjPfXUgeKUkPDeSP4qA1Sg2E/
 ObRaDFTN37x3TWOT/dWAtkbtYvqz1OeYfEyPpHDw+4hplCgGy/1fmWkS2X1q/+htGIqA6NSO+C9
 /pd3GjYoD104SJ/P3CZrMGNHS7ZbFayEQCfwiMZMZ+KHZVK43BB/yatwUmqXL45wGbzyToNRLvX
 jCDP7pkERfsNfdM6PJ+wr7QnPUeMLqchTTjjxPn6UhPVFjtCt2rvdcC1PgJ2
X-Received: by 2002:a05:600c:6309:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a1fdd293d6mr89724145e9.22.1792673943104; 
 Thu, 22 Oct 2026 05:59:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:59:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 2/5] target/hppa: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:55 +0100
Message-ID: <20261022125858.310252-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Convert hppa to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/cpu.h        |  3 ++-
 target/hppa/cpu.c        |  2 +-
 target/hppa/mem_helper.c | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f9..94c81d9fa6e 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -389,7 +389,8 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
-hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr);
+bool hppa_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result);
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
                              MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..51d9ab186c5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -245,7 +245,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
     .has_work = hppa_cpu_has_work,
-    .get_phys_addr_debug = hppa_cpu_get_phys_addr_debug,
+    .translate_for_debug = hppa_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 01e6149c811..2393a155076 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -346,7 +346,8 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     return ret;
 }
 
-hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool hppa_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     hwaddr phys;
@@ -361,10 +362,20 @@ hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx, 0, 0,
                                      &phys, &prot);
 
-    /* Since we're translating for debugging, the only error that is a
-       hard error is no translation at all.  Otherwise, while a real cpu
-       access might not have permission, the debugger does.  */
-    return excp == EXCP_DTLB_MISS ? -1 : phys;
+    /*
+     * Since we're translating for debugging, the only error that is a
+     * hard error is no translation at all.  Otherwise, while a real cpu
+     * access might not have permission, the debugger does.
+     */
+    if (excp == EXCP_DTLB_MISS) {
+        return false;
+    }
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled)
-- 
2.43.0


