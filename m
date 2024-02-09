Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AEAC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgW-00039Y-Mt; Fri, 09 Feb 2024 06:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd7-0006ur-C5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:14 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd3-0000r9-TN
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:11 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6daf694b439so672738b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476468; x=1708081268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbKGrat/lCDlPEyoj856v0npAYQ2ocn+FKM8NUnh6fo=;
 b=Yo8HwfJRWAWSCFetTCGPMrW3Ud5dYFnF1pAFwBMSdY87iMHvzS18ohmb3xG12G2YTk
 DqhXbXIs3vhieU0VuKHksqpS7Og5qlHhEsXLTbDK0+/FhGa8Pa3FuSwfPbf2YTSzmnm4
 sVTV8nQCsINXxtVFb9bJE8NYS7p5xXbgpQoQ7QeqqMCGkTc99os6zVwgRxv6vb8cOrK5
 g0yhnXknbAB3GViTyukSdRMnSfeL+q+Lb9sPhmbnwFfbKLCGmkp2zRGAjRvPL5l0AcLW
 Vrq3fDPDjzzPq9i/XGUHFxwi4Q7HDDm/i/2AOof5hVX7OPK5K5mm4XDevW4WuU9p1Qti
 FndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476468; x=1708081268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbKGrat/lCDlPEyoj856v0npAYQ2ocn+FKM8NUnh6fo=;
 b=WUWMpizOADxoF4+wHWqC2kE6vuH5uoDBA/3zlLiG5e7XgFxW1bvKlSuvxnM5ucVR7f
 MfLv+p7NEmG0qNffqMXr4WjyAQC8vwdZtOew1JgLi12sXSmbSkc2JqERC1uhrP8LwRVJ
 QSRr9rFjpFFVNXqVVSDcNUKbP3feZjoIQHl9+yY+rSQd9hEyQz1kKoZpjehPLMUUNcfT
 /P9JhjL1Tj08IU8ucm/TjiT2YO+zoN9xDiDfO9nqEN5WSfcYiM4WykgFfozupjYeLHty
 F7xjSgE1L2jxHugX4u/C3ZhiUI1SN0j6PVZRz66/zGAlT9Q55HT6Tr1KyoKHq4U54WBV
 BpfA==
X-Gm-Message-State: AOJu0YyEDk4N/YhZo3LKNf2bfM+xOnEksjQ9CIad+L0bcisPH+V1FgWD
 3fSqrZOJlqmTV/1TrQzJRTrrEezEOvzaH9aINapTUAALNL5zHZ9Q7GnhDsNzL/0wSw==
X-Google-Smtp-Source: AGHT+IHv9esL89bmHG73FipokPIPQQBeQJ5pqHm2wm54ORI0cedZzLnJEblI4GWlwslk+43rbQLhyw==
X-Received: by 2002:a05:6a00:2716:b0:6de:12ae:68d6 with SMTP id
 x22-20020a056a00271600b006de12ae68d6mr918425pfv.17.1707476468163; 
 Fri, 09 Feb 2024 03:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZ1b4a0KotDm54uUqP499hPip2S0vqB8jMQnKr8jHg4aBCb1qsf3SxWFcsBwhw0gAFMJ57Gsa1dKfYDPyjkeC+0dWdJMdENdgkO1SpoCU3EVr1tB+KdkkGeMvgmutG1tAj/fSWVIG2oUKLvV4blSLaoDX/hib/FONR90=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/61] target/riscv: Add Zaamo and Zalrsc extension
 infrastructure
Date: Fri,  9 Feb 2024 20:58:02 +1000
Message-ID: <20240209105813.3590056-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Rob Bradford <rbradford@rivosinc.com>

These extensions represent the atomic operations from A (Zaamo) and the
Load-Reserved/Store-Conditional operations from A (Zalrsc)

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240123111030.15074-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e241922f89..833bf58217 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,7 +78,9 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_zdinx;
+    bool ext_zaamo;
     bool ext_zacas;
+    bool ext_zalrsc;
     bool ext_zawrs;
     bool ext_zfa;
     bool ext_zfbfmin;
-- 
2.43.0


