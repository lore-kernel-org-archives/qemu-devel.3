Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC77BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryx0i-0002pt-88; Mon, 22 Apr 2024 12:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryx0f-0002pg-CP
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:59:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryx0d-0003PN-Mk
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:59:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso4645914f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713805152; x=1714409952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYKWjO6YEVkxbSi4wBlU5mdC/+w1+5yrePzG+j4mI14=;
 b=ziC2ZNBx/GuIe9l+tAc9E5u2xKI7dtqofFyizrhfNh1skH/DR3Y1JYw0GMfJ2HJCbk
 BBKfifnliF4dIBe9n8qC8+C3Dblv5qAUgF6nbkg4Vnfl9P+sb+1o6MN0O0fP91JuVCOw
 /2tFoGoGeSrQNlaM+D8qDFdc6QvabddkP8Rc+qqvdcYxOezBvuuDNiG8CHrYagtpcvpz
 t4ZGURKHVnnEXqgfjlMYWdKWfcfqE1xJPw77z/gMt55uADjbgNdWgjngIwMi2Bvk2h8s
 52mgO2S2nGbN71I5yFOHf0/eoVOBdm0xt4HbEBwObyU2Ft9BMf9Z8bMKyHc+stbXkIOL
 OZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713805152; x=1714409952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYKWjO6YEVkxbSi4wBlU5mdC/+w1+5yrePzG+j4mI14=;
 b=lpXC7frumPRTThxvuhqo49hYSdPEYv+y7spI7+qslEimmCYlfRo0Am830Q9XLrEc6+
 z4LTMx/KtB0/iiUA7zTfuURTleHplSdJ6n8QWAvH6+w2GanuB3wmAb/8ij1rJeGWEexw
 RnBVoij4UKyBm4awvKZAq7PM1ohdTfnJJVRu+tazWxdWATi5mXPAtlwgUay7ugarTd1b
 sTlQKPA2jMv8PeD36uXTbc9qqHldAJOnD7Zbsf3iXbRssMPif7b23k/qW7bG4Evj4ZJq
 yO8PLqgG7fPYzx/uXmeLs2vKKo9B3RbnjPZAdQFZK22/2NgdypZ87WTZS3oQl/Ek1vlJ
 n5eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl+GOq+Plv5euLmiQ3dpJKrhEKaSWMT8rj9cEEoy/Q0+smec8HXwYzVwQotemik4qnTpb7b+tTy3ewS2BhEmIW0zhXplM=
X-Gm-Message-State: AOJu0Yze3uWLZFd+AQeMbj0VOwxy0Bg0yMJGauZk2YmGxlJu2IENELLK
 y37+q4eHk8J5DHu+DpUpKj5GYtZM39hqav9PIWXiHMte8B3GWqUqVnjxgDTVjtDcLymKwZDl2TK
 +
X-Google-Smtp-Source: AGHT+IEbM1+RQjtZHz59tZFB2O/00PFx+ycQaG7gXccdkt09buMpE6OPayR/hfaGROTr4h1o0Jzwrw==
X-Received: by 2002:adf:f50b:0:b0:34a:3e3a:a23c with SMTP id
 q11-20020adff50b000000b0034a3e3aa23cmr7691161wro.64.1713805151940; 
 Mon, 22 Apr 2024 09:59:11 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0034b4fcb41efsm939496wra.102.2024.04.22.09.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 09:59:11 -0700 (PDT)
Message-ID: <cd254155-71aa-480f-8962-038c71a2f786@linaro.org>
Date: Mon, 22 Apr 2024 18:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel_iommu 5/7] intel_iommu: extract device IOTLB
 invalidation logic
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-6-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422155236.129179-6-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/4/24 17:52, CLEMENT MATHIEU--DRIF wrote:
> This piece of code can be shared by both IOTLB invalidation and
> PASID-based IOTLB invalidation
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 57 +++++++++++++++++++++++++------------------
>   1 file changed, 33 insertions(+), 24 deletions(-)


>   static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>                                             VTDInvDesc *inv_desc)
>   {
>       VTDAddressSpace *vtd_dev_as;
> -    IOMMUTLBEvent event;
>       hwaddr addr;
> -    uint64_t sz;
>       uint16_t sid;
>       bool size;
>   
> @@ -2912,6 +2941,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>           return false;
>       }
>   
> +

Spurious newline ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       /*


