Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BCC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpa77-0000p1-4m; Wed, 27 Mar 2024 16:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeF-0003BR-EL; Wed, 27 Mar 2024 16:13:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rpZeD-0005x6-LG; Wed, 27 Mar 2024 16:13:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6fb9a494aso283337b3a.0; 
 Wed, 27 Mar 2024 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711570399; x=1712175199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipqqr2xOwh8qICJewRkxYEwaPQGJHL+EZFPMDeo3faU=;
 b=JZIws/Rmu2sgS7nIYjLTIXVDkuMu5VokuaCjYJMDsn6v+Y6TNSjeymLc98qXUjm967
 md3Gg2ciQEiBwhG7Fpp2HTwuCZeZVIjh/FHLWebR0inHfkQFqfMAm35oBSd7OeCzOHwY
 KAmAK6N/e/RWJS6P+srIjDgkezx2uc8CToMi4pOdw85nMCHwxQKDeCKKxX8alFBUJ7dU
 IevvEBPvL0KmkzaWKmIljyC+UUfFAB8IZM9IhDD0F63QX5jZ/nPZTjjQR+4PibXI+7XJ
 JvMuTIcnWj7KWT282lC+WuAqKKClgMOHP2BVjbGyOQ85+JDyyQTNVMldO47ddqQPd/lB
 iv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711570399; x=1712175199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipqqr2xOwh8qICJewRkxYEwaPQGJHL+EZFPMDeo3faU=;
 b=o+jP7MrH5BKPKLRnl/371wHmWSzScWpHjtKPmawX9Rmel3qHFwdz/ms/EsehHOC9Z7
 T2B8ixFmlNZZSX7+tlsfpp52RXnFBdHH75Cmyja1HLyq6nboVfLWhqAqE79tqhDa1JKu
 MVs2gqOzvvsI5rXhAK58oi1999F5UCKX4kTG18VHajBJzbMDTXjryY/NIN6phZ4SmMAQ
 2pFF/+CGSg6GbKz10Qj8YqZFbGCt6VhGnRWXPplr/kiWhTvnnJWwnmTpFcZ1fJbBejqc
 ynYmBLjjXxOqdnnZbPLaK9YxxTrHKWLxhuzshdy2gCwgdMj8EHv4i4fFjI3j1/gDey0F
 v2cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu+MHhlrFLbqt2M8CFY9gRBdO4DCelIYpevqj63JJl1XNeY/vsRhoh/4U/LkZz7HAsfdhmYCmaRoep3FOW8QC1EPvqOB4=
X-Gm-Message-State: AOJu0Yw/w3C6oJO9Hr5+934g4ky63iHiK1J5L0NJk9NGKEu7c45X7Gdd
 db8NR0ti8WECcedI/bUh0Ikxkx2PRs3xio8k7Q8Q6jSRdLjSzbRXKwq/UBPRl6GAX3Yp
X-Google-Smtp-Source: AGHT+IFgP8n+DIqi1Vus3n5GTJgd93MOpsqUInmVuepXpJcwfJmTy+BRwGNXRaLtB2KzcMNAK8FOWw==
X-Received: by 2002:a17:902:c409:b0:1e2:86e:a0dd with SMTP id
 k9-20020a170902c40900b001e2086ea0ddmr708227plk.23.1711570398987; 
 Wed, 27 Mar 2024 13:13:18 -0700 (PDT)
Received: from localhost.localdomain ([192.228.205.68])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001e08d5a7638sm9682673plk.99.2024.03.27.13.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:13:18 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:vvfat),
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH 2/3] vvfat: Fix usage of `info.file.offset`
Date: Thu, 28 Mar 2024 04:11:26 +0800
Message-ID: <20240327201231.31046-3-amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327201231.31046-1-amjadsharafi10@gmail.com>
References: <20240327201231.31046-1-amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x42d.google.com
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


