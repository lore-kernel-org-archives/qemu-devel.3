Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZHP-0005lF-Hc; Tue, 14 Jul 2026 05:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjZHJ-0005Vf-UI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:18:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjZHI-0006mY-HM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:18:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b7612475so31802475e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784020691; x=1784625491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vugWGtQq8pFEDWT6Zcaa4tHT+CIBMpUoXHLbFhwYeF8=;
 b=hResNjfzhRzsVPogh5hs4XgOxQfNZfkh1Okuy+C6DvRWQRNBj6IfNdoxwgSfLRCtcb
 K8RipdA6HtrIQ+K9ZplUhHwYe8TXvbKTh+nwrGCYqmqxSuu5QAT4hgRzjuSYwzSOkqEu
 jIfTTgHNbgFwhILl4iDiB99PfFnbkqEIpVjZfLJyv5y08UtZ/uaPYFnjJw/kkM03tcKx
 rnlKWryntXGsrDp9jr2Y0cpDXU4E/ZN+5zoK+BWKaiw9EkjGdecfBt1d+f8SBeJEUyQn
 4Fhjir8N4d1SVx95a96dI9KyUpP4MpTiMODhaRfvq23ju28hZ8f4G+DfH8+KxytB+J84
 On6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020691; x=1784625491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vugWGtQq8pFEDWT6Zcaa4tHT+CIBMpUoXHLbFhwYeF8=;
 b=EhYoloNzIVbD1L4Sdquih9CJcM8/b1+whSF9u8q8dG6GZzjcMBzHxbpK4rNqbM7UbH
 r16Z+jgSbLqNxTdVTwUIwNI2r6VfXErqRCdqGa5BDsHGvzmQn1d4a89Qta1cz2WfOHtH
 ERBtx33FNnFB8SRncPKb+Cee/LQGJ0Zj/tIBCV86t51HyUgezTaeUFjIXBK1+cp9uZRk
 afKR3hXl1oXyBQgTxE5nGQ4IEiSpJzNNfAyNtlNMi+VGv7JSrmvh2+w6A/SSJIr0KSNL
 ukxs4u6iZqSPLbFDeCzpfIbqpQcGCA+Y6jo+qa5hAaR/s++3N4i22qi1lRPHzX3mbJOD
 Y2cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvrNW0KPDeoUxFj90t3AZRjzeBo9NV0h2depBAhvUNXxuJjVKRB9SDvGX/5szU4OIEYs0qX9MrHtkG@nongnu.org
X-Gm-Message-State: AOJu0YxAGTM7rdwLuIf3VpefjORQt9skTRXltV0ep3NHXkCgGPFB5VS3
 dLLCoqM+/pdFnLnY5ysZ0F/KG5pF6lvydGC1DuHtH2qOE7525I6m/hWMbdNMN7XBWJUr64CEiyf
 tQ3ua5w3CbA==
X-Gm-Gg: AfdE7ckchnluvzbeQCqT2ZwXLJnmkMQ97cjwrJfxyQLrWakLmnXiM1z68vPGTyq7M8a
 lQgpbvgUPrBK/g8j/+ykpY2ZMAU81Rt8L5dRZDjlH/G5XVPkT7tDk+8NZKsZ2yxzOm/QwP6bhYz
 gde2k6/EtcC0woQCD+d8wiUrSgjQZSmJjs9ZXLgdxn/VKxH5UDzA2Req1Z/F7N8gzV0w8Evwh6f
 jlZfQs4CY4OiYQXjb4uj9lIiYAhk9DgKazKWjyeE9Xb2FI8iWqa+UGAcRPf/ctcEZy7EiHe8DOM
 xeBPe8Cr87pW8Bg/KBYOSwyPG/ccW9z2PQYqiITknu9Gsu1DCetqxwMYrtJqL58NmeYqwmCHC98
 /41rU9R4Va8RxQgPdT7RSxJdo/6QXkooo7fjsCM60USrydomkB+UPX7mtWTWDLER77+OyVNmvY8
 qsud0L5RBcLOJ0rfsLoyuETUsW0wZGEbtARM1LGYu6oevC7jWkh7hlbpf1/RvzHUfWlRfKPVoCN
 DEeaAGVP5BuFMoxtFKaWA==
X-Received: by 2002:a05:600c:1d9a:b0:493:c535:3934 with SMTP id
 5b1f17b1804b1-495384a43aemr22224705e9.36.1784020691032; 
 Tue, 14 Jul 2026 02:18:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322bcbsm69927185e9.9.2026.07.14.02.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:18:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can change
 IRQ/FIQ
Date: Tue, 14 Jul 2026 10:18:06 +0100
Message-ID: <20260714091806.3568281-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714091806.3568281-1-peter.maydell@linaro.org>
References: <20260714091806.3568281-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The ICC_APR_EL1 register values change the current running priority,
which we use in our calculations in gic_hppi().  Changing them can
affect whether we have a HPPI, and so the value of the IRQ/FIQ
outputs.  We need to trigger an update in the register writefn.

Fixes: 9bd90bddb79 ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 8e2a08fdb6f..a6e6c440849 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -495,6 +495,7 @@ static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5Domain domain = gicv5_logical_domain(env);
     value &= 0xffffffff;
     env->gicv5_cpuif.icc_apr[domain] = value;
+    gicv5_update_irq_fiq(env);
 }
 
 static uint64_t gic_icc_apr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.43.0


