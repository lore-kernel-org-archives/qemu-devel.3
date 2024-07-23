Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1086BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxS-0002WA-53; Tue, 23 Jul 2024 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJws-0001Be-01
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwe-0001CJ-Nr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:15 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39888f465d7so9995235ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758140; x=1722362940;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=GPdAFAtwBtSjDT3KVSIm625+cLXZMUykRguhba/ibmdc4qvREnuLVRDU2vamcQw29p
 E6b2+es4yB4U47wyIxh4AV3/GFZX8ftmS2F1H/1hDsw8lQTm68ptyyp9muG4o+5Dqzo4
 ZmkHxwYdh2oh5yJhIcLJeN7gudKGW0H7QKKjq6nB6T/CUmTDNlLETSgHfKgFxSWdcWDY
 zxP6w2yTqNb8Nq0UPyIODj7jDiccdmhkg5B77Qzwfz/BZj0K7yiXFHZFdu+5/lmhcp/e
 2II6wBJUKs64JSPViweuxACUYsOZ20xeYwsT12oxM2HhxzbLTjtw4s3+kBC+/tmOvLVq
 vanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758140; x=1722362940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6l2giQ2DgrY0GVfdS/Z1DlHyLIcTuXalMYf+UrzR91E=;
 b=Q7BFSiKqrLQ95NR1e5sTqujtfLCReoThVackGfVrh6Dz9G+P1Ia8S6yeiQedMGa+0S
 tNP6OjpjxEjjKrR+emuIIUA7RwTqtyNqKiv08uwEU8GVVh2S7uEn1MP6OQQ87zqXm1BO
 bOThFkW4K6DSRahaPKLGJVeqhp0ZcflKbp33CxT/wbpix4fI9fvHAIiHMPDFCqJmQSsO
 HTVSLn6s9jU2xdq9XmXMJs/xzdB001MpauDvLeqKenDXJSa1DkwL8bVUOraRVwJTiF4Z
 3EjzF8U7iMixCRRuWcZsPlMqxe1v4ZNgOlXiW8fCoS4pGzhgrgjWZ0ikYm0jBil88W5q
 Un0Q==
X-Gm-Message-State: AOJu0Yx983dubpPCYPzmIkln5R2jAH4FkeOBR5zFTBEwLEYUnugVacXh
 TgRpbnvsg4oXUGlCey36iYuP/L5jgb0Qg7xsth1r/Gvyq3g0cQcZSJ9MxQ3tsf9yb5kcta8w+Ne
 Bosg=
X-Google-Smtp-Source: AGHT+IG628jh6zK46X53MOuNZVB7ZJIIzpI9qlZ6GK4QQZSr7JsghhiZeT0SbW+pC+hzFjCrW0ZVNg==
X-Received: by 2002:a05:6e02:1c46:b0:382:b3f8:9f72 with SMTP id
 e9e14a558f8ab-39a16c81e5fmr10957115ab.15.1721758140488; 
 Tue, 23 Jul 2024 11:09:00 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/14] bsd-user:Add get_mcontext function for ARM AArch64
Date: Tue, 23 Jul 2024 12:07:16 -0600
Message-ID: <20240723180725.99114-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12b.google.com
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


