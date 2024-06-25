Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A978C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzKD-0005bk-3z; Tue, 25 Jun 2024 02:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sLzKB-0005bM-CU; Tue, 25 Jun 2024 02:06:39 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sLzK9-0004u7-JV; Tue, 25 Jun 2024 02:06:38 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so62497911fa.1; 
 Mon, 24 Jun 2024 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719295595; x=1719900395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1Ocl9vGWFzKOfsBS3B1qV9rv+MI2P8LnccLr3V2AHE=;
 b=MCbtVmjp7pP6bzjbG7F87YkIU1jk5m5Pnkg6rSMzNkuA9SxlDN71uHJsSiscmDu5mp
 V71pGwCZ3A+0QumA4hKCkLkD6lklITmbzPL46105Gao+7FXGO595Rj+vPWglYMS7Mpj6
 v1fUzt7zD2gZZXAuHXciKwtZ8Dr+JYsEHHl1J9zvU3qAm/S77tOGKHnN67bYNghKTxY/
 sJGhTzK8HmpZxUNYNSL9QP9fP+6te3MGd2YPKsAOKA4s6NPVNFG1PfSaOA5JYKQ4PJ7x
 hTukQ/xRYgduCcfxKgB2SYC/GDuxkLVTjQsTJPcvFWlnZI17lb30XyfO5HjTrNnBNhOl
 eUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295595; x=1719900395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1Ocl9vGWFzKOfsBS3B1qV9rv+MI2P8LnccLr3V2AHE=;
 b=iy2wopiQNsahqJ7lTPRpZWjMNRnVos9E1ysX1b0cHT4xRqyuEJ1nKBkcmd3Od7ExEc
 otO6U39ypyqruXcFsMddyQKIpevNQFJXvBBN6dyxpHFdlWY+bd+yDEJS6FqldUesINdR
 ZhpMVW0+GlBPl/xL+S6BP42B8x3AXIV14hT5h+KgCX6uSH0x614S7JO5drIeePXxOutz
 rpQ646jsQxnCkVlpjQ/uLSD1knmgDFWqxgEtOQtR0lu9qaC0NipHPm6hEVsLcZ8bMfv7
 ESPiDJSYaFOg90Oz0zGPsgBoZl0GIoY9BVMle6hdMPj90149T+p0CdJ31GKRktm1NuDn
 bnrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCKaSiITZCzrSfu5ZA9KupEbRy3oqJZqpmblCi+RYRFWxTrNreu1BLO5ZYeqD57bZ7NYsSyPYnhar0kNRpgnq0Hf96cPGbglBAc5IoayCVCx9vNrCXeuHndms=
X-Gm-Message-State: AOJu0Yyc0Qv76k/4qh6hSpYIetennBvIvB4UJkXE+S69m+J26ii2xcuY
 bO3c/AYZ8JK7V/cSLbwIejEC/II2jxzqlwnMZEm02sAUVBsKNdO/
X-Google-Smtp-Source: AGHT+IFuWHsEwer/JFWynsdtCqoWnshs2kF5wM5/XYuc+tZBgnM8NdiBQNOgnIH8KB56/XYesi5uMQ==
X-Received: by 2002:a2e:b16e:0:b0:2ec:56d1:f28 with SMTP id
 38308e7fff4ca-2ec5b2b1ce4mr37533211fa.26.1719295594868; 
 Mon, 24 Jun 2024 23:06:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:136:9c60:df8c:dbac:5023:d101?
 ([2a01:e0a:136:9c60:df8c:dbac:5023:d101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191fac8sm157359755e9.42.2024.06.24.23.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 23:06:34 -0700 (PDT)
Message-ID: <d698609b-4760-4932-999b-4d4754021421@gmail.com>
Date: Tue, 25 Jun 2024 08:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240625015028.1382059-1-jamin_lin@aspeedtech.com>
 <20240625015028.1382059-2-jamin_lin@aspeedtech.com>
 <24dbb79e-cdcc-4415-befa-e6351c8f29b4@gmail.com>
 <69656db3-24a7-447d-b2b2-49a938744be4@kaod.org>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <69656db3-24a7-447d-b2b2-49a938744be4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 25/06/2024 08:03, Cédric Le Goater wrote:
> On 6/25/24 8:00 AM, cmd wrote:
>> Hi
>>
>> On 25/06/2024 03:50, Jamin Lin via wrote:
>>> Coverity reports a possible DIVIDE_BY_ZERO issue regarding the
>>> "ram_size" object property. This can not happen because RAM has
>>> predefined valid sizes per SoC. Nevertheless, add a test to
>>> close the issue.
>>>
>>> Fixes: Coverity CID 1547113
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>> [ clg: Rewrote commit log ]
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/arm/aspeed_ast27x0.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
>>> index b6876b4862..d14a46df6f 100644
>>> --- a/hw/arm/aspeed_ast27x0.c
>>> +++ b/hw/arm/aspeed_ast27x0.c
>>> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void 
>>> *opaque, hwaddr addr, uint64_t data,
>>>       ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
>>>                                           &error_abort);
>>> +    if (!ram_size) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: ram_size is zero",  __func__);
>>> +        return;
>>> +    }
>>> +
>> If we are sure that the error cannot happen, shouldn't we assert 
>> instead?
>
> Yes. That is what Peter suggested. This needs to be changed.
>
>
> Thanks,
>
> C.
>
Ok fine, I didn't see the message, sorry!

Thanks

 >cmd

>
>
>>>       /*
>>>        * Emulate ddr capacity hardware behavior.
>>>        * If writes the data to the address which is beyond the ram 
>>> size,
>

