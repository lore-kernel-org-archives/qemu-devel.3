Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A540DC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Nm-0005J1-2E; Tue, 08 Apr 2025 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NT-0005CH-AS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NR-0008SY-LZ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so4758625b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108818; x=1744713618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VovFIwccFz5ZNcTAzE7f9KTJbFEt9HWF4oT+EcZJzUM=;
 b=f16Qq/+lZuneGcXSIuQCc1LWYInm+ao338AIk9LyENMX8MLjyvWMglI15GBUspc4nD
 HL9WXJl1RCupUpG09lw46zcgZ4FjcGKhnV4FkzNQWZsV5o8UofqmgDVcqb+GEYcosXEe
 gdBXH5yq6BI8vPsCEujhSgDHU+SzHBvk5r3bTVkE/TVJt2s41NkZU4T/TdlO5N0JiRSF
 nzwT6hV2NZNhtUIEflUZRnpwAecK4HXRk+kQN2FTmcwO4O/QwA05QPKc8MmNEDCzV4ps
 9K1QzRcqCcjaYFl7oYEkj2zuhoQjP/vWhCgo+oA6oGYtoeKZXij6OPYKZnfnx5ThCb4G
 oJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108818; x=1744713618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VovFIwccFz5ZNcTAzE7f9KTJbFEt9HWF4oT+EcZJzUM=;
 b=vn6EB/IXGHp50afggCgSYUwOLOw2fKiLPbC7+Qz1QCHUs6M1QWIRfC49TRkKZQkp2o
 OKdAjUcjW5wyDMsVQFEiNOD4O+NX0oQdpXJdPGYn3T+LK9mYidk/feG+p4KAohvI0B0L
 UIIyrqYKtGfBfIvkBVorivoYFvmkDNvfriNEPwiwS39kNE71vdcvkM70XqUPI32RQyZ1
 cxRlhcI2J21pPOxAAgralY7+Fa3yP4uS/Rv1cwg3vaMlRbSQv3nltRjgdT6KNbIVyiRF
 WiURIKBnmVm1yfz0j3dSakxmH1C6vSa7q9z8orJnBxDMysaLB53INI1HbSQwSAP88ZsX
 Q7hg==
X-Gm-Message-State: AOJu0Yz0FY/5FucUVWkda0RusS2i8OEPL95UsEI1jcWT2IydALqVtzKq
 SshaepkavDPHzfQJRLRxYL6BrpREpr7MKaqApxHl0s0I+rxsnoHPGLccc8p7FtkfVdbLVf/AhB9
 6AbbmlHi6uTXbeKw+RnCsvOUZSklbqlxWKjQeBUPvUp8gaWebiZJq5ECsEk5V0oBSo6V1eXAmjW
 TSpmgFZ4yphJh236wAJntLrN8QCJY6bRMshAkWK5MJ
X-Gm-Gg: ASbGncsWb8ZogpSPn78WGjsyM1KbMKNyug9SSyig5xs2AsusCpRko1+Ruf2z38JU6oB
 jyf2ZfuWlSu90bo3qTvNeu/SuES5xaHU57fyV3oJeInqEava/xTvvV30xe7wDeZhwhNInMc5vlf
 MWtahO0xlbOky8S987ZljJMSz9BLik5EZ78uQ5y3sT2MwB/JE/FXDxP4dTy+vlXTDLliMM1lqX9
 xa/BChSBI1JBTLO1FoKcIQ075qRa4pg6zBZxHcX96vGjrJx+S1Uz8YuT7cRo4qsN/9n/5WH+taF
 KgWI4EhC6eT3Qfx9SGQIS1dJ+dBaS4D147egcMmkSqctakfTCl7sd5aBJOjX1NBUFZkAJmSYiJ+
 Fy4gWzkQXCO6M62GnknwOMzsb
X-Google-Smtp-Source: AGHT+IEFW3BV82D1y7m5eF8LXuwTZ0X+m4w4T2ZUx25IvWUj5te7H+NjsQ0lfpOPj0sru9r7bjYYhg==
X-Received: by 2002:a05:6a21:107:b0:1f5:873b:3d32 with SMTP id
 adf61e73a8af0-2010474acc3mr24554087637.39.1744108818018; 
 Tue, 08 Apr 2025 03:40:18 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:17 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 10/10] target/riscv: Fix the rvv reserved encoding of
 unmasked instructions
Date: Tue,  8 Apr 2025 18:39:38 +0800
Message-ID: <20250408103938.3623486-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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

According to the v spec, the encodings of vcomoress.vm and vector
mask-register logical instructions with vm=0 are reserved.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6d1a13c8260..cd23b1f3a9b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -703,14 +703,14 @@ vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 # Vector widening ordered and unordered float reduction sum
 vfwredusum_vs   110001 . ..... ..... 001 ..... 1010111 @r_vm
 vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
-vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
-vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
-vmandn_mm       011000 - ..... ..... 010 ..... 1010111 @r
-vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
-vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
-vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
-vmorn_mm        011100 - ..... ..... 010 ..... 1010111 @r
-vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
+vmand_mm        011001 1 ..... ..... 010 ..... 1010111 @r
+vmnand_mm       011101 1 ..... ..... 010 ..... 1010111 @r
+vmandn_mm       011000 1 ..... ..... 010 ..... 1010111 @r
+vmxor_mm        011011 1 ..... ..... 010 ..... 1010111 @r
+vmor_mm         011010 1 ..... ..... 010 ..... 1010111 @r
+vmnor_mm        011110 1 ..... ..... 010 ..... 1010111 @r
+vmorn_mm        011100 1 ..... ..... 010 ..... 1010111 @r
+vmxnor_mm       011111 1 ..... ..... 010 ..... 1010111 @r
 vcpop_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
 vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
@@ -732,7 +732,7 @@ vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
 vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
-vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
+vcompress_vm    010111 1 ..... ..... 010 ..... 1010111 @r
 vmv1r_v         100111 1 ..... 00000 011 ..... 1010111 @r2rd
 vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
 vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd
-- 
2.43.0


