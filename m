Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D456CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNX-0006oP-8J; Wed, 03 Sep 2025 03:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNL-0006he-JC
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNH-0005Mu-VC
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so56963755e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886262; x=1757491062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Aa96lioobd3V/jZeaMPcPy1BST5QsMXEtIGLa9bUrQ=;
 b=ShgARH4DwwB7L2NMQPXbz7RHcg2+vumOZMcbnkKrSVD+jwPNe55tMWK+KnFonZVRzQ
 SmAh4lSrJZKVCQru0DSlwcZHj87RRS+EKQ5RdbCQkEWwIUqrYHikD/cS0u+8Mp1tRSQk
 VbXWzgIMmZu5mCbJO+GWIvDE4bbOr6IBfUByXgVLQTnNrWNf9XRrnKDo0J/84dlGdKdn
 DRNn9lDB4MYXcA0GuWyymmdjNYEd0JbwHmXaQNDWJvqZ/NQoTZOcPSajIgcuYnpEBI6p
 Sb/nAx3pdq9qwE37CfQ9b0hRRB7Mfw4tkt68MKnbW7CFM3C2j98S4CbFWgV02SQcDgNC
 rpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886262; x=1757491062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Aa96lioobd3V/jZeaMPcPy1BST5QsMXEtIGLa9bUrQ=;
 b=IVLN2exvs3DAhNIt8AOjUI5G2EkhgGbitZ8GwnCto5dhARPjEsl1m+MzBJSxqFQAY9
 twhU402EDs8ElWf+BXtx3lX3+pF7m5Fp45RTDy8disnZtrXuKIR9uw47xUV3RPfS6PJ1
 LZBLJZuMWihQIzVNpjbGWOmpXMpHzqPUVnay1T0OCcDhXddZZuv+uXK7skFkjW6mPJut
 Tdqz2RFDVvzFGh36b+PlEg2F/DZyX/tRQWxsk8LdAHjkCNsrh2CyIWqIDXlKOvARKjVE
 s2kJCrb1iFef4xTEZc/7sRbbCTNETFopg+D4MHXzO5RlSpOqpBM0a1jkXuBSz4stnm5A
 qiag==
X-Gm-Message-State: AOJu0YwVmUU1NENmwraFOxv6s5Tbqa447dF75exN6/uKZwwdP9fU1yVk
 H/S+JlRmpxunT4EO7ogCZ8o7FcOz4ARRTbwITJBFNj2c0fhtHFTQTUYXKm9YsxUwBCzLgIx7kW4
 xzhs=
X-Gm-Gg: ASbGncsWdtB5v3zFCGADl2m6uNRlBoBqO6lUUGpwASDLzD8tgLe0DrTKLw30CSD8unR
 hMQS2lT4sNQcSXnPgXrPOMJYkSv3m+6iu1ClyIxRo6K0Y8gNp3lGuKqxXywoLs9Pv8gt07A2t5A
 OUVXdM/yCOaU3Lkx/mHaSn1/qwZ6G6IDHoiJ3oUPQERVBl0HaNLeCq50rXV/A0W1veyRRDl7OlD
 CffteMMb4gXcatWnwwfYNoRoA/mXQr+jjdrO8SvPHgf4bKv9Fbb5LNhRVDGPNwLrHqOPY4d40RD
 Kzuc+KshR/SueWROWe46W9A5NQJIc3N1Piqun6c6ZhGS3yIm7wDVwi18ZqCkM5ZspgfUQDiYgW9
 QOJcG096PdLM9aJUYaFD/N27Za/TCJt24kOB6B1m4eA==
X-Google-Smtp-Source: AGHT+IER6ZQF4y1a9JrKdpml7gocWmIaKwcbIdbCV8//1lbdpL5DwhY23XuCyroc/Cs2kk5agIkNew==
X-Received: by 2002:a05:600c:8b23:b0:456:1dd2:4e3a with SMTP id
 5b1f17b1804b1-45b855506e2mr110848455e9.3.1756886261734; 
 Wed, 03 Sep 2025 00:57:41 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:41 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 1/5] vvfat: introduce no-mbr option
Date: Wed,  3 Sep 2025 09:57:17 +0200
Message-Id: <20250903075721.77623-2-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
References: <20250903075721.77623-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This option when set prevents a master boot record (MBR) to be
initialized. This is mandatory as some operating system don't recognized
mounted disks if a MBR is present.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 814796d918..0220dd828b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1082,6 +1082,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Make the image writable",
         },
+        {
+            .name = "no-mbr",
+            .type = QEMU_OPT_BOOL,
+            .help = "Do not add a Master Boot Record on this disk",
+        },
         { /* end of list */ }
     },
 };
@@ -1092,6 +1097,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     int fat_type = 0;
     bool floppy = false;
     bool rw = false;
+    bool no_mbr = false;
     int i;
 
     if (!strstart(filename, "fat:", NULL)) {
@@ -1116,6 +1122,10 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
         rw = true;
     }
 
+    if (strstr(filename, ":no-mbr:")) {
+        no_mbr = true;
+    }
+
     /* Get the directory name without options */
     i = strrchr(filename, ':') - filename;
     assert(i >= 3);
@@ -1131,6 +1141,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     qdict_put_int(options, "fat-type", fat_type);
     qdict_put_bool(options, "floppy", floppy);
     qdict_put_bool(options, "rw", rw);
+    qdict_put_bool(options, "no-mbr", no_mbr);
 }
 
 static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
@@ -1196,7 +1207,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         if (!s->fat_type) {
             s->fat_type = 16;
         }
-        s->offset_to_bootsector = 0x3f;
+        /* Reserver space for MBR */
+        if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
+            s->offset_to_bootsector = 0x3f;
+        }
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
-- 
2.34.1


