Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E544C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 21:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyTs-0006in-6t; Wed, 06 Mar 2024 16:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyTp-0006ib-1k
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 16:07:13 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyTm-0005B9-RW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 16:07:12 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a450615d1c4so40120566b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709759229; x=1710364029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0vYqykm9ZmWDZ02hL3/UeWxXyVDsnnjfI7SaZxH/4w=;
 b=AAXSZBMxFYCa/bzDARqdQ3vToOI3FpAQsIfywII8Aa9X/GqVvBaL9PxwrGGbYPm4u1
 h++fx2W+x83WLus1MSxb7KyGBC7M2XNasLxURLtP0xc5SIxCTogp9Q7slQl550vUAl2f
 K2JJVF6p99kr8vaOxdh2thG2YFMN0hgo5T+0q084pvRBHykXWMn32HYFVYUJFNDQupXI
 N2EePSbuVhTOnffh+1la0E6F0Sb1ZhUmnjHPmEw69o1etykSH2cuoUKd4wI2JDTmnkml
 e+KtWS6BR+7YBwOuCMA3sT8INI/NObhQbcI+f9k03T2wfGhmZm1MWIN2fMg4eWxJBu98
 ZSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709759229; x=1710364029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0vYqykm9ZmWDZ02hL3/UeWxXyVDsnnjfI7SaZxH/4w=;
 b=hfUNaU2gWa7+DHV7T2ga6rYmCRp/k2QmpWZM3gIB8B9FgbVMHbZnT9sSmH4uS0dSOs
 FSijaA+EbG7e0SIDFv2k9NdKWi1UQqpebErZnT4NLX0yW2XF8kTKP12sL3ze6uPwB99V
 2edGL9JRS66OAkbdl9EE1h8D5RNELh0OFszrKVYdKXdNsryanjh9i5KuQGQYoeaExCYX
 sC77ZdtcaBxa8q5pw2Hm3188E3LXxiNLydtP4TlwgbJH+qBEI19uDeSpQKOjcZ0IhSPy
 H1Md6OntCHFvcmTVS/Vs9YyhgjKpPiGBMCTS+rTqak0zAkka2jEN79iVoC9BgL0MvEGZ
 rAlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg5/4LVk+rMdw003ibnBMnDDu87cRyxnoIUHoR5XOqOyqfbvR/yDO0bepw95EgA2vPEEZLIXz2JFHJZHlvEn1kFUOmN7M=
X-Gm-Message-State: AOJu0YwDIAw4levL3bbWkq2emtJrHDVYtM6rAd77cLIhH8exufU6RnI+
 p3t/M9Jy3Ue6Kvv+AqSU8FBLRKn9LTergvz35jYVOIRHY2PBvk0wHEXEVvVibTI=
X-Google-Smtp-Source: AGHT+IFtbY/p5kGGBleFf3l03heZjjb9uVQjvPXZekM2OkzrzfiH4dfi8v+5nkLQuwRWD35eoO2Rxw==
X-Received: by 2002:a17:906:c34d:b0:a45:af32:5e04 with SMTP id
 ci13-20020a170906c34d00b00a45af325e04mr4804457ejb.30.1709759228891; 
 Wed, 06 Mar 2024 13:07:08 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 b20-20020a0564021f1400b00567fa27e75fsm706818edb.32.2024.03.06.13.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 13:07:08 -0800 (PST)
Message-ID: <91bf387d-0ca1-4812-a414-591f50151d14@linaro.org>
Date: Wed, 6 Mar 2024 22:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Cleanup on SMP and its test
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi,

On 6/3/24 10:53, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi all,
> 
> To make review easier, I've merged my previous single SMP patch [1] and
> SMP test series [2] into this series as well.
> 
> So this series includes:
>   * [Patch 1] Remove deprecated "parameter=0" SMP configurations, which
>     is marked as deprecated in v6.2.
>   * [Patch 2] Deprecate unsupported "parameter=1" SMP configurations.
>   * [Patch 3 & 4] Minor code cleanup for machine_parse_smp_config().
>   * [Patch 5 ~ 14] Test case enhancements to cover more SMP API changes.
> 
> [1]: https://lore.kernel.org/qemu-devel/20240304044510.2305849-1-zhao1.liu@linux.intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240118144857.2124034-1-zhao1.liu@linux.intel.com/
> 
> Thanks and Best Regards,
> Zhao

In a previous community call, Zhao asked us how his work will scale
in the heterogeneous context.

My first idea is CPUs must belong to a cluster. For machines without
explicit cluster, we could always create the first one. Then -smp
would become a sugar property of the first cluster. Next -smp could
also be sugar property of the next cluster.

Regards,

Phil.

