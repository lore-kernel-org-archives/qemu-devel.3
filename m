Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA2C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV76C-0001d7-Ts; Sat, 20 Jul 2024 06:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV76A-0001V1-Su; Sat, 20 Jul 2024 06:13:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV769-0007SZ-8Y; Sat, 20 Jul 2024 06:13:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so63517a12.3; 
 Sat, 20 Jul 2024 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721470431; x=1722075231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZ+98M5u4oIUEUTkUVwqPpKA8S8Llpagu9lbB1G2xCw=;
 b=Ae02YyPpxFn6s23CBK5xfHmxXHP22QliAE7RcMw2QdsOgHBx+XfuUzzuIvWopGvhhg
 R1LBStR8B321BuePrGXZt7EYLBzjV+XiRUjO+xM8xaR58LZIQBFMlLyVDFxwVEd1m3Su
 R2Ly0LDvNeLGGd/PboUa32osUNoobESwU4u5hl2kYd5/lBrM4y2n2rn57PxL2Wx7SGNA
 IurbwjV8tGW91mgnbK4k542MhKc9cyk9xBHI97VyqxMjFnapqh9pf3siz315zIgnnt0a
 1724LngC8LgWxKPJz64Z7PXJhAo1ZEa0aFR1IKTjW90oNzHHwwktGIYdp8PLwmp1UcKi
 Xp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721470431; x=1722075231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZ+98M5u4oIUEUTkUVwqPpKA8S8Llpagu9lbB1G2xCw=;
 b=iIlrHYn2zyBl1YhTUxVi/ktm+PpRTlSCsyJQeZYzNjqElItKlwI8d3s8eAItXiuQy+
 L3MHWr23oUTkCcSSE2163aU2Y7yV+hCNlO0s7xwDEZB+gK/oEqYxeSA1BzhkJMoAjgJh
 AKy3BFJOIioueW4a09ctcZp+S9dcx8SftJ+y1l+rMngVDGt3C1DZy8JEP5EU/gdidXh3
 /ry8F1o1KHHVrnwBQP62DgWaLlHdEQxpHnoAGRPEYvXCApzwf/bfNy2hTz/FH15B5OM/
 voGGG1Ar5natcpBfzbrmqSTK//l1fkNQEaFELnzT2B+tXKEsKHatyGs3pZlaj9clKYnZ
 C/0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCMbLCEQ9ScaDYZeZ6UV0ZcWIBrCrYvi6lX4ctm7+NHM8GhTEic1wxtvao2Mwn8YLX/JTAWFuhy0//lnIeWmHH6caXN5M=
X-Gm-Message-State: AOJu0Yyg5Y+yf+ASEoJXrEiVjHe5bWNCcaNpLTzgLE48nW3m5ax16e2s
 C7wQKO43piAA5pj/l/40ozvYcYmGsu5Jp4nwiwPr42RAKcQUqBUIlt80AfjQLDcLMg==
X-Google-Smtp-Source: AGHT+IFzKucPvRWDzx9fRjpX16OIvXkNVcuveRHObIhj4XYIS3D9Y/Qei0m60aKVbStjks+pYadIbg==
X-Received: by 2002:a05:6a20:7f91:b0:1c3:b61c:57cb with SMTP id
 adf61e73a8af0-1c42869aaa0mr1096511637.53.1721470430904; 
 Sat, 20 Jul 2024 03:13:50 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb76a5fc6csm4411208a91.0.2024.07.20.03.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:13:50 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v6 3/5] vvfat: Fix wrong checks for cluster mappings invariant
Date: Sat, 20 Jul 2024 18:13:32 +0800
Message-ID: <b0fbca3ee208c565885838f6a7deeaeb23f4f9c2.1721470238.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721470238.git.amjadsharafi10@gmail.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x52a.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
2.45.2


