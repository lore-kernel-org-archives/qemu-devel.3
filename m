Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B591CDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQIR-0007Jw-Q7; Wed, 24 Jun 2026 12:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcQIO-0007IW-Pd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:17:48 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcQIM-0005l1-W8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:17:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so11848285e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782317861; x=1782922661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/x4EdXsiqmaDrp3WWBhWh/bHnG1KlJ+O+VKPSj8E3g=;
 b=QPmdhRSAhdYwh//ZVcc1w9MiwbflVFicNr+8mRVmbGsfqZB8WwEiCaBT1cNfPuDAPt
 hFWHxwxQgk6KClDbJslHsL8Xd9Xq0QjoAkB1xkghhGxW+IdnxfGjJ/dQVtj99Y3xQ/RF
 3TgPjHmHutCxZ2UaMzMomnBXx/3BDwOyFAb7D9D4mhalNsqD5nq0FYX0rAQjo1ejfj6L
 0ysS7vw2nwUD5es9FTWQ3WGryMJghh9faiFxIllbPuYcC/Ewocltd6+v7L8D5dKz80mp
 qbWzmqo0wwYOWezvz8evk0vbwGiSnG8qE7Xul9n1ihhzH1vrHnH5pCLy+AWLtUpjJQtB
 taIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782317861; x=1782922661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/x4EdXsiqmaDrp3WWBhWh/bHnG1KlJ+O+VKPSj8E3g=;
 b=aNfHVBLmExhwuwqUSR+nyndoajH8JtrhX9RH7RCcjGcOo2GueBzmE6tSeZ5VOGuH2T
 FzvL2LCy2lZc3T0lOt43qo55YBeSlSo8EbY1t1stbpna6vqe2id/2gVnYXL9dd79xrfl
 rOVc0vCtt9KDlEl8l7pzEFh8M7OaA4EGh0r23z0ZT+tciNPINQV5kGdYNzlMAZ6/UEEA
 rTsT1OUzSOZq01ZDqvhmZUZ70Y8AnuPftqaKTqB4GeY8WZ0kAJdU9iqVyBivLaDIc+lC
 5lNV8sOTJFOwiQdjjCjRNiUbM3Gzs9Js/L0bi+L1It8ObjAs5Wncq7zcN43YSOj9P79K
 rofQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DJZ8py9I1hxqtwbmDucbrwJreM3gvhoNJyKAJocF7nOYW+X9shRmgXhg4bGPylnUcmY9A1nMhrcuS@nongnu.org
X-Gm-Message-State: AOJu0YxEa9mSi3Rs8bNs/9PHV4ViUCd+mq1z7NOX+pNG0v0yI1IA9d+D
 TxD7ZFR+pDgtWBTt6/O+DhF3Y9jrKlFbX4/6Wqi/r7iNsIOibKI5XLOn
X-Gm-Gg: AfdE7ckBC6qDIz+tenDhLzBCv2mUM1q05y4lac8ejUWSb/WMsoXwgRTDBYQRvIYqPFo
 VNm91VdHhMfIflQDE7cKcnaZ52lUck0g5Nnjj/OR1+G5kys+2u+gWknm1A7anfGuH08TMcB9MXC
 RErM9shwLEKs1UpT5qF+qnVMcHSGZP/CJvfO2q+Eei8NgWR1x1/ZDSbVqn5WEWljNtz3ZJgrahH
 BJ8sUgH2VUv5SX+PGYrHbhFXxaU//Z07CMms6bNFwV/XeL2PKgybB92yRplHrIkQPoz9yP/Apif
 QY5j3GNbdnwfg3eHp0eHWI5Fqw46vE481NTookH8J9XucnBM100jvmH5AW9VGXw1oDh636Uy1GC
 hb5LT6oUcD9RW+TXFdWPWBKDvaDSp84Rnd1p5eWs/c1G5VUOpwbyPZAzWECXC3ah6TXq4quoz5P
 Mv3Z3NzVHnA+SU53iB8hjadgU4yUA=
X-Received: by 2002:a05:600c:81c5:b0:492:4ed1:77cf with SMTP id
 5b1f17b1804b1-4925b35338bmr100288415e9.11.1782317860860; 
 Wed, 24 Jun 2026 09:17:40 -0700 (PDT)
Received: from localhost.localdomain ([86.2.40.231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926403573csm3245965e9.7.2026.06.24.09.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:17:40 -0700 (PDT)
From: Ganesh Harshan <ganeshredcobra@gmail.com>
To: philmd@mailo.com
Cc: zhao1.liu@intel.com, qemu-devel@nongnu.org,
 Ganesh Harshan <ganeshredcobra@gmail.com>
Subject: [PATCH] hw/core: fix block comment style in sysbus.c
Date: Wed, 24 Jun 2026 12:17:36 -0400
Message-ID: <20260624161736.31548-1-ganeshredcobra@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ganeshredcobra@gmail.com; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move block comment delimiter to a separate line to comply
with coding style guidelines.

Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
---
 hw/core/sysbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index c07afaa802..74c10c0d4f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -199,7 +199,8 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
-/* The purpose of preserving this empty realize function
+/*
+ * The purpose of preserving this empty realize function
  * is to prevent the parent_realize field of some subclasses
  * from being set to NULL to break the normal init/realize
  * of some devices.
-- 
2.47.3


