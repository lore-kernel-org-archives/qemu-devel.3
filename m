Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D29EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7aJS-0005rH-5p; Thu, 16 May 2024 08:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1s7aJM-0005qY-LV
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:34:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1s7aJJ-0006PX-0g
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:34:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1eeabda8590so58680955ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715862849; x=1716467649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lys27R2Wsf2SnXyQcY79ip1NkU6kkjSI5byaNvYzksM=;
 b=dBg+QdjHKRwY7lFijzi5PA/szhEL46/eBau1k5BuS6MqImqGVuI/YTRLlQ/KDy9ON6
 8AYzORSUFsncR5T4yXvosRxnnKGHqH7pwUi0Z5E7Vmn3vOAdPqz0cZPdf38ClUtfs3RZ
 3KOY6MpWzxVnaGxGBmV68V5uhOdOu/3C06+skN5QTioMfAVXqELk1+oNfTYgpefdlwAJ
 u/8ubIf40c3FRGHuR6g3cWJwL/87vWvP19QM5EJWBLIMVX/UR4f8G1jDpWIamXICnDIE
 OfAzkHSgBb763hI+4TyUZ7BHhlz0J2elDuICLNYZrOSIOFqaQNXPrq3ijjhIizMLwn8u
 hcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715862849; x=1716467649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lys27R2Wsf2SnXyQcY79ip1NkU6kkjSI5byaNvYzksM=;
 b=SkuIogA8tnDTdRifLeC652oogDVnJnoGUUf2LfZUvZqMXo8Pv1KvaIeh2hIt5HfoAz
 7jaRyrLk90ZDwmiYzYFeeyHVUtLbA0/m49QiF8FjL047c1VdcyjVFwUUxnBQK6bpW9DD
 iv59U92YpsCYNP2E0dE9lsZPzkf/ni2MYWSWI+OJpJYyrdHmFPzqDqWxfnewJnUCvB7E
 Q22z/8kInv+hTMqA2HLUXFvgYQLvvHffnlAAGASPIoMQDT3SlbY67o++hZIj+wfEnE34
 q1EjbCHnZxG68h4maOS/V29e1MmwcX0e8JpKFFiOZ99drPWCjSitVS42nN7Xi7ysLiHM
 bGPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgjggDqScQcDm9rGimwk/D0ai3Hn57xWZrcldaYCexeTD8MDSy3M0RhjqWAk/FCXEmR6HlGOHGZhJ884NIcd08zN1p++g=
X-Gm-Message-State: AOJu0YxaGDxhLoenIVXqIVFCbjmwdqRtSz8bR9/YF5OZ72FvKp0WMHmw
 o5L6FiA4dAeKkIMvWN5h7+7RU1OV8F77ldtkfj6YZkygOBLNtbKdJ2Auv8FfAIk=
X-Google-Smtp-Source: AGHT+IHo6Vk09P7Ol3/CXSwy16BGS4Mr11bBuWxmoWX1ScUr5AhvRquKnKkjD0kClOHksk15a0Mo0w==
X-Received: by 2002:a17:902:f552:b0:1ed:1d37:267e with SMTP id
 d9443c01a7336-1ef43e281b0mr241238285ad.16.1715862849016; 
 Thu, 16 May 2024 05:34:09 -0700 (PDT)
Received: from jerry-1818.internal.sifive.com ([136.226.240.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c136838sm137850155ad.232.2024.05.16.05.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 05:34:08 -0700 (PDT)
From: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
To: alistair.francis@wdc.com, palmer@dabbelt.com, frank.chang@sifive.com,
 max.chou@sifive.com, paul.walmsley@sifive.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH] target/riscv: zvbb implies zvkb
Date: Thu, 16 May 2024 20:33:36 +0800
Message-ID: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jerry.zhangjian@sifive.com; helo=mail-pl1-x634.google.com
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

- According to RISC-V crypto spec, Zvkb extension is a proper subset of the Zvbb extension.

- Reference: https://github.com/riscv/riscv-crypto/blob/1769c2609bf4535632e0c0fd715778f212bb272e/doc/vector/riscv-crypto-vector-zvkb.adoc?plain=1#L10

Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 40054a391a..f1a1306ab2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -658,6 +658,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
     }
 
+    if (cpu->cfg.ext_zvbb) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
+    }
+
     /*
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
-- 
2.42.0


