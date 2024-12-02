Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EB0D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Yh-0001cn-8b; Mon, 02 Dec 2024 08:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002yI-A4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Z9-O2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434acf1f9abso38913225e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145296; x=1733750096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xP+uJ24vDri92uzeME3QktEyDQnUmbcE3e8V9D9jklU=;
 b=uoJr4Pxsuioj7APOYOVNhynhdlE+cBB2E9DQdD+OpLJVLJvM6dstHOenJbEn+pEAGa
 4+xfWFrNl8D4g2+onxwdi8/Is8oUIH3IvlrQTxlJB2FtjeWvvCuOn9QXyFCS+lOjSNLG
 PK4M5oFggacKVeJCk5A/7UtSRaiyyAJZOQtcmIkCH8LZTE2M3xAcKDLk/xw5mIIFk2IP
 9gWNfW9zDsFlnOgpvnaAJE2TNrNP7ZPw3w9okXGSCb7FHXYPsfwY7+Zw26CRj7y1uedX
 tg9dVfIDOjlZU31SvUwXCIO5XioXivmXH/ZTaEmb8kVgnEmalrI7636GE/AelOV5w4ko
 9tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145296; x=1733750096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xP+uJ24vDri92uzeME3QktEyDQnUmbcE3e8V9D9jklU=;
 b=UR+RsZzDk1S8CtwGsNoQnVcV0Z/uOBSBKscqTym+PTfVftutyHODT8YWb0IHo6ShuP
 67X1FPXYWOG8MG+zg2d93tn+oY8Ls7E9UaGF/4Vx0o2LFUi0EBWZU6l2MomfNLZph7cc
 PWbSCRfrij9Dwmny5zoPN9X6x6VPJWsHtkc2aQcyKsSOfqIvw8nHuNW9R/+XBxPyBH3Q
 SZa0DYO/RYLLPBoe3PvR8Xl81Ie/fRIL36TYpj3L+9c/CjNHayqHWmvugp21+XseLNlJ
 kJo8nyTsF5Q77cJtdZmU66+PZj1erb3mEALMnknjEqBZ2SmI1RBoXdORojTzyeWfDW9k
 6+ew==
X-Gm-Message-State: AOJu0YwOgvo5v2eL+yOR9gHEVfV3VZhcS8UJ3RgobFGMGKxhDSUUuWkM
 P3cri5t3r/Yxh59X+h2G+gAyLSHVi/J6ndxrs+cvtwK+Ix9qw6HrquFfh2/9F6gzWBZOa1RnOxA
 M
X-Gm-Gg: ASbGncuV1WVqTl7ocCxuK9WY2HdJ/5TwrPSazUeZ8mNwdKM65oDu1g68VutlrDBcUG3
 BvER6EK37KIJrv6H43X+8L0j/GOi7RuUyee3eXU2n7fb3pt/1T50u73sMyTjsi0xBD6kQYTTCfD
 /o8EG2cA/Xh9HQ6MNd5ycnPwKxmw89dKsaO6RmsGOskA99CxdkEZ690pVFfmdCuEGGiJPJl87HG
 Cb4T1g5yqbiXk6/wpm7SlX2jOndu/cBSQAx2fID2Y9aHKj2gF49kqQ=
X-Google-Smtp-Source: AGHT+IEbVKa+1D0aSwF3c5B4FQEXLP0C054fxwlcC+LFvDe+s/IEpdCVQQDQPOKB40nkSfuA52KqeA==
X-Received: by 2002:a05:6000:154e:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-385f44a0eefmr2327929f8f.41.1733145296363; 
 Mon, 02 Dec 2024 05:14:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 50/54] target/xtensa: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:43 +0000
Message-Id: <20241202131347.498124-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Set the default NaN pattern explicitly for xtensa.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 3163b758235..0d4d79b58b4 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -136,6 +136,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_no_signaling_nans(!dfpu, &env->fp_status);
+    /* Default NaN value: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
 }
 
-- 
2.34.1


