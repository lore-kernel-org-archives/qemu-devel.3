Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB1F9D0D3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfQy-0003E4-2H; Tue, 14 Apr 2026 11:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfQr-0003Dd-LU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:12:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfQp-0001nI-Fm
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:12:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso53780355e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776179518; x=1776784318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WYSQ0wBjMnhHj6/hkTkot0uG8kzpLRFXNRlLGEFsJjg=;
 b=ttRRgjpPKjViWKJzX2tCVygP2n1Lz8mZZladYUnHNufACTVOao3ILbA6qUdbw2wKfq
 NUhGNfoDAtt9bDqKDHga7GAIrztJUPi7iWlLkUpB+jlUjg/xm1B4O4Gpzp79dGG3FJYX
 0hKP4CJJUCOqn+a7AY7bZgEkiuSgRdvBuFf9951U73SJ6vZJkXP0ssSZxCX7CrzDQ54R
 E9Sjg1XWl0Zqdrez0SHnmtJg5UQe19Mg1Tr71Ayl3mJHG7d4DRR1j9mQnFlK2apz63ix
 dq3/QNFb+llVtAWLe4asdE2FgkawjBwZFQ5atnaOATA845OZbTAh5fYqBCOpleK+7jrq
 yp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776179518; x=1776784318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYSQ0wBjMnhHj6/hkTkot0uG8kzpLRFXNRlLGEFsJjg=;
 b=nd4Wov87CvwRUZbXNDLPkhfaVL5hm+Eo2KRYeiinltIAzygzOpoXawiLq/uzd83Xag
 uY7/61nf194Ahml+bMMT71Nrx+iQcBYMoUub23FRpUWEtec/L0PWd4f78y25brqOsXTr
 oWl/IQBLORG0maKisdzKu5rLmaJTElEaOLKKKFE3jOz/13Y3EyW0xytiAlEEzXzD/eq4
 sMGXPOx9QzG7Uf23nzIA87jzF/+2f9E62Ac+JncPp3akNE7NS0XH6byk2qXU4eXiavTW
 iml1mftTRMMSZ9fHIC4elIdgOog35N+/PIw7zUbv24wrzO7mSZNF0pZBy0gSLVYG0ASB
 UCOQ==
X-Gm-Message-State: AOJu0Yz5PYbkfwROHLRpjHRmyMYn2rfxi/mfYyjkUf8N7u2UYPDhnX/x
 xrI9U2NovYmUbCwE8cU5smYgiHRi6CUcj+awS9IaZCIF96/aOl2LEqGz0/h7Os6DgvXL/hUHljE
 eIePmpVI=
X-Gm-Gg: AeBDiesxOH889Y4Lqfgjrx2Xg8mLpAultz1UIiNrY6fpAxHp31qiqMxL86w4ozZQjKt
 LHflKtTKDF0qvw5Z8aLxp2kU8p8tb1Cer+ls4vY+jaGBkSvnaEFqkZcAEEC9EYj67BzpOw4VRXi
 2gxqCLSdTfr+zqExms+lgVKveJoujJpiZYnPCJ2bpw6euF7DfE3ySJGrrkCGzrckwAohppMZOKf
 0xWuzzFQuKJM/kuPQC2Gg7QASrNJJ2z1mHyAN1TLNL/PZ9wgKF75EeeUp/mxyspYZexzozfiM5G
 3ggfVjiC845tadBFh+ttLOHhlaQwd94cycguC0M7FgbsGQE0TWfgKRJlNf6WTGZGxUquolq1SEh
 SI0ZPWxUgbh7BhCpZKhPAwZvFQSMBZUljvD+FXmljKXrLuhT7L74mH3SecyjE1HIrDVXrqwlLex
 5JD/dlnOT7nCRrkIB4iFBTt5LhGs7zeQSJQ6e0xM4C4e+I23639WMSNIN2ZptK+op2xfI6Nzc13
 w1d
X-Received: by 2002:a05:600c:45c9:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-488d689cf9emr235255415e9.29.1776179518314; 
 Tue, 14 Apr 2026 08:11:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede25a12sm50896635e9.9.2026.04.14.08.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 08:11:57 -0700 (PDT)
Message-ID: <ec43f756-60f0-4f09-a8c6-1a83b6d41e9a@linaro.org>
Date: Tue, 14 Apr 2026 17:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Misc HW patches for 2026-04-14
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260414132100.53861-1-philmd@linaro.org>
 <CAFEAcA9-oUv7sycLCCtL-Css-2mi+5T-UBs4aKQB-KF6P-zUpg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9-oUv7sycLCCtL-Css-2mi+5T-UBs4aKQB-KF6P-zUpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/4/26 15:47, Peter Maydell wrote:
> On Tue, 14 Apr 2026 at 14:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> The following changes since commit becd22fdc2a071783d9e04421526633772b3b98c:
>>
>>    Update version for v11.0.0-rc3 release (2026-04-09 21:18:56 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20260414
>>
>> for you to fetch changes up to 31ebdb207f99bf7d72abbbb82fced15d161a548f:
>>
>>    ati-vga: fix unsigned integer overflow in cursor bounds checks (2026-04-14 11:35:13 +0200)
>>
>> ----------------------------------------------------------------
>> Misc HW patches
>>
>> Few more VGA & PPC fixes.
>> ----------------------------------------------------------------
>>
>> Junjie Cao (1):
>>    ati-vga: fix unsigned integer overflow in cursor bounds checks
>>
>> Mohamed Mediouni (1):
>>    hw: q35: fix VGA text console with SMM disabled
>>
>> Vivien LEGER (1):
>>    hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
>>      node
> 
> Are these all regressions from 10.2 ?

No.

> For rc4 I would prefer to
> limit it to only important regressions and maybe very obviously
> safe fixes.

OK, I'll repost them included with the rest of queued patches for 11.0,
you can drop them from your radar.

Thanks,

Phil.

