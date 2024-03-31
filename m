Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC33CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphx-0002tO-Kv; Sun, 31 Mar 2024 03:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphv-0002t4-RJ; Sun, 31 Mar 2024 03:34:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphu-0002CL-9H; Sun, 31 Mar 2024 03:34:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso2111904b3a.1; 
 Sun, 31 Mar 2024 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870460; x=1712475260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9G/bE2e1fCaBb8no691midYL4f9HZ61fZW8qbGYtK4=;
 b=FaUFHwUsXCUdW5cC/qli4Km1V+4JUxba0kqrybrOmPWc82pQTFYxudAexKz+eW+SLa
 7IvUAVvju/nxf3Gc+wlg4Iwr9C8CtwfFQRmKOGVwYOmT7SjcvkkZ1X5pTlpcvoSIIwan
 7GkgMFjN9hKzYiUoZJWUGZ3PM1BJeXFTy3+FUNFXFE/innKK+zSIGvwnBIumvArbkeAL
 8cm5gWcNnn2X+B+Sxv1o7JdArZxmHrkg7t3Rq2nDH8gfVQ+beXqqOk/pnPkagCkfkmDO
 I8UoAQoB9ZN4vPviS5H34WOMOlQJV7ac35rxHqDNhYP0If5DYsc+PBJAaQDT4zUwsxdZ
 xTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870460; x=1712475260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9G/bE2e1fCaBb8no691midYL4f9HZ61fZW8qbGYtK4=;
 b=sDo7prh76pwuy8rQho0VN0aAqxwHT6B2kySFWGZWKmdwP78tUDbJ8qPsnMA1QlLwur
 5nC9DPbYq8+593tdXSQfc1G0jauhMJKKIDVh9mz4JGSMNYa8B6HAaJshBxUMH3Byn7e8
 uP0iWYILMFXCmmHwaOlpfFjPMp5tjDdQSp3CJXBtj+ylFQLMlfWV40Vnb73ZpiQysd+G
 ITCWpHmB/0UlhFXT+iHiaEZkK/gpYcYN/KeiaNMYn70jnslf55x82GePv63JT0SRoAoK
 qrWgitEdg61Ve8E7SvrIj2Tbd7fv5rXRZBFDimgsrKvNZFlUXke2ECR9BPtEyIJad7JL
 yhig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/BOvKOPb3J8XTkBPMrZxVeohHnUzXOHxF8aq5YpavBxKGZXltqVrB9sJqwzhlusLlEDC/EBtLLmtofRJeDVMVGnWm
X-Gm-Message-State: AOJu0YztuN2ksgAMTXR3kRVMzJ5GfD2dVHbbXnJ+BQcYRd74B1H4oiqO
 W75c/knJwnb0408qvMGoVpOGPMQBFOS8sOUS1wnpeUEmy6D6hM13xCsHJtLuNhA=
X-Google-Smtp-Source: AGHT+IFyJwjEuW4V9nOwNF0ZLnKXHmEN0ZfPZ7rd6qV+3uFsNhjZy7mGxaijQGbuGtt3OKh/a5bYtg==
X-Received: by 2002:a05:6a00:890:b0:6ea:f05c:5c16 with SMTP id
 q16-20020a056a00089000b006eaf05c5c16mr6320969pfj.5.1711870460303; 
 Sun, 31 Mar 2024 00:34:20 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Benjamin Gray <bgray@linux.ibm.com>
Subject: [PULL 5/8] target/ppc: Fix GDB register indexing on secondary CPUs
Date: Sun, 31 Mar 2024 17:33:42 +1000
Message-ID: <20240331073349.88324-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Benjamin Gray <bgray@linux.ibm.com>

The GDB server protocol assigns an arbitrary numbering of the SPRs.
We track this correspondence on each SPR with gdb_id, using it to
resolve any SPR requests GDB makes.

Early on we generate an XML representation of the SPRs to give GDB,
including this numbering. However the XML is cached globally, and we
skip setting the SPR gdb_id values on subsequent threads if we detect
it is cached. This causes QEMU to fail to resolve SPR requests against
secondary CPUs because it cannot find the matching gdb_id value on that
thread's SPRs.

This is a minimal fix to first assign the gdb_id values, then return
early if the XML is cached. Otherwise we generate the XML using the
now already initialised gdb_id values.

Fixes: 1b53948ff8f7 ("target/ppc: Use GDBFeature for dynamic XML")
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3f1e61bdb7..3b28d4e21c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -305,14 +305,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
     unsigned int num_regs = 0;
     int i;
 
-    if (pcc->gdb_spr.xml) {
-        return;
-    }
-
-    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
-                             "org.qemu.power.spr", "power-spr.xml",
-                             cs->gdb_num_regs);
-
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
@@ -320,9 +312,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
             continue;
         }
 
-        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
-                                       TARGET_LONG_BITS, num_regs,
-                                       "int", "spr");
         /*
          * GDB identifies registers based on the order they are
          * presented in the XML. These ids will not match QEMU's
@@ -335,6 +324,26 @@ static void gdb_gen_spr_feature(CPUState *cs)
         num_regs++;
     }
 
+    if (pcc->gdb_spr.xml) {
+        return;
+    }
+
+    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
+                             "org.qemu.power.spr", "power-spr.xml",
+                             cs->gdb_num_regs);
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
+                                       TARGET_LONG_BITS, spr->gdb_id,
+                                       "int", "spr");
+    }
+
     gdb_feature_builder_end(&builder);
 }
 #endif
-- 
2.43.0


