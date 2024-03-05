Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857AEC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMq-0006mC-UR; Tue, 05 Mar 2024 02:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMK-0006Ho-W7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPM5-0005rz-5w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:08 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e558a67f70so4786006b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624210; x=1710229010;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9OhDS/T3Gx56oShsQS7FHNcWODYCE0LjRwel+5jTWOY=;
 b=GES3jGdo7vtoyjckvE2PiNCxm8VSDSmslI/KJDynJRLOVAUMmyHmBYIr1skGzHEA1N
 SqWxREhqILxf4qA/eaeXYqXIsbiL49nnTU9LH+aZUjHymwq97LF5jSY8vVU7uV0Rsng/
 sqPSLxuSZYMY341d1sQKg09/xUxWC12Xt9iFoxbTwPFDb8qkVs5dkBw/VcBaMoyjJ2NE
 GZ6JC8pF8aRd9qO4NOrJgOJ9oQGLj96l5pmwjyMVII/4XP5Ht++Q3DF14doddGMCQUzq
 wqiKELOykiLbOBW3Pn+zxdxfMTdBfEeMVpS26tUu+Gd3/HWArlj28O1vedkn/ZLZ0i7N
 Is5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624210; x=1710229010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OhDS/T3Gx56oShsQS7FHNcWODYCE0LjRwel+5jTWOY=;
 b=Mp3lX1PksEEoQ556Rc6+a5O/+QEHwM2/pTqP3nBeDj+ucBp6h+OipWdzdHClvMJkWU
 /8BtjUmZuUfM4H0dQHWUst9bJerPRE+mN9mPNPciJ+aaUlX8Hln7ZsliDaewCKq87v9E
 RkuRq/XBqDh08K7qiG55C+q6VXX25vKHJvC3RFeh3sVdfUfq2bKAq4ZkIqEV57dKQRdy
 He/uQ392WpvC0RGwK6wNo0EwkJLOVi9H6BClpwLrX3P+6EQLdEupvCB5Rh0d357XouCR
 kBDY1tbtJ8u+YD1HGb5amQKgVxOiim1cZfjLVVewsK5phvUtimeEoat6HcsUdZVkdBZJ
 lUDQ==
X-Gm-Message-State: AOJu0Yze0GiCx/iGFsoh36JfkVazi9MCZpY5hWGPHPpqEU2bW/aiLQlW
 3QoyyVH6tBb+LcT6Czy/cJ1fek16kSS8ti3xnxaoi0Mxa8Ce1s0AVVlbQ0q9SBKNaZYXUmpzGm0
 q
X-Google-Smtp-Source: AGHT+IGvYv5h8OpOxOyVbmpw8qxtPaafTSUOffqI6gFm6yQErngvRvgJuZJRjrHT/ry/ifp6+sDzag==
X-Received: by 2002:a05:6a20:914e:b0:1a1:4b62:a60a with SMTP id
 x14-20020a056a20914e00b001a14b62a60amr1223095pzc.7.1709624209958; 
 Mon, 04 Mar 2024 23:36:49 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 n39-20020a056a000d6700b006e57defe737sm8396506pfv.76.2024.03.04.23.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:24 +0900
Subject: [PATCH v2 07/13] contrib/elf2dmp: Ensure segment fits in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-7-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

This makes elf2dmp more robust against corrupted inputs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index e01860d15b07..81295a11534a 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -88,11 +88,12 @@ void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     ps->block = g_new(struct pa_block, ps->block_nr);
 
     for (i = 0; i < phdr_nr; i++) {
-        if (phdr[i].p_type == PT_LOAD) {
+        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
             ps->block[block_i] = (struct pa_block) {
                 .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
                 .paddr = phdr[i].p_paddr,
-                .size = phdr[i].p_filesz,
+                .size = MIN(phdr[i].p_filesz,
+                            qemu_elf->size - phdr[i].p_offset),
             };
             pa_block_align(&ps->block[block_i]);
             block_i = ps->block[block_i].size ? (block_i + 1) : block_i;

-- 
2.44.0


