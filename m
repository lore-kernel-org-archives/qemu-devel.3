Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFBAC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwUN-00052s-88; Wed, 02 Jul 2025 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwUB-0004zP-3n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:48 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTt-0007Fs-J6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:45 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so1090780fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458948; x=1752063748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1nwk8IyMWtkFl0V6iMZghwNPUspSshQHOECaZCfwyA=;
 b=wF8KOHabFEG9yww3ZFxr+gOZvlk7vmXq7YepvzL4b0H/ljc3dlz6Yt1wPskzDRGaTe
 O10uxpNjgnvOxUIdRmguKQhUYymMN27/ZG37Cj0jroCSJyCNhEJsNJoWkEtLxpQcS0oG
 zQJyp4e+jjnKuqOAr/YFe6llU1AC2DLHB6ro+YRq2y+o1aAIY1XWyomPrxOlztVpYgVl
 xxydlC1RPqYdLCL8XvolOWe+Lw11KVMf7NNR59lUZ8vMlTcCAsCPTtcnANL04vgYVrTL
 DrF7MpuOqTdvnD0QRgEss8YcBdFeonCfMSDm3dFbJB6oGpxoSOUf8faGMy72owOK675U
 QHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458948; x=1752063748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1nwk8IyMWtkFl0V6iMZghwNPUspSshQHOECaZCfwyA=;
 b=l8VPIR+fsgYed+pqKVDuFl/7yf4PTZ+ZZnMBKvmuNqiohlbkS02G7yAhPIVRXOiP33
 q+zgMkFVmy+IDByPyRDjZhPNUIGj7QRWZCYjNeMv/vY4yy8m6PiM7E+aM+OO1e3BLHTP
 FaylEOLahIrRvVc+6WY9WwkiwSBCFmmhodC+MuGQOFi++I5ZQc/GlpwpP8NnmIE5ZlXr
 3bsbAR5C5QUdTp0IwtNZn4bJPyo9W2H8s0FB4wWlTVQ9aS2q3uHCLXSp99eGLD5wGCic
 J92mJZWkbroZKsh7gPWFb1FDdemBcEJWfXS20uf3fOJxOsXo5dNT+ci9c0sKXQzRsTEU
 dXow==
X-Gm-Message-State: AOJu0YwG9/0mZx9+4YAXBJg9WXghvnV8q+G/oVzDKpUu9+RjCv+2zkWK
 qAwdK7ufavQUCtIslBgZTyFkY7JAxyT1qWi0fYldTf5+lVtd+GUunB8wAb8sB69Pc16EQb+kv+Y
 S4wXfmDw=
X-Gm-Gg: ASbGncvjNLpZOe5fqBVYB41muQMhtVFdJ4ohmg8ELjnVY2LW1iB4vyT9Rw0VJ9uRWHi
 32pSSIJ6vDxonNgs21qBG98NwEQ+AnSkLiFe4wrxCNtkJTn8qbcI+aEFWAPeIVkJ8Et0gfm9PeJ
 dFiyuo4+FaSsq1hQs1rUXpbeHRVSh0D77Yp93KPjAgf5VGOZCSuMIj5zQsW/gxuucreDpSiI6jd
 sFUBrvbrMmI6cODjcro8Yiv37IuAp0GCwRsCbLt8BqWdYI9fa9x9861Y42Jl8e2PN/MM1JZCryj
 xTvKbKKmzStgyRnm3T6enxojR6e87EBm0HyZRhADsObOCs4FU1e2rl5+IJdWf2deU2P3vQ==
X-Google-Smtp-Source: AGHT+IEA1waKIEabthcOKgcQNNIwN2JzYQ7aazMSupnAlWbdbPwGeQ4RN+1KTzYEGY0/9ixrp9U8Xg==
X-Received: by 2002:a05:6870:41d1:b0:2c2:27c8:5865 with SMTP id
 586e51a60fabf-2f5a8a420f8mr2143156fac.9.1751458947841; 
 Wed, 02 Jul 2025 05:22:27 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 10/10] target/arm: Remove CPUARMState.vfp.scratch
Date: Wed,  2 Jul 2025 06:22:13 -0600
Message-ID: <20250702122213.758588-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

The last use of this field was removed in b2fc7be972b9.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e232..15b47a5bfc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -668,9 +668,6 @@ typedef struct CPUArchState {
 
         uint32_t xregs[16];
 
-        /* Scratch space for aa32 neon expansion.  */
-        uint32_t scratch[8];
-
         /* There are a number of distinct float control structures. */
         float_status fp_status[FPST_COUNT];
 
-- 
2.43.0


