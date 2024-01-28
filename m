Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657A2C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx1M-0006G0-77; Sat, 27 Jan 2024 23:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx19-0005nk-DN
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:41 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx17-0004Qq-8Q
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:39 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5957ede4deaso1180498eaf.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417016; x=1707021816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hwCZNX7r6WcP/DB6F59Yv2bYfXzcZik2wXoCrV2EBg=;
 b=ygmUA1MPOgZvcj7ShkZRqbtk+9pD/mRZOryQzNEM7C2sBf2QlrQh8I8pamh5pWXMoo
 vuJ9HC3SP8etWsKPvPjxZ945ieB//y3k3y72Y8DtxYF2hYMU1sHM/Jg3xOGsN9kpzE+C
 0p8Hgj3zUqTxyrsP/WCBxL9PQcrxzyiMAQkMm3mOzKUMLathDxlf57+iwvd7QdVAdzha
 j2gsYJe4eq71zXVoVX9BLylsA403KBaWq98ql36hUSb7NtFkvS9CXQ9y4EGDgeibpavL
 VDPM7iIKvcbQPL76CGjX4VybqsOui6DWdJEZB1r8c9H+xMvD2Clk2DBKR2ztqt9BzJMG
 oKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417016; x=1707021816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hwCZNX7r6WcP/DB6F59Yv2bYfXzcZik2wXoCrV2EBg=;
 b=JcDxzh6mQOaMeQieuIVI73KqGniN36IxvxdfbWBLj2NeyUZ/0jfrs+NvJuvbRwfwcR
 AtDUe34iypB8CW9/caqmOyNCVHawcBDlJ9QTjgNcJkJ1+oWiTi+qNR/bqWyZmAMeelvr
 yPAPxxIj6dgbI5cOzHaA7yx69zuaAYSTX3Opy8vIHP8GtUDE92kZbp8iSGt0pOCG++et
 Ff5uYJJvcQitrruFW4aH40Hj1p2W5eycFm/Mq1z/APe9pt2DUKyCP7W3lu2ZibsBFRro
 GcZ8qb2W2u3vQcmMyMbFMNP8BS0XMq97ecy018AgY/g6JdZ1C49SuVKrh0JSGVfdIDdq
 sBLw==
X-Gm-Message-State: AOJu0Yx6Lf9DGIXmE0XIAL0oPvqaLIC0uouI/sogZdA5SOMH4Lq1GMku
 aSwUKLTzHz/VTHtOnds+h79+3jxthQQSGyNFnY8q9S2xSjzW6dw58QN3vboELdFy/Nae231Vcqz
 vlV9LVQ==
X-Google-Smtp-Source: AGHT+IF2Jhs9mUI8/9R/u+kbEOba5QAX5NNEr/vODx0Z4cNsu0PqqO1+Z6c2I5eNm7yuiK9V0Bv7sw==
X-Received: by 2002:a05:6358:52c7:b0:174:f48c:3871 with SMTP id
 z7-20020a05635852c700b00174f48c3871mr3059615rwz.43.1706417015729; 
 Sat, 27 Jan 2024 20:43:35 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/33] accel/tcg: Inline need_replay_interrupt
Date: Sun, 28 Jan 2024 14:42:11 +1000
Message-Id: <20240128044213.316480-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

The function is now trivial, and with inlining we can
re-use the calling function's tcg_ops variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2eacd694ea..75f7ba7bed 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -765,20 +765,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
-#ifndef CONFIG_USER_ONLY
-/*
- * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
- * "real" interrupt event later. It does not need to be recorded for
- * replay purposes.
- */
-static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
-{
-    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    return !tcg_ops->need_replay_interrupt
-           || tcg_ops->need_replay_interrupt(interrupt_request);
-}
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool icount_exit_request(CPUState *cpu)
 {
     if (!icount_enabled()) {
@@ -862,7 +848,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
             if (tcg_ops->cpu_exec_interrupt &&
                 tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
-                if (need_replay_interrupt(cpu, interrupt_request)) {
+                if (!tcg_ops->need_replay_interrupt ||
+                    tcg_ops->need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
                 }
                 /*
-- 
2.34.1


