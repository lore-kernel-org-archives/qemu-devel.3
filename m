Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1ABC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsN-0000qn-Fb; Wed, 29 May 2024 12:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsL-0000pB-QU
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsC-0003M4-7t
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354e22bc14bso1907141f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716998994; x=1717603794;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rgCgyNe1gFuETnV2hFHHcZAE4WID1bHJfoxPojDtt4=;
 b=l57/93W3aU8wUHKYJUsEQP4pfG3dJncK5FBvAZWqlEWhRXwpsrGYDmZbGt/HuF8BIr
 4bE0V+KtDTSrsBMV4pnaP9XDFRasaH3C/LlVFNQuMP2UgL5rNBrVq6iPhxtzq9rtAn/U
 Vf3F2NCbzyjF4r4tW2oJTU2SuMoKE+suaW7gGhZB/UHkm4NZK01+57sT5Ymd4AwudToP
 Wl7NyBkwtWbSjV/bsjyilMObZI8cu9NF0KZDBn9qUGtz5zwVj/aUQzrRnmM1Mwni5QrB
 Ehs/3sCbFqcSyah/J76qflp4CZEdjgOM5GmeLFQlRKuZ46ZL9vz+/RKmKqVpiCOLy7Th
 6YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998994; x=1717603794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rgCgyNe1gFuETnV2hFHHcZAE4WID1bHJfoxPojDtt4=;
 b=wtMfuiLk7qoF+tdI/lrNW+QErJOSp5/vazzQrPB9DmhFe3J5RAemzdYiiue7/jysnL
 +6OjLwuA817f01yyTh3jPeTgVyX4oTE1p/qMlA0ohbcVUF+WPUe1X79WzwnIctg5W5EW
 EqoXsuKTE0FZPi2g29bS4RTV3cmJObLlN26JVvnvabo/UiC9CQYv9aqFGkKjaVGsrU+z
 DSl03fcQei/nsHDPla1rIXzrDfpUaIKlNw1HNLJSYgQQaIQTgtCMdxX2JVYJJTeEh3Nd
 M+aBKTvrouuK67mvDeFoOhHNFw8YoAGxuSJJym2aV8Z9psuk5AxRD9LygZW0tqndYRDK
 szfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqkta28MlC+QywrHGgrExDZa11MYWWe5DgIoZO7jMxcEq/QyeO0S1NsgJlpE+yb32yYfSeaRVU0aEvPOpdtmqmUpgftLs=
X-Gm-Message-State: AOJu0Ywjec9jPJfZYgR/te8K9trL4hvs0Bu0gaZOyJ6BLwzLUxqqGh0g
 fREr/rnPa4ziR/+Ty+WgZ+n9hXjG2sARA46/tgA+17+2ThL2bUw7HR/C4yzfbwk=
X-Google-Smtp-Source: AGHT+IEKq36zS/jtHLiHLHUVYEeDvsl0Uzo3f0YRmPIvRFRorXUoIqB3NPmjFMN7nTsL/7MmEcMb6w==
X-Received: by 2002:adf:f0d0:0:b0:354:fb97:1365 with SMTP id
 ffacd0b85a97d-3552fe19723mr10083659f8f.52.1716998994367; 
 Wed, 29 May 2024 09:09:54 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm15228213f8f.107.2024.05.29.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:54 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Subject: [PATCH 1/6] target/riscv: Remove obsolete sfence.vm instruction
Date: Wed, 29 May 2024 17:09:45 +0100
Message-Id: <20240529160950.132754-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..9cb1a1b4ec 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -112,7 +112,6 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index bc5263a4e0..4eccdddeaa 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -127,8 +127,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
-
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
-{
-    return false;
-}
-- 
2.34.1


