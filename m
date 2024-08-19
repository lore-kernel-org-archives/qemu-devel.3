Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfttw-0004ke-8j; Mon, 19 Aug 2024 00:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sfttm-0004eH-3X
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:21:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sfttk-0004Hh-H9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:21:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fec34f94abso32400765ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041298; x=1724646098; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ey2/XL3x4dsLSO0Rau9u/e+UZKi3H/ZDUx6iNciV5G8=;
 b=s9k5dMlJJyCE2oFW5/Z5SuYNXHMJnqpEcrAGrAZLRm4Ya9PGSu8x6fX+DIpNDufFJS
 94gWk9JwUzxOOywZiGSz+LHm7ulu6pSN/mAP+JJ5pbMYzATONW1PqPGNazsYq+wwLwkK
 cGfpb59LM/bVKK2PrRUhzcOyMtAAbFR0CNi4vLUK+NSCfHURXPw2npFg7PI3xfoSerZ/
 hEw98aRy9pdSwntD6hkdY/Asx8o/dkUxQC9ettM+E3xfkFaWDSQ4X0vssoZ3lGnk/++r
 h1N2LSUnk7Fmwe6Ay1TFNBkQUj17lOPOQvMow4usS7LEKnbtGy1H+6fUid6JM6V7ayfh
 FqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041298; x=1724646098;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ey2/XL3x4dsLSO0Rau9u/e+UZKi3H/ZDUx6iNciV5G8=;
 b=p4baOjUT5pxLMRei9Sr92t0+r1yKxQsMeV5NzJzkw95229F6CzmNDG8RMaY5WW4EaM
 xbpOVqCTsTsTkD/F07k+2DYYQJWRoprQgfARQ9DKkCY8uVTX9GFIJkyehuvjqsNDf8Ug
 mqz2DFr/XyLNGRp58C/Xactbtdvy+Hz7XdiRFqCnaaRdM1BjwGiHpL3yWU63a3EsMmZH
 DtwUPSLmZtlfud3ka6hNG+/FN3dxJA+2wyqPJ8KP4GyFiwo04CQXlIyDzhbWlMTK/LCu
 uwOqnrVZI7gSXMq/x5+VQGFrabg9DShhq6bjKQUXMMoXpJozp75Kg1I5b8525oZmieV3
 FtUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNg/x7UCGdc7jLSwRVk1alZp44Qa4xtq2qZXpIth/eNRK71HrpcqdUCwCDE92LdCfhTEsjcQn2cW8vSKeu4IQBOhBZpM=
X-Gm-Message-State: AOJu0Yx/rIJVaUttjqpRbR1yQH0rRH6WyoG/3yqaG3ZR5nJvtv2ODOGn
 nd90fl5dFg3OH2L3w0/1kivHIwR/ScqFQsxNjBU9UVajSA/JCkEJ877prCaoKy0=
X-Google-Smtp-Source: AGHT+IHwa6X2nceJCtPoVJnBuO4GBi+E1eKkqPaAi+Og+jHn2va1DEatQSTNbVhbUPQlkkec2GjeUQ==
X-Received: by 2002:a17:902:ccca:b0:1fb:1afb:b864 with SMTP id
 d9443c01a7336-20203e4a727mr104783795ad.5.1724041298061; 
 Sun, 18 Aug 2024 21:21:38 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03a1974sm55998565ad.276.2024.08.18.21.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:21:37 -0700 (PDT)
Subject: Re: [PATCH 2/8] hw/pci-host/designware: Initialize root function in
 host bridge realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-3-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <16a3fd1e-09a9-87d8-5e63-d7c3ab5a48b7@linaro.org>
Date: Mon, 19 Aug 2024 01:21:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-3-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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
> There are no root function properties exposed by the host
> bridge, so using a 2-step QOM creation isn't really useful.
> 
> Simplify by creating the root function when the host bridge
> is realized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/designware.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 304eca1b5c..692e0731cd 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -707,6 +707,10 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>                          "pcie-bus-address-space");
>       pci_setup_iommu(pci->bus, designware_pcie_host_set_iommu, s);
>   
> +    object_initialize_child(OBJECT(dev), "root", &s->root,
> +                            TYPE_DESIGNWARE_PCIE_ROOT);
> +    qdev_prop_set_int32(DEVICE(&s->root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_bit(DEVICE(&s->root), "multifunction", false);
>       qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
>   }
>   
> @@ -736,22 +740,11 @@ static void designware_pcie_host_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_designware_pcie_host;
>   }
>   
> -static void designware_pcie_host_init(Object *obj)
> -{
> -    DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
> -    DesignwarePCIERoot *root = &s->root;
> -
> -    object_initialize_child(obj, "root", root, TYPE_DESIGNWARE_PCIE_ROOT);
> -    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> -    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
> -}
> -
>   static const TypeInfo designware_pcie_types[] = {
>       {
>           .name           = TYPE_DESIGNWARE_PCIE_HOST,
>           .parent         = TYPE_PCI_HOST_BRIDGE,
>           .instance_size  = sizeof(DesignwarePCIEHost),
> -        .instance_init  = designware_pcie_host_init,
>           .class_init     = designware_pcie_host_class_init,
>       }, {
>           .name           = TYPE_DESIGNWARE_PCIE_ROOT,
> 

I could not find any mention in the docs recommending the use of
init/realize pair only when properties could be consumed. Anyways,
you agreed with Peter's comment (I agree too), so I understand this
patch will be drop since it doesn't affect the other patches in the
series.


Cheers,
Gustavo

