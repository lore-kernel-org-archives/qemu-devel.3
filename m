Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F5CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnHX-0000NN-S3; Mon, 20 Oct 2025 06:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHW-0000Mn-JB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHU-0000DF-QN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so989233f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956702; x=1761561502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eb2zFhHkdjNt2ehW35HLRPZBhm40gE3e2lVHvPQ87tw=;
 b=rL+GHqUGmGbN7cXaH2dT5s5lGD1YZQyDmdg7wNh2xYjUpW0iMBJUU95Cz2JVjyrbrs
 chX0QUKW7Zt4HQ750+79tGxt+OupFqgONxpJpNTNEHuJfk9LayfrQHiHC2bFFlJcWUxX
 OrVH6vmN6DIoAymir6LesXDKtqLF7C0ocsHfd3kkc2Kxywj2Ry2R4Jlgl49NEcl9bb0b
 bA/jVr/PQF0iqtQn1+uM7AY5M5rsufCt/Gq9IxIqd1I4w4PqhrEMtw2I8sxK7Qnbgn3D
 a0+mBV3wJhAhhvZfj6Px3/L1SgDv+rK7QoTnFZ5G0l25cU76T0KrWx8/FTyFf8IDoBkc
 Pxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956702; x=1761561502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eb2zFhHkdjNt2ehW35HLRPZBhm40gE3e2lVHvPQ87tw=;
 b=TYBq+6syLHPv8Qe+fWdh7aqX6VEWtrVHui/P4u6UuoBxQUiK4VP0KsVolM5rE6NHCb
 lWUTSs7Uv142SxWffm1AObgLrV3ydGN9A7aHiKPu2RaeFxoqtWhEC+lus/xr6FYc6M5L
 sWVfX6bsYqLr1q2yoLc8GQPxlTdfepA8HJ8JHwOk7MKt7hNz1oqnGoI4rPg+ggKB+Saj
 XpP/DeYF/GG6kCTr3+vDFnWVgrAsLlMDn/VYbrX/bXbb2ffBdG/bor3duR5eK1JwZ3iQ
 BCZrM20zMOqbUkExiB+E6rxYukG0wORKA5T+ykpmn+PeOhcRkGP6Kgbdp/hgdfm980Nc
 7Plw==
X-Gm-Message-State: AOJu0Yw1M2jYw+dd2LTn9iVUdhEHypp4pTovLplgxHVMCPeJpvAUaABQ
 Yqi38pp2SK5w5S2mcnHSMA2FRTCQFy7LxH2Ct6rJdKOfatNLRhO2zgLJfG2BvQ6RWWgJKxuh9xK
 ZWsn2Ypc=
X-Gm-Gg: ASbGncv8CkWsMnQFmS9zsv00aBZiGGany7kxadhx/TlblF8IOapx4UKd9ncx8f0M8Mz
 /KLtpBc5AelgggOTlqOCk2R7Xxqq/EAqG8O/lffR+1rNxbhW1tx7Xg5w+4CH6pYfGMngfXNp1xi
 b6ZVVxyolBFOACeqDKSpGHmGEWOa27QzcUZI2Ji9xXrWweRGDUKaMgsb6iqg1oED7OMZxQ32vX6
 VrAwJ+ccW81+JZbKtHUEh8Uxi9EG8ZQnoB2YLyVi8QNaKLGVTa4VytK0SYK0058Hw3IAk24Znty
 lA1RP8xIUG9VoIq6tpnDXKWhykCI4gxboVVhBD5lP64XDL0PJIiuyfIu4F80/t1aK77sxUb/4vq
 aGrxLmSZfOgyT3HorV1zGVks44TZnXA3sautw4TRwDVGjx/rADdT9/mT6FSaBxnPrrXANZHObFb
 YmJ7Yj+cAFJ7/iXPcEscrd1rYJqdoJquqHfM8Dabx1IcZJvBgK2w==
X-Google-Smtp-Source: AGHT+IFXtCupIGDq2siVPGNf1Z5WcGOG8FPQCLDkC6kjb+5DMC1Dp8EAQOlPDFoxVNiZGk46JqVF8g==
X-Received: by 2002:a05:6000:25e1:b0:427:580:99a7 with SMTP id
 ffacd0b85a97d-42705809a1emr7079805f8f.59.1760956702518; 
 Mon, 20 Oct 2025 03:38:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47154d382d8sm141032845e9.12.2025.10.20.03.38.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/18] hw/ppc/spapr: Remove deprecated pseries-3.0 machine
Date: Mon, 20 Oct 2025 12:37:57 +0200
Message-ID: <20251020103815.78415-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97ab6bebd25..85c27f36535 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5062,24 +5062,6 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(3, 1);
 
-/*
- * pseries-3.0
- */
-
-static void spapr_machine_3_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_3_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-
-    smc->legacy_irq_allocation = true;
-    smc->nr_xirqs = 0x400;
-    smc->irq = &spapr_irq_xics_legacy;
-}
-
-DEFINE_SPAPR_MACHINE(3, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


