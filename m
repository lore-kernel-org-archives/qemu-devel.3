Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A46BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBFg-0004c0-Ed; Mon, 19 Aug 2024 18:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE7-0000X4-N1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE5-0000gk-6d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso38042435e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107907; x=1724712707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Es9COWayATyZP7U12SucfNzKx1xwYMI0HkJSQW4xD1k=;
 b=m8STNsU3p9+JRGwnJx3GppyTYLlx0aaYXQcQGA9d+mLriJYej3mNZMwHUNeKfIw7g1
 e8i2CkAgGfyccB8FftBvJ3riauS2mDka/VVJ2uE+3bDxBJIG5XidASx++DKZtrpDnDNQ
 je/R+xjR1tfgiJL2oUShtJyLDt5b14SN5FzH6bEVeqStn/+H4sPZ5Q/x52C+HAjMUbR1
 jpTdsZMYnHSNEObFF4gYolSztBXBfNMHKNNNc9NH8+su4sEhBVyX2QOiPjXXW14Og6JJ
 rTZyVDy8U/n4CiWFMpnFl3Pk0qMa0+fJyfALACDa7vVV6XaPEt+chJ1yN7GodAu0sHo8
 h0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107907; x=1724712707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Es9COWayATyZP7U12SucfNzKx1xwYMI0HkJSQW4xD1k=;
 b=HtKCTTDqbtvn4DMSVHMoxAYRrr9Ur4C11dOHiSJvoe3YCb2NAMC1ERIfmfEVMOOchN
 EeVhUFUQQ4WhX8W7SceVWVeQKAtqgAZstWxm9aST582ipCBI8wzVXcfRX+vZ7lp4N1E0
 pgnyJDt88u2bPt/fQ6yRkk5f//9waGhg05wC1+DQBuOF76Qt2+m/dt33xdgu3OzNUtwm
 r7mdTRJ2Cbe1DUDLb534Mw+DSvA4iekSjA1kDFfSCzWiea8I4iNSrLkPmJaXsMWEuTKN
 opWYFtMTNZJhehfj+wHjq2rkY81N0o5vp0e4XhZ+u9CY4gIER2yaO4/r6PeZ2OneJPaM
 2Syg==
X-Gm-Message-State: AOJu0Yw4uDgruPKn9m36coUzszOFIk1rRWc1AvD2L2a/KrYShK/SBmyy
 2qg3lktH8ILNT3sLvS8IM3GcifhEcPzxt02dkazfGzoB6L4vHAW+re6gpxgKDRxk7OjiaSevPdm
 r6pY=
X-Google-Smtp-Source: AGHT+IGEuiw+9T9LqSLNqWovnBMjgvUFgPm/ifS0/aTdLcW7r64oYbCRfypl8KIrQUXYQExv7gcktQ==
X-Received: by 2002:a05:600c:a45:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-429ed77d75amr74890135e9.3.1724107906636; 
 Mon, 19 Aug 2024 15:51:46 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed79be15sm122097625e9.48.2024.08.19.15.51.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/20] target/mips: Load PTE as DATA
Date: Tue, 20 Aug 2024 00:51:02 +0200
Message-ID: <20240819225116.17928-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PTE is not CODE so load it as normal DATA access.

Fixes: 074cfcb4da ("Implement hardware page table walker for MIPS32")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240814090452.2591-4-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 0e94e00a5f..3836137750 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -603,9 +603,9 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
 
     oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
     if (op == MO_64) {
-        *pte = cpu_ldq_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldq_mmu(env, vaddr, oi, 0);
     } else {
-        *pte = cpu_ldl_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldl_mmu(env, vaddr, oi, 0);
     }
 
     return true;
-- 
2.45.2


