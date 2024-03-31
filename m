Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5573CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphs-0002s9-W1; Sun, 31 Mar 2024 03:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphq-0002qm-S0; Sun, 31 Mar 2024 03:34:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphp-00027g-FK; Sun, 31 Mar 2024 03:34:18 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29df3333d30so2288529a91.1; 
 Sun, 31 Mar 2024 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870455; x=1712475255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sw/t58NlNMsiEYbm8tj58VRibhqWk2l7GIj5tEOLJ6o=;
 b=nbUSEDztFat5z78KChmuvB8bz3JwhM6fpZUAXAsWex7k1Ho7vkvEdt2sxWYvROfTaG
 6YFVevXrpBd8AFvJjJzZPwy8VV+VjditGqySV1/ylEmU5CTUn3q+A8D9BqUYcOOmpGOy
 U4/J3ADpd5ua8NkrngmW+jHiUwwFhZ7NPIF40KRKJy3BClxPHtKasKErlF77tZZ7xE7t
 DjKLeRk9zPkjvtl3R174HgRdaE/Vis8YBljwbVsuE03wrdkqD+CUdiXRLpeUS/JwfB2f
 ASv910hBoDYCKGy6zFgEadqT0stOt/a/L27ghr1WMJCSkpknhuYZUEwfOBHjG6pTanB+
 EusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870455; x=1712475255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sw/t58NlNMsiEYbm8tj58VRibhqWk2l7GIj5tEOLJ6o=;
 b=S9dnux55j79xTO+KGmhG+y28O//FRHZqttkKUiBGJ/YO+F7z3vmvURP/IHFtal1g5H
 2C14xWd2cmzDIQiwkhhOjE+B2ND000Vd4RasneHq9wJkQHO/VxkR0E8REkdRIHwLj5Qt
 1a7mLsMF7XfxbQuu5OOQ7ySuXJpbj65c3stTYuvIT/IIynH/SlgZJ0Ebw68ES+musXln
 6o49Ivy19gRKNJAOugGteQgjk/CM7H13xt46buz8CYPxF7oo9rQKgHBYqrPg1KX8FM0R
 r9e/k92KW/5duuWrTasbU1Cyvzms3i3t3mjkJ5T7z3Xac7agdZmv7L0u4KAfALmimZZr
 1AFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULoUfucdRJ4y8jijJ94Lpbtg5Kgcrr3bshZkPpXMJQ278uF9X12UUZpCcsZlE0s3hAOZM1fJNqBtZylbOW5oTx+8Ru
X-Gm-Message-State: AOJu0YyG19Q+fX6HHDhD967crxakyrzcHZV0ToMSJ8vvqxLkHvD2LC//
 wFzT1cSAMMXZygBcHpVJdTUY64mtT3VZpeQ0nwgM7Naxq3TauxSEITy7vVBOnMY=
X-Google-Smtp-Source: AGHT+IEVgDm9mZUTEpcLKMZ2d99YeKbCAA+ReIoPEOr6RDmphF39S2X/24uwv/15OPloSsyFU9HNqg==
X-Received: by 2002:a05:6a00:2196:b0:6ea:f7e2:49b8 with SMTP id
 h22-20020a056a00219600b006eaf7e249b8mr2978098pfi.3.1711870454960; 
 Sun, 31 Mar 2024 00:34:14 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/8] target/ppc/mmu-radix64: Use correct string format in
 walk_tree()
Date: Sun, 31 Mar 2024 17:33:40 +1000
Message-ID: <20240331073349.88324-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

'mask', 'nlb' and 'base_addr' are all uin64_t types.
Use the corresponding PRIx64 format.

Fixes: d2066bc50d ("target/ppc: Check page dir/table base alignment")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-radix64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5823e039e6..690dff7a49 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -300,8 +300,8 @@ static int ppc_radix64_next_level(AddressSpace *as, vaddr eaddr,
 
         if (nlb & mask) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                "%s: misaligned page dir/table base: 0x"TARGET_FMT_lx
-                " page dir size: 0x"TARGET_FMT_lx"\n",
+                "%s: misaligned page dir/table base: 0x%" PRIx64
+                " page dir size: 0x%" PRIx64 "\n",
                 __func__, nlb, mask + 1);
             nlb &= ~mask;
         }
@@ -324,8 +324,8 @@ static int ppc_radix64_walk_tree(AddressSpace *as, vaddr eaddr,
 
     if (base_addr & mask) {
         qemu_log_mask(LOG_GUEST_ERROR,
-            "%s: misaligned page dir base: 0x"TARGET_FMT_lx
-            " page dir size: 0x"TARGET_FMT_lx"\n",
+            "%s: misaligned page dir base: 0x%" PRIx64
+            " page dir size: 0x%" PRIx64 "\n",
             __func__, base_addr, mask + 1);
         base_addr &= ~mask;
     }
-- 
2.43.0


