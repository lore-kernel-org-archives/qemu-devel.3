Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A05C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQd-0006R4-Fg; Sat, 18 May 2024 05:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQb-0006PB-Q8; Sat, 18 May 2024 05:32:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQR-0005oa-Cc; Sat, 18 May 2024 05:32:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so31828615ad.2; 
 Sat, 18 May 2024 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024741; x=1716629541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgJrCCZZWo/VI2Gs8h/qaG/qmQuOyLSxM5HbB7cUtW8=;
 b=YYshcTmyM1K7FI+nP7w5Ok6Q5/29XNGrWsgqwgc4SogdW5kLE/v9sj581zXAIYXGM6
 smnqoFLMJ66JuerKuMxZs5RpttSlmNWcEspgdFf0wDMz3qnOiY6rOkcH735MEwc4h+Rj
 Ffv62uHiww23dlxw4u3TqulF3YXIoSbbsD8DEkQf+mWkBYxzg5AKv0sPgQzXjyXFLSKx
 BAq7PwU20bzisoA00yfPzB2CV1YkA/jzNrLiycc/LGNRAIbCdwLecxIvZSW1WVlact9V
 wRDry09w/zyt3wFVuN/UGXsz/oUDZEtr+oTeNeQfjsPBUY8TzPi3sfBC9Z69J4nTeVNG
 J8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024741; x=1716629541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgJrCCZZWo/VI2Gs8h/qaG/qmQuOyLSxM5HbB7cUtW8=;
 b=UdMC9sgWxuwSDBtrs4Oj5lod4K+16a99ey/CPvSujNiu2Q3Kb+m7XgeOK+U1W8BnAp
 j01dwYGLFyYOk3TgxgTTilf0Q5Sn1yf0vS0rVk9SaNqmrPsGfSss5HMyArDdrQGVkkaS
 bzrBspVDrCQD3Yml/nNCxL5kEY5gkjiKKGmm7RJwGovGtzDcrNoSXOJpUw+n6mDY+i5H
 /+n11A/FjcCPm43or4f2d2UfD32zas+nR7RBp60CxZAtV15oSxKpuOQ8CeUF3KL1NYfL
 mcJccUIcl/QJkxNo5HeFzyqm5tlAXLOTuYSRwNbxbrkIOhglVmxXJ5TCDuJ31SkShN04
 rbzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0y1GlGCZ9hpcf376VLWylb0l92sbQS5TK7THddLsh48chWLUvm6zZO5GE4GHPXSC9Z+M0tRFQoqiuWXhCc20/AE+jr7E=
X-Gm-Message-State: AOJu0YxojF+iYTeIUbX/6U6ak+rfPA8Jp5q86dazkYszOR1jpn9Qzkn3
 5egNS9uVutPiecbiIdpYIKYfiZSpYVIODIsRX/zVtNp/Zf/zER+gJ3b/Hg==
X-Google-Smtp-Source: AGHT+IFOxM7n74TgMVUm3YbbzQFZO7XzCT2I4T8O56HkzNPPiBGp0F4OE65IyWuaagmMHzMr4qAXwg==
X-Received: by 2002:a05:6a20:9190:b0:1a9:852f:6acf with SMTP id
 adf61e73a8af0-1afde0a8e5dmr25261146637.11.1716024741426; 
 Sat, 18 May 2024 02:32:21 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 04/14] target/ppc: improve checkstop logging
Date: Sat, 18 May 2024 19:31:46 +1000
Message-ID: <20240518093157.407144-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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


