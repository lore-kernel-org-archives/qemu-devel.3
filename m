Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC25CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtFt-0005Pg-N4; Fri, 15 May 2026 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFs-0005PO-Ct
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFq-0003tx-7v
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so90459715e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854264; x=1779459064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QWGPspy0sNOMbf5lpim3GaJwkmkvUIm+uwig0rAXqY=;
 b=zlaJ75e2uJzwmhl4GgtSe65g02fdhjElb58ISWMm/2F8JKuIl7XzJ8KYMm85/68+sG
 fBpnIQ3gawzzOyS6cJ4gu8Y9w5LQOpq8StJ/7FUwCY8QENF6462KxeTGpqEnV5FQb9sD
 NIuBvime8be1/ft4BNm2vySQzzi8kl6wBx71gncqcyFPGPhF6tHrIyP8lOA3iQYcbMeq
 Q41rn5hS55KB07Cm5XUx2IEnNBaYQDHRH/SIxKGsjzvTYX6wNGAkcaMMezTMlbyRJm9e
 2yduGWeHcjO76SK0Lk3CnWbkCa0ONZ1GXrCv5/8dLqwfnrXFbpsZPAr9mfHzJaIT1LZ4
 7KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854264; x=1779459064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QWGPspy0sNOMbf5lpim3GaJwkmkvUIm+uwig0rAXqY=;
 b=dGsBWwIN2EQEtqwcoiLIEZd/u25epOsGrmDHGGDGyMlTGhQfK414IYnr8Fy5S5hpsb
 MqRHY+vuautrcloAOnqsHqWLVKZSTXgBBhMKqW6RiB2ycNdxCMy7cCWAv14JOeDp2SKu
 rFPGx4vH+PbrIm3yKJKy5qsa/QREVj6tK0uS3LNFmEqAxab2wJlwIIJUp83rfWROMeb5
 8YnNodUiRPTSstP8tFtQk0YzQ+UNy0tCfEhLmOUYtYuFwxzseOwcAbExza61zpEAa0zd
 L9dgu1mo8uXCr8DWJTMmZhnRd+ofD7MOTM4Fq3F/HzVjnDV6KEUcIu8f6VM3SyCIlLca
 niUQ==
X-Gm-Message-State: AOJu0YwzeoOKJ15o2R/y/JY5ObbGOk9+zRudyQZECyBD2qwwRRgYbIZg
 UJgJXGFzFJv/5t5knfNQ8dXU7nIRBcnbVxOo6AtcvXlLd02XD/Mk5wNfF4bwpFNm0JmUx3r+nEl
 fJaWn6Ic=
X-Gm-Gg: Acq92OEN6OsJkIWYOscf4gmkSYg2lq7d6U020MV88EzE7hpeK5MyxLwQRWtzIZMFCIx
 e3bg+1rBBL1bxRN4w3RLyJ5lF3Ly55osM6o83lOEDT5EUVbYnzN+DXe9D4C/UEiu2Mne4xeIzgM
 Gi5qXrCJJzv0uavc+8L4VzZN+SejaaMFrd+OFbQn667pkTSufsayHXMQbb7/w1msDFk1WOAvN0v
 GF3FrWM1CYGZfuQZZu622yTFiLH5ZWaLpmdkdpn14tIoYqFwhSmpdrOrjKER/E9ciBo7+bVSAxe
 suGok93cV73mrbQmOHOWmRLNpgqHTO2TuWjrJn0w/xwMJyOHFEgg8M0cr2hDazUPXNTD7+FUfj0
 lk9muJb1o/XwX2AQEBWI8kBrQMT9bhan4KoOmQYPMQsQuhjindALVdiavqpe3j74XV5g76i8Guc
 jfQ418km27BKZXiNF/k1JBT05ibaBGetkDvL9M13L3jpVZcsY7BgLbtQ442LdU+HXjP/wpzKxO
X-Received: by 2002:a05:600d:10:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48fe60d7882mr51294645e9.13.1778854264161; 
 Fri, 15 May 2026 07:11:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm68165475e9.4.2026.05.15.07.11.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types during
 DeviceRealize()
Date: Fri, 15 May 2026 16:10:15 +0200
Message-ID: <20260515141032.3271-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
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

aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
CPU (Cortex-A35), only available in the 64-bit binary.

If we build this file as common object, these SoCs become
available in both 32 and 64-bit binaries; however when running
the introspection test on the 32-bit binary, the init() method
tries to init the Cortex-A35 type -- although not realizing it
-- which is not available. This can be avoided by deferring the
CPU type initialization to the SoC DeviceRealize step (this is
safe because nothing uses the CPU type before, only the GIC
access them, just after their realization).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 87dcb82e1b0..e50125bfeec 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -418,11 +418,6 @@ static void aspeed_soc_ast2700_init(Object *obj)
         g_assert_not_reached();
     }
 
-    for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
-                                aspeed_soc_cpu_type(sc->valid_cpu_types));
-    }
-
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
 
     object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
@@ -701,6 +696,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
+        object_initialize_child(OBJECT(dev), "cpu[*]", &a->cpu[i],
+                                aspeed_soc_cpu_type(sc->valid_cpu_types));
         object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
                                 aspeed_calc_affinity(i), &error_abort);
 
-- 
2.53.0


