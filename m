Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA66CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsT-0003Sg-GS; Tue, 13 Oct 2026 23:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsO-0003Kh-Ra
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsN-0001qZ-BI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:42:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so1973730a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949318; x=1792554118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ik4ny7Bm+dyaud/nMRbUWRPGJvt+C0GQpAvpufVJbl4=;
 b=Sya1hJYQhoowpDLImFULmHIAMiL/s0n+gjNUnpfgxE6bF5K0KMT58Yx2dfns4WM+3L
 qHvJtgUtChiKD7nbVIPGQIj/9o4TLMbc5/TFpIrDXZVbenjmYoLtQgz4tiYlk1Tx4W5V
 hlgnsJYvoWHJiD6FFwbqXKEW/AMLIHrCZ9f9Pr2ofJERtv/foPnSbSnElvrD2BQRODKW
 AI9m59sPhnvwnfK+/PXL2q4i0aTYBtfib4R2fKEKYc8YxqSOdky2cSsi3uqwX6ZV3DwF
 u560OjALA17a19DoEG/FWqQmfmENjqLSdXMJXA9Aenjt6HWL2O8GILZlcg2J9+k5qsMW
 BRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949318; x=1792554118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ik4ny7Bm+dyaud/nMRbUWRPGJvt+C0GQpAvpufVJbl4=;
 b=1Z2EjMhDngR6N+G3Svy/dImllcCsQDcQZ+R31bNO7r4Hk2b8qEDbdFXdoKG50/pusX
 xds6Yri9vg3GHCiNAw++zDyM80M4kYaX+gFaiolppMhdpa0J2D85XwtwrxicX2kXvbLx
 qmn06eHo+2e/Rf4d59Vm2IGGjKzIdJOVQAAoenWBrnrxgq85hyhGsb97EW0rTCaCcFtp
 kvXkXtB1AOvsO3F7QlIyQlHysbnICmXotrsJAq4AGc6LfzMrYogjirQItVKMWHF92Kzt
 tjIWyWfyTrgbbcMBYd6zoWJo3Jhq+PN7cvXJvOBEcaI8yn3puhdITEKr2mLu2mM/Od+H
 /+tA==
X-Gm-Message-State: AFq9FYLx7hJcwH2jAroTt3gbhZTX8Cbn5XnyrFFEUNpIMxvgD2kDizRw
 wDCxMQQoAwtAM901+fe3S32zCi71Jc40J7WcQIMxlLLxo4a7yTlu8rXYHLbuDA==
X-Gm-Gg: AYBFou3qITMvR//n+7Xf3I3QW60SOZWduzV9Yse2VJHW9HdXoayBI5YxuQCnBal7wZV
 NQjxxv8/Liuecnh6pSx6cMnGqCSy2D2Sxmi0af4FQ7oZCleUhhBP+GubaqAa7qyQ0abPUmhiF62
 Vknslj9EYPU9Iu9NiRpohEW+y8cZIeQVSAio+pUDcOJmvqF+sVtJqH0W0oH7KmmogEZsRP289q4
 u8/hPs8V1Ptt815V9VFOf2W5w7oMvVCmR97CcabPIqp914SAiv2p5txnPgr/0YMdyuSFrnraXnG
 HbhimwsUgEF983YahA9WixfUBh3DF/YqOPvU6VAj/GCTCda8xMyPA16Mc85jBsChyzCpHmP2Pfc
 Um1vtUzl+CrXmBYtOt5bDblBf/tuca/fNkeqE/6waHQwL52f8ez+aGhXHWY3QzsfBrObiqVncHo
 GJqSH+AHXrg2tUUDpKlPTKl7hXhqoyEr0+vEnVvSSfZFTrvwEqCPXcQqywlqxtIADCJkTLVn9m2
 w4CWPBXLULPVO3E
X-Received: by 2002:a17:90a:d007:b0:3ac:3459:b7ff with SMTP id
 98e67ed59e1d1-3ac3459b992mr4332369a91.56.1791949318035; 
 Tue, 13 Oct 2026 20:41:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: dodochicha <kevincheng60303@gmail.com>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/52] target/riscv: Check Svnapot PTE before updating A/D bits
Date: Wed, 14 Oct 2026 13:39:04 +1000
Message-ID: <20261014033907.3332383-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: dodochicha <kevincheng60303@gmail.com>

Reserved Svnapot PTE encodings must raise a page fault without
modifying the PTE. Currently the A/D bits may be updated before
the Svnapot encoding is validated.

Move the Svnapot validation before the A/D update so reserved
PTEs fault without changing the PTE.

Cc: qemu-stable@nongnu.org
Signed-off-by: dodochicha <kevincheng60303@gmail.com>
Message-ID: <20261005115916.21196-1-kevincheng60303@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 4e42883bd5..33d6b41ceb 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1498,6 +1498,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
+    if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+        napot_bits = ctzl(ppn) + 1;
+        if ((i != (levels - 1)) || (napot_bits != 4)) {
+            return TRANSLATE_FAIL;
+        }
+    }
+
     target_ulong updated_pte = pte;
 
     /*
@@ -1590,13 +1597,6 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     /* For superpage mappings, make a fake leaf PTE for the TLB's benefit. */
     target_ulong vpn = addr >> PGSHIFT;
 
-    if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
-        napot_bits = ctzl(ppn) + 1;
-        if ((i != (levels - 1)) || (napot_bits != 4)) {
-            return TRANSLATE_FAIL;
-        }
-    }
-
     napot_mask = (1 << napot_bits) - 1;
     *physical = (((ppn & ~napot_mask) | (vpn & napot_mask) |
                   (vpn & (((target_ulong)1 << ptshift) - 1))
-- 
2.55.0


