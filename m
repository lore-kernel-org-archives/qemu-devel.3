Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3648FDEE2C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSn-00013T-C6; Thu, 23 Apr 2026 13:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSV-0000pU-4o
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSR-0005OO-VW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so5585309f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963798; x=1777568598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO1pyTnO3mNIJGKSVSSCAJig7b0z6dQMkq6ZqngmlbM=;
 b=KTbvI8z2INyBy56nkEKkhQt8hCJrJYsdcsQCz0BwT0C7NHt6z60FLw5LiJbzuPGE0Y
 ChJbkSWGg1K5YTSshpC9akpMjjZqHAsrqyphDGIEopN+mxHN/CBfh3qLCTBmzefx0KTi
 nixIkULlii1BC3rT/rkND6nxw7tTB8dhn+Jln+i9fV9HPxY+7X7gQIrEq41d7hwwvI3M
 K/hyRirYXnl0vfgS/CqTjdfYa/Mtgny0gV6nUaV/ZbW/aqWYswkpda9gDZProL7gIRjW
 stwuA881d+K0wQOiOO3JAjhZ+6GX5m7P32WjS97tqTOXCwd+X0hIxFndeduse8tkVGwY
 apww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963798; x=1777568598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TO1pyTnO3mNIJGKSVSSCAJig7b0z6dQMkq6ZqngmlbM=;
 b=SAaXUK/t3BH3bZRo/owWiLoS04P/NAubWF76rBtl2bQ6uaCt2iWt1gMj8SgpU7QGQE
 SDsKIeU6epbwYWmUlwtQV1cgnQ6BNLOABDYbzGH7OWSPx/QueNIsnIB6lK1bClTKbr22
 dO4bMwBrbaij3r6mjyQA4fHz+S8wDOu/IzUCTQV4QK/WAbo/QQJAe2JU3ZoZrSkqXiOd
 7h/VYaW/GIl0BpQGkvqQBd6HlZajgWiEGeMTq7jgq5x3DcYxDna5ZOxgaPrRtdsWPAdb
 WSH3chfLVAKMbfJwd7HyIR2vR4dX+EzP0sihEKYI9ORr1hVfcq0tFoq6oJMCSMKj1Pe6
 gBGQ==
X-Gm-Message-State: AOJu0YyHOEX4k0Pug5jnwO7v8RxDJJNhvaTatOiIn94As2XFYuB72uY0
 1yM+4/u8xmBRVDQtrCk2YTIqjhXyowpKshs+TI2mFZ+PR3P1EV0qXkgg1/ewihPEccqfXJt6fPI
 coNzneiI=
X-Gm-Gg: AeBDiesCpUB2WF8Oe29acHvJY3uVRbdoWcmo4hcGS/Rpl/kh+nlO4XUL74bLJDqdMIA
 TCTA89NL3fvc8NWW8r5FknoDp5TNg1RsFGAcU1gdUk5Y0ZShX5RKNdWH5e+KllgT/YLYbv1LGf4
 T6d95OWF85MmQ+ODs6Pvb32/BOYWpzyKqJk7B6WPiP+cQqPmsYq6BRyZtD68SsQMOq/MC0QbPBq
 TZrJ5DHQxqoD01SSKE8UIchNqSMBaBqv/zCpdHbRFxGodP2vQD8b4pV5gpGIDVo4ZupV96oBx5X
 sZ1JlaMyC2dk135rzLUOEtiKg4tAlHTYj7iI3RbKr7vTq411OBiVOuiSG9KyKvL7hur399c82SN
 mS3YVxXIDPeFpkgq7BGmced+oBySTRidiUjTi2hNNJgqbE0mzzxX4nRDc8JAHCCa8Twf1VXtgv9
 jW8ZUD13yYe2Bpo6kQnOqFMm0h/aF+taNYuK/WR0DByb/2NuqgM5knc4JwNNIro/r2GO6/N9jpR
 KZcpXJEjs2j7q9Yan7vvA==
X-Received: by 2002:a5d:5f89:0:b0:441:1c95:17e7 with SMTP id
 ffacd0b85a97d-4411c951810mr24411525f8f.15.1776963797790; 
 Thu, 23 Apr 2026 10:03:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm53790415f8f.16.2026.04.23.10.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 06/16] system/cpu: Defer memory layout changes until vCPUs are
 realized
Date: Thu, 23 Apr 2026 19:02:18 +0200
Message-ID: <20260423170229.64655-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

vCPUs are not really usable until fully realized. Do not attempt
to commit memory changes in the middle of vCPU realization. Defer
until realization is completed and vCPU fully operational.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 4e26f1a1d42..091a1da3458 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3089,6 +3089,14 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
     /*
      * Queueing the work function will kick the cpu back to
      * the main loop, which will end the RCU critical section and reclaim
-- 
2.53.0


