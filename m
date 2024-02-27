Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B2C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VV-0006Xi-4I; Tue, 27 Feb 2024 13:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VT-0006Wb-Hs
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:47 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VS-0001Tp-4p
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:47 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c1a7d51fb5so1209222b6e.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059725; x=1709664525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjNGmK53xTEM4PEP/wzxcWkZ/m9cBOwh2M6e53eVpiA=;
 b=H8CbB2ObOaECqOHiTpuCP40k83kMXOXglRn98bVANnPu4CuOSbphs5JzntlE9p06XA
 DisI2QF3aWWfhMPD6GKsEiggz1z6iIZLWOBi+iNEU2Xnwdv9tkpEIGqpoTBg/0dxl5t4
 B566IxnFyL5x3wJP4RcJYVLrfGxXPLr8y5fBRsOMYEEZv5PqRh0HdnyNNoJOnznZ1nxO
 jXjzfmrNSU7wlSlZYIHdti/0ylxRCaHTYnti0op0fDBnkoy/9ZXYZowEre/w3eE5YOwl
 QoawxWchR8tsrTQhzikZdOQXTbbVt0T/5nQ0TFkd0PXsxeUMPQR7BWCS9HV3ZKAtV8kI
 0Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059725; x=1709664525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjNGmK53xTEM4PEP/wzxcWkZ/m9cBOwh2M6e53eVpiA=;
 b=JgLZunwSZi81ci/+f1ZQ5g0hnRRdzKvKChN1fOoDL/pS01Ip/ZDNPaB5ETM8VncEiT
 +3rMMlTJ9HwrL6j6661YeatsD8+b7wyAP4JCU9b3XWPUf+P+maubzKGpPKfJWoI1Xp5C
 Ik1AOrRuUlH6NW+QgHuGRJI2ob8Qa9lwmV6JMkDJe+GjRqzuM7yVYo8jmg3/O54fJ31/
 Rz7hY6C/lzSdZ8sizf+kGu/SoRQknhBukHP43mVvtVuBPfSPpXVpza1WqqZeEhLUwLa/
 Q2UKT/58NJS87LDzAl+1DKKmsutVQrPDh8JinUOJwnHn9a2aAWhrEHEs/kV+5ztXqIf3
 wjzw==
X-Gm-Message-State: AOJu0YyTkughH2cjgf8p8pG3N/taK18klJ93nU0TLYpactasJIGFrC+q
 XjUqtu8xBHnyFKOFcZTxDII63U49w8R+OZYpLDx1r51LGdSIQc5l07Lh6HynkhfEmjTYO80FDie
 a
X-Google-Smtp-Source: AGHT+IHPgaf2Z/HkkAx0p+YsBbf1jizdskZ63ajWuPrVgrQPxF4PpwXiHII/nfbL95AM4M6LfyADzA==
X-Received: by 2002:a05:6808:280e:b0:3bf:d775:616e with SMTP id
 et14-20020a056808280e00b003bfd775616emr2563878oib.53.1709059725010; 
 Tue, 27 Feb 2024 10:48:45 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 06/14] linux-user/elfload: Open core file after vma_init
Date: Tue, 27 Feb 2024 08:48:25 -1000
Message-Id: <20240227184833.193836-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Swap the ordering of vma_init and open.  This will be necessary
for further changes, and adjusts the error cleanup path.  Narrow
the scope of corefile, as the variable can be freed immediately
after use in open().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 39d9ef9acc..877799e9c7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4625,7 +4625,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     const CPUState *cpu = env_cpu((CPUArchState *)env);
     const TaskState *ts = (const TaskState *)cpu->opaque;
     struct vm_area_struct *vma = NULL;
-    g_autofree char *corefile = NULL;
     struct elf_note_info info;
     struct elfhdr elf;
     struct elf_phdr phdr;
@@ -4644,12 +4643,6 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         return 0;
     }
 
-    corefile = core_dump_filename(ts);
-
-    if ((fd = open(corefile, O_WRONLY | O_CREAT,
-                   S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)) < 0)
-        return (-errno);
-
     /*
      * Walk through target process memory mappings and
      * set up structure containing this information.  After
@@ -4657,6 +4650,15 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      */
     vma_init(&mm);
 
+    {
+        g_autofree char *corefile = core_dump_filename(ts);
+        fd = open(corefile, O_WRONLY | O_CREAT,
+                  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+    }
+    if (fd < 0) {
+        goto out;
+    }
+
     walk_memory_regions(&mm, vma_walker);
     segs = vma_get_mapping_count(&mm);
 
-- 
2.34.1


