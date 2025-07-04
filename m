Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A24C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgIJ-0006K5-8x; Fri, 04 Jul 2025 09:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgIG-0006Jp-91
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:17:32 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgIE-0000eL-1B
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:17:31 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-32b561a861fso8173631fa.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635047; x=1752239847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZ+i/+5+N8ewOkII9wT2HLBtCT2glQpVzPe1qJqXJDI=;
 b=nHq9McgrnKEJJPqt6NIT9030ubFUakNO6LM7AZfTpLulsZcaBUfD/ZkQX66zZmfWnh
 7HIriXHM/wJGDWzNLxnGBZFctsmnUJpa/MVoHYsErmG6F0R5j0/sltzv1WDBRRhKDiZ3
 z4QjRtgSmwTq+arOvk0dITu4wZ69y5XdLKdgIV027Ccinp5msc9WKe6ZFGr4oYo0GnOa
 GA0Lo8eHOLOtA3jOvAJtxUSmT7EK/qQnS7HNt3QoeSfKYnvcqnSI+5ozueXmfq1+cmwL
 rlxMtr5Ep5hWXRt9zkoy1YHxWsCWPPcDMKc8GxKQuMZrbSTDTQl0jeD/0PiGFyLZW+dD
 yN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635047; x=1752239847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZ+i/+5+N8ewOkII9wT2HLBtCT2glQpVzPe1qJqXJDI=;
 b=O/ES2r2N9X1wud7yMiPMwmq1BRjVb83BKKqkpdZSN62TlPgaoU+pF9nXByHq/+DD4V
 Hx1hLPDtEzNHCNx7oHCDjVH1TO8sOY6W8mmBuI317Wbhqo5DD0Ff10h+GXrVpp16Ww3e
 DoPpiQq4osLFC/u/QyNm3O14TJawCnMFGPbtfMgc8fAu7eEL20QIar79Xr75TcUO+/sS
 gdBMWFcZCNy6gJktVD4s8mga/LvLRg6PPVfPQ7Pg/PHi6IFf7wc+6yTiI4Cu4IOqtosX
 GkyoUfYVQZsfkuqmOTF0JBkdzv4fkz3YnfBr7uakvUmBgmW5uUhupDrgXCY2a6f5OT4m
 RROw==
X-Gm-Message-State: AOJu0YwmVX3HS0aA74xz0twMR/yLzCYNj9cYEq6rZnTmP7+ftPcAeuYd
 4dW860/87ESIdHiPW7nDarUDB72a9arrU9wbY3M3fes7Ckr074Jo9iKMG8jEK3xB88I=
X-Gm-Gg: ASbGncuSTc4lle6wnuT0thOgZo+MtcVI10Ro/4TCQe07wFbI12CRhc74/ssxY0KmUVp
 g1orAI5w9zr5I9DmWDlERcbXBIwbteMdW6PlhLDvlZImGPIWArANGG2Pf9V4f4ZBeU4mEulzpQH
 1ipXc6T2bplVTI3+/OGN88lNFjiXTBtuUsCk2ggpSwEIc7TDsWMG7drxWbxsYdh9n+6yp+K73xQ
 OSGDCtmPX5D8TDEoEjb3azCdEfRlikdW71iI3M/PVDQZGClVZnPvGY1zb3nscOfGl/EDlX1+IRu
 EB2+PnlUKZpiWJzKLy2ehgAo54PgMC+bXduMZYhbvjDjJLUolj1Me0HgiYXJs7MbWOIMgLPe7uR
 zv5B8uWF8Wcks2+J8MF+hmw0d+BB9rLVRM+E=
X-Google-Smtp-Source: AGHT+IFMIpYwULNg+lU45xyfQ2tIwlIKt9q9LpasQiHw0WDa8dR4mT/eYFUNz1hUoByo8ABQ9vBfSg==
X-Received: by 2002:a2e:bea5:0:b0:32b:3aeb:5533 with SMTP id
 38308e7fff4ca-32e5f55bbcdmr8785901fa.3.1751635046949; 
 Fri, 04 Jul 2025 06:17:26 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-32e1b120281sm1933051fa.59.2025.07.04.06.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 06:17:25 -0700 (PDT)
Message-ID: <eab8d30e-011a-4ec0-ab70-827f6a33a5c5@linaro.org>
Date: Fri, 4 Jul 2025 15:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-3-philmd@linaro.org>
 <CAFEAcA8KBTfJqUbBeUm9_=JoMf133Tt3tcWhJ=sSSy-Yc6Cdcg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8KBTfJqUbBeUm9_=JoMf133Tt3tcWhJ=sSSy-Yc6Cdcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 4/7/25 15:03, Peter Maydell wrote:
> On Mon, 30 Jun 2025 at 14:09, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Only allow disabling NEON when using TCG.
>>
>> This avoids confusing user experience:
>>
>>    $ qemu-system-aarch64 -M virt -accel hvf \
>>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>>    qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither
>>
>>    $ qemu-system-aarch64 -M virt -accel hvf \
>>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>>    qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
>>
>>    $ qemu-system-aarch64 -M virt -accel hvf \
>>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>>    qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found
> 
> I don't know about users, but I'm definitely confused.
> Aren't these three all the same command line ? What's
> the problem it's trying to show ?

I should have only shared this confusing example:

$ qemu-system-aarch64 -M virt -accel hvf -cpu host,vfp-d32=off
qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: 
Property 'host-arm-cpu.vfp-d32' not found

