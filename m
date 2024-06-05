Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38EFC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 01:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEf0k-0008Io-Ca; Tue, 04 Jun 2024 21:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0g-0008HG-RR; Tue, 04 Jun 2024 21:00:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0e-0004TR-GB; Tue, 04 Jun 2024 21:00:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso4935935a12.2; 
 Tue, 04 Jun 2024 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717549209; x=1718154009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uC5r2TxjccT79vaaKGZJkjS3ciceRzc4YPA+h7BCu/w=;
 b=jy0CbmReQE+ChYXCGwGKvCb6Xy3zZLxhT84F7zzMd2lzTMV7u6BEWgXzC3CdfBiBuf
 TdgaZxtJbhopiz8kJa3A3xT5aSVkPaQcYGwQ6dmYyliHjDHgnAIL75rrsWCtFYqCbRBA
 KWLDVaDgw2xzHKYtgHSaagBeIIR0jQyhH24/VbkhmQ12p2qJEhlCPKXkkoO9RqsmjaMO
 A06rwbbEaz4Tjmj07ZTD3HIshUZWbHiLvHOkBR9k591W/s5P2U3w/lkNE5sM+rKcRel3
 qoJR1OVI0eKTwqAn0lC/nYLeYLzQb5lIwnSuvKM5PINeYLX0BXhaAgwDOb5fvATKp+uJ
 Bz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717549209; x=1718154009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uC5r2TxjccT79vaaKGZJkjS3ciceRzc4YPA+h7BCu/w=;
 b=VJx7vDFlhkv9J0jSHb+N+jH+hBPAbhQcAMkLEBi4Yeb4IM4L0BaH8LrhZgw/U6bNP1
 YEX9NRr7utpErDi221zmZTaFhAjalxVhPXml7LBRsZKvOO9QC684u4HTHVJ4PqiHPWKe
 ANs9f6XlKPXLTJ/xQs+GtH1IGf5M/zvO33GT+VKmXziQzs6SJOvGGH+spsiehrF0pwkC
 6GQ6R9vYVXZT3u4Mx+V4OkAExCILIMmbm7xxzASmZ4XxkgIqBLesbqcxY3WybKcb7ZhA
 PQgGVaZGtjIPIjDDX1jVOxzVpT6IwcfFH4d+9b4q/Klug1dRmfptMP8PpFtCK2KvbkhJ
 zT0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnmLJhWhuruQnXwdM/W1T7vCnkppiXiL3UMrifwV5MwBxbPcX12xetebMfUEXZ7YtJVrVBxTI6T/dBqRKxmOilboYdLgU=
X-Gm-Message-State: AOJu0YxhkLyXnJN4Ej5uPKQnYIoJdGbU6IizvxDG2WEZKkB83OBGHEeA
 V2zVQhHKy/DYHt0rnb0aZBe7opZNF1NuFL1FTyshmMSiLuRIigpVP/+thjVXCz4=
X-Google-Smtp-Source: AGHT+IHs3HuwyY+3Y0l34g0k/64gvsddyoIYCT1SYAp/C9U5w7e+qwoEcFy8nF9YJPRWbTw1aPmpow==
X-Received: by 2002:a05:6a20:914b:b0:1af:f497:8225 with SMTP id
 adf61e73a8af0-1b2b6fbd251mr1635667637.31.1717549209421; 
 Tue, 04 Jun 2024 18:00:09 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703ee633e04sm3731b3a.19.2024.06.04.18.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:00:09 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v4 3/4] vvfat: Fix reading files with non-continuous clusters
Date: Wed,  5 Jun 2024 08:58:39 +0800
Message-ID: <3b9536c545c3f472fadc98dddd96a9548adec792.1717549035.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717549035.git.amjadsharafi10@gmail.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x531.google.com
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
 block/vvfat.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index f0642ac3e4..8b4d162aa1 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1360,15 +1360,24 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
 {
     if(!mapping)
         return -1;
+    int new_path = 1;
     if(!s->current_mapping ||
-            strcmp(s->current_mapping->path,mapping->path)) {
-        /* open file */
-        int fd = qemu_open_old(mapping->path,
+            s->current_mapping->first_mapping_index
+                != mapping->first_mapping_index ||
+            (new_path = strcmp(s->current_mapping->path, mapping->path))) {
+
+        if (new_path) {
+            /* open file */
+            int fd = qemu_open_old(mapping->path,
                                O_RDONLY | O_BINARY | O_LARGEFILE);
-        if(fd<0)
-            return -1;
-        vvfat_close_current_file(s);
-        s->current_fd = fd;
+            if (fd < 0) {
+                return -1;
+            }
+            vvfat_close_current_file(s);
+
+            s->current_fd = fd;
+        }
+        assert(s->current_fd);
         s->current_mapping = mapping;
     }
     return 0;
-- 
2.45.1


