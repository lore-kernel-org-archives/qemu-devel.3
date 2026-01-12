Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B3DCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoc-00043l-KV; Mon, 12 Jan 2026 17:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoW-0003rK-2o
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoU-00046k-GR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so66083695e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258505; x=1768863305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qcTGsVHDaBTx/cy/A49xf1mB6DXl6RRXDBGl281jJNc=;
 b=ZHtFPX5C+EeppywWO5Y5cS98kMkIiXzOaftN7hvCWSmUSv5FYsk07+nIQq2kFTzLk5
 32ksb++tf19MSByEHyKCoEEXqeABhEY2POAcKt9xJuonlfIHHxQnuPo7ih9Nm5nBNzZX
 EyCPxy0wNfTqSRJBYUrN3G5oBFC1F/XtIWBvFFKRWrygg+Kp14k4qOTuDyDuXlnHSNuk
 lRrSwkikkI4wG3ymu+ObvTKIZ1KzV3P1gLcxXPu+1zHYf/JQJEwcGPjKhKrFW1DLV57W
 C8ta4sV1iWu87JJDrP0KLg7G8BRH2pOlBiUM5l01q3BU/zri9S9gj++x0PINw7OWo9e3
 bpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258505; x=1768863305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qcTGsVHDaBTx/cy/A49xf1mB6DXl6RRXDBGl281jJNc=;
 b=eFwPQTR7vo4Gv9TS428SgfUZivE067AehYenZZr7JWHfR0AKmSIlghUqQ/Q0VJRXw0
 7r1lqp/mhI23TEhatT0WG9chRMJh/7L9cwke+hnFfvTSCKLtKAYYUqT4OKDNlPaQI4vb
 HkaDlkjM/PJ7hWeG5XZTSCq+ATokV/nMAaB99Bz6ogkHhSdI3u+Wkm98cjDez4DKrGQJ
 scR54XZw2A7m2OaxeNzaw7QsuB/TiW4Dznj4Q5zFUB565zaus+5a5JCoNoF8tRswSN6o
 C2dKTi1x3XFXC2Crj/ZY+jTIjQCRS4o1Zzt/jaU93mHRceBElWLzBozHgJNOh0wMuMCV
 +nYg==
X-Gm-Message-State: AOJu0Yzjj2YgPtxVfgbnnQG/UeHidmYdUaFlGPUciZTcwS1xcxz25cPj
 A8QMtBxjmVS1DPmvKlgK2iqSpz/29GEiQQCaF3J5hVubEybOKFWiYn6tPzHaXib0dDNZugvHi3E
 dTX3DbsA=
X-Gm-Gg: AY/fxX5NXlb1s7t0eyGxzmwKCn7E61CnPFFIYKmQeT97UE23HhLxTdhBpdsWHz9uBYp
 nxrJD+omeJDRcvfBE6mcjyLiC0BRrYCtkbIlx9ZHZ/7kHP4UXgsk+hGejHy7jV4wTXAzbyTL5/8
 Ddtk/+pK/VjTTeR3Z5QXDuMB1F899TY6sSHgZhkMpeeMW3y3AaU+ZKHb+9cjNE8YkhXxMNXbguR
 rc+zE3eV/azYZQ5dy0mJSaMLdmyHZhYZZTO6iAf7y6ZTUeI0CnQ6ifsVrBSE7QTk63481FdEvRN
 HH/UEf6ujcri2oypjs4bomvFTsUpmrVlpYgOwK9gUqz1Ev4DLVU+pHj1KbZHfF38g2IFG8L1m7P
 rIcTQfFmls6Avh6a4B+d8TH3Up2XhZ4TNB/xeUtym1UHef21M9dfJwpC1dlI+YFrcpcuqHKnzLO
 JuDuPxh8kauvBICZjXtmsF2mU4TXqJHn+zBZPht5eI+dCrHJtcWQl9C1ZdO+7L
X-Google-Smtp-Source: AGHT+IEDaR2/3/JXXAsSHaDflpV1qrpYY2UfdOUCVVFW3vZ5GQNRDAtvLeZkjM3yMDYlaq4MXA+tmg==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47d84b3b9e6mr249600845e9.23.1768258504566; 
 Mon, 12 Jan 2026 14:55:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm394107705e9.9.2026.01.12.14.55.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/61] target/sparc: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:48 +0100
Message-ID: <20260112224857.42068-54-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162642.90857-7-philmd@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6b599b71fe..1a7e5cc3d73 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5743,7 +5743,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     unsigned int insn;
 
-    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
+    insn = translator_ldl_end(cpu_env(cs), &dc->base, dc->pc, MO_BE);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-- 
2.52.0


