Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E051CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHE-0006IN-PA; Wed, 02 Oct 2024 01:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH7-0005lK-7T
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH5-0004tT-0e
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b1335e4e4so57215015ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848305; x=1728453105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ei2e5cknHkWf4JsMB1Rt16vBx3FQInTOssw3MsHPalU=;
 b=eFQjxhWU0rV69L2RRN2JLWDulOctDo0y6QoXIktcHCazhG8Q+43Jc9AAURlUOLHP6w
 7ShrFQ2TZYIFZR+Jv0x9PGTqx5klktF8WqS1Q21F3VfgOPio3jVDW+YXTYk5d3IGzSyA
 i8u6Gug0pZY/x0J+ppYSWRUCBMijDMKJkz3i/fkOIlJE1HhcKMo8Sf69PLGY7I8yiTjk
 q6GnHMkky/KNBuPhCP+rhlMdeG2cr1KHgA4TxpETCWBW1OAesKd5hca2VW+K64Od0H2m
 7Obn+zOsmTYfm2ZDn4A63wlcAXkxrj6Y0O9l+cvdd99soPqBgfDLkxPadhmBjB/TlptT
 hM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848305; x=1728453105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ei2e5cknHkWf4JsMB1Rt16vBx3FQInTOssw3MsHPalU=;
 b=scnLEG7iD0eJ+nCUzw5MZZzeQB+Rz2aq2BnZuqDYt2sBYZLFz0i7n6GPFOskVrSLWN
 UEME65ozYXOX73zV55Juwje2VbhMg5QIwupTe38ERT6BgboM5AmRsvD7xRPa+sGOHrUi
 ILYOBQNL1d4o/1ZmvpGRtGET06nMOQYaVOyZCGAEYK/wfwPzlME953w2/1n/XW1VzEhF
 +fPtq89h3StbqdaauCk5/4O5oeAT6JSW7xupYaUJuDMe6R61yMADgVbqriQiLSV3rroo
 z9EsyiBMGI78nGaRFzaNh+oysLuLbm2BiseLJNJx/1a9uu8UIKxBZPxfmiazqQqnpMxe
 N/eg==
X-Gm-Message-State: AOJu0YzBWhzcbrvyFFNFbfhtbjdpZjDGlhXONcxjMXUFIfZIVpc3WXOo
 91W1izH8ZyuqmY2vcZmKfZUPFC7WVwjKShIeYSjn+L1ABIL/P2zNOX2Lr7SN
X-Google-Smtp-Source: AGHT+IEzhcLUvZHTtLHc3DR6V2zY2kRkUr9oQp4GvM2IZidn1H3nn4EtBV6zNqdh+0bPCEpEX2jlJA==
X-Received: by 2002:a17:902:d2cc:b0:20b:7731:e3dd with SMTP id
 d9443c01a7336-20bc59c4295mr30734165ad.2.1727848305559; 
 Tue, 01 Oct 2024 22:51:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 16/35] target/riscv32: Fix masking of physical address
Date: Wed,  2 Oct 2024 15:50:29 +1000
Message-ID: <20241002055048.556083-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Andrew Jones <ajones@ventanamicro.com>

C doesn't extend the sign bit for unsigned types since there isn't a
sign bit to extend. This means a promotion of a u32 to a u64 results
in the upper 32 bits of the u64 being zero. If that result is then
used as a mask on another u64 the upper 32 bits will be cleared. rv32
physical addresses may be up to 34 bits wide, so we don't want to
clear the high bits while page aligning the address. The fix is to
use hwaddr for the mask, which, even on rv32, is 64-bits wide.

Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240909083241.43836-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..4b2c72780c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret = TRANSLATE_FAIL;
     int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
-    target_ulong tlb_size = TARGET_PAGE_SIZE;
+    hwaddr tlb_size = TARGET_PAGE_SIZE;
 
     env->guest_phys_fault_addr = 0;
 
@@ -1375,7 +1375,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
                 qemu_log_mask(CPU_LOG_MMU,
                               "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size " TARGET_FMT_lu "\n",
+                              " %d tlb_size %" HWADDR_PRIu "\n",
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
@@ -1409,7 +1409,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                          " %d tlb_size " TARGET_FMT_lu "\n",
+                          " %d tlb_size %" HWADDR_PRIu "\n",
                           __func__, pa, ret, prot_pmp, tlb_size);
 
             prot &= prot_pmp;
-- 
2.46.2


