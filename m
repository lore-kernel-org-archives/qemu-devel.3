Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1286E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mh-0007JQ-4t; Thu, 19 Feb 2026 05:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-0007B5-BJ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MW-00065J-PS
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso6899345e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497261; x=1772102061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UzzJHiP4Ww50cmlpD5s1nBOWMQn5ZNOxnnLL7RIFj0M=;
 b=zWNhNe3OgheL1ChsjxqgCT/oRi/DR/i9biBiYST/TG7UFNYn7mg0j0cU8fXa5x2pF2
 3sDM/sw/r1xchUI50Mr2cljIYwU+A9m1Kjq32DPjFZ9nlS5iM/ic9T9J1+tFUxm7gZ4b
 R7z+Zx075e+AWXdjQjnYMF6Runz8b99WL4zAf/zfHwXvlZN/8MVm3gMO1WYpzs3orTAo
 rtmOhSvA5lCisFFw1zBSwUl4yjKcFqRDOxDL9YuKvC4xWXeaR6+4YhUfa/QLFESt7mMQ
 aUl0hzTGPijmezISEna40ayvIGFqu1qDuonuDzYa1vse+fRCifR//oDlRePfA3drCho7
 KQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497261; x=1772102061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UzzJHiP4Ww50cmlpD5s1nBOWMQn5ZNOxnnLL7RIFj0M=;
 b=cE0pXtBZ8U1BCcqvd9ksZLcD1YdZDh44jXSnoQKZsye75YKiemXPtr2TeBroOddKEc
 kaHAdxRrY4bDoU0HL15wF7HWyq6emD1rxb+A1hjNQQwlBTN1mOxSTRwSAZJaMhc7SwFf
 E6IWKSlKJ3o4dsG0UPZUW5U+pn4pdUkNeTsl+p0G3BXTmqajFS+W2buFRpZbX//ioPdb
 pAsmQnOvUOyeFvCAFtOcyOYRtWLHnYIXrYsFOBv4zHZ8D9iIInoo5n5JYwIVxplt+ira
 QC+2d33PDjaKyCm3FEuy0VHDBUGMYPHxYUzw4a4dCUEnXVzJ27HhEnX1WhnsXxPDvUux
 Jq+A==
X-Gm-Message-State: AOJu0YwmKvNkapdGLpsRitf+ZAzmAzSu4xTY0nVLiZGxyvFNVwrk9we+
 WMsk1EeCnAKMdNr9EM9vX4Umrb9mo40HuKlSpgCRdOoJEyTyM443qB5jZ0KTBoKyaoWhGGLmsBi
 ztZ70
X-Gm-Gg: AZuq6aIvaAf6JEWNTDhXkXrsHiIKDGgB0ANsym2h9shBHmEMjzCZrFe82pNHHC7zxuu
 Ug9ZiyOkVNAUHN1Upfpjoh242filS3yzktIvI+q1BLiGUJzzqopGuv9IcIRQFc6V/xxKxoZ0J8B
 fTXkoYi80OREoFm2Gkh6APnahL/cQG2zGj/OfT2dYK5yv6ROKMXETzO4l08hkE0mHO+/jEPAGwg
 E7mKq281h6GYmQhyd4y21P7r11UV//tQxsWCYFNoRPyz9jw2QyLWyR7grENLYl/4amnZkaxNx9I
 HJCnoXMMDcnjneaOhvBIPB0G2c5DlKm2dFJGQcDzAycBrTCwjI38T0bQZvshwTILfCpBxHyDa4g
 6rtx5r0F58Xf0Tgsm2aAr5rp6uMlU4hWsXMHTh2gUSPqGFnXQGMaFFY3JtXyO3Klb+8RKT2OhwW
 YYRXhWxhA+4KlVhYPpbn2xB8AvDJazYU478fDdiWQoA5yAcpyKRuBbmb3Xk2gKZObQLa9IFGXJS
 d7YOS/yk85zzp4531WwZCUFiFt+KqU=
X-Received: by 2002:a05:600c:8b84:b0:483:4bbc:89ea with SMTP id
 5b1f17b1804b1-48379c42db1mr290411605e9.37.1771497260764; 
 Thu, 19 Feb 2026 02:34:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] target/arm: Permit configurations with SME but not SVE
Date: Thu, 19 Feb 2026 10:33:48 +0000
Message-ID: <20260219103405.3793357-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

In commit f7767ca30179 ("target/arm: Disable SME if SVE is disabled")
we added code that forces SME to be disabled if SVE is disabled.
This was something we did in the run-up to a release to avoid an
assertion failure in smcr_write() if the user disabled SVE on the
'max' CPU without disabling SME also.

Now that we have corrected the code so that it doesn't assert
in an SME-without-SVE setup, we can let users select it.

This effectively reverts f7767ca30179.

Note that this now means that command lines like "-cpu max,sve=off"
which used to turn off SME and SVE will now give you a CPU with SME
but not SVE.  This is permitted by our loose "max can always give you
extra stuff" rules, but may be unexpected to users.  Mention this in
the CPU property documentation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260202133353.2231685-16-peter.maydell@linaro.org
---
 docs/system/arm/cpu-features.rst | 10 ++++++++--
 target/arm/cpu.c                 | 10 ----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 024119449c..3db1f19401 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -323,12 +323,18 @@ SVE CPU Property Parsing Semantics
       enable SVE2). There are not generally any lower-level controls
       for disabling specific SVE sub-features.
 
+  11) Disabling SVE does not automatically disable SME. If you want to
+      disable both you must use ``sve=off,sme=off``. In particular,
+      for the ``max`` CPU, ``sve=off`` alone will give you a CPU with
+      SME only (and which therefore still has the SVE vector registers).
+      Most users will want to disable both at once.
+
 SVE CPU Property Examples
 -------------------------
 
-  1) Disable SVE::
+  1) Disable SVE and SME::
 
-     $ qemu-system-aarch64 -M virt -cpu max,sve=off
+     $ qemu-system-aarch64 -M virt -cpu max,sve=off,sme=off
 
   2) Implicitly enable all vector lengths for the ``max`` CPU type::
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7542444b18..10f8280eef 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1580,16 +1580,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
-        /*
-         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
-         * FEAT_SME_FA64 is present). However our implementation currently
-         * assumes it, so if the user asked for sve=off then turn off SME also.
-         * (KVM doesn't currently support SME at all.)
-         */
-        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
-            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
-        }
-
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.43.0


