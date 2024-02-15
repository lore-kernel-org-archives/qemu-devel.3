Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75645C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7P-0002wn-OE; Thu, 15 Feb 2024 01:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7N-0002o1-GV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:09 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7L-0005av-Oo
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1db51e55023so2969545ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978065; x=1708582865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=ON0vDx1jfOO6XNXhgRG2bwbv9GCJZfaIHvQ0gRfZ/3ZBCT2LAboGCvSn/9+olyqgwb
 DGy9s8tD/N2dii9MXRJu33ZtLpKVNZybb5edCSBgJFgs4kWBbiyySu3wlgcPgvn4zGkd
 Y46i3EFX85mwaCnhbKxcIGDIiOWI6Yp7jK5sOiJ9Rg9vw3aPlOj7G//q0GnzqFwdAQZI
 +6sQPH2zFHBdXn47qwmeAbf7i0p2ip2kDJchghD82dClha0DrFiejjaTN+SuMEMNPEPI
 bD82pw0eBIp2Dm00ukt4OLzTj05gDRfThmMTIIuCqpFhzunTAmfriHBsj5Edi5dT9Xxk
 m6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978065; x=1708582865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFLr/Nh9lR5RHGOKXL0ktJAFT8XYevI/jB1Fp1QCuj0=;
 b=pCZyrwXDLTFxWHuD4+6PasWKwaTZyTHEEabfplUYI7oSACDzijMR2bM5kW5Cp02DvK
 phzb0mkZR2Psy385O5Ttdbb26KvCUasvcn3xYbtx1zVuj8yXwum68hAhs6MJsNRf7Xf7
 rN4bay1zJNcAxnCnQ+T8GpvKs1+4dKXomVJxYPob7tMrjwi/yenYE8zcIvJoO+ufoxfs
 BpuzN0cS2I9zPxdCcR5iyFH5IIQ+BvH/Jnr56NZb+f/kriWDMomIN0MyvJjHL6nInq6Q
 3++3OMw8GVyvV7r+qwNiNNOXIcsyjC2G+K0strkkN5EYk1Hml9Q+b73dxpZr++p49JRf
 9/Gw==
X-Gm-Message-State: AOJu0YyCUyGnxGCmfmh50tvBCpCMU2jAsucDur3gkSXViqH+4TODnCYT
 M60mwFk6olrHGb5D3JmRIy9gzUHMEQBYlH2tJmrQEHOLA25C+EVbb0pGzktJnxL/cGsv+a4SFEz
 B
X-Google-Smtp-Source: AGHT+IG+Ds5kjKXoYp85oSkZk9AloVLjxUO0mzzS6Im2QjV6I4/2R26lxlpwbwJpG5tAlPZd5CsQDg==
X-Received: by 2002:a17:903:1cc:b0:1da:15c5:bc06 with SMTP id
 e12-20020a17090301cc00b001da15c5bc06mr1195475plh.58.1707978065257; 
 Wed, 14 Feb 2024 22:21:05 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 30/36] accel/tcg: Disconnect TargetPageDataNode from page
 size
Date: Wed, 14 Feb 2024 20:20:12 -1000
Message-Id: <20240215062018.795056-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


