Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E8606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=upfC78jJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDM-0003fd-GX; Mon, 02 Nov 2026 08:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCu-0003BD-CS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCs-0002HC-I4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2717425f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626573; x=1794231373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/Gp5CzEV1OSEfjwLttqIiYCJ1yWK8i/gTI23jefsvbI=;
 b=upfC78jJbHsK/dMXTT/VAXtleikPI88C/ZqDNY3hQfylaPmB/85vNbYgr4kMuvZhmP
 eHLhywX7CB5fIXM2C/MP9loKDzX6T6xen+KtzLR7p9zPnwpiAZIFNOYqyFQALNlDEPDk
 yr/wV8TaCMWThAyHGBR5WUBVoP0mEOxZNQSNp6QzwxbRMV2c6Nc3JvAIPeAPCKHllBSY
 aGhXIo++obgJEnCwYCByiLDLtxjR3hhMZKo6l+EUe1wineMhsj18Rfggb8Lg71/DFz6h
 Sm08PwECGwq+MpUI0lRPdUq4dqLpBs0oEnE54JvJWr43w08HVA7A0isL3qjfe21GwZ/W
 /AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626573; x=1794231373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Gp5CzEV1OSEfjwLttqIiYCJ1yWK8i/gTI23jefsvbI=;
 b=aQgTqJipnnczXIvBE8rtfowkY6Cn65lrM6dzTw9IrSLmkrghZCdc6PEdUFwI8qY0A7
 eIX7Srvcv12hWH+ogoWV5XoCfN8eyfk6tz+nf6A59JLPWmz88tKTbbGn+fpcp+Dbrxpb
 /6rKf3aZSEFJVsF/P4Jf7ObKGDaZCrdQXj+GrTrmfEVNFyIXoTTR2KeFU0uBZXcTqEW+
 YImSKOSbCbhZo4sCozki2NudDf28RupEFlLSaULDxdRF3mkIk74+5WvCAkvOkwtO/i7J
 tTti20zOxQlVPgbmfJ0ohw7gtaRQcCV/Q+esOojaoSP8hc1vhY+pdz4ZXg9z9+X9WV7R
 dZfw==
X-Gm-Message-State: APuU4Z+jnCRM5YuA/ayj818tkcA4++l8VqyWgbP0u8ULKOZGSQvk7RgV
 METKfdymmZCyHnxYXdtuTrBfzYmZzzYrZy6ttfv4rQIeXXNP4u5N6GXrj/sjv76T/LDhrauUOA3
 kdpyE00E=
X-Gm-Gg: AYBFou3GoBNZ0aN3f8pzWj0Njaxk1+Bx6MyKCoDzA4aVPA6nXMDbsOrM5MEFuX+Np3L
 67wpXutQRlPKEv2pxFevIFHr64Xb/Gy5RAQTeutYd3tkWmjyh2+boQXy/rwX3KKcK5lGIXCQnBM
 3Jf0cO3BiXrez/977KKJqNbK42VAIIluTjN90sRgTtuqu/soyigClMzGyEeXd9l22Z+83ZQm7Jl
 dkGAMBKPbpFNDAuODt0dZscO/e4AnHkhhNBw0mLTDp6pm+oBG3xRmVU606y13S/6HYgQy+wa2od
 7DQP2E3kJZzVyFydDcnXRJpVs7rwJ6EZdixe3rHZpagj6mWsgz156FJiJqOEY1SdQCYUrSnxkrY
 /GT8tLcfwhJ5kgww6mBr+Z+ZhJpvSNEDJk7BsRR/BQNxxMiIfCCVebllT7REvik88S3LHpf0J4w
 x8uSFZrsLEkpkskOIejzuZRN9YsWzqlmqhLMLPUWhV1MUAJZhugOeHax87f3hVf9FuNoZuUII+s
 dVE16yRQxOrMp0ThWg62pwSlar+sUwDgJgcJR+8P/2vnE4K0IMkZ82S4QtZWHd2UKRwML/fzCI7
 rk32WtQDbKRX/RF5fddPtTO3/z9GgIM2+Z8PGeEqS/5udfowACbFzVO+HRRybw8HWyee+6VnWbg
 cc18x5LSRJ+QJQLYhRuy883geudXEmS+cKQ==
X-Received: by 2002:a05:6000:2b0e:b0:48d:eae3:b9df with SMTP id
 ffacd0b85a97d-48e6e50c88bmr17458646f8f.35.1793626572982; 
 Mon, 02 Nov 2026 05:36:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/47] target/arm: For linux-user,
 prioritize PC misalignment fault over insn abort
Date: Mon,  2 Nov 2026 13:35:20 +0000
Message-ID: <20261102133547.1375701-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Arm architecture requires that for PC alignment fault exceptions
take precedence over Instruction Abort exceptions.  We get this wrong
for linux-user mode, because QEMU detects the lack of any backing
memory via probe_access_internal(), and calls
arm_cpu_record_sigsegv(), which always reports either a Translation
or Permission fault:

#3  0x0000649548976b94 in arm_deliver_fault (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, mmu_idx=0, fi=0x7fff87e4c940)
    at ../../target/arm/tcg/tlb_helper.c:274
#4  0x0000649548976d69 in arm_cpu_record_sigsegv (cs=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../target/arm/tcg/tlb_helper.c:421
#5  0x0000649548c97650 in cpu_loop_exit_sigsegv (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
    at ../../linux-user/signal.c:761
#6  0x00006495488f8235 in probe_access_internal (env=0x649555ce99a0, addr=1, fault_size=1, access_type=MMU_INST_FETCH, nonfault=false, ra=0)
    at ../../accel/tcg/user-exec.c:790
#7  0x00006495488f850d in get_page_addr_code_hostp (env=0x649555ce99a0, addr=1, hostp=0x7fff87e4ca70) at ../../accel/tcg/user-exec.c:828
#8  0x00006495488e5433 in get_page_addr_code (env=0x649555ce99a0, addr=1) at ../../accel/tcg/internal-common.h:116
#9  0x00006495488e56bd in tb_htable_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:206
#10 0x00006495488e58c8 in tb_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:251
#11 0x00006495488e5d2a in helper_lookup_tb_ptr (env=0x649555ce99a0) at ../../accel/tcg/cpu-exec.c:398
#12 0x00007d973c000270 in code_gen_buffer ()

Make arm_cpu_record_sigsegv() report a PC alignment fault for
MMU_INST_FETCH accesses to non-4-aligned addresses for A64 and A32,
matching the logic used in arm_cpu_tlb_fill_align() for system
emulation.  (Unaligned PC faults can't happen for Thumb.) This is
then passed to the guest binary as SIGBUS rather than SIGSEGV.

(The Fixes tag is for the commit that introduced this function, but
the bug was also present in the previous implementation.  It's an odd
corner case so it's not worth the effort to try to backport the fix
beyond that.)

Cc: qemu-stable@nongnu.org
Fixes: 9b12b6b44250c2 ("target/arm: Implement arm_cpu_record_sigsegv")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4699
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261026140942.2768950-1-peter.maydell@linaro.org
---
 target/arm/tcg/tlb_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4a1611f23f5..9543e43fa99 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -418,6 +418,10 @@ void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * For now, it's easiest to deliver the fault normally.
      */
     cpu_restore_state(cs, ra);
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb && (addr & 3)) {
+        /* Misaligned PC faults take precedence over insn abort */
+        fi.type = ARMFault_Alignment;
+    }
     arm_deliver_fault(cpu, addr, access_type, MMU_USER_IDX, &fi);
 }
 
-- 
2.43.0


