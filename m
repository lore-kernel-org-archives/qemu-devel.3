Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4011C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4I32-0000A0-No; Tue, 07 May 2024 06:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1s4I30-00009A-KP
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:27:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1s4I2u-0006An-IF
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:27:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so3603591e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715077658; x=1715682458;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qT7P2K/liK/Hp+n9TjtwIIf1ig5PKfo3pe/2g+9eNWo=;
 b=AkPoj2CQJYfraUaA9xOVrt9lhhQcR/CGQ9slRbxEPHSHXShqtwRydfWksDtDRWWnhI
 +v+D1YzeoIxtME8GsOUY6o0HSdgmFZus47B2Uij8h9NH1FSfcU5WRUCDJbCJIlfp03Cg
 1gZkkqWpQdc0H41NaQoCfm1vFeZkbySgujcuu1Rx3rhCKqr2W/jLNJ5e47T2UJjmkQ5i
 I7aKDIENCHLQp6wOBE9ODItsvoRpT2IzQTwVu2udWtPr5q0FzgJddIzG2laD/F+rc3fN
 H8L/mHYa1X2Zu+OCfGuei0JTcwrUkbeSO4ynl1K4zYe8vYzc1him2svqeCyBkICjiiHx
 sM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715077658; x=1715682458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qT7P2K/liK/Hp+n9TjtwIIf1ig5PKfo3pe/2g+9eNWo=;
 b=Zw5K2zQY0jkXe96bWSKf1cMdr+Nyyg8b/n5Zl2ov8HVMA6MUi/U1LBwCCATJoqBBix
 dKWspa2zo8wdu2WhVAUfSxBondnjnjJgjZSFQdHV3nuXjxLDRnie11cCMiHr7YfXB6mi
 DvWv16a5CXAWRs4+mtdWdsf/7LqcNYDJWxdp8SPrsPDPL17DFbsBa5MmUw97fIXM70XR
 N8T+6ty5QZjWCNP4mMlSse5yM6SEnlNSlmW4Wv3RXjmOVHODlvcRiCYWBH55Lfglntqx
 uvdxzb/nvWgmJUoDKF+y7JUiyYP0Npv2mXTm5MUoU72V+AbAJTsTwmhG4X+XcSvJsljo
 ptiA==
X-Gm-Message-State: AOJu0YxaRaUgq6/vbxUMk40uQQEtPMD6yOnDi/zQ6m7mXsjaeCAKx05w
 oDoFr534o3wF2zqgmHBfJhFEltD8OGN2KU4FXvKJ0ZvKzSE4MLCTjdMsJSf1WdqMUXkBpdtow3v
 5w7k=
X-Google-Smtp-Source: AGHT+IFsa0kgxS/n/nDcEoScMSnqzrupjnmapCiQtkETZZikUXFMeQrctENrXqdv5QZweoOIBwQIMw==
X-Received: by 2002:a19:e017:0:b0:51d:3b87:70a4 with SMTP id
 x23-20020a19e017000000b0051d3b8770a4mr7912852lfg.36.1715077657451; 
 Tue, 07 May 2024 03:27:37 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n44-20020a05600c502c00b004146e58cc35sm23116116wmr.46.2024.05.07.03.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:27:37 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Rob Bradford <rbradford@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH] target/riscv: Remove experimental prefix from "B" extension
Date: Tue,  7 May 2024 11:27:21 +0100
Message-ID: <20240507102721.55845-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This extension has now been ratified:
https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
removed.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..861d9f4350 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
-    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
+    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
-- 
2.44.0


