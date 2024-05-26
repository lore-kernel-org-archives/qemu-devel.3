Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11645C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 09:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBAcS-0006FD-K4; Sun, 26 May 2024 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcQ-0006Du-OI; Sun, 26 May 2024 05:56:46 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcP-0003p6-6Y; Sun, 26 May 2024 05:56:46 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b53350921fso3993412eaf.3; 
 Sun, 26 May 2024 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716717403; x=1717322203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pai5/RNvpgrHRxkL4/w4wO2z+CuTDolRdw2cxdAsR5I=;
 b=kWV4Hq/r2lfj+w9D5vdUKNjeLFievvAr0dNhAa6lsJN0220Vrc0qi1GVUq82tj4SsP
 TA5Axd695luCY1Bg7hgblLFt/SW3WJUxedWYmS4O8k9ozm+LYbfQsv6OUaw/eZJXfIkT
 fj64RXywYkoPlKeJhx9NoXoly7EFUsQk/AHzSSnOe/AP6/9nb/cDlUsSOpzgT4wODT9p
 IE/6CEXc+7b6xK8vOZ72l5HL7VCpEPjWLwjx4AwRA7gdmxv1w7Xa5Rb46HtdoFCYrWT/
 rvoaXbR6R2iCjoV/wX6jgdTqsFN1/mRiceVo5/j8SsvvPlZwiJ16EqiqqDnW+mWkG8T/
 tV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716717403; x=1717322203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pai5/RNvpgrHRxkL4/w4wO2z+CuTDolRdw2cxdAsR5I=;
 b=ArOf98COsLPP8ZI2RybpCee4HEMW8O76Wl/F4BkPcxFOxHBfqtySzIBds/9aYI80x2
 2Cfzyf9xUSFnBN0mtKY9epWUh+sU1ZKYF4S/0cIC1HLv1IWBUocNdiFg+4aWQkr9K48z
 IHRMSJAiTbe8qcP5TWE+xh4cK/SRAZoiuHzIlnyVd7261WZtfdtpc/bAH/gGxuzAvcWl
 /QI21C/wz+6ihUhFsbIaJ62KblI336GuyV9W311Rjlu6wY/hKwvNpAYvciNLtD/e7w5g
 emXL/MkgH1cPRrZIvIv9Fkt9rn6KYxiN2I4EDCuKBYqVaTZdsdFO/kwVJIPbrStI8vB7
 ayYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH8VZAceWmxpQxChJMgMA9k6MJTJYC2haaZXBbBGt1wX8Xd8ZlfUgCksKsKvNuXC5y7NAAtQFdgmQ9gdgJElgJUvY2eSs=
X-Gm-Message-State: AOJu0YzKcbNmL7/fjkZYQiOrIkcCWhPrKXs8MEq3V3Vjt8A1l0aV8lZw
 tg2zS5dzAg8E9T/rVN2xkfEmC7vbtjwxTveKwJwLNbOEmoXwMYFqLRpvbC08
X-Google-Smtp-Source: AGHT+IHu+siSMxZfcH5hrtIN6CAYdqiMQSQ+ncv3eik0rEEINB+F//JsiGEtDTeriLOKV6i1D9Ihiw==
X-Received: by 2002:a05:6359:a10:b0:186:1d2a:a457 with SMTP id
 e5c5f4694b2df-197e521706bmr657718355d.15.1716717402719; 
 Sun, 26 May 2024 02:56:42 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm4021368a12.46.2024.05.26.02.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 02:56:42 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v3 3/6] vvfat: Fix reading files with non-continuous clusters
Date: Sun, 26 May 2024 17:56:03 +0800
Message-ID: <b96e79ca14e4d90a2b983d3c5d1bc98045979b68.1716717181.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716717181.git.amjadsharafi10@gmail.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oo1-xc2e.google.com
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
2.45.0


