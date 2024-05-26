Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F505C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 09:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBAcP-0006DM-TB; Sun, 26 May 2024 05:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcO-0006Co-IC; Sun, 26 May 2024 05:56:44 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcM-0003oq-VE; Sun, 26 May 2024 05:56:44 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b680c1fdd4so3031968eaf.1; 
 Sun, 26 May 2024 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716717401; x=1717322201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aGPsWq5Naz4uqiF5AmaN5boMB6iQaQGhjOrt7FuaD8=;
 b=cqtFrlpTfWF3oLWZGUS0VpUtipoEyofj3s4zA6w8w6cVM51ZmNpGWMqicLabtgYHCl
 G5xj55IdWqZPX9b+DcWmJejcC9f1RC4DyAVbVlUrYmUYCeuMiyyPDhlOJVWogtOGAryA
 prA73+0pIWHjbJe/CDYGNPL3XVKjRARQ1y5y8KAMKHrGLH2vZe4ryj7o+sAsrhNaxxrV
 iBPboS3S1Xt3T1/3b2uqFjFwPOhZkd7c8v5vgOGy+ZIk+qCEUt/OalVi3dGFcteC/DCG
 w6lyDeaRpRSUALTR03vxa1xxWFh0jAw4a/lf9jBG3FgHt41Y4ixfLtgorX9lfldW80nq
 en4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716717401; x=1717322201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aGPsWq5Naz4uqiF5AmaN5boMB6iQaQGhjOrt7FuaD8=;
 b=XFADQgT9byKLZIwjZBPNXeP+QMPS7VMHFtWa3jnfJ+ib8k4rESSE5xbXBVP8kL80/9
 f5b4gH/MECxAIiQtdDxmvmLNJuNtxJjvlhLktrtk0/sr+AeHNzKpBQAqnZX/sFPsA4k6
 V4IDOnH0B4JT+mmWBS1vC4tkZaUsIU9C65TGfpQ8U/s/qMMAVDcJkappVVrQpCS7MibH
 jxk/gGV5N36NxK8fHFGfZ+U6A1GzJnQXx8L6coQ+18FdYa+9TDAWgpILlR0ye5lqRzFQ
 Eh4Bhavku5XFxMAROaabMGjNGoxAtdB+c1+WUbeChYUHL+DmtRC+U89swxQyrqukOaqg
 SLPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWisa0VIVhtk1sSvwzV5qAzqaOAE/6t+eIaTXVWDhEeGqqb6oFnjGNBXw6C17cn68LPs/3yElwVKPcSQUSTRZMudjw/FuY=
X-Gm-Message-State: AOJu0Ywptra4sGKGxjtEMcshWw52dB48JMnfCxYm24Nu/nvJ8Nxe/FDb
 KCMKtoCz00oNUFyIzPQw5jYG0TAiSj5WaM4NeM8dNQkece34HB3vApTBETOG
X-Google-Smtp-Source: AGHT+IF02c68RQd9m1+GGCU7SgrZ1UbneVRrtUhdeit643bsF4MvBK5VFkvPFD2lad4SmuiWYaCg/A==
X-Received: by 2002:a05:6358:71cc:b0:18d:9e17:455f with SMTP id
 e5c5f4694b2df-197e5101158mr891480055d.12.1716717400688; 
 Sun, 26 May 2024 02:56:40 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm4021368a12.46.2024.05.26.02.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 02:56:40 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v3 2/6] vvfat: Fix usage of `info.file.offset`
Date: Sun, 26 May 2024 17:56:02 +0800
Message-ID: <836a0ea26f641a4f0ff4b2bd8e9c9d17c59ef2d7.1716717181.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716717181.git.amjadsharafi10@gmail.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oo1-xc2c.google.com
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
2.45.0


