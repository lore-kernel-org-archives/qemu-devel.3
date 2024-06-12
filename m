Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6D8C27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLj-0001OV-Um; Wed, 12 Jun 2024 08:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLG-0000tk-BL; Wed, 12 Jun 2024 08:44:43 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLD-0004zw-4k; Wed, 12 Jun 2024 08:44:41 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso1019776fac.2; 
 Wed, 12 Jun 2024 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196277; x=1718801077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+v+HIv51CtqkxYFi42nScIfp3QBbrvdk4LeJEzD4Wy4=;
 b=nO3xkrrBGPD0mSD/MTUyBlIUQgcMtmKH7vGPNQBM8BbMAdF6le90dkROyEzp6QPeo9
 izI/c1PEH9P6lLBRJ+MNcBqmkd4KDYt5E3Y19rBv+XZdYai4yvwII0QqUk4Or7vUK328
 B7UYwf3Fh56Pzemg009IFx53GA+gAnmWEK1yaDu2cyDqpl3G+ZvTVtywq74TP05KWf+2
 Qlcp8EpnWE5eb3FPlWWMqnbQ4rnmtsEDHfK94mYF97Vh7FdRExuYmZHT/5YYwx65caKj
 2D2/XGmBNHWUYSPHTfmPp3FZQ4B1+J4WkSafNN4+SCFSGFquktAWminuNsTCKQr+IdX5
 vUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196277; x=1718801077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+v+HIv51CtqkxYFi42nScIfp3QBbrvdk4LeJEzD4Wy4=;
 b=s9OoK+aqA9Ij1/C9VDdctR/ntjs9Xy1+CYKf8yGqoG1loJVyQ5CiAp30XvX7sZ5nT/
 gB4ZJluXjimCIqDzzju2WIH4XlEQhCunXTCAIgdA6QaBNXI3FsIiyf7TdpVjmXsRmiyO
 G5r4nWiGheAltI5UBc4LZZEx+S+3K7PJi79kAVVyiQxUUvcXJ5JEOtKqGKcnW3PImf1s
 yqMFi2NDF7McxIq7lU7iw/wvozexv+QpuSDdbkqidGtlG6raQCytY5e2TGPapw0KDX8q
 4Zz4rql8fnXclQOK9VOrQGh5q5B73hi3tf6G7fjtg8diXQIq3jgG8xL2I3a6XBC4qHXA
 boCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/9XSdCGYoJvhaahTmrbubHVegAQh0U37DcnlEqodBbveigKgteAlXWB9J7dhBlYZG2XbmNtwIUCalXCcQdymXezzGvPg=
X-Gm-Message-State: AOJu0Yxstyv2jPmKKS/qQVSz2je7P37cY7JVmLjRj5PrqNyaht3jDEUF
 /BPquN6IBo2zIvAh5zIZ4EsCH4wu3FyWevOt6ko5n5iWt/xS+7LnPHCh2N2Y0Bs=
X-Google-Smtp-Source: AGHT+IHTZj9airiY9qYWw0/Kpu1/HB38FDeELQfFhJWZQkAgp50u+VNxu2b8HC813YCBWryT7ufcNA==
X-Received: by 2002:a05:6871:b29:b0:255:162e:a8b1 with SMTP id
 586e51a60fabf-255162eaa8bmr1941952fac.51.1718196277089; 
 Wed, 12 Jun 2024 05:44:37 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:36 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 4/5] vvfat: Fix reading files with non-continuous clusters
Date: Wed, 12 Jun 2024 20:43:25 +0800
Message-ID: <9c0be954b608da7d47c6a0c120da332c16798d2a.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oa1-x2a.google.com
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
index b63ac5d045..fc570d0610 100644
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
+            s->current_mapping->info.file.offset
+                != mapping->info.file.offset ||
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


