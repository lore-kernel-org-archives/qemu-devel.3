Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D99C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT00d-0003ZP-Iy; Thu, 25 Jan 2024 08:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT00a-0003XQ-Ti
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:43:08 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT00Z-0001km-8M
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:43:08 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337d58942c9so6767545f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706190185; x=1706794985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8cqesZOdW9FLhCoNybK1K8wV/PFZ0n/GQh3iLYD7EDg=;
 b=ZpW/cEJ+CCTg+N4tI41HEJBOWWfopjl+x252kk/oBWVmmNWn44/gmca1UWv4yxz3cX
 5WK3pbZAgoSKPKuoeT+cn/FtHopGKmzDYIU71ARkSQ5mX/bcwt2Bi2rzJpvDeMKCKssB
 eS0kOCS55/nx/NxpfW/czP3Qzrkzc7vTc7k7vLyK7FHpzoNkeERJk6wYrRwANZoSlHZa
 ZGXgX2zi169ruArfD3qVjHBjeditQM5XmoHOqdw937PUQib15Rk1XGfzfjCqP856tbca
 1rGtrmPqC7Ff5Jk8KXvAv/hISMpMu9ZfIZnQLuoY1W9S9BQET1BFA6WU+Ft18mZlQf0z
 4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706190185; x=1706794985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cqesZOdW9FLhCoNybK1K8wV/PFZ0n/GQh3iLYD7EDg=;
 b=ok5T7rH+ozsRWQyeRzHO1rILieMUCAh/WscSBcFhIoGIXKTzMZhXsiDYzZ8SDms2BU
 tNJq7UdVkstwyGgY141Soe3zYlB0aUTMwBIEjTF74h9uwy4JIfqlOZsgxXnsVfnfLWtu
 Lo2h0nXEvkNXpMSMYNbnqjRU1GIbwiBS/FLdWC+1E6/uld03jL/AFNXzDibHojByJjGM
 nfyMr2JJgSccLEiJtEOwx+LYnX50X2zMNY/B3t7piR1exE2DNJ5dwnnSzh4/U7pnUpoE
 o4lxxIp2EXHFSTkeZCcy8ClWMdwWlEyoDS3XIXv2xgIcKNEJXueL4OB6CwrB8JM0lxhr
 COqA==
X-Gm-Message-State: AOJu0Ywm8I+/wS3LW8cH5DpkBhuskbYwqRIQtz+U7rumUYdE+CAtI41j
 zrXNE3o6sIZ+BAEJJ6EzXk/RQSI5Uu1SSTOY9iMsQPAczFVJsFV7D2+WzD4lmCeKRjtr5NEdRyb
 F
X-Google-Smtp-Source: AGHT+IFqxGjL3bMgypIKdt8wTXiM50Gc/apBxMdJcq3Y4Oc91SHj1VQ2FRtfoMMsdkfkR58UsY4hiw==
X-Received: by 2002:a05:6000:1209:b0:337:bcac:35eb with SMTP id
 e9-20020a056000120900b00337bcac35ebmr529645wrx.136.1706190185451; 
 Thu, 25 Jan 2024 05:43:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adf9cc5000000b003368849129dsm20810534wre.15.2024.01.25.05.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:43:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the
 exposed-to-userspace set
Date: Thu, 25 Jan 2024 13:43:04 +0000
Message-Id: <20240125134304.1470404-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In kernel commit 5d5b4e8c2d9ec ("arm64/sve: Report FEAT_SVE_B16B16 to
userspace") Linux added ID_AA64ZFR0_el1.B16B16 to the set of ID
register fields which it exposes to userspace.  Update our
exported_bits mask to include this.

(This doesn't yet change any behaviour for us, because we don't yet
have any CPUs that implement this feature, which is part of SVE2.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a loose end from last year: in commit 5f7b71fb99dc I
updated our mask values to match the kernel, and when I was
doing that I noticed that the kernel had forgotten to add
B16B16 to its report-to-userspace list when adding support
for that architectural feature. Now the kernel has fixed its
side, we can update again to match it.
---
 target/arm/helper.c         | 1 +
 tests/tcg/aarch64/sysregs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e068d353831..24c0f80679d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8895,6 +8895,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ZFR0_AES_MASK |
                                R_ID_AA64ZFR0_BITPERM_MASK |
                                R_ID_AA64ZFR0_BFLOAT16_MASK |
+                               R_ID_AA64ZFR0_B16B16_MASK |
                                R_ID_AA64ZFR0_SHA3_MASK |
                                R_ID_AA64ZFR0_SM4_MASK |
                                R_ID_AA64ZFR0_I8MM_MASK |
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index f7a055f1d5f..301e61d0dd4 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -137,7 +137,7 @@ int main(void)
     /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
-    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
+    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,0fff,00ff));
     get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(8ff1,fcff,0000,0000));
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
-- 
2.34.1


