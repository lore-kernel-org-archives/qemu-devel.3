Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAC3C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwVO-0004in-9x; Tue, 28 May 2024 09:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1sBwVN-0004iK-8w
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:04:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1sBwVK-0003pP-2M
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:04:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f47eb21f0aso7010855ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1716901476; x=1717506276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkWDWLJe6ifCLfRxbVy6kaBipu+b3OffSbkRgfkqXg0=;
 b=VrR84w7i8k+eYVQKKiHyrea14CvMvKWYfSgu/tniICbgA+S8+nZ6g/iaBzOLyhKGfN
 5WrRuM9UqKxScQWvoJQSb36qlhcU3/4AypU3mkDoujztkA1jHSbWr31LeHLnHgCvrY6g
 sZAXnJJmD6d/u0BBLhlx6X90nyZy1zvVOnxrTEUmuau37UsPyZczwcnnTOm2V8XVb1NN
 ubs4nDwnt285o3+B7bUyj7Pcl3ISQ4o8PO3XbVbkzQEKCAx1RrqoTZ0jO029vEVakkcl
 17CDC41iRCRk6X5WJpHuWEBTYqzs0eY7Ufg6onogGdrg0Uzf8o5qCyB3oI4xqcrrfVWJ
 9WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716901476; x=1717506276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkWDWLJe6ifCLfRxbVy6kaBipu+b3OffSbkRgfkqXg0=;
 b=Cxz8rIUVpMmUc8D6dnXcj97bDxVmgxrEe/mKyi/8pH+RAO8WPEs6vA3/MV1ou/owX3
 IkRy1A96KHXuVZGjTTo2khg3pC3jghBgKIxlxftPHDPMmkx5bQj/3jsinfCj7/uK/WMM
 0Pln2B2LvBc7D2EE85i8oi/BYz4Qjsd+Q8PkItvMubGrCiX6nnXG7KpR83fDDa0yVCqP
 H8OVgsh4d5M7VE8ZmJnlWYxtP3Oo8lK+U4Thw/8GRG3Puw0oAA6J8A40d70P/6n+mAwc
 zCZ+n3ELD0wb19ZCjL3b+ldDatwczByV0gd1lELZIQ2nmdbavvw7T1dfr4mumDb1WVh1
 oEEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDModa/9tXzcBnZ0YhMMHmrEFDCNGs3jpZcEbVa4S420B9tl+Enu3eyXPMfah444nMmrpH167n+0QvT6hCLjjeSjlk10=
X-Gm-Message-State: AOJu0YyhXToh0HajnKOoIq7eb3uHM3K/GFgIX9XnG7gr5BApTARXZCsB
 pq6h90Ix9nScWzJRcfI2u6WaAp99cSTZBrr+0PN+fB/pxQeENQmsm8nD5if0n5c=
X-Google-Smtp-Source: AGHT+IFaCmHXurXlxjQhMH+5Sl1ud38kk4HTNfVgoY+HDisd5J7h/p6LyFY8jCzoNwR+aPzn7hN1Sg==
X-Received: by 2002:a17:903:192:b0:1f4:5477:4bf2 with SMTP id
 d9443c01a7336-1f454774e12mr128639375ad.42.1716901476194; 
 Tue, 28 May 2024 06:04:36 -0700 (PDT)
Received: from localhost.localdomain (114-34-225-151.hinet-ip.hinet.net.
 [114.34.225.151]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a4fadsm79481175ad.224.2024.05.28.06.04.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 06:04:35 -0700 (PDT)
From: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
To: alistair.francis@wdc.com, palmer@dabbelt.com, frank.chang@sifive.com,
 max.chou@sifive.com, paul.walmsley@sifive.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH v2] target/riscv: zvbb implies zvkb
Date: Tue, 28 May 2024 21:03:49 +0800
Message-ID: <20240528130349.20193-1-jerry.zhangjian@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
References: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jerry.zhangjian@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
2.44.0


