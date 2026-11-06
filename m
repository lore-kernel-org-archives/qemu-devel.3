Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918E606A32F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z1DQGw/S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMZ4-0005vA-7Z; Fri, 06 Nov 2026 11:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMYy-0005un-36
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:13:12 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMYw-0003f3-IS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:13:11 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b33a08df33so7030087b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793981588; cv=none;
 d=google.com; s=arc-20260327;
 b=JquKke1vJmnRIxN8NYZMLV36PWkE5w82LvV34nSi3ASEx5jFMPxqu1A0hDT+ORx1l6
 9BjBFm1Dd69Ppc0GhY+ZbSEsS0bF9SyR6idOxxTqlWTo6OmYuOKa4v8OmQmykey2WfDb
 2QWIqfF+DjtbuJK7fWFaLnrFOanf18LPJLFA9ktRnxaaLbAP09T1lnptQTZritbBV0Ei
 wLxSYUoKI9ed11+pU12HbNstlL8CUo5gYRJbDVaBqU6rtxQY3Ff0xq9B6bwAFbdCQfrl
 8Naql4vuGyM7SJ1WMZenubOFbMBpdKxX+egXZThT+IP/bcET4PjgXrhG8eWZectAM/H2
 pIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PD4Qb9YjuBa3OtZ91nPTdzVKAhegfQZa11FM3l7Pxq4=;
 fh=5317mX6oGDg6Sxarguik4hys36RBivYPLmpzofA2CWw=;
 b=ID9CKITwjn7FiMMJaP/EXJvfrbZ2wIDWf3wx7n+qSTaTrfGBV69y0oaFKI5ZG7wEB8
 +YyvDADZBeueylhy3882sl5Y2mVTM/upnGBEEbGYhQBmXF8XIYaY5J/lW8dnFkWJH4R5
 fcxikzd+BWTYLvo/8AfgLscA3kmwIBxN2VfS8n2aMJiqg5k7wSHeIQ3F7FcBOHohcD5S
 +r9CaJXWF8j81FuFlgoDuAOQCb/bjOZO2xX3a57wYUTa0mEglYRWE0YhOIT3KhZXBRpT
 gIYd0gvxnPyryMu4CH7HIT09Ydvlu82SJDk8IRBG6vO4u1rlAtmSM+9JgPgSKxaJK5Eo
 08Zw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793981588; x=1794586388; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PD4Qb9YjuBa3OtZ91nPTdzVKAhegfQZa11FM3l7Pxq4=;
 b=Z1DQGw/SeRMAwLJ0KyAHFJ23jAfnH3UbXun1JzrZj2z+HguVXsGgGVb0RO480S0a/w
 woWIT0+EXLY2zHLl1jofrLHQS8bT8v/77+XaLSAzUGswk9mUCA4qsHtZknig0mvIqPFB
 xm5FFhVIoRD+BcGrHtIlmMKY2kz3jIKIUiCRDjqedUCgJIKL8i4BItozTBm0sZSdosgB
 m7ITcesoyUqUwo8mzoAogKlcRcwFB6ItdgBnFFA2scd4WqAGXRdQ1NCSxrj+pq3tBwm2
 kKMrH2TO20b4nLp/cPdxp4e95R8j7tJ/Mll+m6bJR/EiO2EfJz+5zAmf9rZlvkAnCFLO
 8wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793981588; x=1794586388;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PD4Qb9YjuBa3OtZ91nPTdzVKAhegfQZa11FM3l7Pxq4=;
 b=U/fUbNpio+ckCh7vl3Y7Zrru8SlzwtWTj9B7Tqhry4vh5b1kp+PC9g97eGyMn/py+F
 ntiSzGVCqLiuMiUAGfcT652ePSAtS4FsqO4ea6DNcILtm906kFxD/63e0ftMm/KyqYnO
 c5EmLIQQEHDjql5w+A5Qhe4ovdDfnTkcuci80SJuEQnxXCIogVkwU9CWzUNioIYkm0XP
 BG7HRCaLs6DZdqGSrTdVvqMl8kQJqfPjkcYsFp0HRRvx4wqOFWrHUh75CenK1vvmtQAo
 zAh9yjGwU2P6sDB8834+fWnRJel1X4pKoM40M73DeFFmCJ/1YxhPkW5RkwFG4mIMtc4E
 UIFA==
