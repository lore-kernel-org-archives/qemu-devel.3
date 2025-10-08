Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AD8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Nyh-00024M-9P; Wed, 08 Oct 2025 02:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyU-00020u-7V
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyS-0005Xq-Kr
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so3783616f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906109; x=1760510909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRF8Uyf38eujUALOuDgoXpdcVfr9o4Mr1Zd6XLJHY8s=;
 b=EVwA2B0xnNgipTRIjtAIPb4sDNb/QixLt64zr2lX8FUEeYA+3JdtBKxlP97KuSAv7a
 e0mF8HFboq5U8R159WKgTCULTXQ+wrQUycnLPSsge6ihAqsdLnidL2QCyfe7jSMjH2Xh
 dpT6pxhu+Ac8NfPMrf13uNxi4DuztfRmiGqZLRvzuoBNXze/0Kwj8svhGpRE0rYn0y/f
 tz0VdA/BHgNBVsQDWsTiRCBkZuA0IJWdp0bEaavxr0XukqZ7LmBkpZcEM2mHCeSvnZbf
 XJ6CNX9786C6uFxskdtzNZOD88kzM8oDCdmBcUOMbG1nKSDMn7DPC6kqzG9MTyiljEGj
 pYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906109; x=1760510909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRF8Uyf38eujUALOuDgoXpdcVfr9o4Mr1Zd6XLJHY8s=;
 b=XBzgG26SJ8poi3KvLwVkUF9tJud+PnK8n7OtFirlGeiFxzC6WSkeHkRSFy5o101r/e
 uGpSxm82wpfKY/otp7vV8xvLkNDhi4A4LsJnqecvyksumFVEukWQ8AgY7awTu3XzDbO8
 8hM3m8gPrxj76K9DryZStkLIqs7VjD3H1kQbemuHF933bVzwlsrXltha78Y/VTXSxovt
 qPagIUqhJi91sf9wjCm2OdDSQRpTHxT77JvOhxaWls7eDMulZ63IEJFyOxKbBTUEcbZL
 ZhfroXJJLxmSlD2tA5AAFuHdoMDT0KLLcGSPtK8W1DW7wU6PEcFWVgo1a5X/wOOPPlOE
 GxHA==
X-Gm-Message-State: AOJu0YwX+biKBcl97kQuSpQxbYh5Emk7QaevILIXlTvuzr0yM5xQSKZ8
 WwSsI+tAI3eX+8UUrOEVnlJzOC+TjtzKfqPXdzvIS0bypc2vkdxiUYDBkkz2F8GGNflhg3+OPyv
 6AuXsNLIcCw==
X-Gm-Gg: ASbGncsDgwHN+OM0S8CxmXnuYJcJWxBpMedkWkiyVBvAIebHKzdQcl/aieWPIRE+AhT
 B9xGTiL4XKm92TQ1yVJh4lgQV78RHfiduAx3JRUnxK7gutymJibwU7VBr5pdxOugLxVvyDjGpJY
 x6Hmk5z1QFIWUPMHsA88/oiuv3g0Li7forayO9jvw0fsDNPMVMB4JWcZh6nn1JyELV+AJFZQ0wn
 Zidzw0JjP2y6tO3WA6/6G9KvXHrv9D+W8S+Ov8l3LiHk6/PNY2MrpBQJmGEzul6QARMxrw/94VN
 o2ER8q4mXWJKhd6CjN6oeB6hXpy9avMBpJcqEFnXTu1ObCBRnV7nwCJTK7R6CJLvQYP0ayPDqtL
 tzv63jG9xMp4S/k4IKt5Ac2cZcCe7XSPpPu8fT3soX/+W3A/rq2D/o1xG0E/6h8v1/43rl4pqg0
 mHUK9mtREFnLOBfS072Ba4YoLT
X-Google-Smtp-Source: AGHT+IGJ4gir10hU7up608QVA+AuTnhdihI8dvBvH9/JNcvps4twT5f2EedDP90wQ1oz6w2nylIoGQ==
X-Received: by 2002:a05:6000:2c0d:b0:3e2:da00:44af with SMTP id
 ffacd0b85a97d-4266e8d8d0dmr1220714f8f.36.1759906109456; 
 Tue, 07 Oct 2025 23:48:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28258162f8f.34.2025.10.07.23.48.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] target/sh4: Use hwaddr type for hardware addresses
Date: Wed,  8 Oct 2025 08:48:10 +0200
Message-ID: <20251008064814.90520-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The CPUClass::get_phys_page_debug() handler returns a 'hwaddr' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 42e324589e8..0e13339b33b 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -325,7 +325,7 @@ static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid
    MMU_ITLB_MULTIPLE, MMU_ITLB_VIOLATION,
    MMU_IADDR_ERROR, MMU_DADDR_ERROR_READ, MMU_DADDR_ERROR_WRITE.
 */
-static int get_mmu_address(CPUSH4State * env, target_ulong * physical,
+static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
                            int *prot, target_ulong address,
                            MMUAccessType access_type)
 {
@@ -392,7 +392,7 @@ static int get_mmu_address(CPUSH4State * env, target_ulong * physical,
     return n;
 }
 
-static int get_physical_address(CPUSH4State * env, target_ulong * physical,
+static int get_physical_address(CPUSH4State *env, hwaddr* physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type)
 {
@@ -433,7 +433,7 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
 
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    target_ulong physical;
+    hwaddr physical;
     int prot;
 
     if (get_physical_address(cpu_env(cs), &physical, &prot, addr, MMU_DATA_LOAD)
@@ -800,7 +800,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUSH4State *env = cpu_env(cs);
     int ret;
 
-    target_ulong physical;
+    hwaddr physical;
     int prot;
 
     ret = get_physical_address(env, &physical, &prot, address, access_type);
-- 
2.51.0


