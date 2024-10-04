Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259A3CF8854
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 17:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmZE-0002F1-8a; Fri, 04 Oct 2024 13:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swmZA-0002DK-Sx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:58:13 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swmZ8-0006bv-NY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:58:12 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso464372566b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728064667; x=1728669467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uml7o5xPPexvJTnvPBC1eXY+yv2rWD3mcFHFe+jiAhA=;
 b=cA3YA5EVRbmC9X9ZMZTbxYuQD69v+WT50kKlmxIYjJ1K8sl4yFJjBUKxAFSDyMqE8+
 G915kZh7UvUTEm2vvCW0Nk2dNYGR9domppblYVAk8npqyc6tNJoKKFlApVDk09SvoCHu
 po3W5gOil2Ar1dR3WB0L6T42TEuJMJnv2F6LXuNwhYd08DOF1be4GETMiPsCrQmEVvWa
 gKGNaPHAgpCCyi9IjjngDWQp3JJv+bFr00vjD1UJLn7jFKAL4s5BafqxJLYRGhSLgBdM
 B0xp4U/ZH/vaqUKTxTZP3WYmllPt9aVNB1o5AI6Ba7QqYzrVuDM4m9lDDou/UMY90xay
 coGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728064667; x=1728669467;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uml7o5xPPexvJTnvPBC1eXY+yv2rWD3mcFHFe+jiAhA=;
 b=qM8YfHmkJQxhWg0Uu6B7dUi05I+q+t0io+egC2SjVWeHo6xZaTaWDqtb1p2VqT7l7E
 hPmJXjiUhMPBMGqqzaiL5XyeAFaz9S3LOC1dVI0BkK0PtNBqIwiC4L3cbsdQDu4ZUKhD
 LDXoTeqCryDYojq/fmr6Y8QZAP/QVi+Rh8nGLiIBRcB/YnZ4pFNSBk/DaEPhwPj8ZHuN
 VRE0TnmVo7R7enuIaMSX/w2bFhJ+X3KiGqKdOnDDh377i9YeS6FNf54oJlU4Eq2Fncku
 yYvY0I1BNcnViNGv2v8owuJVEioh6WgzVZ34kgNZ2JP06Z+2CKeyEF3oIbAwNsudm83T
 PNqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNAN154JddWhSG+93s9MM1wguHKmIxPjTwSuttiHXuHFJRyFNebYedAtneFlCRH4rStRlNlLNWoGn@nongnu.org
X-Gm-Message-State: AOJu0YwfalLheJpvGfvBOnJ6bGtS4+xEocCXXHMO7++bqnO0HjBeB5gs
 l3eIN+qkjdRaoN83UnaTpUr6MUgJoZMRkLBgGuNQ5i1F88cUDTZncEHLCfg3NT0=
X-Google-Smtp-Source: AGHT+IGNQlWwarlacwsuvMAbwQEUSjMOA/7FvBUKojT85t4IOkaWs74dqrMKgo71BRsAWBB/V0Rr7A==
X-Received: by 2002:a17:907:940c:b0:a8a:6db7:665d with SMTP id
 a640c23a62f3a-a991cf73a24mr376363066b.17.1728064667363; 
 Fri, 04 Oct 2024 10:57:47 -0700 (PDT)
Received: from meli-email.org (adsl-74.37.6.1.tellas.gr. [37.6.1.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e6655bbsm23307566b.96.2024.10.04.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:56:36 -0700 (PDT)
Date: Fri, 04 Oct 2024 20:53:39 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: Re: [PATCH] tests/functional: Fix hash validation
User-Agent: meli 0.8.7
References: <20241004130225.217441-1-thuth@redhat.com>
In-Reply-To: <20241004130225.217441-1-thuth@redhat.com>
Message-ID: <kuf60.ek3w2mj9njb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Fri, 04 Oct 2024 16:02, Thomas Huth <thuth@redhat.com> wrote:
>The _check() function is supposed to check whether the hash of the
>downloaded file matches the expected one. Unfortunately, during the
>last rework of this function, the check was accidentally turned into
>returning the hash value itself instead of a True/False value,
>effectively accepting each hash as valid. Let's do a proper check
>again now.
>
>Fixes:05e303210d ("tests/functional/qemu_test: Use Python hashlib ...")
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> tests/functional/qemu_test/asset.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
>index 3ec429217e..e47bfac035 100644
>--- a/tests/functional/qemu_test/asset.py
>+++ b/tests/functional/qemu_test/asset.py
>@@ -57,7 +57,7 @@ def _check(self, cache_file):
>                     break
>                 hl.update(chunk)
> 
>-        return  hl.hexdigest()
>+        return self.hash == hl.hexdigest()
> 
>     def valid(self):
>         return self.cache_file.exists() and self._check(self.cache_file)
>-- 
>2.46.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

