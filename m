Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E4D41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmwd-0007X5-Ku; Tue, 12 Nov 2024 04:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwS-0007WK-4N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:08 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwQ-0007jO-FV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:07 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ee4c57b037so3954124a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402724; x=1732007524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E42IsZBE7HGFFYOrQ3x+O3byf38/OjcoUURin3swXE=;
 b=NhxkXzws6VF0gwD7QHckW6cYBQjj9aBhaeEtUK/RmGLX2AOlCTNLlNpTkMQ2dUFgVE
 DbLxQ6b/fiOz9msQULgkJFEHLSJ9zk39xMxzcOT/D0UMoJyHDfx/f81t/k/jvtq2ZroH
 mk62PLl4ofFvpXWr9fvYchwkp89Og/xB85LZZwGyw9C4ell2wbq5AQSYPpzB8F+vvYTc
 cLwRaB9if6P5aPC5PEvvoQKfmRunKtCLe3KRcGc3D8ASvUDkhq0erpZUsTTbIAk7cPeC
 0KytaH8nVs6SUNws4qux8m82zJgWt2CWCzdpNNsvHAuwGul2gjx43JqczzK5F0nCo26s
 aZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402724; x=1732007524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1E42IsZBE7HGFFYOrQ3x+O3byf38/OjcoUURin3swXE=;
 b=EMPFhNbF6EXWuhB+Opx0b7ObHcNslfE6+uS5egL47UliG+HXcba1jqZzQYv4Ca+PMN
 eP2aB8QOUgNMuwhjJSaNKQ7LRpcGB49blU1h0qMxuNcjqW0KEto3WB0aEskzzMlzyE6t
 e9eZAbhQ3ypz+dEPnkWYJXBaBV222pfo+0VwJMfTdLnuojXkwcJnEmLLKLLnBbImvCcZ
 xRHP7hW8Pc/83x/vEz6wzxfAoHUUC36kg5jw/CTCcbrt1GbF8VmEOueLsqmSo5/AnxaI
 kqIY2riSO0/4bV7k5nWkIrdgmTXDH80ua4L3J5GEv6JSbS2zB//4xBCduD+/r4na/6fA
 VZcA==
X-Gm-Message-State: AOJu0Yy3OFJqQx7mTJ6V7uUZKlbudQQn9JT9hOahwZbLDt38edLRlDP/
 ADHTlSpMkJQO7rOhEEJcCtvDajdEtds1I6GsZGXSn9/ZiLPi0/l6iLDSrWvjH2TVF+CVv75WUF/
 bHywFgD02n1Y5vXqPGg2uKDude720O4mlEjTKErwGkCeYbjOFbjbDcbPIfo3n9/PsiAigvNnc0r
 hvscQRwFPdUKxP1dZBXgc5Kv6coAMvEaTGyV8=
X-Google-Smtp-Source: AGHT+IFm6DmEv77h3jMrkVTytuLwa/AhmZuDeu6IpjIjoQKiHPFt96PL1sno/O8pICd2xJRNPsiF0w==
X-Received: by 2002:a17:90b:35c1:b0:2e2:af52:a7b7 with SMTP id
 98e67ed59e1d1-2e9b1785684mr21068570a91.34.1731402724477; 
 Tue, 12 Nov 2024 01:12:04 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm13495347a91.2.2024.11.12.01.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 01:12:03 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 1/5] target/riscv: Add svukte extension capability variable
Date: Tue, 12 Nov 2024 17:14:19 +0800
Message-Id: <20241112091423.2529583-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091423.2529583-1-fea.wang@sifive.com>
References: <20241112091423.2529583-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x532.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.34.1


