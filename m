Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B790C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftxx-0006dt-QS; Mon, 19 Aug 2024 00:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sfttY-0004aB-JT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:21:28 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sfttV-0004HC-H2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:21:28 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5c7f24372so2602102eaf.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041284; x=1724646084; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zMBFLaUmtC+DIxiu4oheIM8uCLkqi+EyyEj4w3QR8w=;
 b=AhSDdOpIwoYgrr0cclrnSrjTlO2/1cbB4g7fezYkHath/AcqE6/uXHnKdawKPdeRIa
 X8xy57EGToWoQkvaHhQ53gcZ1q1Raa5fyOa97TtYokdQccaxJ5yVb7aCDLi99Tt7z42H
 zkMLVEEFtBQqb51E//dK28gRRqbtR03ugXRWLoL3/363k7Dj8mloMWBP/+gvi2xCbDUw
 oUy2okQqRoZLPWj7IgXPdjBAF9ofc09cGOXIc4xqZhOMSl9+7LYCvq1BCD3oS5WT5gJU
 UatMipGvC15EWhldSd/6cfPJp1HIyMpQwNf6qdXhtHu+H/ws031r1qTKVy52qMep4ZZE
 jB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041284; x=1724646084;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9zMBFLaUmtC+DIxiu4oheIM8uCLkqi+EyyEj4w3QR8w=;
 b=P6Xq5yHx8gdtOJD9nQiYN+O9H12a04RoBpumhuGI/TNg2WI8teiclUibjd3zLI9tmJ
 PmG63hGucNd0Nbtr2sPxgY5wmM4VG1PBtOwXZKScO5muj7k0fnq9WlwnOeaZkCJVluTy
 ZD/6lWlHb0wnPh8htdAS7x6k2kA0r2hmqa6FtTsM7N0roDh0DNnifE8jiF9WXxFAxgWy
 DSoq2DpyA6pqOyyoh1vyFbDcIMSipq8d4sbgAS7+ztDZcvZj0whRmWXAJ/AwjP0wQ85S
 vG/xrSOvbeaBMrI5GZxRjFStzTHMEdS0xyagl/1sY4I7hnOGycfKde39qU/kpLNg5Nrk
 tlZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ztaDw1uDqE8JeUp5lmAEaT9Mp3oE1BznGvJlAdFwd0oI53pqHOp0hORaRS5/sXocIwgdUWwrPckDoS3NoGHSBk8wXQQ=
X-Gm-Message-State: AOJu0YwxUriFJ23tb2XXAb9U5YWL5qSHrSVXjH+cjq8D0qwCtRyScP3g
 u4xtn0yA+eN8e0LYS2OtcBGDSoP7BOQfqwLMHIQeEvx2qXIiql0M8OIMtQIdnd4=
X-Google-Smtp-Source: AGHT+IEf8Q7/4W0fWIddamgDNe4FKal2aZCyI1xTaFnY6BC1hm07senB8BqZybM4OGwy4Hi05KU6Ag==
X-Received: by 2002:a05:6358:478e:b0:19f:5a42:d2bd with SMTP id
 e5c5f4694b2df-1b393282954mr1606058055d.22.1724041283597; 
 Sun, 18 Aug 2024 21:21:23 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae669b7sm5891811b3a.88.2024.08.18.21.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:21:23 -0700 (PDT)
Subject: Re: [PATCH 1/8] hw/pci-host/designware: Declare CPU QOM types using
 DEFINE_TYPES() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-2-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <2f3df725-0d99-97d0-af7b-7054036e4228@linaro.org>
Date: Mon, 19 Aug 2024 01:21:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-2-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.588,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Phil,

On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> Remove a pointless structure declaration in "designware.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/pci-host/designware.h |  2 --
>   hw/pci-host/designware.c         | 39 ++++++++++++++------------------
>   2 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index 908f3d946b..c484e377a8 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -31,8 +31,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
>   #define TYPE_DESIGNWARE_PCIE_ROOT "designware-pcie-root"
>   OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
>   
> -struct DesignwarePCIERoot;
> -
>   typedef struct DesignwarePCIEViewport {
>       DesignwarePCIERoot *root;
>   
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 6f5442f108..304eca1b5c 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -746,28 +746,23 @@ static void designware_pcie_host_init(Object *obj)
>       qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>   }
>   
> -static const TypeInfo designware_pcie_root_info = {
> -    .name = TYPE_DESIGNWARE_PCIE_ROOT,
> -    .parent = TYPE_PCI_BRIDGE,
> -    .instance_size = sizeof(DesignwarePCIERoot),
> -    .class_init = designware_pcie_root_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_PCIE_DEVICE },
> -        { }
> +static const TypeInfo designware_pcie_types[] = {
> +    {
> +        .name           = TYPE_DESIGNWARE_PCIE_HOST,
> +        .parent         = TYPE_PCI_HOST_BRIDGE,
> +        .instance_size  = sizeof(DesignwarePCIEHost),
> +        .instance_init  = designware_pcie_host_init,
> +        .class_init     = designware_pcie_host_class_init,
> +    }, {
> +        .name           = TYPE_DESIGNWARE_PCIE_ROOT,
> +        .parent         = TYPE_PCI_BRIDGE,
> +        .instance_size  = sizeof(DesignwarePCIERoot),
> +        .class_init     = designware_pcie_root_class_init,
> +        .interfaces     = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        },
>       },
>   };
>   
> -static const TypeInfo designware_pcie_host_info = {
> -    .name       = TYPE_DESIGNWARE_PCIE_HOST,
> -    .parent     = TYPE_PCI_HOST_BRIDGE,
> -    .instance_size = sizeof(DesignwarePCIEHost),
> -    .instance_init = designware_pcie_host_init,
> -    .class_init = designware_pcie_host_class_init,
> -};
> -
> -static void designware_pcie_register(void)
> -{
> -    type_register_static(&designware_pcie_root_info);
> -    type_register_static(&designware_pcie_host_info);
> -}
> -type_init(designware_pcie_register)
> +DEFINE_TYPES(designware_pcie_types)
> 

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

This patch can get merged independently of this series.


Cheers,
Gustavo

