Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BEC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmyY-0003wG-4j; Mon, 22 Jul 2024 02:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmyW-0003q4-I7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:56:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmyV-0005Uu-14
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:56:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so25903385e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721631405; x=1722236205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BsvGQgRxzVSqGttsDNL9B244vEO/oSV2Ou90e5u+zWE=;
 b=DqPvuir+n2NCYlg/Dgy3mGlH5exkyImk0VXsy+lGm2uxFBbZgYWxlOnAmJ0z4XJ2+K
 7J8lvtKc073eoQ7P4bMBoLGUAwV8+Iok56CUjOYQ58VkZL9+EIGlo8N6KgGKkwXSieis
 T5jZB+YkEYwr08A2Ny4kYVQusx7AD3iOXigYZ9zA4WFTZECdr727Kb/ldjohT7cIQODM
 EHGs3lqGizNhV3BX4bY3yM2RzM+gsm1/5IJRhtLFMYSwhocDLm33a8q6pvUXm62gy4Dn
 D1kvHIe5wMexKjyL/tFfnnYhNAqoczwBOIeoej3wp+gcXCT78XH0G+Yab/w+M77VzNnM
 zwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631405; x=1722236205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BsvGQgRxzVSqGttsDNL9B244vEO/oSV2Ou90e5u+zWE=;
 b=BHUd7ohpbe6ZGRvy+NMzDht1YXrrasacBsLUH7wWt66SB6K643j5AxjQ38CBQZuqWS
 khPXBG2rBXwEqCWjJkLNXrLkyeJqcTK5YeYFzfKTMprNRigUDaXt1HGoECinh7mZdYyf
 VGeLm2lb2UAxvnchEGChgrzUXU1FhYsf2NFmd/ElYkzPlZOUVab/MT5W/E05fnwkjeQ3
 ZhJvUg0TaxkLd8wEv4hLrRpJMdPl20e8Eguv+jNG1eavyZiMgkSUkH0bFmgQX4tXO/NA
 pDBRS4/5sR/OnSh+ETRuZfEDS7HfJj8cx2MsPmpUU4oZPg9nGGIfUh1QPZfCI5kU3n0A
 Kacw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGCK9Aue9LZ8e8sC7IINGyOHd0Jc3zMZKrFPujiiVkpkPwwMDY53sid8JTvT2X4trvnYNz5C+U1a4h9mpzGlWej9NWsXo=
X-Gm-Message-State: AOJu0YwxIQ3Gm4+49QCHzhm3H0Vh5XQo5WFEUZkSITrh+HlYbOvEcGsy
 Wyk3uG0/2WAsg5+tYLZvhmykkP/LhobNVe6xnUQKFsxJmxWN1OuAY8yTz70zgTJ6GZMRMiivSiM
 f
X-Google-Smtp-Source: AGHT+IFY3/1hh/s9HkCj3Xj3Fm1hTqkBbkXH/3AjKPKp30LtXBgC07WfCxK68lbrcPFov/mnhZ07pg==
X-Received: by 2002:a05:600c:1914:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427daa60cf1mr37402115e9.30.1721631405428; 
 Sun, 21 Jul 2024 23:56:45 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427df79bf64sm59228905e9.5.2024.07.21.23.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 23:56:44 -0700 (PDT)
Message-ID: <c8386dc1-9381-4b9f-9387-1c5130d3d663@linaro.org>
Date: Mon, 22 Jul 2024 08:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] cxl/mailbox: make range overlap check more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-5-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-5-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



