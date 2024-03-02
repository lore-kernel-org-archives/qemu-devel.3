Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86E2C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjF-0005KD-5K; Fri, 01 Mar 2024 23:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpj-0008IF-3A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:36 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDph-0001px-Fa
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5a50d91b4so2238958b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 17:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709341591; x=1709946391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8MXSoWfmAHZQ0rBmuR55Qzx+gnIMTEYTxvhSOOyEls=;
 b=OQ8ujKQML2VNSxjZfF4sqOw0RJ0to+fk7a3jbGACjLfUNtc9glLvqT/cORLgh9+4sH
 FaRNfmnrp0R+0RMO1inS4stzQCsyhujWDRdqmcDOLBdv7hU6QwGcReNaGopsrn2AV5AO
 4OToHWtKIO/G90FbhX7h1B3me8zunAoHIp+KkFYM/NxJ7aKyaytBMlnA8tHP2gCzMZCN
 OZTz3m0D6HvqLCW38jBrZ9+7CrnAn8C6OLTNeiDGAqcrMfEHHumFbV3kfg5t5Pwdlsrq
 PGgIjJQ7sKzlTuP9lSSA9szADYp/8cnwDFpVw/2PNWSphmTOCPULi57SvIkg1Et7PxPk
 GYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709341591; x=1709946391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8MXSoWfmAHZQ0rBmuR55Qzx+gnIMTEYTxvhSOOyEls=;
 b=CN4K+swo0h52/1ysJNO8nizENViRTQTl73E9bbc07oH0L/bA2KavNkOT/j63epUzFT
 XSV+IatOkAMfjsYkY7g55975TrGM/DO4upBtG5nM2WTIK+7qas7xhS6Yx5OkhqY/YY6D
 jFgbwJxByh5pDLcYGhcJIFJa+X8XtkAv5cbA76trWNoMiLGmnoyWQjbQ6rfrgzpvUU4J
 4/LdV06ZZy4EPR5a67I7AppV7eHyAVQ4uC9gxpOCDUA0yI/6SrUKGWwH5fmwJc5jXAXc
 yRYnRU0tB6sxzverlcYoVwSvlyS9mpgquUWapFDS2oOHKXRGLh3E30TXh95mtlTrY6ZF
 j+MA==
X-Gm-Message-State: AOJu0YxLwGg1dTE8cEt5M87Tw8c6WHFAzRGShSSFMQ5Nm1u8svaL765f
 jKKWedpm3gWm4ZMg9HFpHxus18AYsZ3sESOv7MNxO/4ZwjrKC4VtRxKizxKB33hudnFPDD/yJZA
 j
X-Google-Smtp-Source: AGHT+IHkoNqNVXB9d/OkKFx4ZS9wore56vROYcDpgjJKiOjriAZ+vcrW2hvnFfE9GG7kWHjkS8k45A==
X-Received: by 2002:a05:6a21:2d86:b0:1a1:44f9:cbf3 with SMTP id
 ty6-20020a056a212d8600b001a144f9cbf3mr1035651pzb.57.1709341591585; 
 Fri, 01 Mar 2024 17:06:31 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lo21-20020a056a003d1500b006e5acdb5c94sm2399881pfb.176.2024.03.01.17.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 17:06:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 1/3] linux-user: Implement PR_{GET,SET}_CHILD_SUBREAPER
Date: Fri,  1 Mar 2024 15:06:25 -1000
Message-Id: <20240302010627.12998-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302010627.12998-1-richard.henderson@linaro.org>
References: <20240302010627.12998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The "set" prctl passes through integral values.
The "get" prctl returns the value into a pointer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1929
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bc8c06522f..263b651cc5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6450,11 +6450,21 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_NO_NEW_PRIVS:
     case PR_GET_IO_FLUSHER:
     case PR_SET_IO_FLUSHER:
+    case PR_SET_CHILD_SUBREAPER:
         /* Some prctl options have no pointer arguments and we can pass on. */
         return get_errno(prctl(option, arg2, arg3, arg4, arg5));
 
     case PR_GET_CHILD_SUBREAPER:
-    case PR_SET_CHILD_SUBREAPER:
+        {
+            int val;
+            ret = get_errno(prctl(PR_GET_CHILD_SUBREAPER, &val,
+                                  arg3, arg4, arg5));
+            if (!is_error(ret) && put_user_s32(val, arg2)) {
+                return -TARGET_EFAULT;
+            }
+            return ret;
+        }
+
     case PR_GET_SPECULATION_CTRL:
     case PR_SET_SPECULATION_CTRL:
     case PR_GET_TID_ADDRESS:
-- 
2.34.1


