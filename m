Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444BFE8B381
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOZ-0005yO-Hc; Tue, 03 Feb 2026 18:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOV-0005y9-3M
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOS-0006Av-Fu
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483100e97d8so526325e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159670; x=1770764470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fki7Z7lvkxs4LTNUjYTuJYA3h2xrMJ2tqxVaedVRuZM=;
 b=C/nLyhfB1B9yjff440lEqhFQnsfW/zj/x+PkPCEBvGzgc6nM0oGXGyk+FsaNrsOtuc
 Jj1unOTfJOFJE86TYR42LAPKQRD0OdDv4JtQcpm85baGyQvVTqyc/qT0a1OBomnuoVex
 pclwr6Z6v8pTQZY2pF/y8lvv/dD0vcQZ5vPOkgXcfUzvW22RpORaHoMy73jnCCaHEjU0
 wgdnpZbT3a2xiY8+IIPoxU/aqvRo9XYMg/Th6GCi5VJuJbW7p6DzifEiNHpcF2gqMD5z
 7FHAOQ7Wl++G1XyqpZtNnkGs3kLY5Wcw2oqfgIUh1iykWmA15Sgg5w59CZD4HZKCIxk9
 BPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159670; x=1770764470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fki7Z7lvkxs4LTNUjYTuJYA3h2xrMJ2tqxVaedVRuZM=;
 b=K8nYtMSpcmEzl8PCIZ8jTXzNyGB9ci4zvREUalPuD/ZkUbMP7bgpCRYGnoBHF2zSjh
 a2TydlCjFWaCFCy0uf8jUMwnp5DYI9rBT5Ac7WasSxSeq/RPLXO36GWhqcll1HRtFLCw
 hPcnXVZq+ugRh/WdSzlHFjmFBa2YgSsi6YCyjxM6OYIiWdhO8VN/mqmrpOdGMkp6FU/K
 JdOCVkU4Eu83iaOacoN6BRIJhDa5DEBt+FfywGs6ND9AvpCTD7LaxNkkNDl+oc/DNjaZ
 1SJfs7U7YDLrPN73NPbk20RCFM9jJvP/c3zx17nn40EEuYI8zaQrRAnZ4SU9SZ/ILBq5
 If+Q==
X-Gm-Message-State: AOJu0YzmRddhJL2VgbB4P59TQrDRuPKufkj5iWO2R4326/5wySj7sRNe
 UmyASwhr0xnZvL1NPW+VjMpYqsoEhc6AYR/39LXmuaTtSsikvaJjQpmvem1n9+MHuMHL4QFW3Ff
 8FVdDOME=
X-Gm-Gg: AZuq6aJfvjM2H1PJp6pKw0VITTRsz5pQs7xst2gimLTm91/pHh5QbBu9E7dk6PuMpwv
 HocyK6OulYnRfBoVCwLQmQ/GpgHAgJQjqgM4gbzNWqjshOUBjzLywBb8LXcS6YmCcHb1LM0ijrl
 rpB72WEjW+07p5iA+88LAbAE7bA4tnpuo+9wYzPJJCrWYqS/5vJtTpuzgTZt1tIXeH/yhaggTCZ
 mN/dZX6BYHfGaUk31CWW8GdsrlBW7VVvz4CG90uItSblONVO7heavLoBX+BTvcqH6LFpOTi+b3O
 rgliHoSUQ3OLIZkuWjuK0drbFN3X4mKLQkqh4n0lB42uW/g5MFX26CWMjQWFp0kI/5+p8Pncval
 nrUfp44IRbGHjoQm0L/5EjQYz8fAg3+RgVRVi/wVanx/rORvJd7EMWvQ0E7ralxhl4HxYaqA+YV
 oGN1twkutxZnR4fLQ8CHjmtw1IXshDYV8PqxubW49Eh03+zkMLNuKOfdVZrbZI
