Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF12C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJs9-00015J-MR; Sat, 18 Jan 2025 20:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs8-00014q-3o
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs6-0003AJ-IR
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:03 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so5809535a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249181; x=1737853981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HWWsLugXEr9up/g4/JxXJKxCn4PeYas5O5GPDoslqE=;
 b=kfcmbw36Eeu9o85ET1Hw3LyDLBhX9Cp+aZdumoED40vgJRRNQAL0JQRtgOzVz0fuLE
 JayVAC2p+qYoKt3fqV/VFYk0jlLrqdLDzDPUTWrkFykxB9LIoNLlmfxCiiFw9dA5igZ7
 CFQstsXU8fDPoutsETSsYZFAwchXc9BarYSuBOzQ/1bJq/k7bPiSyXQgLbLvY3zrnRcp
 /71SnT4TKsAZ1cmrtxFZX8p0q23mJ+9PrnMNTjwpeBFJbYjC+8R+OVg0l6wE9QNutedL
 RE0S7PwGm3rRL/Jjh3FILf7f2LWK7vS4uuzADUcALQXuy4KYJy3E7siK/7ruuc+2/vua
 LRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249181; x=1737853981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HWWsLugXEr9up/g4/JxXJKxCn4PeYas5O5GPDoslqE=;
 b=wNTb13hb8aufTh69pLcAirk5wCbCGEPfmT44cPj5+6znzaj9I4ZdHWLjmFq83v2d8C
 U4veZ/dxcmzYan2vGm7Yyw/6aEZckWCz/F/Cx/LlfV3XlXA6SBeiU0x0G2DFdyLxilUk
 k/+uyDMUKe2reyIzIaSYlB18v5J/Lo19Cu6EJLM1mczTq16RFJdgAD/3vBdhbcO67i+N
 W4G02Z1VdkB5K3sWtkIrAdEW3SQl5r1+kSK2+DB9FyQmmUhWT/CdEnnPavZirI3wZkmz
 cybuS8Al9z+l91XpVzxYOKTKaCWMfDpIZSmwcDe/jBm0ik8/JlmH+6i2wtilxeLvfApg
 xieg==
X-Gm-Message-State: AOJu0YwJbsvQk64Z7g355iVi6zBwiolVMfVkTHZDkvK5U5AVsyHSqWnI
 e4EASZKfv4aev57BTPvZglqdMh0mDyHa1KcHmnFvNo5U/lrgIkxCsPO8GFry
X-Gm-Gg: ASbGncuy+efV2U5AdOqM28BWjn4SPH+OJxbJM4tCjUXyOO7VunIM/9vknB6aApx0qlp
 rB237S7udA4YdoIMvXEJFzFeec9d4cMJfdncpbyIP9MituJ5S3wQexL267K3GD7hC4tQ8gIsMDt
 aoiQ5L3ehzLntfflLWYgKWodnOc76FrpHqdB+cC93qkCKGQspL8NxCyREjA8OpPNMIRzsS1y1wR
 qHEeYVaAPWs2y20Frk9TsUpiDidHG7ohAjcGBDAJ9QO5tRVeXT4AIus21DaA2w+1UvaBeM2mzOg
 48V9L0eP/rzKIHtKqltQv3o0p27Wo0PKo0phKl2V42ZWm8PAK5y9Y4UWwKKaeAGWqJwuzb2Qug=
 =
X-Google-Smtp-Source: AGHT+IE4iImaV41IMPTC64WaEg9Ifi9JRKwJ4AfIvYYtGH7XcgEIgovlesJYGVgrd2/h/R00vYz5ow==
X-Received: by 2002:a17:90b:2c83:b0:2ee:c918:cd42 with SMTP id
 98e67ed59e1d1-2f782d4eea7mr10296300a91.22.1737249180863; 
 Sat, 18 Jan 2025 17:13:00 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/50] target/riscv: add shvstvecd
Date: Sun, 19 Jan 2025 11:11:42 +1000
Message-ID: <20250119011225.11452-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

shvstvecd is defined in RVA22 as:

"vstvec.MODE must be capable of holding the value 0 (Direct).
When vstvec.MODE=Direct, vstvec.BASE must be capable of holding any
valid four-byte-aligned address."

This is always true for TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 364 -> 374 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe5f7b572f..20cbb6b2f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 065f894010..2c7dc6c9ab 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


