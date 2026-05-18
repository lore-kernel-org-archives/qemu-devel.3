Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25985CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYO-0006zs-34; Mon, 18 May 2026 01:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXw-0006t8-68
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:45 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXo-0003TA-5o
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:38 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479d593a0c3so1599476b6e.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082170; x=1779686970; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=Xk3aim11q3MCyDQIRib6UDYQPPNG2kyePRIjDgyiJZLiUSm+XA3BlFSwOgV86IKMR3
 97VLDFNacHgWjv8aEsT9Ju8WQo2jKKoNHIqSiPBlmC6fskFQ3zvb686RZFhg2KiZiHoB
 ouyx5ubi65TMcI93KhVxrcN1qgI9uvdcM8z49PBW7ixnGFdqqhsUSkiNi4+UHcl7r7Mj
 fhpFwyleRJ0o0dbMZEFjrR18va3mW7ZmABUHVNN0YN/3mgD0Eg1X8SMQ0KfG9/LPY2eJ
 ohus3nsfiHtIIrlby5vqCQhd+cJNrj8qTw+Vk04wj3uX+BSWr3T5HPUZ6dllFFydx+12
 ncVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082170; x=1779686970;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=cZmeTfhiFkTtSZrO5C1QWMnHRrQePyMJgNbnxwUEkX+IVXu4qNGvse9ViDHQKHemhB
 BImotAkV2tobQV2+pbsck1e4udNt/iEdNhz9iSKsAyTxs9EtoA2IwjIPAdVE86Na0+d3
 gNdv6pOzc8X2B2uvVl/cadiIuJfqpQIFxaYZ8le5gJ6K9xrSezH4tJX1ZpyDAjwzzNP5
 JMnNXSRVN3ugcU5FnxF1mFOgM2ULiroG8xMRnWFSZBOis43ePuymayQuuyxCeUQYiAgd
 ouxmk4xZ9VIu1ld4RicZWgNCIQWdQHhmI84s5QsuAbvQyUszwFGemZkuacXSTPisNQ85
 pD6Q==
X-Gm-Message-State: AOJu0YwZ8GaLdHLF/y7NBIILI/5M0ZZLDGRQXqo/MBP+hOJTNz0LTiND
 c+4G9hQLAd0q8fEOjL0NAm3AJ/k3XQtAhIUjj33rXyGrzyD9mxVlXPfr
X-Gm-Gg: Acq92OHrG8MzchMP1Fv+IKrSL0aORnGkqr3dc5Gxjx9XXpp+guShIqQYKGZ38oyv514
 Hbev9y6IZmHhyPyx5HXmLH6BST06qbU2Lgj+taIVa4IEHZNUSKeLP2v+scNHj8oA1Ko3nBlx7Do
 a9MxBuUHND5q4lo3JpAs3QCkwPe+GiP5usAsfT7P2PzhslOVkPNc7skr17+YKYf9K8rWM8X0aAu
 CwJ1JP5uw1g+NzgzS6nXQ/NoAhqg0q2i+HyIp1rLXRf8+nlBXvShpJUGeBOqiam0YIwDnBrHiQA
 Ndlg5Fu+YsGyu8tqL9KB5IBUglGoqlIsyhqVv5OvUjM41ayFoCrTdmVkX2K7OTSqvpVF/ngWawK
 nIlYkbO0YdKlRVowfF/UxzFO+bxn9z/jsRZjnLwxSh//nAMGfW3GXI57+pwCGraAIdNVjPiNgaL
 KwtCBRT7dwu5r8olGH4ZyCzukbJjbqnEZLV7OVI1WBGpgiWeYO3QwT2exrJx6RnloQy97edgu6F
 za6Tjj/wLn6pe23V/8Th1FIzmG/2qcbhWW7KhQccOjKMJlE3/QzgLE7SNC20C5phXBiwWQ=
X-Received: by 2002:a05:6808:4709:b0:482:6ed8:e183 with SMTP id
 5614622812f47-482e44fb4b3mr7892520b6e.7.1779082169796; 
 Sun, 17 May 2026 22:29:29 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:05 -0600
Subject: [PATCH v8 08/35] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-8-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
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


