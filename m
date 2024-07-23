Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC7C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW49g-0008Ih-Gn; Mon, 22 Jul 2024 21:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW49Q-0007eU-GH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:17:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW49O-0002Lh-4w
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:17:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc5549788eso37428495ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721697428; x=1722302228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qTKaOqetYPf18hLuVZzsRY2daa8pNhGsB9HKubNyZY=;
 b=OogchreHiG2i0fLHeSjxFpQRy0cnPCFpy+MNZ+6GsYTy0WL6XMsXA09lkUZNlm3vWY
 vGWin19HnfGATKGkS6k+/aD32SXNxvR/s/fjt99VQj59RPl+Pf9uOggYb0h2cGD1keog
 En9lLtn4eFWEuzMubFdcvZ8ye3nUpsM8qgtQikb2msOXMz89R47sdvJbLS6h6/KTZ9Tx
 cqeNmPAJQwK5WHkMD/wqxGamhKl8Nqjmv/hJjlnpHQUexoRZi5QFX0KQO7PUCa/GGGo2
 aqYSnVo9HI2X1FOKizokack7A32yMVVDjq/Qse40qI8m3qvCs1LF3HoHmXk7mzPISBTr
 Pxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721697428; x=1722302228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qTKaOqetYPf18hLuVZzsRY2daa8pNhGsB9HKubNyZY=;
 b=HhvLhWBBMX1ttcXv6hLnunq3XpuZl/V5dUiZyFJKByQgA1OEcGs/EBBvbpkJE8jhNV
 bet4pGjY4w9mU9z4KV/i6tb0K4decHftDAnO07QRUiqHaahz6twQcutdcBt9ql4yhr95
 s5tzO0S0hN8lvyDUfveJU9q2N9ML1uKj3qeyqJSnXBFXCi9zKhw5oX3q/hK6gBwWqK8f
 uDUnlWghGjmwyDnDbfjBlWOty6tyg9dY/Y/p9B2pBLxcrfJpSMGlwhG7mx74bfOZAaro
 wpWTUD+Nwb/mzoI6I5H2qm72MAbzztjQaZjmYL5wsB9+oSlSXnUg5lFYIls3UbjwB3bQ
 QfNw==
X-Gm-Message-State: AOJu0YxSSf+QBgutakQr4X9FmNzEmk+hWZv8tT0biXZGnfPT2828Aqfu
 JeSTXsOp9P01qGbbcqzPwHs5tgFkMglcSrRdtqss1Y7OZZwUwX5k8QOcub0BXF+87XctoxHLKzf
 H61bwtQ==
X-Google-Smtp-Source: AGHT+IEswDuG0FdmxCpIjOba6+aLR34GdZjeGAIJ+nn+pu6j4H2W/L+T6EcCWyZVBcPJJLASpJ/zLQ==
X-Received: by 2002:a17:902:d48d:b0:1fd:82ac:7c2e with SMTP id
 d9443c01a7336-1fd82ac8886mr97646385ad.25.1721697428292; 
 Mon, 22 Jul 2024 18:17:08 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f25bfedsm63658935ad.48.2024.07.22.18.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 18:17:07 -0700 (PDT)
Message-ID: <0b7514dc-f9ed-4c48-be37-5a5de7b26229@linaro.org>
Date: Tue, 23 Jul 2024 11:17:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
 <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
 <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
 <f2f6c27e-7625-471f-b888-0f3a870bb0c4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f2f6c27e-7625-471f-b888-0f3a870bb0c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/23/24 08:11, Philippe Mathieu-Daudé wrote:
> On 23/7/24 00:06, Warner Losh wrote:
>>
>>
>> On Mon, Jul 22, 2024 at 3:54 PM Philippe Mathieu-Daudé <philmd@linaro.org 
>> <mailto:philmd@linaro.org>> wrote:
>>
>>     Hi Warner,
>>
>>     On 22/7/24 23:43, Warner Losh wrote:
>>      > Add the aarch64 bsd-user fragments needed to build the new
>>     aarch64 code.
>>      >
>>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>>      > ---
>>      >   configs/targets/aarch64-bsd-user.mak | 3 +++
>>      >   1 file changed, 3 insertions(+)
>>      >   create mode 100644 configs/targets/aarch64-bsd-user.mak
>>
>>     Can we build aarch64 on Cirrus-CI? (not clear on
>>     https://cirrus-ci.org/guide/FreeBSD/
>>     <https://cirrus-ci.org/guide/FreeBSD/>). If so, could you add
>>     a follow-up patch to build that on our CI, patching
>>     .gitlab-ci.d/cirrus.yml?
>>
>>
>> We can build aarch64 host for bsd-user for sure. I'll see if we can do it in cirrus CI.
>> If so, I'll try to add it to cirrus.yml.
>>
>> This patch series adds aarch64 guest...
> 
> Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD
> aarch64 bsd-user guest and test it. Am I wrong?
> 

This is adding guest support, so your suggestion is orthogonal.


r~

