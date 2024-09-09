Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5C4CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snYcR-0002o4-G4; Mon, 09 Sep 2024 03:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1snYcL-0002me-Rn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:15:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1snYc8-0000xf-Km
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:15:21 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2053616fa36so41963895ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725866105; x=1726470905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WacMwpDGM/3qUlwy+SBbNApQAZ6DjbUiTpOgdKzrWs8=;
 b=L3htkqdzj/5mVI/Hque295T9W12rkjMM5tlyQpnaQgopi2QTFBM6URmS0QNTHMH3wv
 XlOZ9PJo1BibXamWM/TqP+D7EZq1vS8eE7nrWB7vXGabVuYVQj9GzZs+E3uGywBftK3w
 R1EIj3lkzdqyijPBJ0MTu8zkSGzkgPkcFQU6SPmNtDkWkACTwJecQ2N4l7ERE1WJYILe
 LPdHUog5lusy3bG006HRh8LL/it4eKPJAxYsAxxiwxijlNucVP/7Gsdvi8tkr6QRc9Ng
 MtqMvu6kcabRhIWuDmhAWMGfS3B5vDGCD2ce5njwBWpdfHYs/2zOItcQ+e0Hqd80QzOv
 KJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725866105; x=1726470905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WacMwpDGM/3qUlwy+SBbNApQAZ6DjbUiTpOgdKzrWs8=;
 b=cVcOxmGR6Q2n23/hBJ5MYtqQ3I84GNJF1yIgCPMuHihsRhUxAljEPXo5mX+Wmg4qRX
 YssZ8OFvQTsmyAhwv4fjyTp60DN9qYgmo2rKHT7bGQZhaPvyfXrAx2v+drOFQ4AkHF9X
 GOoAihu/FHNfd95L9DvZXV55NYr+Z1CsuOFV8sf6rz8B1HI5hV9nya4yYzZ9b/3U2Dcl
 6zoP1CbOgf4XORLlsdYV04+IfsX+ZIaREeOP+w6rEDUW7vhVuVhYs5ootzDUr1zQ8lLm
 nFwRKrjz6L9GU+th3L/KlvjrRUQZ6zsk3whehjo7z40/n7QIaRd4Ae6RBYXIR1WBuZs6
 rceg==
X-Gm-Message-State: AOJu0Ywjds/l6jO4L98L04W1hXXvJD4DP1oV3OweEVq8yWgKvo9b/lf2
 wKcKDK/RmmrZiEn5wJ5O3PH1dDzZeyB0t+pqXHUUb3NuSYvP3deCQyNBbVRF4Ko=
X-Google-Smtp-Source: AGHT+IHkjJ09Md7Xm7Sl0AbbVqyALiBsULPkBZ+9yUuiMD4oRXUS2qoLOjgoWQ2lWA9nP6L6K9Oqeg==
X-Received: by 2002:a17:902:e745:b0:207:1616:60db with SMTP id
 d9443c01a7336-207161660edmr73116135ad.6.1725866104752; 
 Mon, 09 Sep 2024 00:15:04 -0700 (PDT)
Received: from localhost.localdomain ([223.104.132.8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1e279sm28125015ad.205.2024.09.09.00.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 00:15:04 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, mjt@tls.msk.ru, mst@redhat.com,
 fan.ni@samsung.com, hyeongtak.ji@gmail.com,
 luzhixing12345 <luzhixing12345@gmail.com>
Subject: [PATCH] cxl: update kernel config requirement
Date: Mon,  9 Sep 2024 15:14:50 +0800
Message-Id: <20240909071450.13124-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pl1-x644.google.com
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

add CXL_PMEM config dependence LIBNVIDIMM

CXL_REGION config is not enabled in 5.18, and it was introduced 
into kernel in 6.0 by commit 779dd20c for dynamic provisioning of new memory region

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
---
 docs/system/devices/cxl.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 882b036f5e..ccbe47749f 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -401,9 +401,12 @@ OS management of CXL memory devices as described here.
 * CONFIG_CXL_BUS
 * CONFIG_CXL_PCI
 * CONFIG_CXL_ACPI
-* CONFIG_CXL_PMEM
+* CONFIG_CXL_PMEM(depends on LIBNVDIMM)
 * CONFIG_CXL_MEM
 * CONFIG_CXL_PORT
+
+Dynamic provisioning of new memory region since Linux 6.0
+
 * CONFIG_CXL_REGION
 
 References
-- 
2.34.1


