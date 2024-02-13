Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D665C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsV3-00068u-5j; Tue, 13 Feb 2024 08:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSp-00027l-HI
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSm-00069L-IM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-411c93e1cd8so2322435e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829478; x=1708434278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzdfTq0867epJMYzdvQvnVDtS/miOKN1SYVhmEO67ak=;
 b=w6fP3/sDQDdPCliuc7rhwWmIKHhP+0ykeRIAsXhoyxUbtoYauaZ2+/UcqieqHg9jVO
 N8BVcS3DZaSYeE9XNatnFExHyvbzAU+lVVDWovkN4PGBjc+rUJuVg+PPupN1OXp6n0rG
 Ot5QFGCbLAfnaHImQri+2631MwmtjHMr1YR+0ojODB7lSgic5+OLnlGdhSfCZqWf9vtK
 BVQXt1qWlpWoVBIxBUXBJkZKtNVTW22/fsZ+U62XQrpr4zXYz+7h2tlBDDIkjTYIbJ8W
 FmprHBtoKHrgMxVpzCOoMiuYV1QVIgAWqRwjMe9jsOetECyWh2IC29WT2UKu6gkj9gvE
 qYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829478; x=1708434278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzdfTq0867epJMYzdvQvnVDtS/miOKN1SYVhmEO67ak=;
 b=Nnz4B36tqnL7oOr34/Bb51keBNmLQD8OnYKSEwq9/saA2CnDkiox3EUKUNJDMu9maF
 FxUHeJw6GVeeQTSOPFU7gjLKovgFWIJ1bapu70+4JgoDihVMfXQ3FakmbLnNfHnioci/
 eZlvtoSQAas/23ksffshdy/DwoIG7UeC+p7iQG+V85gOtNDi46m//YPERBJZIXNz0fT3
 USC6MsQ8/N9CLgijEiqld2gx1m/yK6moTOWxesGevxAJj6sSRT6gaTqtwpKeqbAxWSFv
 EqOFXZ24/Tjt3qCFL8qgjqOlsd1+dkg3O/IuOjdHrinJq2OmPHp1DUojszhQP6IP1T9p
 1yAQ==
X-Gm-Message-State: AOJu0YxgzQxsYJV16j+JQ0IU5y5q0SdtFzoVj6fQZXVhE3+UOwEfiwbP
 mJup13yOrZpdkul2BK4S2Bcoau4PMVAkpeOlpcvppIy/U8Jl+Xb/0SWKPy9E3wPhWLcGqKP8I6Q
 8
X-Google-Smtp-Source: AGHT+IFh8eebvtyFHQLEINNSzD+AyvJEXwMiUoCT8SfzQX1g68EJg99tTHLRR+o7diQwqlYDQ2pVug==
X-Received: by 2002:a05:600c:3b29:b0:410:ce61:8609 with SMTP id
 m41-20020a05600c3b2900b00410ce618609mr2194442wms.11.1707829478644; 
 Tue, 13 Feb 2024 05:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyK71U+xBG8+bXpW2Gz81GejX3O5t5GAFLhPp91QS2RYXupYGRARBfvf4sg3F6D0iprzPfO1IzjPDLr6JC9afdVNS+7XZnGgzrAV78JMP/QmkhkQMJu20cKk6LTtH61n7JbS1TSOWwtdM/rILg7+WdFy2+vakczaDGbOw50soQg5w1D2uQfI/feE4OxAquZm6AZ38/wo/lXpodAYbiTsx0tvwsucmKORFQ53is2aYybkMhaIHraAG8xxqFli+Bo0KLksMrsaUnBW3Od0i+9CMcI38kF5X1rWEH1BZ3aqaMy2UKP2JtraWQv1N8BVUxDG2fKwXsvCuAsiPJ231+VlOMo2SDlGEC8T9zn/0h2FvDueZjXtkgAZIX6d1tNoUvikMOdnptA==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 bo6-20020a056000068600b0033ccfd57d4dsm2324610wrb.52.2024.02.13.05.04.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v4 08/12] hw/sparc/sun4m: Realize DMA controller before
 accessing it
Date: Tue, 13 Feb 2024 14:03:37 +0100
Message-ID: <20240213130341.1793-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/sun4m.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e782c8ec7a..d52e6a7213 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     dma = qdev_new(TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
     esp = SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
 
     ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
                                  OBJECT(dma), "ledma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
@@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     }
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-- 
2.41.0


