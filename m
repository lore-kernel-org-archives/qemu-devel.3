Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2257D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbO-0004YY-4y; Tue, 05 Nov 2024 06:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbK-0004VZ-0i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbD-00077F-JD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314b316495so45502685e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805589; x=1731410389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c8Sl2WdMeznJ3O6Hl+0ANVSekrp0/KXuiL2fAiYWe7Y=;
 b=EotC5W3wV5nQVA1Ke8WpTF007lOMb1cWooXAsyiANAhkKjC4umHkDzBMrzgZgRIWHE
 uBJ5msPmXvQlWzhQhnJ39grrI0UMQ4mn0ApbByFAfIFrtrIehQp9oEfMA5lhiXat5g/0
 Ma78ALUfxlWvoz8FgGjVstqHA/arFdBG3XXA5EN8ZSVfaZ3vEMQEmo9MnA8Mr6XPdTas
 V2Fy+DvROddHLGUOLUTsPejxhMBxH0l4FBJkycYUVyHeIJL9mkVhM6a+GkJOnyLeewYR
 Pd50XEmL4ngFUQPxlsUqOFleWb0A0VmTSwdhLRG1aBLxiaCLd7M1ubW6xbHMauWEOZEO
 bnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805589; x=1731410389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8Sl2WdMeznJ3O6Hl+0ANVSekrp0/KXuiL2fAiYWe7Y=;
 b=rHYCHEjGkv1uc2pigdWC4qh1FPO5cEjxiT0i5UXMCQ7eoJVcNxCGhglgjNmV00oa0U
 m7/182SC4GqmEf1HEw50wUcvFvBxDAfhgeu0r2iH5a7B74cRGT+hFpl6zCNDaBnfaIJS
 SnOgIKvbjyPRnAcSl2ySBV1917XMskmCjGJ1PC8Ubma+3Cy/6WWiJ7bZJZ7omETAKk2D
 TOdntrC438aDzZr8TGstDRm87qkDjyPa2S+HAQCp/BiU0M48/fo+jvviJK/PabNipEoK
 oFQBBn1uinPVbrbnVxf/EedEyPcD0/nHsQdSX4nwk3jzY2gL56zRyCvYlQAsOq1HLBYG
 0gRg==
X-Gm-Message-State: AOJu0Yxd8YqagAehR4RnOKLPKjUT0BFFFlgkXTAKKvdltw6naW2oR5V7
 QukvXcezM0Hoyj4dY6RKK0IkXUInhQwvGXBWKfeYGJFgVT6PPtvnAAkhnti2V+9Wf2PgEoeOzo2
 3
X-Google-Smtp-Source: AGHT+IHeeZkES+0Ju2dE+HLTNR5HPuj11tiMMZi4a6APqWtBjhuH1PkSALEwUqxAWmI8Pc5a+yxT3w==
X-Received: by 2002:a05:600c:3591:b0:431:680e:95d9 with SMTP id
 5b1f17b1804b1-4327b7eac4emr165388775e9.22.1730805588717; 
 Tue, 05 Nov 2024 03:19:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/31] target/rx: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:24 +0000
Message-Id: <20241105111935.2747034-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Set the NaN propagation rule explicitly for the float_status word
used in the rx target.

This not the architecturally correct behaviour, but since this is a
no-behaviour-change patch, we leave a TODO note to that effect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-21-peter.maydell@linaro.org
---
 target/rx/cpu.c                | 7 +++++++
 fpu/softfloat-specialize.c.inc | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36d2a6f1890..65a74ce720f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -93,6 +93,13 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     env->fpsw = 0;
     set_flush_to_zero(1, &env->fp_status);
     set_flush_inputs_to_zero(1, &env->fp_status);
+    /*
+     * TODO: this is not the correct NaN propagation rule for this
+     * architecture. The "RX Family User's Manual: Software" table 1.6
+     * defines the propagation rules as "prefer SNaN over QNaN;
+     * then prefer dest over source", which is float_2nan_prop_s_ab.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ee5c73cad46..254bbd67168 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -407,7 +407,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
     || defined(TARGET_I386) || defined(TARGET_ALPHA) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC)
+    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC) \
+    || defined(TARGET_RX)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


