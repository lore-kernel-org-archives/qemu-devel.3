Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4664EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTu7-0003j0-Kb; Thu, 15 May 2025 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTu3-0003T1-41
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:25:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTtz-0003OU-W7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:25:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so4943905e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747297514; x=1747902314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CJvOp+Uq+UMPcUG3rsEofkLXmUXiP/EYIEzYRZwXU9c=;
 b=HWdlGAH1FDMKSZhv7eSc6Mt0h27jMOBKcD7A7WSP6WffKXCaptzRlmnM/mcei3ajNC
 xO49+BlAHBrrHEuNcZhwDLNpTgcpUWQrhjyn/9xQKRbSwH7VNhnIvgIQHPtB+Gp4P7vQ
 vpB/E25nSXCyo9Th+jlfShlm+N6ahITioi8eQGyCY8nkd3TELW59evWNwtudIdA5CaEB
 vlL0RxI0Kd8xfi+WlmGpzEyK15PBLYyPsnSMFM6DjnvK6wm2u2PAFbCyNIkx56yjIIqK
 ebdfJjmzpK5QB8AOmXYh6vfNKlluqwN1cG1/gmAclOwOtd/9J2ZNmM054LKREWuf9Qmu
 1iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747297514; x=1747902314;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJvOp+Uq+UMPcUG3rsEofkLXmUXiP/EYIEzYRZwXU9c=;
 b=euIjaCPUov+SNAAtoRxJ3WUGPO40sYiRKAmiN2RlAILpM9O7bNHja1axMcaPwi7uj4
 05g40FXyoBVm4vCo1rm2Qy14ycKKe/vpNTBDLjAzUSF5S1/wXlseUWMnZxb/YixwL8KR
 al6RtxoaZ+KzltYB82dPenu1dT29fBThRe+usyTWCDWJGr7JVz6dcbbm/IvlAAbsJbab
 Lv8Oub/I5DNyHD8RGsbRx3S9SKna12WMv/g+De/JoLk8+AHg3JNBgnojaHne4f3vqKa7
 WCoX03pPVKow23sH2DWNlfBNE5kAX3BVuZx4C7KMMYCDILQS/8JY5th9HJkt7fV8Bz6a
 pOtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHde0JZ07mXvINQtaAJS0KRaftOXStB2O5KyPcigHAKCzTKcfVWGI8yq263ajhKACmKbnr9sqoBEvB@nongnu.org
X-Gm-Message-State: AOJu0YzxgiDMg4jeyqpDmptc2nIjklLwGYHNGYLbjwcpnpVsKBgSt49m
 N+ACegagPup649GbJlUgyPaQlK0jNFXCSN8hf38tzyI8OiVjtAvtNF348OUXD6A=
X-Gm-Gg: ASbGncuqnPlBZobT9yaz55Oqfp0amvxO1AVnbQL7RtcH8kAbhj3OVwP4/+glRMIigNu
 HOQEn8kug9qWAbwBFbLx8ayV7k6uBp2kYRgbRXfJeqlvcf5hflYIqRbdKT5Azo6gymhim1Hb6xj
 I+YTAgbTz1giDOQEi4KCMnOFX3UrvcRlQNOqKHg+C5sGkSi48wP5YgHyk4kOXgZrlO6E93wRlia
 VY+Uq8xBWF9O9pzDnGSGvfc6dyrWasRhHhxMda68Izg4RLzYeZIdc+xHyqo3HnYRYNQeCfRo9YI
 tCjuv8gmugADAG/qsP67HypRoeVe5g5XwgCQLa0a+5/BSMOIc5/uvMhDXaCSiMQ8SCmwOKcTqWE
 8xVkMLbCdNx3OElg=
X-Google-Smtp-Source: AGHT+IEAEC2CTrkt7+ePC5uOo550n1hj4Uqi1M8hTeNQQgmfuxIlET9HhPVPvKV8sanKXQ3bk0IwyQ==
X-Received: by 2002:a05:600c:64c8:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-442f217ab9amr56651055e9.33.1747297513746; 
 Thu, 15 May 2025 01:25:13 -0700 (PDT)
Received: from [10.61.1.10] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db95sm60738805e9.10.2025.05.15.01.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 01:25:13 -0700 (PDT)
Message-ID: <c206ef83-aa2e-40f5-b1b3-bada9c090f1b@linaro.org>
Date: Thu, 15 May 2025 09:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] qapi: make most CPU commands unconditionally
 available
From: Richard Henderson <richard.henderson@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
 <20250514234108.3746675-10-pierrick.bouvier@linaro.org>
 <176d584d-386e-4c27-ad2d-57838f599016@linaro.org>
Content-Language: en-US
In-Reply-To: <176d584d-386e-4c27-ad2d-57838f599016@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/15/25 09:24, Richard Henderson wrote:
> On 5/15/25 00:41, Pierrick Bouvier wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 476dcb46683..c2a6e6d1c1c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1927,7 +1927,6 @@ F: hw/core/numa.c
>>   F: hw/cpu/cluster.c
>>   F: qapi/machine.json
>>   F: qapi/machine-common.json
>> -F: qapi/machine-target.json
>>   F: include/hw/boards.h
>>   F: include/hw/core/cpu.h
>>   F: include/hw/cpu/cluster.h
> 
> This hunk should be in patch 7.

Bah.  ENOCOFFEE.

r~

