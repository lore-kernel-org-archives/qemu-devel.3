Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A96C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC3E-0006k7-Dc; Fri, 01 Mar 2024 18:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1V-0003rl-5d
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:43 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1T-0005h5-9C
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:36 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so2373290a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334633; x=1709939433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=WDyjvaQJN1OEqMugqeP4kryL6Wr58LNN0fFaHQj/alOQV/mB5YS8S3/uQVskHvrVE9
 9lv4BifWyHGYVT4Dg2TJGfzPwCFyfmtIH0VgDy5PhvnIEWwe3vjnhMyv5aN5uL+3JhvP
 PH4+k1ds0602/f7v+z6B6kobAwL/VEM6S5JQVWRpvxMqw0RI2sq2tMawVc9BucNbRF7a
 JQw5db9ZKx33Cth616zVOEVhy8LrgT47AtSem1coYrWMTkxojC8MYNtpYlQVEyXI2jZQ
 5GHSXwg42vu80VCGXDD6r4h3BFpIq20kt2l0B8D4HbE9gHeuZSsgPmkaJdbZDWMGXZ9X
 /4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334633; x=1709939433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=jK+pFXxJd/wVOIOfXl3xMyglJF2PxBvf7FHvb7uGwVNtqfNCqCnsC4pjBb6XH51SbX
 TzjOXOR2ZnFFAW/CdqNfdpx85mUszZyrQdvehU1J+KyRWnGOEHv6PTD3eATPRdPvV8GR
 Ze8G7f/P1gAO9wNr+ypcRtFmoneOPEB2PGtXXlV+DgZhJ9EPGFFtrzEv2L1eGdppOUiA
 5MiIXde6CYZ1F1ltzvNXnF+2fqH6zTl8J2IlQaxa736hUoYPhJ0Q4ptmpRdoKXL+brmn
 YLGfuIbFjuOtQBlq4JYJ8CaEmgjdiun3jBlik/ExOptdsexKNBD6Nv9/fEDPZkggL+Nl
 LZgw==
X-Gm-Message-State: AOJu0Yz1gO13YlCngNtBfbdjKQLZohQvppYmBQqRa0xNPcKZif/yJTI6
 wSCImBE5X1qE+dHYLhE7c2NO36beSpX/UHvI0kMkScFmFVT/tdhsCF4sYUEYxWw4M/zEQPJqpLf
 e
X-Google-Smtp-Source: AGHT+IHfiU+h+aqT+6hV8F+0NDG1GLqmnvSOOV/HOpeBNQxCXHChmdXC7+wJWTbYcPZVHJBG0oYwkA==
X-Received: by 2002:a05:6a20:8418:b0:1a1:15ff:43b with SMTP id
 c24-20020a056a20841800b001a115ff043bmr3434798pzd.23.1709334633691; 
 Fri, 01 Mar 2024 15:10:33 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 48/60] accel/tcg: Disconnect TargetPageDataNode from page size
Date: Fri,  1 Mar 2024 13:06:07 -1000
Message-Id: <20240301230619.661008-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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


