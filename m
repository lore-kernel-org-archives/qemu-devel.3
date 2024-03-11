Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklc-0005ou-2T; Mon, 11 Mar 2024 14:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklZ-0005g6-IR; Mon, 11 Mar 2024 14:52:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklX-00058k-W2; Mon, 11 Mar 2024 14:52:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso3390409b3a.1; 
 Mon, 11 Mar 2024 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183170; x=1710787970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+HiPneyq4qCJry8QSNDSO9d1TeusirkAe2ee2h8AX0=;
 b=Qok4vsYwBqHczDknzJO/ORvyz4eeN/7Q3EN5l+DZqM3NllMlObZZ2nD6A0l0MDVmsH
 6XpYnSQ8N431E0EuYR21Vk3WmDXXT5L34kaceP18ACJ9m9tCEAXMWPx65L5/dWbFCYap
 Mov9m8txsrm7MCHi8VderOA3QP0N6H+7ecPYIbisOcqjtrZNdF9USuSgYhIyOjIbGsaa
 kjXK4afhcFfBqCzVW9wJFpCUDRPfaG25PtzDfAFUdTCG6zP9pztA8Gsadym4TmTj4nKU
 0avAWAg1mHbX8ANuH/KOUDE8XQa+Eof02uSkLgebyPDS5jRESRosFt2TaPZK4kg+FmBk
 YioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183170; x=1710787970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+HiPneyq4qCJry8QSNDSO9d1TeusirkAe2ee2h8AX0=;
 b=k4DOlOjvuDGswVUhHLTTOWGU6Dotxi4/PwvnMJL8hjTUSJ916v+vFFGSI8ebV0j9o7
 8L0w6DeOYcvrQ1unvJZt9SmtnZS6iHJ5doibXs+IWTqgzB1FU5fg/cmI2R4n0JlmUo3y
 59hgoAALna6eqjCrwPptYiWvHLMBUrtsKwZ0n2PStyfJh3jkzwE1gN4rbCFj3AqU3C8x
 DSRAH4Z/g6qygbeVwbPj1waktpF9h6RVOmXrcUn8Oav30i1GPqM0kW7pgv8iFRQXso1K
 Twu0PtmsHsS8PhujBZTkFqkHe20LibD8NXBmy1rAnT2mNGBBaOKRKwS4TfNbX+5FdhvX
 a6Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZFPi/KBhdbhfut/DsqtgU/TbZ5/hIru8pvswippCe7UClxOtq3J0+Ljk3LSj+u2N8ls+UhtDZ2jW9q9Y42eI8vtZapk=
X-Gm-Message-State: AOJu0YxT1EAuJ/4q3nJbYwIHVmGb4n8sBszVmwfUZ0CaB4xGtBeWn1g5
 OeFMPBGImI6k24NAwG4vZvomk2jrpWXU127xemx1YINiAX9PAtK7jJsosg5CnoM=
X-Google-Smtp-Source: AGHT+IFR+fzCxPNniofEaq4bu9fchWH1PZRTSujb0i8O33bcmAdSth2c/ooUHgeEfqU6yiauk4ZbdA==
X-Received: by 2002:a05:6a20:7349:b0:1a1:3d87:422d with SMTP id
 v9-20020a056a20734900b001a13d87422dmr9298663pzc.45.1710183170243; 
 Mon, 11 Mar 2024 11:52:50 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 12/13] target/ppc: improve checkstop logging
Date: Tue, 12 Mar 2024 04:51:54 +1000
Message-ID: <20240311185200.2185753-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Change the logging not to print to stderr as well, because a
checkstop is a guest error (or perhaps a simulated machine error)
rather than a QEMU error, so send it to the log.

Update the checkstop message, and log CPU registers too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9aca4a1489..ad78d027e9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -429,6 +429,7 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
+    FILE *f;
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
@@ -440,12 +441,13 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
      * it is often a guest error).
      */
 
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
 
     qemu_system_guest_panicked(NULL);
 
-- 
2.42.0


