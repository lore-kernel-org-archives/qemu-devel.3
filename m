Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D77C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMo-0006jI-Uw; Tue, 05 Mar 2024 02:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMM-0006Hx-5y
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMJ-0005u2-Kw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:09 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e5c0be115aso2443866b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624226; x=1710229026;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EWGUi9tBAet6Aqvwl5xC+YeARn1u1TklowkngVTL1c0=;
 b=rZEWCnoFrhc1fq1WA+tsYYzLWl4oLU92u3e17bx78ZbfFkDUMnAUTuVC9rc+7VJawL
 w/xqYJOhUqPHAJfowHd+3oZvFCcOtHuI5xludGFfdkfMR3T/QczBM20qi3XN5MDz6N3S
 KEd3eg8Gh8/n+aJbh+TRqzhNCTRr8847+3zuakHzxKw8WmoxkpJEQHXv6RM6tavsbmwM
 P693AiZ52Zs3iv3YYY1HQ/HPmsWl+wVzm8L6DF33sMGteiVyHIQtGDCz5zf15ltcqZOR
 5Hm5dLCJHW7NGe5B3grpaYT4LeJ5ZlaqntO/TMA9dC+VnoqnSU0IN4zTMUHl0sGMUHtY
 dqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624226; x=1710229026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWGUi9tBAet6Aqvwl5xC+YeARn1u1TklowkngVTL1c0=;
 b=MVXV4DOBjVRuPYVe/EZQKRmEYsitddyheL9DcVIkReb64ElCSpewWdrw93GYl/n4O4
 Q74JUU3nDMvXfOp8WQel80JDk9vLwez0BZFVEdyCViOul0njLSrN8W0R9d4QoSnmn1mH
 /Lb1leI+RLrpfFCwKGLoMpv46/R8kCXyTEQ3Wu1Wd4KBADIT0CZT4mSPc3Y1b8PuYm4b
 aP6f8uE3ixsivRNKpDU8ZFc7SrTF/NOxfhhAPZb9DWl3sR2DRFUAoSl3T7GYegHCvdo2
 Ys3Zy3ZsjiKYzDQW9G9X1qS2D1+xCM/FDPXJx//y5cWyy1bWgNGl3wTgVEWrje0iWwTl
 AW5Q==
X-Gm-Message-State: AOJu0YxlmYRQ5FGr+WYVWnM0tA97QxhgT91y+vMxBY4XsceuQziIit6l
 E+Atuho1eU3tvUA7ATRmssjUUvnWxUO2eLFNb41zTVUDO9mZFfBryccbHYwvIAPxUrEY7/zfSr+
 Z
X-Google-Smtp-Source: AGHT+IFhe+5xYJKgv+ZBAaqU3+ea4R9YNpa9nD7ebbLRStjcBw1fWGQfoualvzkrAFBHfe2CCXvbig==
X-Received: by 2002:a05:6a00:2d07:b0:6e5:f773:eb80 with SMTP id
 fa7-20020a056a002d0700b006e5f773eb80mr8723836pfb.24.1709624225669; 
 Mon, 04 Mar 2024 23:37:05 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 m2-20020a62f202000000b006e4432027d1sm8556709pfh.142.2024.03.04.23.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:37:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:29 +0900
Subject: [PATCH v2 12/13] contrib/elf2dmp: Use GPtrArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-12-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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


