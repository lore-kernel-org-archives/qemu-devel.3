Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81D8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZrH-0005WJ-DH; Wed, 27 Mar 2024 16:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZrE-0005Vn-La
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:26:49 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZrD-0001Mt-0A
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:26:48 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ea80de0e97so226492b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711571205; x=1712176005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3t5ZnpZ3UjrN/u1J+PmE6wW80BCWKwFBVmXCHkC5mAA=;
 b=SS1wJ/QhZx/nEfTux76YISpS1rmykFfTLZdNaC/1Wp+UWI90SYSE0OU1S26DV+NhgV
 ZNYh96R1deAS7PT5cUQDkOj5gFra2nDSbA1OpHt6WXbCpaKRnPc5Hx0mfek4T+aHuNUk
 D73fH1VkgbyHPwgKVVhrkZjfFM+h77P0kBEOr21hbh2PL5PMxexV+XHy16kyRCqebOUc
 dC3nRvEyg/Zxre3uDMKB8bF/eRkfZ7XKjLvLguX1v1dzIe1tAnDoUDcniOVXhoA2IeeM
 L7JP1w38DKJNCZo5bXbQrjALXd94VN8h9p8JG1F0VprgD2t6gT+aqNN6NZ+jZVqdq5Tv
 yu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711571205; x=1712176005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3t5ZnpZ3UjrN/u1J+PmE6wW80BCWKwFBVmXCHkC5mAA=;
 b=Vcl3/1KolBAaXsem47eP8QG/ZGCmUt+bM68+ul39WdOIiUlQKVvxbkj2PF9NFq2m02
 tGHZwJP7TB2B8LjAL3SWO7TC28N86L3ve/1HMQ1/wmKRxWmiIPjg4/dkM310GKkhtGk7
 ISd6PEv3HrBC03Xgm5P9JZkM830hXJxVQhFmpG5X8IMPItREx/HpX9YTonj1lVTE4aWl
 UfXHS1v+jttbdwMeCq9FBNWBV/WTKr0cm0Dv7bF76FkEWPV8BGFGqoBdzDhKJEgLtlt0
 Qys5tkslvgi0w0rd6dmPP6Ol681JieSukuWIG/qQDBgsVWaYhxyVC6sbQIDJoW1GKnJk
 Cz1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGHoxSJGg9OvfNbMIROjUZvOC7ZFAGiI9AeyNP5h3RnXeHjIYBf/ZcSTQIS/BMUy1fqG/I0W/7DcnWalP2UjOT3IL2pSM=
X-Gm-Message-State: AOJu0YzKS5RE8y2QY839WSb6z5UR1iHH+2q5E3HyPxFZl10K1kgpedpT
 ixxl+PEyWCgQxGztk7IELoMq9E5u6jCACUDta2a26GIYGf9V9IJMeA6H0dN46oWD4JTq5vhyDxd
 c
X-Google-Smtp-Source: AGHT+IF9ZOORh5fVJrQvL9XYK0XsbzWZDjzJ0rVkt5suhneHdu4kgOAid6HrFLeQ4ilFPEYCDqZyZg==
X-Received: by 2002:a05:6a20:ce44:b0:1a3:c673:564 with SMTP id
 id4-20020a056a20ce4400b001a3c6730564mr1301085pzb.28.1711571205637; 
 Wed, 27 Mar 2024 13:26:45 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c7-20020a170903234700b001e208707048sm316691plh.117.2024.03.27.13.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 13:26:45 -0700 (PDT)
Message-ID: <3d4b4fa1-415b-4ae0-aaee-f3136132182e@linaro.org>
Date: Wed, 27 Mar 2024 10:26:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 3/3] hw/timer: Remove the ALTERA_TIMER model
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240327144806.11319-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 3/27/24 04:48, Philippe Mathieu-Daudé wrote:
> The ALTERA_TIMER was only used by Nios II machines,
> which have been removed. Since it has no direct user,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/altera_timer.c | 244 ----------------------------------------
>   hw/timer/Kconfig        |   4 -
>   hw/timer/meson.build    |   1 -
>   3 files changed, 249 deletions(-)
>   delete mode 100644 hw/timer/altera_timer.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

