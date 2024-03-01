Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6433C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg2vx-000432-Ik; Fri, 01 Mar 2024 08:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg2vv-00042c-CF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:28:15 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg2vp-0001rW-0x
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:28:10 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d61e39912so975328f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709299687; x=1709904487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ot6A01TALzRH28+8v0Lc0tfI+Kp3y1CjK9jVOQwUyko=;
 b=oznwGDLznSvcgliQ2ylnNtFFIjMuVgnUBL+IllvkZ+r3tHtKM93UBeRs1AN2bBWVaB
 0knaLj+4iXRhWL69xrifERsdFbCXRSUKEFcWxXcoQxNN/zcfSzPtSMhd0IxR0oTiNhZ5
 xcDqn1Qm2ane/M/jgjQg9uR/r7+LM2/01PHXUr/Qf31SlN9B4W3bASZuPi5L5wSBHGrg
 d/nBGX3sHMUuyLTILtMWiH37b+ikshBOXGOxYmJ5WomFPRgqdZ+gW8iSLnU3S3buF/Sh
 wQflygpQrJeQF4DXnAO3UQOCJBbo3YeTuI2zbhuEOuCYhW0J/8csuUZlovtPa8KeNI3e
 lP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709299687; x=1709904487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ot6A01TALzRH28+8v0Lc0tfI+Kp3y1CjK9jVOQwUyko=;
 b=VshDC02UPYxhgzOhWBEVqPlro5MINIo79oNQcnNqong876+EGCHxIuZkxhwubZM5bx
 6K7kjbq9EiVJ42eZIrWZjdQV/yvtLAenR/0gfjCjQvvGB+QNASmwDf5y21XtabWwpCnd
 7NPjDyniU365W9hf1ZsjBX09xybO9E36etWD1Putczb9UiV10STBTPHGQ+OXtms7RnRo
 lIUboITLiQHCxTWAOtg4FQOWMVF/UE/VPlJKUQXqbFY/nuHFZw7Nndn5hpi4EWVHy7qe
 Uj8CxpHm7NF1Q8EOfbNIsY4UzK4Xm3Anfa3IVbbraJGgyqPg45f8Sp74o+Zn26gvQwqF
 97MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPGQdhQ2bXkUh7W4uNs+x0uGBwN3n6PeEIznie3Dc4Z3nl1ykv1utHiwSvc+XQp2tDSMk6luoQDr4NeiINf8ZnBWiuatI=
X-Gm-Message-State: AOJu0Ywgf1JP3mvnw9dbmRxr+R/sKZ+iNJhAf9C1vwL1DnbC9BmrmbXp
 MZw4jy9GBZBcP0pm4U9TpegHAhVgTwMVZDMYdqF8P11pfMbdY2QCU/+2XmNoamIO3YlOJWt4gPl
 cXPY=
X-Google-Smtp-Source: AGHT+IHeOZfZXhp1xehBDh1pkZmAyxG7WpBYJR4shauE9rqrDr20sBpWZDVD1NwJNc7TXOGKcS2t4A==
X-Received: by 2002:adf:e902:0:b0:33d:f1e5:7b5b with SMTP id
 f2-20020adfe902000000b0033df1e57b5bmr1248428wrm.59.1709299686713; 
 Fri, 01 Mar 2024 05:28:06 -0800 (PST)
Received: from [192.168.128.175] (232.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.232]) by smtp.gmail.com with ESMTPSA id
 ay1-20020a5d6f01000000b0033e22a7b3f8sm871079wrb.75.2024.03.01.05.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 05:28:06 -0800 (PST)
Message-ID: <168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org>
Date: Fri, 1 Mar 2024 14:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 1/1] loongarch: Change the UEFI loading mode to loongarch
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Xianglai Li <lixianglai@loongson.cn>,
 Andrea Bolognani <abologna@redhat.com>, maobibo@loongson.cn,
 zhaotianrui@loongson.cn
References: <20240229113842.619738-1-gaosong@loongson.cn>
 <20240229113842.619738-2-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240229113842.619738-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 29/2/24 12:38, Song Gao wrote:
> From: Xianglai Li <lixianglai@loongson.cn>
> 
> The UEFI loading mode in loongarch is very different
> from that in other architectures:loongarch's UEFI code
> is in rom, while other architectures' UEFI code is in flash.
> 
> loongarch UEFI can be loaded as follows:
> -machine virt,pflash=pflash0-format
> -bios ./QEMU_EFI.fd
> 
> Other architectures load UEFI using the following methods:
> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
> 
> loongarch's UEFI loading method makes qemu and libvirt incompatible
> when using NVRAM, and the cost of loongarch's current loading method
> far outweighs the benefits, so we decided to use the same UEFI loading
> scheme as other architectures.

FYI I'm still trying to find a way to avoid that, planning to discuss
more with libvirt folks. Well, maybe it is a waste of my time and I
should just stop worrying / caring about this long standing issue.

> Cc: Andrea Bolognani <abologna@redhat.com>
> Cc: maobibo@loongson.cn
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Andrea Bolognani <abologna@redhat.com>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>   include/hw/loongarch/virt.h |  10 ++--
>   3 files changed, 107 insertions(+), 33 deletions(-)


