Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B732DC54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKXH-0001iI-EY; Thu, 07 Mar 2024 15:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKXF-0001ho-2P
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:40:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKXC-0001Wi-RM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:40:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso762475ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844009; x=1710448809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jeq9gSKzeoxfVpU5+KRTxtVJY2HCer0A1/AnLyg+uMk=;
 b=iuL1QsjI8ZAWk2cslvo5IecTJfx6W3y9MDS/d8C4RHTzy6jctOjAMmetmWN0ye8zCX
 jeXjIX2+udQ1pzimsa61CiXGqUhN5K5CE4cti+3JO5Acpu72M0rEu9llVb2H1VI18rdz
 PW2fpeM0Q19Vp0jAV/jGENvi48TtynlXyZIHpzbF9JYZEpfpjwE5PMEH6nzNKGUgtEtW
 AUarlPBUWPOC8tQFlPiSK1D/fYv1W+PnBCMtSidUfHB3LHmredZKfGYlpuIwOGc7yT9y
 glPzATDziwMf+sTF3rHSv6aZw8Us07HKv6eZ4F2KuvwBUZDRQm9OIUqb1sw6vAz5t6HF
 wV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844009; x=1710448809;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jeq9gSKzeoxfVpU5+KRTxtVJY2HCer0A1/AnLyg+uMk=;
 b=lFp4BmqbHHNAGN+T9B+gTy6tCl0l1UK4DYz4W6OrFf/XSiZhftu8Y6cwWrjkIJvmM6
 Eex+KJWwC1fOmclJcGg7diZKbae78ZjRIU51vxo0KbsO2Cy/YkkTMEcKemTR6LXY0SU2
 DQ237jYHEAVqG8UjX552bc30kdrUVLW4WiBbyuuEhlvY0oKTXP+DaZYaf8I9pSdbL6Tv
 iR2sg0s7qSFAmGFV1y2K055mA4XTYwBpk1R8hNHMzk8InGPCErDl8ho30nU1hqRuoWrJ
 arxmRho5gEgz2vaAu+KIcETqWsXxMp55zvqnWFNL1V0SVLl5lI1gEwTUvVKp+GuhpIn3
 WI9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgUpaYyE2878A/Jq8tRUaODa9f2bmG4GyfiBbrQNtbyPEb5sZPs0dLZfBT8PECbs1xG24i25ScuY1qJgbKZ4H41ttwu4o=
X-Gm-Message-State: AOJu0YxnQ2hxELzjduHkkoCwV5hZzoRfFgebItQUP229qS4jhEt4bKTA
 hUmsH11VYUbPAWrsmUDFBKdSGCD97ElADiwKttZJYDcigqUniR0hEhKVBLIjO1g=
X-Google-Smtp-Source: AGHT+IEHp+jwMLyU2ShYRHY9jFXeiXS4aIz9/IcZwa/dK0uVvbMVYFO2ALXgFdl0KJv/JZrOTdVJPQ==
X-Received: by 2002:a17:903:2348:b0:1dc:d4f9:ef21 with SMTP id
 c8-20020a170903234800b001dcd4f9ef21mr9723348plh.52.1709844008959; 
 Thu, 07 Mar 2024 12:40:08 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 w7-20020a170902e88700b001dba739d15bsm15109796plg.76.2024.03.07.12.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:40:08 -0800 (PST)
Message-ID: <4a559ba6-c467-4bdb-9a8e-780850413aa0@linaro.org>
Date: Thu, 7 Mar 2024 10:40:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] include/exec: remove warning_printed from MemoryRegion
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307181105.4081793-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/7/24 08:11, Alex Bennée wrote:
> Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
> field is unused.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/exec/memory.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

