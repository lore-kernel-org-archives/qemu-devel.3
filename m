Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJx8-0001r7-DF; Tue, 23 Jul 2024 14:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJws-0001Bf-35
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwo-0001Cj-EY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:17 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso25955565ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758143; x=1722362943;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXCw0+RJXjXO156yoRFr2t5+0iBs33zwi5q8sWmsNWs=;
 b=Tol5Pfzt00N2MoDzPVr/9jf2A4IedplMBTNxr74fLgXg00FTuB+6GJZpKdwWAZFQiP
 kvhlp8HpsFJQqebUUfktA7eAUmfzKqfbHYvxVUdOnDDCKnAGTyfqN6Us3H5oa08MbkDb
 G7gcwEZH9LQX1IZP2b6yCYo5o8BzvZtLm1brrC9mibivzBc5AlN6hLLOT6cm8+edbdxL
 g3VhB6NU8xjsbbHYln38o0hkX2sGKAXkAFDg5rt0QE2YVmQwJxGgvMVLzs42WKwDKVoE
 Q78Fo/zcizQOtCBe0FJCXti94Q9LVp+vphjJqFEO13Ao78CvS8c6IaVRM5hfkm63kpGH
 GO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758143; x=1722362943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXCw0+RJXjXO156yoRFr2t5+0iBs33zwi5q8sWmsNWs=;
 b=q1mN6oxdZpatRWcEDRW589WydHLgxn0qIOlWwjM0SB1Uq7FiEdQtyb1txuNfGaGBpX
 9nNs879ot4adeHsO/M61OqaccGGVR0E2rclRkuHj7nYenrQuWLNjKt8RXx+Ljwcveq//
 FiibI98plySx0X4KfmOHP7V+7CSePicvEPmsLsqx8hkK4e0Pqv2//r3oL8z0OinigdX1
 9/UWyGXn6qWuIWccAgmk3a+hgYLV8HNHb1qmtsbf4gvdTOejUeaYUrCNYRtUw3PvxFwB
 YLWm565BrD8jC6ESwC79FjFq2VX4gZMtDEy4iVjjqkywpJTgLoIx1zcDVNKiTv8FePaa
 nnyA==
X-Gm-Message-State: AOJu0YzGfWUvA1iV4I36jX9tNp2lvbNaJWkyMBVhudRxZ5arHxGk527t
 WKwkLegEsMxY3i6T5HMzWxXbgZfTdrJQQ1wqUeLtZoxVBoZbQsqeIhYYcnGocnl82ZWfLjWgX5r
 aGjw=
X-Google-Smtp-Source: AGHT+IHnrGaNWqqAkwFMvWbCSBLhF1+3y5tcElslWJgwfmkBAw2b6AD8/gSA0E1HvoIR+SaqNAFv2w==
X-Received: by 2002:a05:6e02:1a83:b0:381:d74f:b2f4 with SMTP id
 e9e14a558f8ab-39a16d5a102mr9503785ab.24.1721758141350; 
 Tue, 23 Jul 2024 11:09:01 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/14] bsd-user:Add setup_sigframe_arch function for ARM AArch64
Date: Tue, 23 Jul 2024 12:07:17 -0600
Message-ID: <20240723180725.99114-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x135.google.com
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

The function utilizes the `get_mcontext` function to retrieve the machine
context for the current CPUARMState

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-7-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index ab3bf8558ab..43c886e6036 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -81,3 +81,17 @@ abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
 
     return err;
 }
+
+/*
+ * Compare to arm64/arm64/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
+
-- 
2.45.1


