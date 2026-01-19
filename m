Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49ABC9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhcoR-0001vh-6q; Sun, 18 Jan 2026 19:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhco9-0001gd-PI
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:50 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhco7-000153-Rt
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:49 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c46d68f2b4eso2312315a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768781266; x=1769386066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t1AKGUHId+INksKwIuaGKrCnb0t6iZ8w+RSsmvmv1xA=;
 b=jQ0+yZrbmj3tP1IQpPBG6gzwurIkFwcFB5hPIEF7eIzWGOyDD65raJctJbMr48nxOS
 ORLChM6qRTgMiO3pfTNzphINC4Il9TFepqnsIJ/0ARtLpVNoM7pp9QOiiT8pGf7u/oer
 gRYfQ5pt/7xQJ0njqRQ0xBrDJSEHU19hVoSFHBDit6VbwDDkTiXmixhzXBFkUnQNQTLI
 gQc7zRwHe/KuJneOHCGIiWu1NhkAeWhvRWi1OfmD2u/6HrK8vBIgynO9UcMSbnYCxcJ0
 ZqmvufZG39tTg73Ek0eLv7HNbXHwMVrAzTKGPadeream2+K3VflhyVYhZfp2ghT+iZEH
 4XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768781266; x=1769386066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1AKGUHId+INksKwIuaGKrCnb0t6iZ8w+RSsmvmv1xA=;
 b=vzSkGrCkZ2Bg58+Ynuai5Kaje4s1vqIKgI/B9Z4tpvhqYS6YvxUdLbm24yxrNKccIa
 rtJQtQ6bmi07dhIGEbw5Pi6FyKi6f9SiDjo/lJmmJkR80f/TRj3j0q8/CPMiPRp64SxK
 NvqmxI4ykMDQNU72ddm3TwxNCSVjiEEmkFz4XFxkq1dieFdzqa3u1zPuGr1BqZqcOtTK
 hly6b1s7cUy17TaUB1K1faS7r8IA7HCsRkWNcaeugPNmzXzgZm3qu5hljKZ//Wk6sybJ
 H1Kdfh1WLUp7x0Im3KtrT6+qpcAuCCviC/HtMxb1FgUUSDpxB3Yq/yRAENCHI3iiNSeg
 d5Zw==
X-Gm-Message-State: AOJu0YxznT8+kOGvMFRJKbXaWXS/nUbTJPCfObGMz6e1/4p2bWR4pe3m
 MC3zN7lItBoU9FIHja149qyEUnPYO2m0z7CHI+etrUb5V/KXvd5EZ0HzS8TP1+RpKaYW/HrEtiw
 jLY1O/I8SBw==
X-Gm-Gg: AY/fxX6PvtSV9ciwIMWQ8muK/WoGzmDkTe22RD71i3od7qkj1LpqDNUAkqNPwMEeLkV
 IOHyjtKjZ/xvR1cvVJqmLrCuZk8beUzZiuQ+y9E5hSB6pYQ4wtKN3LqE2xf1kXlBuX9DQMWVjyT
 50V/HhQK1hr6SyAeXLxvLFs2aJYjF97IhE8EdnteuPfhnbyaN71XekrvqBpQdJrD5LaUoKfDANJ
 aSVSQsm2OXxhwhvLfXkTuyjhXjsLcNB0FFIpvrrL7el609QeqO2uGZpuofDBIgKhAttimheHAUa
 hlilFMADrb7n6uTZglA+K0wmt7Q7wx9rQBlPc3HXcnXO4zSjVVR7bBj8hUmeVHCDxzwKYBBVjO6
 UamqDsKWAG0mY/gVE3y30MzWSz4//43zvEtkilevW7svBbj033h52P/MPc8bq6atpkhKABVEyFl
 76xafnYbFpt2SpNRMX+g==
X-Received: by 2002:a05:6a21:4591:b0:38b:eeb9:cba1 with SMTP id
 adf61e73a8af0-38dfe7d6dd6mr7304984637.42.1768781265751; 
 Sun, 18 Jan 2026 16:07:45 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eee39sm74872145ad.45.2026.01.18.16.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 16:07:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH 0/3] tcg: Lower deposit/extract2 during optimize
Date: Mon, 19 Jan 2026 11:07:37 +1100
Message-ID: <20260119000740.50516-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The idea is that we can do a better job of lowering once
we have a firm idea of which operands overlap, which are
constants, and the like.

The first version of this was almost 2 years ago:

https://lore.kernel.org/qemu-devel/20240312143839.136408-16-richard.henderson@linaro.org/

This version is fairly simplified by not having to handle
TCG_TARGET_REG_BITS == 32 anymore.  Some of Paolo's patches
to choose and vs shift could be incorporated here, but during
optimize instead of initial code generation.


r~


Richard Henderson (3):
  tcg/optimize: Lower unsupported deposit during optimize
  tcg/optimize: Lower unsupported extract2 during optimize
  tcg: Expand missing rotri with extract2

 tcg/optimize.c | 257 ++++++++++++++++++++++++++++++++++++++++++++-----
 tcg/tcg-op.c   | 174 ++++++---------------------------
 2 files changed, 262 insertions(+), 169 deletions(-)

-- 
2.43.0


