Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F14C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk7z-0000QZ-Hh; Wed, 24 Jul 2024 18:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7v-0000Gy-KW
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:27 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7s-0006XJ-GH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:27 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7fe8d029fbeso13825339f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858782; x=1722463582;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=nQjP9orQDkXDCkAcCyRhkMCucwO+Zf49vf2d5bmVyyi/Lj86D8xH2AzrWb4rwpshaT
 oZA8uKepPeIy+LxSnMvCLCetIGz1bppjs+rTdCiAdGzP2BPPJpUSVDxFl9DRE911+tew
 /9yGmvlp5hBWwIBrpOM9011byLgwQtfihg2QZNr98siU5XE+uRePhNT9PwUlEtnNBn8C
 XB9Txhmh3YD8+l3vcHIpi6lsR5sM09mZXuhoMkpaQrd7F2rzmWiIWxe3+EzwhCoYkMac
 qltaZ5+CgVxIaiSPzRsIUaEa8Gs6mVeaaby4wPPinUUDSIBGX/c3q4yn80G4F9jxeGIQ
 IKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858782; x=1722463582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=eLZtbbgmUlJtQIkjauT28ZPYXT3Gg+0lGN0eu2bT3TrknPyFSQotSqysOoGWGyelTJ
 DhfRjT1/Czat2t62sTK+ReAbLKJLKA1N1RV51Fv1FOJuAESjwFVPxvlILbu6XirmjCLY
 fzvWxBJ388HIwBq9cKM3rnTV6Biae3POQPa8nzNFyzwJYJbC4kF2nphQh7TYGmUJ2blR
 tziEzSt0JAtv2iaFmY5WtbF2RAROE+I2MfiYBPcqvVrnKcj63DgbIOXvLOk8bCZp5wn7
 J32SauabQwIb4CYE2FQmoXNqBkyfCCzzqIXRU+hzdyEPJzfMCBrZD/oGYM62DdBHqxMf
 UTEg==
X-Gm-Message-State: AOJu0YywjPX/TPHsqSCphZCYpgbdCjISaaAss4oQ3PDPQl4YoaeLZAcL
 awnL0KtmsH+x40obOFPGwHrjDfkywMuQ7iDb9s60GNE/ei/B95uB1d+czcr224hTWPrzX5K63V4
 zKmI=
X-Google-Smtp-Source: AGHT+IEEoCtFtIWCxg561LR9tjLLb/W50MzyrgCLTgyq70R0c4sy14UBWgoRxlgVp0A2thHeLsUvDg==
X-Received: by 2002:a05:6602:1695:b0:7fa:56f0:ad87 with SMTP id
 ca18e2360f4ac-81f7e430a4bmr16774839f.10.1721858782394; 
 Wed, 24 Jul 2024 15:06:22 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/15] bsd-user:Add get_mcontext function for ARM AArch64
Date: Wed, 24 Jul 2024 16:04:38 -0600
Message-ID: <20240724220449.10398-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

function to retrieve machine context,it populates the provided
target_mcontext_t structure with information from the CPUARMState
registers.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-6-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 98861f9ab3b..ab3bf8558ab 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -51,3 +51,33 @@ abi_long set_sigtramp_args(CPUARMState *regs, int sig,
 
     return 0;
 }
+
+/*
+ * Compare to get_mcontext() in arm64/arm64/machdep.c
+ * Assumes that the memory is locked if mcp points to user memory.
+ */
+abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
+{
+    int err = 0, i;
+    uint64_t *gr = mcp->mc_gpregs.gp_x;
+
+    mcp->mc_gpregs.gp_spsr = pstate_read(regs);
+    if (flags & TARGET_MC_GET_CLEAR_RET) {
+        gr[0] = 0UL;
+        mcp->mc_gpregs.gp_spsr &= ~CPSR_C;
+    } else {
+        gr[0] = tswap64(regs->xregs[0]);
+    }
+
+    for (i = 1; i < 30; i++) {
+        gr[i] = tswap64(regs->xregs[i]);
+    }
+
+    mcp->mc_gpregs.gp_sp = tswap64(regs->xregs[TARGET_REG_SP]);
+    mcp->mc_gpregs.gp_lr = tswap64(regs->xregs[TARGET_REG_LR]);
+    mcp->mc_gpregs.gp_elr = tswap64(regs->pc);
+
+    /* XXX FP? */
+
+    return err;
+}
-- 
2.45.1


