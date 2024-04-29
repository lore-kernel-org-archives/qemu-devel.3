Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4D7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QxJ-0005Rn-GI; Mon, 29 Apr 2024 09:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1QxA-0005Qz-2R
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:22:01 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Qx8-0005Bf-3E
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:21:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5171a529224so5614799e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714396911; x=1715001711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jljxZJGISWC3e+SDlGvPM/yJwLLe4lClxBEZcWzHTxg=;
 b=y/i2VBSHOqzyNHazAfEXopRx5fa0y3NMeA8+wCa+m4ZhZeeANEdTI12zveQLI23QGX
 MS0x4bU4VtcaXFe5kKEl2MRRhLzWjc7DPBUI68HLVDHwPOuNSlCKRYEDdNIMODVX241P
 yd9BtOPubXEsoSAhS59nn3Eq8nm6yULtmejU8MJNFi9ZnuWpySy8cy6i3raKB6i37E0S
 XMGO5wdMXHkK6kREEEH+q8pin2lgPxaC0sWtQr4L/lN1VMrdn4Zz5VRyJpVKHIjvk38M
 l2IhriZBYmVCl13IddCWsVHvQn2rNtq395J0pAqIYlPmu+bvSbvKx6jBRmIJ/TPC+SRJ
 0JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714396911; x=1715001711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jljxZJGISWC3e+SDlGvPM/yJwLLe4lClxBEZcWzHTxg=;
 b=HEZx5kwWlZmAJ+g4jlGPDmbZCX8Rk+4Sv6xQeiVqg9shN2cvBrCFbMhBalIYUm2NGG
 ucnHiOYOwPaGhJcJQfYlw1PzErgbkhQ6Xp1gCVYeNuiMxlKRVbVEBuNfothYjlG1buDl
 o0GtzesY4E2qDF8M8Y57zTMzmC6q1EBq3fX622irFYEl8d/xSNl1OEG7mg8I61aBSKEs
 d3/wV4mhoh6wbQ0wwX/9VIo5N7O67/xACdmqH1AnKWrsl3888T48Km/DaFtCfJ/d/E7L
 AzQtZdhw6ogOdFOYUbF0nrpwvOI68bBRwPG4GYdc+HlP0BOT8+emUS2HAWXqhfx3g/aI
 HPSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm0TkkYXj6B2FMCMprHMpLgHjY41s3CMSgRswugWCpuIVYpxRJC0EqzZ66PPkoOoop9Rtel+afnxLY16ho3m2LVagnSDg=
X-Gm-Message-State: AOJu0YxaPuYQJ7KYR8cSi4ICxBCrVaIE22BcQ8nYh1faxFoCS1Ca6SgJ
 gUSJPoMGrktI82xuPaENyCHWDm09iX/B9eyqpMl8pF/dYNiATe9vO2JOYcjC1yY=
X-Google-Smtp-Source: AGHT+IGb9nqz2b5Mgixok5BmHg+gfIR2ST+JuLbQxNfrHAad3ZbKGZgOv7pVtNrWF2MC1eRlbAGKeA==
X-Received: by 2002:a05:6512:220b:b0:516:a091:db5e with SMTP id
 h11-20020a056512220b00b00516a091db5emr8399950lfu.48.1714396910461; 
 Mon, 29 Apr 2024 06:21:50 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 j42-20020a05600c1c2a00b0041bfa2171efsm7359190wms.40.2024.04.29.06.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 06:21:50 -0700 (PDT)
Message-ID: <2f89280f-b26d-434e-8ac1-e48fe13243f1@linaro.org>
Date: Mon, 29 Apr 2024 15:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] util/bufferiszero: Improve scalar variant
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-7-richard.henderson@linaro.org>
 <400f20e7-3c33-4916-897a-0d6b21d572c4@linaro.org>
 <80f07930-e5e5-496b-ba08-6091ebe55c1e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <80f07930-e5e5-496b-ba08-6091ebe55c1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 29/4/24 14:31, Richard Henderson wrote:
> On 4/29/24 05:18, Philippe Mathieu-Daudé wrote:
>>> +
>>> +    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
>>
>> Here we read #0 and #31, ...
>>
>>> +    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
>>> +    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
>>> +
>>> +    /* Read 0 to 31 aligned words from the middle. */
>>
>> ... so here is #1 to #30?
> 
> Not indexes, but count.  There may be zero words remaining in the 
> middle, etc.

Oh, got it, thanks!


