Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22874CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYX-0007AP-Th; Mon, 18 May 2026 01:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY5-0006v1-5Q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:59 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXy-0003TH-H1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:50 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c35be02fdso596538b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082171; x=1779686971; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=SncWpZPCtUiSiil+gOB28mLFzn+cvVXVyr6V/FUTQeAX9Whu1FBM3xlEtbL4O9uXd6
 Xh1PUosdKmvUQhostg7c9cY4YfnNqsEcz4UszfYQ4E6e39YeY+qJuTadvnh/5CgHTI6/
 jHV6NtS6W0nTFs0CUqHJQNNf6Jn19+/NC0NBaxKjz0U7/EIPuSTfXjVg7XSeMxFRTwjp
 zMGjDowseLqWnUNAVi4nFB7FBcOhAQcX1mQT+GQzgFR7sZkbzd3207kYIgNdJMTUzyyb
 rXQWvZ96eWImQHH2lsvhO0YXZiC5+VTjGQ0+2DgMyHDFE6vg0B9Ixco98db3d1+gJ/+9
 5/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082171; x=1779686971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=GfgrfBzMzefS8IT2waAbKXHWZmIqUcgYQMX6l4mA572z1pjlMuLYOqz910gLcQfX/7
 7glyesXutu7JCu313xdeSA+pR8h6OpnEFU2iav6Bv1Y2pD4d6HnY+//r/neTk7w6Bh4A
 4adKW5KInPkEjIRBls9hlH1tzE85rZmq4eEURuKbYSpBU19ttOX3luq6atupTaE1Hzo8
 x40WF8z8f8yu1+B8TqjeyBf0aN9AeCbbUhkYi6Q6IrCEx3GoLF9pxzwsRPY4a+YLyqDE
 jdwzVZKEDbWq+S4P9J8gh2Kp9gcb6HMwQieQz3UpkLOkIO7NyLNlwmibQyWjUJPE22M4
 +SBQ==
X-Gm-Message-State: AOJu0YydS2uCAKX1G0w/BoZ1v2my9xpM3oP2XWXnt7H2xvrzrtiuMwtN
 POvYSS0uqmBnt+XPmyCjLXmnmt8XPOty8qHPVOTmilv9jMMtxaVd1vqK9DIR6g==
X-Gm-Gg: Acq92OGHvx1DkiDFA2fRzavXFOElffItOYvOXgYosy5j0kgOCmgIomXEXTmSsD6FWLK
 s1flIsMrOq0uuDSytOgPzrUDuv6hXDeaWQ6rNdg8OsnmtHPU2thz7zcuotiAQdJr7YC0YYqAuoJ
 E1cmdIO+Nnvtc4zzCEMhCL/oaEfY63chlKMGTrkcRs+jlB/pcZYJM0LC9QA7ucGRSbGzZdlsFzT
 V1R3sX8FKrgmNiOsRwBfw1v1Aw7NWCNrIoTGkEOTwWjA4U8KoZ+jzMMYkVFEiEHkZMCaf5N1hxg
 TESiHq+1YgfzYSLEfB+87FpE2V068tFkkrcG7ejKD2rIB3ozpOZlwGjb3PZIfIxygPWlJEAYfBI
 oDx/0jSW579Yw99+EiVOPKjyJt9zb9sqTKXL6JtY7CvkjoP17vAaYRzhGEOjGV+XkI/tX4WuYJl
 LN5PITJS65zNiFxQS5b4xAMTgOp1AuIsC9Rna025sYAJ2FxfFviIrLnrAWZVM+iXrE11vVgR6Fe
 +xu/Ck1BKMj8LVabguiw8TslhbIxh0upbGX1iL1RBbBiHbbhFR/Ly8LsgTFjrpYBAxVDg16Pg/u
 mpffbg==
X-Received: by 2002:a05:6808:5282:b0:467:2509:c207 with SMTP id
 5614622812f47-482e5644bd6mr8554978b6e.17.1779082171089; 
 Sun, 17 May 2026 22:29:31 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:06 -0600
Subject: [PATCH v8 09/35] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-9-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x231.google.com
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f897b42807..401c4bd14b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


