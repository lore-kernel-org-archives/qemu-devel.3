Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72186C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29k-00021T-Q0; Fri, 02 Aug 2024 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29i-0001un-MJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:55 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29h-0004Ij-9j
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:54 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f9339e544so340310839f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643072; x=1723247872;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWWgURm7Gj0tu0dmUrbtb+IelYe/G3vbyvbAbU8GzUk=;
 b=SlRtZFYgn2Sm0Z4CkP++WDMgwGwcL6y0mQkZNMvfs1yYk2rHbydrbYclXxxQHoyJ12
 9nxERWeYWhXdB2RY6XbHxvdZsIveBGWuDTReHuFhcHIadvNDlOkGx1p8897jSj/P51Cv
 KuC6L2d+p5/TMAEq1Rw5yolvXgL+s/pArgeK6E0zdWKGbCpc2ni837BQ6cm0/ZbC5/m+
 zKj2+OhwRu7FVA4/XrPWHLCbuexm0fMGHEujHCqiPvGwmGj/qMYo38CJn2NhzoRp8EBu
 EojJ+O5fzQHoBHUjWzzMCqcd83PzCv/pVEdimop4SgAdDlz5UGrLspBY7MS6mKYVpXNn
 6PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643072; x=1723247872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWWgURm7Gj0tu0dmUrbtb+IelYe/G3vbyvbAbU8GzUk=;
 b=SmZi6zf9uwArm1cfU7t3IHK9HjBr6wugYMy/ATyDB00kQulfl6N7b1WBzLCnDPLbdg
 P2E8Dq1Kix1H9uNjl2zmr6sgskWEPQHXwduAW7aBQQojx8myDvHytVhVD+o3T3MZHgEr
 NyQLPE+gp1s3Q54T/TVuEvOKbsrb18DZGrvCmwCQVYglAQqOiVfoLBiFPWg4FYvxho8p
 MSiqU53hW131M1Ul7sHRDHrC7MrUh7mI/idMdXEhSCRpX4hFtmaj875kbx1e3nxCbM/M
 61g7NUbTGxbLfOGmYDv1FZ5N/ZeMtr1w0govODkhLU5JNz61Nk8Of9OwWvMp4eqA2ff+
 GjGQ==
X-Gm-Message-State: AOJu0YxjYsuAmGCxTHd/XVkcb0cJ8EOMmCTQeRsDnlB80lpiRx4uaepU
 xhl/A33Ch6pBMiz9TVHU3gpfJr39jNEPuVy1BaNlQ9ydAE29fuhuNxNeq4YW/vw5fv3Msf8+HBY
 UBKQ=
X-Google-Smtp-Source: AGHT+IE2O5SY884IPHtNGxy0xYcbqgv0MSIy69f7/gVB/R2j7/TwQtot4my3nRkKDkWVvx0syz89hA==
X-Received: by 2002:a05:6602:6016:b0:7f6:84e7:bd35 with SMTP id
 ca18e2360f4ac-81fd4358ef7mr535598339f.8.1722643071762; 
 Fri, 02 Aug 2024 16:57:51 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 12/17] bsd-user: Use guest_range_valid_untagged to validate
 range
Date: Fri,  2 Aug 2024 17:56:12 -0600
Message-ID: <20240802235617.7971-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2b.google.com
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

This is the generic validation function, so remove some hand-rolled
ones.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index fc69cb43ebd..ed8d31a9048 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -74,9 +74,10 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -EINVAL;
     len = TARGET_PAGE_ALIGN(len);
+    if (!guest_range_valid_untagged(start, len)) {
+        return -ENOMEM;
+    }
     end = start + len;
-    if (end < start)
-        return -EINVAL;
     prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
     if (len == 0)
         return 0;
@@ -689,11 +690,13 @@ int target_munmap(abi_ulong start, abi_ulong len)
            TARGET_ABI_FMT_lx "\n",
            start, len);
 #endif
-    if (start & ~TARGET_PAGE_MASK)
+    if (start & ~TARGET_PAGE_MASK) {
         return -EINVAL;
+    }
     len = TARGET_PAGE_ALIGN(len);
-    if (len == 0)
+    if (len == 0 || !guest_range_valid_untagged(start, len)) {
         return -EINVAL;
+    }
     mmap_lock();
     end = start + len;
     real_start = start & qemu_host_page_mask;
-- 
2.45.1


