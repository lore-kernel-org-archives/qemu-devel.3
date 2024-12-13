Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBAQ-00048P-RG; Fri, 13 Dec 2024 14:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7y-0008F7-IK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:15:10 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7l-0007gT-4G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:15:01 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29f88004a92so1253117fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117291; x=1734722091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUREKfOZFFX0Cik+qgjY7NL4liaNpXwK6Nn2DyaSOoI=;
 b=eC0FM3C2rRSq6bycK5ik+uEjkDHvH05QdhjOiG0CE/sNE81DH3mxhthguW506lOi/a
 FvWXsP3wdFB4E8vzI/KLTbrKaXUgFSqPqIKhnG8O598KNsSdyzZiT/w9TKINyPYlSwff
 oBHV8INGxivEJKwB9H9Y7j63xmTUXJea7oWNof7xbnBF4bKc7Gw1POtC7XfhbWTy+Hx/
 gZC9kGuQJnXs5iI+Q3kbcYRKGNFROhOvvyOvCjXMUtWsKt+fE0ohRvd+nZpYBXHSjbb2
 y993cCI0f3fTEslcCfGpPbzxs8SdmqyRdhjVBJ/WQNHarfarIk0kiPBzh6yW0E93P9le
 7q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117291; x=1734722091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUREKfOZFFX0Cik+qgjY7NL4liaNpXwK6Nn2DyaSOoI=;
 b=rvzUax0TI5G7taX/3yrIj9+a9IsGbPQIoZ2AJkLqS6Keu2nv8v7CokYdZgOwGGUtmr
 L0E7lVcEwoltH5O/1Hm3kYX+FFqBtANp/5utRUY4r3aEvj5qwNK+mJ+nxOEiqyNFrmYG
 A/z6wCaHbW9EKzUAWLC1JlpdfbxyUDPOw0UKNwLOVtro3jjrQctfoAqCvUqZduinVil5
 kOZdbWRWxyGldOHMT/ukibw4MgepufKuV0VaQ7Lh4fX5pMMnVVCkzMdCKTJPP8eXnNBT
 /4ZFFLyjfj+CKfZOr6FQsMN96QUZ4S0W5k91ljhGPKCKIj7YUUFbPMeFM0spwgrksknJ
 hIgQ==
X-Gm-Message-State: AOJu0YwVjCSSu2ZmLUcOKTgyR7+utGrA5bPnTThod3Rs/9uLXjK04Mxb
 Ko/kB2cFxQY+OsQ/aO6IfvTdXcRaKSvH2S9UerkLATI1125lsn44jnu/HjyKdWqVNy9n76veDCf
 6ajtD/0OU
X-Gm-Gg: ASbGncu5+XjzbvtBrN/Lqzdm7+KWqezi33r07aQooh5JahdPcACIIloAaACuTLmBoM7
 H3BazT0vrOBDP4IpEl17pMxIw7Jo1am0puODtc07MVfCjrYIGOuZnvLQBeuvDCHP9+AJ+mPmIlQ
 6H9vqfGkVeltCZ9jD2sCfYS//oqpY2Uw4Au4zrM9W8AfmU8H2PS/j/oA5Vj/GB0wOPCfEeJK45Z
 1bGBpbLhCI1t1u3B6NhbGWKkfCs4c1BW/wMO6gO/BIDBjFEihMp91QjMVTZ+uZW
X-Google-Smtp-Source: AGHT+IGwNMXVxQK/RMcx05Wwv2S9qKBEzz5sbg2HZcZw37JIyPwDDZWjAwkRQZEl4rnqZYnVu/XSSg==
X-Received: by 2002:a05:6808:2519:b0:3e9:2090:c030 with SMTP id
 5614622812f47-3eba689dcb4mr1750600b6e.25.1734117291191; 
 Fri, 13 Dec 2024 11:14:51 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Subject: [PATCH 63/71] hw/ufs: Constify all Property
Date: Fri, 13 Dec 2024 13:07:37 -0600
Message-ID: <20241213190750.2513964-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ufs/lu.c  | 2 +-
 hw/ufs/ufs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 81bfff9b4e..74ff52ad09 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -274,7 +274,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     return UFS_REQUEST_NO_COMPLETE;
 }
 
-static Property ufs_lu_props[] = {
+static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 79f786ed4e..fe77158439 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1752,7 +1752,7 @@ static void ufs_exit(PCIDevice *pci_dev)
     }
 }
 
-static Property ufs_props[] = {
+static const Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
-- 
2.43.0


