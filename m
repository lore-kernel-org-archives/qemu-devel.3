Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91849E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZLV-0005uu-8t; Fri, 06 Dec 2024 09:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZLT-0005nD-GU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:30:15 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZLR-0003Ru-UB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:30:15 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0d4a2da4dso3468773a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733495412; x=1734100212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bIr3DoSMnABEI3WhF1EWSUyvCdFK2mTBRKvDmxNFFac=;
 b=YXJLdx3X82mQtvMvm8kJev/FdjGI7quv3N/1X0yOvTarXP43zIEs9hxNQYiCp6Jlc5
 owPw8/gmi1ULjIr88/r56ebirvs2IKTWgoCNS9YGGV7SkdHGMN7eXHW3jOVVI5seqoBf
 S9k863QwE8aWlLAbJ3V0zz91s6auj6SvKawCTxENWaptHQBM+dc849JXcaWFX3nwQJX6
 YMbwt+4UQqojzJ7imTgDStEzmz4bE/5CKs46FM9pUacyJJTbs9Edm9ibwg0PcBLApGr8
 JMCTBi16lkpUeTCMZ+CdrvD9Ni5yCv3Zt8IwkNwO6k+ZeCTEwSRVxYhh837wWdzftsAj
 vTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495412; x=1734100212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bIr3DoSMnABEI3WhF1EWSUyvCdFK2mTBRKvDmxNFFac=;
 b=FIZfl3rFV4Z5WPKQ8ip5wrAGnFPXCBm3dLQWUIlivK35yKnoyUPjz3uzuCdGzPwP7S
 7Of1eTdrXWxOfVXAAVNMWu6EP4BcXZGD3QTLhOdtT/h+swqdv3HKijHogpq2pYRVxnqz
 xm5QDrKdPkda/m3x1hQ3Rw1RSxduAFYR+wm3Gflm59QEKnBz7PvSaRnKnBw1+jQiVD3O
 dp8MS3u+DLuEKAhXvriTC5IMVR1lS7/eL+w13B2/YJcSh9miSVwdvX74hCgYtFeApNcE
 XLgUrZ1A/LOJPH30Gt6vA8bWHV4YBY7qkm/ZnEgRzf0kFxYcK8jGVcxZfO+dNcxKkew5
 I78w==
X-Gm-Message-State: AOJu0YwPUMizA5h4e6ayp+RNGpzyNaoyrdyCCoZaY25KObsaYn8gQVku
 /Qnr32VQBBOH7JQCuyFEL+a2tQcxgRPJ1po0CTpKxEtSGKM7dL7OK+HGcqI3XaTRAB9DAnS/Bgo
 P14JPLhMMdr/L5SkSa+PsYwF8MaWJL/GOaxaE4Q==
X-Gm-Gg: ASbGncs2U7Zrsddf6JNHaeVqCbXHeOCOuA8+ILp+e63uaGttCmJqTJabe48UaGiqKo+
 aStslwR2ZUXWLXLIY71WpebhDvtvb6aLJ
X-Google-Smtp-Source: AGHT+IHbC1D+NgWxP4WMmYFbCx26XjEkhpM/ccSmu4vJrD42BUZ2WkrbAWG+D0bJMB7KFnj8xm6vRkYxjVXtlmYOH0U=
X-Received: by 2002:a05:6402:26cc:b0:5d2:723c:a559 with SMTP id
 4fb4d7f45d1cf-5d3be6d7416mr2727716a12.10.1733495412216; Fri, 06 Dec 2024
 06:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-36-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 14:30:00 +0000
Message-ID: <CAFEAcA8tuzW-+UwXQaznRw0rNa=nNVwK8rKWu0YWgdKnJcvtRA@mail.gmail.com>
Subject: Re: [PATCH 35/67] target/arm: Convert ABS, NEG to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 1 Dec 2024 at 15:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

