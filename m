Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BED606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0ekHzYV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQi9-0002zQ-9B; Wed, 25 Nov 2026 23:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xWQi8-0002zH-Nt
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 23:03:52 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xWQi6-0006D3-O3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 23:03:52 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-571888655f1so2232504b6e.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 20:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795665828; x=1796270628; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bIuDluCbnsnMu2I9m0NjlyF0A42hhgwAKwv3lUYWo90=;
 b=f0ekHzYVwKyeqLH0JIHRIIR32hB1ql4loYIVXqQr3cRCmYq2ed+6Kc1RPesanPXJGV
 D0nPqJw5AMooDkij1KjTYNTSfrWwnAPMVf5ApOmQ2FG/Hoy2LwvlDM/5hf38zb1q+NXr
 IeS5y84EBh7IXOA43LpgNSft0BUcwruX6x/X6BdvBkL4D9KruCh4JfUq8xEcPXFPlUV0
 5K8fXgbeC4QWN/meIbIwSjF0wOBeOITPU9RCmN4lBiyd+cMIuY82YGLEWAKLm+7aepnO
 K6m1yYfF/hHj8z/h44yuulXmW0+bnP75IVZS6e1EVCQrusGTKNdFmZczht/tSb+momIh
 IlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795665828; x=1796270628;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bIuDluCbnsnMu2I9m0NjlyF0A42hhgwAKwv3lUYWo90=;
 b=DksSVljnwvcdvkV7nX8F2/2fMUIj7ARJtqME1jXuhiMI7uEUmmzeGBhitWuhG8Njtc
 FydE8NiLMatsRWCYXRTi0ooNUXp6xRDq2TC2LvoqN/XJx3lI5w+LL00IRg0Lwiuzqc7T
 XeKW5175DkP6AgA6iEK5SPKxrRaW1pmriyl6m5wSvTyAH0x4iJTkz0UKsKklcAnGbqZd
 r947+Okm9Oe5RiHYIkrYiwCrKNHlFMZK8z3FO2VctiwdNsMJ17XBs47w8ky013Ob0FEs
 +5vYXmP2FaX/Uwru9m7sdrMEctQl2Zj+VvXTYtOTcw5nkLKF2mPxD/kbCxGBSON7lcVv
 AmNw==
X-Gm-Message-State: APuU4Z/K0V9oRBpJ161ZdYP/3Wu9+/7ctHPKU8TZTWSw+9kHg0s3+7xA
 +iGtCSlOgMgFSZ/Ke0mTaxtOOpSWe+xVfQ8IlAUod62WcoYMb02hZy1a
X-Gm-Gg: AZFdTZd5zd1xrlGyLLOBDxG2Url0MGB+XtZzglrlLW1fDvk7qqK3iPzjFJGCkk4S3X/
 zjr7YANh2W/e37gTnDGPnBFp3wYWjE1XenzO3m/3w+PjLS7+glTanPLwW+kjhN8lqkdqQIpmew9
 gdmSaRly4rZeXJwnglaogRq+kWW59PbLJoqq5Sy2Wy7ais0zbU+vhg7OMvosmyAa4Xlcs5SX1Kc
 /i87vs8OLoSZBq+bU18exaaJRlIQWAY5j3AdBo9nF/f4BdoeTpJUYzony2zpsNCvUEEk4ABqtHm
 3xcRScFZ6E/LNkeH8tpE6SHrj5fDbHjBor9IJ/423+VLMtuw+O9dyuPpGfVGqgd9nStozCZaUQD
 trYRaB9DWVkqyhdl728CYI2fsWdO1BMm60w2VU2FnF+lTkuPZThKppJvWR2TLgiVeqqzxHnv6ra
 iLWvD4w/WTiRdqB1orcomqkl4CwKz9FLc5gYuIAnZYjQiINJP9cC7z33PGbDGfXzcfWsqf7zYEu
 47Iau0E+W6vbK7OwSTCntbJoWR4UfoYOkuFJLmYVv1XFmnOlPxeNdI1IdQBTFc+QPXDMN2zWG//
 o1n+Bjsr7X7nwyojRgXgePifuFA=
X-Received: by 2002:a05:6808:4f5f:b0:564:4dce:607f with SMTP id
 5614622812f47-57a0ad2a86fmr23021252b6e.39.1795665828271; 
 Wed, 25 Nov 2026 20:03:48 -0800 (PST)
Received: from [127.0.1.1] ([2603:8080:a00:9759:116d:2577:161a:11a3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34252251sm16019268b6e.6.2026.11.25.20.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 20:03:46 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Wed, 25 Nov 2026 22:03:28 -0600
Subject: [PATCH v3] hw/net: at least one TX queue and RX queue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-4729-out-of-bounds-rx-interrupt-idx-v3-1-18d377f43be0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI+vB2sC/5XNQQ6DIBAF0KsY1p1GEEG66j2aLiygTlLBgBob4
 92Lrly2mdWf/Ly/kmgD2khu2UqCnTGidykUl4zornatBTQpE5YzQSktgUumwE8j+AZefnImQlg
 A3WhDmIYx1ReQlRGqlqbi0pAkDcE2uBwrj2fKHcbRh88xOtP9+58/U0gneKWoFGUj9L3ta3xft
 e/J7s/sZDL+m8kgB21oZa3mTSHU2dy27Qu5Q88+KgEAAA==
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795665825; l=2215;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=4MrTC0mo2EPcy7unO/BoWOhefY9+cQf8MIr0CK/21qI=;
 b=vH0y6Q33RMg2kMGLJfP9QFaCwUvbfzbz+3CdHaVPFX3s0PZm9lR8M7BqeYmV67Qe/iXsfHCiE
 7ac24TV56n9BufXSyNBOKPfZKtASrdXFTsaTP+Lqf78A406oGIS2j9r
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=xmphyr@gmail.com; helo=mail-oi1-x231.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Require a VMXNET3 configuration to have at least one TX queue and one RX
queue.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
This is a resolution for issue #4729: 
https://gitlab.com/qemu-project/qemu/-/work_items/4729. The issue is that
a VMXNET3 configuration with 0 RX queues is loaded. When one of these RX
queues is accessed anyway, say, rxq_descr[0], it could have an invalid 
interrupt index that was never validated in the first place.
---
Changes in v3:
- Deleted the v1 commit

Cahnges in v2:
- vmxnet3.c: undid v1
- vmxnet3.c: when validating the queues, not interrupt indexes, check for minimum of one

Changes in v1:
- vmxnet3.c: changed the RX queue interrupt index validation for loop to a do-while loop
---
 hw/net/vmxnet3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 24c551a054..875c998d63 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1382,17 +1382,18 @@ static bool vmxnet3_validate_queues(VMXNET3State *s)
 {
     /*
     * txq_num and rxq_num are total number of queues
-    * configured by guest. These numbers must not
-    * exceed corresponding maximal values.
+    * configured by guest. These numbers must be at
+    * least one and not exceed corresponding maximal
+    * values.
     */
 
-    if (s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
+    if (s->txq_num <= 0 || s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
         qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad TX queues number: %d\n",
                       s->txq_num);
         return false;
     }
 
-    if (s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
+    if (s->rxq_num <= 0 || s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
         qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad RX queues number: %d\n",
                       s->rxq_num);
         return false;

---
base-commit: 6bf90d4fc5027567cb704d7888f5ec792b4ed75a
change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>


