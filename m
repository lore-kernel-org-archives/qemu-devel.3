Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7955BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFva-0008Am-E6; Thu, 22 Feb 2024 15:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvY-00087p-Pu
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvW-0002nX-9v
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso10254735ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634657; x=1709239457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=cewAROzRJluIMgKQAMvQECa8EoX7t/lej6g/hIyeFwo5xXYmld45rmlh9RBd/AkK+5
 /RM+sfWwS7nF5jPCyCjLoFJugOwMCmJAfkBrvY9m0IsL8ep84ffShbGzhuuRd5GMDKs9
 BFH+lkT1rbSJgqxg8nuOYsERpXpE6SYeC4oEs7D0tCCDXhS8mzFVrINhQQ8MMFXvYRBO
 SvqZqoeX0dpu89SWqF8JkoaNyV3/LYCNG436INlQvFqiZZTqigj7UNREzgE7jUWM+5gW
 gfD0xNipQKIp9A+UiMTxQirzAIVjkO9JC0Z4HWgXIuO3b44yHEeVe2mPc9yDwJA52qy0
 xkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634657; x=1709239457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=A6LeiEgzGA89m+1QVgHHQokuKkcUUn91pLWas0Y73FoYw5rY9WeN7WJR6SDLYP9fjK
 ZT1ZxeaZdl9aB5w5YFflzqhBnhmPYzl51n6scllmFigi7alkApZjGMJ1Oa4ACbyYbMf9
 Q9AEXEV24G4fIb/rnhJPocDvmHd7gIEljpm8eWwr38LHtw0MoPiQdy6lKRoD3KqPGEhM
 BNo/Ns08CbcI9F+7ki6s5Ztr27FUmmTwDnE7ClAc76MpASoo5M488V5rTgowO9hhG01j
 dZ00x0RGLNhrGopaDj0wlJOWY1+mJsYKCGc5HjETXMdIb9ixnxXnlLwvZL2ksAYcInXP
 nkIw==
X-Gm-Message-State: AOJu0Yx8q1U2zMZ7BPKWQCNek/ggdDxpoKNumTvWxsKeycS6QgpOgcZL
 V/uhSmOLz1FFtLDvzMFXwzFp3gbG6wff2pFtTx5P6Yw90lVOpzy5ynkYy8KjDjdPJJ+iFrV8yEI
 M
X-Google-Smtp-Source: AGHT+IGKmEqptejhuqQ8Xh4Axro+8zv2UVti17Bt2ZCSZ72RESjA2z2OXX5LRtpSVZ8PZ7zTWsTFGg==
X-Received: by 2002:a17:902:da92:b0:1db:f15c:85c0 with SMTP id
 j18-20020a170902da9200b001dbf15c85c0mr173183plx.33.1708634656959; 
 Thu, 22 Feb 2024 12:44:16 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 33/39] accel/tcg: Disconnect TargetPageDataNode from page size
Date: Thu, 22 Feb 2024 10:43:17 -1000
Message-Id: <20240222204323.268539-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Dynamically size the node for the runtime target page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-29-richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 69b7429e31..3cac3a78c4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -864,7 +864,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 typedef struct TargetPageDataNode {
     struct rcu_head rcu;
     IntervalTreeNode itree;
-    char data[TPD_PAGES][TARGET_PAGE_DATA_SIZE] __attribute__((aligned));
+    char data[] __attribute__((aligned));
 } TargetPageDataNode;
 
 static IntervalTreeRoot targetdata_root;
@@ -902,7 +902,8 @@ void page_reset_target_data(target_ulong start, target_ulong last)
         n_last = MIN(last, n->last);
         p_len = (n_last + 1 - n_start) >> TARGET_PAGE_BITS;
 
-        memset(t->data[p_ofs], 0, p_len * TARGET_PAGE_DATA_SIZE);
+        memset(t->data + p_ofs * TARGET_PAGE_DATA_SIZE, 0,
+               p_len * TARGET_PAGE_DATA_SIZE);
     }
 }
 
@@ -910,7 +911,7 @@ void *page_get_target_data(target_ulong address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region;
+    target_ulong page, region, p_ofs;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -926,7 +927,8 @@ void *page_get_target_data(target_ulong address)
         mmap_lock();
         n = interval_tree_iter_first(&targetdata_root, page, page);
         if (!n) {
-            t = g_new0(TargetPageDataNode, 1);
+            t = g_malloc0(sizeof(TargetPageDataNode)
+                          + TPD_PAGES * TARGET_PAGE_DATA_SIZE);
             n = &t->itree;
             n->start = region;
             n->last = region | ~TBD_MASK;
@@ -936,7 +938,8 @@ void *page_get_target_data(target_ulong address)
     }
 
     t = container_of(n, TargetPageDataNode, itree);
-    return t->data[(page - region) >> TARGET_PAGE_BITS];
+    p_ofs = (page - region) >> TARGET_PAGE_BITS;
+    return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
 }
 #else
 void page_reset_target_data(target_ulong start, target_ulong last) { }
-- 
2.34.1


