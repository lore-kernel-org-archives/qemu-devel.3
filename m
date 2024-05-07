Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58877C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Fes-0002ZE-Tn; Tue, 07 May 2024 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Feq-0002Ye-IY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:54:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Fem-0004q0-TR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:54:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34ef66c0178so1584457f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715068475; x=1715673275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/ZP59gaaEc7rDJGoQ8grD5WHAafi5fzSlXp3Oliub4=;
 b=wSHa0Xi9EDOZ4ckIDwL2PIcpi32tMXgv2XSUFZEp0qLee4ulTR18plscsUBbkiZBnD
 imNnr2kHxWswoWQ9sed5CHa1tgH3u/7qY4gp7BER8n6dQ4Z3kDeaiUQYwW85pHEH3a0U
 tFa1HtblFOJxPz2wBXW6894UClhYG/lDBZij9NgqgKhwARO5bLHOOkPb7AWVG53C0LFl
 l5r87l6n+avRE1T/iq7R8JSNHJYl8oqEyxHEdnnCRnL7OtXcg9fyGVp+R4p+iSUw82kV
 eJNwYRlgW/zv5AnKyUIrXbeFNpMhr1eDmXJ9H+9N/vXBnpyPWrNellHnVDb5pRRB0squ
 CYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715068475; x=1715673275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/ZP59gaaEc7rDJGoQ8grD5WHAafi5fzSlXp3Oliub4=;
 b=B3ggd9aBuLIMYY4CY70KRyTs00GMjQAPzg8HhwiwU+0OGzFPPIwBtRmomDhQwGS2G0
 rp0IkdtnhVFeJ28DizOUeDkm37KQ/z0i11zgKrg1HYfN1dMZuZbX6s2gGBGHuI74Ee/H
 TXIW3o0/R4JADKrPkjJxogim11T/5yVp2l7W2A0d7INeY2x9WUHEySDzaAQgn//j4SI1
 K/e3+HRhlJSnW3AF5063l3bY7viNdIQuc+OTIV9sFlPJF4rkhHKZTzN2lbc0jcxJcqdM
 xwwxGNB8jzDuDs2vaKmfcVU4FU2Ip+W5wyqS9nnJHoKcD/QlTI7wzyF9EFpKFkdXPz75
 VW8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7M6G/T5c2HDwpcg3dDYRoYSb0OSvNXxbRk0cT3f8Wol6CcFWb6aglmWQkfnKeU741SfN7iuf2wGs98Sw3t14lrkcWk4I=
X-Gm-Message-State: AOJu0YyCcfGmTN3mg6b5bMdJBI+/tW5jsV0UHNqf0Jv6EH4B4JIc9nf6
 gBj+u51m2tTQJUJOCHZisMZO88i3ooHIHiSNjWs1Sm2ngZimoXUmmzk1xdL5VWdYwCXf4sPT6xa
 N
X-Google-Smtp-Source: AGHT+IE6jQSTiaLkVIkBNCaCFb+z0Rif8kDDgmyk+FYtkN+QB+MfBhcFFv91MBTpeLD6c9lSIIpU4w==
X-Received: by 2002:adf:a484:0:b0:347:3037:188d with SMTP id
 g4-20020adfa484000000b003473037188dmr13749401wrb.34.1715068475116; 
 Tue, 07 May 2024 00:54:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adfed07000000b0034d839bed92sm12302230wro.64.2024.05.07.00.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:54:34 -0700 (PDT)
Message-ID: <8dac58c1-9fb2-4cb3-8753-596c54f48bce@linaro.org>
Date: Tue, 7 May 2024 09:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: Migrate ail-mode-3 spapr cap
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240506115607.13405-1-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506115607.13405-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 6/5/24 13:56, Nicholas Piggin wrote:
> This cap did not add the migration code when it was introduced. This
> results in migration failure when changing the default using the
> command line.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ccc5a4c5e10 ("spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/spapr.h | 1 +
>   hw/ppc/spapr.c         | 1 +
>   hw/ppc/spapr_caps.c    | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


