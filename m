Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44112C44502
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEc8-0004u3-J5; Sun, 05 Jul 2026 00:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbr-0004jx-O8
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbk-00040c-7O
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cace91f112so14395205ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226250; x=1783831050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZQKYJz7acBPOxECmB0e2sZSXiKoHybMCyGFRMtMCII=;
 b=sqhNxoj8k+CLsjNrmNVmomtCDg5wmJjD2CKQh+ce1mjZJla67B/4bFMtHUZb7Urhn3
 c2EtOsKi9nkylEIM9pgAGNqG+kjM27xu7mDalt8UOHLJLZBCY0uxzNpZXZHmDoemh+Y/
 ZbtOYKqK6TsLFpfsT9Kw4FXIutsqxd6xU4yEutE6kLCiWUq9OC1epeOSE1sOp5FjxBJ7
 fwfGpQRqX8TWEkL8M9AkkCTjpSeH0w6CCSQ17TJAe79BaaOsH5Uq7p+hCP+ZDgihBqw/
 MXn+SBm4GmLvo5zVYryTJnDsezahqF8JuefSgr7Y6/hkpIwD2PXIMbVZXGTQ+E9LDxty
 Pysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226250; x=1783831050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZQKYJz7acBPOxECmB0e2sZSXiKoHybMCyGFRMtMCII=;
 b=WGNXUCb0I7n/RkR5rY1ZB8ARbeGhSVgeZ4pcfErcw6YMjVlexGFPmQ9wnU/3w8biu9
 gwrBt7PfzXTZupmvUsGjrNHfUPu8Fce0AZEg5njupcORHZP8syEsgzR+ajmqAyn7grJA
 4JzRIdqKK/XOD8D8scafKiXhfDBYdYcQ4Bjjo8M/5IlSkCq1dnl8P09+92IXvHZA4MSV
 Ta8HqboD8QjiikQ9+KqguCnoiP60kO4r6JtSdLcc3nLrTRCPhM73meBYKN+zWhmzt5ha
 f+tjD5P1Aq7+i/urW7rvDSQ+FvcYz4a+dKkna18kNBMbHnMLt9g4VUF4rq4M3uUToq70
 fo4w==
X-Gm-Message-State: AOJu0YxUNT+LsYVjtdXI9TaP9GIttl6akourAwzdXChISfnBIeIAB0Ln
 CUArNY1rGVPP1Jce8dvkRmLYB7o+ObIQnrmjbhcqsnGT5B0AdBTzfkikfml0DvN7UFdKzYx2Gsh
 M/z2H
X-Gm-Gg: AfdE7cmwErLtuQT1+N9DTyR6P8kfl1X/Bv54tBY0Pnp3Ux8IFHqgxrr7HxW6U2aPTfd
 cSbnMcfrVKC235sjpIjLn9EDEfjVb2bn+zqUOOrqJF0WSRWpJH3zhvlcgeS4r7jUdK33CexnzmS
 RfsBQvqM1zhIMgk6jWRMzvERaQL4MT9XwITfDz6fi3Bq84yGqjAH4YbpO1XQuF3cme1Ym2jvnLh
 PyMKPvv54PutniPK3M9rcQVy21AZr7DB0nI62LnApcmHFQIS4oE3aYgJmVZkwJKvtdvMoeKr7n9
 pFZ3MSo6+OD3K/M4p0dpM4DvgdhfxvuBcee+zaan1Ha2HNOvS0mMOJoRm66LFadxR2WyQwLZkor
 DZW+ANWJO6mCICxKpCCpdJXtb80odv4E7356E0cgx1nZkWRzk6PpSzzDMHuX2jBhKLv3mLrvXHR
 V3EW6XtJNKgGkNDHjhfcQDVI2ar1BPhUb5VI4fUkC2ytAQx3w=
X-Received: by 2002:a17:903:2cd:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2cbb9eeb474mr51328895ad.42.1783226250405; 
 Sat, 04 Jul 2026 21:37:30 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 04/46] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
Date: Sat,  4 Jul 2026 21:36:43 -0700
Message-ID: <20260705043725.1373137-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug facility
for v2.07S") also implemented TCGCPUOps::debug_check_watchpoint for
PPC: make the comment generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260630220100.1289-29-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f64d94b2b5..568d82cdd3 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -250,14 +250,13 @@ struct TCGCPUOps {
                                            int mmu_idx, uintptr_t retaddr);
 
     /**
-     * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
+     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
      */
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
 
     /**
      * @debug_check_watchpoint: return true if the architectural
-     * watchpoint whose address has matched should really fire, used by ARM
-     * and RISC-V
+     * watchpoint whose address has matched should really fire.
      */
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
 
-- 
2.43.0


