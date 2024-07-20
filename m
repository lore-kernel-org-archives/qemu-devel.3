Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF16C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV76E-0001jE-EB; Sat, 20 Jul 2024 06:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV76C-0001dH-U5; Sat, 20 Jul 2024 06:13:56 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV76B-0007TH-9T; Sat, 20 Jul 2024 06:13:56 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so1558622a91.0; 
 Sat, 20 Jul 2024 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721470433; x=1722075233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsFMsus6VE/JFgo/xYfX/N41AZYUF7OSOz1IzwXOsx0=;
 b=edT/JrnwhgwPKLLEDUPBQRf39BtiRi8p8TKBf7aTyPGcFCgQfi6ceJFV419dsLuBO+
 cn5PgFqV35xVt8stkxfuaHNfjs4XqouUTFOWAEJfMQezG1sxAveHKY8clKz3vIXobORr
 HrThXZmhpl/9seDuMcaIZzW+c50k8F5I4Q3jgMAXwiCfGMUFGhqbf5/Z5OLAM4gnjtIJ
 l6ejHo14ZolYWVVElcBbvHu056HmYgzqSndzodu8oQq6fittLw1E0U7ZABAeprva+9hJ
 BQJTWZSCxkVzUZU5TR7GNjm+5WquW+y4IFs6nP7/6LTG6jVv1q6zzxN+2fUu4YTNWlng
 BQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721470433; x=1722075233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsFMsus6VE/JFgo/xYfX/N41AZYUF7OSOz1IzwXOsx0=;
 b=q3t5Tz8elbjALAYCDUMsHcWABatH+mJVyfZmppNkAIJ5XMRPuDcoN7QsZwwcnUbaI1
 12jjEYD7nhHffZEgBSqJNCwkDwmyE2FcQtdwtF7Vi37qtGD7h9qyYEK6GNA8FUs/yJke
 RQag/3vDS3nUOyH20mhxQ/jfrUJ5ml66Bf1sRRie7mMHq2dbjlXX+l9JYflGUk+rn1/S
 gAkM1awXgOWgdO1/ZyY7K/iNIwe17xyb4RUIjWV2IkCH22PnghkRpD5eFJjp8RLLkUz7
 Z6qQosbbqUkkVlhx6P96X/K4iyeSHc+SY4IRL0RYRF9rh9REGrC5ihgnBa7hH2+a+o//
 uP4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgn80oG23Grw7iOxh3pWMDi/KwLVjBjbaArTeovwcMy1QN7Z4JtgrwNLG4P9Ms/MVper39KA1x+EeqBBlD3F5QQktSptA=
X-Gm-Message-State: AOJu0YwLVWlDkhiErZxjSygi9TMMdma0VnmB+w8sKB6hvMQ0mecT71qC
 y2T1Cyk4ehs5N1m2QQ0ObkRm7xThZs3/bEvT1Ccyk1kb69Zlmby2n4xEmrbXBkeo5Q==
X-Google-Smtp-Source: AGHT+IH1pm6kgzJXdS5U+Is4y7r6xBU4p3yaFKa29dHR6Ir458J8lnZsueWAN8/Rs9LA9E8aHuOBlw==
X-Received: by 2002:a17:90b:2303:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2cd170c92f3mr3716260a91.15.1721470432991; 
 Sat, 20 Jul 2024 03:13:52 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb76a5fc6csm4411208a91.0.2024.07.20.03.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:13:52 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v6 4/5] vvfat: Fix reading files with non-continuous clusters
Date: Sat, 20 Jul 2024 18:13:33 +0800
Message-ID: <1f3ea115779abab62ba32c788073cdc99f9ad5dd.1721470238.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721470238.git.amjadsharafi10@gmail.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When reading with `read_cluster` we get the `mapping` with
`find_mapping_for_cluster` and then we call `open_file` for this
mapping.
The issue appear when its the same file, but a second cluster that is
not immediately after it, imagine clusters `500 -> 503`, this will give
us 2 mappings one has the range `500..501` and another `503..504`, both
point to the same file, but different offsets.

When we don't open the file since the path is the same, we won't assign
`s->current_mapping` and thus accessing way out of bound of the file.

From our example above, after `open_file` (that didn't open anything) we
will get the offset into the file with
`s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
give us `0x2000 * (504-500)`, which is out of bound for this mapping and
will produce some issues.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index b63ac5d045..d2b879705e 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1360,15 +1360,17 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
 {
     if(!mapping)
         return -1;
-    if(!s->current_mapping ||
-            strcmp(s->current_mapping->path,mapping->path)) {
+    if (s->current_mapping != mapping) {
         /* open file */
         int fd = qemu_open_old(mapping->path,
-                               O_RDONLY | O_BINARY | O_LARGEFILE);
-        if(fd<0)
+                            O_RDONLY | O_BINARY | O_LARGEFILE);
+        if (fd < 0) {
             return -1;
+        }
         vvfat_close_current_file(s);
+
         s->current_fd = fd;
+        assert(s->current_fd);
         s->current_mapping = mapping;
     }
     return 0;
-- 
2.45.2