X-Received: by 2002:a05:600c:c4ab:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-4830e9795d3mr14357965e9.28.1770159670552; 
 Tue, 03 Feb 2026 15:01:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48310928f1fsm1291235e9.14.2026.02.03.15.01.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:01:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v4 2/5] accel/tcg: Have cpu_ld*_mmu() methods consider the
 MO_SIGN flag
Date: Wed,  4 Feb 2026 00:00:51 +0100
Message-ID: <20260203230054.23667-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230054.23667-1-philmd@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sign-extend the result when the MO_SIGN flag is requested
in TCG common CPU TLB handling.

Remote the SPARC specific handling.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c         | 37 +++++++++++++++++++++++++++++++------
 target/sparc/ldst_helper.c |  9 ---------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 76546c66515..97782997881 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2296,12 +2296,18 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
 {
     MMULookupLocals l;
     bool crosspage;
+    uint8_t ret;
 
     cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
-    return do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
+    ret = do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
+
+    if (l.memop & MO_SIGN) {
+        ret = (int8_t)ret;
+    }
+    return ret;
 }
 
 static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
@@ -2315,7 +2321,8 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_2(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        ret = do_ld_2(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        goto return_signextended;
     }
 
     a = do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
@@ -2326,6 +2333,10 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     } else {
         ret = b | (a << 8);
     }
+return_signextended:
+    if (l.memop & MO_SIGN) {
+        ret = (int16_t)ret;
+    }
     return ret;
 }
 
@@ -2339,7 +2350,8 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_4(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        ret = do_ld_4(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        goto return_signextended;
     }
 
     ret = do_ld_beN(cpu, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
@@ -2347,6 +2359,10 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = bswap32(ret);
     }
+return_signextended:
+    if (l.memop & MO_SIGN) {
+        ret = (int32_t)ret;
+    }
     return ret;
 }
 
@@ -2360,7 +2376,8 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
-        return do_ld_8(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        ret = do_ld_8(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
+        goto return_signextended;
     }
 
     ret = do_ld_beN(cpu, &l.page[0], 0, l.mmu_idx, access_type, l.memop, ra);
@@ -2368,6 +2385,10 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = bswap64(ret);
     }
+return_signextended:
+    if (l.memop & MO_SIGN) {
+        ret = (int64_t)ret;
+    }
     return ret;
 }
 
@@ -2396,7 +2417,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
                 ret = bswap128(ret);
             }
         }
-        return ret;
+        goto return_signextended;
     }
 
     first = l.page[0].size;
@@ -2410,7 +2431,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
         } else {
             ret = int128_make128(b, a);
         }
-        return ret;
+        goto return_signextended;
     }
 
     if (first < 8) {
@@ -2429,6 +2450,10 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     if ((l.memop & MO_BSWAP) == MO_LE) {
         ret = bswap128(ret);
     }
+return_signextended:
+    if (l.memop & MO_SIGN) {
+        ret = int128_signextend(ret);
+    }
     return ret;
 }
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 3bc6a6827a4..e1178e53d51 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1163,27 +1163,18 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
     switch (mop & MO_SIZE) {
     case MO_8:
         ret = cpu_ldb_code_mmu(env, addr, oi, ra);
-        if (mop & MO_SIGN) {
-            ret = (int8_t)ret;
-        }
         break;
     case MO_16:
         ret = cpu_ldw_code_mmu(env, addr, oi, ra);
         if ((mop & MO_BSWAP) != MO_TE) {
             ret = bswap16(ret);
         }
-        if (mop & MO_SIGN) {
-            ret = (int16_t)ret;
-        }
         break;
     case MO_32:
         ret = cpu_ldl_code_mmu(env, addr, oi, ra);
         if ((mop & MO_BSWAP) != MO_TE) {
             ret = bswap32(ret);
         }
-        if (mop & MO_SIGN) {
-            ret = (int32_t)ret;
-        }
         break;
     case MO_64:
         ret = cpu_ldq_code_mmu(env, addr, oi, ra);
-- 
2.52.0


