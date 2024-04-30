Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F00C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mc1-0007Oe-9m; Tue, 30 Apr 2024 08:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbr-00075L-P7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:24 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbk-0001pG-SL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:23 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so615052866b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480152; x=1715084952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVZawkKvVQR7O9F/TX/jD3cCMEtFFYeEPtpsgeiKfbg=;
 b=UmyjDXGx5jAtRGiU2m5mDQZcbyK35yNwueIgsrXq1nnW5at2Cd+C81TmzavUfJl5Ev
 wKu78/H6pSQCS149pyUc1DR0VY4EQ2eEiH0u4UmKQ//052UTVUiQ8PtwcZuJtGMuEE4I
 4GG6S3wuez6tAfxD0nvblLJZBN6FAraGV43icSYO4UCfK5A9PZSa0oHkuJ0vlwsS4BQG
 ML4FrL1XWV+jMJ4OncZmKZyaPwBT/xlOZc5jgUOr/fQ1E6oAxxs84im6blKFvoSFuwc0
 E6EhLwa1piEwzUn3pZINZspDZvNcKT6pslG5zihermkczFD5O46J1eMCZfVpXhgt30kn
 5xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480152; x=1715084952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVZawkKvVQR7O9F/TX/jD3cCMEtFFYeEPtpsgeiKfbg=;
 b=q8tt3oMV9AuJHO4qeqRy+lRsSgC2TS59Iwjf7bTiuhK0vOMmPhFcdQBoRFdjgNY+8c
 nWIkuoXlvFYS2gu9aEOCXR+GAayRiP5FrQD9RQsmv+RGv8xz7T+AzyOCgvV/t8BQL3ku
 XS/njcCQ3TUN5eOLjjzThNLQKf2OMYWMTK4Yvm1chytjfDXi7aY0D686DMcyyxpZSeBz
 aoFwCNPL4rK38s1X9bxQ6pEfyOPeQGRMSxtOnwSO6JM8MvSaNL5z+hxwi0ckWOKpo5dj
 IpvLLjAPCAZgEKYdp8AMcbrAMeu9HYfFKUYGwLCB9mMKxkirKC2sqvflTgtlbn1jZJVz
 OmnA==
X-Gm-Message-State: AOJu0Yzq15vvH2HRf1kSkfSRIxEvie0oItqmceH+vQ2IqJXO49rsXaLY
 6HYycnUsWfUbzqKpHE5FrJaSSpt7Xpdmtdl0g0C6CiZwPFoL9Hn1tTFKKvt+lbYczVSUxgv7tu9
 c
X-Google-Smtp-Source: AGHT+IE/q01qNd7xlHVEi1JetVv9zfzRkIw2oaHPyRLP0KPD98MUhERj7OY27tRjdm4/xQzrpkPY7Q==
X-Received: by 2002:a17:906:3e4d:b0:a55:653b:3981 with SMTP id
 t13-20020a1709063e4d00b00a55653b3981mr7958729eji.50.1714480152542; 
 Tue, 30 Apr 2024 05:29:12 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 k14-20020a170906128e00b00a525609ae30sm15013371ejb.169.2024.04.30.05.29.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:29:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/13] accel/tcg: Restrict icount to system emulation
Date: Tue, 30 Apr 2024 14:28:05 +0200
Message-ID: <20240430122808.72025-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

So far we don't support icount on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-24-philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2af0e964c1..49b4b57a56 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -781,6 +781,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 static inline bool icount_exit_request(CPUState *cpu)
 {
+#if defined(CONFIG_USER_ONLY)
+    return false;
+#else
     if (!icount_enabled()) {
         return false;
     }
@@ -788,6 +791,7 @@ static inline bool icount_exit_request(CPUState *cpu)
         return false;
     }
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+#endif
 }
 
 static inline bool cpu_handle_interrupt(CPUState *cpu,
@@ -802,12 +806,14 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         return false;
     }
 
+#if !defined(CONFIG_USER_ONLY)
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
+#endif /* !CONFIG_USER_ONLY */
 
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
-- 
2.41.0


