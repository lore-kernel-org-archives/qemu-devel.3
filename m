Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB872CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOF5-0002AN-10; Sat, 30 Aug 2025 12:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERl-0007aA-Q2
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERk-00054l-AY
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-244580523a0so28187485ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532895; x=1757137695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzZct4djTFinECEhxm08t9VOK2GZ1btlbs9cto0ZOTw=;
 b=ujL//ZX5dy2DBrZUewb+Wco+q7IC+DIg82q6sKmV3v6wap+n/hz0CUDrNZYO3M5rqW
 tJu8wCw7G+K7dAGxiUjH4I+iYDO5eR6QMPt8XwPFRJVOUxebH5hxSTRFkGh6cnTHcIPx
 sca5RS0xTG8AZF5FULDFqmczqdJWt08qqgnT8sswGDS6N5v6UeiYJnJjVma12MpblVKi
 MEFZmkxMvVutEGOwKTbqcUcCK/pWqqofl+5Fu+z2CmfU2HBW2O35KpqGWxgfOGwr65TG
 TRcPKjx/hFcmnJbaRt7+zUhq45gE5yMZBr5Um4EDS2t1FX47oAENzhtlasUx0j73l+BE
 xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532895; x=1757137695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzZct4djTFinECEhxm08t9VOK2GZ1btlbs9cto0ZOTw=;
 b=okMA2oN/B1g/EnddqPvR95k7pFK91D2MV854M/jdhI2M1WLhgtWBxY+smQMv/wFc/7
 Fj16IZeY5VuaNPzqaOGZGkNZOKBkVd3ePFb64n3SbI5ExxvQzdFtXyF6pMnqdAZxGamO
 5AKDcT6bNncbtrxTWLnCXLMhD7FSkJZkA2pTVbRyAUvfeg7A5waX5z8dfig/7NxlqmTi
 Jo5dqieIJNv0dbuFA7zdA2fB+tm4emlGburx3159sVbCqPAnVdbm0qjPt52XMpBn1pJK
 egwbi8QTfywi4lJNSEyTrqDcmj5zCz5DoJ0qriUpX7e7qw91EUwbJam+ImyNC+S6NXxT
 srFQ==
X-Gm-Message-State: AOJu0Yw5B3b01GQRlT2eBeo8+yB7Z9/qCExelTrkyHIALrhaWx/tXPtu
 D5rt6dxeGN57TiF8gzuw2bw1u2ABmdZgxCA37x6Tm/in0PqghtiE2+hFye7Y3nz7mj4m9sE8UK1
 nf1sbqYg=
X-Gm-Gg: ASbGncsT9HogwDd82pPZXBiyqETPRcRUXArTDshL7CV0zSTu4dwdHfdbj21w/qvNRmf
 NC9ucrG0a3cEPxlFDeerxszvx48qXdFwj6pGXcauaRT1DgEaA8tX4L666STAZ1WeOfwIzFaUEey
 bw62iMIPlItlMaflAyGJudo4r9K1pJ3k27pC3Ff4YboJDISKA6xfEk8378g9VNqZuVeOWy+1DAu
 30CASIHbErT0JnVoyv5KJVoEpFVo1YZ6kslRL+uRUA5zIw2t5Vda4RAxQKfWBxoBfGARoT8GW7U
 3b7opi9kEtLj2OZOm/NKyytKqi1Ragxbf9fhcstIdRvOD+oIfHuB9pVoK/PTKp6XNjrsbaDFJ9u
 yPXqQg8isUBUx7Cb+3KkdQTtNBGW3PM64T61IFU2nRVLQ1e3zxt3HWJQ21ogYi/I=
X-Google-Smtp-Source: AGHT+IHpeDjwV5Bw27g3dn1AQkU/Um8wLUCAH86KqgCnVlqEv+7GOBtpsDhP8gnaqAdmHuX9as/hdw==
X-Received: by 2002:a17:902:ec85:b0:248:d84a:91df with SMTP id
 d9443c01a7336-24944a5c73cmr15620865ad.26.1756532894858; 
 Fri, 29 Aug 2025 22:48:14 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:48:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 78/84] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Sat, 30 Aug 2025 15:41:22 +1000
Message-ID: <20250830054128.448363-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1c2ff87b89..51d1956e28 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -317,6 +317,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0


