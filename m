Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29E2C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYd-0004El-6x; Fri, 24 Jan 2025 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYE-0003hD-Oz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:59 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMY7-0005OV-Fs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:56 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43635796b48so15503355e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736129; x=1738340929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VV3/bjL+L2GYg3BGKCSiBTft5KK2gRABV/uDNOnPfr0=;
 b=r+ltMcYYV7BisqC7NqaVa+pBAejxm0grKgQghnBWOxH6V/SeIw73NVAY4JXgcJbT7j
 Nrh5354ZQ6IF4kPZ7dzz52jHyecbXNtvwJpb3BsQ9TfGNNSVZ72Ax8rCxqf1w82kDj/l
 LkeThlijJdol3XEoZQy1Zwx408GoTCuzN9b5SIeyXJIYljymmsjZswkdrJPk6LYtFEMz
 n27HAQEPRDVzrmbczu/ZicTyD8yMVHYvx1tTJGUV2NmwTunYbQT/8oDdtLUXfWcYQy0Q
 CfST1LJoybr9jSMo6TOQ5CZAvF/vvv9Jv/uNTcNmADHNi3+3Rt51SjH/9lRW1DZNMHgd
 np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736129; x=1738340929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VV3/bjL+L2GYg3BGKCSiBTft5KK2gRABV/uDNOnPfr0=;
 b=SjNsb4lMjM5OwZUK6A0+Agsrnbo8wRQCgWmh32/XqZ0Lfy9shnDZxUr1XSzrlFYtn1
 w3Q5Pcc7B9bhiJuG5HRhwcveIDVDh89KqQ0G74peab5TQccgD7U+i6jwf87P9MR60sLX
 ydpRaVLcYvDxWJ8yLhjtrMosj8diHXoZjBnc6VhqB7QynhwRxbs3JUMiqyGqtXs5bav7
 wkLHHDayg7KdHgAz2/TU/szrZVVvATzs5jpsmxMWrzS5A5UnNmzvb8o79xjcYUjiQAKD
 XU5P14eG8XrnjgLU8VU9TjsAgs2HHEaRZK8FBVbw45aX4q4+YrrvkSDRjITqCFOThLW3
 SGRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS1zaDWs4jX+z3d9fY5TOQVxeDywKS0NtFZjXuwri4LGDukXs0Iojrqoe2FPpvzz5fE7Lk2GHiFkVy@nongnu.org
X-Gm-Message-State: AOJu0Yzpjb8szJpKeeUeRZ1JMkhNJLgHxI0BYaWMSHMQu5jsGjoUNlVE
 cHZBAAVWxVnrxI0rHxDsS3mjydAj8ComNe4d6TUX/xFI/s68UKVPiU5j15PUojw=
X-Gm-Gg: ASbGnctMK2djNG7xY23djmRW/a3GNvHyV+GRKE2jOXn1pPrQ7QU1jL6awQgQ+NhWWVm
 Xs+UkL/ktKDBvDGYFCSXSa4NoeH5489J0kBH1vt6xwaSl+DuWo4HIDPv1Fce8S2xw50H1q0BnfJ
 9UoV94mhOYlbK6YgvErCPOb1g6WqNCyKodSfce52OwAMHOe0HzWHsHF97GB/BR4kLxuQ8qS/3vl
 HJ25OW1719vGAIcPF6ner0D8bNVqOgmcK7UgPaEYcetAbJELeF39wfs4Cr3D490cNBfVikDdCM6
 e5VTEGVrhLc=
X-Google-Smtp-Source: AGHT+IFoeMyckCrxiOWwwShM978drFl2M17PVpytmthFnhi6xGEjjHz3Wd9mHJ4CExPD1DMNh3BpXw==
X-Received: by 2002:a05:600c:1c14:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-438b8841d5amr75426785e9.1.1737736129298; 
 Fri, 24 Jan 2025 08:28:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/76] target/arm: Use fp_status_a32 in vfp_cmp helpers
Date: Fri, 24 Jan 2025 16:27:29 +0000
Message-Id: <20250124162836.2332150-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The helpers vfp_cmps, vfp_cmpes, vfp_cmpd, vfp_cmped are used only from
the A32 decoder; the A64 decoder uses separate vfp_cmps_a64 etc helpers
(because for A64 we update the main NZCV flags and for A32 we update
the FPSCR NZCV flags). So we can make these helpers use the fp_status_a32
field instead of fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We could in theory make A32 use the a64 helpers and do the setting
of vfp.fpsr NZCV in the generated code from the helper return value,
but it doesn't seem worthwhile to me.
---
 target/arm/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0671ba3a88b..034f26e5daa 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -373,8 +373,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
-DO_VFP_cmp(s, float32, float32, fp_status)
-DO_VFP_cmp(d, float64, float64, fp_status)
+DO_VFP_cmp(s, float32, float32, fp_status_a32)
+DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
-- 
2.34.1


