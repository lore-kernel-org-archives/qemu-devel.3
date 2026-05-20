Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A28CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgX-000156-2S; Wed, 20 May 2026 00:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgT-00013q-C1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:30 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgQ-0003mS-DX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:28 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dca4debedaso4640246a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251844; x=1779856644; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=pD+eNCmXC61HtH6PEx0CRy3Ts2rGe4UmnKYrgdj0GIbXSWrj854NbA6pK3hsLxvau7
 tmE86bsZ5xjdOt6ZsjbNt9Q7x7W/w8rdEGhIWBAxR0chfpkgWiOnjzAawZ6Q40fcRgkw
 Axf85lwt809t2zOKRmD8iH5JDHQTw9Ci3RmGB8K4MKxR95j2LnIaTcDgMrZ+jl6TjoDB
 WVlOtku2kDT1+I8ULjjMSoT6997W+cY1fJwOIO1E84oR15lPyKhcicLFHhQvlTX9bU7e
 kEzxxJHb3r7LQ67TQ/vD7hmHPW/MykqHHn4VwzV/f8QS/PIrc15dhNtiD8Fhj5Jkk5BU
 9MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251844; x=1779856644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=TkdxnURdFXyFOwFOpqbmLWbaGMqxqoVLQLaqwVKBMmrSauRGVjF6ZrV+Wp8IuTb0PV
 dpoGN2/Gi2AW3AFmxEZeXOPfOnBUWqZD4hlLoBbBa9PHbvSWRwJqPEknQXIuqVGSatvw
 xCGQWFQsn0yUHpgseQb+LcZgh+3wV4++jcPnmwW+/fwhMXnvVybiUtNfJzyjuzmNXUkw
 BZFD7Lh0tBa4bt+RwTusgLq86PMTrEbedYAklBeCSDwuwfaAA/5uP6PM/mXMaY8Ue3QB
 McYakePcEe1U1blZrgnJCNNr6fjaMUpYpl6iiP6jp5pmvOo7d/mHd/YB1hTmkoboyUyR
 iU4g==
X-Gm-Message-State: AOJu0Yxn4oEtgKZJ1OQZjqDNzkxUgiU2bLXenR1UsqzYUQ1rMlzyCiOR
 Z1bkMpDuOGsov9/8bwZdl2/LTzKdVFqpmCODx017JqlJZKkRl78iCEp+
X-Gm-Gg: Acq92OEbDVMzE9Zc1WvpgNq/uche+sbcQ4pjGR8DvYBnp+sYl9LrDO+JfEyRD7vTboT
 I5o3If7FQcxWDtOxIMrVoYwz9eQ1ywoBISmKACxL9EV2j9cj00r2AccAJ6hzttrSutL4253s8gK
 PV+xePQt3a5FPeNodO6rs8Vca2rGjpOupXA6TuOitu4BbTyKRaGfVeA2qrqP0vdYzRtsrTTnVdW
 BTcWZ7xNtpjnAyPEcuKW18vHYa+xJb6PE6cgcfbaxbQveYKySwUyhZfK58m1npkzfWf6kl2WTCh
 SuUVFcB5v8suGPO8MjjILXxJX01ZfrJXrZiadTsxeFbdoxRHytE//uNsATiwQ4epcEa2EkZPkvM
 bpPxcSPUlTC6hmDCbyfWSBVtNW96jGvgIbUCg34yd5r4sN2L7vaiyZcd8TYLyy8YNHnARfOaa71
 CTYufCrkpcu9N+H7hoDCTb73Gd+wA6QdElnmzN4JJMLRtWQ1njNPDx+769O7+I4Zog3WK7tRcvR
 j5sqsKmieuTToIhMk/DpTPn/4cTW3n6YHInLVLOrHY1EJUZFF9NyRvpdmEU7jgH/e8K
X-Received: by 2002:a05:6830:4704:b0:7dc:e090:68a with SMTP id
 46e09a7af769-7e4de651649mr15526334a34.0.1779251844066; 
 Tue, 19 May 2026 21:37:24 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:02 -0600
Subject: [PATCH v10 08/45] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-8-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 451737cda1..f897b42807 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


