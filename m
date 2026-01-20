Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A2D26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfJ-00030O-AF; Tue, 20 Jan 2026 13:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGf6-00027H-SH
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGf4-0006Nw-1d
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:08 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so4834781f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934463; x=1769539263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=783rdm+bkQ356/mKoFd+xki71gfr3hdbrK/yAD5kMUM=;
 b=y+gpK5t4IeIk8HK+gUueHpxJp6Vk64TJaOtheLzmAHDT3Qi/ncAcD3rxJiRMs2Va/7
 b1cPLDrGN1uuAwh/WJSKVS0rUBxNzj3Fh9+SX6Oj+akQdQO4z+xjnhc6ML6VYXEfsiQE
 jUOqcC2RucOt3aTfCLmaKrfQWNrvtFysvch6udB+Xkk+cswV1ShdOgPbOjKdtuQpxYs4
 11ooAyNACIvwjKGY9VRzcORMHYA9e1ASww+C1woeR73b+3p6ft7qLIDFpEv77XBXUrpc
 v/ujyf86X86GC5NpCxnPGNkXJ/vv6QtHDWl+aM5hUre/xnONh7soepWISasoTcDzV2BT
 3g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934463; x=1769539263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=783rdm+bkQ356/mKoFd+xki71gfr3hdbrK/yAD5kMUM=;
 b=tPKI4ItQnwGgd5PZvYucGSjGE3HJqCOUQqr5Ua6imz2D/+aH8dm//Zx7GzaxFjwlgt
 yovtsRCbjyl8c9zB3sVmvi8WVySyxi5wXsxTILISWWUKj4KYUgSkspYMeqZn96mO2mlt
 2tBLU2Ki33tMdTca+uei80h3U3/a0aQk15eqfseApsDrIycrIsVqwUWkTApDACyDeUVA
 2Iw7U5cFtOZ1BK6BQmb4wcxdb4Dj3mL0yc2wkhDEm4EYh4wOeWntxln4Uj3CPwXTjKpO
 LmAK+4iTXgpHbpd6+JsCBAF/NhEV3XthA3tLD7krQbNqorMf3pGtnyPMAsxIJWKFmfIJ
 PAvg==
X-Gm-Message-State: AOJu0YwHVrJhdNqG4biwx7dIQp2YXQQi0HC9Hi/Jkc7Is9Z2YSM8iMuO
 JPEgqGe9gD/XdBuEa1isUbAIuqdwZoE2Gq9ioSY1eyWUBSAvvFJUbddtCwlUSiL5LxIrVio+8wr
 JwykweEI=
X-Gm-Gg: AZuq6aJvAzU0sfiBDQCX2qUX4MlqEnItZv9aq9/dq8CU9LJJDycX0PUNm4aUsFs9nel
 Xe16dpTqp9Js2kqS+40soEteeW/HR1L39jYxaXVEzEsK+CTjCFzEJby2MfrZx4dFtx/Kn+7+36p
 qXgcQUqkt7ICBHSj9ZhBw4QmdHW0+E+3PnJh2+xa7pWvaK8Xt0MTfoO5vG5XUz0GhGA3Sw4jYED
 fLCx9uZmg6o+xjEjEeWy/NBHhTnZGMtUjDxazjiuKqnyUH0i5hM6RU19p3mWDXS36aTvP1At/3+
 bl0dFbBU17lovFZI7q0/M7vdXlLK+Ic1ElABCOICj341oNhLS0DZX9MWcO+kgTPC7TC5W2OD5+V
 YVDS66K2IEjPTEVkilMOX7Zoci+HhoPLLN9TihtvVCUIAfK/7oUmEM6av5PCmbTbQFeR7O533AN
 27bqFwsM1+tmxP1V/9ZHvYgSNpf4Ndki/nUqyJ6CdpfJKLdbFQ34/NNm9lEW2m
X-Received: by 2002:a05:6000:26cb:b0:430:f1d3:f96 with SMTP id
 ffacd0b85a97d-4358fed1153mr3952291f8f.6.1768934463197; 
 Tue, 20 Jan 2026 10:41:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921f6esm30226717f8f.4.2026.01.20.10.41.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/29] hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
Date: Tue, 20 Jan 2026 19:38:50 +0100
Message-ID: <20260120183902.73845-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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

TYPE_FSL_ESDHC_BE maches real hardware more closely by reusing code of
TYPE_IMX_USDHC. For example, it fixes Linux to flood the guest console with
"mmc0: Internal clock never stabilised" messages in the QEMU advent calendar
2018 day 19 image.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-10-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index eb0d3a418e2..d6ca2e8563a 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1036,15 +1036,7 @@ void ppce500_init(MachineState *machine)
         memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
 
-        /*
-         * Compatible with:
-         * - SD Host Controller Specification Version 2.0 Part A2
-         * (See MPC8569E Reference Manual)
-         */
-        dev = qdev_new(TYPE_SYSBUS_SDHCI);
-        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-        qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
-        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+        dev = qdev_new(TYPE_FSL_ESDHC_BE);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
-- 
2.52.0


