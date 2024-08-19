Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftyE-0006t9-Hu; Mon, 19 Aug 2024 00:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftu9-0005RI-GI
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftu6-0004K8-8F
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so2847170b3a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041321; x=1724646121; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2LjqyCT6rO7vXKqOxfsdOjN6oNqGyfd9gAZ6OyDIX4=;
 b=tE+j2IvQbxnVnVwbqFBRGB/hEc7ZhqjWcLcXUfAjs+1mRG8wt9dOBK2Kc5hQOY80+Q
 63TxaBvt3ZUaOsOVK4/26sMOGt/DR20CmrZpq2KUzMnsESAGPoKEyW4CwENUJIlGKm6R
 Y7TKGAn+mTw9s4Cc4n3vv1a59OJCk8IoxqwcuIs4Y1oX6v7NuKIT4QfB0ePfpjwMwL06
 IvJJNKRmH18A912NcBhi4TNZf3W6KxlQBBjL/YzBJltuXXqOel4licOw7pV7cqRlGiXY
 GQi9X4x0+CgtbyNSFjTk0avIXxABOGkJtOdoKbo0nlXhfriHErILPc7pjsnPZHD8iO5r
 6BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041321; x=1724646121;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2LjqyCT6rO7vXKqOxfsdOjN6oNqGyfd9gAZ6OyDIX4=;
 b=i+ci3Zk/kKjYxyTwQ6E0gO4GfJQripdpAIe8ZUR9WJeY7EKmmD97aFKqu4gx07mb/k
 e9+veqPpGUnSk9Em1C4MXDF2IFvGJ1TaSjclqJB8FdM4NRQUecaWDFb3Q72/HXlvCwm3
 iFHgovX9I94lM95SKZj2vf8bQdm0goAkUvhGtJqcr/zmhyfTyw4DDEj9Q15yPKplhwKh
 KCd8w0vZnm27HUFuUHP9NZcC7mt+Ka7ugOhQdwu652DZWcr94rxtIKkESgqchVvg95Ni
 CzZExRqMIXMp8Bc0ywddRDPCeslNtE7jXjy0Szu/mQF8fXdlY0gc7EMTo1el/MsIRxzf
 4ECw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfYgG5ZLDEji5UXSU92gxAWAxC7Os3ZSe6HOwrv+7jNdq+kgo8cYi4mw0Yx0tNYd5oYcX9+poaXY6fK0zNb7SthmXlmj8=
X-Gm-Message-State: AOJu0YyWHFOYuCL9CVQbyyVnUOMjg2nItddqUTpRUFl6mDXRqWmQ0sdM
 mtw6P8IrwxoLPWSqmEHacpfLDc+p/CvHXnnFWtpJHSoK8vlw5zobdzUeed+1Rdw=
X-Google-Smtp-Source: AGHT+IHSX27sB8DHDWkIkw2eQlMfE3gQff9rMsJZ84bYGwem25J29O3Cq8ub6RLjX41byKESgFazOQ==
X-Received: by 2002:a05:6a20:d706:b0:1c4:d540:46c with SMTP id
 adf61e73a8af0-1c905052b1bmr9489800637.47.1724041320746; 
 Sun, 18 Aug 2024 21:22:00 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03a4c33sm55920265ad.284.2024.08.18.21.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:22:00 -0700 (PDT)
Subject: Re: [PATCH 3/8] hw/pci-host/designware: Add 'host_mem' variable for
 clarity
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-4-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <97ea999c-38a6-36d4-ce78-e3b0793b8572@linaro.org>
Date: Mon, 19 Aug 2024 01:21:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-4-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
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
> designware_pcie_root_realize() uses get_system_memory()
> as the "host side memory region", as opposed to the "PCI
> side" one. Introduce the 'host_mem' variable for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/pci-host/designware.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 692e0731cd..bacb2bdb2d 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -393,6 +393,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
>       DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
> +    MemoryRegion *host_mem = get_system_memory();
>       MemoryRegion *address_space = &host->pci.memory;
>       PCIBridge *br = PCI_BRIDGE(dev);
>       DesignwarePCIEViewport *viewport;
> @@ -433,7 +434,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>   
>           source      = &host->pci.address_space_root;
> -        destination = get_system_memory();
> +        destination = host_mem;
>           direction   = "Inbound";
>   
>           /*
> @@ -458,7 +459,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>   
>           destination = &host->pci.memory;
>           direction   = "Outbound";
> -        source      = get_system_memory();
> +        source      = host_mem;
>   
>           /*
>            * Configure MemoryRegion implementing CPU -> PCI memory
> 

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

This patch can get merged independently of this series.


Cheers,
Gustavo

