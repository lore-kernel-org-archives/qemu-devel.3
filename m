Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58637C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29o-0002Iv-TO; Fri, 02 Aug 2024 19:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29m-0002AM-UA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:59 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29l-0004Jg-Bs
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:58 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f921c40a0so346408939f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643076; x=1723247876;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSto2JlTblPm7lL32v0n5cXRXHwEk3Eun8OyV2xgFYk=;
 b=M8MHeNzvfF2sOKpKUlIqBAvlluww7MREpGVSzIu1ee92vVlLt6xDxFxR4T0qEEV6ya
 IsVOTWgNy/QopAbJBB/nXlCoDYY0sF6Yl+lzOq78duZLL6vmqVzuUo6zC85ShcNfd9rc
 Nj2W417++sPI/d0O7Cn/LrNpa0CcOtBLfiKtyEAMpYy0uuA/bOVRP88q/QKwCJqTGdPw
 8DX84wmhTM3Hcb0CX7FJSsFt3HtO4a4xwgJG6FCNNjwu+16GQoW1O7aXBsIk2XQXys1R
 sSXM1Rx0XcvbKIIv7NklqBgqBJiZPAYCAsp8IPse6xxyOCrsdJFkx9BBz2QbPTkba9eo
 8Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643076; x=1723247876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSto2JlTblPm7lL32v0n5cXRXHwEk3Eun8OyV2xgFYk=;
 b=rAHh9y731PxYXIAvlA3GDuOCJgRDyIqiRpJQvOIv0eDvYVqwgWAFpksCSdeCll+gcu
 Xx919PJQYyB5RRn/1Q+4qOfMyVs5doEOsa0VSaIJbVV/8ENEGmnUEknATAQdGkMW02PR
 zvj86wtTzewdS6hvzDzXe2cWDLwFd7grJuBvXB/bVLUmw6kb15tkaEgO+0PwYY5l2tMr
 xBH0JSJqYXMrU3Twq5qbAlvziW72/5R7B5crEP/1JC4nk5osv7FrnCrFnX9O70uaRoi4
 RoCcvb/lUp8sNk7adbQDiAI1BLUTr0mzOaPhvfdpSrExSjw/N5RUX1S/vfsnhaaBOorh
 hIiA==
X-Gm-Message-State: AOJu0YwdGnBaouB8uypIM2C7nTlFD3qzgi+gha90+Mv8Kvft1nvZH79Z
 VR2kWhucNN7zhkELcPI5kgo+2G7oIai9xqtoT+fcjhaRaO4J6b2siNXmqDLjtUTB3bRpu0Rs9Ww
 rmSc=
X-Google-Smtp-Source: AGHT+IETbXa+Mp5jDXt73Y3oKpH6ChskQHJZmg8+gfksu4bMm78r8LCx3sJZIP9WjRcX2pnEp4DOIQ==
X-Received: by 2002:a05:6602:13d4:b0:7fb:87d6:64b with SMTP id
 ca18e2360f4ac-81fd4405a91mr605406939f.17.1722643075646; 
 Fri, 02 Aug 2024 16:57:55 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 15/17] bsd-user: target_mprotect: use helper host_page_size
 local
Date: Fri,  2 Aug 2024 17:56:15 -0600
Message-ID: <20240802235617.7971-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Use helper variable for host_page_size. Linux-user uses a similar helper
to make the code smaller after the multi-page-size migration.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 2118972f073..ffecf52a72a 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -63,6 +63,7 @@ void mmap_fork_end(int child)
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong end, host_start, host_end, addr;
     int prot1, ret;
 
@@ -83,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
         return 0;
 
     mmap_lock();
-    host_start = start & qemu_host_page_mask;
+    host_start = start & -host_page_size;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
@@ -91,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
         for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        if (host_end == host_start + qemu_host_page_size) {
+        if (host_end == host_start + host_page_size) {
             for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
                 prot1 |= page_get_flags(addr);
             }
             end = host_end;
         }
         ret = mprotect(g2h_untagged(host_start),
-                       qemu_host_page_size, prot1 & PAGE_RWX);
+                       host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
-        host_start += qemu_host_page_size;
+        host_start += host_page_size;
     }
     if (end < host_end) {
         prot1 = target_prot;
         for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, prot1 & PAGE_RWX);
+        ret = mprotect(g2h_untagged(host_end - host_page_size),
+                       host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
-        host_end -= qemu_host_page_size;
+        host_end -= host_page_size;
     }
 
     /* handle the pages in the middle */
-- 
2.45.1


