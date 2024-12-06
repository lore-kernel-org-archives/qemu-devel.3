Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08882E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLtV-00059I-DU; Thu, 05 Dec 2024 19:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtQ-00057h-4m; Thu, 05 Dec 2024 19:08:24 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtO-0000fx-Kk; Thu, 05 Dec 2024 19:08:23 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f22ea6d72aso614420eaf.1; 
 Thu, 05 Dec 2024 16:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733443700; x=1734048500; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=se6qbCp0/OCGWSFKD0YAo16T7mN1hR6rpmZ2Msx5uN8=;
 b=GwG5UQiSW+1W92klm/KOH6i/O4oXWOjAG4p3d+M5Ta2GF6/Oaa8WptqASxBjm72GTl
 22MPH5jbS/zS5hGrPCX6YR66weSFiGyyEedMMwUmHof3HCIrm6wPHCeFqRVcjntBR574
 f8FsJk35UHrJ9Q0wuhD6emVccp9UOpYHkP0bV7PKSMEu0Z7MThRENVg7G4VA+zM7Djj1
 AsNMubIDdN9a+naIayw4I7ZAVG7DrnSCEJTfMnHlUOuwyTxs+nVik5DD8nUc6MWDXawN
 Yv2xWUsGr3UIziG0eI1EjGBvvuhZ89DKeinoT+gWyGeLU3iVH7TGlE/JHAobm4u3jdXM
 r9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443700; x=1734048500;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=se6qbCp0/OCGWSFKD0YAo16T7mN1hR6rpmZ2Msx5uN8=;
 b=cjnDDTgdgmx/NYBLoTDqwc/EO0/KIt61dGMoTqX3eu3/v/sYloqREIKcS3dVLEAJKZ
 0AAqV7dQDD6eZIUgBgCr3mPYlRC7WCsjKpXwRVNd4Deb571STYRSgUGAnihBHGeEhE5g
 xIjF9M2VyUhSeHtAUxRTqk6gLkAWvi4dO1x1KQLEXG3q1bch/tSAAFOd+fK+wKhH5S1e
 1rzs/PWDPUSK0PzgbPJQoMrJ3wGhxwyywseaw0AGHZOBWiiciOobWt8pIcID9rr2sRNA
 d5nWNn7+f4TtPzqixWoiw6WpN0IzTCkCHmbTT3FhhkWKB9ymwjKGHhkU3LXYPlc+fIWa
 l9hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkOEX5AIa8BTQNxWdOJhV/SDYDKZ2uOhgXVegJorG4Q7lrbEwxiAmGElyIA6gPRUpN020m2WNGj/My@nongnu.org
X-Gm-Message-State: AOJu0YzDFoBjSU8aunb/PXGObS36qUaYD5gcJ6SDavkQBE7jD4v8tGew
 lN2tZHAlhBuT40sb2rHvjVy4w9vfsLfZYxhplz8mbY4Q0gosTRNEDtzOuTEV
X-Gm-Gg: ASbGncv/eQOPLrmC+ye5uuGY2EMbO0jXUOsVZNj5uvGIWZVFTgSjSgoUqCG/TFTrtWf
 SnTKKEHHq/Npo2GuR47ykaW9EE3XT0RJF7LbzmC8VBnweqX38oDSykoo5PyOGxr+kbbuoMF6JAn
 KUI5/jb+8AyfVyo6/kvU6jUUj4s4Dg8lMTgbblPPYDefhoGKsFVUpyuqXlXuYzcBRnYlTlhY25I
 OGFneoONmvKE4if4CG2YwyyPRSfB3Awtzq7cdtPSjsyWPVJ5mdVEL3gxYKU5blkjV+Vy7PPeJ8V
 xh7aU8K43bow5wgN/5U=
X-Google-Smtp-Source: AGHT+IEvZua6Wun32X42LNi8saoHubNgbLELEtXvvpL9my6jbgSBe7wUP10cI69p1Kq18Z+3jyoTQw==
X-Received: by 2002:a05:6820:54b:b0:5e1:ea03:9286 with SMTP id
 006d021491bc7-5f2870a4d80mr867773eaf.6.1733443700505; 
 Thu, 05 Dec 2024 16:08:20 -0800 (PST)
