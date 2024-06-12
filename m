Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27A2C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLi-0001HB-BH; Wed, 12 Jun 2024 08:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLB-0000pu-40; Wed, 12 Jun 2024 08:44:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNL9-0004xy-D2; Wed, 12 Jun 2024 08:44:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-704189f1225so4360484b3a.0; 
 Wed, 12 Jun 2024 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196273; x=1718801073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nptw2utT3cflhovZk/xEgGBnD/tuGQdekWiabPUKqzM=;
 b=Xm+w4JrvyzoRC+6ngngeecT5NznLFGz4diJH4fX9bMlUhVOpBibFQYHfS+wI3UzXVT
 p6NfOGI3JbY77RMzIy7sgUtl70q+J3nR528rM2zquCdAth3i8WJiEJt6WkZmXZrXBUTP
 SxH0ezRTXXGftlUpAc13KKA5gF3D9Qyse2l/7ilzzaHkJVydSt2TAPM+56nZu9XHtbhz
 G2ZWkYXa+Z3DH5H8TXBVVj2n2gi5fKobahZ42Z0W1uqUXBVTzAVwzvWncoWaMZAyt8Fk
 661/Z6p1KM+qkK1JOH8YA5f/DqUJKxuFvdz5i64r1OI4vR0CNhUp16hmrVoK367kf+wR
 3UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196273; x=1718801073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nptw2utT3cflhovZk/xEgGBnD/tuGQdekWiabPUKqzM=;
 b=QQM71UQUXn+j7A252WEl7Tk6na8my7GhYz0yBSRWfaSiLu+K+M4l6c0Wg5/PIPdltL
 2uUEDr4m0RSJUwSRPrlr90XxIjMW6ptjNZPM5BaUc4G8L+Zppm3MevPhenUmZfi4dDFK
 UdW+I7ExC4aXCXnZAB3YXSVpYWsTwkwOHgtH9tdo/ZF6mtivDaTykdwyVcEKnxnyAwrC
 J9GtB+0Yybul/kKbNzPvsyEu3T1ABPf0SMgeDyXMxI2UeHLcy4M5wjiuHc9Oi2kbNoqa
 79nElrnsXmbvHBqUybLP7+ajZd0gVW2iNt2jgcmlE5dJnr5N8sYC8HLSPqgRT7QLW8z2
 8ilQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnyYktLyxzWLc+7vhTfnLihWtHcQYiHncRZpRPcy21ymjzcx2tjzz2nKd7shIG6KvBtRbY2V0lx+IFyE9VAtGChZJABGc=
X-Gm-Message-State: AOJu0YxKI/K4f6VXshUSxQ7jjy4eREiu0i7HwFnuGhPyHIz+DoXaFfFa
 aphuVKpk21xNUiQeUIyeG4Yh4OfNry61RkIFp6bJvIfcfZay0TCGJU6bkJfa23A=
X-Google-Smtp-Source: AGHT+IFJDvXWcHdMt54s+ktF341ZC3YbtK1q2lCRncETZ+mHRjQ/rLfxsOVN/vVEoTwkxMjbDKlSIg==
X-Received: by 2002:a05:6a00:4b54:b0:705:b121:3557 with SMTP id
 d2e1a72fcca58-705bce06ca3mr2233780b3a.9.1718196272753; 
 Wed, 12 Jun 2024 05:44:32 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:32 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 2/5] vvfat: Fix usage of `info.file.offset`
Date: Wed, 12 Jun 2024 20:43:23 +0800
Message-ID: <c1b1d06871b34bd3ac6034ab65b2eaa06e520ff2.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The field is marked as "the offset in the file (in clusters)", but it
was being used like this
`cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 19da009a5b..247b232608 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1408,7 +1408,9 @@ read_cluster_directory:
 
         assert(s->current_fd);
 
-        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
+        offset = s->cluster_size *
+            ((cluster_num - s->current_mapping->begin)
+            + s->current_mapping->info.file.offset);
         if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
             return -3;
         s->cluster=s->cluster_buffer;
@@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                         (mapping->mode & MODE_DIRECTORY) == 0) {
 
                     /* was modified in qcow */
-                    if (offset != mapping->info.file.offset + s->cluster_size
-                            * (cluster_num - mapping->begin)) {
+                    if (offset != s->cluster_size
+                            * ((cluster_num - mapping->begin)
+                            + mapping->info.file.offset)) {
                         /* offset of this cluster in file chain has changed */
                         abort();
                         copy_it = 1;
@@ -2404,7 +2407,7 @@ static int commit_mappings(BDRVVVFATState* s,
                         (mapping->end - mapping->begin);
             } else
                 next_mapping->info.file.offset = mapping->info.file.offset +
-                        mapping->end - mapping->begin;
+                        (mapping->end - mapping->begin);
 
             mapping = next_mapping;
         }
-- 
2.45.1