X-Gm-Message-State: APuU4Z9pokJMBRrzU5Z9Gxx0MrAKSr//WgPipoL1+uXhujdrFZS4dKpV
 NNItteYgmIf0/UGMPGPChd+dv+fgUJXFeJYPjb6VlEttu2SnNeG+Qn/xHy8UzjIE4fuvTYKJhqP
 0fFkeTVux3dHSArrUeW9NnS4H0O708yrju95WCG/mqjqYq2bix2qwwec=
X-Gm-Gg: AYBFou3a84NVgIrNLV3XMSYgHRv9dQ5bQ6sY1LoRowqYH7Hxnt6OmxlfTp9w0lbK4hT
 c4bkPVS7y8FZTRTZdTyeDBoMlre/N9qdhz1s15PjCNjyieAqb7HB3UCcqhr05VLkK6o01+EMzzn
 uLisDMvJzMuEIOs/gyLx0lMNH0+vPQgjvbW1v5HadovX7Brp26V2rwH5J4ci45kEQtmxFnXehRN
 e5FnKaV2fvChtkQkNU97aJCkmC4UzBNu6WnjoggJe1Gz57JubBLbveDtQs4kAd/XOIfc2ZRBTFx
 CjhBN/HUD0KkN1EjIXvsM+t4ycSaaQU/P5DhnOdXsSn2Cw6pwBdvpsjz4Vw1jIqMCKCFmawYJ8L
 JOwYUqY1gEL+CRJM+ood8Kdj/y9hio9oFJzqQCcmIDLyefBd+y4WWeChqGqwK9EjxAl8wHHAWAo
 x5fdmk8t3SETUjqK//IwzKk43kLwXrZhRBxqAfjGPnUQ==
X-Received: by 2002:a05:690c:9502:b0:8b1:60a0:c311 with SMTP id
 00721157ae682-8b341b50672mr13124457b3.33.1793981588183; Fri, 06 Nov 2026
 08:13:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023084624.1063258-1-peter.maydell@linaro.org>
In-Reply-To: <20261023084624.1063258-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 16:12:56 +0000
X-Gm-Features: AclHuK92_Ky5xglaAwzid8UwbgIWnnIDwF8FigR7wq2crzYf0VDfT1QM1bcAeWo
Message-ID: <CAFEAcA-m9cLAOe8GhjKY35V2SX=pQCofJU9zwTydG77S=jCCVg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/hex-l2vic: avoid shift into sign bit
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This has been reviewed, is a hexagon maintainer going to pick it up?
(I can throw it into my next target-arm pullreq if you prefer.)

thanks
-- PMM


On Fri, 23 Oct 2026 at 09:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In fastl2vic_write() we do:
>    val = 1 << (irq % 32);
>
> Because '1' is a signed integer, this can shift into the sign
> bit of 'int'; the cast to uint64_t to assign to 'val' then
> results in all the high bits being set. This happens to cause
> no visible problems because l2vic_write never looks at those
> bits, but it's obviously not intended. Use 1ULL so that we
> do the shift as 64 bits unsigned.
>
> Resolves: Coverity CID 1685261
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/hex-l2vic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> index 736f1be3b1d..89b44200928 100644
> --- a/hw/intc/hex-l2vic.c
> +++ b/hw/intc/hex-l2vic.c
> @@ -381,7 +381,7 @@ static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
>          uint32_t cmd = (val >> 16) & 0x3;
>          uint32_t irq = val & 0x3ff;
>          uint32_t slice = (irq / 32) * 4;
> -        val = 1 << (irq % 32);
> +        val = 1ULL << (irq % 32);
>
>          if (cmd == FASTL2VIC_ENABLE) {
>              l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);

