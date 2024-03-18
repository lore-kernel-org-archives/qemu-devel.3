Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B04C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9sd-0001Ht-Bu; Mon, 18 Mar 2024 06:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sY-0001FY-DJ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:06:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sW-00061h-DH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:06:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34005b5927eso1018472f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756357; x=1711361157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFthmmsYp+m5f9owLwx+hyTocTKSDvu4WqZSfWH+cu8=;
 b=inchz0MLLvsW9u/sAZDtO3gU4sM0uXlgM1hAy1BlidQNUnUVqPG0rq67Izbx6Tv7+8
 0N5f3Rzq7GUgQrUrpVL2hzNClHWR18AqUOT+1uM4awnZr9crv8vAGpj6tXrkY7xmfbgI
 oWEJC8TrmfuYQn8sA4qbNpHiVjBMNsnfwzx9PwRDWPT1DJj+47Vk34F24jMMZpsO8mZY
 7yh1/rur6DNQ2EA2F3DK/2sioOBvc/jIA7Ql6BP9NNcP1FeeMcidGWcMnSuSf1zK4rFX
 gzkJeElyH4sPkfjt0PyB4khMg7ZfR6gCPFsXJSaCWzEUD3u6RALOqEC7wn7i/pD0bXxR
 DxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756357; x=1711361157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFthmmsYp+m5f9owLwx+hyTocTKSDvu4WqZSfWH+cu8=;
 b=nTWT86HA1sKL0wiN/1lZilZ5Ly5cAGGFa1B+vMW57RB0fjfCNOLfK5dJKZWmm1ZXd3
 Tjwn3altyjS1AjpY2uSjtlPR3u2hsQliOJxSDub3KpQvMMseKd1H/RRyEos7YFagz7cJ
 CcgcJ8oq3gauei8BzN5xtuv+2X/WMKZmK61y5zwQY+bdM2uqJiAfjwZmnzA3zBcvRzI3
 Qx5sHF/UdqKfKKtw4MaVYxebZ3TsBqb/irV18Cgh29EXvg5qYrOTZTeZ4SAQXIjTE17x
 0l7Q5gklnUI+536OmH7194IgFOAnB6uhAKoN5JWW4QeWcrk72rpbBmB2EsyfWXTPpKQd
 Ui0g==
X-Gm-Message-State: AOJu0YwNZ8IaPVk79Ae+7qSIOJHp1lq7sxZRPZRXlDSkifI0Nm7MmCMi
 DBVMo1L7LikKkHfIlbL+PMSgRbY/a6uJXzl3UUwkC5Ju9I0KCDxSqzfPCZoSlh/OEd/dGec3RIY
 JATI=
X-Google-Smtp-Source: AGHT+IEkQbMURGcd+GowJ6dmmdpvTofChR6UhvHYnQSi6h49OdpIrmxUzplNdgFSUQU1KewM/zE7qg==
X-Received: by 2002:a05:6000:ecd:b0:33e:be35:d449 with SMTP id
 ea13-20020a0560000ecd00b0033ebe35d449mr7811193wrb.44.1710756357044; 
 Mon, 18 Mar 2024 03:05:57 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 r15-20020a5d694f000000b0033ec6a1b37esm9489265wrw.8.2024.03.18.03.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 03:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 2/3] hw/display/pxa2xx_lcd: Set rotation angle using
 qemu_console_set_rotate
Date: Mon, 18 Mar 2024 11:05:41 +0100
Message-ID: <20240318100543.78846-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318100543.78846-1-philmd@linaro.org>
References: <20240318100543.78846-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/pxa2xx_lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index a9d0d981a0..7d03fa57d0 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1439,6 +1439,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     s->con = graphic_console_init(NULL, 0, &pxa2xx_ops, s);
+    qemu_console_set_rotate(s->con, graphic_rotate);
 
     vmstate_register(NULL, 0, &vmstate_pxa2xx_lcdc, s);
 
-- 
2.41.0


