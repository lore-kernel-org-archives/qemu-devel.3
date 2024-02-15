Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E7C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racOu-0006lD-Jy; Thu, 15 Feb 2024 09:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racOt-0006kg-OW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:07:43 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racOo-0005Vq-2z
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:07:42 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so120708666b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006056; x=1708610856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fak3h2S2fdUxm+Gvh0uWUCezlhQiRY1Wnz4XuBbDs0c=;
 b=w3l2d5IUQDA+SQ8alVxHS5FbZ3W9RJPlexTOyVucxk5SU1v0HtFH35en36/URa9Hlv
 1cJ6LqEQy4KXaSW04V2IIbLU1cTW0anfp7hcziv0pCuK2mrFJdbtyZIBXgwwuM58huog
 KJDewhkoeWHaSwpbQydYyxqPM94vSXWiwocS0i+SWotn5wq2OKNTqD79PAPE1FJXa8o7
 15SDkihjbqlXewsIyUZrA67Sw56DzGyRXyYwPJCXF06iIBZAKYYzvpVV0JIkmyg4Bdyc
 3VoLTm71alvEfmeic4+M65/zpyfWnJBgAQTLq4jqAoA1e+YcqHM9e4+7ptifcTgcv/MC
 eQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006056; x=1708610856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fak3h2S2fdUxm+Gvh0uWUCezlhQiRY1Wnz4XuBbDs0c=;
 b=tY0jt9j+T1mkQIIpYPHwjnKsumMgVJeBsNUfXq/VwnHEEmZuiERLXN6ezvLHK4Ll0x
 Ygd1A7H7Er+MApCaPMIDWLbrEo7rZmkfzRzFXFcUuVoDQ+ZNlKb0PWgM5tT/+p5cCNqN
 Gh3lSFqx8gtVYpomf/q7UAfuQqOFMQlOIEuolotyfqOiAHkL77yoqodOG9OVDuqb3xgP
 h2kZEz302HsyGA/o5ApVYZ/K0ndkyPxrQQ9/ZVdZjRJpuaVnBvzFQdoHMp0CiTOtpBmB
 ZS5WppJHcNj2DTRknKMSaadHKqVgwbMllG2VB5n2naPArJ5fo+JCfvb0fr1TIyJOHkGQ
 taZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIjt9PmpZ9zd3l249dHNT4yTCGhO+DUQDAZqFyQ8AYaF9oaIlqKUfmvgiNU9M/mTRpJC7qgwtPDEGeW3D8DqVIij7I+aE=
X-Gm-Message-State: AOJu0YwffwpMD0FUqb8T+nN3XmoHYQR9+Kp1b0/tTF9ka+qjx+n/l2nj
 nitF6xnV40iZXWQRnPr6SwIhH5nKunqlOqTVUOgh2y8ULOEKw1ChcqO6tPdAupQ=
X-Google-Smtp-Source: AGHT+IEqyNSdbeMdZ59C1SQGm/YtDzJekc1TBGU57mHpNPlLnuUo5Ud+3YEZ6OGfpCVwa117vLzprQ==
X-Received: by 2002:a17:906:46da:b0:a3c:f6dc:ea46 with SMTP id
 k26-20020a17090646da00b00a3cf6dcea46mr1350831ejs.49.1708006056022; 
 Thu, 15 Feb 2024 06:07:36 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a170906241a00b00a3d7975639csm573481eja.206.2024.02.15.06.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:07:35 -0800 (PST)
Message-ID: <3da80312-81e7-49b7-a6c5-479309d79ddc@linaro.org>
Date: Thu, 15 Feb 2024 15:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/sgx: Use QDev API
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240213071613.72566-1-philmd@linaro.org>
 <05ef6ee2-ef3a-4137-994f-4a548b587d0b@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <05ef6ee2-ef3a-4137-994f-4a548b587d0b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 15/2/24 10:31, Michael Tokarev wrote:
> 13.02.2024 10:16, Philippe Mathieu-Daudé :
>> Prefer the QDev API over the low level QOM one.
>> No logical change intended.
> ...
>>           /* set the numa node property for sgx epc object */
>> -        object_property_set_uint(obj, SGX_EPC_NUMA_NODE_PROP, 
>> list->value->node,
>> -                             &error_fatal);
>> -        object_property_set_bool(obj, "realized", true, &error_fatal);
>> -        object_unref(obj);
>> +        object_property_set_uint(OBJECT(dev), SGX_EPC_NUMA_NODE_PROP,
>> +                                 list->value->node, &error_fatal);
>> +        qdev_realize_and_unref(dev, &error_fatal);
> 
> This does not work.  Here's the function prototype:
> 
>   bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error 
> **errp);

I was surprised because all my local tests passed, but then I
realized 'config SGX depends on KVM' and I'm on Darwin... Sorry.

> 
> I'd say a v2 is in order.
> 
> /mjt
> 


