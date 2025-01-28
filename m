Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8256C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxp-0002AK-Qp; Tue, 28 Jan 2025 15:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxn-00029N-NP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxm-0001bb-7t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso184325e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095213; x=1738700013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GOW1Twt4lg+2UgyPFX0ahn7+j3jSZp0l8hnDgVS7jCc=;
 b=ALmoUjILvh/ksxoTzspuFiDcpbo+ipxyv8x4CjDLnxj9f+gvg/I3j+9I6W/KMpGyXK
 qsKk18gbA6WBXva4BU3wivFTQxDdHE/IE8/sdezu0u9EdVYTrXiIAQK/fHuI+uuFsNUb
 KUyT3OtlTyRLT3VH0GqJTCouGvB5eZebpoR60sNJQg0xxvfJcM7vb9v/GmWLCuvgn3Gd
 QpPFWfi9gzTmdjpxlzZ6Ma932u1Q7FVNhBqrupGF2H0+YLqrUvIJ/4aO4eMimiYFy77M
 iN5B3hJXiDmOH4GzAVyh386xz15ErjQIgEoYZLivvyZLhf2KcSXvn0KPv0CLSIHl4r+7
 uqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095213; x=1738700013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOW1Twt4lg+2UgyPFX0ahn7+j3jSZp0l8hnDgVS7jCc=;
 b=PdEbXITcLfpQtadpGWtCWbTweDvQ+OKwIDcBOE1KAq12eqLEB1cfE9b22ZRGUir8jB
 MvoPEfXthufQK/XbhWNXegBoUsvIXxDMbK4mgOd0JDNtuvXI4NJcRd4v+HMi3Vviwqcx
 2PC1DiSLh8L+9u3vDRQmXiCsF8QKXq2ECqLFDNhvAup7caRuHwnFzzaleedz43VfyLiw
 h8GmUylogC+qEEp1RvrQ1eWmo8FNFhwJ7gLgIRfokOocEIqRf8kjLcPNsBX61u4VgR5S
 gEU/mtejDlTe9y0zmb7/xegNMnWlHWkOuAHsVNrfJmg1zAdi1ljreH1ZFGcFFSxvhNdM
 9JEw==
X-Gm-Message-State: AOJu0YxauXanGZ/5PQd5Xj6lLyGQUimGFAmHp/pY9eqywn03OdlN1vCR
 ptRyGR8mg8HHrAGgYJIUB+TZEhCYyTqA8aUZP0J8cfLR70aF58b8KwtqCWbh0mlyemXbGFMTLH9
 z
X-Gm-Gg: ASbGncuswv0L0ZEbeQKA7W9AtlL34GuXzS8r5HeAP1CZso/5wveyg+/EVuIKGW/S5i8
 EfZRtMgDr33bsQjx6bfo+i7XzTH9vV9gF+EFkLuISDk35wjinId7NhPN/lnRN1VYpLUhNi+R8mD
 8ObVbqnryTyYiMppqO43prGgDnbHSt7kl08NDjz3/mHGjS9GM47GpW31yz5XDOc9MUQQgfMfBOk
 cSbw+RQcXxYTmPfV/RLY58MZYf+UrSK4rKptIeOrXanh1/V4iwZplmcPaQJmBiwa7lvIf+wHOZI
 /ccXBliN+ngNkuXsoPdt9g==
X-Google-Smtp-Source: AGHT+IGOt5vfI6x/c67p/yYDcUZy+BXOlyjWL+tpDEDYl8PbcAPqUtSIu1BBJKsJknyN7ORUwlUH5w==
X-Received: by 2002:a05:600c:4443:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-438dbfb68d8mr5176745e9.14.1738095212819; 
 Tue, 28 Jan 2025 12:13:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] target/arm: Use FPSR_ constants in
 vfp_exceptbits_from_host()
Date: Tue, 28 Jan 2025 20:12:53 +0000
Message-Id: <20250128201314.44038-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Use the FPSR_ named constants in vfp_exceptbits_from_host(),
rather than hardcoded magic numbers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-5-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index fc20a567530..fcc9e5d382e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -39,22 +39,22 @@ static inline int vfp_exceptbits_from_host(int host_bits)
     int target_bits = 0;
 
     if (host_bits & float_flag_invalid) {
-        target_bits |= 1;
+        target_bits |= FPSR_IOC;
     }
     if (host_bits & float_flag_divbyzero) {
-        target_bits |= 2;
+        target_bits |= FPSR_DZC;
     }
     if (host_bits & float_flag_overflow) {
-        target_bits |= 4;
+        target_bits |= FPSR_OFC;
     }
     if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
-        target_bits |= 8;
+        target_bits |= FPSR_UFC;
     }
     if (host_bits & float_flag_inexact) {
-        target_bits |= 0x10;
+        target_bits |= FPSR_IXC;
     }
     if (host_bits & float_flag_input_denormal) {
-        target_bits |= 0x80;
+        target_bits |= FPSR_IDC;
     }
     return target_bits;
 }
-- 
2.34.1


