Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA0AC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXRmB-0003fC-Ii; Tue, 06 Feb 2024 15:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXRm6-0003er-Kb
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:10:35 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXRm4-0003aO-Ha
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:10:34 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-214ca209184so4204468fac.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707250230; x=1707855030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDrV8/y9IikSi52rZDgFDEB1bT0pc+4WpLRznZfIRUU=;
 b=nVmTNPt3Dl7By3wv1QVq4n65E/hxXkmPJxHPs23QCowheUD57xNTBEdjlx1NoaN8m+
 fYhFCFuihLPeLqWzgz+CgipcigL2zjGu31UosmbiNvQIKvdVPsna+KUe8ZdEXWX/vEH1
 h37KNzOaNApCiHu6KP4/6A47XCJfRpMlUHtb1nMdjWdkBoYYuq6QM9wkNIMh6BLtTX+O
 RwNnIlbA7PL5ADnZLfns1LtCgH0LGUpmr7+5fbPA6kYAB83gzbJ+J2bChiShAhk0DvZR
 m0wVC2IkxahfjE00PNequXk+X7SeGrK/78og0PrzLtHRvchaXNbPQfQwLe8LtlPWNY50
 b4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707250230; x=1707855030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDrV8/y9IikSi52rZDgFDEB1bT0pc+4WpLRznZfIRUU=;
 b=j7tEWMA/tBh/d3PXrUBkbv3XVMLZjxgUfPYsRxBjOhGV3U8QUpd/wMh41it6rVGKKU
 8QBdNR/R0lflzhjVrL7BKo3USE0WD366lPzDT3o1YsOjZcM3RMa9wxVPXnB/LZwBVaUD
 aynPK3lhYhrqf0NE/SuFXzJysRLFjWF8mtcc25nI67M6A3J+1M1AQJJ914rh3hpti1l0
 smo9o5mhGiNnZ86wcuDx6ij1YfMtMK891zdKC8zDSQ+d4Un/29BdA0jQYbbivEjXJUuc
 Fq925D7GnbMoVwMY47P397lbsFI9vhtGENZOextj9gr+kMx6z037KeVzqddcoUuRiZpZ
 Tq/w==
X-Gm-Message-State: AOJu0YxVZ1pJUZ3YV8FTLrMwP+pu6/158PHjwPzqrZGTwLfVyD/S4J42
 nbYiIHOIp0VgU1UZLWkLF5CgM7CHeWwgEWgtNoihbsodNUibqe1bmkbt2KGJ/VE=
X-Google-Smtp-Source: AGHT+IEVvxjRuCxHPYRA6x3eYvxTub6Mhchntj46e2m48JbaXnpc7J0XgMb9i6XV1NcuBofkEly8zg==
X-Received: by 2002:a05:6870:6112:b0:218:dfd5:a5a6 with SMTP id
 s18-20020a056870611200b00218dfd5a5a6mr4105910oae.2.1707250230255; 
 Tue, 06 Feb 2024 12:10:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVsL6rOckra9+qOn0K3O+8+SRDdYEjkBsYFPcRTNWCMcpdFEDdKfMZ/ozFlqjWtcZT4OqypvJhba0P4WnsvLpRkAIbpbqrurzC8aM+CWsMVXKZmfru7ojDh3t6/cpqw
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a631a57000000b005d8e30897e4sm2518063pgm.69.2024.02.06.12.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 12:10:29 -0800 (PST)
Message-ID: <75779607-c0fe-4a3f-8555-db26d9894b99@linaro.org>
Date: Wed, 7 Feb 2024 06:10:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] target/arm: assorted mte fixes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <CAFEAcA_+H-HHCN=WiwNjvOKRuVU=A-TnsosCSf9aTF_VjSgR8g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_+H-HHCN=WiwNjvOKRuVU=A-TnsosCSf9aTF_VjSgR8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/7/24 00:54, Peter Maydell wrote:
> On Tue, 6 Feb 2024 at 03:07, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The first patch is unchanged from
>>
>> Supercedes: <20240131003557.176486-1-richard.henderson@linaro.org>
>>
>> while the remaining patches replace
>>
>> Supercedes: <20240205023948.25476-1-richard.henderson@linaro.org>
>>
>> While digging through Gustavo's test case, wondering why it
>> should be failing at all, I finally noticed that we weren't
>> overflowing MTEDESC.SIZEM1, but underflowing (-1).  Oops.
>>
>> But I did find a few other points by inspection where we
>> weren't properly handling or supplying MTEDESC.
>>
> 
> Should some or all of this patchset be cc: qemu-stable ?

All of it, I expect.


r~


