Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02526C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricrb-0007oq-Gb; Fri, 08 Mar 2024 11:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ricrT-0007jw-Te
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:14:20 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ricrQ-00005X-5a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:14:19 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so128209066b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709914453; x=1710519253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GFuY10NRycju0TCEIzNu/SW5zTp5TLcxEWCaS61P9RE=;
 b=cSdsyOJ/i1QyBFKO4fUBCfGV+6qDjfEVZCugJlyIm08R99kq6zbtsamSH1Vxdmp6kD
 U8mXdVeHOxFs/HndQeGDHDyiMZ+vgXNrbZL+0HtTsJ9F8chiNS1fwUUY7D2N0qxbGere
 2D6podKmkE0c1o+Fw/ualGj5W7HTw7+LCyjFZDVvSTVyJPk5gOtIk/dqoxB1OzEXAi8g
 SKdfF/dUwUqDfBI0I5fdQNg7xe5OJr5dySPhxQUNr+VkzQo7RcUJkmm2VBK3Z8Umzqkv
 2zkLBbQP1AtdrPZ3PQqipqdYBb5wFl2hd5D7pLggna1xVo1M8T4KLZ2k5wA/3UB8VKPC
 HbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709914453; x=1710519253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFuY10NRycju0TCEIzNu/SW5zTp5TLcxEWCaS61P9RE=;
 b=B4vaRcrUgmVcXTcH2LArw3mQJgVXQUEeeGSefiHRn+bCkqhd1qGz8BULBjyFWbNukf
 JbzxVdeX52BsTw0LEp0VDOnWihFmao2qPn5eS2gB/nVicRcq1fBVTh5+sj+xtt2VrnGB
 pliDpKYI8IzKJOloLRutwUiG3OrBqZwVb4Xnk3Y774jRIrUAHK0aC64g7fymVlwPXlJs
 awBDaji5DM06SEL9g4c5Rtf7FR+e0ROxoS2hjjbkF2wXODwzi2WiKQdjZ2uq4le9T2dt
 BqRHdvm7DhRbprEq5jqtQWjFFxLYzDybfgHz/OwjwC09VsBRTMWE/T+b3N2Ffe5LH8v9
 LYbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoNA/5CekHS3HYyrmwi88JzkC+sUPW6ACQtf73J8sSUd+QBMb296KlFsRYzkKOakwfthCDe3aTaQz1uttL7nVdGc7hF1g=
X-Gm-Message-State: AOJu0YzEJ5EtmJriXcWW1fQbY51Qm/znSo4Tl5Qn6Oyhprr3uEFIhbHC
 W9R59g1xY0vKtiAmIs6ZrrfiC7XIjSCLPD+3+8KDRM0ql4R000YgPI4EMeV5+vA=
X-Google-Smtp-Source: AGHT+IF2A4OWFXpRboNCc9ynwfAm7QU71aymDqbs9H/LN6q5DAb9Klsc/GVqjbQWmh5JpzND1JZnDA==
X-Received: by 2002:a17:906:ccc8:b0:a44:1a51:a1fd with SMTP id
 ot8-20020a170906ccc800b00a441a51a1fdmr14045816ejb.64.1709914453592; 
 Fri, 08 Mar 2024 08:14:13 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 fw11-20020a170906c94b00b00a45a8c4edb4sm3995322ejb.48.2024.03.08.08.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:14:13 -0800 (PST)
Message-ID: <66729d0f-72af-4c96-8bf7-479f954b032e@linaro.org>
Date: Fri, 8 Mar 2024 17:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Deprecate the "mainstone", "tosa" and "z2"
 machines
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240308104206.480929-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240308104206.480929-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi Thomas,

On 8/3/24 11:42, Thomas Huth wrote:
> Support for these boards has been removed from the Linux kernel
> in version 6.3 in 2023, so there are likely no users left for these
> boards. Time to mark them as deprecated in QEMU, too!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/arm/mainstone.c        | 1 +
>   hw/arm/tosa.c             | 1 +
>   hw/arm/z2.c               | 1 +
>   4 files changed, 11 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 8565644da6..da5cc91eec 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -247,6 +247,14 @@ to correct issues, mostly regarding migration compatibility. These are
>   no longer maintained and removing them will make the code easier to
>   read and maintain. Use versions 2.12 and above as a replacement.
>   
> +``mainstone``, ``tosa`` and ``z2`` PXA2xx arm machines (since 9.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Support for these boards has been removed from the Linux kernel
> +in version 6.3 in 2023, so there are likely no users left for these
> +boards, thus they will be removed without replacement.

While Linux host support makes sense for code removal, guest
support isn't relevant IMHO. I.e. you can still run U-boot
or any guest code you fancy, like my-first-rtos.

(I noticed Peter want a more generic removal)

