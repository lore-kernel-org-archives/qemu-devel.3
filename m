Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE86BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpa73-0000nH-47; Wed, 27 Mar 2024 16:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeI-0003Bi-L7; Wed, 27 Mar 2024 16:13:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeF-0005xR-HH; Wed, 27 Mar 2024 16:13:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dee27acf7aso1694985ad.2; 
 Wed, 27 Mar 2024 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711570401; x=1712175201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq8wco9LxYm2lwgJnPrcuNFswulKN41BsT8tTWCz16o=;
 b=NAySpR+meuVJYq+vGr8eAzVgGeTktLNMtPoPWOb1+DoTdQTt53rJ35lydio3jk0Ss4
 TJacZofHPKySWV2CAD8UR06YS6fhIVeWaG14HsTeyprUbbVPyDrzD7oCfQe12CjFkJyU
 zbBbx0xZMdGD887eQaPsotb4sbiG+T6csfzTdqAN1D7eR0alZy5VCLDXG3WCp4DvJS1W
 GBR07TsLTVL4waUa+S7zRdBO+NpOxLZaoeAGfBPRzkiI9fxWDuV/9Hb6gE4ntALRSm/q
 g48jWzdn33hJRdrQIMqWWdcmgsiViJPhw0wSidqEpejdFDMc8WfsRy99pxdCr8nlzQ9V
 ZYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711570401; x=1712175201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq8wco9LxYm2lwgJnPrcuNFswulKN41BsT8tTWCz16o=;
 b=rcFpNevvGrP/msHhnSBzSbz+sX+4AWAGWCJ4nXVA+R8n9JyDiMZfRpMt05s24YdQIi
 S+sNj1W66RR3eyczjiKLOirkAFf0eAlDiIYeZk/XaoIKEe3Q7CTosrKlUVpYv2hr3HWB
 /XJEha72XJxo2Slc6hgwkMTt+oWn/lroyu5uv7D+oG0H4vLLCAcmqPwll6numSxDFSXY
 SlIstY+9i5mD/rxfQkW6oSiTAD/ijeJT3w26qqXUAz2SiuQYjp5u02T84Pfptx/cli3h
 dHC7yOLF+lRYooAAf10a2QUVHK5yLQ31/oY58KJDJ6iYX8cBBfQS/0RNI5/L4TmGEaTB
 GDfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWObuEwThn4sFyjOSmZPfnQ3rrF7uAafo5tS1vAl7z1EoxMM/q9UIAsqZeHMzZsS09eARd+CdhzA8979GCIH/5EZVdFsP4=
X-Gm-Message-State: AOJu0YxkgvxsVZN3CNy4n1IR06CfbmhzYl9H0PFExLuL/CL8QcLu/VlV
 NAnq2IMjlWMDaQIg1yjbiJD20s0wFlve9Nb/6ORH+sB5D9xZaoutd6uzdJrk5kJD4RbG
X-Google-Smtp-Source: AGHT+IFHjmKzcKotGaW+Xb3J5dmnycZ9iUC8b7zmjMRrpv/Fl73s8Zghq682oUJYFxqdlFtocJxJzg==
X-Received: by 2002:a17:902:6808:b0:1e0:e2b1:7395 with SMTP id
 h8-20020a170902680800b001e0e2b17395mr761150plk.14.1711570400992; 
 Wed, 27 Mar 2024 13:13:20 -0700 (PDT)
Received: from localhost.localdomain ([192.228.205.68])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001e08d5a7638sm9682673plk.99.2024.03.27.13.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:13:20 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:vvfat),
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH 3/3] ffvat: Fix reading files with non-continuous clusters
Date: Thu, 28 Mar 2024 04:11:27 +0800
Message-ID: <20240327201231.31046-4-amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327201231.31046-1-amjadsharafi10@gmail.com>
References: <20240327201231.31046-1-amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x629.google.com
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
 block/vvfat.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index cb3ab81e29..87165abc26 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1360,15 +1360,22 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
 {
     if(!mapping)
         return -1;
+    int new_path = 1;
     if(!s->current_mapping ||
-            strcmp(s->current_mapping->path,mapping->path)) {
-        /* open file */
-        int fd = qemu_open_old(mapping->path,
+            s->current_mapping->first_mapping_index!=mapping->first_mapping_index ||
+            (new_path = strcmp(s->current_mapping->path,mapping->path))) {
+
+        if (new_path) {
+            /* open file */
+            int fd = qemu_open_old(mapping->path,
                                O_RDONLY | O_BINARY | O_LARGEFILE);
-        if(fd<0)
-            return -1;
-        vvfat_close_current_file(s);
-        s->current_fd = fd;
+            if(fd<0)
+                return -1;
+            vvfat_close_current_file(s);
+
+            s->current_fd = fd;
+        }
+        assert(s->current_fd);
         s->current_mapping = mapping;
     }
     return 0;
-- 
2.44.0


