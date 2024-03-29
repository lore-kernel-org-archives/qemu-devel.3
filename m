Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AF2C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKae-00055n-Ss; Fri, 29 Mar 2024 18:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKad-00055U-PG
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKac-0001p9-9T
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so2032981b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750845; x=1712355645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtUHg09UOjxxYBJJEpdXT1anxY6jjxQxzEq5yXQbAXE=;
 b=yBJGaOdrjxNQNBorSTQqmPpBX4T4sd3LXvM2cI1rJX+8fCHqOMYiRWupAHDFL1+lJB
 vYukkFzzMz/qP2Ht9Rn6HF0LD1zg29tyoNxlVmyk27bQgAbV7w116SyLpiCs4qICIkru
 a//h8CKsi+/oZRk/6JKFTw7LSrqnN2PvvFXRBGSG+ibN6YVr5yyqVpDDQ3Z9Km6i0Esr
 zsnvevkFBoRegLZV2qOFw16vgIsTBHhKajHR7AjrT4J9SWXhPitXDU6bmxc9fJ8pfxIF
 2Ph2e/9RCeSBSaWIr9drZo06fv15xcXn6/F9N0pg8bTGXRxnp6lOvSQX22+QwtHWPWPF
 feyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750845; x=1712355645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtUHg09UOjxxYBJJEpdXT1anxY6jjxQxzEq5yXQbAXE=;
 b=uy+aVsv8+5hMTe6B3KLjT5T1xAp7D4W8XNxY2E3sCf57xjTngGI9QUroVDv/lLIo3P
 smL7uxHtYh+ucJb1Qb9npY8vaWOp8ops/ImqaYz2THsdX+bGdMo1XNzHiPXspWGwhT+Q
 vmDiZ0G1uy0ecRx5IGTxzUQfBZy5TURWSHd+l5iQlRoqnxxfQn9azIuPNnuJSkHvjC6c
 TJ1/ZXgXEzcazpPENqL4/PBiGPKAbHpLlxnfuGznJ5+HCO+CbqkbLXqzyTQr88HBaYqb
 5GnSPHcmfjlhIvdVPjelu4zZ7MT4hnB6YP3BdLMNGHCKzMOMktDAWfVblthkIWX9o9oB
 XLMA==
X-Gm-Message-State: AOJu0YxAI7oilD/G6bru9aP7lD3sfvM0LdL3dClBVRBKr6lfVM7Amd5v
 PmTDnwRj7I0Bz/i3V+EbA+2uIqEtOMpM9qnJLp5TWOMXTnRTDnr8dYUOhRBvwoL2RHvEuIXI4co
 o
X-Google-Smtp-Source: AGHT+IEjgiztimZl+umzBvIB4PXvgwmlAsCEtEh0MwE+tdRYfYwCpG08/cOs52K0LU9o9F18Mh8m3Q==
X-Received: by 2002:a05:6a00:1910:b0:6ea:ca90:3459 with SMTP id
 y16-20020a056a00191000b006eaca903459mr3588812pfi.32.1711750844955; 
 Fri, 29 Mar 2024 15:20:44 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 3/7] linux-user: Fix shmat(NULL) for h != g
Date: Fri, 29 Mar 2024 12:20:33 -1000
Message-Id: <20240329222037.1735350-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

In the h != g && shmaddr == NULL && !reserved_va case, target_shmat()
incorrectly mmap()s the initial anonymous range with
MAP_FIXED_NOREPLACE, even though the earlier mmap_find_vma() has
already reserved the respective address range.

Fix by using MAP_FIXED when "mapped", which is set after
mmap_find_vma(), is true.

Fixes: 78bc8ed9a8f0 ("linux-user: Rewrite target_shmat")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240325192436.561154-4-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4505fd7376..be3b9a68eb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1354,7 +1354,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         if (h_len != t_len) {
             int mmap_p = PROT_READ | (shmflg & SHM_RDONLY ? 0 : PROT_WRITE);
             int mmap_f = MAP_PRIVATE | MAP_ANONYMOUS
-                       | (reserved_va || (shmflg & SHM_REMAP)
+                       | (reserved_va || mapped || (shmflg & SHM_REMAP)
                           ? MAP_FIXED : MAP_FIXED_NOREPLACE);
 
             test = mmap(want, m_len, mmap_p, mmap_f, -1, 0);
-- 
2.34.1


