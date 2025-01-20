Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D7C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyX7-0003qO-MK; Mon, 20 Jan 2025 15:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX5-0003pS-51; Mon, 20 Jan 2025 15:38:03 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX3-0002Tk-8Q; Mon, 20 Jan 2025 15:38:02 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5db689a87cbso9542661a12.3; 
 Mon, 20 Jan 2025 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405479; x=1738010279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4eqioEqDiPZKfgpKSby2VQfBQgy0mMrRetTKTmi4w0=;
 b=avxXaLNLm25Gj5Rn8sIBvIky0WZivL9uixvu8cGrdnPPsViGguzCRRy/ziRaz9xJPj
 5PHjZltABgfbV59kk7XhROZTpFjCB45ebLU+mPYtwNXWSELbc0CfHTQTlrVHcY6BEhaj
 q569VePjKfNhsiRkGLRPhUlb+cvJKGti11jLd2AdTkaUFOu7JrryB14kLaeFwhBeJcoC
 TxBKCVfFt+EMvrdqxyaLw0M8bBEZsadoprjzk+v/iM8vmh9zupkpYjJBFl5dFLiFIAAL
 e2E62SN8vriYCJSSmdWtqZfAzbMP3gkr2uUDxijjEEHpJN3UWsF9ZKEwmS/xLYwrgxYZ
 MXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405479; x=1738010279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4eqioEqDiPZKfgpKSby2VQfBQgy0mMrRetTKTmi4w0=;
 b=C144YNtSMgqGSZJLkpYGYWNNb6quOSdKifuFbi68gLazPALu9rd/Jtmbh4/lJHi637
 V7w+DIs7IalhHNFKONmEaXPbj5P5TF2bvBamnn61U8Qu+euvWhJW4e6M9YU2wrhvV4oB
 LQcqKYF7oVwYZmwRJ7cpoc+P147dCdxOTSy4n+F/EPtRHEH4I4QC3cBRMPg/UPlu8M0U
 NDTQfVoh5MG3n7UNH1y97A9OqQGon1anmLykz9WeFlnDa4AV6N4aksG2PjYGjFWuHXiE
 /mysKD3cQfihMuhXg9kRgqKvFLQXGdXuO4t8SgNv/eYakCnyXP7lqhQrUzX9hB1ASU75
 Fhkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfq0G4a4HjV2f/sYJ7ABmsxdN+kcZ/bZOzkc/ckv11s2vfm4ajH+6S69OHeZnNJISU48qsZS6LZg==@nongnu.org
X-Gm-Message-State: AOJu0YyWh4xmi5c4hm0rEeunTSios9od/8KwhZyMb8e7LdyrKcusmGNK
 rUu2/ZBIwvw/rtR0lM7fyCvPlY3f8w5Cybv9jYPHgGTBrzcXf5e7Ks2W+Ln7
X-Gm-Gg: ASbGnctBhtHab2AmqVHW0R+e/iwsQwLCMPSKcf38j+xkAffg9XoJ4CNN9dMDZ98Eq2s
 s2zXzUJP0MbLXIWPuPpapfkUyYfhkJdcTDDlUcEpf3Tri5woEpsTPvS9QSXcGVhZopP0M3hyjU5
 AfYje1NOJLrJD2T/mPwyVmsXiXXDpDdjPU9BsdwbTsMWmgFaOEeddsjCxiQp2sgD19lkg7q1YSW
 iP1isWolSFdY5APCor0fTX369mBUtS7UE2uXrzgo2JOAbdr3ADN3RBAYYF3fvK0VDOOO3XlYb0G
 9tW6xllQQqLp4IHcXGR96uPfvYqEsa+i4YjLZVtkfCGP0jK2Sx4lyPIDne0N
X-Google-Smtp-Source: AGHT+IFGaxT6WPfYmMqoUWoXjRJn3yfi4n0Af2capSzQ5Cn1Pz7gsO6ubbeg3QAXt7nhBtRDVblLrw==
X-Received: by 2002:a05:6402:1ec8:b0:5db:731d:4466 with SMTP id
 4fb4d7f45d1cf-5db7d633108mr15732249a12.28.1737405478900; 
 Mon, 20 Jan 2025 12:37:58 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:37:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 01/21] hw/char/imx_serial: Fix reset value of UFCR register
Date: Mon, 20 Jan 2025 21:37:28 +0100
Message-ID: <20250120203748.4687-2-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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

The value of the UCFR register is respected when echoing characters to the
terminal, but its reset value is reserved. Fix the reset value to the one
documented in the datasheet.

While at it move the related attribute out of the section of unimplemented
registers since its value is actually respected.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/imx_serial.h | 2 +-
 hw/char/imx_serial.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 65f0e97c76..90ba3ff18c 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -109,13 +109,13 @@ struct IMXSerialState {
     uint32_t ucr1;
     uint32_t ucr2;
     uint32_t uts1;
+    uint32_t ufcr;
 
     /*
      * The registers below are implemented just so that the
      * guest OS sees what it has written
      */
     uint32_t onems;
-    uint32_t ufcr;
     uint32_t ubmr;
     uint32_t ubrc;
     uint32_t ucr3;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 7c353fde50..cb6761d40e 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -160,6 +160,7 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
+    s->ufcr = BIT(11) | BIT(0);
 
     fifo32_reset(&s->rx_fifo);
     timer_del(&s->ageing_timer);
-- 
2.48.1


