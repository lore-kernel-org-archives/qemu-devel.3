Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F5C54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByE-0005ca-B2; Fri, 01 Mar 2024 18:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxo-0004v6-6h
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxm-0004Fe-74
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so10146535ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334405; x=1709939205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXv7UEq6yLB4cFzFbGG2vFz3ZhmdoWnqKW8J54cTadc=;
 b=ATPboLxDfsaTLNgvFXnLgCdE452zxfkw14RBbC8zb8rVbkYGYR+1UnkR7AeIrcLVm0
 i7Ff7/Ae8bD0mCGaNCN8jWtdkWgPZpXdRsGd6/j1Px12dv3GkIvpmL2JZwY1tvdtwWES
 qFo6/7aCzrCIkAonWI3zvyO3rsGd02G19LBUrkGpOyzni0SqYgDlkrlseB7h8l51Qaj8
 l8EA87o/U8lo+Vecw3ymJSQ40Ft/mlV/AQPPSAactowc4eLKN7gBTMg4ZMyMT55PgB7i
 anIg13ULUl8zwZh7wAUOgJfFFwpB4HwxeKR3bVO5G3D3EHu6NB2yvD9qRYAS86f6SeI7
 +oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334405; x=1709939205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXv7UEq6yLB4cFzFbGG2vFz3ZhmdoWnqKW8J54cTadc=;
 b=kffqTdkYOBN8IpIAPtyqOjZMaqeAs3IEfQGTOFLsciQhILbw3xxjubQz2j0vJkmdCj
 01aqIRn1TJZizOubyVOxzi1ULpsMRYFvMykah9ySVI4vBAK/xMuFMiYo8a6k1cqj8I3J
 TLMpnUyXRDpXo/irR10G3ZaFH5sCOzUxMBshT4hVEaFU/LgLtBz5SiOskxnWCOSeSt3+
 An0Iq5Pd12ZWQ8lHHs8RqxbWDrdIIIeFjVrQpnyVaO5dOzViDljL8zDa++wiHKjK1Lij
 9IosIdY7c0Z50/ZAWHxrxrmER3Itgn/oeWCaF7u7ILxnzgsHD189jCE6JLxa0Gh1t29b
 VIrQ==
X-Gm-Message-State: AOJu0YzIZReSn6SkuTsV8TpmY1g2635ifvUFYfQU7giUUwsQXBYbeR7T
 EOMMkAXtlKAjB7CmBp27KYRkYY+05hX0fneCpb0iBtxcTC4vjKiwpFCdCbCzIEpxplBblaSVI3R
 T
X-Google-Smtp-Source: AGHT+IFXQSXnU3Ao9/HAmOezRnL4JaVjs4rkit5pIuu3lrDaLx0719o2octFlr6I81PAFsoZNmwnbg==
X-Received: by 2002:a17:902:9f90:b0:1dc:c28c:fb92 with SMTP id
 g16-20020a1709029f9000b001dcc28cfb92mr2782861plq.33.1709334404665; 
 Fri, 01 Mar 2024 15:06:44 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 17/60] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
Date: Fri,  1 Mar 2024 13:05:36 -1000
Message-Id: <20240301230619.661008-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On i386, after fixing the page walking code to work with pages in
MMIO memory (specifically CXL emulated interleaved memory),
a crash was seen in an interrupt handling path.

Useful part of backtrace

7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
21 0x0000555555ca2c61 in mmu_lookup (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1803
22 0x0000555555ca3165 in do_ld4_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2416
23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=0, oi=32, addr=18446741874686299840, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
24 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555578e3470, addr=addr@entry=18446741874686299840, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:294
25 0x0000555555bb6cdd in do_interrupt64 (is_hw=1, next_eip=18446744072399775809, error_code=0, is_int=0, intno=236, env=0x5555578e3470) at ../../target/i386/tcg/seg_helper.c:889
26 do_interrupt_all (cpu=cpu@entry=0x5555578e0cb0, intno=236, is_int=is_int@entry=0, error_code=error_code@entry=0, next_eip=next_eip@entry=0, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1130
27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=env@entry=0x5555578e3470, intno=<optimized out>, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1162
28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=0x5555578e0cb0, interrupt_request=<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper.c:197
29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=<synthetic pointer>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844

Peter identified this as being due to the BQL already being
held when the page table walker encounters MMIO memory and attempts
to take the lock again.  There are other examples of similar paths
TCG, so this follows the approach taken in those of simply checking
if the lock is already held and if it is, don't take it again.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
[rth: Use BQL_LOCK_GUARD]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 047cd2cc0a..6243bcb179 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2022,7 +2022,6 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegion *mr;
     hwaddr mr_offset;
     MemTxAttrs attrs;
-    uint64_t ret;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
@@ -2030,12 +2029,9 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
-    ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
-                          type, ra, mr, mr_offset);
-    bql_unlock();
-
-    return ret;
+    BQL_LOCK_GUARD();
+    return int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
+                           type, ra, mr, mr_offset);
 }
 
 static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
@@ -2054,13 +2050,11 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    BQL_LOCK_GUARD();
     a = int_ld_mmio_beN(cpu, full, ret_be, addr, size - 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset);
     b = int_ld_mmio_beN(cpu, full, ret_be, addr + size - 8, 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset + size - 8);
-    bql_unlock();
-
     return int128_make128(b, a);
 }
 
@@ -2569,7 +2563,6 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     hwaddr mr_offset;
     MemoryRegion *mr;
     MemTxAttrs attrs;
-    uint64_t ret;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
@@ -2577,12 +2570,9 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
-    ret = int_st_mmio_leN(cpu, full, val_le, addr, size, mmu_idx,
-                          ra, mr, mr_offset);
-    bql_unlock();
-
-    return ret;
+    BQL_LOCK_GUARD();
+    return int_st_mmio_leN(cpu, full, val_le, addr, size, mmu_idx,
+                           ra, mr, mr_offset);
 }
 
 static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
@@ -2593,7 +2583,6 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegion *mr;
     hwaddr mr_offset;
     MemTxAttrs attrs;
-    uint64_t ret;
 
     tcg_debug_assert(size > 8 && size <= 16);
 
@@ -2601,14 +2590,11 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    BQL_LOCK_GUARD();
     int_st_mmio_leN(cpu, full, int128_getlo(val_le), addr, 8,
                     mmu_idx, ra, mr, mr_offset);
-    ret = int_st_mmio_leN(cpu, full, int128_gethi(val_le), addr + 8,
-                          size - 8, mmu_idx, ra, mr, mr_offset + 8);
-    bql_unlock();
-
-    return ret;
+    return int_st_mmio_leN(cpu, full, int128_gethi(val_le), addr + 8,
+                           size - 8, mmu_idx, ra, mr, mr_offset + 8);
 }
 
 /*
-- 
2.34.1


