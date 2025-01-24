Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FF4C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgq-000785-OI; Fri, 24 Jan 2025 11:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZh-00069U-63
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZX-00064S-Oh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so24616825e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736214; x=1738341014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oV62nQbavYpaLNeL3j3KFgn+7cVCaGdr4oQFW+y825Y=;
 b=C/YvdDbOYdAda5mAhbwWlJQh4WkhHwNkHMBBnBNAVIpQe/vpgtdteR3stVCSXcZ6b8
 P//VCLOFvQwKg78R4UhbciAWMNXN8aL0rWFrW7mq9cdTDLKyoc9NjuyClzabUikkuvBa
 xEZyutPmH1yRFk27DmK12IkEM6jcFtSZLjJhi97rqtNVWdj/vUIv4/l13AIXbVZYDfrn
 RDYWSkG43eeFe+xMfXwX0spOssMywf5SfkKZw7oz08hfJGFLedxdlRjdDvKjAJDeKOF8
 TkEyih/KMWS/JS7LbJGBAamq0PdVKLrzA3F+pZoqd2ayDSJKc3NojamH1ECzrBgg7WyR
 NHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736214; x=1738341014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oV62nQbavYpaLNeL3j3KFgn+7cVCaGdr4oQFW+y825Y=;
 b=I6CtnyGltW+eHXtzdmkGUulsv25frrrIrSMyvhJe1+08xs9UZM2ccF3O/9ehG4j1+j
 3yaHG7c17mggzG83BHqnzYJH+6gpMM6Hr/heiN2md0dUEaAKIE//W3e1N6vx8he3x7dR
 Ls7/RNsxfubUVhv1RC5QSdRGGxYYtHsgjcFG0gL5GQmPFKUXesYhRCOgcznlpcbZ2Rnz
 Oo+7qmiQv2SFPsYlGsmLIbhcdC/KJ5XCP8jHHOdJko0JRUZsCdeJy8iIlOYNonPA5H/X
 eedNv/9GAYt9zBGI/WuC3/Jqt7lrMXQTLhl0TKX2VGvhlIyNj3OqZnF5Brb8lOfyijEm
 qhJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIHeIu3oXWEJKgcxUMzFycPH8OgaTWpSXMaR+5l4afIxESqK+U0ghax1Qn3GF4SkWqgWi+nedwjYoJ@nongnu.org
X-Gm-Message-State: AOJu0YwPPvYRaHHo2q4xbJlFT34WTuql58CdOnZQGvv1rSiCOqlj7whG
 lZYo0QIR2dJkHxEn6kDHo/nrcS8pRX+5NaPtY1GgfNk4LYfbpdzCrJrw9+Rst1iYntmS7+A17TW
 w
X-Gm-Gg: ASbGnct46e1ZwaPMtG+znl0L9LMapsDq4xRD6gjq8V6vri/VDwvOanL7FVLGb/21Q06
 5UpmUOHVg+NMGmHdwGov9QO8y7n4ezOIhIngBKBd8ks2FD7O/g4es8ISenQQ0W8/1gb1Lv1rlil
 ZhJhUXtex1Tegts8Jod3ytQ92y5DQyYrg5RnM3jmYHSAzv00dH7UdQfEgdvWhTH4C+R0WdlB/5z
 eO0KUlmZolBK2G+0bYxkEiFr/hiBcZfB0bS+PxGHLGXR4e6ISA/dB9bh0Wy+s00NQGzpU/Gbeor
 KBzC6Iognh4=
X-Google-Smtp-Source: AGHT+IFfjXYHkqnixVf07jkqK5cxyhv7+n2MrwOwbvWuJMaOntinu9OAlcbPeTGGeMz5fpKjTiWGZQ==
X-Received: by 2002:a05:600c:35c3:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438913cf2e0mr294415915e9.8.1737736214070; 
 Fri, 24 Jan 2025 08:30:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 75/76] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Date: Fri, 24 Jan 2025 16:28:35 +0000
Message-Id: <20250124162836.2332150-76-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The x86 DE bit in the FPU and MXCSR status is supposed to be set
when an input denormal is consumed. We didn't previously report
this from softfloat, so the x86 code either simply didn't set
the DE bit or else incorrectly wired it up to denormal_flushed,
depending on which register you looked at.

Now we have input_denormal_used we can wire up these DE bits
with the semantics they are supposed to have.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 97b46307d56..fd1cd823e9e 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -215,7 +215,7 @@ static void merge_exception_flags(CPUX86State *env, int old_flags)
                        (new_flags & float_flag_overflow ? FPUS_OE : 0) |
                        (new_flags & float_flag_underflow ? FPUS_UE : 0) |
                        (new_flags & float_flag_inexact ? FPUS_PE : 0) |
-                       (new_flags & float_flag_input_denormal_flushed ? FPUS_DE : 0)));
+                       (new_flags & float_flag_input_denormal_used ? FPUS_DE : 0)));
 }
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
@@ -3251,6 +3251,7 @@ void update_mxcsr_status(CPUX86State *env)
 
     /* Set exception flags.  */
     set_float_exception_flags((mxcsr & FPUS_IE ? float_flag_invalid : 0) |
+                              (mxcsr & FPUS_DE ? float_flag_input_denormal_used : 0) |
                               (mxcsr & FPUS_ZE ? float_flag_divbyzero : 0) |
                               (mxcsr & FPUS_OE ? float_flag_overflow : 0) |
                               (mxcsr & FPUS_UE ? float_flag_underflow : 0) |
@@ -3267,14 +3268,8 @@ void update_mxcsr_status(CPUX86State *env)
 void update_mxcsr_from_sse_status(CPUX86State *env)
 {
     int flags = get_float_exception_flags(&env->sse_status);
-    /*
-     * The MXCSR denormal flag has opposite semantics to
-     * float_flag_input_denormal_flushed (the softfloat code sets that flag
-     * only when flushing input denormals to zero, but SSE sets it
-     * only when not flushing them to zero), so is not converted
-     * here.
-     */
     env->mxcsr |= ((flags & float_flag_invalid ? FPUS_IE : 0) |
+                   (flags & float_flag_input_denormal_used ? FPUS_DE : 0) |
                    (flags & float_flag_divbyzero ? FPUS_ZE : 0) |
                    (flags & float_flag_overflow ? FPUS_OE : 0) |
                    (flags & float_flag_underflow ? FPUS_UE : 0) |
-- 
2.34.1


