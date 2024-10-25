Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961BD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Oac-0002ef-7o; Fri, 25 Oct 2024 13:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Oaa-0002e6-Og
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:08 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OaY-0002Ko-UN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso1604740a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729879145; x=1730483945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znPbUZNNslddQtH/rLaGSWOe8DbymY8ZMMF9baiLEDo=;
 b=yHHVX14TBk+qTYIwxrqUH1HZ5sayggAehz0txQndHCV7cd9O3Xtt3lg/Weh/USDVe2
 RBam0Q/jsyAVtJIZ0bXoCs0X2Hi09DMglSztadBJmys4q2xtItmTGjaRUVDFQzRJktTo
 ErHugZtpSwJ0If23fqGvQhchpDvahg4JQjNyYvhUVebqJNW/MU/nvP1kcLAPiNuqdtXs
 qIUw+g5bJCUwhDj9erxIaFKqcIoSNpjDbOvQMoL/aMPA+VnrZEdiRRdYZddXuqLek+fi
 eXH9E80Q9t0yseO6M/XH6G4jt98PDPfwpyhUrWvY9lHzV8W+294Yf0ScJtr14ugiHFCn
 IR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729879145; x=1730483945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znPbUZNNslddQtH/rLaGSWOe8DbymY8ZMMF9baiLEDo=;
 b=Sixb0v88NuN9CqK1hgduhXZppBAScEXxA+1gUUTRMQp+jQ61suqXEz0XmSNS97pvMF
 xVwtSOAz6LYnojjk61T/CsNPqSnDiWqi7CEiY47RFHJNUOKcHCwqSFM+HLF635A4+rhe
 tBv8hlQ7tKNl/1lJ9ryTgzYUkgwhaW8QlSEI1EcX1BoimvFoqtzq2GYXQ0Vz/+qQtSlW
 W7Uwbso/dKP8x9qGL8Hv2CpEScW3Fast8I9AAWaJa3haJvQfK6L3rbZR4pOdzRuSpZ+k
 k6UcsVq01Dk8FmQVXmwcRB6NvEH24wZwtCUAfl1eWfV8NZrvm1RciK4PiCaRXXuXjH3M
 n3Lg==
X-Gm-Message-State: AOJu0Yzv/Ws3Btz0Ad3IfSa1XXv5F5hrLHiOScBDcYpggQCNsJ3oqBVY
 z6liW8dGsyqtAhjHaEC5yeuLnm6I3khfqspVsYKY1ad/qPiDw7MkWYUgtBiUh5PtTrtcAAT3Mq+
 1SC/cEw==
X-Google-Smtp-Source: AGHT+IFEIbN5ucd0K4JrZaLhNCHpSxdelyJi1BrseWQmDZDFAGld0WuhFZh0tunxTZ0e3ACllcSuEw==
X-Received: by 2002:a05:6a21:1707:b0:1d9:17fa:e5d8 with SMTP id
 adf61e73a8af0-1d9a846a5e3mr82205637.26.1729879145415; 
 Fri, 25 Oct 2024 10:59:05 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8679eecsm1358056a12.26.2024.10.25.10.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:59:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/2] target/i386: fix hang when using slow path for ptw_setl
Date: Fri, 25 Oct 2024 10:58:56 -0700
Message-Id: <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

When instrumenting memory accesses for plugin, we force memory accesses
to use the slow path for mmu [1]. This create a situation where we end
up calling ptw_setl_slow. This was fixed recently in [2] but the issue
still could appear out of plugins use case.

Since this function gets called during a cpu_exec, start_exclusive then
hangs. This exclusive section was introduced initially for security
reasons [3].

I suspect this code path was never triggered, because ptw_setl_slow
would always be called transitively from cpu_exec, resulting in a hang.

[1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
[2] https://gitlab.com/qemu-project/qemu/-/commit/115ade42d50144c15b74368d32dc734ea277d853
[3] https://gitlab.com/qemu-project/qemu/-/issues/279

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index da187c8792a..ddc51e3e0b8 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -107,6 +107,10 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
+    CPUState *cpu = env_cpu(in->env);
+    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
+    g_assert(cpu->running);
+    cpu_exec_end(cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
     cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
@@ -114,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
         cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
+    cpu_exec_start(cpu);
     return cmp == old;
 }
 
-- 
2.39.5


