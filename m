Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650B3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFX-0000Af-Uq; Thu, 02 May 2024 01:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFL-0008U0-K2
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:43 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFC-0002fs-Lg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:43 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5aa362cc2ccso4856859eaf.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628673; x=1715233473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zw9e5BtuMbzLeV49JTlnqFQYfmJ+6A5JAzWr8qjGuDw=;
 b=jLFQ07SyaYLVy7wLONL+WC2EcquxA8HKKvHs+59TREGD53iFkPXYRnPT+ej07JC2xb
 a97rZqE84f/5gtsplxkdHWJY4xGKBK8BKMc1yg6fhtJPWYYUkmiJNsw5LVEYihD0FicA
 rXwV4zqGiNtWGgUeyKOTSTW1BwGyAmZOVM7t0eT4pH6XQiA/TxzapGbI0dLPBPzkc019
 JpyreA7lqAlJiIM3Ss59O888QWZghCxxITMnq6/8OGjBP/G1Kt12egtu+5f1BRfaZuAg
 q74HIkWPIXUo2Fh2zzGj0cG1AYz/ui7jElzNq9+B0OSLx7ETrNedPtyyZIGLPd7qTmoQ
 zpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628673; x=1715233473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zw9e5BtuMbzLeV49JTlnqFQYfmJ+6A5JAzWr8qjGuDw=;
 b=OaQSsaOCrjB7SJ3bvnt0bnn0oNTkBtx076oYTRPBJNHHFEgGXIQa+t3AojLCkhyUTf
 NB3pAzwDId7jL9jH/V1SUA0odtqn/gddRMkO7l5j8enVe4RKgf8tM37ngK8GXgKlsT57
 dM7yJtuEHWP5HNPUpbb6Ct6sApl/9NubWzPxrGFip3+GilhQ/nsrofrhtvc16uzEun7H
 aMfKWPvq0/eemfvNAG8bjG8/UhfF41QjHSFfPdZCsaGQoTD6N/Pt2/2P6My1w3phNQFG
 Z1rMw03SI907M/SJQzHXOjNR9eMLy1wIw2hyMo1FywGtKgp9KT5cOJ+3DzpaojJNItN5
 ZDkw==
X-Gm-Message-State: AOJu0Ywjf5FBvfzbDesjy6DC3f+5xDI8RUPnZECVoS66okESRN+qMMhC
 noKP/F9VzqoVVRjV8nCy7G9yCWy9bdhbALj8BeHuERmHmKdTK2Akj7xiqD4grlsXgF9B6/MTVp2
 u
X-Google-Smtp-Source: AGHT+IH8417a0IJJH7OuNqmg8fteiiRHEsz85XcTpbJD51JuxqhY8bFNABi2cQwGtOUAhm5y0iIbKw==
X-Received: by 2002:a05:6358:2911:b0:18d:8ef1:e77c with SMTP id
 y17-20020a056358291100b0018d8ef1e77cmr5588612rwb.15.1714628673561; 
 Wed, 01 May 2024 22:44:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 14/14] tests/tcg/s390x: Add per.S
Date: Wed,  1 May 2024 22:44:17 -0700
Message-Id: <20240502054417.234340-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Add a small test to avoid regressions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/per.S                   | 82 +++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/s390x/per.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 1a1f088b28..80159cccf5 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -25,6 +25,7 @@ ASM_TESTS =                                                                    \
     lpswe-early                                                                \
     lra                                                                        \
     mc                                                                         \
+    per                                                                        \
     precise-smc-softmmu                                                        \
     ssm-early                                                                  \
     stosm-early                                                                \
diff --git a/tests/tcg/s390x/per.S b/tests/tcg/s390x/per.S
new file mode 100644
index 0000000000..79e704a6ff
--- /dev/null
+++ b/tests/tcg/s390x/per.S
@@ -0,0 +1,82 @@
+	.org	0x8d
+ilc:
+	.org	0x8e
+program_interruption_code:
+	.org	0x96
+per_code:
+	.org	0x98
+per_address:
+	.org	0x150
+program_old_psw:
+	.org	0x1d0
+program_new_psw:
+	.quad	0, pgm_handler
+
+	.org	0x200			/* exit lowcore */
+
+per_on_psw:
+	.quad	0x4000000000000000, start_per
+per_on_regs:
+	.quad	0x80000000, 0, -1	/* successful-branching everywhere */
+per_off_regs:
+	.quad	0, 0 ,0
+success_psw:
+	.quad	0x2000000000000, 0xfff	/* see is_special_wait_psw() */
+failure_psw:
+	.quad	0x2000000000000, 0	/* disabled wait */
+
+	.org	0x2000			/* exit lowcore pages */
+
+	.globl _start
+_start:
+	lpswe	per_on_psw
+start_per:
+	lctlg	%c9, %c11, per_on_regs
+
+/* Test unconditional relative branch. */
+	larl	%r0, j1
+	larl	%r1, d1
+	lhi	%r2, 0
+j1:	j	d1
+	lpswe	failure_psw
+d1:
+
+/* Test unconditional indirect branch. */
+	larl	%r0, j2
+	larl	%r1, d2
+j2:	br	%r1
+	lpswe	failure_psw
+d2:
+
+/* Test conditional relative branch. */
+	larl	%r0, j3
+	larl	%r1, d3
+	clr	%r1, %r2	/* d3 != 0 */
+j3:	jne	d3
+	lpswe	failure_psw
+d3:
+
+/* Test conditional register branch. */
+	larl	%r0, j4
+	larl	%r1, d4
+	clr	%r1, %r2	/* d4 != 0 */
+j4:	bner	%r1
+	lpswe	failure_psw
+d4:
+
+/* Success! */
+	nop
+	lpswe	success_psw
+
+pgm_handler:
+	chhsi	program_interruption_code, 0x80	/* PER event? */
+	jne	fail
+	cli	per_code, 0x80		/* successful-branching event? */
+	jne	fail
+	clg	%r0, per_address	/* per_address == jump insn? */
+	jne	fail
+	clg	%r1, program_old_psw+8	/* psw.addr updated to dest? */
+	jne	fail
+	lpswe	program_old_psw
+fail:
+	lpswe	failure_psw
-- 
2.34.1


