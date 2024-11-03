Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BF5D10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 11:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Z5M-00045G-J1; Sun, 03 Nov 2024 06:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7Z5E-00044d-QY
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 06:47:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7Z5B-0001DD-R6
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 06:47:52 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so28448555e9.1
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 03:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730634468; x=1731239268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ggWF+nPqi0KPxzFSWTmSy5QIbNzYd/k43hqgNb+iww=;
 b=rTm6MpXfGM2h8hvrZ07u2HruF9YV6qxmDfcpTe3uYzwqp9vIicodh40bBUNsJ3zJKf
 YBtNfHIeU2W1YS90BOf4J+jpIv1YT7bAaN20jMjWUzBhO1I3/FIL+Hg93tIuu4qw/tnT
 rioIHZIh+S32Blah9RCps0uyoVob4GZ7sJ3rFCGV0gr5DE+usyD7tRjppSIqxM/Najhy
 J2k5ZetCl4QU/pWK55H5EtlYmsvjTYre1LLqHGzP9iD1X0lOCUNhLa4poXP5OxciowKP
 EI/Dq/hbVAlLCOrSY+d5DFNO9jATuXemvDknePLzCdWGyIvq3pusLaUqAnYjORTJ5//m
 aAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730634468; x=1731239268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ggWF+nPqi0KPxzFSWTmSy5QIbNzYd/k43hqgNb+iww=;
 b=oBiowBiYtjr3IroEGNj5/0S4P7uHFNclJG1FBb9LhekQudYEve8dhdoHrJSLV0HUJ/
 rIY6+aQcxhjs1lh8HCubBW4he6bw18xA9G4e55wnvH70lZeVvyV8yiTs5jx9aLRWjS5t
 UxZ9+PjZTTsrduie5pDmZt7dhciCKcMfJDglfoqXQg93tn5pJuj0upN+b5aUz1/UNY/u
 l7tSkjT/QOSm+uAW/5bVOuapGHneHmEA0fSwqfNIuBgh+wDI8o58k8nHVwOYvqb+EFWl
 Lq1Sod5eu162IB7yKmjpxGRpxIDpNRc+wkuEC1h8ikC51ILpqvdKSvDTAJh3gqkEX2Z5
 Tfsw==
X-Gm-Message-State: AOJu0YyBZPujbMSWjqion4yfyMB2qeQLXxzbmNULzdpPQ0MHFw5MDvp5
 oliktdL8xut6mtf1ONNjIkOwuItyba1bdsv7l4C+LbN8nTY4+ZtT1lG+/gLOSXU=
X-Google-Smtp-Source: AGHT+IE2krHXoyyw1GQoqFZs40lIc6cS5p6myEu5bmEy0y0fBwvdg8abHmOYs4nMkPExMqgjLgdz4w==
X-Received: by 2002:a05:600c:5118:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-4328324aaacmr72041675e9.8.1730634468097; 
 Sun, 03 Nov 2024 03:47:48 -0800 (PST)
Received: from [172.33.63.88] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685287sm124132045e9.35.2024.11.03.03.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 03:47:46 -0800 (PST)
Message-ID: <9d436b3b-4ff2-492b-8aea-c23bcfc2d7e7@linaro.org>
Date: Sun, 3 Nov 2024 12:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Add parenthesis to PCI_BUILD_BDF macro
To: Roque Arcudia Hernandez <roqueh@google.com>, nabihestefan@google.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20241101215923.3399311-1-roqueh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101215923.3399311-1-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 1/11/24 18:59, Roque Arcudia Hernandez wrote:
> The bus parameter in the macro PCI_BUILD_BDF is not surrounded by
> parenthesis. This can create a compile error when warnings are
> treated as errors or can potentially create runtime errors due to the
> operator precedence.
> 
> For instance:
> 
>   file.c:x:32: error: suggest parentheses around '-' inside '<<'
>   [-Werror=parentheses]
>     171 | uint16_t bdf = PCI_BUILD_BDF(a - b, sdev->devfn);
>         |                              ~~^~~
>   include/hw/pci/pci.h:19:41: note: in definition of macro
>   'PCI_BUILD_BDF'
>      19 | #define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
>         |                                         ^~~
>   cc1: all warnings being treated as errors
> 
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   include/hw/pci/pci.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 35d4fe0bbf..1daec974da 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -16,7 +16,7 @@ extern bool pci_available;
>   #define PCI_BUS_NUM(x)          (((x) >> 8) & 0xff)
>   #define PCI_SLOT(devfn)         (((devfn) >> 3) & 0x1f)
>   #define PCI_FUNC(devfn)         ((devfn) & 0x07)
> -#define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
> +#define PCI_BUILD_BDF(bus, devfn)     (((bus) << 8) | (devfn))
>   #define PCI_BDF_TO_DEVFN(x)     ((x) & 0xff)
>   #define PCI_BUS_MAX             256
>   #define PCI_DEVFN_MAX           256

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


