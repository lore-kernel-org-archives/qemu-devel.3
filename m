Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE62C10F1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B0m-00085R-3v; Sat, 04 May 2024 04:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0k-00085A-MP; Sat, 04 May 2024 04:44:50 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0j-0001WY-7B; Sat, 04 May 2024 04:44:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c963880aecso24109b6e.3; 
 Sat, 04 May 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812287; x=1715417087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipqqr2xOwh8qICJewRkxYEwaPQGJHL+EZFPMDeo3faU=;
 b=Y2Q5xP+Nt9YhGame4colnPi5rehUh9jmJR6HzoAp+fv1pwYmGx/W8sIffkb1+m1uoB
 jWqU5uo2cl4jLidXiimOV78/wZ43+gB7t+eJh/V8ODT5wHlOk9DDl5S36v6apvccxTsD
 V7D60QOggyCO2TOy6JU0ytwNvoM1wFjUTy967JHI0YMkG486xu6sxKsk4boGHb37pLYw
 Z5HNWLSb//OiMBTPEGhhMZR2xRnaN2Iyp1BUpTyqRhtTVSGqsRU27mWnFHwfXc784pVQ
 uVlwWavzEPSb+kALTTsxUktvO0s7l69QDTNjRmo0ZWcPQjP7+v9Ub2iOfrg9iERqYqax
 /XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812287; x=1715417087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipqqr2xOwh8qICJewRkxYEwaPQGJHL+EZFPMDeo3faU=;
 b=mM5lW2yPj9lB09Ocre4LwRZmRdUbq88CnJd5M6hMrD8oNsf+RHScBCwyAr71KvCDvA
 8/+hGOozj9vHNW8YrLonaQ/3CfNI0OrP4gw/p9Vdehs7TxvlRhk5NPrMr95re49uGli3
 xHxPV/q/a+sLrKE0/FjTT5YldSIQz2ZhFqjjdoi78bnQArDXYq7KoSIJhxhz4JcgGHqx
 yEBeV+kzIg7LMBmwa13pBWVBaewUSwYT+tJ5UyfC5Jg4plvJfZbVy/SV0yMOrNmdPZws
 PIt+eJDlJmZmDUGn0ZLggWVbfxv6xEWqwhh4OrWaK4MLAeTJIoDRlJFZ5mg+UaM3IYoH
 ZJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM3JejuSvsG+TqtPWigva3+RyRcocjnyxw/UfYmx5B6QiMGKC6VrpGlh05RVE4p4RnwHaUPUDhp2k/HGGit36e0XgG1c0=
X-Gm-Message-State: AOJu0YwDiGYcI/VF4NSZ/rwbJgtt5UVFNNVaZn7rmY4dIhWw9ZiXnu8a
 T5Hnx6YnD0wf26LqGcpUKCmnelcjmxjkOxOOrHPU1GAAdyzVxTka30lbjA8k
X-Google-Smtp-Source: AGHT+IEFaNWwIjy8dtfZ6D0yRw3I/RI3WdeYhRUMe1JnS8p9jZmN17lbx6FOP4y3ZOFjTxooxyWPJg==
X-Received: by 2002:a05:6870:82ac:b0:22e:d541:7eb5 with SMTP id
 q44-20020a05687082ac00b0022ed5417eb5mr5984365oae.38.1714812287046; 
 Sat, 04 May 2024 01:44:47 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 ei32-20020a056a0080e000b006f44e64dfe3sm2310393pfb.177.2024.05.04.01.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 01:44:46 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v2 2/5] vvfat: Fix usage of `info.file.offset`
Date: Sat,  4 May 2024 16:44:20 +0800
Message-ID: <836a0ea26f641a4f0ff4b2bd8e9c9d17c59ef2d7.1714811679.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714811679.git.amjadsharafi10@gmail.com>
References: <cover.1714811679.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oi1-x22d.google.com
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

The field is marked as "the offset in the file (in clusters)", but it
was being used like this
`cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.

Additionally, removed the `abort` when `first_mapping_index` does not
match, as this matches the case when adding new clusters for files, and
its inevitable that we reach this condition when doing that if the
clusters are not after one another, so there is no reason to `abort`
here, execution continues and the new clusters are written to disk
correctly.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index ab342f0743..cb3ab81e29 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1408,7 +1408,7 @@ read_cluster_directory:
 
         assert(s->current_fd);
 
-        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
+        offset=s->cluster_size*((cluster_num - s->current_mapping->begin) + s->current_mapping->info.file.offset);
         if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
             return -3;
         s->cluster=s->cluster_buffer;
@@ -1929,8 +1929,8 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                         (mapping->mode & MODE_DIRECTORY) == 0) {
 
                     /* was modified in qcow */
-                    if (offset != mapping->info.file.offset + s->cluster_size
-                            * (cluster_num - mapping->begin)) {
+                    if (offset != s->cluster_size
+                            * ((cluster_num - mapping->begin) + mapping->info.file.offset)) {
                         /* offset of this cluster in file chain has changed */
                         abort();
                         copy_it = 1;
@@ -1944,7 +1944,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
                     if (mapping->first_mapping_index != first_mapping_index
                             && mapping->info.file.offset > 0) {
-                        abort();
                         copy_it = 1;
                     }
 
@@ -2404,7 +2403,7 @@ static int commit_mappings(BDRVVVFATState* s,
                         (mapping->end - mapping->begin);
             } else
                 next_mapping->info.file.offset = mapping->info.file.offset +
-                        mapping->end - mapping->begin;
+                        (mapping->end - mapping->begin);
 
             mapping = next_mapping;
         }
-- 
2.44.0


