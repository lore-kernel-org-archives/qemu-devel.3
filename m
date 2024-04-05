Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E59C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgm7-0006uM-Ul; Fri, 05 Apr 2024 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglM-000682-U8
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglL-0004oM-Bq
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso1376979b3a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312734; x=1712917534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D538lejiqMy2S3Z/eKkMIrZXKbMQWBqQMNIx5hsPK8Q=;
 b=bMhWn3wiEcWbk+XzBA0ZZijYelGcL3wzK7QTmtAxA1maJsfUm997ddLCMGclxfCD7t
 I43Q7fjhWCQMMXrME5Oi6B67NUZeNN8J5n4Yw3Y5Xf+2an485qoIP2lWbD5Msn2C4FEA
 O3F6X3GDECYiyRtUzLyKlqTzTSHyOimNl6ZqXcaX7HMDWC+FXrnQJ9NledGlQ6VoFTQ7
 4ZZAZo5BQH6qcvCMz/Gl32zGdNPijl26rMKW7DxSrR1ltKPFWb8aDYSJimF9/Ty1xe2a
 kshRBzctA4xitm4yXepcmRPCLcRebe0UP6/MAjUD/KvXLctF1OCbzt7l3TvifRrtHnZR
 NSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312734; x=1712917534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D538lejiqMy2S3Z/eKkMIrZXKbMQWBqQMNIx5hsPK8Q=;
 b=Ogm7FtXVVgBHdjg6lgbAAYy4dC1MpYnZKLgd82WwS9X4A/9BIyS4CkLqAbhu82XOix
 TELsI/kn/MXXs9hC+7EsSRIPKOXTCshRuVmqXUmcK3B9y/RbJDZbY0bgBXtgxgkO0+tD
 T8vANSjyXC/ckOAfuK2X04NvmMTAEatvIwu6x1cvpqLE1GRV/H1ocIZHp9nYuZvxIKTc
 nk2jMZn1mRmCkPe0ZKMapwOdCa+oWTPe7ytQctTPmp7gH7pyELpjXs9uMpSVBHEg6jaZ
 v+sdO7b8Riwd28SuGZFzjN/fBMcjrSU7u90XR8MMdZQ211vVNVfEikESv2hdN/7s+IhO
 I8gQ==
X-Gm-Message-State: AOJu0YwZ7XvvTUiRUicc7mM0bpEPgzEoGqigBk0VhKLZAqSyMNKov08x
 vtYVz+xE7WTx3IwzrPZEa3RH1vVMFtS4UN9Pe/dZz1mbyeSP6QPL3AVOLBVGC01y6u5aPk7+ZWj
 S
X-Google-Smtp-Source: AGHT+IF0ai+as3Dy8k28EnglHZ4to917VnzkrfmHpwC9n/h1+wDyftmiUP6OQSXiP7JKu1pv6fetpg==
X-Received: by 2002:a05:6a00:3d49:b0:6ec:da37:d09 with SMTP id
 lp9-20020a056a003d4900b006ecda370d09mr1049329pfb.16.1712312734117; 
 Fri, 05 Apr 2024 03:25:34 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/32] target/i386: Use translator_ldub for everything
Date: Fri,  5 Apr 2024 00:24:52 -1000
Message-Id: <20240405102459.462551-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 796180f085..d0ba81eb6d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "fpu/softfloat.h"
 
@@ -2137,9 +2136,8 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
          * This can happen even if the operand is only one byte long!
          */
         if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
-            volatile uint8_t unused =
-                cpu_ldub_code(env, (s->pc - 1) & TARGET_PAGE_MASK);
-            (void) unused;
+            (void)translator_ldub(env, &s->base,
+                                  (s->pc - 1) & TARGET_PAGE_MASK);
         }
         siglongjmp(s->jmpbuf, 1);
     }
@@ -2717,7 +2715,7 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
 
             fprintf(logfile, "ILLOPC: " TARGET_FMT_lx ":", pc);
             for (; pc < end; ++pc) {
-                fprintf(logfile, " %02x", cpu_ldub_code(env, pc));
+                fprintf(logfile, " %02x", translator_ldub(env, &s->base, pc));
             }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
-- 
2.34.1


