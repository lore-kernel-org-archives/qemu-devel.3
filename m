Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87188F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQBx-0003HA-Hq; Mon, 13 Apr 2026 18:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQBv-0003GO-Hd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:55:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQBt-0002jD-Li
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:55:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so47013225e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776120936; x=1776725736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QEkTwuACxrjxuqfxmduq+1X6DL5EyeOxBVhKjG+AKyA=;
 b=Ggxd0ui+yjhZHqWo/Vf/2LUUREsqy3TU/+FSS5XUnksx0zAd7nJ2onuTcPQVNkZX4v
 I0hgRC0DEwtIMZtqzDtL8vcHVWDa1hMEXmtXYbgRqvXlQ9sZoDOOJddjKfiSHIPP4IzH
 FV+8lS7LVx+Oe+OTHivCrsGTw/24fsINA+NIteNwi7wKiuBKdItqwu8026bQe3L5tYZh
 R5ZSv/PdVoj4wTqQNbSDyFoHGuT7e1CPgTl46lD1gDTpk6gpO/acs4SzNXrgC84acwwq
 QUthAoOrFmVYFQzKknq77lhqtku2VNruOX4BUPdccoKOgMnaOjY+Rq8wcP0SKsgiPaot
 sExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776120936; x=1776725736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QEkTwuACxrjxuqfxmduq+1X6DL5EyeOxBVhKjG+AKyA=;
 b=X9Ns8vS+BXTZbZ//15fE1n5+wG31hXEY0RHpA758hRiffDEjTOChn7K6GzMQyh5YU4
 tBuPQ3bDqOhm/+g+06SIkgRVu07uA/C6f4XdSqG4vwXesLiXPYCeynY1WIcYe6G7AtpI
 xXw4k7+k58KkmGM2XedZCDxJBazNnpOO4OT+8iiP2H/39zq3pscBHelBLdrl3L0EkSLw
 VQw0MLt9PhYYB04wj5jt4xhPxf/iVqAOnAbzchl5HC57UF1JjUgEDgBVRVABdg7LT33s
 mHjVHJk3BgV8exqgPvo6ni+SjV2EWPhsqHEzeA7bAuw+LHY4PbP//GrGZmWNUgjXplLB
 +4qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+C/G7p4cwRfQDkNkWCppt5Yacfbi1vhIc2PrqvpYt1LILBwfELeYHhjy8wKEtr6jFs7u26SpCZeGrq@nongnu.org
X-Gm-Message-State: AOJu0Yx5MOivMDCiHefVEJSlvji6FCypdmtwwxu+jaABbXaEM+coWILS
 a4VxE2SV83TRzy9T02cpUYUMC7yTDOgNe9/e6v4LQ6bQo6Kgd9AHB2xhQ+p+UJ56iKc=
X-Gm-Gg: AeBDietw926sOQ41RKR1Tt9EtnK9OYg+WhfMiWbP7DWQrt+sccIxQ7zXeUApqqPSY4K
 LliyUS2GOghev9MZ5kVftClcFwFVF6SPasuBAF5XpdgU+vLswpJGOYAP0X/2eg1joAZsb5HdpVQ
 rItkIDJ+jeyxamTtrfRu+c9wkHZVatUfocjd+4i6q+GTX5ovFizsBDusCSah8rjdlrLFvd/s/cB
 WyvneHl8JSWvqUMr8V1WMTiuplNIqVkzCUY5+hzdQT9UdxN3ndvNg6KUT/KIQVOAS0tIesAo7FW
 a5mXMR2bcxmFO3olezG4o7wE84dDF9UntYzqTqjHjUBl/wHnsIZXunlX7TQtpECdC44JgYxDiuc
 xTm5hR0IWtpOed8+yIugEeTfu5fwaWVdINItDQgExqHTcWlY0ftTwX30c2iw4ylyIjtYn9YpMBW
 ha/3DtsEV5VNhyAxU+H/BTit2/IfAW6puenT0/I4ZQMpwT1s1CVdyT82nth8U/GrEvsg==
X-Received: by 2002:a05:600c:8b38:b0:488:be58:bb77 with SMTP id
 5b1f17b1804b1-488d6890ee3mr187095145e9.30.1776120935690; 
 Mon, 13 Apr 2026 15:55:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67b128dsm175925005e9.2.2026.04.13.15.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:55:35 -0700 (PDT)
Message-ID: <bb73ea01-f615-49cc-af5d-8a5fee87af5e@linaro.org>
Date: Tue, 14 Apr 2026 00:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 58/65] hw/arm/virt: Pull "wire CPU interrupts" out of
 create_gic()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-59-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-59-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> create_gic() is quite long and mixes GICv2 and GICv3 even though
> they're mostly different in their creation.  As a preliminary to
> splitting it up, pull out the "wire the CPU interrupts to the GIC PPI
> inputs" code out into its own function.  This is a long and
> self-contained piece of code that is the main thing that we need to
> do basically the same way for GICv2 and GICv3.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/arm/virt.c | 126 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 68 insertions(+), 58 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

