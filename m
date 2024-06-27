Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C98C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsen-0007F9-3Q; Thu, 27 Jun 2024 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsed-0007Cr-Kg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMseY-0001pF-EW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-364ff42999eso6367614f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508280; x=1720113080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS5w/rOHX5RjJWkmyFPsFftFPu5c4nwaKlj59xhrXaU=;
 b=OLy6oP86eACS3NFEB6NuEPDLQ+Gbw9jYDuzlhXDEQiJonewp2Dzw/xdPOhxiofcFXb
 J+ii/xMPs/MjiLGrOoSLQemhrZOImMsVkbCL0C4jcd0ixMqmQf/yLL6qfcJQn9oifyYj
 8AarjOwAayfLJhCNQ0Lx/1wqiBRro/kwW9uQU0kZpXs5lLl7cK6uv7nFAD83ZOTYlIM1
 8JfppXRICM8Z+EXQHSN0gpayNsauu8vd002G5k9jAbzBpCE+1HwxaGhf0QxAKpisEZOu
 xJOYOIzZo6RfuY8VI1xGNVBj8s4/N4hzGKUdivUHmgBuFIDiDYytF/EG43DVdMOHOsq2
 JXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508280; x=1720113080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS5w/rOHX5RjJWkmyFPsFftFPu5c4nwaKlj59xhrXaU=;
 b=n2cWRHda+U4ol6Q5063uArNZeQdGaBuwWdId7iQB8l1jUZQQ1Tm9i4EqB1E30FNRHe
 gZ1zUq8mafk6ZJPxNxNLoCd1zZnmHHgJAtj18kR4d/gRqCYGDiiSNzR9LW14b/Zplwao
 Yb7z/KVB7oHF4AtOYdSH7S5sstpqaWLbm9m0wwYm0m8kPxyVYqIuZ7z8YVUJm9sYGKpl
 wJcAIOJ0++Jr7NpcmM5lnrrKilGf3Qcsm66thkJZwy18tm7MCL2RZ3REPInm4WdR27KX
 WCjE2uY5LUWhuPV7OxIsod8XNbZA828rWOB5AaY/acDc1j7GSyjTdQ6dYoKFnUGJgtVm
 lcoA==
X-Gm-Message-State: AOJu0YwFwGNNkstD2phygh2WP01YrliSJds3sh+HGRDLmrsT9C/QKTMZ
 9Nx9+KNoJNhr9wyyTF0KmOiR8K44BJoc5Ge0ve8w8nP5Nm2Wz7d3dQGaElRpPxYxIoG34RU3XjD
 MvVo=
X-Google-Smtp-Source: AGHT+IFbJlRK+CniOeFZTveQBOAZD1UFMtdcrQYiz5wcr+jyqnAgVeH49LHe8r4wTuppPsrXTNqhcw==
X-Received: by 2002:a5d:6482:0:b0:366:e986:22ef with SMTP id
 ffacd0b85a97d-366e9862451mr15683222f8f.4.1719508280679; 
 Thu, 27 Jun 2024 10:11:20 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c173sm2534594f8f.18.2024.06.27.10.11.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:11:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 01/19] hw/sd/sdcard: Introduce set_csd/set_cid handlers
Date: Thu, 27 Jun 2024 19:10:41 +0200
Message-ID: <20240627171059.84349-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In preparation of introducing eMMC support which have
different CSD/CID structures, introduce a pair of handlers
in SDCardClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 2 ++
 hw/sd/sd.c         | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index c1a35ab420..0d6d9e452b 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -127,6 +127,8 @@ struct SDCardClass {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
+    void (*set_cid)(SDState *sd);
+    void (*set_csd)(SDState *sd, uint64_t size);
 
     const struct SDProto *proto;
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a0da06e017..b0ef252001 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -671,6 +671,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     uint64_t size;
     uint64_t sect;
 
@@ -691,8 +692,8 @@ static void sd_reset(DeviceState *dev)
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
+    sc->set_cid(sd);
+    sc->set_csd(sd, size);
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
@@ -2472,6 +2473,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+    sc->set_cid = sd_set_cid;
+    sc->set_csd = sd_set_csd;
     sc->proto = &sd_proto_sd;
 }
 
-- 
2.41.0


