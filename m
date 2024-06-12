Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B330C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLh-0001ET-VA; Wed, 12 Jun 2024 08:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLE-0000sD-PR; Wed, 12 Jun 2024 08:44:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLB-0004yN-He; Wed, 12 Jun 2024 08:44:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70417a6c328so4258118b3a.1; 
 Wed, 12 Jun 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196275; x=1718801075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hp73qP7OErp7ZGgPqkAOD0UzQuJ+A1PD/aAVb0gIORA=;
 b=nm9FwBuKYRPvAAY/aN5ofzu9dQi8+uOFLsQef1uk9a7GXDhIScBUHDqyJBzZrIfBRe
 fNdmkk1+/0wc81bI+CmYyvUKZ9UrJEjjTTu2zphde5dH5r4mv4uYB3VIVIUInC916nnh
 oqKrQwhZIbopfwJr5DOIykT9UOCBTKTcZch4vaO4dY4w28Gs+kxpP6doNxJytMdpsGPL
 41mbQUse8raleR4EpZjWH2t5BxM1MJ9Lu7Nqa85M2IVZfbYMtumVb6rU4G9zqfCUd3Z7
 sZhFG5HGOt7SfYMzxOuDZECXHPGFjomjIrgAP0vTJxFD72wov6g7uSZui190Ntcw0/Zr
 nHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196275; x=1718801075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp73qP7OErp7ZGgPqkAOD0UzQuJ+A1PD/aAVb0gIORA=;
 b=rqXga0p8SoMWB0pkgtntB4qFsHpTuHGBa95Pl8VVsWwlUBJvyD4fWcwv7o8KP2pgOu
 Wa/7sx/Gf2W+2RHz017So7Ok8HrEqEBZzrqRpLx/5Z6Ss8gfkhPZ45opLISetpv6uxxa
 y3GFi+ycLhUuFE4fNE7h4g0d4ZWTUQu3XbmG27BWUy9tlNlYWQ6EaUNCoTpLRHqAQlvx
 TL1R6KhONvbFpFeOc49ZTSKBttmyyQFlA9QWUfQhnfuVeGPTRMMPHlcKRI9kLQkZf8Pp
 /4c68pYLxgIYuKGwQE2b6x15ZOymJP/PRA5rd68GWAkvDdr9wXte20+wt+EZBb2s5oU/
 a/wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr86X+0Hr9pWm+7AhfCz9FjbKFucrE+zlolEZL0poqIeew3oWMCfBsELmY50WGrNJ2yFaVYhtYr38MbhpO22JjtH1lkMk=
X-Gm-Message-State: AOJu0YwLz53/6icl3A3doasvmY76mP9SFdnZ1A76xkRogS6dagi72AwH
 DbcJAiUx7v+dq07MKgUpZMOM3+jP8cNCcWJ+tJ8WzEW11md6JmOJVdFVnACGMCQ=
X-Google-Smtp-Source: AGHT+IEBlSi6BYVb/+cQ+MC2K5Njz+PwRmzZrN8mzX1GTUjquKwh35qDppYcIks8cUj+V+pYdZbfdg==
X-Received: by 2002:a05:6a00:1146:b0:702:6dc7:2368 with SMTP id
 d2e1a72fcca58-705bce514aemr1661624b3a.12.1718196275093; 
 Wed, 12 Jun 2024 05:44:35 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:34 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 3/5] vvfat: Fix wrong checks for cluster mappings invariant
Date: Wed, 12 Jun 2024 20:43:24 +0800
Message-ID: <cb635e58663b2dd02baa8e015dbc7fd57da89e46.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x431.google.com
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

How this `abort` was intended to check for was:
- if the `mapping->first_mapping_index` is not the same as
  `first_mapping_index`, which **should** happen only in one case,
  when we are handling the first mapping, in that case
  `mapping->first_mapping_index == -1`, in all other cases, the other
  mappings after the first should have the condition `true`.
- From above, we know that this is the first mapping, so if the offset
  is not `0`, then abort, since this is an invalid state.

The issue was that `first_mapping_index` is not set if we are
checking from the middle, the variable `first_mapping_index` is
only set if we passed through the check `cluster_was_modified` with the
first mapping, and in the same function call we checked the other
mappings.

One approach is to go into the loop even if `cluster_was_modified`
is not true so that we will be able to set `first_mapping_index` for the
first mapping, but since `first_mapping_index` is only used here,
another approach is to just check manually for the
`mapping->first_mapping_index != -1` since we know that this is the
value for the only entry where `offset == 0` (i.e. first mapping).

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 247b232608..b63ac5d045 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1880,7 +1880,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
     uint32_t cluster_num = begin_of_direntry(direntry);
     uint32_t offset = 0;
-    int first_mapping_index = -1;
     mapping_t* mapping = NULL;
     const char* basename2 = NULL;
 
@@ -1942,14 +1941,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
                         if (strcmp(basename, basename2))
                             copy_it = 1;
-                        first_mapping_index = array_index(&(s->mapping), mapping);
-                    }
-
-                    if (mapping->first_mapping_index != first_mapping_index
-                            && mapping->info.file.offset > 0) {
-                        abort();
-                        copy_it = 1;
                     }
+                    assert(mapping->first_mapping_index == -1
+                            || mapping->info.file.offset > 0);
 
                     /* need to write out? */
                     if (!was_modified && is_file(direntry)) {
-- 
2.45.1


