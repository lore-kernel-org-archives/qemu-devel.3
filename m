Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4B6D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nvs-0006YJ-5Z; Tue, 29 Oct 2024 11:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nsC-0000pD-0N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns3-0007jX-Kv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4319399a411so42333895e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214658; x=1730819458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+ZkiB0yRpxPAiy0AdprSxhYgetza8NXjghFFGQPPbg=;
 b=WBmPB+j+ECukrqDHMt76xJCIllMoxxVXrr4mBIfCYv835SIQi8E3h8KQcZOe+pOhfB
 3mnsjYvKL4585C/neGFSXsM4ikJU5jmdujBhnuJRjPIQTLR9kVRZBIawp1/v2YMr7D5c
 6p9XGXIOHRQU2GJBUvvyDZLigy0oz1XtOwpk3oMSDgdfUB1hlYhj/3VxXcj2oPbVDocW
 AhuzVOyONsFwXV4Q6gyRt6OVQ4QIvjQwKoCN+a9LPJBrPc5pZvPPV63Soie4DF1XjfSF
 HMI/XHufUa/4qWFtfQswWNmSyRCAaF7h6zIpxcBFxvGV2hgUwixDmPMLrdXtBk8vsVMX
 2IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214658; x=1730819458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+ZkiB0yRpxPAiy0AdprSxhYgetza8NXjghFFGQPPbg=;
 b=h6BT3kCX4UyxiE/OXCiaZ4DYby7yCffUDjm/mOqzsBPUXqxlYn42V8SkMV4C9l9jbp
 xd44p2eMwQAYuPEyPbpEAvw4hBLnx8NymRNKPQS7NzMmcG9VeiMOvtnJSw9StdFT+mGI
 W7iH/9c6tCTh2EOZ9MyGNeuySnJfY4t1HeTNcZpGIBSlP0yPuyjPawXpbWb8Wlm4ikAi
 +35CfY1hXrdpoZxmPzuPWIosqktIjJid+cjsYhfD1M3NwQ8vh/uFlgY76gJi4XTaz07A
 Xaub4wKzUACUtpyzNbu5ekMHaUFZez/G/U7mz0Tqn/Kn5iCjIzlDTPpEgWUYZ2rmNr1O
 q2hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIpG9bthRGP6RuUk9COY8BT6auyaHpiqVIuMiq2wQNuQnXcTWr0A3bZnhKCeF4pWE9oabG8XAxFSOC@nongnu.org
X-Gm-Message-State: AOJu0YzsI8soAY823Kw9rQBbN2Qe87mwfDjxo3PJhxdXTxX5O9iyqKvu
 +P42UqwE173/+1QS6Ta7BsWCwuhfexwFDtKFNwQDfz7jxDSw6Jj7idmuyZk8+zmaH67V90O0tm8
 i
X-Google-Smtp-Source: AGHT+IFLVrKnjhl6V/CAmcCcTnVMiNhXdDcchzfEkLM310aXBoSI0dQsighiwi/TkMWXYXVt02EjgA==
X-Received: by 2002:a05:600c:1c95:b0:42f:6d3d:399f with SMTP id
 5b1f17b1804b1-4319acbab55mr111741305e9.21.1730214658108; 
 Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/18] target/arm: Fix arithmetic underflow in SETM instruction
Date: Tue, 29 Oct 2024 15:10:46 +0000
Message-Id: <20241029151048.1047247-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Ido Plat <ido.plat1@ibm.com>

Pass the stage size to step function callback, otherwise do_setm
would hang when size is larger then page size because stage size
would underflow.  This fix changes do_setm to be more inline with
do_setp.

Cc: qemu-stable@nongnu.org
Fixes: 0e92818887dee ("target/arm: Implement the SET* instructions")
Signed-off-by: Ido Plat <ido.plat1@ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025024909.799989-1-ido.plat1@ibm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 56b431faf57..8f42a28d07b 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1348,7 +1348,7 @@ static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     /* Do the actual memset: we leave the last partial page to SETE */
     stagesetsize = setsize & TARGET_PAGE_MASK;
     while (stagesetsize > 0) {
-        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        step = stepfn(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
         toaddr += step;
         setsize -= step;
         stagesetsize -= step;
-- 
2.34.1


