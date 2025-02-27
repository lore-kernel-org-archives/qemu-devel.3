Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147ECC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYMT-0003x9-M6; Thu, 27 Feb 2025 02:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tnYMH-0003ul-DE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:31:03 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tnYMF-0004Mh-1s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:31:00 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fea65dcc3cso790070a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740641456; x=1741246256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W1cRaC5gQFqx4sw4ws+KyDi9AyCOSvamK2A+8kQRjfk=;
 b=A7r6sHWwgOQIY9V8YO88XfzfnsO0sHMe+21ecBXtuSbwPmPpsdDynZ1mngsGm6uPsW
 umHtVd+3BC+xxTVMLhSvjGcncH5OkdX9A20GOBuSJrHMHnpIdO7q9Pu7m/GNENGqURXG
 I9h3YofQiG5+oWWX7lR26m/5qJ5R+h2wWgut5ENF1yNn+GmRx2LbeopPM4FK8ZsXHNQp
 gRwOI8BKzyQ61BfuOw9O0H/GiLWKDv7VAuCJjDfV/FD0RgJsHWbi0yWSKV+lSCVWqkEZ
 UURtPSgeoOgdrMDxc7FxVdWjkSA6STW+0wce1RZiMBWYmZM2uz0tUVMzV21B88Jtisnp
 50Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740641456; x=1741246256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1cRaC5gQFqx4sw4ws+KyDi9AyCOSvamK2A+8kQRjfk=;
 b=ECRePi8KaDq4u3hK1RdmLXxSnXWCcDohVqmItLuG1ezoZ5dbAN6eGBgmXTh0UoWU80
 0g6EM569v7siOn2rFAL7Lyi2UPCWGdTvVfplX7HuZvMgE9EigarLGfU3vglIxTmqs4VD
 AOAmKY2zfTTLFw+niyk4ueIZYjET6RCN+a/VJxlSUDrxWsNErjMzWNvqYAqJXm17DAX3
 kkq9iQmYvsoPyVIX945dijzVlKzf6VnAIWG4Z8uG78FGW/3ztxlO6cnFLLnZ0ZinO3xd
 zsVJjwYm4SrqjTMw6gRWgbCyJsV+LWJNaubsp7fix7/4KeEmZyvNbAvRaSggt0ycxsMo
 c0MA==
X-Gm-Message-State: AOJu0Yz4EE0RQRXPwOTBZY5Stx1hf2KoSNJRfvxz3kzspRdwxxo4Zies
 wDGZKKGvlDBAEp0emV0vsUSKb3HTJk++SL/3e3qVE+i4JmxQlSTvb3WtVbjnVt4yo0hefT7xAvJ
 rookdm6z+L63GT0IaonQBGHtiOBxL910RtUw9z3QUgGrsQWDPt7bkvd0lwwZhQmL0/zr6F9YwqF
 qBwRNgf/0/cZEyYcdtmbvKNogOnuiULY+NTV3KXvI=
X-Gm-Gg: ASbGncu8LsT7Cp+uxOCTeWUbDm6/qha9yJh22esvdpdgYSB1thWSb9y8pIF6644T3KR
 IBtRYKX7kVVi0PWt6bDO4K51dMpHTpt6DkQiXMwZHZjxpmlduduPwxvrBEK7+5GDYhrlDi3Ds+P
 0G4WvfdFbiqH2iQpcOkBbYKyYgLyyeafJbYa2RSFD9JcqCBQ3SKmnM01BPxkt+++NINWJM/fdZt
 aJJW2BwBLYZabX618QaDydjbQGr6w7HvCofCXKvPHPNFmyRizGAsevt3wjK60LbH5HclPKe3E2V
 4ZhhpitOH3uMLVjb82IrGtRf2rDHNXsuP4Sg2lSd5QXHy7zeYNswXQ==
X-Google-Smtp-Source: AGHT+IFDxKXagRZxdP/bUaV7OZcddxqG+Egy14RcpjwohSoEoHaJNhvo4C47QQbATRh45ZyZXkt7QQ==
X-Received: by 2002:a05:6a21:8801:b0:1f0:e3b9:6b17 with SMTP id
 adf61e73a8af0-1f0e3b96b1amr21723557637.26.1740641455623; 
 Wed, 26 Feb 2025 23:30:55 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dec6727sm716764a12.51.2025.02.26.23.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 23:30:55 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jiri Slaby <jslaby@suse.cz>,
	Jason Chien <jason.chien@sifive.com>
Subject: [PATCH] hw/misc/edu: Rename macros indicating the direction of DMA
 operations
Date: Thu, 27 Feb 2025 15:30:49 +0800
Message-ID: <20250227073049.32655-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x102a.google.com
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

This commit renames the macros to accurately reflect the direction of
DMA operations.

EDU_DMA_TO_PCI now represents reading memory content into the EDU buffer,
while EDU_DMA_FROM_PCI represents writing EDU buffer content to memory.

The previous naming was misleading, as the definitions were reversed.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/misc/edu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 504178b4a2..1353c67dc2 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -63,8 +63,8 @@ struct EduState {
 
 #define EDU_DMA_RUN             0x1
 #define EDU_DMA_DIR(cmd)        (((cmd) & 0x2) >> 1)
-# define EDU_DMA_FROM_PCI       0
-# define EDU_DMA_TO_PCI         1
+# define EDU_DMA_TO_PCI         0
+# define EDU_DMA_FROM_PCI       1
 #define EDU_DMA_IRQ             0x4
     struct dma_state {
         dma_addr_t src;
@@ -146,7 +146,7 @@ static void edu_dma_timer(void *opaque)
         return;
     }
 
-    if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
+    if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_TO_PCI) {
         uint64_t dst = edu->dma.dst;
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
-- 
2.43.2


