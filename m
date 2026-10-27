Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B4606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWH61wlM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnE0-0002w2-Tz; Tue, 27 Oct 2026 15:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDk-0002nV-VN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDj-0004qZ-Dw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so137983f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130750; x=1793735550; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=njtkyiWLQ6dppKJ3LzrTtB5KAmfwTkfleOI184DxmGE=;
 b=FWH61wlMvOQbN5KECt07Wtn6k6STGYJTNRcCew5YE58nTnKiv2G4eCf0DKf+dmlyrI
 KVAAryIjvAV7rLDUJyLvflAOp7Rav2B3hn93N6Ttvb3jyfh94eP1Br0Qi9o+4F9BL2Wq
 TTuqxnulVjaFcllfTA9abPhp/UEK+8nmBG7rlxzWlpxgwp2nb1mFs9pwihBgGEijlmIX
 4WFuYBbNuYy9dLC1UwakQT7E1W75qJ+iM0iIQopS1asI2Q56+uUGWT4GMkAEAGUvEv0/
 YyXorh+s28/Xhog74If74zZRPDQQY9VdkSneV5wxdGQ92Ycti9547HjabmnlcfwMUHTQ
 e8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130750; x=1793735550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=njtkyiWLQ6dppKJ3LzrTtB5KAmfwTkfleOI184DxmGE=;
 b=ckNLzgiqLGHlXOfu0CUVrMnovWdkkZnmBl7Ue5qzWj6e2PDd3/qUL9YM8lKR5aCreN
 YBMiDHvQ0q4pb2tr9mO9izXHkGVOTE4ggO4nf+yrpn27kG9neXGdVMxs9aYWvTwGR/3L
 n5P1mJbRZTVScWrqZXWW190pQidw/bkL4dlQSnRJZPTpD+zYl1I/aBL+YlYIr9BmnO4u
 cxVanl16JndkvA/o9yQxNhx/bcY6lSU5dSFdx2lxpWdUj47ve17uZ5VmuV+SBGNFjOpW
 /k7N7+AqC2o0S7nizGCGOaPgj5Rwjrwb1/5h0+TDEHWwFBeNhKImgiY7bzm7lFGdEfDb
 zpnA==
X-Gm-Message-State: AFq9FYI6/J+3A2WAFNY8vhjqQ/XHqvQRCtUs1MvYHWhR0iGAPRZ5E8vf
 FBWzI9vG7fAkhlIfmCe5YG6hSuDxJQIpcfuN7YytzNWIRwCr22l+tipb
X-Gm-Gg: AYBFou0QLv14LLS+l+YioRowzhHVDdnWUB1sUfc3+hEuqeVHlo/6RPeKBZ6BDYam0tC
 UVsd2hP71iLBzNZ59yhlRypkWBHnX0UkVAiEMLA9uN0GLCh+jQfEGIQrfuujJw43x1kTsD4SNUE
 mEzRRsm0prCKkqHXt214BOEciK2kXZMbobutFFQkUt8Vgd8BV3Heezb0x4cdqT3lhLgg/d5/ejy
 PIFxHykob5GsYpacB1/ts0FO0WMsi4TT6G2SIJ9rjb40dhyHVDAV3EpAPslVoA7h9Z91A8544uV
 j8XxIMkt1QbdGFtClVVOwfxIn7m4LPMHpXVlvjS5Abu0OWlHIrixHK3Q+suTXP0TvkUFTUtTaz5
 MV97S0/y7nAUbp4oUmfhl4c+eSl7/bLjSBVOpXUFlyMIywWYPW+qxgWFij6NG6f1aDC9goB79bE
 4PuwZbcWrE+pr312kKqUIvqr2csBdz9bra7YBNHXS5KDYujOaRE3a9mNUS9I0aAOYAvXD1wn4IR
 dFTWjDqvcmCf0+MXleNGPHAx6akY4tME6o8NTDmoARL623hjoTh2mi70+e9awdRkyTlp1dmAlVo
 i1JYARTKst6HJ3Y=
X-Received: by 2002:a05:6000:2413:b0:488:79d6:a4a6 with SMTP id
 ffacd0b85a97d-48e5d454f11mr993127f8f.8.1793130749827; 
 Tue, 27 Oct 2026 12:52:29 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm24746368f8f.25.2026.10.27.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:52:29 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 22:50:44 +0300
Subject: [PATCH v2 3/6] hw/i2c/aspeed: fix I2CD_CMD register reading
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v2-3-07deed1dff60@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793130744; l=823;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=2cPhJrLg6jplL8sLpXBRy0TPHFV2wsBvRhXZ26zaQCA=;
 b=D/AkWMO1+SFsZ9o5e9uhWSGHB6DoyznDMBVzYYfsjdStl19RJjoVvUY7ppB0Cpvh2YpkoljEq
 TtoL1uXwNgtB9u8xkcreivSUYau7kMH/qjcT2UGECjPcL0DmjI92XRH
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=gessingate@gmail.com; helo=mail-wr1-x431.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The I2CD_CMD register now returns a valid value in old register mode.

Fixes: c2c5beec42bf ("hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers")
Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
 hw/i2c/aspeed_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index fb6d19c37b..ff6ef6d23a 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -108,6 +108,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
         value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CD_CMD:
+        value = bus->regs[offset / sizeof(*bus->regs)];
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
     case A_I2CD_DMA_ADDR:

-- 
2.53.0


