Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C834C27C54
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 01:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEf0f-0008Gz-Dl; Tue, 04 Jun 2024 21:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0d-0008Fv-Cb; Tue, 04 Jun 2024 21:00:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0b-0004ST-N5; Tue, 04 Jun 2024 21:00:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ff6fe215c6so5259993b3a.3; 
 Tue, 04 Jun 2024 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717549207; x=1718154007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2pTPMBEIDi5LLLvpu+U97bXLBYJm3PiGfhebQ5qPuw=;
 b=ievh8Syq9WQYk1mFxvN0EvuI6IjJ+xlH/MwZ+XmLUUw4ErTWLCzT+4w/ZSYlRw0rmN
 +36t+uSSR1Nml6TxUsFfodwS5jcujMXbDzrOu7DQPb67KP+9EkHooQ3dO2yyugFDUqe/
 W0LptE3lpM1IfZx4TN6tim2a3baO1FIlfFaEYMH6s1E9dZcJlzDg5QVv7rbAwJKi/OsL
 1euw32BdKTJDw0Ei3xsRLUKbmMP8MSWcJSPMQvA93Z7i61kcEC/Kg9RT954V8kzxVlFe
 BVodbOxPj+hgqvn9OdJQrGPIqfw8myAWaV2i6UTdtMUAw7nDzEIxMzK3somupry/XZUw
 KQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717549207; x=1718154007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2pTPMBEIDi5LLLvpu+U97bXLBYJm3PiGfhebQ5qPuw=;
 b=ay1yRoW4NaCOVTQ09eWC41NeJujXyYv2A1dkKG/jwpW+I+w1N6q3aNZ8mNKus0uM4r
 +BgNv6jMnjlL8K0/B0TExk5b9P1UQHE1lqXizYBhZmSe8o6ZhjuPGDNb85PQKtr7Cvhm
 IBSo7kkonlJMFJJuplKLw8iNKsjyMcgAirXbfh5UEXBymURh3MRtFEZxk3PzNXoFaPw0
 w7wpxpye7c/63MW8Uem1j0ep3vOvTYLs+A38VsSLMpio6ikBucso37y6fYPCegLwwdZQ
 LZSptARorjC7h7w6vsGtSXhVIPk/rCHyVp8R1XvLfubNcNumBNVAp33D0FEmALb0YwWD
 pWsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0JElCKbWJPEZCTXtz5S69hpDNM8+sGXGYYokkHA7vidLkGG8r0kCJ3efTGV0Tjm3QzYRciG1bSeuNnMow0pqyDZ1a8gg=
X-Gm-Message-State: AOJu0YwKo5EqedxKKOzN71YfANlQDxs6Uc1wP7ejf/BQee1NNg2c38u1
 UUXjlhRB5msncOncMhObIuUfh5dkyklXyAonZdcZaYJxzOVCR9NsLbmtLzLMldk=
X-Google-Smtp-Source: AGHT+IGOWv8BgH2GIEPNv595ZPHosUGgyKqJbZ87bqVPbC2O6LZMA8vw+LXX1ev0CpVHMP/inNRPEA==
X-Received: by 2002:a05:6a00:2292:b0:703:ed39:fbb7 with SMTP id
 d2e1a72fcca58-703ed3a0179mr243439b3a.5.1717549207355; 
 Tue, 04 Jun 2024 18:00:07 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703ee633e04sm3731b3a.19.2024.06.04.18.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:00:06 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v4 2/4] vvfat: Fix usage of `info.file.offset`
Date: Wed,  5 Jun 2024 08:58:38 +0800
Message-ID: <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717549035.git.amjadsharafi10@gmail.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x436.google.com
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

Additionally, removed the `abort` when `first_mapping_index` does not
match, as this matches the case when adding new clusters for files, and
its inevitable that we reach this condition when doing that if the
clusters are not after one another, so there is no reason to `abort`
here, execution continues and the new clusters are written to disk
correctly.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 19da009a5b..f0642ac3e4 100644
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
@@ -1944,7 +1947,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
                     if (mapping->first_mapping_index != first_mapping_index
                             && mapping->info.file.offset > 0) {
-                        abort();
                         copy_it = 1;
                     }
 
@@ -2404,7 +2406,7 @@ static int commit_mappings(BDRVVVFATState* s,
                         (mapping->end - mapping->begin);
             } else
                 next_mapping->info.file.offset = mapping->info.file.offset +
-                        mapping->end - mapping->begin;
+                        (mapping->end - mapping->begin);
 
             mapping = next_mapping;
         }
-- 
2.45.1


