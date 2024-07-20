Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3987C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV769-0001QL-NU; Sat, 20 Jul 2024 06:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV767-0001I0-Dc; Sat, 20 Jul 2024 06:13:51 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV765-0007QX-W0; Sat, 20 Jul 2024 06:13:51 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so1503034a91.2; 
 Sat, 20 Jul 2024 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721470427; x=1722075227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbJVDnv52Tg0eAb6ccUpzqtMp8g5kcnSvB8cItuXb20=;
 b=iPSvMHGlhmEZ+sGqxLNt8UNzi7CVh2F5wdTKyeU9N25HIod4Etaygpyr4cOYuvtrhX
 wcTnYOhrwITVYabY4my+XgQLJQ4uVZIIOHtz3bpk5yyLxc4xb+mZTciQytSG1Kow/va/
 CF7UkU962Lg8s4Lr4ev6eCxHwp8EUbUVbCTpxS15I/5qcdhzBV9bikKZscIUPbnSHNB8
 jGg0Hlm1Kvf5p5v4CR4qcL7Hz2mtEnwJ5tXnJwhwlhqICSGqcDkfw/eZJ+S0QBgEmAce
 QBwmK6La+GeMuAK9GuvNZEWfscqaFlMMRvAES3NKrHMdFGzEZIdClSlXqKVjikYMdsmX
 xPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721470427; x=1722075227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbJVDnv52Tg0eAb6ccUpzqtMp8g5kcnSvB8cItuXb20=;
 b=o4DhIIQcTD4q8stryYEk9Cr/Arv7uZzuThou0Kzfa+RguJ0yGqrwNKl+47QET7EGMM
 sHjq7zj2UwjA2eg5XywL8HqqDxoRzwrCPFiHYVwdqavkJOexegLasUsanOaPhjnteLle
 3FeXohYrCcmaABhR4CQF+3yjn7UMyZXuYQLwaj2/aQBFwBOHMO8Qplrf3DnwA/QJ6yAJ
 dRd54cdIdb4vHflSNCGnJkaUvbF3lbqV04PFR1hA93TIBcSUt4//Laemp8uxEczth8ms
 b6fjjIwsQdf/rtro/YdVzQSTHxj42mwdo7hKKccj88oQ45WcAS9LWkyk3lPM5xIrm7kA
 PxvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ3cuDnFJpboPdKcR6bunXPQPDfnnaBwdMVzxGpdQtD6yrUBGW3Okl3MhIminRTo6Ype90P4hXwjQDVjgUXgYD9gjM7s0=
X-Gm-Message-State: AOJu0YzyVM8AIXGqUIokt3OG1uURU4JcWRdveINnKg2XrQBMyr7vhsqG
 uFh1sOY0MdKywglWu0t4L62QH0n81qlaZ6Op3ocRWanGhqi7mwaTI/Qs0JQZDw+RGA==
X-Google-Smtp-Source: AGHT+IH4aljVy5lBC3eS5I4gqELDgeo/tMtW2Izr+VoaYkFAXvCfM90oFf1gBVm9cQttTj9p89ESFw==
X-Received: by 2002:a17:90b:1057:b0:2c9:65f5:5f61 with SMTP id
 98e67ed59e1d1-2cd273d7a0emr468016a91.9.1721470426382; 
 Sat, 20 Jul 2024 03:13:46 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb76a5fc6csm4411208a91.0.2024.07.20.03.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:13:45 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v6 1/5] vvfat: Fix bug in writing to middle of file
Date: Sat, 20 Jul 2024 18:13:30 +0800
Message-ID: <b97c1e1f1bc2f776061ae914f95d799d124fcd73.1721470238.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721470238.git.amjadsharafi10@gmail.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pj1-x1032.google.com
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
2.45.2


