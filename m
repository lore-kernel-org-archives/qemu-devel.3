Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16374CCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vho4D-0006ql-K1; Mon, 19 Jan 2026 07:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vho3s-0006mZ-Li
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:08:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vho3o-0001aT-LP
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:08:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so25357445e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768824522; x=1769429322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ctXZfo+01L2t+GxjVT5SxcOwyvERdUyQNA06MEQ+oZ4=;
 b=qkntceuSQDSkjbHxo1vOntG0vPrR7FoNJiFab584kRKkFTAyE1YS+aLrS76Rw6m4Ns
 P3ISzp5jDA4ApL/f8ZGwGthsiDm7lE/SlQH9iVa5G+IPF+D7i5ir14dra52+0F+ONdyr
 Lis/dvdxCT4CoYd7O8A8GQKzVAoeYgdkYdhTFpBx5pFLXUeqJe8T+M/aIec09fxThA4y
 BZzLh+7WLtGVP8f2Qi64UIZJhRvZ29sx3SCAXRDmkpkfMJu9KVTUlVm8FV0nRoDZKCMM
 Jv8x4dNv+Cpv68XRz+eWAccEhPDaOy0j3zRcbBH1s7tT1zvTDTDO+y/gXXNsAC9ffXUC
 zfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768824522; x=1769429322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctXZfo+01L2t+GxjVT5SxcOwyvERdUyQNA06MEQ+oZ4=;
 b=BCyH5KcvJkGBPKMPw/bjOfozT50J4ZkzHrB2kJECyoHQI7vpJfFQ6Ff3zz4Cl2WDdS
 I70fYc+QuNMxPnKT5nPHf1LHWGSwhP9ZrOaAYhK9AWg+u8VhGwXxMAIqZ+0ERRmbnGfc
 61eAP2Rb1rqdIXEFVXWbXy+1uaHU1SD+UMvywUVS/mdK+voCZ+1rOn/STQoBt3l5PUlC
 b56C2R2Sx7yf4qd9SggPFBOYiD0i61KtUdylTv8tb3uIFgsIdHS4qFm0SirWZ7czDBqi
 qNwSjvZL96+GMehSzNX45feNI8SLL/w4bx6GCPG1xSSGtCIs7CQVrGEtlrYt+S8zsW0B
 LwzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLd/v7/DFldlIC9H5k2GdCiiZZN5abJVRktTsPMQs2p74StJmgKzFJGzX/4AqoInNQH+SrNC75eNAD@nongnu.org
X-Gm-Message-State: AOJu0YxwJreii0p/1fw6piBwG/TyMigptilRYbycuNwKut9hhs0DO4xu
 h+FuBRK3KDxA91nzkWQH2UtOOJtc47dxzbKZa7Qumz3RrikvDS4+SCHVDYeDR6XMJQ4=
X-Gm-Gg: AY/fxX7U3uV7ZBbbCqm0d3rcrKrbB9uMy/QP/pqqRo3gm0DwwZzUz183ZIZ0jzKUA10
 p6LO+QeFkU9/zuBpkVx21c4f0BeQ/+IU3jlDAinNhhq7XfH0M06ou0QISXTBrGtEh4HauWP/9v+
 KFncF/cUvUi/66V0MytuHImQChoVhVTfShRfHm6JxAqpLFAS55PfXLUHQFNsD7fMnT8rX2Hm1Ue
 FgLWxiD1y9jeG+18Zj6nv2SlDjNYGBlmdZsYHaERzlPlhAZfNp8PE8YykUQ8wBfB6AX7w+xZEyb
 mbYPEbidmDYracs6VEbM0f5QoA8ab+Vuj5EEt2J3AsvaH+qMk4ueWA+hmxZ/GyLaHQAHmfoCGgM
 UUJnXaMTbkaUkzjhLSqLOjQCinE4k+icV15ViCZDfi+MH4Zsesc2LeBBZ5yaYZ2aT8bKw/lI4XY
 89FKEf4K55YaH7muT9EMyaR/5j1ENuag8kRKDscpZTuirEy7UjiFoBvw==
X-Received: by 2002:a05:600c:674f:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-4801eaba084mr111910445e9.3.1768824522184; 
 Mon, 19 Jan 2026 04:08:42 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e9ce5aasm86009755e9.2.2026.01.19.04.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 04:08:41 -0800 (PST)
Message-ID: <249256a4-96a7-4a77-878a-badfd0c9010c@linaro.org>
Date: Mon, 19 Jan 2026 13:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM cores" <qemu-arm@nongnu.org>
References: <20260119120030.2593993-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119120030.2593993-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 19/1/26 13:00, Alex Bennée wrote:
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This allows us to keep the MSI data in plain host
> order rather then potentially truncating with multiple byte swaps of
> different sizes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/intc/arm_gicv3_its_common.c | 4 ++--
>   hw/intc/arm_gicv3_its_kvm.c    | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)


>   static const MemoryRegionOps gicv3_its_trans_ops = {
>       .read_with_attrs = gicv3_its_trans_read,
>       .write_with_attrs = gicv3_its_trans_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

\o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };

