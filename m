Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D455C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFuy-00070n-96; Thu, 22 Feb 2024 15:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuv-0006zp-9Q
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFut-0002cS-Mc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so521735ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634618; x=1709239418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emMi1h1Qw5IeyN9nGFR+tElZTiLuS0cNV7Vg5JxneO0=;
 b=IXY3FNMlf5tD4tkHfrXxIkdWE84Lo257kMH4kL6eu1Xzbg93yqpbHxEv+x2pZYniSG
 iQY72bxqvGHmHh0j7i7kssPboxK47hZvHPYzAFutWAND8rrayWvLw26pUittbhFTG4cj
 Av7eKNujTyijnIeLBO63/oUWgtdOzyy1QGGemrXiidss+HYwFWOkTldu5mthHYusczVf
 5axnJ1MF68461ZTTtg6f2+RjqwP4QxeiQJYonU95rHMYu5I94CvBfp9GA9D/Z5OmL0TJ
 hbMetGxTF/9B+aY0wDctjA2Pm6YnP5kkrFNNuJNA1qbNxZSaonerJC4eT54fCnKtLN9Z
 G8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634618; x=1709239418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emMi1h1Qw5IeyN9nGFR+tElZTiLuS0cNV7Vg5JxneO0=;
 b=fkdC63Zv6dxMqatm/tX6AI21Kxo3bFaYDIu/d82jX2j0K5iL3iceNMAdWNja2av8cY
 0fPM7IsOEIOxRNs04ChoE1p44wX8io9CrZx5stKhmjCQNkKwpXff8kYrJM0/vLuPyEga
 IF8k/IGZEP3KhDnnGzQ3bWbD7Dif6/Ug0tEj2/RmNtZHagzcJX0L4D2oLWJa3m8Bnd0Z
 RNjTCASMz4Ikzob8SL/18PeBbVLYKbJX1gTw7BqVfPSEgC7g4UreNuELc0VpqWER0NI6
 3Z3tL6khgbHpXif0IOOY6EPhUxxYV8yMpDqxX1+leU1AqveqBVdBvTqgjkz0sHbEhm1S
 3VoQ==
X-Gm-Message-State: AOJu0YxDPTbB62X4AVBarLPEN2HT03uZq3vA6PetobeVBn27n6xvx2lh
 udaJNI83guTSR4RM42EP3S3gXR1z2WqQ22vhP2H5W/AMdH4JrLMsV3AW8tG4kPZ2lJqBBXJA8xL
 S
X-Google-Smtp-Source: AGHT+IHvM5bA684xWryyQ9GmZRMcHOL0zYp3ZGA35yzyBMWSzV8xKSyFi1lYd5I9fojNeQ9R+yXyZg==
X-Received: by 2002:a17:903:1c6:b0:1db:d7a8:850b with SMTP id
 e6-20020a17090301c600b001dbd7a8850bmr16589191plh.25.1708634618559; 
 Thu, 22 Feb 2024 12:43:38 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 08/39] linux-user/hppa: Simplify init_guest_commpage
Date: Thu, 22 Feb 2024 10:42:52 -1000
Message-Id: <20240222204323.268539-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-6-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index dfb152bfcb..1893b3c192 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1970,16 +1970,20 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 static bool init_guest_commpage(void)
 {
-    void *want = g2h_untagged(LO_COMMPAGE);
-    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        void *want, *addr;
 
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


