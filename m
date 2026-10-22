Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E5606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G47B4YvK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsOI-0001AH-Su; Thu, 22 Oct 2026 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNt-00013L-5e
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNr-0007Jz-DK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so19478195e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673942; x=1793278742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15KVxgua1RtTtMZheAeMQxeOO8nOq6kF7AGPMLSRATM=;
 b=G47B4YvKBvdo7Fz2H+Y9CHjXSd+6l0Bu+RLigNfjJDH3jKdQxw9sVQQ4RK0hHfu8YZ
 3zZFlxVwFlfRSgRfJ2IL1/brfyNx5DwS72/fj637XCoVkX/o+UtfnNGh5Z2cBvzmgS8n
 C44rJ5hjGqOW08VyiuZ7QfyzlS2GS2IlYwWj0e+C++N47WzPVt0U73HzQNCIM72ZEv8p
 ZHkWfaVFhjXKDef9rdpgZ9ezjHVtqHD4PF4kKLZ7XpkvAYmToJQak5wQzO9T+atbQqJl
 dyX63NMHqi4RadWiqQPYgbxw8emTFP3P6Qp0Ccf1iwh4dAuxatM4aqv9wfClXG7Q3Zgr
 EqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673942; x=1793278742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=15KVxgua1RtTtMZheAeMQxeOO8nOq6kF7AGPMLSRATM=;
 b=T1fvjb1pAvli+yzC1CWLyF5rylCLyT3pDeMwdQImE5ZxdI/ldcl14CQPfTJtX00YFW
 4Sg9pFV4Lx71dEKfzs1heo0KILoXYd28DJH1RvJDho7bamHB2wuV/ixu3WgXbzLQw4+z
 IpnBlPNro8TBRHVuJ612coTA6i3NE9QvVIKpOB+h4YWqCJzMZ7WwN7j5ERk5+95+oKfd
 OolbBLPrLnb9NcEX9hOgC/emKTVGSR9tOqJx/lBF6kuriTxqSiOOWcMTEQekYtrG4iH6
 WTa2ClvlWgUmkoPHUw9UIRO08BzhiEULKCWsr8MSMSayElhvZIIWPw79LReQHGRMWCv7
 fxjg==
X-Gm-Message-State: AFq9FYIB6Nk8axMQ7z6/ljLc6nVgOjkGjuhcQY9qxw7ikm0vQ+nb3nlZ
 obOPD5TMK0JTSJJ4OLCeEA4XCi/sj9mE7zsMBZXqZ+XPHaUzT/vOX7/AynXmZeHPXQTCrcj0oGX
 J3M1S6OU=
X-Gm-Gg: AYBFou3G69txwqITN+rqxmMGM2GLWSYiKkxuIw6yZMZQOTm61tLDaLh+J7u1Sp0zPEz
 Zk+/Li7B6JqnfpNFhbUwDI+udcNzi+ySGxIi+yYZIhAN2smaAUnt6m6Jp029PDxgAcLpXNzoR/1
 NvGAz+gr822sPWlT1H8ZaEUPWF6GpifmYzXFRvFioQb0oZgmmp4KzZLxPMqYnwUQIjNtunKrijp
 zwiRTEin9t9F/P8SLlZQ9/o2IDap3W4jxWXK5cakHm/dq+idpuHE+vtPXIBpqIy8cUj8ZiufnFp
 ztQlFJK+f/WLIhx/a4j16SRgy6275PCb6y1Xbj1CbtnqZ5DOFySmr/bFAAY4rG1eCdTN+bvDf5k
 hk0036WQbrebXkNGHBY26/fEnR2znYwYCGzCbnjCddiUOeddk/c6DCZzCJIoeBpsKD3UXFT6PXf
 nRayllv0LZMOXBQgE8vPcUWwpdgOc6yBJ7tfFZiPHoFOfs5T5UsN0G76uv+FDGsTMCJcn4WGvzr
 E+DwVTn6seNddOpnp33Iab8kVeqIpQWEG9R6so7Vs4DHffO7xLaUbPkKPvDv/3sVyhJQrOGcTIY
 Es0WCWRVydoyGIRZmhr0YPJSww1QxXLuKhQc0Jpo7ONK/M676Pz/WDsWCd5Z
X-Received: by 2002:a05:600c:4585:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4a1fdb20774mr103770105e9.25.1792673941848; 
 Thu, 22 Oct 2026 05:59:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:59:00 -0700 (PDT)
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
Subject: [PATCH 1/5] target/hexagon: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:54 +0100
Message-ID: <20261022125858.310252-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Convert hexagon to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hexagon/cpu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index f20d6de6f63..5e99e84b075 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -612,7 +612,8 @@ static void find_qemu_subpage(vaddr *addr, hwaddr *phys, uint64_t page_size)
     *phys += offset;
 }
 
-static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                            TranslateForDebugResult *result)
 {
     CPUHexagonState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -626,10 +627,16 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
         vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
         find_qemu_subpage(&addr, &phys_addr, page_size);
         phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
-        return phys_addr;
+
+        *result = (TranslateForDebugResult) {
+            .physaddr = phys_addr,
+            .lg_page_size = TARGET_PAGE_BITS,
+            .attrs.debug = 1,
+        };
+        return true;
     }
 
-    return -1;
+    return false;
 }
 
 
@@ -755,7 +762,7 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
 
 static const struct SysemuCPUOps hexagon_sysemu_ops = {
     .has_work = hexagon_cpu_has_work,
-    .get_phys_addr_debug = hexagon_cpu_get_phys_addr_debug,
+    .translate_for_debug = hexagon_cpu_translate_for_debug,
 };
 
 static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.43.0


