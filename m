Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2127ACCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqS-0003eS-Ni; Fri, 07 Nov 2025 09:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqK-0003Rc-K7
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:36 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqH-0001uO-Bn
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:35 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429bf011e6cso839062f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527212; x=1763132012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ4FOUgzu/5ncAghYllBlZW5m3sSyvsHiRGMiimwX3M=;
 b=fVkcQ31ZJqGc6bEzYPq14kRZ40ypuYAafbEBsn7gkYkb8tOI5gBxM07iOESQIfRyWe
 nq3dgxF8o2kZi0I6ZhpC9x1JKSnwyqz1Gvho3vwr9FemV19z6fhqItV91jaQFFLDr96W
 mOhhygDytXHilqVkntzvNQx9C6WJ7gKOOJmenG7eXbOiQSsbB3VU4UiquxhQAcnFgr54
 HyIVIAASjz7XdN7vSpD1fG/hWWYknR2ohtHHMr1lBGC9784yAC/uMVYSHBiad2Mq0ou6
 eE/KmiMzq/Prr+7F8T7cH+zhh0V3iKjsRdPrEByWRdRzj4yrlQizJUtrSyhs3Vi8O3CX
 oKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527212; x=1763132012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQ4FOUgzu/5ncAghYllBlZW5m3sSyvsHiRGMiimwX3M=;
 b=IE+SLYc66dOOM1zl1c3EhIzPjUsQX5R5fHdw2AkoFUy/xet8Hhkh9VE7u4VA6A30bE
 tt6j2Q6h2kHf81d61Ndr+WcrC91/7Lk4TvzBAS5hYiTTZn2bv/c+979bHECodDJkFskX
 4BEvDI1MdnCPIuLzhBwp/jRSX5VDLD9OQIPCUHhSc9dY8Q882iZ8NRjYxodzyuJ3Q8gy
 3+2thQFbV5GEuad83F6/S1c2LiDgiDpkZ94xNPY0XLhTx4k07/bFrzKeaXF26i40Z3tq
 m+69A/1LAgQYsdjr4Am2N2euVS2gxofj2XVRKV8LgXItwJyWDW5yTqyeIIyg2CpgPDol
 2s6w==
X-Gm-Message-State: AOJu0Ywv6CDgKBTSiJPpSY5iS2WVC8r74Fr3kWba30hVDdKJ1CORhQ3b
 QH8P9ZOtULbYF0pNjmOVq7Hc/rZb5OiURb6WN0dYUbBRSXnRsgj3JkPqCXa6WZtH8kjdwnT7F8t
 Su5w=
X-Gm-Gg: ASbGncuRrBYpamakbeTMLjNh/7pDFLW7T6Kl/tcCjfpQsancB7qCVeZ/D9S7rwpyF5f
 HzxxsKvgMU05G3AItC6Lw9fGpg7Q6qUSWcyeJevcFJUQ/dc4wOPdOK/59CL3jZjKTzt+Od/0teI
 Th8/nTpIv+cf4g41RkI5lc/UdPwUI31Gs4zXTL8y5sBEYlUggAb1cqXp2+kVCsWRZ+dklor2Xg1
 Pvjp+THidPXyLr690IWReTkWpesKeXXwVRfhAnbhOOzB/FwBsy6S0MpneBmOVcOWF8RFZ1Q6zDG
 Y9yispcX+IRdUNEdhSmDFCus/t2mhS8t5fyVs4eY19cE5WPXCZEBVrvWxVdPxfyOznd1TAzJPwf
 KogqlhePlbze0KLVih9abEQAkR5hnfi7mjYEM/OXJCreXfaO+9J4IvwLqhCUSA70rAl5GLFSlPB
 QPAw+4DqDCXctbRykajQ==
X-Google-Smtp-Source: AGHT+IFm4gV7kKat1LdzITQ6wbCjDRLBARxrA83binMW/Nd+eB0NlcEzmwNtCld3J0yzNo5Tt6dsPA==
X-Received: by 2002:a05:6000:220e:b0:429:d6fa:da20 with SMTP id
 ffacd0b85a97d-42ae58829f5mr2936682f8f.25.1762527211868; 
 Fri, 07 Nov 2025 06:53:31 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:e453:acd:db85:b66e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm5922435f8f.20.2025.11.07.06.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:53:31 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
Date: Fri,  7 Nov 2025 15:53:24 +0100
Message-ID: <20251107145327.539481-3-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107145327.539481-1-chigot@adacore.com>
References: <20251107145327.539481-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This allows to handle the default FAT size in a single place and make the
following part taking care only about size parameters. It will be later
moved away in a specific function.

The selection of floppy size was a bit unusual:
 - fat-type undefined: a FAT 12 2880 Kib disk (default)
 - fat-type=16: a FAT 16 2880 Kib disk
 - fat-type=12: a FAT 12 1440 Kib disk

Now, that fat-type undefined means fat-type=12, it's no longer possible
to make that size distinction. Therefore, it's being changed for the
following:
 - fat-type=12: a FAT 12 1440 Kib disk (default)
 - fat-type=16: a FAT 16 2880 Kib dis

This has been choosen for two reasons: keep fat-type=12 the default and
creates a more usual size for it: 1440 Kib.

The possibility to create a FAT 12 2880 Kib floppy will be added back
later, through the fat-size parameter.

Side note to mention that s->sectors_per_cluster assignments are
removed because they are overidden a few line further.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index de6031db98..d8c8d44f16 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1192,45 +1192,45 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         memcpy(s->volume_label, "QEMU VVFAT", 10);
     }
 
-    if (floppy) {
-        /* 1.44MB or 2.88MB floppy.  2.88MB can be FAT12 (default) or FAT16. */
-        if (!s->fat_type) {
+    /* Verify FAT type  */
+    switch (s->fat_type) {
+    case 32:
+        warn_report("FAT32 has not been tested. You are welcome to do so!");
+        break;
+    case 16:
+    case 12:
+        break;
+    case 0:
+        /* Set a default type */
+        if (floppy) {
             s->fat_type = 12;
-            secs = 36;
-            s->sectors_per_cluster = 2;
         } else {
-            secs = s->fat_type == 12 ? 18 : 36;
-            s->sectors_per_cluster = 1;
+            s->fat_type = 16;
         }
+        break;
+    default:
+        error_setg(errp, "Valid FAT types are only 12, 16 and 32");
+        ret = -EINVAL;
+        goto fail;
+    }
+
+
+    if (floppy) {
+        /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
+        secs = s->fat_type == 12 ? 18 : 36;
         cyls = 80;
         heads = 2;
     } else {
-        /* 32MB or 504MB disk*/
-        if (!s->fat_type) {
-            s->fat_type = 16;
-        }
         /* Reserver space for MBR */
         if (qemu_opt_get_bool(opts, "partitioned", true)) {
             s->offset_to_bootsector = 0x3f;
         }
+        /* 32MB or 504MB disk*/
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
     }
 
-    switch (s->fat_type) {
-    case 32:
-        warn_report("FAT32 has not been tested. You are welcome to do so!");
-        break;
-    case 16:
-    case 12:
-        break;
-    default:
-        error_setg(errp, "Valid FAT types are only 12, 16 and 32");
-        ret = -EINVAL;
-        goto fail;
-    }
-
 
     s->bs = bs;
 
-- 
2.43.0


