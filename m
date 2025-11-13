Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D67CD342D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 00:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLRv-0000Xv-Hj; Wed, 12 Nov 2025 19:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vikVaQYKCrUtpWdiubjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--yubinz.bounces.google.com>)
 id 1vJLRF-0008Ea-CH
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:43:54 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vikVaQYKCrUtpWdiubjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--yubinz.bounces.google.com>)
 id 1vJLRD-0006Mu-MC
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:43:49 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-297f587dc2eso2883905ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762994622; x=1763599422; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tdPJbA5gQYfjHofpxb9clh1H5FB3WQCqFyboBs0lAbc=;
 b=isbzWYtC5MHFg1yvh71fWoLObLgbHo9N5XEm+wlxXw8puaLPuDGrKEQbXN9dbYTADS
 IL/c5vgRK0yRkXXIM0kVDbzKEp7bNpVeD94i8zlk4+LL8koMh+EeZ39uVVRuMUbguVlS
 lw8v+eUe8PLUFm9ODtmDcbIwTe3g0qQHUm70fJclpPSExWNf7OjmDPc37/FOV1HTZsHN
 7llPe28PxfOq+gZNNWN/kw03vpE07NkQ44gFFJ0u6X/vdVCp9J5BRRijrVlulrJWnLrK
 sPW/runRAZh4LHYIKYOVKFLp/pudcWQHQtSdDbGf+k0tamstKePfMQ++5Ln84Nx6WmXi
 53FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762994622; x=1763599422;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdPJbA5gQYfjHofpxb9clh1H5FB3WQCqFyboBs0lAbc=;
 b=SPFrSqx6aLm/l0HpNSx+tt5hT7PPHNxJwForjzDCAsJnj3lp9SZy9sajv+zvLpRxc9
 aw7Py52Eq5QProXPVcvt5WLqQatyd6llaEr/r1fxcLiEsOR+cU8zS+VG7wJ0i5xhAbLN
 CHRl3pX5jmOdR3kvQQ9kx2OhX6Mf/6aI7pW0Ya8QNDNP2wyUXLOJG7cH2n/0pYjyZSsT
 UL7u+nfioryFg5KNQARJxvr8QOcjVO8boWzRMHCytbRQ5OMJpjs3ktIDu9wgYL1czrCv
 xsPyk2ZZ/GHy8b5pZoPtBo8SGor9cReHlpnnw4qQMTu6UH/Jn8bsC2o92IfQU7vlr/61
 EKrQ==
X-Gm-Message-State: AOJu0YxujWpL9Hd3YOxzds+tx0kt3n4hDp7lmV9qccpNlvRzc1BsqBmM
 nQxKmBaTyT50sp9c+pAZUV3v2fxqgy4pgrrbwnSD7iJ5f3o8MabKINW2zv9WwFh7xmWeq4QflvW
 holclSp/IbCvx7uoQqZmxSiGcUSoVVkIHuO06CsE+8Rj77XMD4mkQkTt/EUH9ca9gPX6ap5wWqR
 7KtQCAcHOTPMDPEN61ko7eV4l6DvrA1onWEJ0=
X-Google-Smtp-Source: AGHT+IG4C8E0Tv/dBwExGNQeHKSMNapEPfTkokX4/6JZXKdbuJgbMkbJHDlHhNqI0kiYgGSmhsUI4/mKQm8=
X-Received: from dlbvp3.prod.google.com ([2002:a05:7022:ff43:b0:11a:126f:ee80])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f86:b0:297:c71d:851c
 with SMTP id d9443c01a7336-2984eda9f4emr58626365ad.36.1762994622150; Wed, 12
 Nov 2025 16:43:42 -0800 (PST)
Date: Thu, 13 Nov 2025 00:43:29 +0000
In-Reply-To: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
Mime-Version: 1.0
References: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251113-quanta-q71l-eeproms-v2-2-e72451b974b0@google.com>
Subject: [PATCH v2 2/3] hw/arm: add eeproms to quanta-q7l1 board
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3vikVaQYKCrUtpWdiubjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Patrick Venture <venture@google.com>

Adds eeprom init for aspeed helper method and adds 24c64 eeproms to the
quanta-q71l bmc board.

Tested: Booted quanta-q71l bmc firmware to userspace.
Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/arm/aspeed.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe7701381f6980e874f9fca51805ff9fb9b4..bae59ae7394882e3fc93863049a37ff5a8737ff8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -561,14 +561,17 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
 
-    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
-    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
+    /* Baseboard FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
+    /* Frontpanel FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
     /* TODO: Add Memory Riser i2c mux and eeproms. */
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
 
-    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
+    /* Add BIOS FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
 
     /* i2c-7 */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
@@ -577,8 +580,10 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     /*        - i2c@2: pmbus@58 */
     /*        - i2c@3: pmbus@59 */
 
-    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
-    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
+    /* PDB FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
+    /* BMC FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
 }
 
 static void ast2500_evb_i2c_init(AspeedMachineState *bmc)

-- 
2.51.2.1041.gc1ab5b90ca-goog


