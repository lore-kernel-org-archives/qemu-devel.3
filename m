Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF005C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLQ-0004jS-TZ; Fri, 17 Jan 2025 00:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLO-0004ik-VZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLN-0005wH-Il
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-215770613dbso22700555ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093392; x=1737698192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFJUeznJLd2V/k0Pqt2Kim4L8jh8CRphYkqY0ysj+eQ=;
 b=nMwpcRfco5X9vAFB9bOd4rpyMnTwqfbgyTYgSqsfVZlvlJBaZQ593NEPxm2O1QaA1q
 3AG0TIvtx+gFY/6TFUPn+RUvch2hEhnlYzzDpbWbxHuu9n+Kx5eJm4azNRIAGEAeFhwL
 7HnZjzhstm6Zj4fM3Dhz1pN9HORFPrOqusu0pR0H9I0HgZ8xnym3UYZ7BhgfSR2SoImO
 Db0kKOS+3HdQqEhc1Lgo4uswHEUgnd484qtCmX0mTf+lU02jyXDEKTF/3FbyQ6BlH9DZ
 wmiPf+PcM6tfHM9+rjVxMRFC71L+NJBDp582o9XWVIB6Qg6CCPw3DsNk5QVsAlHhOKXJ
 odaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093392; x=1737698192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFJUeznJLd2V/k0Pqt2Kim4L8jh8CRphYkqY0ysj+eQ=;
 b=ORaRNJSe6isFDuX1BF27NPrfrucDUl+J7nl4FlYhwd0vyZxM2yVM5/dW4nQUf+GWqz
 1i3r3QzwnYJMbEt3BNb9m6OQoISt2ZgPN/UdMLT8TDLI0fOBShfvR3PJ7QJ2byi1NbkJ
 CIMWf78M7cKeCY6Cq/mLm0FT1ZrcpF0ng5vUDmXbCUHPyTtvM119BcUSC9P/TEQr+Y/H
 1oCzmrTFHYyM5vXLwtXt3UJR5729VbNteJwO+wqWMEapkTb2UoMhK2YlMjdRFqq9Tfex
 jDbKtX0uKh1AOmZrx9MIfr61RTGPisnYbB30HDEc4V35ngLNxed3IwSYrDo6mkO2QDlU
 IXIA==
X-Gm-Message-State: AOJu0Yztt6rrtYS9yQ7e1zWqeAkk3skAKlr4xRiL6Rrr3WXfsveaD7br
 ec2QBM/ohyzXRFkdK61I+DzgyMCUcLG9HPeAik9wcZgT2RGp/ns1rbtGKg==
X-Gm-Gg: ASbGnctMK5XTvFEJLEr3artM5lH5iP0+VzkMJ6isqLtJ1RxMTNk1AInxOC0Vn3mrs9f
 zGqgxIyu+YVQos8VCqcFjLpYMOeKpauDq7p6n26LMp+8kEf9Z6ogyBl74u6tl5QD6lzLow97atg
 h4/m43zlX9cHT8p6Qu5ZGPhneN7+Fi2oI2krU+AK+Mc+GzFbSRuLWovLkwj0pRV8ZIYcYf73TOi
 5sn4YBBPifeBt7TJoafro1+Dx00cilrCfY5o4TigxLe3t9N7gNz8cp+r/19PFPsojzpCJeQ0QuU
 puC3epkMT8mfEvG6DT5e2KLgWb4VFX31nMa02nbVKqmeicnfjCKWJhlnoT8B
X-Google-Smtp-Source: AGHT+IHBwxZ7oWF/JcSqL5zBk1qcGLVYvwci8WGvYE8KQVGV9vfHaziZFkZ7Nh8bLhRTwHNLW/CgVg==
X-Received: by 2002:a17:902:d4cf:b0:215:a97a:c6bb with SMTP id
 d9443c01a7336-21c35400a0dmr22941475ad.12.1737093391866; 
 Thu, 16 Jan 2025 21:56:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/50] target/riscv: add shgatpa
Date: Fri, 17 Jan 2025 15:55:11 +1000
Message-ID: <20250117055552.108376-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shgatpa is defined in RVA22 as:

"For each supported virtual memory scheme SvNN supported in satp, the
corresponding hgatp SvNNx4 mode must be supported. The hgatp mode Bare
must also be supported."

Claim support for shgatpa since this is always true for TCG.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 382 -> 390 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f58eeb689..3e138572d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index fcd9c95a6a..695022d56c 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


