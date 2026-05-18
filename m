Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F47CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsVB-00014L-DD; Mon, 18 May 2026 03:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUT-0000gY-Cc
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUQ-0000UP-Rv
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso1584543f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089653; x=1779694453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqGYmMNk2IzjfU6V7SHdR87lmOLyVnNSlOzoPXx3nik=;
 b=jKZR1Fyp/beVJW/igphVA64uw1bbghqRCpzGVFC1ib//CT7kS6ZbDOVvxeciEU54oq
 /3xcpxHFa30DkCTteizU5ztS+my7x/ZVNFZ3J7uCwvOu7k1O/Sy2eRssGdPWAVGK0Ci9
 YPYRhySAauNiDo6VjCE3vnaXphWAPyguCgMnzsYDnwA+/6VFDIhTjZ2yZ9AhnXdd6u0O
 8EMIJWmGH4u03FpMFgrmIejqh/tUXzWkcmzNbSawArjbByMbec6xLWNGKLBQuTlzL8UQ
 cHJpXyX4reffQXPb+t/Wie/yCNefIvD4jDSL/kXomeQnU7fOnmtSrvMhOEcICX35IKEi
 10sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089653; x=1779694453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RqGYmMNk2IzjfU6V7SHdR87lmOLyVnNSlOzoPXx3nik=;
 b=RQGqp5S/tMQv4iel/BzifBFatQEPkDLlsDBd1OgdM22KJruybhUtdPxxfesYR6+p1r
 ygIj1/zgpcGvStVmNupJCeQAfMDy45rPlhwSTnByrcj7M5e2p00Xz9tta9ognJDuuk5C
 AfukushQgbyKQc6KQ42HDySrCdRJzUE+s7+DKIuRHKLH8PO0DG2xVJAbtg1fUy8k/Iy8
 jOWa9Y/T6RqWm2sk07WkbyZnG2AV7kx1WBnBzX5aplWBl2aUvj5gkyQdOI88Po1DpDZy
 jdeY2id5f3g6JEwArIy7hPYX3SFTibTmuErwOHZHvb1HH/Gzifsf31XUeCtivmJ7R/aE
 1Gcw==
X-Gm-Message-State: AOJu0YxszNxRTDnEyyOJFYRufLIj1tj0u5H/opL1NJ5A7khNuJEUD7SR
 UbnpJa7YutUwFY+DMZRhKgdHInY9RGfhakPNngkUblX5O06hIi2mNuL0lAf6o9KU
X-Gm-Gg: Acq92OECugohWQYtbqBi0q5GNrT5DY6e/ofZ9od3ppbfUP/knW02NmA+adRzyVm3M5g
 8/vb+tkkJDWg3XsGC66agl52C3EPlhAHicdUpmd6LngNvkz1BdbqLMYsiL1539HsbnicKvQ1xej
 D5uUQhLnSk3H4BuPmfdlpZML6FWEDx15FqRi4OR5xoLr8uONtm/2Ji8oYj7lJuOYzfYVOaP5Sq3
 7gc/4gT/OD4Ty+3ac4LexbOqWhr5NZYeq4QOr5zsLVP5ggyFoEUu8rmrn/vmYINRM8kwwk5tfGy
 hjBg4JDpAhpM/S7gNeZUp6hW/0T3P0z0RqF0sbQN0eOXod1q3OnGsgjU61Oash52Nn1kkT09H4n
 BKp1SlEgwSX95JVp3PBHaOhf5ESo800baTHEFUTScYSClAp/jRv60uk4F1BA3RNmF4zvuTQxzCy
 AqlWOT4vg3GLpBCewF05oaaFOp8FOR8AGfUysCcL71PHfLnA==
X-Received: by 2002:a05:6000:40df:b0:456:f186:7af8 with SMTP id
 ffacd0b85a97d-45e5c35e4c5mr21451286f8f.4.1779089652738; 
 Mon, 18 May 2026 00:34:12 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:12 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 09/16] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Mon, 18 May 2026 09:33:54 +0200
Message-ID: <20260518073401.11279-10-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42d.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b8a2543c0b..4a4cda6602 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.47.3


