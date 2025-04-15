Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 06:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4a1O-0003yQ-UF; Tue, 15 Apr 2025 02:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4a1H-0003xj-Gz
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:43:44 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4a1F-0006lS-Sp
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:43:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-399749152b4so2817702f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744699420; x=1745304220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GQT0TCgqzsAPvVCIMNHaaNcimJr7CPVS7DDR1d11JY=;
 b=SRVekZaEa+Ubsat9zv2ZnkBJYViZ3nrMIl3GoJT1N9pvM/prPuY667JTh18sTmKaQV
 vIxtBrKOuZnMOZtGZIGMqeuiEt6A9x/0BZcTvvX8I5DZZ/YULO/8hApCvNLP/lBnq4J/
 6lFB7pzEzGTYGJnjDsOY/pNLeaMIa3yFtV51QuLN0iQTzSn2+lf9cP/A9fIQb23MgOK0
 5YjAiLpvUvYtk8ShFBfEnmKHtAY2aZIqnm+EHSwOqqB4urhhGNKhj7X4++Dxa3PMtHYh
 jdVmj46pMIdLYoPwuGRZx+jLzfEqmUbVd5MRYfiVl38UtUy6mUAzE44tmoLHsgSzkPrn
 LYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744699420; x=1745304220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GQT0TCgqzsAPvVCIMNHaaNcimJr7CPVS7DDR1d11JY=;
 b=P2pCfvnuhE8ikFBNJA1AjbkROTkuHeExmTbfLPpN7vpK/LOv+NESwGfhZM/6BP5I7r
 CbtQe36S6KGQKnuAziwclwFD4Cu134PFTOVXrbifCZt0ymuzxnFA4S0BD2tQHr7e3Kil
 N+MZTvnWp6OxKICXLXiG5II28tZv5fjg72GHhkQAOsLpdc99ZmypZIOqjWGqOZf7VvF2
 3xI+N8HOkehVhoAiTORcbDaxhppWC/Irz49nK7bM38z1wFXhvt03kVyo7Bxye0UIZze1
 /1on9ft82GEClBGLrPjnG4n4dBkAZst/dKV/d88ZRWDGppNe8T/cKXAIa3XLCINLTKBp
 V/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHVawDjQ6cDOcnzMzFBwD8qNGn2Q86/r2+bROaaahCn2UUefF8vvd2cnV8frs0Uyf4HpoR7t18QxFE@nongnu.org
X-Gm-Message-State: AOJu0YzqZZEpXDfIsDFFD3yodsX7F8VmaijlHVF9eLt6oKZc8oVClak6
 Jquf+Xi90L9futKLb9bObql55UqbvFTc4Gyv0JsQvNkxz2zqlZOV8CCmNLAi8IQ=
X-Gm-Gg: ASbGncsTwFjkL0zOoMcN7xCU4/OgFK9mqrK4bXkASO6nwO6mu3x5BOkjtG3KRY6LMnZ
 en7+srOfJFawWGbTgMdu9Dgp/motxoLCKay6+WpkD+/9LjY6o9CrmCveEvf61GfqbtOdGkrX2/q
 97uH2I0nb1QwISVsSwiT6b2tixCx7emmv4tpKVgKWg0Bfvi1vitHXH4CoDHsLTiD5OcBwWi53yO
 DpwB9zDYvxAiv+VsSurXKo4qmUIPq3LAm+TB9d+dJII/fDqgBgSey4GAaPaHQ35h3X6F56Cb/xp
 XRtPRUzNOXJXjFd7vMISeKH59tJ8mQ9TnousfX2ZzNo2aZAU5GmcoZlNB/KMXbJAYWEdwX5kZ7q
 8Ac0VhnyZm7VGlsZjSgE=
X-Google-Smtp-Source: AGHT+IEclHZQTHJeSRYfT9Lb2Und69zLxR6yslXXtMvcyTxUXe2ZPsV/DFPjy7oScxKas0YludOSvQ==
X-Received: by 2002:a05:6000:248a:b0:391:39fb:59c8 with SMTP id
 ffacd0b85a97d-39ea521760cmr11962068f8f.25.1744699419762; 
 Mon, 14 Apr 2025 23:43:39 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625592sm200727665e9.10.2025.04.14.23.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 23:43:39 -0700 (PDT)
Message-ID: <71997461-7470-452b-9df1-3efa6d6f68c4@linaro.org>
Date: Tue, 15 Apr 2025 08:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] include: Add a header to define host PCI MMIO
 functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20250414213616.2675-1-alifm@linux.ibm.com>
 <20250414213616.2675-3-alifm@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414213616.2675-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi,

On 14/4/25 23:36, Farhan Ali wrote:
> Add a generic API for host PCI MMIO reads/writes
> (e.g. Linux VFIO BAR accesses). The functions access
> little endian memory and returns the result in
> host cpu endianness.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/host-pci-mmio.h | 141 +++++++++++++++++++++++++++++++++++
>   1 file changed, 141 insertions(+)
>   create mode 100644 include/qemu/host-pci-mmio.h
> 
> diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
> new file mode 100644
> index 0000000000..de17d67e3a
> --- /dev/null
> +++ b/include/qemu/host-pci-mmio.h
> @@ -0,0 +1,141 @@
> +/*
> + * API for host PCI MMIO accesses (e.g. Linux VFIO BARs)
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HOST_PCI_MMIO_H
> +#define HOST_PCI_MMIO_H
> +
> +#include "qemu/bswap.h"
> +#include "qemu/s390x_pci_mmio.h"
> +
> +
> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)

Is it really worth inlining?

> +{
> +    uint8_t ret = 0;
> +#ifdef __s390x__
> +    ret = s390x_pci_mmio_read_8(ioaddr);
> +#else
> +    ret = ldub_he_p(ioaddr);
> +#endif
> +
> +    return ret;
> +}


