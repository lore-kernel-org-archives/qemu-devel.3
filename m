Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB1C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZR-00020v-G3; Thu, 23 May 2024 19:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ8-0000S5-VO; Thu, 23 May 2024 19:09:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYz-0005oX-Kn; Thu, 23 May 2024 19:09:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ad4so3283876b3a.1; 
 Thu, 23 May 2024 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505769; x=1717110569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQGT5w4aVKrr3NPxoIEcsxRySTZpkRG07sbTk9FlNkw=;
 b=UxQnj55EHIxBFVBb4z9R1WsIiB10pTkiGO+i/W05ebHqweQ/eaoxsPoVT+xGmpTZyf
 FQCOQlPEvC25ZqEnSOUhzpoguh69gfzRvlUtZpVpplbdCowzeYmZ/+re3kftbGFgrlU7
 7pRHQJuubZaHQ6YQNwJp3xXpRGOOutGJPifUrBpk22osQNu/WqkOYcuAtMMwPU+GQGFG
 X+YLQ7REjmw33JTiS3lqHezIsQtgfeqPRblmNbuC7yS67m2r1QL5BlPEaU/VvuUS0k22
 bZTIuDvRVrbfw+0GB9uX9d49TNuUdLAKoA3k6mtLRo5oFU2n7XY5dh5NEnmGg0Hvx+rm
 rKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505769; x=1717110569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQGT5w4aVKrr3NPxoIEcsxRySTZpkRG07sbTk9FlNkw=;
 b=DyRraIVHwrMDStTIa/Lnx53C4ciTYZEvTRFqXboCga1KMz+gbMwclDqVJo/A6eBCPM
 e6FGAdaOs9RZcEMoM/EQrlLEW6XV3zIm5rRe721Qk9oSVDTpbL1L8lWgrxR+Ux1RW8qK
 dypCIHmMT9TZyv8WbccsPWStDT4ZKFV35SD4yGNFmuufUKjOm1UGS3WTHlfkiRERejlS
 NysYv1oZm84usb5ZJDigZt+D7BBSZQXl6OvVW/iKiHTxVBlmd/eKHIvTv4RC1EYJCYln
 P6OMSmSf9FsrPMinN6esqTCsY5glyVJ4IP/zORvvVw5B9G5jxCFiWUVpfixEtRohk/9v
 Jd/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/qSdHpCGKP/FZaQS0jAAEwQQxTxIAAbHqiwZLBhU+6Tn1iymkCKZQRbleFSx0YBnQZgni4T6yc6/cM1Sm42YlL9y
X-Gm-Message-State: AOJu0YwvGSlicTY5ZQNPWPHc6Q6N327cMK7NnjQdbHfRMBN5snHahh6+
 Pv/fT3/JDTxOGS4wVVH4Ore0H6g4YnydqkKIb+6DtskMU/GZVtzxlWmhqA==
X-Google-Smtp-Source: AGHT+IFgw/a0XoHbM68ttsRirMFYivy84iFwboS8VPZmN8JCDHRRgg6SmJluSmDlrr4r4CJoJlI2zA==
X-Received: by 2002:a05:6a00:2a07:b0:6f3:34c0:13c9 with SMTP id
 d2e1a72fcca58-6f8f42af798mr571005b3a.29.1716505769334; 
 Thu, 23 May 2024 16:09:29 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 29/72] target/ppc: improve checkstop logging
Date: Fri, 24 May 2024 09:07:02 +1000
Message-ID: <20240523230747.45703-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Change the logging not to print to stderr as well, because a
checkstop is a guest error (or perhaps a simulated machine error)
rather than a QEMU error, so send it to the log.

Update the checkstop message, and log CPU registers too.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fd00c044b5..a283c97717 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -430,17 +430,19 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     /* KVM guests always have MSR[ME] enabled */
 #ifdef CONFIG_TCG
     CPUState *cs = env_cpu(env);
+    FILE *f;
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
 
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
-    if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: "
+                   "machine check with MSR[ME]=0\n");
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
+    }
 
     /*
      * This stops the machine and logs CPU state without killing QEMU
-- 
2.43.0


