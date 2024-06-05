Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4FC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 01:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEf0i-0008HU-NP; Tue, 04 Jun 2024 21:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0c-0008Fg-G8; Tue, 04 Jun 2024 21:00:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0a-0004S2-GW; Tue, 04 Jun 2024 21:00:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-702548b056aso3192013b3a.1; 
 Tue, 04 Jun 2024 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717549205; x=1718154005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymVSlpsEC0B/nB1jHObObR3P+gg3N0AOCscuoEKuFXg=;
 b=U8Sfc4H/nWUEoiohJSFe8hReVVXvDm2QyXvvOE8plYZi5n1vW7E0+BAdNe/OaffxJi
 O1gw+TvLaSXlHv8v7YoU1lt3Vp3i7prtV4LHAG9VryRdTTYhLxX0JQnjZe8NSHjQWNGs
 Wyl6RwEu1gZsj7MGiDDEQKygdd+IoVaerhFD7/mSNJyWhPg27S8TKDLIpNxfu8mZhGze
 XkuXfHKSMOlsogGtvcwDVCfOheTPcu3KK8u3hL9b9JavxfgSAjEfuedD+BfGLKbD7yoQ
 a7/NEvS0AA3dvTDmTEnEGktV0oyVDWn4Tn1dl0bh0mIfjs2eOhffe6Hbau/vLWcGyoEU
 5EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717549205; x=1718154005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymVSlpsEC0B/nB1jHObObR3P+gg3N0AOCscuoEKuFXg=;
 b=r343QXjxJ+XY6vMd/TS/fcGM8RuJ1IHf2NxVtfpgqibv0fM0N7tT2J+74WljETY6Q7
 xeHpGUXV8Jzge1miK2Z2o2CXKcVf0MM7YRiAuvgvwYUJn6txENHaOgr+5V7QuULAfnTW
 nXTR50qF8Xj7M53HL0OVc9SOV6iQB2/4aW3rTQYdKUnYIHzPWHHohYW7Ck8UwyoMvUHR
 kRHad6455CEUfjEDgSuDfenv/W8G/FnNapwsFwhEDkQtyEumgXoYue1XRuGXZ1j6I/4m
 Uyowz8/p3qBqw7zijB4RNa+cM64RYTiM9LW2LO7I7oVUcbSquUy+2+BS6d4v+iBTLnO/
 HHqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV02sFVNzDSd0R/m17V1bE0eXlwikFLSMGfnEZaKLLrEQD4SSSDfHBMrd/1NUKJybOhpv8ucj3sE7FwpSOlyvpX7rZKawU=
X-Gm-Message-State: AOJu0Yzimy9pJEegQd+nSwLDR/AX1WF9tDY+BqMa+zfoiR2how6ZnFzh
 a1/x8JvDGQFzK+1v3QRVtw+ACULB0HQAQM973wtHdFsuq2CCjtdGgkShRVjCXzo=
X-Google-Smtp-Source: AGHT+IFjnpe+mQKhY2xjd4tN2As3LWc9ByDooIYvnVHLpt/TOeKePaIT6d8caIiojoR7ls4BE2a+4Q==
X-Received: by 2002:a05:6a20:7487:b0:1b2:a899:e57e with SMTP id
 adf61e73a8af0-1b2b71542b8mr1416771637.59.1717549205196; 
 Tue, 04 Jun 2024 18:00:05 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703ee633e04sm3731b3a.19.2024.06.04.18.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:00:04 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v4 1/4] vvfat: Fix bug in writing to middle of file
Date: Wed,  5 Jun 2024 08:58:37 +0800
Message-ID: <4100134ef391cc33487ded6568bdf1a2abd1e8e7.1717549035.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717549035.git.amjadsharafi10@gmail.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x42b.google.com
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

Before this commit, the behavior when calling `commit_one_file` for
example with `offset=0x2000` (second cluster), what will happen is that
we won't fetch the next cluster from the fat, and instead use the first
cluster for the read operation.

This is due to off-by-one error here, where `i=0x2000 !< offset=0x2000`,
thus not fetching the next cluster.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3ae..19da009a5b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2525,8 +2525,9 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
         return -1;
     }
 
-    for (i = s->cluster_size; i < offset; i += s->cluster_size)
+    for (i = 0; i < offset; i += s->cluster_size) {
         c = modified_fat_get(s, c);
+    }
 
     fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
     if (fd < 0) {
-- 
2.45.1


