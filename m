Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB81C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74F-0000S0-KY; Tue, 12 Mar 2024 14:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk741-0000LI-Sx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk740-0001MJ-FC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd8d586126so2017965ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268883; x=1710873683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8vhO1WDf0+YkBR/iCx/R6UcOGD7cvxq9c3tWVgAEV4=;
 b=UWk8Uy+zxiKaFc+TDbuBEkUT++UwrcCRM5ziy18KT2qAMFFbc52Hnlw63xXMx7PRIC
 XaFU4614XtGP5X88xk9gtnR09LI+vwfdiV1cWOkYZWYRduTyZq1T9ss+CxNaCdZz/8Nl
 G0PidEi6FR1f9GC2YFT8G+rbFiA8MhxOGoeMUxzONrEwOgutL2XOgi8JIz/AFA1+VNvI
 CYv+6qoEGifwqf0mK0CM4IiNjLblnvdtc3cHXlRRyXS2PjwLgRAfkzluhgJXepfmIEWi
 ImiCkm8a7unWgu0JW4rgyLNHzE14mNif2wmPRnitXF6lL3r2anrs9v+vnPtUT6UOaQBu
 4CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268883; x=1710873683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8vhO1WDf0+YkBR/iCx/R6UcOGD7cvxq9c3tWVgAEV4=;
 b=A5MVmtYjdJoPLNerMokLPupaKBZpC2DUeou/V7i2cCgpWRJ02VVGGuDF7xoUG7Z3up
 igBluuzRwFt018WjsZ38Pxpz2bVWS7tWw7DHNa/r3g9+75ceGoe4kLpFFdEZxl5fbkqW
 poOHZkgKZeK6SXKDrWrg+dwJnOqKFFsFIPHfCG1BRYtZdVMzx4giwfwXlCe5G+DmzEQh
 JV83dXAscAPDKbdI0/irNuAWvgHjiH4mHjUV5UISKtLJfQgRzZe5/Ja3yDk7hOi6CCAe
 4Qtle1w5vCrDYdF5pFFaUgPa7IDpoMCB6p3LGAM6kBSh7LThzAM8R7UFwqGoYbqXEyD7
 kSrA==
X-Gm-Message-State: AOJu0Yxr1MKLFg/HclyS5KsGlJVyVvvVlmzl71CFg+kTJjRywsUxj08A
 pVPDt/43BERVCcOilziAQV6iMQr6ZjJl6cDV1ykP8e9XWvcKQN9EDSfBy84JHH8W4OP+tRpwR2p
 o
X-Google-Smtp-Source: AGHT+IEU+pyNZVpa1n1RM/GtoQ8LLz7HxxQw5TaZ2ZbibbdLPUBwFF4MAZqbeosPWTVwEy39wn8FgA==
X-Received: by 2002:a17:903:2441:b0:1dd:63e2:2478 with SMTP id
 l1-20020a170903244100b001dd63e22478mr5745106pls.57.1710268883176; 
 Tue, 12 Mar 2024 11:41:23 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/8] linux-user: Implement PR_GET_TID_ADDRESS
Date: Tue, 12 Mar 2024 08:41:11 -1000
Message-Id: <20240312184115.365415-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4871c4b648..e12d969c2e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6468,8 +6468,10 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
         }
 
     case PR_GET_TID_ADDRESS:
-        /* TODO */
-        return -TARGET_EINVAL;
+        {
+            TaskState *ts = env_cpu(env)->opaque;
+            return put_user_ual(ts->child_tidptr, arg2);
+        }
 
     case PR_GET_FPEXC:
     case PR_SET_FPEXC:
-- 
2.34.1


