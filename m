Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1E8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJy7-00069d-Cj; Wed, 29 May 2024 10:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy5-00069C-Jn
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:53 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy2-0005iV-NO
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:52 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b0d25b54eso1061944e87.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991668; x=1717596468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAPTdk2tBTLhsGMXcyf3g+dPATMhben3YmhgWkc5O5I=;
 b=csOmNvd5RiyrHcC1EeZJvCYSTWZfo1a3zd7gm9cxXnPTxrNRzTyQ+jqnAvTNABPnGe
 CTc8PTEaHDtH7iYbb5FezLoiOIAaM99DdyQU+cIQ0g+1muQh+7UiHNNnSe2dnjrxjOYs
 fGMl8l5Qjsqg/nffW6/UXO2v183+Cm209BIyqlFw5dEF+Zn0EIwW1kDwvevjAyzbdy0Y
 UibqIEJ9H5jrxakum9eCSWVIDYDYInvzbONxYNKOdJT115rR9qBS1KuPQ7oZLlJBG1aq
 SXCUET0XObY4yRowwTT21ofS090jU0PM+KlrVP0KtFpfQXKZZU8TrSNiHvVtgnkr+Qkw
 vrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991668; x=1717596468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAPTdk2tBTLhsGMXcyf3g+dPATMhben3YmhgWkc5O5I=;
 b=V/MAFJBrjMBd+2U5FHyZ85ndFN0VxnEi6NiBaJdMWjmULyvXdPrijwDbIiaFSZfppR
 lkTCKOE6JZzNPW30+O57ukmJEbMaQdtNfSXupsarmhoL8L1M+Ljz2GYsJEoj9UVa2713
 3r/SYCVMB1YH8j7c9h4C7SOrWKq3NeIuWrMTMA395KIYnOt5/Vfl81K2RcM2roME9Hgp
 6++vOEXYwyowGTfSWq3hEW9maUOLGmWmMm18UH6xjyGoCOWvSLKmVzkKL4+Y6tqKue6Q
 T38scZVyfhiYL8qS7iI1x0edapE+VXJEatO1ZXMUvCid6SkbbUD2KLt5PVJdSLN+7Job
 ox/g==
X-Gm-Message-State: AOJu0YznwzAtdL7IonHlKENHXUfYVWkshY/8RtD+MnCGZWMZxQEgte7l
 tTcXyqw+cM/A5QIjRghUteMriHJwCXE/vs/284ZGeAgbuGWOjDTOzDhJpaHy
X-Google-Smtp-Source: AGHT+IGOA8Vu0icbu0zyHf6lFCWn4Cz61R+8i5rez/vRWoe83xM7S5KZvOgmZ506Efg9JdJ8IwEO8Q==
X-Received: by 2002:ac2:51d1:0:b0:52b:7a44:e17b with SMTP id
 2adb3069b0e04-52b7a44e3e7mr163705e87.13.1716991668154; 
 Wed, 29 May 2024 07:07:48 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5296e8842c9sm1309835e87.15.2024.05.29.07.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 5/8] softmmu: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
Date: Wed, 29 May 2024 16:07:36 +0200
Message-Id: <20240529140739.1387692-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

For xen, when checking for the first RAM (xen_memory), use
xen_mr_is_memory() rather than checking for a RAMBlock with
offset 0.

All Xen machines create xen_memory first so this has no
functional change for existing machines.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e6257ef65..b7847db1a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
                                  len, lock, lock,
                                  is_write);
-- 
2.40.1


