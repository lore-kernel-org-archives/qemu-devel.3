Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618DED4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVL-0000gc-0Q; Thu, 15 Jan 2026 13:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV6-0000dJ-Si
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV2-0005sl-D6
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso8474845e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503313; x=1769108113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q51h4LOe1HGQIAJLCsEgnFJbwI2EukWy/+nt44oI/io=;
 b=krcJOCZMw8UW15HwHnEBlIsaF2+D8gffz2Xgj58vGS9ekA1lrF092nuLHka1LDEPrS
 e31wOcDOfgvqbaFwKnBX7B6n5w5NB2PltXHOygnCHnTH8AkDRS43+++uSg3JI53MbRru
 dJxr701L8JPnLTcHtXr1m81mGS0ZCi7PqeP7zNg8bkPHdI8ut9/XQPHZgyW6QYvgkFnF
 aVxgqcSQBitQ6EvutVBB6HyJIkWrTb74fmyxv/wiL59W0PdfXH5ykiW0/dIMFeaKR6x6
 4RT1jrHPuAowYEFVpnz640kCTwnOz/HmNEDDIN0jPyivmKe0UeCd7TnmjG1ooZDxIi5a
 Uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503313; x=1769108113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q51h4LOe1HGQIAJLCsEgnFJbwI2EukWy/+nt44oI/io=;
 b=o9y491uecGG6mBRjEyMPenIIx4LfDgRWIlJRBPyR+DjS7QsPlwlY3M/K86Nep+pMo+
 5jUY/MDP7evlqMYe4+85lhlMp2g5Hll0oM7cPje/DoxFAHYTXofo8t5DHzfKI0GweFEB
 MNO2rY7UCzvV2d8KWcmwUjdrZ8e+arHH3FEwTmuUC1g01lLRZ7a02sINMwQVlU89eWpX
 +Z5vNBjt2FNYKXSwONUUHvOZ2odxqygf0BbrU9UTPkVR7fYbNBIvOwpo8EWCtTeF49DC
 VRkYBfLESYlJHIuIaL/9AOay8ycMjHWzhrMtI97oBT1BcnAZLHOnceh97WhLXBvqdrUN
 kCGg==
X-Gm-Message-State: AOJu0Yxq744R3yL1mupKuBnXDUmOl3oYjrtzQ1FTSL7QVzPP1Mz7eQg2
 hGWpV/tBPhVG3CWZ68C0Z471uy3lSeJ4z4qqHvkYBm8TZZj27HE6ZOTd5utmr73m4B3MMOt5/FV
 NGFM6
X-Gm-Gg: AY/fxX6XeCQ678t1H+VYCrA5QFsKYRtI4kziW6lhvI//SOTHd5wldxnfv/5YVbUnuPA
 z5IdA2Bs3fKGQmsTro4ioGs35XWuiuzA15/DlCNId6NyCPQajdMmcXgKZyQbk/ISrzQkmkyxcko
 53Yb9/NXPBm68AwUJcxHYPK3W81FePiticLdja+aVFVh+3cmb2bFQaiHZnxe1MLISkFtDeFxOoU
 ft1t+dnjTyUj9CWrbVJC1GQBh6t3/CEw0MkSjX4imUsRVj9rdAPbtBiVxqpNmd53+s5LBlvS3oo
 cwQN5YV7yt0MossufI4zrPOWkYf6VMiiLm6MpjmHw9YxNtgEzG2fxq+nI/QfGOV4yNXQoEExTF2
 6zh4RY/ZLoMdGPIlm64kSjODBIWmzeXcDJYUmExXW6dcpQU2bfF5n8lQzNJdkecJLLLaHx1d+Fr
 Wk159wVCkiAuMircFigo2IeLvzMXl8DR/csnnpV9/ogVsCtgWtmc+PRWzCHcNzSJEmVMn0dgvU5
 pAjBsMxr+ZPNAWyUBNDJMTZP/MdvfbbsZtkDBRLHuGBnA==
X-Received: by 2002:a05:600c:19cd:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-4801e359031mr9017935e9.36.1768503312868; 
 Thu, 15 Jan 2026 10:55:12 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/25] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
Date: Thu, 15 Jan 2026 18:54:46 +0000
Message-ID: <20260115185508.786428-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

docs/system/arm/emulation.rst: Add ASID2

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..3f30ea5a30 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -24,6 +24,7 @@ the following architecture extensions:
 - FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
+- FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 917db5bb09..611838171b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.47.3


