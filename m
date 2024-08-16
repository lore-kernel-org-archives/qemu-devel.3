Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDA5C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serrk-0005eq-V9; Fri, 16 Aug 2024 03:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1serrj-0005cK-IE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:59:19 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1serrT-0000PV-Nk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:59:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so224471966b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723795142; x=1724399942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQNlL0j6yonIaPCQzgG4dPlkY6Yhmk47cyY4q1c8dGI=;
 b=mZ+7kELIx/FdN70uLQ64JjdGecm6Umvr5M8DVWZRccQ6woV2u0L7rn51f9g0ujKpMv
 fL9gDGkH1DZpFby8rxkNK4iU5p16BATH+tj+aK6/TdRkl2dpbpWzl0D1iXCzYqMY05t4
 MsrI/Lr0PJBMKsqlT82a3fH+TLWAVDW+LVVlP95e9XlLnhauv9SOXTUFPmgw4G9wwwne
 B0Llf4fwVKFY+BLvmva6V4a+rGivl71nYOJPxNOUjsQ4v62b1Hy6/HR+IpuRXEASUqup
 q0XnIB7GC0rfhlC4H7SHyq2AaEIihJVqy+7pRbBrUjS8BByq+Kv3vq8PhQdxdE7c9Gef
 TI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795142; x=1724399942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQNlL0j6yonIaPCQzgG4dPlkY6Yhmk47cyY4q1c8dGI=;
 b=LOTG/i99CzSp03AUGY+Id9+KkEHVsHUO381dRp7EhRl7pBj31i+lOelaBZuhyzXsiO
 Y1i2fEyDAATe+Eyt15M6tQHVfqmnDMZoJ9laTF47i2m2tmprrT2ggZ28AYI0JSDkl/b9
 aS1dnJC1hGt6rHaCFjRE61AkLd1OPo6Y1Z7H0mEDAO3aNy5PTMsk1a/8GeqIJexbsrUW
 fTfb9e2Ux7MHK0fMeHenP3VKxCkpQUcYUQKs4QveowTd1cWUILZ/6pFLoAE9Vcy0ynXA
 yySWuPs6ND48sCnZGET1xATLRoRTbBLnZ0FaMFWDvllpIqaO9kNmeIoHi6tFxOWWdegx
 SiEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlteqt7zfnNE28HR+mffgioDfADQV4LFZ1lZpq5FeZnuwBX9AQCbSKbmoKHr3RQpAczhAWE4n7rkqpIgfqj91uNYT86mM=
X-Gm-Message-State: AOJu0Yy+p0RFPsbDkD/W2MC+wvQx43uSgyqJpFo0r2Yi05x/gaChxF7L
 dEQmdRZBTM4VuJH6AtQW/4Fw8Nj4M8frxN7ZV2o6mp4yrpYxaihy8G+rj9Sfn3Cw25sNks8ITvf
 LDRo=
X-Google-Smtp-Source: AGHT+IHtqh4J+JKKxMKXKgmFpySPeI7XpKZ6d9zgsTPPwGPWBFxf5fIayTzvYbCXJ7zCOmMKRfJiEg==
X-Received: by 2002:a17:907:944a:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a8392a3bb13mr131463966b.42.1723795141680; 
 Fri, 16 Aug 2024 00:59:01 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfae7sm215852966b.58.2024.08.16.00.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 00:59:01 -0700 (PDT)
Message-ID: <cde5b677-66e4-4d84-adb5-26136c5c842c@linaro.org>
Date: Fri, 16 Aug 2024 09:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] target/sparc: Restrict STQF to sparcv9
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chauser@pullman.com, qemu-stable@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <20240816072311.353234-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816072311.353234-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 16/8/24 09:23, Richard Henderson wrote:
> Prior to sparcv9, the same encoding was STDFQ.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 06c060d9e5b ("target/sparc: Move simple fp load/store to decodetree")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



