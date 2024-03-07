Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9610C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsw-0005dJ-A9; Thu, 07 Mar 2024 05:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsp-0005WB-Vb
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:52 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAso-0007F5-Dp
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:51 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bd72353d9fso307265b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806909; x=1710411709;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SWv/n6ZKj2r4AuXL4UqGI23kMpuzOnRejuu9Q3uLHrw=;
 b=1/Qkl/BSvuZ6Pe3LVvtuswGUfBtm7SsFOUeu8q4a2/hmrZyqrPf83Yce+6tiziCs1Z
 MX8QreJRjSHCheIMIUNYPZOQ7YRSpKRIGccBfUOqcT4SFUvCgGQA7849dFjKqPszT2vQ
 nKcPShyWvF+XwJpN1zgTn7FhDKTGb5YK/mbca3luGdM2maRvYmAWvZtitT0Mzod8e+bG
 CZ1BUiphKfr5R5ltj0Sbc12Zv9j3wOr45Bb9g4xCzJbsUywxIIKcbvXYjpR0MoXfQJxi
 V9B1eVJjQkHKPByE8uWjMt4ObMRdTLuMSgZuF7NJZxMf4z6bLNuPPsprXNbBEIPrPG8n
 +L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806909; x=1710411709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWv/n6ZKj2r4AuXL4UqGI23kMpuzOnRejuu9Q3uLHrw=;
 b=WWE6mut/BExNniJ2LHmQHuW4CBZB9aXyhO95NEyLiVrSWaYtxBHt6UNZUOIoG35hnY
 5VNmDL+VXLkPOJOJ0Ux+QsNBmPwaMd7yZPXK3w1Fbt2bUbZzs7TIqx9aeWVJmF7OF/hT
 zGTAdNe7+z1uhX7yY0G3vfAqvxOtF0445oVvWW4x08iLGif76SDauJChqdo5ZppbeG9b
 oIqOdaNDgP4js0CbRWQH7+9dPDxfqLOFWHHEOLLGlAIOKbcPFLjMH/+PTyRxMmpJxfZ0
 tdsT0UMvb1QSI103nGCVOeBfsQJNSMHp/M2XrXLeF321wyqg6qavOwzbs93GqPxg7/XJ
 pcPg==
X-Gm-Message-State: AOJu0YyaA8CwGnWgnhB2frDql62ufe4ScBUILiBMtwJuBQ3QaZZCABL5
 /DkDTooMwofGC8otzHaqvm3VIwj4xS1XWlZM3Sr11ro7HJd5HSZBkQ9JbrtfCnJQBVokuDQg33M
 K
X-Google-Smtp-Source: AGHT+IGwXSPAhhT9Q4vOFxyGynKFUYnnavYEGXAQmIVBHM/YfXvH1OF/25PjupTjV2WjuH/DqXkvgQ==
X-Received: by 2002:a05:6870:a70a:b0:21e:5a2b:58ac with SMTP id
 g10-20020a056870a70a00b0021e5a2b58acmr7672016oam.15.1709806909126; 
 Thu, 07 Mar 2024 02:21:49 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 r11-20020a63ec4b000000b005d880b41598sm12186644pgj.94.2024.03.07.02.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:21:00 +0900
Subject: [PATCH v4 17/19] contrib/elf2dmp: Use GPtrArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-17-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This removes the need to enumarate QEMUCPUState twice and saves code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index a22c057d3ec3..7d896cac5b15 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -66,7 +66,7 @@ static bool init_states(QEMU_Elf *qe)
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
     Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
-    size_t cpu_nr = 0;
+    GPtrArray *states;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,38 +74,29 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    states = g_ptr_array_new();
 
     for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
         if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
             QEMUCPUState *state = nhdr_get_desc(nhdr);
 
             if (state->size < sizeof(*state)) {
-                eprintf("CPU #%zu: QEMU CPU state size %u doesn't match\n",
-                        cpu_nr, state->size);
+                eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
+                        states->len, state->size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.
                  */
                 qe->has_kernel_gs_base = 0;
             }
-            cpu_nr++;
+            g_ptr_array_add(states, state);
         }
     }
 
-    printf("%zu CPU states has been found\n", cpu_nr);
+    printf("%u CPU states has been found\n", states->len);
 
-    qe->state = g_new(QEMUCPUState*, cpu_nr);
-
-    cpu_nr = 0;
-
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            qe->state[cpu_nr] = nhdr_get_desc(nhdr);
-            cpu_nr++;
-        }
-    }
-
-    qe->state_nr = cpu_nr;
+    qe->state_nr = states->len;
+    qe->state = (void *)g_ptr_array_free(states, FALSE);
 
     return true;
 }

-- 
2.44.0


