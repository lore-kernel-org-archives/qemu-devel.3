Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F6C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrU-0006AC-Qy; Mon, 21 Sep 2026 17:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrR-00067r-PO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:42 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrQ-00009z-80
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:41 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so18380395e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027257; x=1790632057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o+hEYygZfsuRDx+4QNBUO+YpCyklkWw9TSfQmKE7iGE=;
 b=rv8OfZjOZWlq8hjQi3kXhgsTcr9RwXHp2wfVUT4bBFDS6GQWDS4H9YXk04oMjWKOo9
 UGrJ/L8r6enjJNsLWUyc6X5Who8E0+1PeOu9h8zm1RYW3z6XkygL7E7wirNZrIymAm5p
 hpk+PTUYmBaUtqU+1Rk0TWlO/ngOo5Uoz7NBlvvgbpih8gBt7tRg+3CYhSSaxzCTczpx
 QwuqrtSD5mWXsCQrtyVz1Kvki7iuFfUJMSsVuD/yoA7DuSkcXxvgcETm2fr04qVPPju6
 U76pP5OSWjUHDpHs+RnWTDXeqMfNL7hd2DPdAXkV/w9Frja9rwFbJfATED8AuXorBNll
 pTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027258; x=1790632058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o+hEYygZfsuRDx+4QNBUO+YpCyklkWw9TSfQmKE7iGE=;
 b=LZPIwoMhw1Wd/L81MrSPbu5X0pB7WnczMl9Dy4Q2BCzRiaAIB2zr9DcKSgzSNjCjkE
 +4l/WkTGSpEC2ZMqz9JALDsC8ziAMX2xGpn1BlIqQF3Kdx3khpY/MhCXf1goLVjBmx5D
 x0/maHKvhjTV/6Z3eCJxzW6As4rh3Qf3nqMa5gVoyh4YobpsHW4eVNDBwTW2VtKaGpBd
 llF/ktKJ8W/9ZfhuKGluunFFBvB4wxlTksnNVEZdTU/v8Z1a1oMaeVxzvKwZeaZdidty
 WKYUyHMxcORWfip6TNHn64Y/6sBoqJHBtgXQ+/a09qJmyoBtLXeMSNr1PtRLYRHTsrWs
 rFmw==
X-Gm-Message-State: AFuF++nFBCYSQI2gpIlpyWVJMId21+s+FAK4C5jTN4W7Of7W25H+IdGS
 a+AGRQYMVekFwDhNTNh8aivjixJ2aiaMPJrwkRn+I8B/XRbrIC2/rX1gMQlzdw==
X-Gm-Gg: AYBFou3vdqZU15DL0PRx9PgOV7A0KxE08nPS1m9R0wJNz85ypGDaFdIoIzO3wQ525Mv
 MbW00QpHQfqfHCiVy3hTK80a1+1piGy4LWHt4xhyU63BP42p9VTqZn+kYau930UYkdMnW574V2N
 kzBHNl/3tqkKDuBCuHAvJsTQDDryP+3W/8lVizbXXI/NW9C1aASaLOUoaNJ6ryBL777nXGFq76w
 zWX4l51pPecYURIhGi92YTV4bttvFhhGVOvuq6JP7MC5dYO7GAXG9upST+gwSCM/AfgM3ZHoOxn
 8bvPZSENsPTkb3btVYeX9p75LiKsyM9HYLqvt8be1QmKuuYUK30HZvEKVagIf/+/O0U+g+u9XUS
 PmCRO5DE6T3PkBLMnopl/ND2Qi8Zpz1NlQLgFCu9ElLtG4KFvgMNqZ3f85FzEug607MnNSCtV+Y
 OOnkqUHtD7CiF31iOgR/fNd7V/rbRrUXY+OwbsOynfYxiyCjlahceYIRujoki11OzvBNeD4WrcC
 TT4Q/LzZ2vKFocQRUM9USoDiEbmJJYCbHleLqvPlIOlFhiqZKXkAvceDICRvCQgdfeLnDCN02Gg
 IFc=
X-Received: by 2002:a05:600c:1d16:b0:49f:bc8a:b103 with SMTP id
 5b1f17b1804b1-49fc55c5361mr193211495e9.0.1790027257531; 
 Mon, 21 Sep 2026 14:47:37 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 08/42] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
Date: Mon, 21 Sep 2026 23:46:36 +0200
Message-ID: <20260921214710.29422-9-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Having 512 MiB of RAM matches real hardware. Fix the machine
default to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-m 128M` needs to be added to the command line.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx6ul-evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b..4964cb9345 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -73,6 +73,7 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+    mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.55.0


