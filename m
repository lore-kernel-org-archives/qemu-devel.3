Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D23C41513
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B0j-00084f-6Z; Sat, 04 May 2024 04:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0h-00083k-BL; Sat, 04 May 2024 04:44:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0e-0001Vk-W6; Sat, 04 May 2024 04:44:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6edc61d0ff6so410576b3a.2; 
 Sat, 04 May 2024 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812282; x=1715417082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFVIMyRlD8/BSmSylP4xvcbNRqi2JvuqJ8ggirzVAcY=;
 b=DB1DA1t5tXxXOwO/ptWZiy947nvb6Morxt1u/ufhi8PQf6RxSyuYuHN4dOe2/8rEMU
 8w/fnB34jChig8d3qzrEpgrwbvxYOKPhI5yOWdxKzaTFG1THzQwl9SowOo+3mepyvb8D
 RozuItXOmUVXB37WXXdKYG7Yc5BU5i5b5ypg5EQ3Bd9GyymWxuNvAot7NaDhl1IeHUxZ
 jQhyQ3wy8uaB7vd64ikSm/4Sxn17I4I8JAKk1yVRfdM9TagkVfpz8DsHBLTKwIpS1Wvz
 dQoedrrqF9UMqtGfXMCmNqXi5Ki+iWPHHGI8sR8GfKeUnN3N8oGYsZG0wMjL34f//wgZ
 JNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812282; x=1715417082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFVIMyRlD8/BSmSylP4xvcbNRqi2JvuqJ8ggirzVAcY=;
 b=SHJBD5/SkIJi5foLC0zAEJSIA6dnhT0PjMq+kIKbA3VCI97HSN08Oq8l/DRrtHqmpH
 wZi/NL85ap00IypVMH27+7DDUJd7wqVz3y8N8Pcx6NELhBxHuCv6aEKGihfbdiAoXdlX
 KGLq2Twm2crNfVxi19z9nGbOZt+4Qu+CQvx7pTgSxOeDr81q8MvIaKi3vHFeiVYBxt/T
 jy1pBCL6VPKAY1FJOJL+m3gSXzybYI66QPFZw5dKcxsiql0cLyhUyZ10PnU9LSGyoszt
 TlFC1kfQa7vKcahWZ9uLcTewJXnlVt/JSuOcs4OJRs87BpliA2T/y4BnJuuSm/DryVyg
 Y6Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcVbo/V6bSV6b+yh0bn7O6hXS1V8D4uFeMAYwdTrJ36QLp6aIa32M1kbCF57g6BiKyO8eZiaTPwqMB5MQY9HrGvb5gyfo=
X-Gm-Message-State: AOJu0YwCH17n8P1QMYhnVMkWbYXGT/b53HvSHg9IEcBnVeReog7DTKGR
 FtuRJzQ3Wm4F/5DCAs2pHZkaBb6GhqEQ7lar03WDWZhvDuGSpNTRb8yQc5Jw
X-Google-Smtp-Source: AGHT+IGwePShG1wgYeY6sScrGEhr0oOuh+dbaY7QTZCOS0QN0zXsaziZTW5R3tYEVuAky25k8tvIDg==
X-Received: by 2002:a05:6a00:10d2:b0:6ea:e2d8:468 with SMTP id
 d18-20020a056a0010d200b006eae2d80468mr6393129pfu.26.1714812281926; 
 Sat, 04 May 2024 01:44:41 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 ei32-20020a056a0080e000b006f44e64dfe3sm2310393pfb.177.2024.05.04.01.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 01:44:41 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v2 1/5] vvfat: Fix bug in writing to middle of file
Date: Sat,  4 May 2024 16:44:19 +0800
Message-ID: <2871281d8ea41fb4d7ef8f9beeaba017a1717019.1714811679.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714811679.git.amjadsharafi10@gmail.com>
References: <cover.1714811679.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x433.google.com
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
---
 block/vvfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3ae..ab342f0743 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2525,7 +2525,7 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
         return -1;
     }
 
-    for (i = s->cluster_size; i < offset; i += s->cluster_size)
+    for (i = s->cluster_size; i <= offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
     fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
-- 
2.44.0


