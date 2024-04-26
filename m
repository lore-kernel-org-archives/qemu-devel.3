Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVh-0001Rq-2J; Fri, 26 Apr 2024 15:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVa-00013a-Mu
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:22 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVX-0004Zl-Ln
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso424879566b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160718; x=1714765518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXDAwLQsv2ww5TZLeRIWY1HIfD/SnMqDRj2dwvAIHgY=;
 b=zu0zykhTN8O9lp5Zsdgu4VwjvzDUEvIzrQ5Kw5EnVtKG19iLemz1txafl1QoTp/M3C
 VxwCD7EI1r5c4FNXgnIMLJR/z3rqA1wPn3AZVMTH/08a/+0ZVyGSYQgB1h9Nosixboc0
 KkAatfjLLiEtJAbcJaDgzpxQO5PPvox7RyN+k7BXHJElGaiwHbhBWQhMbKvqzZydTW+p
 62aqij0dmkcDCkWBVOYxMsGyIBJfKeaH8HIIbAkkoaucioghN3YIW35Pslxr6BfPWXQC
 o5hY4OvOxvcbdd5HsanEkAKqkXMrACORfmcpHTacNouIxijrOHLBsby7p1xGYPqv7Yel
 4mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160718; x=1714765518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXDAwLQsv2ww5TZLeRIWY1HIfD/SnMqDRj2dwvAIHgY=;
 b=DSas6Z8R3cl1lL1+R8vNRG1wrdr+rrN32MeoMikrCRbWsp3/gdpA12nvtZHAtwPL6N
 K6dykh/etrNwodN1807+SIAOLIdNAzo+FGacRDhG4/W679SDB1p0eeYtf+mNpSJOouVm
 mct6glSbm+qwNRZkyipsxllPvcnymHcMBKmEIJFUqVYutGiyH3VTlvM8ADl6scvLAsrt
 TP5o6tKtCDZ+uRIuEaZHdzPY4SmLqMdYPZEwl4r48ZTIE7R9KusMojZbdMrneURH1ORf
 n+uXhB1w9+JuVMW//ufI4cganhNgectzfTbEOcRnocywFSjBsXjq1PC+R7q1/4DpLjZW
 j+cg==
X-Gm-Message-State: AOJu0YxnsvYwOdSWfUg4NtdmNo9NCYGYX709MRCUxYrLeRCesJFxw4Va
 O0f9klCg4ZKf84Np6xnGFlqP3FRTF2GqAyPxhFj1CyFnig5KM6jlBSV1xg/pSFiqmZY/xnpmaFt
 J6bE=
X-Google-Smtp-Source: AGHT+IEgJdTI8rt+PyOgpO3hCB5yaM4NBY8HNxEVtviUMKGm932HnqQvCPkqFfiDWe+9Ou9Pw85Csg==
X-Received: by 2002:a17:907:7244:b0:a58:c4f9:a2f7 with SMTP id
 ds4-20020a170907724400b00a58c4f9a2f7mr697418ejc.2.1714160717925; 
 Fri, 26 Apr 2024 12:45:17 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 cd19-20020a170906b35300b00a4673706b4dsm10888091ejb.78.2024.04.26.12.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 33/38] exec: Restrict 'cpu_ldst.h' to TCG accelerator
Date: Fri, 26 Apr 2024 21:41:53 +0200
Message-ID: <20240426194200.43723-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"exec/cpu_ldst.h" is specific to TCG, do not allow its
inclusion from other accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-6-philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 5b99666702..f3c2a3ca74 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -1,5 +1,5 @@
 /*
- *  Software MMU support
+ *  Software MMU support (per-target)
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -62,6 +62,10 @@
 #ifndef CPU_LDST_H
 #define CPU_LDST_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/memopidx.h"
 #include "exec/abi_ptr.h"
 #include "exec/mmu-access-type.h"
-- 
2.41.0


