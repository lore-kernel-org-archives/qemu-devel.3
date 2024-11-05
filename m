Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52742D1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbG-0004To-Q5; Tue, 05 Nov 2024 06:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbE-0004T1-7T
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb9-00075v-Pu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so45658365e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805584; x=1731410384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nlatDknV/aBfEnJ/+F3868r6flWSi/PVuWVtl184IcQ=;
 b=B/i+lgDjbNc2cmEJ78MGIAZA81rNsG+EwUq4Q8nSDOMdFgmwAH/CW9nTsl9SeBxDhH
 uZYN5CWWYwwW/XqpnOtLsZZGHmVxtj6BEnV++CPdO/LlyStqs+9H0R6AYHIJWGDbbUgJ
 tZqpRCIRi3FkQzIdiOHapJxjxJHhnkgcIyzBwX/O3rc6ldsj0Xu9HNLKabs36Srb42uD
 bxr5UOnxw40peZ0ANgm61Pp4RzcXY45u4zP+PykzMJJrLcAvFWo2oOYfKaKRvMhlDn1N
 a4WafbSZSGy/5enSlkgIsnX6ZByMY1QzaZvf0Na7hMvJ6BMbPuYSRSf9eAgRV+4AkFZw
 XYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805584; x=1731410384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlatDknV/aBfEnJ/+F3868r6flWSi/PVuWVtl184IcQ=;
 b=dUgPHArDaDoeHxx5pq76kGumKYUxH1wgpfkLWDI0/CwZ9AgrF60j2fG4DSWG4jODTa
 deFqjzv45FuLX5H9LXDj1/oonfclG9wpEdqhPeZWV6A7V2Ztuk/QOxXeTBo+uh9Ej9hA
 IF8Rk/oVVR6bZHJs1DoksIK7VgLCTO53Dzawg9IDly0+VyyP2gcmknyxBSkNrnzEpZkh
 v3tVBFcQ5hP8A+qtwc1+whd7s2uRmyucsyUcBvfXFXD70ASFMdmxspbzrLn5bK/DAO34
 WuCtQTtmPcShLXdd+Hb2CTul37miOubzy7tL4k0R9nspR3bvtJrqqllCIJih03eCo8Op
 wNeA==
X-Gm-Message-State: AOJu0YyDsluXQze2ec27NcfGZwQBbe4Zyie00fkRF2+cEMpp7KvIPUhn
 kPGtrDVkGD3PRwZNppPtADljEOEUAQzVAjK7mpI+tFOxAhyV2QewnUH3UlFpUuMRF3f3e1FVjMP
 h
X-Google-Smtp-Source: AGHT+IHcTsD95yU7AnMAHWb8g4TH1ZOb2S7iALAhpMQMa4BnVpZwzp85YsAe5NLpVVmM3suXCHLtpQ==
X-Received: by 2002:a05:600c:cc5:b0:432:a36b:d896 with SMTP id
 5b1f17b1804b1-432a36bd911mr16015845e9.26.1730805583796; 
 Tue, 05 Nov 2024 03:19:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/31] target/sparc: Move cpu_put_fsr(env, 0) call to reset
Date: Tue,  5 Nov 2024 11:19:15 +0000
Message-Id: <20241105111935.2747034-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently we call cpu_put_fsr(0) in sparc_cpu_realizefn(), which
initializes various fields in the CPU struct:
 * fsr_cexc_ftt
 * fcc[]
 * fsr_qne
 * fsr
It also sets the rounding mode in env->fp_status.

This is largely pointless, because when we later reset the CPU
this will zero out all the fields up until the "end_reset_fields"
label, which includes all of these (but not fp_status!)

Move the cpu_put_fsr(env, 0) call to reset, because that expresses
the logical requirement: we want to reset FSR to 0 on every reset.
This isn't a behaviour change because the fields are all zero anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-12-peter.maydell@linaro.org
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 54cb269e0af..e7f4068a162 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -76,6 +76,7 @@ static void sparc_cpu_reset_hold(Object *obj, ResetType type)
     env->npc = env->pc + 4;
 #endif
     env->cache_control = 0;
+    cpu_put_fsr(env, 0);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -805,7 +806,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.maxtl << 8;
     env->version |= env->def.nwindows - 1;
 #endif
-    cpu_put_fsr(env, 0);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
-- 
2.34.1


