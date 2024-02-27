Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BCAC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2Ve-0006ac-Kd; Tue, 27 Feb 2024 13:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vd-0006Zm-6g
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:57 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VZ-0001Ve-Oh
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:55 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e53f76898fso1210354b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059731; x=1709664531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzO2W+WajMGPZKg0sOd9kLpT7E3B/88XAmc0t2vBAHU=;
 b=nJ6ZO8FMeMfEoNkbIMVQkx6Gh39+vyaQ4VJBox+JMPRy83EE/xU23mgzqX3eGpeX9u
 Y4m3MbK1NgPSZIdtqpaBJrhxELAMHRxcVScau7vgbj2BJeeGmrH//P280Lr7MbFDvKKR
 3G3kIxP61Ps0oPiA1Cgk1OOTdm40AQXlOCR/gQDQMAUh47D0lSdLiF4xvh/3QnO2oQbn
 56E6W+1NCDj9bJeCW2nTOwyuNpuECh9BHXAXfo1e+3Lh9uO3r76waCRAXKQAeUAl73OC
 T1dRDZkMy5cFEciqC+gwxIpOCJCLT2B8GBiubU1g9LI1s5skTpKWZ0vqqi0ZIIai8DU1
 B39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059731; x=1709664531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzO2W+WajMGPZKg0sOd9kLpT7E3B/88XAmc0t2vBAHU=;
 b=CHCz7wPPpXOjMowAOXs2rCNnmwAP2luC4UxOiDVwcDk52sXSJSZ/7+iLerBIDdVEVv
 rfCJldFJHl2P2C2cdJvJpuc0UsJkVmlO4iMpRPWkrG62WhG/WF5pbeD8+a5EBwrqD+XO
 zDifb5a7+2Qms8jZ4mhHGDTTUlJZ6J2eKmeifDiAw9vTlBGMmY5BFaiXJ2TcDf9H4gZU
 eTIjqfamFifBzDrUFZcgRsuMnjPdfR7MP2dTpevuEgJ/Q6X+8oLvoq2bdfLryjwP55Kw
 B7fRaD/6+5wh5RC7wLqeVGCWbNsgKGMLtkEFicKPG9NoOiENvzfT+SuodyRZ1Oox3/wA
 IfhA==
X-Gm-Message-State: AOJu0Ywr2zsqZliRQujKLG7xSVfYrnIrHZzE6PQWqsZMZc2pvbwA1Jhh
 SJuZqVmUztPlGD1wdMm10xJKxlPAevnoY7cXZkvMNwfVzZWG+0Q1uU6gVAb2u+pDEZJIP2xBLKT
 L
X-Google-Smtp-Source: AGHT+IFwktXTj333cP6pxP7EV0Ih3RdsH+v8ojIC9qWKCo/Dzqwwl6wVBIG30ZVmYfjBTF1qHxfvdw==
X-Received: by 2002:aa7:88d4:0:b0:6e5:456b:bff9 with SMTP id
 k20-20020aa788d4000000b006e5456bbff9mr4604881pff.12.1709059731642; 
 Tue, 27 Feb 2024 10:48:51 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 11/14] linux-user/elfload: Write process memory to core file
 in larger chunks
Date: Tue, 27 Feb 2024 08:48:30 -1000
Message-Id: <20240227184833.193836-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We do not need to copy pages from guest memory before writing
them out.  Because vmas are contiguous in host memory, we can
write them in one go.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8d07d8054..491e754f72 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4551,32 +4551,13 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
 
     /*
-     * Finally we can dump process memory into corefile as well.
+     * Finally write process memory into the corefile as well.
      */
     for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-        abi_ulong addr;
-        abi_ulong end;
+        size_t size = vma_dump_size(vma);
 
-        end = vma->vma_start + vma_dump_size(vma);
-
-        for (addr = vma->vma_start; addr < end;
-             addr += TARGET_PAGE_SIZE) {
-            char page[TARGET_PAGE_SIZE];
-            int error;
-
-            /*
-             *  Read in page from target process memory and
-             *  write it to coredump file.
-             */
-            error = copy_from_user(page, addr, sizeof (page));
-            if (error != 0) {
-                (void) fprintf(stderr, "unable to dump " TARGET_ABI_FMT_lx "\n",
-                               addr);
-                errno = -error;
-                goto out;
-            }
-            if (dump_write(fd, page, TARGET_PAGE_SIZE) < 0)
-                goto out;
+        if (size && dump_write(fd, g2h_untagged(vma->vma_start), size) < 0) {
+            goto out;
         }
     }
     errno = 0;
-- 
2.34.1


