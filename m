Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02D9C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMcY-0003i3-8H; Thu, 03 Jul 2025 12:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMcP-0003dp-Pa
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:17:04 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMcO-0002d9-2p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:17:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-712be7e034cso56509397b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559419; x=1752164219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GfauHClvYF6yN7jumsZrA3rMQKmW10M75an4DjpP0yA=;
 b=zC+jMB4GOOsSGXHvzEZdhoF5Ww7j0iyaYZMyUpJLnq8ucT8Gf3mNnTAQD8LJc0Yr9+
 XqBwrujkBOmMiNcjTnSWqyZUVBERcgjTFTqUKU4FRd+rzTyoHkPfYyzkrU60fw5n7CmZ
 S8XLOE1Iis1VyT5kWQkwoSNpQNqVQADDWLMWjO821vD6xoW1wbVzklATv0W9v78wrkik
 jIhDTgAE9vd62b55nTHOaCNqlxzlk88Re/SII6Mx+wqFXfSLOsr+AZpYQqw4ro79ipVw
 7uaE03wuodXTJdPdzuSPjgzilyB0c2Vw8FTOdmlhNLzepKXBDKTUaavqKGpDS5odVu6W
 WTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559419; x=1752164219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfauHClvYF6yN7jumsZrA3rMQKmW10M75an4DjpP0yA=;
 b=s5q/c6aLgX+ScbGeJZC6+LyGFiZucaPDAd9cqKqnd52Bidmb+i7oReDtVR3fUq+bFa
 UR4rPU4QHe0fFrMBLatc7dsPMK1uKoBnBRB+IXf+OULeiiI4m3VvN8wdX9NTDppGGkWX
 VVdFss2NiSzGqaHiZpvK1V0i6BLVYG2p6Eh7a/uTaJoS3zPFUlCWGQ7McVijovVC8/0A
 945oKVJ6KfLZ9v+UsbiyReIH2LOH3IR4f1X159Tr5fopx2ZBFjuWP5I8QRAFNJl8dbpM
 +8/rbljslomI9A4Ldqq/Acc2QU1qQ8dFhrPfIHHq/RHS3p6FVVG6FlEVUj3FeUZdUFjz
 SQmg==
X-Gm-Message-State: AOJu0YzSrFOx4qvq53MwhQtgEl72JF7v5u6LpfJeKdr81C5g2Flx/HGc
 9aphVWzdNoRjMBZuuqMSdvQw3tQ9Rza36LSrxgGRlGwn1qPdGiKknkOmw1W/KJYNcg+jDSz2GrL
 0K8kc6uzyMcImvwKVVeYSrUxIk2rYGGioftJPVuvNTA==
X-Gm-Gg: ASbGncvEb461BXnmPFX8e/rwW3PZveigN3mI43ZblLC74FzZ8oDTt2GqBnyCVWCIBJJ
 0XVhAZvBxk0dK8GFs7xsv2ASwDl0mWo+PFpT6mLycbmuHhWZ+v4frCn0wGBLO0zTJt0XC6LS2qp
 YcJ4UXjWuzF1OAtWvTpz5abKbiXEiBwQ3886GCTVpHmN+x
X-Google-Smtp-Source: AGHT+IEBrbjHMhAKyjuyVtqhT/bBEuTdlsV7eDsp4M3Tb/XgCd5BRHhZ286ylcDQHpyW4pTZt5cdL+UANZGp5HlfVX4=
X-Received: by 2002:a05:690c:650a:b0:712:d70b:45cc with SMTP id
 00721157ae682-71658fda9c5mr58523727b3.8.1751559418669; Thu, 03 Jul 2025
 09:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-7-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-7-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:16:47 +0100
X-Gm-Features: Ac12FXwRMrOJWceXfFxoglh-Gxg6gIz6v-tvW-twh1-hJr_3kUfQOguk4MD7Dqk
Message-ID: <CAFEAcA83M7_8ECFHjGC=qiC6UOsHHgE0jNVYJdkVbBgS-GHcYA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] MAX78000: GCR Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements the Global Control Register
> for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

