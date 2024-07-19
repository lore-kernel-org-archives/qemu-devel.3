Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016DC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs4L-0001qt-S6; Fri, 19 Jul 2024 14:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4K-0001mm-D8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4I-0003j9-Rs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso13003745e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412657; x=1722017457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1/EHJXKlUMSicfL7BY9ywX9D2Y7SpR4mdCel9zTlhc=;
 b=glagd9JJPvlW0574i9+zBvBeHneb6LLGuuFol6VVmx3tdmqlgnqy2K0HplpHqvztru
 3X3AWinFxb5CYgEbCZGxuazu3SQZ6pJQzH9E9UjVKEbktNaSiR1Xh0WAaoJB6+PNrOEK
 Dm6UP7I5BlZ8MlX4gUsRUSXy/oSzcPcldTqMnmQhkJebIuOaoeqXRFMsGdrQSfOcp8hv
 WiZAuV0xYBB8SD0t++Q2FJz65DQ3OUHuOa4WBmIWZXe9MrxWRKfnLhznWpB0Ri9v3VNX
 jti6yM7AXWE2/K9YC1Hpn+0jRXLca6i0fCo5kXfLyGPmyrR2h5vnNKvs4JfdJCnJ8zRo
 Oivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412657; x=1722017457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1/EHJXKlUMSicfL7BY9ywX9D2Y7SpR4mdCel9zTlhc=;
 b=Y7kmqOGEcmfIAydVdLStVfmO/dLkvyMtywLVgbubnDf9zhFaSlHolAJt4IGUJ3DuVk
 xcOXkyg2w86jn2PBs1Yy5Bd7b4K2LsDolYfeiq6w8fIMBHOocGQ8xTIDicit+khjMhjt
 KZK+YfAI7mB9sKuadi5FRTFtIyyoNooC6JCiE7n8y4DTm0Q5FSDKhpGfbW3LbnUjuNWa
 H1cLvlUeD8gUq4Z72BDv5y9OtoTN7sGR69R7Ah7jEEohW6sVdpq5hLz4yKVcgPt1MlPX
 WeM60MvOTf2VRpxEn+UDxSIALh299rJc6B00KbxQ7O2v5pRAPF1SYp7SESfvv0eLsbW+
 1pqA==
X-Gm-Message-State: AOJu0YxNCPO1/Z50EQE6H9pdrCTAkkPRWQM4w2jK5pE4Vkhh7Nhz4oWy
 v6DvsWyzWK4TKFnMKkhq9Fgs5AdRb+wvh9N0lOIrOsd8bv/YFVg29Ncqja/3aDb/McHeRCxh6fj
 +
X-Google-Smtp-Source: AGHT+IHU/u6YJi7xFP2CXTlMYwlMrPXaJ2sZ+VYd7hMLWoS0b2ILTUd8zWUwWmYXUVLaC3BIp/l84w==
X-Received: by 2002:adf:fa03:0:b0:367:8876:68e6 with SMTP id
 ffacd0b85a97d-3683175b8aamr6577658f8f.48.1721412657188; 
 Fri, 19 Jul 2024 11:10:57 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684801sm2258633f8f.11.2024.07.19.11.10.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:10:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/16] hw/char/pl011: Remove unused 'readbuff' field
Date: Fri, 19 Jul 2024 20:10:27 +0200
Message-ID: <20240719181041.49545-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since its introduction in commit cdbdb648b7 ("ARM Versatile
Platform Baseboard emulation.") PL011State::readbuff as never
been used. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/pl011.h | 1 -
 hw/char/pl011.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index d853802132..4fcaf3d7d3 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -32,7 +32,6 @@ struct PL011State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    uint32_t readbuff;
     uint32_t flags;
     uint32_t lcr;
     uint32_t rsr;
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f8078aa216..260f5fc0bc 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -549,7 +549,7 @@ static const VMStateDescription vmstate_pl011 = {
     .minimum_version_id = 2,
     .post_load = pl011_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(readbuff, PL011State),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
         VMSTATE_UINT32(flags, PL011State),
         VMSTATE_UINT32(lcr, PL011State),
         VMSTATE_UINT32(rsr, PL011State),
-- 
2.41.0


