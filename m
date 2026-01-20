Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A48DD26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeY-0001HW-G7; Tue, 20 Jan 2026 13:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeX-0001CD-Bb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeV-0006KW-Ol
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso28318515e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934429; x=1769539229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WO00u8QI4LjWu8ts3L8aVvr3TmdkCu7ktpRhzvlacGU=;
 b=loIa0i1y+iYBrqftXvExlMrAMXxmCXeuJRf3+vJptUNnN3IHU2CMKNhoPKl2pjhzQH
 4S77yCdC5Bxl9TW8OSW2CYMzX5MupPlSEqb2X+Kd0DTB1EMqwuuKh7GlnAnV6PHt7BUf
 KpshVR+1TwRK8LPf9PDmxtY0nG2PB/XVrvkANSNl5rhNCPl/dVqArn1n7XWG7+p5PK6n
 BVicdfH9ipahLjgIeTv0+XAbjVHBH4f+gQAjqJvfhRqHz98jafgPTBl7a/cSBw9nCrsE
 RZ/lwJommRSO6E21qV++RrGNgT1J3hh3SrXFiVTcOVPZaZjQcqccQ9S/tGi5mo4mPWpl
 EzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934429; x=1769539229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WO00u8QI4LjWu8ts3L8aVvr3TmdkCu7ktpRhzvlacGU=;
 b=uK6A3+4Vi+LMUUHXQfcaQA67hbdG3hoZNNw2iJqhO7D68P3lJ1EF26obUyaUosGak6
 ugCkG5Kof76t6bpM9aAbY34yYybmu+OczxGhQbsnMB4jUxgNIn2prj7Fi2jQ+2pEqMBz
 elCv9JuAu2PFqDVfJuYJuRVX/cCyEyT6gwbbXZBuAdAVDLwOPG94EWwVpsfpRkGu9gQm
 pcUpQRvoKc/mAscrHRTn9G+Mh//JjQBZh2kI15etod6PxcU5+N/CN9jxmZRsR/Wx4QJF
 MeIEMOBOAJGhCCoir3Tv+ixXfQwxHDdK/F4/4jk8yV1NLk4YxzR6E4Jd8DIrkQPZEE7b
 NLKw==
X-Gm-Message-State: AOJu0YyJ5wOhrbWVS3VDGNaJpScY7wHnAeibP7NytAATMVK7jBomEbN4
 YY21tapStnXMLQ9ltsfm3hHHn57hoQfgtZOtgPwxRXfZioaDnlZiXy7Y3CbB1ZQsva0jqjcpScF
 9yGG6N4I=
X-Gm-Gg: AY/fxX4lftTJJ+GlHp1RrNzxAMW/cXlLSPcg6iw36OjT0RsLSLM26WPk5YZxVLyT3Sg
 FMnWh0jN4DHm1E8d1IopLDG1MXaAqaVLQeHqES7nF+hM6Ir7mhAHzA74KCo7bcGo5s+Uza0nGwn
 Cun+wYFoaL4AxVBGwZRB2My0P2d4e72l2s6St+qCpXZCmDBJTRhDXtxGhUglL07xpg9W0KTidnK
 TGFvEQVtgfBRDnZQxD+VYPaimqaGpk4iLliITei/05USsgFVsUAzPvV1+N5hspnUtl8h5g46imU
 ckcBW7I37LQTibHMgc3NCN44COK2RLh8Vt+wFUZCJgvIh8WqjiWt0bO+UhV5PQ5yaInsz7h5BeQ
 2taZxmBgPK60RjaqAmjK4XKZKlxD1zJYEku7JeQcB7851qJvmXQxJp//2cqpMonBu9cXD60/75t
 4GE6PyD3QzfUYdA1MjFHnHwTh6k2GFQOscGsxHSyNtQDd6v9/meVAQoUIzcJdbDZ4ycr53rTw=
X-Received: by 2002:a05:600c:8b82:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-4801eb0e10emr197899725e9.28.1768934429562; 
 Tue, 20 Jan 2026 10:40:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d90b3sm264908825e9.15.2026.01.20.10.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] hw/arm/fsl-imx25: Apply missing reset quirk
Date: Tue, 20 Jan 2026 19:38:45 +0100
Message-ID: <20260120183902.73845-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Just like the Freescale MPC8569E SoC the i.MX25 features an eSDHC but
as little-endian variant. According to the datasheet TYPE_FSL_IMX25 requires
the same reset quirk as the e500 machines. The quirk was introduced in
d060b2789f71 ("hw/sd/sdhci: Set reset value of interrupt registers") for the
e500 machines, so reuse it now in TYPE_FSL_IMX25.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx25.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index dd670827ff7..9e02063533c 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -243,6 +243,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
+                                 SDHCI_VENDOR_FSL, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
-- 
2.52.0


