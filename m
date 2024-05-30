Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15FDC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCd3f-0001TI-U9; Thu, 30 May 2024 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCd3X-0001Mo-EB
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:30:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCd3V-0000r5-TE
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:30:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so346747a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717065043; x=1717669843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uThypw/HPvw4P8WDz2IRhO+g65TKOdufmMLi1ChnOkU=;
 b=N8VsOW/6B2eL8fuwnphQuL7sjR2b41zLTJu0QjUmglp0np2dxGh7HzS0MgDQnOSqAc
 TAGYdPyTVqwHkhNTrBliIV2/HhoaALKyDk2EGX9SYq874xhkNgPdGWNsrvIe/t5tqBl3
 RM2xGAQZXHkfj6go/VLQxl1+jzp2cipLlSN2CXvjAxgDSTlwFRt3MaLVeYPZabU3+b0g
 r8xGGUG7gOb8JT2UyHEisH+mmE3E3ttTK97VG9Ls4CK1nwV6JsrsVybyCyeiY5ZBsDOR
 XZU4SPXibU+gFIx1MH4cQ3GbQbIAWGpkfNnmUQmobKVC+HCvlokJcq1s28ApkMdgdARE
 giig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717065043; x=1717669843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uThypw/HPvw4P8WDz2IRhO+g65TKOdufmMLi1ChnOkU=;
 b=jD33P8h44Q+PR1OebaakECdVIvOuDoTfyI0frnOCwzddL2Gs/6Sz4l5jJobxlF1hbE
 Rc0g0vEkrA02BqXa1U04/7NOGtFQed1G8xf0nwxJlX8Ur6uGlqyGoxvDUaXnDD4WWUjn
 61+Xlkx7y58fjejm/Xm9M6n4StjU+f+7SsAqeDB+fhQb1c9Z/6nUzurDQ5LiZxjickgE
 04HFy3SCPyD/XhUusw0RLb8I16V/WgqdYfiPv+540HxHPv0/NbZZp2VhPMQRTtqf5m2l
 HAa1Vmitw0p5u6hvh9ZDbQVgrJNgK0Rbx1a+4cHitPpPPPeicZ/pGvwCj+/UJ5q1Y7ED
 4ZQQ==
X-Gm-Message-State: AOJu0YzFvteYR5hfo8k3xFLrKUyHiE9ZxwVzIBbwwEIMdHMOZIYUo0tG
 OhWM+Jt/KniZNBXXc9JuEtN/YRngyF5MG4Cesi+jDTLPXrncdtA5HOVEvXqtG0x4D2kFGKBog+t
 d3T0Q/pkIswg7OPV8ly6VxMaIzE+qnTz5yOTLU1+p8YhdUYoM
X-Google-Smtp-Source: AGHT+IFexnhLQKmDule0FjKuofm+EDCgdNYvIDr0b0LJ91ysfaDjCKq8/54iIXtF0jQXfKxDpqFsoHQxXagmf6OuphQ=
X-Received: by 2002:a50:d5d4:0:b0:56e:238e:372c with SMTP id
 4fb4d7f45d1cf-57a1796a2famr1153871a12.26.1717065043321; Thu, 30 May 2024
 03:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 11:30:32 +0100
Message-ID: <CAFEAcA81fqWKXL_7m6LTi0-zkmtMQC0RY6_ZNP49cdWCVJK+1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Zynq 7000 Improvements
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 24 May 2024 at 13:08, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> v2:
>
> * Add Kconfig support
>
> * Add array of CPUs to ZynqMachineState
>
> * Add FIQ support
>
> Sebastian Huber (2):
>   hw/arm/xilinx_zynq: Add cache controller
>   hw/arm/xilinx_zynq: Support up to two CPU cores



Applied to target-arm.next, thanks.

-- PMM

