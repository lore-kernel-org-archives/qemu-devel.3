Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED061C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29o-0002Fr-6x; Fri, 02 Aug 2024 19:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29k-0001yw-4o
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:56 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29i-0004Iw-Jg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:55 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so357271139f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643073; x=1723247873;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcFCklOxEptK/v+KYBlk+aaUGmJl8I5KUjcP8oU3kVY=;
 b=2Fi8EXtQ6HRAnNfojg+cnCpCMGSRD1JnurMQMhBkTVfAqc48PaHvoLs5i57Wr8zTED
 PdcRQUb+cOIEu4Vs4u6L0OqSuARDZRXHbru6ZtyW7IF5YLNYtB8JOSdY5NpZ8BrdfhOr
 1A+PHupaJPOEMps0v34mfpDp3Jev73opLDNBicOknQepuntUqIbIMeQqRmTmCJyVKk0N
 vTfj+a3hHv4ii7iP8Gx3VUAPJxs71E7F3CvgDqvAK/vwc1LRUKeUvwuJwHxjNEBdocR+
 b5XEef8iaHr5UYVByUhqPC9OglTytQ88F95B6Y6KsClj8hjOK0Ro9FX48oi4XHGnvnK1
 aZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643073; x=1723247873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcFCklOxEptK/v+KYBlk+aaUGmJl8I5KUjcP8oU3kVY=;
 b=EsKEDTckcnbgOVYVwIWb9q4VjMYFyM5y06S0W2Bth0USLf3ysdDft0LSo34lRkD9Qn
 twu+78CPoOM/YLNmgxB5YlB7WtcUIWt8Xr4VfasULEHQn4srm8MCtGLFNxb7iqgzLHD8
 vQSm5hH/XacKuW1YwozVIqI66Xto3rEARc+4gdHEglDLlznQrLV1W+h1j2WfhtH55pcD
 nRw7KaKvsa6+zb5Cj2Hu3t4sDEc4cHAxHujyHBUI9ZtacLzl/F7eG8J3YIBXsGqv4fjN
 tFxmxMUQCnvLhRUbdamfLrAQhNq9KjiyEl1nEFfFzJ/S2ek7clvMyDHklqrncHBvuGRY
 D6sw==
X-Gm-Message-State: AOJu0Yx4Fbjds2Q9+/Iiu71eusYbhYhM+oG+H62aWordM+IGmJ6q5i2H
 wYWv9JUaoh9oTrXWMwr2hr4Z5Vm10EMVMR/PgRvc6th3cRJ3ChftTVxykzud2ZBo+cxIbDiqZCg
 qkMQ=
X-Google-Smtp-Source: AGHT+IF+T6AgLY1GQRi4nbq5nPAncJzm//ge4HtzBIoewlabZi/Bxkj8Q7QDmeCMupKHCP+kqJbo0g==
X-Received: by 2002:a05:6602:27cf:b0:812:9c27:357c with SMTP id
 ca18e2360f4ac-81fd43652b4mr808645739f.8.1722643073028; 
 Fri, 02 Aug 2024 16:57:53 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:52 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 13/17] bsd-user: target_mprotect: rename prot to target_prot
Date: Fri,  2 Aug 2024 17:56:13 -0600
Message-ID: <20240802235617.7971-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2c.google.com
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

Linux-user's target_mprotect uses this convention, so move to it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index ed8d31a9048..d34075c5c64 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -61,16 +61,16 @@ void mmap_fork_end(int child)
 }
 
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot)
+int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     abi_ulong end, host_start, host_end, addr;
     int prot1, ret;
 
     qemu_log_mask(CPU_LOG_PAGE, "mprotect: start=0x" TARGET_ABI_FMT_lx
                   " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
-                  prot & PROT_READ ? 'r' : '-',
-                  prot & PROT_WRITE ? 'w' : '-',
-                  prot & PROT_EXEC ? 'x' : '-');
+                  target_prot & PROT_READ ? 'r' : '-',
+                  target_prot & PROT_WRITE ? 'w' : '-',
+                  target_prot & PROT_EXEC ? 'x' : '-');
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -EINVAL;
     len = TARGET_PAGE_ALIGN(len);
@@ -78,7 +78,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         return -ENOMEM;
     }
     end = start + len;
-    prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
+    target_prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
     if (len == 0)
         return 0;
 
@@ -87,7 +87,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
-        prot1 = prot;
+        prot1 = target_prot;
         for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
@@ -104,7 +104,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         host_start += qemu_host_page_size;
     }
     if (end < host_end) {
-        prot1 = prot;
+        prot1 = target_prot;
         for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
@@ -117,11 +117,11 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
 
     /* handle the pages in the middle */
     if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start), host_end - host_start, prot);
+        ret = mprotect(g2h_untagged(host_start), host_end - host_start, target_prot);
         if (ret != 0)
             goto error;
     }
-    page_set_flags(start, start + len - 1, prot | PAGE_VALID);
+    page_set_flags(start, start + len - 1, target_prot | PAGE_VALID);
     mmap_unlock();
     return 0;
 error:
-- 
2.45.1


