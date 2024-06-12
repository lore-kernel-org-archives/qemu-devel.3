Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFFBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLW-0000xA-I0; Wed, 12 Jun 2024 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNL9-0000pd-9Y; Wed, 12 Jun 2024 08:44:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNL7-0004xh-Gs; Wed, 12 Jun 2024 08:44:34 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so1651444a12.0; 
 Wed, 12 Jun 2024 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196271; x=1718801071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymVSlpsEC0B/nB1jHObObR3P+gg3N0AOCscuoEKuFXg=;
 b=EeklGONPlDr2I0IUlaKdR9RQnFuxqYoJijtNZgyJgBPfu0MBrloo+MXkvSnUU8Np+z
 YI0Fa6itTMqgwobauBAW4dygGak0XsHSU7ATpjVdN8WYiarXy7M//PJ30GFwdeO6jjC1
 CE2JSuOW2Ob++wkbocg4mWJ3DNORsH2hrDE1xv538ixX2Vm1FheOqp8N+PGt/yyjvEVm
 1Clt+U2SEpLvuj/fPcVG8FIglMKd0H+gpnVQ0z5xkzCfYLmrQFzzDzwQ0C80a7ht17oX
 PWIpylSx5but3HF2xeKzlSYyBct4crfjhMHeeI0AN3iXaazANYB6Z7otNY1CxDRZuaKt
 fffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196271; x=1718801071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymVSlpsEC0B/nB1jHObObR3P+gg3N0AOCscuoEKuFXg=;
 b=FhtkMkUi15TMSI5lMqEeQ6wBrmpcb5wN233/KjDX6tklBpEI5M1GPa8lL3uumMTCse
 v27T78raOSmyMN3fOys2JdpbtPiOXDnUgPgzAsKxqvXE/P1w7QDiHKmW5L7k0l1xQOdq
 QDOOdMgWxQTY11JOnlt2NS3Vp0oNk3u2Bsn3BUPz+cLvybc3wRAcDZRTFsJR7f2axVPh
 mNVI4NDpZV38lyaq2/fXRYxAK45vsbCRxVMBYc08RInX4Hw9sBl9JF3c69huXCSqHYPF
 zgfjEFX7hqyMz26AXGcVMNjX4SC1IXDs9IhoIGDuJOy6jKNQ+JyPc/1P91/8eg3at2qx
 c0vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRTEQgdaDmSSULHukShN0bVYiwDCtHgcleautTT42jLguZVbSYiisBABu2VT36eqQ0VplPFKUlFW49GZR5/s69Q0bNhEI=
X-Gm-Message-State: AOJu0Yxol6vuSvAJE+T+6gtsDzN0nUu2dc0G2eYbR3R32fhRQU+jbKL5
 ZXTsjIipIGdScNoFwQ7UuBBl+BSzLal+aVUj2tG3deZcmUGXu7Qhzczv/Jzsqic=
X-Google-Smtp-Source: AGHT+IGZ0m1QnyEpNaz45jWGix4ylxaY3FH7zCtIr/6cZdnWJE2TfDL1I7VpO6GMX0uFEzOTrEKM/Q==
X-Received: by 2002:a05:6a21:999a:b0:1b2:b16f:3b26 with SMTP id
 adf61e73a8af0-1b8a9b1375bmr1891370637.7.1718196270710; 
 Wed, 12 Jun 2024 05:44:30 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:30 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 1/5] vvfat: Fix bug in writing to middle of file
Date: Wed, 12 Jun 2024 20:43:22 +0800
Message-ID: <4100134ef391cc33487ded6568bdf1a2abd1e8e7.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x534.google.com
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


