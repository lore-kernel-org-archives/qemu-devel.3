Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F78FC97F2
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 21:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6xJT-0005oZ-8X; Sun, 29 Mar 2026 17:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6xJO-0005nt-V3
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:04:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6xJN-0003Hu-4a
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:04:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso15387915ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774818283; x=1775423083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=USRWpu/TsI4prWiurkC7iIjtzTH/YeeJr1hwOgX/fgI=;
 b=EFCnkF3WPJ+2k19XSjuuaS+PNgcNujjEkYEMLoEuzy5T9JBhIxADZm37iK7coNKd6t
 G9JufPRwx3Y9IgWUlvuoZjWD/o4/qSEkAhGcF/baAb4JIHbOFqs5vroQHJGjIlfT+ikr
 y0kfoB3n621PcDlTgL3p/UUivcXF+k6KLYciYngrGs0FIX9OkddSMFK4cRrfU2NrI5O1
 j3vTo0k/stk3M+ASfUYHe43Q3J8c5ynyb75v9ErS4YVVhSPyPKIf5FTY5AI8Kf2s0et+
 8Fp/A7U2DxnRfUlH0boMmEJMtBdsfBTBozDTsSwiYYLIJYLzq4fRcSH51gMD1JWo/LVF
 bF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774818283; x=1775423083;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USRWpu/TsI4prWiurkC7iIjtzTH/YeeJr1hwOgX/fgI=;
 b=n+lS4z75NUoCuIlcSTrpQmWTf3HHFL09Jl2Jduzkx3R5ywOVtlBUPjIB+H3OAwsc51
 rC8a6/uWiqrN3yL1mlwbshdFvINVRdtlA6Umwpjh7g1c4TX2+bxh1e9cIMD7eZcBKItQ
 Jd2hRHO1pfgh6SN/VZZZAzPqgw7vyd8vkjAfSfUtdpHtdInWYEQRBDe8yOeU6Q65xdql
 RQOVBLFGq4Of5OlrE7pcsdnOg++2fzUSHGHBHd9/QoIMN23qaMQwDZDI2O/mMRnaVAgJ
 6m2wYBht1rBhooS7uUjpcp+LESjLcgRwlx6n9qoIZESwy9AS1Rox7bQenj3/X3LUuDqN
 HCJQ==
X-Gm-Message-State: AOJu0YxAbguAmLjqVHOwxFfApzbcVOAtb8j6wsc5T0Iszd9kSlD88l0G
 3Td8ns6AyZOkEMmdzfqTnNUHLMlcSux4QbaqfzfiZE1d3KS7ZqULeySqJcIV68Exg0KwJdWh8Fs
 RqfquNH4=
X-Gm-Gg: ATEYQzygmHLD961XcOzk6YAsBxjiNJ0bn7/WQl+0SznWgr2hWMM4e6x+YgzlFqrHqfd
 2srcs6zUyWHHPSG/4vZNYp0Mk5WRPKPR75h1y2VVpcmo1Isyl2mGsbWFoIhUFVZm34axBdE/+yo
 fh1HWxQZ9r9nDWg0Zma6CYnCXkwLvB4MiR50ChUXHA3g60CxYdkN3WfQi/ugKBC/OYH60ivhIVy
 Y/pUe7f8A8/q3SKSpZLJhmrFuNn3XKWuIMTkFcDtHtsmvmTyf+gJRSuKc2KgxBYorjdHezoGDJY
 BT4q8lW8WI4lDdABQrVvlVLGQp6FXZiiUroQekV18YtSoQ3Y3NCb/NPb4PXh1XpZ+vDqYXnDSaW
 RNg9iFJXBAmdGSziJ1mVbCLsq49t2pboYKJ0cYj7cLN8LTlC5S2pWNK1mVSrRYqMY7IdPmi3TrO
 2uoOGUbNfsW30pEpfMc0XuRYqynTStYrOqjAhhPd+/9TKPxXELCxetsu4dYmIx/Oufuq9HKYMdH
 +1dRtQ=
X-Received: by 2002:a17:903:1b65:b0:2b0:afad:7aad with SMTP id
 d9443c01a7336-2b0cdd3e3abmr103871375ad.45.1774818282827; 
 Sun, 29 Mar 2026 14:04:42 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24265e7basm69864555ad.21.2026.03.29.14.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 14:04:42 -0700 (PDT)
Message-ID: <937e6d77-6da8-44b9-bc4e-87c0620b10ad@linaro.org>
Date: Sun, 29 Mar 2026 14:04:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs and tests: assets moved after GitHub account renaming
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org
References: <20260326214436.256215-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260326214436.256215-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/26/26 2:44 PM, Pierrick Bouvier wrote:
> GitHub setup a permanent redirection for all repositories when accounts,
> so the old links will keep on working also.
> 
> However, GitHub allow this username to be reused again. To ensure no one
> can inject malicious content, I took ownership of the (newly free)
> pbo-linaro account [1], so no one else can claim it.
> 
> [1] https://github.com/pbo-linaro
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/about/emulation.rst                      | 28 +++++++++----------
>   .../aarch64/test_device_passthrough.py        |  4 +--
>   tests/functional/aarch64/test_rme_sbsaref.py  |  4 +--
>   tests/functional/aarch64/test_rme_virt.py     |  4 +--
>   4 files changed, 20 insertions(+), 20 deletions(-)
> 

This was merged into master (bbaad5ee25cc93e5592afc85a66530cd8b69b2d1).

Regards,
Pierrick

