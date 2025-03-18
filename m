Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB946C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufXW-0000sI-Lb; Tue, 18 Mar 2025 18:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufXQ-0000rF-KG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:35:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufXJ-0000fH-Br
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:35:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22423adf751so109368895ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742337345; x=1742942145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OcpXmFjMO3sTuEr069JPwJK2tK4LKUaxYfppJkr+u58=;
 b=Tr4wjUiF5u196NwEWF8wYixgf+7Zux21OziwgEGj52j/BNGUZHUtk+Q5d5gjVL9HKm
 LaOpmM9y0Edwdo5RP8D1nDJsGxtqUufzJ1RUy771RjaYYDIu3FMAin6SjffL6JZJZBfC
 jWSMWTmZ19HXFO7BMmHnkbeZEcsTwjhgTTTCV+omdZt2kp7rysZl0a3SfGCnT4IoRLGQ
 abrG5ZVS2Ir9t0ZXGM5wfzvkPHuCL5lg7vsJ6mllQb8eWXykn7k5QKiGo5ehe2svS0ge
 nkQKaBo0RYF1WSo1y0eVSNGG+Z05A02/08RcxLM3DmIbr2mc12Lqv9F03FC+iM/GxiNx
 MQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337345; x=1742942145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcpXmFjMO3sTuEr069JPwJK2tK4LKUaxYfppJkr+u58=;
 b=Aaef9Wg1GjFieGh8r5rSXb8eOyB3ZYFf+Ml5oufkujB8a6pyqueJRV8jnV4xI3M+7p
 Q+ONqzrFkWVTnmnY2sZmygtfPepF7A98GqZkH5pXbeIGjFvw/jg0oByXtb6BAGnqJrF/
 aCiPK1AEP+Pp3MpNsY/x6HFCoFCu3Nz0ceFJuQOf0iuiV4AvOKT7vvXG0VjmEtkAEY5/
 OJRhy561fbgmXNi2w1q5cpASjGaAGuhepKybg8zPv/T1NeRBKnTLZrIEpx+ccZsuGSX0
 RH6bw3CZgTM2gaXDwz1XVb1iw5DVcZI0d/t8z4JqiDm3sDOYS58viEkpZic+Yp5Dy7R5
 +ZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIEvv2EUskaNNwaS0JkTBuhHtpqHGk8Xgxlss5on7BWSmb1vkRc8hvRXvEaqSloS4gw9EDSPcnyD/L@nongnu.org
X-Gm-Message-State: AOJu0YwSonxS3K8sXHTMoKgvjxV1Us+BMsg1LzjGs4d2pRoLgzyxLj1y
 XRBW5qqT8ceVxtddCEG6zOw7F3YnMOEQ7/+TXF7uBum1G/G5niXEYRGtYvdvHnE=
X-Gm-Gg: ASbGncuw4J97ac1eiGfDUKIk12vsEoyGWOtLpb/xrI+g/9X0+FD10ULIobYYbktpG2s
 9kz/zjGbyGuWibv/5BaB0lzlz1mqChLZDhYSMrVCYzizsqTbH9UGizft6us4CZ68/Vro528N+Yd
 QwKg7/CYaCktkPFh2kXPIBAG+bzkTiknh7nISTP6glu4iWmbgHWiYZRU7X0nGOhQIvl4ZA/wuye
 Le80vO83VGQxKMgdL/HkOklfswJGwqhS9JGrly6zsVlGku4a42zdcqZXnOJ1Z/mVvYgYwkCXzYI
 yev9I8r6oV6NPb7IlXIhDYp/QxvrfNgHXHK4ZQyx6UqSPsBUs+3epv/PwQ==
X-Google-Smtp-Source: AGHT+IEt60b/xkcu869FuAeLSGYbURqATeqh+waGHDsaBv/jurzyPKhT+Oye2N3wcUB3foD5o0iT/g==
X-Received: by 2002:a17:90a:e70f:b0:2ff:6ac2:c5a6 with SMTP id
 98e67ed59e1d1-301be205cd8mr503863a91.31.1742337345425; 
 Tue, 18 Mar 2025 15:35:45 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6a08sm100286865ad.154.2025.03.18.15.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:35:45 -0700 (PDT)
Message-ID: <30e72d8d-a4cb-45af-b57e-a0910bbe06a5@linaro.org>
Date: Tue, 18 Mar 2025 15:35:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] exec/cpu-all: restrict BSWAP_NEEDED to target
 specific code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-2-pierrick.bouvier@linaro.org>
 <2766725c-9287-4ba6-9e14-e84616d5fd17@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2766725c-9287-4ba6-9e14-e84616d5fd17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/18/25 14:41, Richard Henderson wrote:
> On 3/17/25 21:51, Pierrick Bouvier wrote:
>> This identifier is already poisoned, so it can't be used from common
>> code anyway.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h | 6 ++++--
>>    1 file changed, 4 insertions(+), 2 deletions(-)
> 
> I'll give you a
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> because it's quick and correct.  However, there are only 8 actual uses within the entire
> tree (discounting comments), and all could be replaced by
> 

I hesitated to do it and get rid of BSWAP_NEEDED completely, so I'll do 
the replace.

>> +# if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
> 
> 
> r~


