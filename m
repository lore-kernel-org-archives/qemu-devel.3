Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12C5C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV76A-0001Sg-A5; Sat, 20 Jul 2024 06:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV768-0001Ld-Ip; Sat, 20 Jul 2024 06:13:52 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV766-0007RH-Vt; Sat, 20 Jul 2024 06:13:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c6924f2383so1274980eaf.2; 
 Sat, 20 Jul 2024 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721470429; x=1722075229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0TcqHDGmq+zPmeeTD6pafWi3xRQRQCgCCjNIOd26LE=;
 b=hSsbivDy3fMpaiJsC9lWG/ovuShdG6cwIx6sNTnRhO3ECV5xT3Uuy/3S9j8SR3slRu
 HLCPPlV36MPEmcibVIOF03b+Ya5yvjtuRlXVC1wMDSA4GUwU3+7KywfxLDRa/2H2UqQ7
 6xO1wL7/BNbkh4hqFEkXtBQTLUJz6E2+2X16T5MI0m6RUkYbwjOmaT9kR/5Vh6d0Qg1G
 m+UnjX36f8NTSucQeY4wtfNeDhOCJU6skH7ZYyqJDEBm4SAzpPi7oUt6aGKLpXDkOAr6
 ntg2cb79MKkvSIc2rKHh5Oe/tRsHDZrqXYyF/UbN3jZHPsJ1iQLkuQwQQZ2Ip5e+omId
 Ca1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721470429; x=1722075229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0TcqHDGmq+zPmeeTD6pafWi3xRQRQCgCCjNIOd26LE=;
 b=ZNDzBY9gxwIpMcNjMk0bFYeOueBeVS7osIAXd42lbrGjl762TvDAhoT69WUU3IQrHj
 2NRvGqovYEQttzmXfnzQLXlP/4Y/FfubaHY7Ab3IrgK0pjUDg5lTdIUa+xSbnifXEpwv
 chp5a88fySY3fzqyZoqFdoLqLXGzdCCl0mj/3blYG/7pYRYwh7oIccTwcAMSvseeytsI
 Sz5PI6RHueBTW0LW3QTsIXjk83XIo3PJrU2aDinmxkrRvwmxqGBwBxma3kmZwQLmDDhx
 gfMy75Tf1vUaZ0oUxkgZYlDApJMoEUwA6KlQGc+8Z8e9s25AmznZ0QXEZgsGf2VFguiO
 yA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx8Sf2ObEMosuWlxlgH/Er1VRkbA0H1v0peMsquBCQhUtKj9xOGdu9lWo4ZOdirjiKZ1TMsXcFhB19UTIisZSHyEPW9TM=
X-Gm-Message-State: AOJu0Ywy2f8U0MVx+bGKPh+fOeABj+FdBupCBh05K6N9weOeSWtN/U/g
 KT+h4c7Ich1deV6D3DEaA3MPKqiKXQ+SH3/kUNYPSqqoA8fO1TIeUL1X29Xem/EymQ==
X-Google-Smtp-Source: AGHT+IEx3eZ2+QDRU3KSgCx+OV+pBNRFvlIeIxRWjJ8O0yjzM4DTtM3tHEIt/k5BZ6oeQUtPwypRXw==
X-Received: by 2002:a05:6358:726:b0:1a5:f991:ae54 with SMTP id
 e5c5f4694b2df-1acc5c4b72cmr244477255d.20.1721470428817; 
 Sat, 20 Jul 2024 03:13:48 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb76a5fc6csm4411208a91.0.2024.07.20.03.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:13:48 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v6 2/5] vvfat: Fix usage of `info.file.offset`
Date: Sat, 20 Jul 2024 18:13:31 +0800
Message-ID: <72f19a7903886dda1aa78bcae0e17702ee939262.1721470238.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721470238.git.amjadsharafi10@gmail.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oo1-xc2a.google.com
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

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
2.45.2


