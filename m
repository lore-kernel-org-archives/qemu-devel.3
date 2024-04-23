Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4BCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGbN-0001nL-Tf; Tue, 23 Apr 2024 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGb6-0001jG-5H
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:54:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGb4-0001oX-21
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:54:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41a0979b999so19071875e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713880448; x=1714485248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSt2RFTxXwLoA4VABAKy/xnYmHJa1hI8akZ4rpSi3zc=;
 b=o14Sqm8quknMJGDDIXYb0xuDbiB/kYdbmJeChyZk2CczsTFRlElETUfZ9zsj8kPNQj
 PR97pbFA0+YK7vDmGZmfKMJauIX1ekhNjR2cqBD2NOZQ2/c7ZwIlnwTjequqYyL4cH0P
 41Xzdlt14o3WQlQjaqSA2vDQ/3XnK8R+2gaE+6TcIZvTevtqqLj/YlIkucytJ5KTLMFC
 /S6xcHvOJR4LIUCGefXSOoKqdQYRKPAbHNqtwmNh7hopVERubWz4w656I4ozlK9QCG9O
 9GbGIIKFevhBlVCTDUXuaXQPcA9f6jyGGEcHk07kiJRbByPO/td5GissQNpUD5+quE28
 9KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713880448; x=1714485248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSt2RFTxXwLoA4VABAKy/xnYmHJa1hI8akZ4rpSi3zc=;
 b=mQG0NCy6S1K6MNAvAWpcndTxvyVJmXwtyZY9cqIEvxstuO98rV6IeKGmHm4IC9BOP/
 /8IadxcTQgaJl/ZarJYmP2nuaQco2Tk2eLqn7+nvB0NV2hStVCuZpz5YIPTrdVlJg/YL
 c2VrWxZCOzQV7DYiE+XxzaDcBRXmD9vWasE28raWBz4yvK8zSMCtkhmiS1g6EnMVQK9E
 2nbphiJXGCP79EX5urAKsgBdEUsK61/+B5iioguHBvU2kMaOsTdNaw3EvdFLsBqT0Qwm
 CP0REv1asu8l2lNR6SzKIiiouiAolXaBcYChVsDH4tCivUXmYKCSOKFB1HADS9BNqHhV
 jM6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DqpMLrMwOTKoi37TmYlQo7L6XEYVh+yRNsBF68HJ95L+jnaujfFrJvz8ZdBJ20rHl/u1jwYPf0SXd1qC/2dYWWIXTuQ=
X-Gm-Message-State: AOJu0YzWA8BOlFruH3PXbmcoAj6w4j4dxj+3bNbnP3Kueip/0uOHtWhb
 A82chvp57fBsX/XRdmJX2Dsx3Wkj6M47och5rBH2ePQ/I+R5urIRdi286ttacIk=
X-Google-Smtp-Source: AGHT+IFs1tKdbqkeLfYiLV2KV/t7YCFKSgwzqq7BeGm2fvGM1fSdEqxLqdt9AF8ohYCqg9VWY0EetQ==
X-Received: by 2002:a05:600c:4e43:b0:41a:8b39:8035 with SMTP id
 e3-20020a05600c4e4300b0041a8b398035mr3421445wmq.9.1713880448086; 
 Tue, 23 Apr 2024 06:54:08 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b0041a7fe7a300sm5471664wmq.26.2024.04.23.06.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:54:07 -0700 (PDT)
Message-ID: <cf8fa898-8697-43c7-b20d-0806b37b459f@linaro.org>
Date: Tue, 23 Apr 2024 15:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 01/21] host/atomic128: Include missing
 'qemu/atomic.h' header
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-2-philmd@linaro.org>
 <6987ccce-82c4-4598-a281-9818d2975477@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6987ccce-82c4-4598-a281-9818d2975477@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 21/3/24 18:05, Richard Henderson wrote:
> On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
>> qatomic_cmpxchg__nocheck(), qatomic_read__nocheck(),
>> qatomic_set__nocheck() are defined in "qemu/atomic.h".
>> Include it in order to avoid:
>>
>>    In file included from include/exec/helper-proto.h:10:
>>    In file included from include/exec/helper-proto-common.h:10:
>>    In file included from include/qemu/atomic128.h:61:
>>    In file included from host/include/aarch64/host/atomic128-cas.h:16:
>>    host/include/generic/host/atomic128-cas.h:23:11: error: call to 
>> undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do 
>> not support implicit function declarations 
>> [-Wimplicit-function-declaration]
>>      r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
> 
> 
> Nak.  We can rename these host/include/*/host/*atomic* as .h.inc if you 
> need, but the top-level header is include/qemu/atomic128.h.

Patch available here:
https://lore.kernel.org/qemu-devel/20240418160943.95047-3-philmd@linaro.org/


