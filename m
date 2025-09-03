Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6255BCA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uto5H-000340-NH; Wed, 03 Sep 2025 10:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto5D-00031x-5m
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uto5B-0005tE-12
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:03:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24c786130feso13333815ad.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756908207; x=1757513007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7yO8ADA0pol4cy8ipnt6jQ+4uDi0a2eWjgPSJWFAag=;
 b=XBA/vhhha7Tb7vCBmP6x6mUGW35xJrYYDp/UI0+KoNj6F2CwlW0773lQEnMEFoX0j3
 b+wcv+tDK+hSj31+dm/fJ1jNghc5UUk+bAoQQAT7HC/zNuYqnMEHwz6656Or1H0SgVtT
 W3zqriR8R1ThSbZvPe5kRp+vdrBQxVKgBW+9EPAk2J8Nc1hJN/Sg0SNFt+4KS7CXEDNH
 wlD1ejg2PE/hJi9avBTBNwovlwIzdQCZDaxeRubL3I7d44rzzhO4kjGU0UXC8Q5MH31w
 aKJKBck3dKFyWEqGG1MfIWvjyMg38kS5LYx9Iy2ip0Kb8PXZKnBT2TukqhjIpyfK4MAe
 ZbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756908207; x=1757513007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7yO8ADA0pol4cy8ipnt6jQ+4uDi0a2eWjgPSJWFAag=;
 b=DZh/T5bV5Mqy9CQEM4AU+UQRa53zFv0p2lAlgv9zX6PE8unIr/Wnw1c8cB8WOZRhb6
 odBpQ1SQ+NlIBVu+Mxz0B8EJh2iXFahWRyUzH6qkRpH8aM6+tZTMMM7ggJTjpkMTFS9W
 UK7ZEEunfM+t42GmZogIBD241iEUys20NQ7pIjC3yYfkoswJCpNfuS3KjvnzCMxxPxVI
 M/vojNpffEJ2yuzq7cRQpFjvV1mf7Pu7GE4nTbuZo/Y2QaoyETGeygItr114xiD2lMRP
 GGmii7ryxgdDucUf1dg/ywnFkwzYAPsyfy3fhDTtNFFBOtSrNfWQlA4xo7kDm59BoIPY
 bYQw==
X-Gm-Message-State: AOJu0YzgMH76CHsvbpgM+ZTBOuEo1V8wCEwUXlPrC37C9AGF6SwAgMmD
 YfLZEtat3Lji5cowY8VX3IPetWiMSvwQClms5rGF3ire/KkNxq2o876oSaqI8Hu539+Aivo+sJS
 IA2VMVvId5E4IzVQk8UTJhLxLrQ/3L5D26upqciiwJGkTrWxJEdxagnoo5T1CcCFfgMZCzU1cc0
 9bhyNHj93vr1l4f/gSAdUWodYun0fu/actzhaFsKXWWA==
X-Gm-Gg: ASbGncvtp7rNOeGkf8n+dOa4Oi8sA0iA6JV4bc0HkcooZbxB56vQVCYeT+4yg7j37J1
 p8wVN4x9+2LS4tjpMcUounnqHmpOsnHD6Ss0i6Tp1S525PMQ6rVGBOFOhj3jqRBNq5R6O6DEez8
 cUe97UEcMknXDZbrHw2Wy0PPp1CQL9/U16OInB4JikGYqaI6X3KwgN23GOM640KUzuj7CILn314
 IoW5GNzoRDvT2CaJQsqlZMxwDjoKuPyxD2JoyMxhE+Ed6kLxMsPkAEBsVTLC/Qr34/qd8wMYqfT
 4i5MBVIJRB6Y0UK0wXzW9AanEYJl3t6lv7BJXfw6a9PjuTSdVtjtMpNfEAVb+qWNRFhMGgzW9iz
 B+PlcqiPzaaSxS4EhBKDApoadccxWFJ7w4dB9HhzKMKCqnWMk5NQaZp9Eb8G5irdW+DmeaA0W9X
 a4hw==
X-Google-Smtp-Source: AGHT+IFp1z8hnynSiwSV+34+CkKSuU/DNEso0oDkvNmZ597dU5eMU07lZKG0MnNOkgmr76Cr09eoDg==
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id
 d9443c01a7336-249448de13fmr166549455ad.13.1756908206165; 
 Wed, 03 Sep 2025 07:03:26 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b14e1b097sm50720545ad.21.2025.09.03.07.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 07:03:25 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v3 3/3] target/riscv: Expose Zvqdotq extension as a cpu
 property
Date: Wed,  3 Sep 2025 22:03:08 +0800
Message-ID: <20250903140308.1705751-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903140308.1705751-1-max.chou@sifive.com>
References: <20250903140308.1705751-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 95edd02e68..ed486113ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1373,6 +1373,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
 
     { },
 };
-- 
2.39.3


