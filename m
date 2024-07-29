Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8495C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTDw-0006Mu-UB; Mon, 29 Jul 2024 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYTDv-0006M7-Bf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:27:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYTDt-0004nP-BR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:27:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b01af9b0c9so2395467a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722270463; x=1722875263; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SKKsfiFw3cSJrBIm6U8cZkPuyzxrBZ7rKyvyeUi9V7Q=;
 b=SXDm9Yn8WFatsiwMLqD5aL5yaS5pjGKlp6mrVcNBd5eTjPfEea5/NUf/YavOqQGQx+
 nEdkvY6L5F1FSlftNUcmTNuPd5JG3qf26/XB7hp80O5OrQkPhgCCT77E8w0zJI2uc0Q5
 691IUrfpj1rMTBAiB7rFsSBM7G/3UVq3E7PSPwSIL58rRYO8Z6t3WaBk2JcHWMUfQlSy
 rfwRFfbCO1EZPbO7z2BfRj1QJ0eVbbhJ3agopAAf49a7nbURyuE36BCEvdOCc2blNdQC
 BWM3dP+T2IXail5CnFr4dfDCu0XuulNfT6Tno0fudoCLz6T+Z9b7JzSgsenUwRa2ubVo
 9g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722270463; x=1722875263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKKsfiFw3cSJrBIm6U8cZkPuyzxrBZ7rKyvyeUi9V7Q=;
 b=u2bQvpKg4bbR0nw0nHs1KqcRnPHZzhqhFkVqmvTN7JfuqM43I+66rTjFE/soUWubPM
 kCMVO/Hlc2upKIHqAp0XMuOHPegyn2GE69rwUhuwRlfa5X85uTm4dPtNu+zN7cyj46b6
 0c1IPik56mj/G09a1XPhDu4XQxY1Me7dsbMjicr4H4LOH/uV9lpeFudCbffAlOGATgqF
 zIFywU6+qswHPaf+9A9jpbJ0aLapFiRTn2A5UJ/BX9oBQgEmhgKMrpSN5kwXrUuSYZff
 zhxFEMO3O01heOc07zOqy6R6abU+jpgBbUJAnLOH4H0/mTMeRy8L81Bt807Zzjip7Enl
 u8pA==
X-Gm-Message-State: AOJu0YyL4lnpb1B9NECHhyAFw4rlNikuvt8JMVzy7DBFPAWJ3XGAKNc6
 ZKuMQhfmQnQWu0500+xACy2yCslLA1YkSqGTuNC+1OoOEacuzzIX/PYf1vYeKo4r8aROcShM9Wm
 xoUx4YJI0XHeXfd+06OGFqAvvpMGhQhLjFCg1aA==
X-Google-Smtp-Source: AGHT+IH6xJAeb5N9CdJPFf5+sMb1q1aSQETVyrdTa5n5Xqe512ZQKww5SKaItjS9vwkSQNlTHbQ34xwBigyo+md44MQ=
X-Received: by 2002:a50:d6d4:0:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5b021d2202fmr5704552a12.27.1722270463594; Mon, 29 Jul 2024
 09:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240718230031.69641-1-danny_canter@apple.com>
In-Reply-To: <20240718230031.69641-1-danny_canter@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 17:27:32 +0100
Message-ID: <CAFEAcA9Y3yNoOQp+Ei3M4mtOyeMKAh9fD9_WBimrSYETxFkUhA@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dirty@apple.com, 
 rbolshakov@ddn.com, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 19 Jul 2024 at 00:03, Danny Canter <danny_canter@apple.com> wrote:
>
> This patch's main focus is to enable creating VMs with > 63GB
> of RAM on Apple Silicon machines by using some new HVF APIs. In
> pursuit of this a couple of things related to how we handle the
> physical address range we expose to guests were altered:

Hi -- this is just a note to say that this patch is on my
todo list to review, I just haven't got to it yet. (Unfortunately
it's just missed the cutoff for the upcoming 9.1 release, and
I've been prioritising the for-9.1 stuff.)

I did see one thing from an initial quick eyeball, but
don't bother respinning the patchset just to change that:
I'll do an actual review hopefully in the next week or so.

> +static uint32_t hvf_get_default_ipa_bit_size(void)
> +{
> +    uint32_t default_ipa_size = 36;
> +#if defined(MAC_OS_VERSION_13_0) && \
> +    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_13_0
> +    hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
> +    assert_hvf_ok(ret);
> +#endif

You can assume we have at least macos 13 or better -- our
minimum supported build platform is at least that new,
and we already dropped some 10.12-and-earlier compat
ifdefs (see commit 2d27c91e2b72ac7).

> +    return default_ipa_size;
> +}

thanks
-- PMM

