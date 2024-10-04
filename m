Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFDDCF8854
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmrL-0008KC-LT; Fri, 04 Oct 2024 14:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmrI-0008Jb-Cm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:16:57 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmrF-0001xd-PN
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:16:56 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fadc95ccfcso28557311fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728065811; x=1728670611; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MpCOpQT1mnf0KEcNztOskBKboRKrECpYZzHTs1f9tMA=;
 b=ltK8WieitQ0zcHqarJscpUfmHSAiny1Fh4JPXeHFTIvwRCplrz+JFb6MMUbFi6n6LT
 4tZUvluzKydVHsXV9FtihyoR4kTh/9s7gyLQ/akFVNkTf5Y+PVMpmR7Q01ZGchCOXIqF
 1nnl43ymUNNYsi3e0L+iUDr97TuE6VtCtc8jPloZpM5qOlVJpUvQ1AGvUK4ppQrHphe7
 80h8jpwd1lXs9tiYeQkK8QzrA22UgHdELtzPYXXrkOHlWiCh06nafQo5uNIeDO9zkJgy
 i+3z+73tzy69ENnoTmCCcK54TaA+fiNx2GFBRPfkcFp+HptblxKALLLWPMo0OYF77NoX
 6tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728065811; x=1728670611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpCOpQT1mnf0KEcNztOskBKboRKrECpYZzHTs1f9tMA=;
 b=TlrH8eO+XVnYRKhCeHFlw6QXRwU54gGpLN+yXzDnXXdFmTHvwD9HCv7vQeOPD5E9R2
 WUh0Por/qjcUHaHF1DjzUmOFuOoHq5Pyd6XZUY/3xmXAkpcxD8NtBYqMf9MSwrmqxWp1
 e4mp0bagJlEclLbDIsMKpDBs1LeezaDRuTuli7EyiBT+eEZtQVIARyO9FwZYAAj7zURZ
 ZQEK8mNo/9jLB8/UzDp2JsWMRR9JNDtYSt5ESWrOHUTIt0nqDmHp+oV/gQTqiyKvRslU
 B5VUki1l5S1HHY8L7yCQhjFmvbWylMvZKTHhm90Z+AT7N0jhbsXLPQBpRwENNAgC7ize
 dMyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgUX2NUJ5LWG0JL5s0ucR1sihm+Smr+1js5P853OKUh1ZIESxyeCfeF41GVtziUDjAjSCfzDrkr9Ni@nongnu.org
X-Gm-Message-State: AOJu0YwausWZTQeOirU13SynYbgOlCpsWDMVMlM4flahPdgd2yjZVYyj
 X2AjoteuVQG0UssXfI1Wmjfx1M+Hik/hxl04ulODxVylnanAzYGEGMd3g6ZYAbF74eebtNiPori
 ZGmZiCXqz57qMPFnvCWR3LPOG9Y2zm/sEwoGPmg==
X-Google-Smtp-Source: AGHT+IGZL83zVLHAMME4wZqv2lotL50NYVekLK8K2TOjscGD80UpQYt95D70H6h4+vkferg6X4HDC0gbKCHGCxaLgO8=
X-Received: by 2002:a05:6512:104d:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-539ab9e1750mr2434506e87.45.1728065811282; Fri, 04 Oct 2024
 11:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241001095125.26043-1-adiupina@astralinux.ru>
In-Reply-To: <20241001095125.26043-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:16:40 +0100
Message-ID: <CAFEAcA-bZt3pqDUk0BsV9Ztav+oNB7Wj0cpXgXspKZqLUDfBXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/intc/arm_gicv3: Add cast to match the documentation
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Tue, 1 Oct 2024 at 10:51, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
> When cast to uint64_t (for further bitwise OR), the 32 most
> significant bits will be filled with 1s. However, the documentation
> states that the upper 32 bits of ICH_AP[0/1]R<n>_EL2 are reserved.
>
> Add an explicit cast to match the documentation.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d2c0c6aab6 ("hw/intc/arm_gicv3: Handle icv_nmiar1_read() for icc_nmiar1_read()")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>

Yep, these look definitely like fixes for wrong code.
I've applied these to target-arm.next (with a cc to stable).

PS: for future multi-patch submissions would you mind
including a cover letter (of the form generated by
'git format-patch --cover-letter')? Our automated tools
expect the cover letter, so patchsets are a bit easier
to process if there is one. (Single patches don't need
a cover letter.)

thanks
-- PMM

