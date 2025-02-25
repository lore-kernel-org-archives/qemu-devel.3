Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1950C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvpv-0007W5-4z; Tue, 25 Feb 2025 09:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvpt-0007Ux-8j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:23:01 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvpr-0007V5-Rh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:23:01 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef7c9e9592so46706827b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740493377; x=1741098177; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb5nTvbvTARsb2ArR/utGIva5KxPWjMuzImX9SbxaRs=;
 b=WtS1a/Qv0ZnzwKscLzdW+89L5xkyLjJuyWhR+/cKMX7vyyg3bITY7qHE2EtKWxqglP
 iLynCkXq8PWvDsVCHPDwISW8gN9QW6tuavuF8QDSVBs+qdZQxxKKhBmZLhvrYFm9IEOk
 Ax8JsHDAMXeDuPjzUuB0gKhWwIsaA+kYinx34+YVjuwFmmb3aDG9kkBW+zb2WYR3TkOU
 gXgF1Ktpy6gHftaqOcjTCT3HIg1dJ+N96Fd9Qm9HXGChLuGPGabRXloPiYrrswszztmw
 14GZvTInJxYMFJvTgYHG8ZyqyaWcQ01l8J9NvhfqxsORuPJyDZUV9IKpz7naZrOnfVQM
 3vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493377; x=1741098177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gb5nTvbvTARsb2ArR/utGIva5KxPWjMuzImX9SbxaRs=;
 b=lJA0IMelpbHPVUeRdm+NyYhY5WAwpTgZn2snyM3AUirtjZsZWfPDNAo4tL3ONAkFeM
 r98e/I4VhsmA3f8J7XCgAlNPtW2QDOplMGh1/sSVilkS4lq2uG6ety9veBO3Kvwcl6wx
 JRbZLM2w/zUH1fXA5pekAdd8UZfrj8hPKvsC1p0S+g+X+ihGB0TXg+6f+XgLsN/EVz6n
 jFfkaWsbjfxewez68K7VtouX4YqPszcuBdD0ZFxOFxDNe+IysW7ZwKrWv/vWI8ia0y4I
 BDCwWgeo/0xt+5FBGXE7vkn1yOIWh+6/7Cn3TYnnEWOemMZv7L9ZpAEWS3U7GF0UIMHZ
 RX/Q==
X-Gm-Message-State: AOJu0YwpIMCMg2VHHNJVQVvYuouiU39R0LFdh2X+CPZtAsx7s0pPoTpa
 7qithymq/dKbij8aTLVWPocsMncciiX42JrU2jbY2EcCPlKAD3Qk3V5ARFhTOJkmqZaNCU94N2w
 hPo+MqNfRChNKQWFN3WHZQvuHdkz3pWAKR53e4g==
X-Gm-Gg: ASbGncvdVn0wO7sFkXs3Tmj+ijAmR/dj/YomQ5N9PcUCm2Ja/K5MXDrm/3iAv4qJrjD
 AyjGkyEnR7l4qEqTl7p+PjhbpUllhpe57CypfIt2LeB/xotEtWfkg9FmbN5t4ErX6136h2ZbTxQ
 j+VB/gIgdl
X-Google-Smtp-Source: AGHT+IGn+I31emJiIXXvjCIlSh2eSdYDA8vyMwwnpVH0K6xrZS8PZdkZqVcd4ZJI8cEhprrihx04AXKrmUJb1Lm/VwY=
X-Received: by 2002:a05:690c:6c04:b0:6fb:91a9:94d9 with SMTP id
 00721157ae682-6fd109aac64mr30782747b3.2.1740493377426; Tue, 25 Feb 2025
 06:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-9-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-9-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:22:46 +0000
X-Gm-Features: AWEUYZk5HMA3nIadt4eVkqdLdr7LUXtUGeNu2f7y3Tx4P6ZV3xOgUhR4RH4QVLM
Message-ID: <CAFEAcA-cApB5cF7Safr_-kA3Je37OjMtyGoeCP0G_oXkDD0PHQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] hw/arm/fsl-imx8mp: Add PCIe support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Linux checks for the PLLs in the PHY to be locked, so implement a model
> emulating that.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

