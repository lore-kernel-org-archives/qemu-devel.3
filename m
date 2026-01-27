Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B725CD1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6s-0001C6-Eg; Mon, 26 Jan 2026 20:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6r-00019p-Cj
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:13 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6o-0008FK-0B
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:13 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso1839601a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478188; x=1770082988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vs7p60H/dISULhoLL+Ih0Y+xS0j9epS7LQBAaJEH9xA=;
 b=TyL2cp/BoFFRYtf5ILId05CBwHywm7HkLvcJiVODpe4aEzNSrl2QJ9CFC6A7NkVsC9
 06ss0c45U42FI1q1wtSYm/Ddm9lqiR/F9s54K3LJSOxx+zYGO9aJUoHCYv1tJCOipE8l
 kh3wa+d4g/jT7f8W+7G73k8tcAyMT/pMgvTrIUMfTnwSY3Jsh7L2r61SPKx4MFs/HmVO
 u/joVokvhn+fatx4sMirzlMXX6kqbd0sg5PegdPzTzJejLYUFT+LUZFtqHt1BNcWLuwG
 Qf61UKWE2y6ui8OhAPcXZIeESOPNImEH6UuKUPTLxlnadhtUOGEcxGzRJqJi/1wtcQUo
 7RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478188; x=1770082988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vs7p60H/dISULhoLL+Ih0Y+xS0j9epS7LQBAaJEH9xA=;
 b=qCYIK3UrblRdoi1P6orCkWPS7Y9j0OYMEg6kw56SOFO7Pgsu/N9H2ERvcGoV15ErQl
 Eh604ebtCBIpucw5VvtBISa7wFK4TCOGROaob8DzZCig3FCTSrqIvbJxHG6SvsslV5Pq
 ellyq8TGc/2UF3h6yDiIn4XMcw6vj8mEDq2/KBgUyR581yBkPHMLvrP+JB/OFIwquORb
 MXUpkPABxoBEa2SFI1l2ATZRzjUiDIheITa92Vd9Xbd+A2KkZ5m0cvRvvro2TWtQCfOr
 1PeoIflXkK91GOsZPE/WbzniWQ2dkG+wb+QUUxaenoKFz1sChamzRTh5AGfJUWyCaI50
 Wi0w==
X-Gm-Message-State: AOJu0Yx1Kly7dhdL+sYdcXDiWhJEZVHWGB2WCLwTmGZHNypTdpp86pfE
 B5rCiPwHrl+He8WIR4hEjZZoZ9hp0TwY3IQOkgD8ecjksMPv/oTga1HR6jdORwi5PO/HeGSN/E7
 o97LIk0YwKpR+DJeahJ413hEIMQnSUhGus2qaU49l9klqPnWtWg887w7Pe/pHKrlNLuY4N2cJws
 I9tcHBIt7NXZFHMFZMjnZ6kjAKPrlTtdzVdUlfGDlr3A==
X-Gm-Gg: AZuq6aJps81SHN+3bs8yYS7tUL4F58ceUswvFKo6m7rqSNHWiVL6GZF4YkkNAcdM3T5
 +tsKH7h0PIpaTA987HOvTmKy5tYNy+1+gBxDe9gPOitiMrWO3LJwIpXRggRvyLeizpsnZpwq8q7
 s5NRYZO5MzsUcYG4KHaoi36bHbiDRFHDa5tNHgDKrfdrFPId5MkcH1pQQJelCFlj17dkMnt5rku
 dyFQoFXNip9LfGzxFadZ3pfEFb//J6U1k47RIizCJHbeIU6t4EPc1vGd2FJXIn7cawBm1j2tvrD
 c8bS8yLCtlvhu40jaZ/VSmM+T0o5HcE4bUFJVM67UrGgliuXgUXHhCP76YDozoi7XSaL5nGAV1x
 o6GByvRy0qFfPC7OLER7Fl0kvuNg7sZFEpWp01QXtvG7zKB1fO+qKGUcivW4zqAigdxSEZg/ROe
 N+9Szv6PHghnZdP/DVEyfTo4sQfj9KzV7en9qMAUmR7eey0RMcuMAOEj7BHnAdEb1dC2p3F3fJf
 Hmz3murDcPHvzc=
X-Received: by 2002:a17:90b:2c86:b0:353:2e1:95f2 with SMTP id
 98e67ed59e1d1-353fecca603mr240301a91.8.1769478188306; 
 Mon, 26 Jan 2026 17:43:08 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:43:07 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
Date: Tue, 27 Jan 2026 09:42:27 +0800
Message-ID: <20260127014227.406653-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 01cb62bde4..2bc3c5198e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1378,6 +1378,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
     { },
 };
-- 
2.52.0


