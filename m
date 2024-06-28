Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F7AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNExa-0004ir-NB; Fri, 28 Jun 2024 13:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNExV-0004iG-Mt
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:00:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNExU-0004Ib-3U
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:00:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7067435d376so628916b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719594021; x=1720198821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bagi6TvphIUbU8910D7iyGU6bhlwzcwKNmA+VG1Qerg=;
 b=grlHxEEgwuXNr1cP2SaULUNj9y67HwNzAdc0fsC4wsDKInFQ5xnsp+Vj5KdjXf4ZI9
 PF2iX/NJNLbt94ET2rDUJ+KWuiNeOpwX/2o1Q1BsCLb1v9vAEVEIXJtOaOsVGSip/YI5
 X0hKeJImiK+44GMppmRJ/cFKGjIs4nFf7+B2xUaRZvvmM0T/xISwzTSXASc1tSFYctg+
 JUOPh/CpxFvIkcMzoW03AjF5gp76q4P0NFSkp4dYeReR9lXwxejGESb3cDCWtw7fgLRB
 U6eOVMPuTXdLK2yx7ngpbfzBNM8Kazm+5HtIWxVqV6vrQpRSp4lO/TYMkG6H+UA4psyq
 tAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719594021; x=1720198821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bagi6TvphIUbU8910D7iyGU6bhlwzcwKNmA+VG1Qerg=;
 b=k0kx2FqpOrS059FhlfbIkk8TyPGGzakluhJbMePuLOXg/vhqsKYldsY5UWNxkecxVP
 qHdtMJvHN4EYVfdaoopn0YzntUeCh+mc0oeCie8aJ50RftN1eLQmc5YXkB1eo9r6vkTF
 zRC+KaZF451QropZzjSuCIo6BcO2xWRFxhiHqbmmXwbLL73oRS6sn1cUm8kmhLEEOy9R
 nB860Ba6erTt2LU6wo1x6YBTlPHBaGamcdfn0i+CxpPDdEg2J77vgNXNXvIoxK+Ua0G7
 hxsXS8pS269eJvn+/pFZaUjapX9h+8I93m+sCtxE5DsVfA0H9i2/gfEUh5o7b0vrzAQG
 J9jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz1deV1Qv+M77TZxchXSGw8Yg1wIBu9qWlCoP5E8HVvwftKuBjeWPZsAx8k640R65gJ3fxdRLCw5lvQNFmpSCVthOwoqY=
X-Gm-Message-State: AOJu0YwOtLPjMSi4rpgizcUSEEZ0HM2p9cVk2VSHewrVSPH7DEPxBNaX
 25zlhacbQT7TbNH2cLft3YYea+79BPZM0QOg5mOVYLcwN5A1F4FyWunZO5/mdzw=
X-Google-Smtp-Source: AGHT+IF7lXFEo4FMPF7ZiF3qGBuiibAww5SNdUYnPzeF3QaYSW0+yseT8N5/YQL2qpovYRKGK3A4Ag==
X-Received: by 2002:a05:6a00:28cf:b0:6ed:825b:30c0 with SMTP id
 d2e1a72fcca58-708539a7f3dmr2934157b3a.15.1719594021266; 
 Fri, 28 Jun 2024 10:00:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080205a180sm1906772b3a.18.2024.06.28.10.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:00:20 -0700 (PDT)
Message-ID: <ea688598-b4a5-40f4-a749-c155ecc0988c@linaro.org>
Date: Fri, 28 Jun 2024 10:00:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
 <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/28/24 08:49, Gustavo Romero wrote:
> I thought you meant osdep.h should not be included _at all_ in my case, either
> in mte_user_helper.h or in mte_user_helper.c. Maybe the wording in the docs
> should be "Do not include "qemu/osdep.h" from header files. Include it from .c
> files, when necessary.".

Not "when necessary", always, and always first.

See the "Include directives" section of docs/devel/style.rst, which does explicitly say 
'Do not include "qemu/osdep.h" from header files'.


> I think we agree osdep.h is necessary and must be put in mte_user_helper.c. But
> that left me wondering how it would work for sources including mte_user_helper.h,
> because it can be the case they don't have the declarations for the types used in
> the function prototypes, in this case, for CPUArchState and abi_long types in
> arm_set_mte_tcf0.

CPUArchState will come from qemu/typedefs.h via osdep.h.

For this particular function, 'int' would have been enough,
since we only care about the low two bits.


r~

