Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF966070CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OVu59bZG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvVB-0002NU-7F; Mon, 02 Nov 2026 12:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvV9-0002LW-BQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:19 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvV7-0005zY-Gx
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:19 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ad98c3fb15so27412817b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 09:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793639236; cv=none;
 d=google.com; s=arc-20260327;
 b=WG2n6lV8yK1rJsgWPq5+6tNkL3op786YWKGCYHCwLetN96up7RWJDfOeg6Cg2+pag+
 rQ3K4oq3s0pmf3rFvxiol43KxXVyCCGdyCtev6pv7tgYgun3W3NJD/EzehfZvMjVetfd
 24N3GFMJxpgmfs+yw86dnFdZl5NP0ZeMQT1P8MswA2tQVjdpQ54nrlxAnqwwPNCEg2hA
 qAWNTFvsovSqHqZAbeSva4Ea8/sZjH/zkeHET0aR6ewg5wEWJsbeahT3bbOzTUm0kKH5
 3nFq6S10fvFT7d+HJFF9vAhJAStag5EpWYIX4/BDtte5lygAM+/59XwslcckC3TX4gcN
 bWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jpbACo+t6286VTNY4WrR5Jfr75/v+ASeBxYHRk3dxTs=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=Kd9FbsX0Ppe+D+Ng2uxEbMEBnxRMxy4HciM9mmrpPWqPkF3WnKXQgy9XM4Sc13TD5H
 fBbZB1qAlOpGvv37Qs1SyKUgF2og8Axu87yR56JGWJGeVHDJt0F2gpbQtEmaV7zK2le5
 C0AVllsW/5CWFI7Kc/YNRZSZ1HE7PZnmcZQyd2EcTtcaPwdXpSR7jpl1wZSil2Vct8ft
 Rc9g7i9YoC+0XX2HxK8Kjh3EucjxBCG8Gx/2aXtGBEkjF9FxO8a6X3910iABuEZUg/sh
 bVm93Q+KsDebiahDMe9pOk9EvVgpwW421VNw5RIV/X+b2RJTA5HJXgTadjpLCkI5oZDz
 3HbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793639236; x=1794244036; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jpbACo+t6286VTNY4WrR5Jfr75/v+ASeBxYHRk3dxTs=;
 b=OVu59bZGDPz+cLD1M9KKURm/ADOMnGlxVuIoKGkvnY2bTtkCoPgDAzZByAJ9YBJvr0
 eMUtIE/69TxbhDSDhZUiiwZrwzM4hUPPPM6At7XjBnvZUCBLLlYly7pY+CdDnWQijcT0
 Wyjs1v9yFA+QTZ4jGp/FyrgJzpZl/atwiWGHU68l0OrfZ/3M/WIOfGpRcZPBkaoVm0tu
 +E6wtMXmIDZjC7DDlwINskWBO4APLCr/ffaHexOan17OouWFzuW16A2fMYx9aoCB22lb
 Qc1kxQbbCObNbydoo4/zPW5DCX3khDY5sbjrYTTGG+ZHpnZqTEVZJoQeIpvDYzg0Ag3p
 25jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639236; x=1794244036;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jpbACo+t6286VTNY4WrR5Jfr75/v+ASeBxYHRk3dxTs=;
 b=Z3a8Xlbfbfk4mhWFysx5PpTUR7MiSiT0TUokgiq2GM0rZBcioHUkzvTRMHPNLs8lRt
 MwnIzfLWP4+/4oeuo8frSUOIOibp2lq2CY5I10UMziz880z7JMXNhbNzo1SgdlIgX5NM
 VDMKxLtE2Ss1oJVB6tOXYewmLS48kp54PO8jXPwiGy4q6OR+iHmGNhsZm3KzDrPGIdYs
 m7bnJ4FqU2l0YeqF6Y3uLKQTZjpDbDdf2HCzdMrF8HFVvSvNN+85w6hKvbQ00XW9rFse
 Ar3mzgXmGSRxtUzBsDD2XwMfHuINOaADbryZTK2UaHTSiJLqJ+35GZ9a5LTkyDIx2+JS
 /cMQ==
X-Gm-Message-State: APuU4Z+nE2gPa8a+EDZz/w50Ozu+r2Sj5/wKBaZGEvzXQoOxqWNRaHfj
 Uv29K+jWN0tNkmONXvJCTyZ47P1ucKdGLUBa9DHrqtO6bbW3eDD2ShAYpMohxZcGrtR5+M8kos+
 DPdyjXTdaJn6rinudVb6t7Focx55kKODm42n8/xDoWFmnwWvuyT9mrPATSQ==
X-Gm-Gg: AYBFou067t7HPpFN8vA9wttdOAfE0ksdO6HxndY8lBItOH4RGw/7Yd9cmGMAxXcXrtI
 vEOew5FUGc7bN4E2X2KuFC17oVGl5ctCOQBjKMLTWDNBYKcZtn+Hq9+kE/G3gkAjyFTrAWvGMEK
 ZgPXTdVIk5o/nGMNX+D11lWg66si3GyH2MAz2omwkweZFqlOmPyqc/rLeZqNRo+DvCkUFO+tQpB
 TXml7vkRa9nQ7cdI2Q59dFQDfalcgbobZY+MB8aA57rITHwLFJOkjNRCRV2K8uqvcEwrZwKaIP+
 poX0mLMSedzz74Uk/9AMzdE71HlKxEduKEqJrHXXzq1dpi71NYhQDbsN7xNRsr4CVmfLMmcUJG7
 MnSk/Mae7ZyQVXhve2AKC7oRA6BHxjcUyBqEo8AJt6BHjgq+0wyq3E7vYB/nculpBkOifANpoVe
 4mK6N0LdKVH1sO7ciSrBNB
X-Received: by 2002:a05:690e:bc6:b0:66d:1877:121b with SMTP id
 956f58d0204a3-67ba4ed9d6amr8624803d50.32.1793639235939; Mon, 02 Nov 2026
 09:07:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <20261027120135.53048-5-mohamed@unpredictable.fr>
In-Reply-To: <20261027120135.53048-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 17:07:04 +0000
X-Gm-Features: AclHuK8apI7uKQR7VJeflf1G7xivvxG3mLicxyyh1JXZSWglckzH1s-SlLEJ310
Message-ID: <CAFEAcA8YN2+YuU94W=+6Z-YBaG54Db4E1hkYdzn4DrSW0J8dkw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] hvf: arm: fetch more features
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 12:01, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> macOS 27.0 has some more feature registers available. Fetch them (but not using the values yet).
>
> Also fetch DCZID_EL0 at the same time.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This patch failed on the macos CI jobs, so I've dropped it from target-arm:


https://gitlab.com/qemu-project/qemu/-/jobs/17671032296#L4708
https://gitlab.com/qemu-project/qemu/-/jobs/17671063089#L4702

> ../target/arm/hvf/hvf.c:1197:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64ISAR2_EL1'
>  1197 |         { HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1198:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64PFR2_EL1'
>  1198 |         { HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1199:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64MMFR3_EL1'
>  1199 |         { HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1200:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64MMFR4_EL1'
>  1200 |         { HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1202:25: error: invalid application of 'sizeof' to an incomplete type 'const struct isar_regs[]'
>  1202 |         for (i = 0; i < ARRAY_SIZE(new_regs); i++) {
>       |                         ^~~~~~~~~~~~~~~~~~~~
> /Users/gitlab/builds/qemu-project/qemu/include/qemu/osdep.h:541:31: note: expanded from macro 'ARRAY_SIZE'
>   541 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>       |                               ^~~
> 5 errors generated.

thanks
-- PMM

