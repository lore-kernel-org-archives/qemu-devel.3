Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=chApVMyM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsZj-0001F2-WA; Mon, 19 Oct 2026 14:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samanyu.goel16@gmail.com>)
 id 1xIpi8-0007yD-1c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:55:40 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samanyu.goel16@gmail.com>)
 id 1xIpi6-0006n9-Jz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:55:39 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-157fe9d771bso915062c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792425337; x=1793030137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oa7GGKxGIdUJiEFtMZRhwgXozwpjlUBJYDhFsQiQlKY=;
 b=chApVMyMNGv7lRMpzZs2vnyAIVCt8b1RXVVInaKvS6uFbJ4fEb4NzocEUys0Luy65U
 tvtx10B3KRHwwzxVI3tkVZB6VZAovKtNgCiVMIaT1l07YEfUSVbXQ5bK85uJ+5yh2KGv
 de+mcJZi8mNPoUIYbmLEY2jjhXEwJGXiSkeB8LHEFoaXCdkuUVrNoGsEi/yWq+2aAoRT
 d0Y5XQiyey49vMUcsq6sOIWwWWoH/oCDvD3Y/TBlpDR6Uc9iOREPxY3a1IRnLN+bCk0G
 +ymu6cwuUsoA2NdZa3GKQlQi6J2ltJ+/i3BXf6+6b/5hUVMU/s1sZ7UAH4h0qgT1v5sq
 Gv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425337; x=1793030137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oa7GGKxGIdUJiEFtMZRhwgXozwpjlUBJYDhFsQiQlKY=;
 b=i1jjsMjCPPlXWy89gw1dOJcP8bJBjaQJjSN0h9pzuzrv8tNHYHfQvXR3CX18mtaoLw
 G8ccF560zi6ovB+XCpYJf9zEeQJ2yxmW77TsDUIG2bjeb8qYFdWlyEjtrjgn57VPssIy
 z0zX/lUi6TDnMirdl3hnXs3Y2PpRQvPolDzAA8HO+Nix6WjP6s+/MsCtPlc1MIuvThyo
 nV+sqNC4ztu0GUdz0Vst6+rgY+g5F0gLbJsn0/BsoGK1rhGoPPWC8Sp3ziAQz6uBZsGC
 rm2L6TMMqqqw+6wQziw41sEJZL9L4AbvTA2tOn7m8SFFx6gWY+2iwbQHJyS/3LKHBQvj
 1g/w==
X-Gm-Message-State: AFq9FYI/A0b5TIPabCUs8oYacePubfQ73nkbpmgbmJtQw9cgLZurQL1c
 bp6KEalS/uQ49swSmp2D4QluBDvigYQSnEZpg18mNDVHqSmhQ0/yVuI0GJ1keH9pn/fuJw==
X-Gm-Gg: AYBFou3e8vcAFU6OKQ07HKnozrVu3abt8Gj4CfHoC0PBmsO1O/6yrla/why5UNQCp8F
 5HOU9MO69oFgT3irpB/td/FRy1sNguREUP5LphO9+J5WVxsOKvmtUSK4fjXOHGVKKPKnmRFHtG9
 EanvqUX+eknIBFEGIfWVkZT37NQED8ShVmiToDgqRRQxmzf5ngYnli4GYX97kYP42F4pY9y0dix
 WtVywvd8ma1DhOQth0zU5Qt2z1XvKEI+gq5e9c6J7ALkJZA6GwLECuNqVPP3sgczhwXJxlM+srE
 6MqeryX7AQvPjOM32UzhRUBl/hQj0UpRi49jkhh0A4wGoGJTuhTo3+5lkvxWMr/AhQ3W2gbIRu/
 HGoOM+2V44Ge20bPyIs97JIN++UEU9qVRbmG+BC1ehNLn6un+z/i5CBNflw9iIf0WktoAN6yfyz
 CEEkDv6J9HTjcm6kfi+TCa0Lsr+XWVJVCrBKCBRy5lgvm6Ac/MM627tnjRKlA3SgvplzuULNc9S
 TQEP+LwhEpJuPbrU3L3v2yn49EWjFulpdKlg8R1k1ZWZS1SS1U32v13jwbNI0VJSfQ8lVzBdaFo
 c89NYqddeFgWyypTow==
X-Received: by 2002:a05:7022:170d:b0:143:3617:c595 with SMTP id
 a92af1059eb24-1850c223bb9mr10820485c88.1.1792425336314; 
 Mon, 19 Oct 2026 08:55:36 -0700 (PDT)
Received: from Samanyu.localdomain ([117.213.200.4])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm31283501c88.22.2026.10.19.08.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:55:35 -0700 (PDT)
From: Samanyu Goel <samanyu.goel16@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Samanyu Goel <samanyu.goel16@gmail.com>
Subject: [PATCH] hw/intc/exynos4210_combiner: Fix out of bounds access
Date: Mon, 19 Oct 2026 15:55:19 +0000
Message-ID: <20261019155519.1302964-1-samanyu.goel16@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=samanyu.goel16@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Oct 2026 14:59:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In exynos4210_combiner_write(), the bounds check used req_quad_base_n
instead of grp_quad_base_n. Because req_quad_base_n counts 4-group blocks
rather than individual groups, invalid offsets were allowed through.

For example, writing to offset 0x100 resulted in req_quad_base_n = 16,
passing the check (16 < 64). As verified in GDB, this caused
grp_quad_base_n to reach 64, leading to an out-of-bounds write at
s->group[64].

Signed-off-by: Samanyu Goel <samanyu.goel16@gmail.com>
---
 hw/intc/exynos4210_combiner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index dbbdee4d31..458949e8bb 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -184,7 +184,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
     grp_quad_base_n = req_quad_base_n << 2;
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
-    if (req_quad_base_n >= IIC_NGRP) {
+    if (grp_quad_base_n >= IIC_NGRP) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "exynos4210.combiner: unallowed write access at offset 0x"
                       HWADDR_FMT_plx "\n", offset);
-- 
2.53.0


