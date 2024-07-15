Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BF3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHMX-0001cS-KL; Mon, 15 Jul 2024 04:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sTHMK-0000jY-LF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:47:04 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sTHME-0004Cl-11
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:55 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eede876fbfso21362781fa.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1721033210; x=1721638010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=smeHfjdq7x/vts+HY4zLbwYTyHqb+nFZnSUbcKr7l4Y=;
 b=HnlGvrh6uKcWD/BJkFkMeJixlsWN59O6xe6g5fvN4OvCC5pI+EutKe2YJ0Ud36CTet
 W2sdwKCN3P1mCOnOK+5jFzvJM/AsH+4e6BoPpiahMxc+P4dQeGNROhuZkpSYcDCCFoeV
 OV1iBfzNwbLEAWxjONGibqL1DkkfjmMCT2nWiVo7jo9IcUKjC97fnc3L4Qez3Kx/9TeZ
 uvThGbtYY3pu9Bwj6slRMHXNxGkdH21h78kn/G1ej2gxTlWj+sa5DY0cPw7dvxWv2z9n
 QBdZBTyOEcAbGHCLFryzGbzhTy3W3tofGwQEwS+pgEeky/AWoa9wnIsHdJZH+z8lAR/F
 Ra0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033210; x=1721638010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smeHfjdq7x/vts+HY4zLbwYTyHqb+nFZnSUbcKr7l4Y=;
 b=WGEBVECNQPW1H0hXB00616F7Y5lHWcnWiqwjTtOey0RXcUtX9B+pXe5MMu1V41mjIL
 fd24vA+eqLZFzJa7JuSzieYZIfJN5dnYsx8qtZvCORWkzkJnD0dkq7G6dK7WC2G+16fy
 Fjl49kqXXuCSDug1odl/fcL8J0/ys0tfOvhDGBfKSwORUC6j+1WC0xLpYVGBUv6bc2V9
 W6Ya0Sz7YrHsX4MhSSPuGMdByerHM5J5e3v6LbYxY9GkQIQ7NeqLCZHisDbeBuWQ6ggo
 GTTnIL7V5MoDQBL/i4Y27i2rXtyaK1rpSo7zcanXzns3GScDx/h6nazQqA5ZHD8Z3d8k
 HKig==
X-Gm-Message-State: AOJu0Yw7BMzXMQ3LSMyUuEV45xbbqf15dHhYft50k1SMkxGJQwJchXQ+
 oLw4/sw8gCOptBXuW6K7jYznpZxbeKsoiIKIDoRd+z8Dk+m/Y6LfW14nz0aaaEX3pin+X7midbY
 =
X-Google-Smtp-Source: AGHT+IF25cFjiBklDjiALVQAKBjcVrGYJLwL8j5m6bGRuEK3OzsZ4AyYMz341dH7OR/kU+aMoLH7Ng==
X-Received: by 2002:a2e:b60f:0:b0:2ee:8720:b4b5 with SMTP id
 38308e7fff4ca-2eeb3188e27mr122591961fa.36.1721033209787; 
 Mon, 15 Jul 2024 01:46:49 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f259761sm110337535e9.11.2024.07.15.01.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 01:46:49 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] hw/ppc: fix decrementer with BookE timers
Date: Mon, 15 Jul 2024 10:46:39 +0200
Message-Id: <20240715084639.983127-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=chigot@adacore.com; helo=mail-lj1-x231.google.com
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

The BookE decrementer stops at 0, meaning that it won't decremented
towards "negative" values.
However, the current logic is inverted: decr is updated solely when
the resulting value would be negative.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
---
 hw/ppc/ppc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index e6fa5580c0..9fc85c7de0 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
     int64_t decr;
 
     n = ns_to_tb(tb_env->decr_freq, now);
-    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
+
+    /* BookE timers stop when reaching 0.  */
+    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
     } else {
         decr = next - n;
-- 
2.25.1


