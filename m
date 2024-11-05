Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F0FD3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SRF-0002Gf-HT; Tue, 05 Nov 2024 17:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SRD-00025l-Bz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:54:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SRB-0005kB-C7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:54:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso50946635e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847251; x=1731452051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cv0HzH1vNyWkqVfadbqu8tw5+s9qR0g25g6EENHzeSY=;
 b=FubKX9VdCfeDPvEiPUhbhVtvp9ReMdbwhmRlRk/7wnsTIojMfaAHB+8PS7M7Tf5ypa
 xNhuj83bLrgsTXtO0XihoMeTQyxkUH0ILWbvGNTXPvX9RUYZf+ksn0uetzEvCkhzenUh
 byXv6gr+hon2eeSkd3CBqIzJyJEoZqge3efBxEvScfBuQjQAn48gPKgKjtH9WLnutqsO
 A/NQNmhvORYqFS/SlYq9+6g1yVykWOBKRDZc4JFALfI//zo+F6e1GOyM2TV2HEkFlqU8
 +L0CbfKjYs46n/zsDhCTL7Po43payJiH+51SUAfJnP7tYY1L4OQuZWkcXV2SYLrC4Y+W
 /fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847251; x=1731452051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cv0HzH1vNyWkqVfadbqu8tw5+s9qR0g25g6EENHzeSY=;
 b=AHXKwyU/A8pILWwEkSmulNAT2EGz9fH6JF/9j79FUEL3a+uvFKuKuRfbLk2irlC83/
 3oQ834aZS+FEFn+QcN+DR7gd8DgIhvHvVwUVX5zCC9CekTC9mkoXH71R0a8jk75Hal7u
 ooedgnYxgzSvia73UxqQi+ltHoivMr8b6tD23WHJ9crPwRbdtwThyN/AySys32lPU9JP
 OwtWosTY2e+bus60Of0L2dmpMtCvNXo2AdVl2c48XWXgWvFchLhky5WCNJj+7MfxU5fb
 aHhAc9YgDb+7/s5IPhr5sgkadRIvXhSoKKwczBCPBVpvZ5aSLQPYzUTLCTFsk6I/SOfa
 8cmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIMww7XLro0WzKwkmy6tXZOU2gnXkyM/2e0V1Cv6VfX0gQqX1iwBigT+03FuTT3T0/ozy7AHLgeyCt@nongnu.org
X-Gm-Message-State: AOJu0YzVkrEj8/0DCYpXKfrYpjow5xcoAqvwovtM6W3hJLtmg+2SYukb
 Yl11+ybojd6ARcPaflOXLVmICtTO9toAQ0lzRC9qlzRYGPqagYqE5wYnQYjdthI=
X-Google-Smtp-Source: AGHT+IF7iWF2Ipw7+lGag7OS11tcIrj2DAa31GxxvDSSvIYwYLI0vYgG53ofk53jzA+KHiLDuooz8A==
X-Received: by 2002:a05:6000:1868:b0:37d:4846:3d29 with SMTP id
 ffacd0b85a97d-381c7a6cbf7mr11956058f8f.28.1730847250917; 
 Tue, 05 Nov 2024 14:54:10 -0800 (PST)
Received: from [172.20.143.32] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4392sm17395628f8f.36.2024.11.05.14.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:54:10 -0800 (PST)
Message-ID: <1b00ec74-4dda-48d4-b74f-9ce45cf1a429@linaro.org>
Date: Tue, 5 Nov 2024 22:54:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Introduce SMP Cache Topology
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20241101083331.340178-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101083331.340178-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Zhao,

On 1/11/24 09:33, Zhao Liu wrote:
> Hi Paolo,
> 
> This is my v5, if you think it's okay, could this feature get the final
> merge? (Before the 9.2 cycle ends) :-)


> ---
> Zhao Liu (8):
>    i386/cpu: Don't enumerate the "invalid" CPU topology level
>    hw/core: Make CPU topology enumeration arch-agnostic
>    qapi/qom: Define cache enumeration and properties for machine
>    hw/core: Check smp cache topology support for machine
>    hw/core: Add a helper to check the cache topology level

Since the first patches aim to be generic I took the liberty to
queue them via the hw-misc tree. The rest really belongs to the
x86 tree.

>    i386/cpu: Support thread and module level cache topology
>    i386/cpu: Update cache topology with machine's configuration
>    i386/pc: Support cache topology in -machine for PC machine
 > Alireza Sanaee (1):
 >    i386/cpu: add has_caches flag to check smp_cache configuration
 >


