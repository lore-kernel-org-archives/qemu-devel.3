Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD14EA71A1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 19:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEY52-0005Ne-MA; Sun, 19 Apr 2026 15:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1wEY50-0005N5-PB
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 15:45:18 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1wEY4z-0004AN-4M
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 15:45:18 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso2873331eec.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776627915; x=1777232715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t9B0AG+zxZtzlL8RLO9c0uKyS0sPfKurOxx2FmTxBZA=;
 b=KubcDrb7aRYiSA65Jy2uJp4YO2F0O2F85cK2Qvafn2s+xyt4HGNdCNZKQa4aVfmZgs
 kiu/CxoauCXEvMxbozRg5xERs2nP/Z6QSc+pj8LGe1qa2F9XjWF5glwnsped+XswVDLH
 VIU8G5E1CwKOKXVX3hcRaltqY5lHiUX5hIymP4Gbi7nhTAm6RNueaZSJdd9VzL5lN1+d
 YpPn/amPv2ftvCUvAyZ3uhLjc8R4XlPDAKEwQ0rUulHqYO5rlabcCBYjA4aKLyUZdduV
 kit7ilsnnAp/NlpoarnBtKYTkCRkE8jKS8bxTduuYppwUhv8BC9FSFIGm5C5tCr7q/kQ
 x3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776627915; x=1777232715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9B0AG+zxZtzlL8RLO9c0uKyS0sPfKurOxx2FmTxBZA=;
 b=QVs0eqiXF8/e2jJrP3GIJP8nmQzc3tVe5yRvEJWoQ2FXRkMcibnyBcEEWq8fm2agAp
 uYXThmp0Hdkk7LvXwX8jdDv11w2HO8QVw5OHYlMnVi9TLEGHq/+V9TrPl/Hggm97JlzK
 umSJgNb6F1NuCCww98T1IgtYOw7gMT0M/rxNjVZ5V9/mtmMG74pJlTk87/YJUfmp4IlH
 hpF4o26nbrAsH7PQccK8KXqgYhe/ZPbDqASv8e/iqf7dsNitSRJLHN71qxqB2EgNKBf8
 OLWG+GYMwJhZTUOWwW/XjuvMsWtEXmeFGXwkUy/qEmKYzg7lJtdYvsOG1FT/jrqCJgEa
 jEyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9u4wEJ4rRjC65GQ70MTJuWUoZkMqA5trhrKLpB7TOlpFUtqi03a2VXhkSVrma0VQhwKrL8pYXITAC@nongnu.org
X-Gm-Message-State: AOJu0YzCTYdfZftJr44QG2aAukgi6vVkBZJq1lvW2pY2qNzp5v64Azs1
 EplTq0FKaFZYYxY65wQBWVwHyAdPPOyR+O4rx7CcgKgZ7/0/LVvdbWxpiCIcVsvJZTM=
X-Gm-Gg: AeBDievooP1CynpXMbtPUtTSD8e1lMTbm2pj1Eq7/thkYmbe9sD9JH+ZMU+gRJxDQq3
 MnO9Lr5utEActI7KLdQkcOfUT83wPYBpLy+DdWdZA7o96kkSGloxh78hFztMdtHwj7/twCwDQxl
 ei30M0DlJ1IKVPw9Ig5m/wiSNiDFLkZVMGJrrb5BKERb+RwZ48A01X6nVw0dW04GTbaxggPH2UU
 ohsot8VYxt2KNWXy96M+LgW4kpBzaXLBUl4D3u9DnU59sISeVZqpo7i/YGE1LCFllpDpNkDVtJE
 f9hvL+Ov9Pf+sWmqynhDYhy//9oYkEM6wUy8y93VeQuk62UpAMCqfeox0sy9Id8++qJF/2FoXV7
 EAk672Afny9B2iLS9PGbYi2EWQLjdUig423gsIS+/oBVZW/Pdcn9jhVcPvxKa4z+YZs8Ap/VNwR
 CcKvDkcY9IL8ccEB4ZBpOeKy6mStJs5LUoPlHisxwQ1NiCw9lmnxWgtYyd8V68Qg==
X-Received: by 2002:a05:7300:a191:b0:2c4:4363:3742 with SMTP id
 5a478bee46e88-2e464dac917mr5993042eec.9.1776627914506; 
 Sun, 19 Apr 2026 12:45:14 -0700 (PDT)
Received: from ?IPV6:2804:14c:3d88:963e::2000? ([2804:14c:3d88:963e::2000])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa244csm10797733eec.2.2026.04.19.12.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 12:45:14 -0700 (PDT)
Message-ID: <3f646bd5-b1f0-402f-baa9-0c08f6c3de70@linaro.org>
Date: Sun, 19 Apr 2026 16:45:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] MAINTAINERS: Merge PCIe DOE section within SPDM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-4-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260417110550.70068-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x1329.google.com
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

Hi Phil,

On 4/17/26 08:05, Philippe Mathieu-Daudé wrote:
> SPDM depends on PCIe DOE, so it makes sense to cover
> these files there. Cover the spdm.rst document. Add

Right, that makes sense.


> Tao Tang who volunteered to be designated reviewer:
> https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn/

Thanks, Tao.


> Cc: Tao Tang <tangtao1634@phytium.com.cn>
> Cc: Gustavo Romero <gustavo.romero@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11bf50a9ecf..eccc0d64331 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,11 +2150,6 @@ F: docs/pci*
>   F: docs/specs/*pci*
>   F: docs/system/sriov.rst
>   
> -PCIE DOE
> -S: Orphan
> -F: include/hw/pci/pcie_doe.h
> -F: hw/pci/pcie_doe.c
> -
>   ARM PCI Hotplug
>   M: Gustavo Romero <gustavo.romero@linaro.org>
>   L: qemu-arm@nongnu.org
> @@ -3693,11 +3688,15 @@ F: tests/qtest/*tpm*
>   F: docs/specs/tpm.rst
>   T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>   
> -SPDM
> +SPDM, PCIe DOE
>   M: Alistair Francis <alistair.francis@wdc.com>
> +R: Tao Tang <tangtao1634@phytium.com.cn>
>   S: Maintained
>   F: backends/spdm-socket.c
>   F: include/system/spdm-socket.h
> +F: include/hw/pci/pcie_doe.h
> +F: hw/pci/pcie_doe.c
> +F: docs/specs/spdm.rst
>   
>   Checkpatch
>   S: Odd Fixes

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

