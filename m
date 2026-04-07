Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554B3FB5181
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAp-0007d3-F8; Mon, 06 Apr 2026 22:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-0007aK-KV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAj-0006zT-Bm
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso22193885ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528887; x=1776133687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=KRqGm/dWZDDpY/9ofEB7r9nJtkNgktG1QY/hR/sQdx0gRoQBMgXaQPYpIh9IBfqJ0g
 3/ct7ejUDn/518Bnl1cUohrM7OQj2Lk3Z5Jw+yMFNGw+yGIWcSJ+YZ9fE+ubRiTZzZ6P
 WU9SV1hTnaXZRI4d86pUOh3Gw2bsqIIyFH7ZIZdphQW5D+EYIk+O4DAC296crSQ0+lpS
 Pjp4T8Sixd1PlpTW9+hk2yGPN4fBsrFkffeLmsF9x7s/pWjaD4dv69xica2PDLCXzqGB
 /FiaYjIy22im5QVkkzqYVysitSS0erATJScgvNvA0KspvbRzxLocTBduiljF8JI8X9Ha
 1qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528887; x=1776133687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=qSIkmO2N8/Aycuh0h/9xBRw3hCxn1wGteLn8FvHMBqIWGLcrczdxHsOQMJktP9h8XF
 2joo+6A0xmbCywWS7LstGE/eDFY1wDkT9KvaUZeKSLknGg2hw7iIQ2Cgj1QhQCrxQSI6
 Vf+3dAVyXQTSog6MzTfMkNa2iBsEfD1ImCLFwS6VTenJblc64n4H4dXWYCH1XpnfM7vb
 eumS4BlFI7bn+uPS+g0pQYoED6/35vC0AQOA0c0nY2SIyZiLWQLVcO2xhANUdcgvxRS6
 7ZdrJNYT79oFChr8MHnKruRgQHAMfA11qRnwqC3hXVMgE4gIJWt2EuAuE5qtHfhtQ4We
 pqdQ==
X-Gm-Message-State: AOJu0YwbgnLRga5QYLU1beRqF6oKTwte7YWgqWGhUIqJkyRvVrGwCng1
 q16/k3T9+UgauxIXtjY2gOHFu7urlFUIbfuFbW1eAEyhccJSMVOTDoABQMnbyGTiC6BBy3blDtx
 jwe4IRa60bA==
X-Gm-Gg: AeBDies4nEjTJiXEg56HO4C8rXI0in4T4lJkBSN8jnov2TTlYBMqno09PM4AH2aunuP
 rPSBkxYuTiRvYsKszkPUM3T93f3/tqaLJf8oFuRhO8wJZTkmyUyts2Lj8R5libCyoMxEV/3JPnB
 ndhfyuljrXCK1FAXb3yfntmIcNQMuWcW4tNHWxYy0TSGctDNEAjZ+ySEnbaURWKpuQZYI0ONdyP
 qdVnfzO7Zb+c0Q92ufeAGemGNeVbizEUTXgezU2aMuUIwmyqHM4bb41nUS8cBdiwVjTHyCoa1g3
 O8QcuB0dSD5K92LBy6Fy44Gm7Mz3+T9bueCDbLHF4Ls9eIPn7HOXVeyDoJ1Decd9u15tZ8sVZ2k
 eY4y2yfhB/nVrE0EEk5q43vtxk6o62DMGId9cE+Wwu2CJCAlzm5wxEN/2Nmx/u+I/Z/oiWlJPhz
 G0u7UxbIkCZDI4ZeWNJWs+rjRoqtsd0BuwFSLl4ygBX8MP7M082GcYJo10SqdfMmIwERi3LlH8B
 4GZ
X-Received: by 2002:a17:903:3c47:b0:2b0:b016:773f with SMTP id
 d9443c01a7336-2b281803f15mr160764785ad.11.1775528886663; 
 Mon, 06 Apr 2026 19:28:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 12/20] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Mon,  6 Apr 2026 19:27:40 -0700
Message-ID: <20260407022748.57629-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


