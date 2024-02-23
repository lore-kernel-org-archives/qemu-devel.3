Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0C2C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYwm-0000VZ-5v; Fri, 23 Feb 2024 12:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYdt-0004Qa-EP
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:43:21 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYdp-0001Ib-V8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:43:20 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d220e39907so16394001fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706596; x=1709311396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7KNDr97GO0+PbFjKwQ4Ggp+aJeVshonNgPPnWYKiCcw=;
 b=Mx4PlG5Vt4n0MhEec2EagsYvBUMEs5qrElJ6WkymEddRfZyvlMB4KmHoa/Up/igvLA
 ji8Vh5gB4gEoOE5eXYQYsJBhy4o2E77SpHANskO5XI4WsJtDvJxl+Hs3N1kDDijNM288
 6Jq96S3CQYy1gXclXVYCLQk0Me6iInz92bjahhPneNBrj9QACwS8snNzQBB6YZAa4XTR
 had49HcmzZZ+dZyazsgfznuauEBgMCQdsEx7T0JkoYikrQdFutgrmpa0YSdV+Bzds8yT
 YxZYbWwYUScMUqCisw3sXst085bmmMVHLSMP1033ZGM4n8+iog+nJMsyogBhvsmACmPJ
 eBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706596; x=1709311396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7KNDr97GO0+PbFjKwQ4Ggp+aJeVshonNgPPnWYKiCcw=;
 b=bhXSZQi7wIfSjrsX5mvFuC6+B08x5ccVJs6hBj1L3EqhKFNHVm1PdGkYUMYpXJ8tCV
 qEG5b+Llm7xQEd/HA10fOTi+cR/0WDvLCxl0KSt5RbImUiWyI6FBnYN0zYRTJArLm6vT
 cPIaovo+gvt8QbV2Rxy/Ut5hztt6AQDVbqly4hNnaIYiPN/d5T27HNqGsYBDbBkGEn/L
 CLjbFF0kB2XHrPCCErGQ80xIczjK0OjYsoe8Wx+QSJavsRVyzmWvQ9o9jGhKEBHyY4bH
 pMhL5svRoPp/ROc3vJOWY/0wwwGhO2S3sKBNle53MPJ3PxHZAp0HyYs66YYbgS/47yFZ
 PuHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtxYAxSzOSyAPuhg9LanSnwyhFL9DI8EOrnNnasFuzAFbF9NRIXGMUM/PloyrM+klPfba7v+OvanDbu8AkVJfrEIRKVXA=
X-Gm-Message-State: AOJu0YzpojPySZnbR+zthdZ25j8TQRo6N3rSGb+ActOoJcDJP2FI3H4U
 jHaa492kLd2SXsWWk7yIoQS77n2rCvpnLo68dwExWqI0gm+8FLDAL6CE7F5AovARQPMkbPQf1hz
 WSp1nKOhAR4EG44pHAqOxmfuA9Y2DzW6eWDUYlw==
X-Google-Smtp-Source: AGHT+IGgjpzVKokMANxIkO9Z9rf/up0UxoZVt+uYu9vEYhlo2hRJz1i5dgcr8L0A7GuuKMLtfAMToG7Q+eYRd3toFCQ=
X-Received: by 2002:ac2:4a9d:0:b0:512:a995:3445 with SMTP id
 l29-20020ac24a9d000000b00512a9953445mr194102lfp.25.1708706595837; Fri, 23 Feb
 2024 08:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-8-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-8-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:43:05 +0000
Message-ID: <CAFEAcA_SZKjmSPqwWOpwyDwOdP--T-WhHkEFjUD3Sb+UUvO3gg@mail.gmail.com>
Subject: Re: [PATCH v5 07/41] Implement BCM2838 GPIO functionality
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:23, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

