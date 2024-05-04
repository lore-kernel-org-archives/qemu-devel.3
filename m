Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB6CC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B0p-00086t-1m; Sat, 04 May 2024 04:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0n-00086A-7p; Sat, 04 May 2024 04:44:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0l-0001Wz-P2; Sat, 04 May 2024 04:44:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so350088a12.1; 
 Sat, 04 May 2024 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812289; x=1715417089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq8wco9LxYm2lwgJnPrcuNFswulKN41BsT8tTWCz16o=;
 b=j33RF0C/TR1r77mNdStr29/A+/wR8bn5iviuuB3aU+mdgTNYaZ0K+TA5YL2EtQsR3w
 aBn3w4KCKO1wq9SVru5tmn52/PtHywxKiCwFE01YALj/GNQDu6XP2OjS2vnuStE7IP76
 Yib+muFIDvP7PGiHQtLz6pQy+qzpwwmMcnvkdR3ioFPOL0y4SsAk+Cjy3reNzI/DVDpy
 db21+y2zW7SROZEnaK76DXa5Yd7jvdYQejLbGylr+YrCig1G+1ch6PhxVkykesAq8Bg1
 tCJJlMVGNYuxJgA8itlgJ3zT+fW8KREp3AiPKNBKri++ZJVEhbTt6dMyvnoQAVNnxqGZ
 dyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812289; x=1715417089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq8wco9LxYm2lwgJnPrcuNFswulKN41BsT8tTWCz16o=;
 b=Zbf00udyo8FnzpU7DowQc0ba+gwSnXavUohbsmIfZQ3zgCdtCH74ii+mOAh1ru8HaL
 9LpRlFwkzuMOtvISbntxQ138AMgUpFb9XAzVpXQ9uQYva5gMabW4g/XImAZUXh/o9kmm
 4B2bvkhsYmwr7c20d7uNA4k3ql8JJ7L74XD+cd6L6YU1ImmOpIaM/U0mVW2OZgrzKpOe
 dDK/eXaPVZLq6gYn1XA0EjX9VaefLlA6sL7sxaQieQFrcA3Euec5D9giQqQY5bifwUof
 DGt0/nAM/FtyzsNHDSJObNeJ/W6Oi7Ye+VoN93gtbHHiEtlxmGS3St8f85m9ITAit/n7
 E1ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQsKMDx7S/B2hwJ2NlLa2oRPMsRxcWCJaAskuG6PlH+JCuszrcGaC+LjO2RqijTk0ZjLeKC/vG0qx6xfdm6nwZd8JVcU=
X-Gm-Message-State: AOJu0YzbH6/ZDbZryIygJ0H8zYAG04nbY7SYvaYFQ38oUZME0MWkaG4l
 UOh0dHe79X0S2p3JQ4OxC4VeQ8y28C05zipVfZFSvuKARl1EO9D4ecsM1oDF
X-Google-Smtp-Source: AGHT+IH4P9m+nu650WGmAf809mya2WaEIwjaGyHC6S0sw2KkntiD0A0qJLdsK0rraHauDcEBKTouKw==
X-Received: by 2002:a05:6a20:3d85:b0:1aa:755f:1746 with SMTP id
 s5-20020a056a203d8500b001aa755f1746mr6864350pzi.22.1714812289167; 
 Sat, 04 May 2024 01:44:49 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 ei32-20020a056a0080e000b006f44e64dfe3sm2310393pfb.177.2024.05.04.01.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 01:44:48 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v2 3/5] vvfat: Fix reading files with non-continuous clusters
Date: Sat,  4 May 2024 16:44:21 +0800
Message-ID: <b96e79ca14e4d90a2b983d3c5d1bc98045979b68.1714811679.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714811679.git.amjadsharafi10@gmail.com>
References: <cover.1714811679.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x531.google.com
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


