Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EF1C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8uK-0005ZZ-UH; Thu, 08 Feb 2024 13:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8u1-0005Me-71
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:38 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tx-0006os-Qx
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:35 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a39e31e1aa9so12210066b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416011; x=1708020811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49ud5Yjb30rn8SP9Mr5OVYTkrS5yFB+17IJ/cfY04ss=;
 b=LIMfBEEIRCYqMVNfECDt9W/Oy3qom2pvaKtrUCP2zzx/dfbyupZbdvTiFl5XZODU//
 /lqR4op+YrNaoB5XhpFaskWz8qTo+Ff5rOyq78BSIhrCmLU07+uGvJOKVTzAHeVFg8Ly
 RY8RK2HJFa5XE+F12yZ1yJis3fai+trNMAIot4gQDR/eNIXDpUk72kfHIXRHgWGIJVWI
 gq8Y7I804gASPjdwVKgn/PDVbCjcvW2KuZhXS3gNfliPtj8DDVsUwrf8/IgHV2sSfa8Z
 Nt24uHzHJV5SNHnvwl/LT4O6oWLC3h5kklXRjN3l3+QHP3M2dOvbYKS3eFPqn/Dn1PfB
 MrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416011; x=1708020811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49ud5Yjb30rn8SP9Mr5OVYTkrS5yFB+17IJ/cfY04ss=;
 b=adr/9dPLNU0dX5W3r9sHpFR04fghqKAjeThLd5HVTW7La+iEEvp4S0Kfvne73LQuA/
 MzOsMXcWsJBqNwCCBI3Uwn1YXNt23sKNjLkWAQzBZBXnBAKzseFgFlyMLWemCF5o6MhP
 MxRy3jXwC0hivMug6o3yReFFqn8KUXis0h8Q0yZ+e2NtuZBmQncsTh96oq/OMF/z5oCl
 DjuWoD2+Sj+uH2Nj+wmIU/DJQkJTiVP/aMUe23ZFx6DBsuULmw/V4oj1+jdeEwSREf4r
 6Uxc40paqJU7U0M7hTKBBKSfGX2M8Vr0DGVEPOsExsejE8Q8Z645zIHPUhFTFbQgVtSD
 4HdQ==
X-Gm-Message-State: AOJu0YwGRDSxMVUNnr7jp80vKKtrkkKsrl8PWfjMgtn5ng1T8xzzjlbf
 zeJZ5iDReEz/JdMk/2ZA8dvFPttOJ6cqbp1p4SyC3VskugtTWcPJ1hNDH6bcyJEwSkSzhNlERM/
 YOhY=
X-Google-Smtp-Source: AGHT+IElKnKnfr2w+uv+DJybwknWUt2WS+hrduCNrzndqBMvy8oa1xWESV1rOzmK5yYbgzhIAsV8yA==
X-Received: by 2002:a17:906:1cc3:b0:a38:6b3e:8bd with SMTP id
 i3-20020a1709061cc300b00a386b3e08bdmr93193ejh.37.1707416011498; 
 Thu, 08 Feb 2024 10:13:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWu2EbPuE4dOdkSp7nul+FpNq+9PE8jv5D0KfYqhDgArRE57ave53OHf/heI6zT4eJVrEkTNtyt8x4aN5C8rpwpzxSAv30Klpc+CgZqcaiftxlryebGJ8pjHyG8tT6XHnkoJecs+aHlKKLCxaK116PUB3ASLy7jpH9MVM3oSvV5BEy7HyJu8p6NmBwvotGQxRETSqJzIGXSGfKdfM155VlEXgpmzOkeHd4yt1ptNA7svbf5rnhIc0mNhetgZIFJFJTAxcTlXvxH/7ioqra/jiOUh0uxs0d3v9rEOGgpDLS1gfqpHD1/Mj1Wuey+PrIaLqJZTnSLSrHzX1++NMw91yJOnHQGB+aB7TriTyefKhM4eaMBoKvo4jANJQv/RTvFp+2tS++EzcPAmg==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a17090681c300b00a3826937a33sm292715ejx.211.2024.02.08.10.13.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before accessing
 it
Date: Thu,  8 Feb 2024 19:12:40 +0100
Message-ID: <20240208181245.96617-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/sh4/r2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e9f316a6ce..c73e8f49b8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -285,9 +285,9 @@ static void r2d_init(MachineState *machine)
     dinfo = drive_get(IF_IDE, 0, 0);
     dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
-- 
2.41.0


