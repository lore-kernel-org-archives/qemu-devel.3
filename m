Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CE10854B2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 21:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1WyW-0000cu-0Q; Sat, 14 Mar 2026 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1w1WyU-0000cX-Lb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 17:56:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1w1WyS-0007kK-LI
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 17:56:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso31158055e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773525402; x=1774130202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f9YPOVjLnIngm/XdwqAsuk05kiixPnUAK1J03DTFzlQ=;
 b=Btflg1TLzmgRYhoFLgMwGFfpFKgTXLnfRFydBRFYh/MLc/eYNqQX8Ywn0NRml6dYrG
 kbHLmrOB08I+mgt5oHMVF7CwLBfciFTTlxT7a3+JFnIRuJf7DREoJyjOUKWyGqeTpkgK
 dRkO9vqIeHhxRuWwJWvzzjjRLOr6L+OYjmFOkJxJ/+JBrQa1G61ENkseCRmmYhQUepIC
 Lc3O+zWp8jWPIYJmJzYmzdvetDuwMMJ1QLmrQWheRNDtXqgxkA6+OrrUFyWmaYFKKVcT
 EM59E3adLywx4J6REWHPeRHFM46UYTyd4NEHChJEMHQHXUdJppIWgMvXXIIVJeb2kLeU
 RbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773525402; x=1774130202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9YPOVjLnIngm/XdwqAsuk05kiixPnUAK1J03DTFzlQ=;
 b=skhUfxBs9n70rdSPT2Vhdyt4aG+NtRIgsZMaogoi4Q5WUyXoViupwJfd8nIAO01O/q
 B1oQB++iQM7QuSnyEh+B63B5F0oK0LoCfItdRAPQ9PbS5ZiWCQH18kAJFFXN8WuSu/IY
 HONaL5xGvyW56GDvq+u6KyACMdN3KdmTGyCLlrzkyHNUukGMzNmZwp5GTBwrAljvNJXF
 cbK5udTeVofF1c9WSW9+ZL8p3M5yuzcArBTEst3A11kv930tlyZgx56P2rELLDJDIJ4E
 zxxodN/ha/WMDqg2IsNZiddNZ+jIfxGla1/NSXHxmjppIWKCJQjjj+x4BlLX+cLWk+/2
 nEtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWScICiKGyCpVuHsImhp7W4v7M98Pf+D5Znm4bYr6y0PhOfP9tlX/3Ab92Y1nFH8DX2+L/YcadmMyTP@nongnu.org
X-Gm-Message-State: AOJu0YxKa/ZsbsjywE8bJRVcoFwGXnLxBC7sUlCk1d0nrbqi9j/YjSz8
 Ua0WPgcr4Bi4ccYU/DhqOKyGI+5/pC/zjTTz9LctKVT/aXwOB83KV45a
X-Gm-Gg: ATEYQzw6OsazlrAn4uSawqZLfHyfFLiPKzm1MisMTiuurA6WBqf4gtWab+TXrrOEkv3
 usw+6etLwvJkvXuLoYrdv9WjqPjoJg/3cLNrP49hwnXJV387gPKy7778v2gDAs+wlWbjnRAAL2z
 U9jAYFOS+6ToG7SmCiyap87k01dMfOoTuzq2ii+2fTlqNu5OcFG/o81nE7eHH3wRC7kXuclBams
 qVDIsIuyLxucPyBzH3gCQVY0yUD6IDiM7JG0PEBtrTp1MRRW4J+zzoP01mo1ro6rcNVqFTKysj/
 jb6IXylh5tNmUeUBeeU539RoR5si0LBaWIfs22LTnOE3WAMGLQc1iwGe86/0a1yELDsfElJTAZI
 aa12vKApJ/UIDmphpiIIqrxa2oGS39eSlBqSKVHwr8oGswtr0wwNEPpvOaRYykDAm8zK+exQ7LO
 hERpeZPgsK9G5M5F/rf/dJL0PF5N9CDSf0Bd/rn7rBPhm+p1Wx0xV0w4ekrXc=
X-Received: by 2002:a05:600c:3e05:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-48555ab09e1mr118589455e9.4.1773525402358; 
 Sat, 14 Mar 2026 14:56:42 -0700 (PDT)
Received: from osama.. ([41.238.114.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fed7sm282505475e9.11.2026.03.14.14.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 14:56:41 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] whpx: arm: fix ID_AA64MMFR3_EL1 host feature register index
Date: Sat, 14 Mar 2026 22:56:13 +0100
Message-ID: <20260314215613.141373-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the host
MMFR3 value is stored in the correct slot.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..98889426d2 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -683,7 +683,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
-        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
+        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR3_EL1_IDX] }
     };
 
     int i;
-- 
2.43.0


