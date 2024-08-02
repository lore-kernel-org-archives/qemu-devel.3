Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC606C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 00:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29n-0002Ci-I1; Fri, 02 Aug 2024 19:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29f-0001lm-SY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:52 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29e-0004I8-DA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:51 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso39916795ab.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643069; x=1723247869;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rilSw23IUxG4CebVk69zBKPwzGm7q3B46BwudSTr67M=;
 b=zM0uKIvPULjOb0wxLy5mD/n+uE5OS8ACWmF6ahkv32jSQKzfqiuVmzXLL4XRpToYec
 ggP3DF1dddApFcFMPqb00dCCrBsVEZSXs7TdEt6EhA1gGU1gdrgpNyJKhAdNneNjn6rc
 D1lb4FkjkJjRvZFgwAykeyqUPgQTcukfF8/+6iQom+A0GCu6kYvcnO+MEpNZXQ5/DjEi
 Df7/6346a52GP13ZVqkzS1ZYHKuCWjcFalhTOZtMVV3PS5IIJ48Co8YYPuOhs9FPKRLv
 +CXiI4JhGioDLZ1UdVtaoFQsCKf27oQQ4bpgJxhHyblzOtv6kt5br6s6IigV3vOH2OKV
 V/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643069; x=1723247869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rilSw23IUxG4CebVk69zBKPwzGm7q3B46BwudSTr67M=;
 b=V9jm28GK36HDIAIwpGZQcTlAR2fCUC/pQUC01ApBat7iXGBeFYZM14MVj2bdgzqfUr
 tcHgyfM2VF9iFTnEgRl74Qd4PE/6Zp2MaXIHtlRWzXZpTX+9p/JGXRPg78dJvcZ3AEZe
 6X9DUsQzCTomhPS8nlSijctaAG/t1ISLfD4BcRRja7ZCXsDocGazYV7fi+i6ep4WNIx3
 r1aptKx8+27ufzCmtMaWr/CgS1bkehG4HHxOn/FC+G95hXC+yCOUvnuOkhmd3FuDu/J5
 9MWr6xgKh1vl9If0DEl3PHKXdyY6efcxz7Jf8W7mPS71axLjuvs0STKuGxGcoAXf+hi2
 1JTQ==
X-Gm-Message-State: AOJu0YzLKIH+q6iim0K0zQ1OuVilqX1LOogIdJODVDhesyxls0+FdoNz
 HjIgxkvuifjvfR18VbdenfhkAOh7b8t1OANwa+/Si+oIZe7GsUHdCmyDkk1INLoBuMbE9dfzs+t
 9vvk=
X-Google-Smtp-Source: AGHT+IF1oU7ZT1YmVXaX8TPsKGeKDUWjF16N1xXfjP6JDckPPTwnVGYNqVT7GbbGzj5XK+RX6EugHw==
X-Received: by 2002:a05:6602:27cf:b0:812:9c27:357c with SMTP id
 ca18e2360f4ac-81fd43652b4mr808622239f.8.1722643068819; 
 Fri, 02 Aug 2024 16:57:48 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 09/17] bsd-user: target_msync unused, remove it
Date: Fri,  2 Aug 2024 17:56:09 -0600
Message-ID: <20240802235617.7971-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
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

Nothing calls target_msync in the upstream or blitz fork, so remove it.
It will save us having to modernize it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 17 -----------------
 bsd-user/qemu.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index f3a4f1712da..fc69cb43ebd 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -739,20 +739,3 @@ int target_munmap(abi_ulong start, abi_ulong len)
     mmap_unlock();
     return ret;
 }
-
-int target_msync(abi_ulong start, abi_ulong len, int flags)
-{
-    abi_ulong end;
-
-    if (start & ~TARGET_PAGE_MASK)
-        return -EINVAL;
-    len = TARGET_PAGE_ALIGN(len);
-    end = start + len;
-    if (end < start)
-        return -EINVAL;
-    if (end == start)
-        return 0;
-
-    start &= qemu_host_page_mask;
-    return msync(g2h_untagged(start), end - start, flags);
-}
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index ed6044cfdaf..a2bc14eea50 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -236,7 +236,6 @@ int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
-int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void mmap_reserve(abi_ulong start, abi_ulong size);
-- 
2.45.1


