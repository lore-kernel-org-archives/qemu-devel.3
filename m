Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D8CC54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxn-0004uD-Jj; Fri, 01 Mar 2024 18:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxd-0004ri-Sp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:42 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxX-0004D8-QO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:36 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so25117755ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334390; x=1709939190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HjNGmK53xTEM4PEP/wzxcWkZ/m9cBOwh2M6e53eVpiA=;
 b=JHzXef831+oBIR4Mb2YWjTCS9cbsRJ8yBA5n4PK7uWhMudwM85T4fYv1B7ln7fGJGF
 xSyH5hwomaXyhIdAVqI1uJjpACaH6oKvkhsA2dHZV9d90Jqwd6u3HiXcB3gWRANEk6cc
 yC/vBJs3Mtm6AkXHKS/hzUTph2Toj9QsSTKmgEz4dS7piYEj6eHjjzqnxTAByy1z42IT
 CFNa5K9/aYSxwlt0zxMLjqORTTqiesxrbPKEl1nZS9yqi6OJBFPrFnbkNzP6pfbwX6eX
 1kT5zk1mbIMi65S9HCAbh54Xecvz9L6jTik1rAPw9NoiYfwzQvrb0qSn8C3FeMy+m5mD
 KuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334390; x=1709939190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjNGmK53xTEM4PEP/wzxcWkZ/m9cBOwh2M6e53eVpiA=;
 b=Q5cKSBYDwzLL8GxM+mXE1uU/Qx8+Xfg8tBbVaSE36l3DYx/Wjk2hGWcJLhcKlnkSNb
 T5+4PhYVk+tf03ubPfN58xQ5Uuzk+4E7G8Oj24JAPI4Q7KpAv1i8Ba5jN29p+Vl3uwwO
 GZltU90yN3aJ9BsjSjSqH3oMCCcKDgn8x2nfkNJyf/ovAJEiHdTZ532dr/k3//ct9Acp
 uK13b75CNnvExpNyHxaZkWlwIYccmJ3flafFFnS/x4CZ81p73UUPmkI3OHv2LzU8j+o2
 eqfvJs3iwh+a4a8xXp+CtGiWYSf3xV4pNQblO7Jp9h4+sQwfvG1CLGDZRzMWNSNH4R6+
 tQgw==
X-Gm-Message-State: AOJu0YzZTM6imEg66Eboe2p+I42CJdnFVkXy3fslVQwMQoqxNZQeIAIt
 /iRpfhysXpl86Zjo9PJGyKPA1yGkLUYrt1s2JdU+FjiFS2VyMFCsyRxC1layEcYP9tlWICqqKiP
 8
X-Google-Smtp-Source: AGHT+IG1CNtQJbd4yoi/hWo0YmLZI5axfhiJldST1H5g+hATg9j4kKu/68naFIKCjRCUorRtSlJ7aQ==
X-Received: by 2002:a17:902:db02:b0:1dc:4bf6:7eb4 with SMTP id
 m2-20020a170902db0200b001dc4bf67eb4mr3923448plx.31.1709334390302; 
 Fri, 01 Mar 2024 15:06:30 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/60] linux-user/elfload: Open core file after vma_init
Date: Fri,  1 Mar 2024 13:05:25 -1000
Message-Id: <20240301230619.661008-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