Received: from takeshi-suzuki-dev01.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793046d9sm486212eaf.30.2024.12.05.16.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:08:20 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH v2 3/3] Add VHDX specific image info
Date: Thu,  5 Dec 2024 16:07:51 -0800
Message-Id: <20241206000751.34694-4-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
References: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Show logical sector size as follows:

```
Format specific information:
    logical sector size: 4096
```

Signed-off-by: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
---
 block/vhdx.c         | 21 +++++++++++++++++++++
 qapi/block-core.json | 27 +++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 495ddc2815..957aa99c2d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2270,6 +2270,26 @@ static int GRAPH_RDLOCK vhdx_has_zero_init(BlockDriverState *bs)
     return 1;
 }
 
+static ImageInfoSpecific * GRAPH_RDLOCK
+vhdx_get_specific_info(BlockDriverState *bs, Error **errp)
+{
+    const BDRVVHDXState *const s = bs->opaque;
+    ImageInfoSpecific *const spec_info = g_new0(ImageInfoSpecific, 1);
+
+    *spec_info = (ImageInfoSpecific){
+        .type = IMAGE_INFO_SPECIFIC_KIND_VHDX,
+        .u = {
+            .vhdx.data = g_new0(ImageInfoSpecificVHDX, 1),
+        },
+    };
+
+    *spec_info->u.vhdx.data = (ImageInfoSpecificVHDX) {
+        .logical_sector_size = s->logical_sector_size,
+    };
+
+    return spec_info;
+}
+
 static QemuOptsList vhdx_create_opts = {
     .name = "vhdx-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(vhdx_create_opts.head),
@@ -2321,6 +2341,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_co_writev         = vhdx_co_writev,
     .bdrv_co_create         = vhdx_co_create,
     .bdrv_co_create_opts    = vhdx_co_create_opts,
+    .bdrv_get_specific_info = vhdx_get_specific_info,
     .bdrv_co_get_info       = vhdx_co_get_info,
     .bdrv_co_check          = vhdx_co_check,
     .bdrv_has_zero_init     = vhdx_has_zero_init,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fd3bcc1c17..7d6ac22776 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -179,6 +179,18 @@
       '*extent-size-hint': 'size'
   } }
 
+##
+# @ImageInfoSpecificVHDX:
+#
+# @logical-sector-size: Logical sector size
+#
+# Since: 9.2
+##
+{ 'struct': 'ImageInfoSpecificVHDX',
+  'data': {
+      'logical-sector-size': 'int'
+  } }
+
 ##
 # @ImageInfoSpecificKind:
 #
@@ -191,7 +203,7 @@
 # Since: 1.7
 ##
 { 'enum': 'ImageInfoSpecificKind',
-  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
+  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'vhdx' ] }
 
 ##
 # @ImageInfoSpecificQCow2Wrapper:
@@ -246,6 +258,16 @@
 { 'struct': 'ImageInfoSpecificFileWrapper',
   'data': { 'data': 'ImageInfoSpecificFile' } }
 
+##
+# @ImageInfoSpecificVHDXWrapper:
+#
+# @data: image information specific to VHDX
+#
+# Since: 9.2
+##
+{ 'struct': 'ImageInfoSpecificVHDXWrapper',
+  'data': { 'data': 'ImageInfoSpecificVHDX' } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -264,7 +286,8 @@
       'vmdk': 'ImageInfoSpecificVmdkWrapper',
       'luks': 'ImageInfoSpecificLUKSWrapper',
       'rbd': 'ImageInfoSpecificRbdWrapper',
-      'file': 'ImageInfoSpecificFileWrapper'
+      'file': 'ImageInfoSpecificFileWrapper',
+      'vhdx': 'ImageInfoSpecificVHDXWrapper'
   } }
 
 ##
-- 
2.17.1


