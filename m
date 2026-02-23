Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C9EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMr-0005mJ-4f; Mon, 23 Feb 2026 12:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLI-0002xQ-Lv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLD-0000Tm-75
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48371119eacso52944235e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866204; x=1772471004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PSIfnHT/9W4YeoezCcXgDdWqKuWJ/ARpVnHX63Z0IRE=;
 b=tZXeBjnuGxACndcGJzyz2w93j4AD7zWABZDUh93CioAz2xKgUtLzvyImPTdaD6Jm+T
 U+trSq+1rUsP/g59yP3UyP16uAYnfxHOJPAmZuyxVhLLRmTRUNoeVTQrEW27YleNyPNg
 oQ5qERqUFxIC77/PxwnDu3cQREA8NBwTGPu6eB5lklxttLI5213oDvHaU4lMatYL2mdP
 rIgQIjG0RssvGr4nRLgJHJzOadIBbi8dN2IzBzlAIqSMCZkfRGFykxsgyvp2LAvXDyt4
 hEOouDyTyyzMRt7nAsRKmPoj79tv4s4FCyKgTBKOXU25/TRBmZfmi6GpIFobqw4oHxXx
 pZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866204; x=1772471004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PSIfnHT/9W4YeoezCcXgDdWqKuWJ/ARpVnHX63Z0IRE=;
 b=eSZG1Dzn41m1Pa/XSqmnuEYFUjaOGIQsFY43XYL9ZVxdYE7iRozaI3AnA0WnQ4IkLw
 XHm/uVLj9xyVE0hkC4uEqb6Yf1L5aiKfAlzWhY3gh9VksTsit5mtHJuJEOWdr4GqtL8F
 DT/kybr2RB1wEde0+Lc2gi06oyyYhurijOHWyyhK1rO2hoix3kUiVTyzmomEe6OEBFWS
 aP327/zlLiATl5TeC+DuMv5xv3XsVeIhwIp1HST2Djp/FKlv6MZFKiJkF21X0cZKLY0y
 mi9/RC2b3cEv6vPiPcuzPDzywy5juap9ts8B46V+2m326+YIOCo3X+iANs8es0d8S5fN
 pY0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/hbJ4C9wwCUxOeaLq9WGOBRwTBNU9QFdvqpkwN91f43QMdOim4psb0HOHLnM1374mzXytetiLc6M9@nongnu.org
X-Gm-Message-State: AOJu0YyjZb09ru/SbQR7um9ml9CZSNFlr76+3MlcTi0cbfOHuREJl9TO
 EmwN3QV7sdNK/UI28SJiekt2ceKOfthWsdwTci1r0zOvZTvZ4tTno8TgG94lG0gxBiJAu4N0V20
 SLFVH
X-Gm-Gg: AZuq6aL3tGNCZlgCdOVOS4nBNqk0LTV3ktfGJO/Exdgmj3LuNGhKb9XjDSwe5oJoCTX
 nZd7TtR3jCp+FZBEaxYVqR0fhHn/nsijptuJ1jQR57pFxpATZbAadWqfpV7QTSIOgpHJUJ6EhSS
 uDG+OGTBEp9WnI1KC6DTdjvHvp6NJdeJQrdW783XAuHon9oEhI6VGQA9L0cVkMZPDa4s8/jhcYR
 8VJ5uX3ZEIJNaiMGVM0lMkBuxdh9bV58okrlNuM7MWnkC5QpaTwf1YOuwqsbFf9/L/mHjQzoJz/
 V6KTcbhdtaPqBRX27Jqepa1APQKAvMaQdA9r5gIIQiQnQoDsu6kw8HQC4gOmYToDR+mhDKxlXT0
 NQpFwYe6+4dkkt8zRic7JjXF3IS5pPm1sUjmWYs5Ufjg7rGKsnUOdLWxlZCpbmFQO/R1umuJ/8y
 yp3xTfIzdk+MmvOZLLK5BtyrJb/3Kry5fl8NO/R8oJQNNDEykx5y2N5Kg86Ly8PZ7noKX71KZsR
 EH6NyZPZ/kyQx/QWsE83LsP0CRDQak=
X-Received: by 2002:a05:600c:3147:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483a962e3e2mr138472885e9.22.1771866204456; 
 Mon, 23 Feb 2026 09:03:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 64/65] hw/arm/virt: Enable GICv5 CPU interface when using GICv5
Date: Mon, 23 Feb 2026 17:02:11 +0000
Message-ID: <20260223170212.441276-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If we are using the GICv5 in the virt board, we need to set the
has_gcie property on the CPU objects to tell them to implement the
cpu interface part of GICv5.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1b63338196..1c684b59b4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2677,6 +2677,14 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
 
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            if (!object_property_find(cpuobj, "has_gcie")) {
+                error_report("Using GICv5 but guest CPU does not support it");
+                exit(1);
+            }
+            object_property_set_bool(cpuobj, "has_gcie", true, NULL);
+        }
+
         if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
-- 
2.43.0


