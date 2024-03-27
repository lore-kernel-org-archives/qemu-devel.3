Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpa74-0000oF-NT; Wed, 27 Mar 2024 16:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeE-0003B5-4B; Wed, 27 Mar 2024 16:13:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeB-0005we-Bg; Wed, 27 Mar 2024 16:13:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e0d6356ce9so1897385ad.3; 
 Wed, 27 Mar 2024 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711570397; x=1712175197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFVIMyRlD8/BSmSylP4xvcbNRqi2JvuqJ8ggirzVAcY=;
 b=R3RF3w6Ij0fQZjkSqWzDXwiKF4NaxCCVq2POBDwvvEK4kTQ6LsvAgBJ35DKm6JOUbI
 gUkCAPVGlJOjN/XUHHpejSO6LNLueLWOplrDjarRBofuIgeKoZ+w6EXeWy27+ZFvJkuo
 f3PIJhhRUhRkcrrPsmqS4JuJLbPOaDKGzUUpEDNvtG9aHX/loxlCpqB/oYrx83fH95tv
 25+VpBHPpIUM6LZ/prgIpbrOXi/KzEwY0M7vNZ87eV+v7qjAvm4Zl8S3ybqhCIE5SmcB
 Onp0TgVKjtJc8nAxMHeY/6PDYWQz0TMqQ3LWWTryDNn62/yGAVaMZ06AkG0IXU3TbVHN
 XICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711570397; x=1712175197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFVIMyRlD8/BSmSylP4xvcbNRqi2JvuqJ8ggirzVAcY=;
 b=hFBVvrWhxWBUWeXRcWoMWYIpPOvlProW3m3117QTnjsNrcTDICCN4qymMIft1i21pu
 rEMigIcXd+2rYe5CNs+tVvhyUSJ5Ovv+ICg7fRi9LeZeb3f6do3xObsOJ8KWGy2Jp32F
 dmQHCwPNq7kovl+KKsV3VJON/3q/W0Lr0t2n7u02rueh31WFyAQPRQ5TMX0HDoUO5OEu
 mZ4H6b5IcaWeZl5vMLGyZmYIwZjAgtOm5roIhGt1iu6EmERqN18inF0XbgUa+2YtrV3m
 7CvlEeuSOq929rOImbQdyZF793LT4lApQHCHkUEbThjW1/6G0R1TvoEBpDEfIyCpDPuS
 R0cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkmSLmPrWx/P8JhJftzvqTuh52z6WGeIsSjYWMRcr/1t99Xa/Qq4b+pTyYa7+wvXWu6Z7sCA7LPcf+7/Wg09wgIighFIw=
X-Gm-Message-State: AOJu0Yxg/mGPjO3E17pSnesnqfwoszkQDGa5AJbMYuXzFMUzDjiutuL+
 Td7tD/Y1/EGaUyoiCfQQ6LD5TxT3YsXWLNT4O1yaap0ab/N6kl0Qdp59EWqMoIFJQIip
X-Google-Smtp-Source: AGHT+IH9uPGf6E2jInJ2aHBvY8xvsboNk/P2+w02eTE13anqRI3+m3UUFCMBDGYAOKRAdljxbL1kHg==
X-Received: by 2002:a17:902:8f95:b0:1e0:c7b6:ef4a with SMTP id
 z21-20020a1709028f9500b001e0c7b6ef4amr752410plo.40.1711570396973; 
 Wed, 27 Mar 2024 13:13:16 -0700 (PDT)
Received: from localhost.localdomain ([192.228.205.68])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001e08d5a7638sm9682673plk.99.2024.03.27.13.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:13:16 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:vvfat),
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH 1/3] vvfat: Fix bug in writing to middle of file
Date: Thu, 28 Mar 2024 04:11:25 +0800
Message-ID: <20240327201231.31046-2-amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327201231.31046-1-amjadsharafi10@gmail.com>
References: <20240327201231.31046-1-amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Mar 2024 16:43:07 -0400
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

Before this commit, the behavior when calling `commit_one_file` for
example with `offset=0x2000` (second cluster), what will happen is that
we won't fetch the next cluster from the fat, and instead use the first
cluster for the read operation.

This is due to off-by-one error here, where `i=0x2000 !< offset=0x2000`,
thus not fetching the next cluster.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3ae..ab342f0743 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2525,7 +2525,7 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
         return -1;
     }
 
-    for (i = s->cluster_size; i < offset; i += s->cluster_size)
+    for (i = s->cluster_size; i <= offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
     fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
-- 
2.44.0


