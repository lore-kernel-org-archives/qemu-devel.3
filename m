Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F9CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNrH-0003Rd-Em; Thu, 04 Apr 2024 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNrF-0003RF-8d
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:14:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNrD-0007ru-Mx
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:14:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so1573913a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240062; x=1712844862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0z4FnaPcsOBQ+YX4GKSd1KH+I7KTyoZry6IxOeoJ6Wo=;
 b=aHAbDuwmjm/1rCXnbR+SQTCG8nAlNGEUy7+9MRmDCRn9NzdMOSEZ8m1bAksnGSDQwK
 M58qa1v3s3yfh9FXg61AU0iBAi60ORDcEj2Gc6s/NqpOmaFg4N+Jm41dAtz0aXa33yzs
 ANKhfVrlWqgK9I5CUseBYfVElkG60poVdxCdebdx5SjtXf7gBJyM374kRaPTzP1hyIsE
 MWQaeNf617rFTHR8ycNTfYz4rfxUJikB7E2A5H2jV6ht9596Bm2/98RmA2YW6FcdzK9d
 rWiBuy8Bfk263H2uOS3/XFOnysdGroEYS60yevwuuyXTnOUnTOTXcT7AbfnbP5PyNnwu
 Le6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240062; x=1712844862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0z4FnaPcsOBQ+YX4GKSd1KH+I7KTyoZry6IxOeoJ6Wo=;
 b=ZSdbBd2MhqBSdRJ58nK+T7f9kI6CMcM7TgK/3qgosaBL86jd3rw5oPZfo+bExogcus
 w8pqEBgN6w1GNeSqtSUXltkhQkROUW7qDbFbZKUh+A2iXkECidx0YVz7WUkBuZtzSCc2
 ebu+1xnHdc4c/z5qWCvCJ1j1a8xIY7A0VjhSf7kYqe0sdOmDSM5ygdmCb87LcoimQ0mm
 BiJmlBcD/15J+T0ng7mdPTB1vaYc1qN4plB8h4y5fIrgbDSY5UNsrQ0AlBvW/UJMFBY7
 eOjNKLSM3JK4emA3UBu8vhG3lU3NlAEdsxHojII7s3zgPADZLMoISx84zaxZgxQwUsVj
 mtTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIyjXVAy8Tr2EwLgqarjtXjfeQq/cmfNI7EXK40wOBHMxfTNNDonIL+aqtTUDZ51e523t5K8VBOxRH3xNkejXA2inBTTU=
X-Gm-Message-State: AOJu0Yxg6mOA0P4g78mWldeEB1fHSoWxu9ij7IdLqqpmPDdwQsHjwa2P
 dAiR8sTM4M60YGHhDxJA9RwQc5IWUofhbMaEprBNOdoYUAEUIjwDrrTqoq2BZBuxYTrdTs+9LHn
 PUT1AQoNk7rhkipE4EvjewQ3c8zjjtXvXThtzHg==
X-Google-Smtp-Source: AGHT+IFmjhALIvdyCK1u0z7HPBNDiNQbc8DaG7rBbGGqLVxHToUPq6+kt95d4pMm9K5j14lONaTG13Ffx+nBgNiAmkI=
X-Received: by 2002:a50:cc95:0:b0:568:b3bf:409c with SMTP id
 q21-20020a50cc95000000b00568b3bf409cmr1817688edi.16.1712240062280; Thu, 04
 Apr 2024 07:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-7-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-7-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:14:11 +0100
Message-ID: <CAFEAcA8GJE9WGT=zzrK6y3DRz9zXPxoPELtbqA0djPSYQD3jig@mail.gmail.com>
Subject: Re: [PATCH v12 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 3 Apr 2024 at 11:17, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This only implements the external delivery method via the GICv3.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

