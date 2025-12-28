Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F99E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 17:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZuG4-0006x4-C3; Sun, 28 Dec 2025 12:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuG3-0006vt-0D
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:08:43 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuG1-0001k5-HQ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:08:42 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc7892214so55679707b3.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766941720; x=1767546520; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jL44AaMnL+XlOL2KGeRIObyV48ISGUhidJNsD3qk2rI=;
 b=BS04Q05v7xePql4biQTtsEb7L5uywDhpqSCCMeOtVTNg9MpnQgnUwZe7hb2oBpIW3l
 BCScJbiWuywXeK+iGqeeTYEWNm/tkZWEoDczeGnAHmgcw53xAKeUteQA45kbz3Xm2Osa
 ytu91mRE1f91sfwTzTW491Wa8eJ1V8JSd/EycqqiAm2b9g/VhxerSYTubkLR42cMGk4I
 ln3sgMixCsVAPxNGyrrwp6i7bu/J+MOxPnsy7oSGb/pbh6v6I7b6jxTLOxHZ6jy0FrNK
 1CFkV/cWmuds8Z3rVQ2zn+I4EsNc24NCvAgJbfmJiH9EtC3YN18Qj2Uc40Zgdc57+GHu
 DQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766941720; x=1767546520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jL44AaMnL+XlOL2KGeRIObyV48ISGUhidJNsD3qk2rI=;
 b=jrsCX+750WDVRDGsgf1qncX7MWkNXc52es905PW7yfI42iSeOwJ41a/0cNjYcKAHCH
 qHHxRXgT9jNXAaDnGitZIsAnteFjEF7SIxT8Mbva73M7e0AEX1lLmKAfT5XsagaiIhKz
 XOl1hZ7qA727xiJ4K8Ia6pO1yWrtdPY2PNgehZ4mn6pF0p6VCsjMyTroT4C/I7dKcqpF
 ZszH8hqLlyiNNpOEI7stIUecNB/wcM99jgfYJ4KL1KRXIQ9MrzldghE/taB/i5JP3Siu
 1UQ1fQHFWRgwvszuLQy+PT6szGQPUM4no9OZKLG4TQOtVMa3zVL9AyIZOpaoPZ2ccNzn
 xUyg==
X-Gm-Message-State: AOJu0YwrrQtyM54QY9jBALHqU9/bFJOcpXS+0PUJyKuAao4hoD3wh8pM
 EntEY//tFUW/ziqQZ538Ttaxd7hUKL/LYEItSFY3TVQF++5fQVVfUZPcp6/1YvsnvN9IbADgPJr
 3xQDIBFZgrJTJAEGwA/EzfNr52+4T4L1+0PUAYghn8g==
X-Gm-Gg: AY/fxX6dIcdNQm/nPmX+XMvu2KPy3BLhpHGrVn6r0NCT8o49R6WlduxBvnsHasOftSu
 mBCWvFN9mU7UghOFlvOgRadjfZWrbfVCaiSXtSOBUbp2neIgsYEnd1wrwi4iMVEcq0m5DipP5rK
 NipPIsKIUSJLRRBNEPwJSVUx6FwsgJnwAUSUQD1Cm2TL/2hQtTyQFlrWQ+aDy2yi1eYj73OQ1lw
 leBGOJqLJCym1Z74I8Cv5e1R8TuSUcLXpgnGUOBpza64HEomPDJXzIUrzJR3o5dDLF94mSolZTM
 M0JO5MnsJJJBkP8nWTt5SiabgaZ6H4F1aA==
X-Google-Smtp-Source: AGHT+IEcIvqx4VidfxWASBLWhsvXMPtSaUfJZ6Qev+agsEWmQ8QnAwrPR8iVm2hfe9qup8ekV3XXGW7gI3+0xOVuAQU=
X-Received: by 2002:a05:690c:4446:b0:78f:f385:4116 with SMTP id
 00721157ae682-78ff3854144mr143633737b3.34.1766941720351; Sun, 28 Dec 2025
 09:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20251223223712.17047-1-ruslichenko.r@gmail.com>
In-Reply-To: <20251223223712.17047-1-ruslichenko.r@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Dec 2025 17:08:29 +0000
X-Gm-Features: AQt7F2rClaxWXZYxUbkjJYjDMD_wna96LCGvM4qybkM3jxovSX7IF4Jkvg5m6Fc
Message-ID: <CAFEAcA_SSnwo0N8j_zz4jRrzcewAiRaVCENj1_gzdBVCthNVFg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/smmuv3: add support for combined irq
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 23 Dec 2025 at 22:37, Ruslan Ruslichenko
<ruslichenko.r@gmail.com> wrote:
>
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>
> Some platforms use combined irq type, in which case
> only single interrupt line is used, instead of 4
> different irq's for each type.
>
> Add emulation support for combined irq mode.
>
> This mode can be selected by platforms by setting
> 'combined_irq' property.

Which platforms?

The other way to approach this would be to have the
relevant SoC/platform models create a TYPE_OR_IRQ
or gate to wire the interrupts together.

thanks
-- PMM

