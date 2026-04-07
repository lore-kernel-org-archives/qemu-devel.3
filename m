Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD7DFF5139
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaU-0004Dm-L7; Tue, 07 Apr 2026 15:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaQ-00047D-DF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:46 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaN-0007Ml-2v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:46 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so4767226a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591981; x=1776196781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=OvgSskHyrFAo7vVD13+5O/NeA/DJSo+Gnin6rpBayFm69yjKXBd2xOH4i+vanf9f3a
 yPe7OYYuIpiIj0JYMgqoZLXcw/DtGcDBREIMSoarR3ANtDd/YMumSqD4c/PJvWPOe6dV
 qrDeXahR+REtgIK1mj357+zyrNldHAVlwjILAHMXQIDjKmoY+zJ6ynuY4yc6LWIDCbBf
 wPML3kWg8B3aUuMmNOyilHrabtU0HnMgAtsTllaY+bmmQLTyI4MdqqV7qleDABZ7swYv
 Ni9zKO1A6gPDdeOKaV5AYG1L54AHsJfbWAxqwJB1/AuxAIlAvVXCR9ZltEoMZUMzV0Qw
 ePLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591981; x=1776196781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=S6NdOPkX9x+6giBA0D+LV+McpDcRFK97LWX0AKYUg2mno3HrxnhZityNEi0yyQo3pX
 PIvSzvVKhdLe8Q0HWMP1s5UZOFBTxH5jDMyH9PToOfAWhf2TsfMAnUk7L+/lx5vwUAeo
 XAxgfHHa4CrWtSK5CRWE6uZnZvVqqReQ7T4GXNLLScu11EbXyX+m/nqHffeYEI3L4yx4
 NxAMz7iazPxWgOXdeA7J2tkGLd0EJ+21dVksr6OG3QJ+CF/bXSfqHGhyHvWOU0vWNkns
 pHOElW6Ct8qtUIEoRtwK8AYde9wWymNPGajT9ngPg6XOOl6yPV3Y7aIxQ7ttHwZ080Bv
 lxug==
X-Gm-Message-State: AOJu0Yw06oOZzXx+2tpg81QBC+PZd/IBO1iBYyaYYRFNUT1GAJ7NSCKf
 VLH5at5P09AyeCu9/mLJjVAHWbwA3u/rQJFjMxqjj/mFSO5ztRAK7nBbygTHOPwIijy3aIAf7Sa
 rpxJ2uSU=
X-Gm-Gg: AeBDiesI/43iYJnFzFGpxXrHwTgPNyC9vGfpcobNYwLFr3Y0oLCMuySctZnygffoc3X
 7v/IU2R8cICSH8O8DANtPgcNMD/3siy3up3oetAzgX7CyyF2p3Di3sp/DHbmIK6dbHaln2s6R4H
 cAdYpz5MwfNYXMAYK95My1sNT+TUmK4v46748r3SV5yjhJL1K8FuU9AA1FIbbkErlpRjXab21F0
 u/e2CVpI4etb+6991+sKsfKH3IV/Itk6VYQEhMJ77EG5h3os9ffO81lU2Oaqm4m+TRD61vTz4MY
 uTQ4Z8cwgs9e8DHSbrXp5QRxWIM4flj1GbcthZkZdzd4s+Ni65IIkKbuu5cifdpSAk5QnJKsCgY
 sGIgdInCuArKxt1KZ4n0mOvcjlEQ+NvVZZxh2wHKtC0Mj3vlYvLS0EcsIM7eexz0v0zteTfpeQa
 Qknvatlp9icy1+R5niNQBXTNTD0zSbnV2wWKv/gTpabp2Cph1Jw/eM/Da3Ft+zcdJ23GtV8c9Ct
 Hkg
X-Received: by 2002:a17:90b:4ccf:b0:35b:e593:b1d7 with SMTP id
 98e67ed59e1d1-35de6825f04mr18260026a91.12.1775591981571; 
 Tue, 07 Apr 2026 12:59:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 12/21] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Tue,  7 Apr 2026 12:59:13 -0700
Message-ID: <20260407195922.196410-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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


