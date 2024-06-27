Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E1EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfl-0000ra-K4; Thu, 27 Jun 2024 13:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfj-0000dg-Gi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfg-0002JQ-OR
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42565697036so5582055e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508350; x=1720113150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQQUBf2F5gPlbKVK01VAnUB30JlRnWbK2EOrpmfwvjQ=;
 b=QHAZdY+Y1dpy1YvhvphPnvRajMSu2MqT89vdz7/DLWXxhcTNoaKRZm3STDra/fEqG+
 4jjGwz4kl4dNbqFPzxpD9pAkRvpvySPoSn8/Bbh40x9CcrWX7qC7LJQbWG9luF5EWHw9
 bhVp8LqK1t9nLsmj7jF7x8WvKgy89vXXok9QtZTaDiyX5TR8ZKLFCW0WoaBklPTFKWOI
 INv2eqqkXcondUTkb4fuvPK0A8is6zdMvWQXEHMNkOcKYgke8t7KseudapSFWTGJjybI
 jEAFJSz4rEzV0fosjEtFkpb1KGDvK1hwAsxi7J/tTUVeFq4i6moFTNrBJ1DIu2zM2iJt
 Aifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508350; x=1720113150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQQUBf2F5gPlbKVK01VAnUB30JlRnWbK2EOrpmfwvjQ=;
 b=ikfQevTVr68a9iGfg+q5RhIgJPaG2Wux63ZtZXfV0BHdgEXwbDilF4ArD+cOxtzhS/
 v+E9+adslDazbsRkVFfB3GSunlfxFHm2GZmwXwV7nuH47HR6E9iY2B/Ix+s0ZAwv19Gz
 zjcOBwXaqpulQiYwFF5DTKS3W8lT1uAlnFXnR3JWAxyoJ0U98DzDH3O9No4775d4Ox44
 /Dxop7IxmDBKbNUttuSn3WDsS7vpuIXZaOYuRynTiq8IJijhziDsqu5+q0LJpcWLsKok
 /XXOyGt+pH/3qAUFzqIbl4zyG/EeUyy87OqocoyPRzvoVORb2/85fCZolGM7Oe9aw5SN
 o8lw==
X-Gm-Message-State: AOJu0Yz58la22EhBKyxq16UgBO5dIpkTXVsvnwqF4uJ0wNths2DuCBCW
 Glxe88c8W5Sjzo2/QZ7Lte5rBJrRgKUqm4v7EesVxMfYdM6AK3k3P05BZdrJEjYBy+rqacFJkWe
 ZfMs=
X-Google-Smtp-Source: AGHT+IE+kD+xYrGBCUUesZSLmjW7bDnhpPn+ya7jIKl+uTZ7L0Er53a28YxcAnAx0K0/WTkZEJ6ZLg==
X-Received: by 2002:a05:600c:2e0b:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-425630daf0fmr31725965e9.4.1719508350744; 
 Thu, 27 Jun 2024 10:12:30 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1611sm569565e9.42.2024.06.27.10.12.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 08/19] hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on
 eMMC (CMD23)
Date: Thu, 27 Jun 2024 19:10:48 +0200
Message-ID: <20240627171059.84349-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Cédric Le Goater <clg@kaod.org>

The number of blocks is defined in the lower bits [15:0].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2dc0209482..7c6f5ccc72 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -171,12 +171,18 @@ struct SDState {
 static void sd_realize(DeviceState *dev, Error **errp);
 
 static const SDProto sd_proto_spi;
+static const SDProto sd_proto_emmc;
 
 static bool sd_is_spi(SDState *sd)
 {
     return sd->proto == &sd_proto_spi;
 }
 
+static bool sd_is_emmc(SDState *sd)
+{
+    return sd->proto == &sd_proto_emmc;
+}
+
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
@@ -1479,6 +1485,9 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    if (sd_is_emmc(sd)) {
+        sd->multi_blk_cnt &= 0xffff;
+    }
     trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
-- 
2.41.0


