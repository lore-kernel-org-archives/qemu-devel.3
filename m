Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95588C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmT-0006tJ-8t; Mon, 05 Feb 2024 22:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmR-0006sW-Kt
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:51 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmC-0003Ci-Tf
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:51 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e04fd5e05aso106874b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188735; x=1707793535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6bw+vo5JatBKfHw3dI0irsDkK5JENn8mMxMtSK3thY=;
 b=ztsMqqUa5uQOI/phLa1S4y1yJ8B/sxXDQ0fwHY+8IfAtNMyeLVMjGpEW7leDPCCM7i
 iFRz5K7V49sNzyI4DY8tw5ED1zdsB/6pNefdEN1SGu7WwkgTl2cYK9ZRCiVC1kf7wrZx
 vIk2p0x6BkoXaZN0mXGX1I+1cA5qfolptwl5jZ8PnsKPw9KmJcOw5+xy1bzdx0gDmMHx
 l0Kbx+bqcLkuNhX0veSJod7Dk4g2tKA+Y7/Y+xRVMcdncrYohZ2+bD+IFu0X0+9Z9aiC
 22PgSyXipKjCdpkKkscSa9bkKRouAHqC2ENeMGAw9GkDA6Wc1Ykp19oWrDLj38I3xoIi
 duKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188735; x=1707793535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6bw+vo5JatBKfHw3dI0irsDkK5JENn8mMxMtSK3thY=;
 b=vPpPYY0gfpQG1xQncAWmGU+IlQnf6oTR1WY535OWms/z8OczvlPWqARPZs4p7X0wa9
 irhDHLJmrzHUJiIvXT3eWJ77N7Tsz9+qvXD81OXvbQMf1IGpb6D8pmXD93R7/rDcybhO
 YSjsLl/0bfPdeWv3DIXPp+yKTLBOcxNR6gqPzoKHt9Oxo2KEIgGOkbHq+b/Jh3Gt1IVT
 W/Kx23I4ZcDfXcUaBo/WqP7x/SqTJXZQGyrc8CtLcoqWz+NhNGIIDqyXLkJIRmTojF0O
 iahDBJPp2uaAtVjetjJOg7JS+OGhkltpDRr4E0nFsBCmb3LY3lT9CTBL4Gp8j1PjhECW
 YaLg==
X-Gm-Message-State: AOJu0Yyv8PyUaVhowoH1g23q3bImnUqYhEgHrhTqinKOdI3o2l+mGttx
 CnD/m9ngaYqVF8iuUDWPwThEckgu/k9DkgOoiWvUz81ic4hdOB4dHHWWIXbYMBeGVu7WwKfjwk5
 AQJ4=
X-Google-Smtp-Source: AGHT+IEgwbuGzWpy/YdZa8EljsI/4VDjTE9Yc8g3HOugDVw6I6xUAeU8bhJglrLA/0a0OI8Ope2j3g==
X-Received: by 2002:a62:e405:0:b0:6da:bcea:4cd4 with SMTP id
 r5-20020a62e405000000b006dabcea4cd4mr2011390pfh.16.1707188735655; 
 Mon, 05 Feb 2024 19:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV0nu4hV+42c5XWycC7UIfEGNXkD17R62Y7zKc7Qm/ASx7oHtrMviJt830t6SVB19nHbpf6SJiZvUcpqxMiH2SnX0a54qyuQ4rd
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 1/6] linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL for
 FEAT_MTE3
Date: Tue,  6 Feb 2024 13:05:22 +1000
Message-Id: <20240206030527.169147-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

When MTE3 is supported, the kernel maps
  PR_MTE_TCF_ASYNC | PR_MTE_TCF_SYNC
to
  MTE_CTRL_TCF_ASYMM
and from there to
  SCTLR_EL1.TCF0 = 3

There is no error reported for setting ASYNC | SYNC when MTE3 is not
supported; the kernel simply selects the ASYNC behavior of TCF0=2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_prctl.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 5067e7d731..49bd16aa95 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -173,21 +173,22 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        switch (arg2 & PR_MTE_TCF_MASK) {
-        case PR_MTE_TCF_NONE:
-        case PR_MTE_TCF_SYNC:
-        case PR_MTE_TCF_ASYNC:
-            break;
-        default:
-            return -EINVAL;
-        }
-
         /*
          * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         * Note that the syscall values are consistent with hw.
+         * Note that SYNC | ASYNC -> ASYMM with FEAT_MTE3,
+         * otherwise mte_update_sctlr_user chooses ASYNC.
          */
-        env->cp15.sctlr_el[1] =
-            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
+        unsigned tcf = 0;
+        if (arg2 & PR_MTE_TCF_ASYNC) {
+            if ((arg2 & PR_MTE_TCF_SYNC) && cpu_isar_feature(aa64_mte3, cpu)) {
+                tcf = 3;
+            } else {
+                tcf = 2;
+            }
+        } else if (arg2 & PR_MTE_TCF_SYNC) {
+            tcf = 1;
+        }
+        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.34.1


