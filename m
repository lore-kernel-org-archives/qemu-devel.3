Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73840C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:07:56 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaev-00048A-Ua; Fri, 07 Jun 2024 10:33:37 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaeu-00047u-OH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:33:36 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaes-0002Vk-GI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:33:36 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso31824411fa.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717770812; x=1718375612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1m+3h3ZMpB2qpYFkRUj7JWzswXTd2jyCojOK8qXXe8=;
 b=UL4/SzsCVhkyZzTiLZARtLhZ88SiV/ouImTY/N+cJDI87zLfKon40V5PC9ZQn+VyWP
 3nWZZ4CWtUAKd5bK9avI+9cF/OGZdhlZc0Gmytv/yYdThX8yR+/NKzB+AQGf7eauOF90
 +LxBu+uxm1SrtWpMdda0Z1i3F/ud5wfJ4hvylXdcZ1sh7tCFbVfZc6zoA/gQ5Q04sW97
 xgqVuwvT3nOkuEQwHivNIyS71Ii2z8+bBL7xC2qjzDWukbGVjdROuncClGMqyQBHc1ca
 3mWkaVdoZGDRo3PxF8CAKPkMxK0oKuDDMm5TgUJyAoxn0l940+IrtGxCkC16kKnQJKdN
 g7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717770812; x=1718375612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1m+3h3ZMpB2qpYFkRUj7JWzswXTd2jyCojOK8qXXe8=;
 b=QbsBS9qHroHcB6c9FIpVxziU57KUIUOb6rBjkuomMG9YrfI4QiCcY3wFSh6YuBAin1
 c76WUCjs1ArDyIKHZwh9OcoL6rG6tAbxFauo6qUcx2fXMhlD6SHkeZ9jjom8GQsgc7s8
 U4eDR8JiuzVCzRrdLohy19w1GduDMhEaE3oZyGwledKK/67XjM1mqqcaq4Wn57WWPrzg
 rNcWIcBunyF8WTLkxBf85vf/58rxzBUzeUXCoE1X9u043m7hPmAJ7SHHY/B5IuFxg1cz
 hfZXWrFN2h66Imu4FfzJz0h+f4XKyARcCznpW0pHxwjPSHKTNzkSIHVR+BaIjqu3nl43
 NmyQ==
X-Gm-Message-State: AOJu0YzbpfCJOI+hkKrKs4fnf/4h6g2la9NJgAl4+imm2nVqr2LwxclX
 VYFtQosbMly4aNWETwRnRWpOdxWU3XarFgSWstwhZzG4oIKXfBEl02CjUaMaXKHGKNjDGDA34Pt
 F3nksqhapEmpz5MfgtD1O8t+0uvD4Mt/jnh0Elg==
X-Google-Smtp-Source: AGHT+IEaPk732i0YbUA1nmYbFrFWei9Z0zR1zaf4gbjxSxkJKBMjCD7NvdufuljyiCfTiAGP6iUUzj4yigZzHn70PDk=
X-Received: by 2002:a2e:880e:0:b0:2ea:e2d2:61ff with SMTP id
 38308e7fff4ca-2eae2d26485mr10509311fa.23.1717770812457; Fri, 07 Jun 2024
 07:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240605143044.2029444-1-edgar.iglesias@gmail.com>
In-Reply-To: <20240605143044.2029444-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:33:21 +0100
Message-ID: <CAFEAcA_j0d=0y_1Nd9VZDPceHBw7CMpd4N8Vv14KUa+RvOJR6A@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] hw/intc/arm_gic: Fix deactivation of SPI lines
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, sstabellini@kernel.org, 
 julien@xen.org, bertrand.marquis@arm.com, edgar.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Wed, 5 Jun 2024 at 15:43, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Julien reported that he has seen strange behaviour when running
> Xen on QEMU using GICv2. When Xen migrates a guest's vCPU to
> another pCPU while the vCPU is handling an interrupt the guest
> is unable to properly deactivate interrupts.
>
> It sounds like something rare but in some setups it actually
> happens all the time.
>
> Looking at it a little closer, our GICv2 model treats
> deactivation of SPI lines as if they were PPI's, i.e banked per
> CPU core. The state for active interrupts should only be banked
> for PPI lines, not for SPI lines.
>
> When deactivating SPI lines, I think we need to handle the state
> as unbanked, similar to how we handle writes to GICD_ICACTIVER.
>
> This fixes the problem on my side.

Applied to target-arm.next, thanks.

(I'm surprised anybody's still using GICv2 seriously at
this point...)

-- PMM

