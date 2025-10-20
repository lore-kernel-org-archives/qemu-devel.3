Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44920CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlfD-0005Zo-4o; Mon, 20 Oct 2025 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlfB-0005Ze-27
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:54:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlf4-0002l9-Vj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:54:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4282fba734bso800962f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760950477; x=1761555277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xs3tYeIUxROfq9Qyi/HAYIGr+WeY+9jWls+cksD7RSw=;
 b=jlGFeI4MkDzcDau19StqQ1y7GnRMh6/WQVnKBU2zMG9KRI8tcQUSnIp9gMF/o3tH6v
 Dtcs/q6fKjgoulFz34labh+xnU20PJg9XqWXswBA8UKHl7x+i3y7EnkiJvBCt0Fo8Sm3
 MLQ79+8qzFPaTgRdSyoQvFk0vvZeTTzCYk45sXlHGbcApd7D4+kJ6ofiKLytkYya9yIW
 qazH/ePg+3ErZzYinYIRW6vr0cG5aTYrxzl6IXvdtRYCWevejKmxEwrzAwDG7pblDKMw
 J5L7XPcpDh0O63lMmJcwDeT2nz8aexW9Iwn+1AzxFWswpOM+HARjT/x8omJDQlcXrrkS
 btYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760950477; x=1761555277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xs3tYeIUxROfq9Qyi/HAYIGr+WeY+9jWls+cksD7RSw=;
 b=izU4SMQBOqlU9NnoM9gDBiU5ZT7HvPwCHbha+ZwROxPwnASq51FCKmSOTqgmioewLD
 gnCBIpwCCxwp0wS49AftXK8YlrVyFJM02tJZPRrWE0bbKOw5O7g/nZijglaQm3ABDRO+
 yYSi/JgingNckc5x8i1Ul3eZ4Oyvwy+TZCUcncOfnDvIsE7LbHx2tRkvMfytwcG3piZs
 pEGmVyCgUSpy7/cIvqMNVdCJvjF29czEGE04tglgiVr3c9OEzzK/ZVgs5ynGHDf5D8mS
 dnDwnOGe3Insolbev9O7uqaIcZbBFRrOpzkaYytkZr5D4VIjtaDsm8Cxq5amDC6Ytv6t
 exTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmczDjxAyjDzaTcOyL06L9gJ1PTRcntMC4U9AItBI8EOic4ncsipfCu3D1uH9xnlfYT9jnMgwT6xK@nongnu.org
X-Gm-Message-State: AOJu0Ywc09Oin4TxvykfWjrROVeyk0T1w0AuQaJp+UltN/WHczzqSXTN
 DxXsWmpBhsIcRtZTL/nBGq/0f7B6SSCcRF2/ELpuooog0FB/W6GdkAyxJb5RheAmCNc=
X-Gm-Gg: ASbGncv1blPCWTAZEULlxzA5Vq6c04bdNgfxDr6LOiphQyN6ecp6g0eeuNsXtYZGdYw
 bPA2Ocp1mFAQ0+dspsN2qsclDs/Li8tdMJSHtXnARy2GP5xm+SpuGXlb1N9zu4vxcv8/A7BAAtX
 Goo9lcdiUgzhoFSn98iu3FIQC/thX8EPRqClI2VZiVdUALIXy7D5KkPJVao9tSGXwC/ycAyRzET
 /ritZOgrvI2kzXmmuiWv7p26kmIHUW7Nqdhzq4fXLhvVG1tGuJ6yNuzJtVVEfuTisrB05OW8tvp
 uutiUzc9oW6P2qlYBM3Ar6ukdd9+oUx5zh1K2g6jentcumRMJawaGg62rQohWOfECJMe9PprXdY
 kP4kjKMokPG7vyZTzwWo3EEacqdhSsxVpcns8WR/8ob3INwawt/Rged1e0IUeoq5eOtnmmCRNHz
 Bf3/7LP1x1xza3Ebu3ZG6RYCHe9teVLBO2Kc0Lo7MYNLVI+kHduzTuUQ==
X-Google-Smtp-Source: AGHT+IH7OheyZPs9TPr+otf1kEZ7q1qgXF3Y0MfR0BVQSmBubwt6G2vjxM/oX98m2YpRjvVi9qzEjg==
X-Received: by 2002:a05:6000:4202:b0:426:d82f:889e with SMTP id
 ffacd0b85a97d-42704d74dc8mr9007569f8f.14.1760950476732; 
 Mon, 20 Oct 2025 01:54:36 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a1056sm14254801f8f.2.2025.10.20.01.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:54:36 -0700 (PDT)
Message-ID: <2047e87f-36e8-4e5c-bdf1-6f08192ab55f@linaro.org>
Date: Mon, 20 Oct 2025 10:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] hw/ppc/pegasos2: Change device tree generation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/25 17:11, BALATON Zoltan wrote:
> We generate a flattened device tree programmatically for VOF. Change
> this to load the static parts from a device tree blob and only
> generate the parts that depend on run time conditions such as CPU
> type, memory size and PCI devices. Moving the static parts in a dts
> makes the board code simpler and more generic.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c        | 292 +++++++--------------------------------
>   pc-bios/dtb/meson.build  |   1 +
>   pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>   pc-bios/dtb/pegasos2.dts | 167 ++++++++++++++++++++++
>   4 files changed, 220 insertions(+), 240 deletions(-)
>   create mode 100644 pc-bios/dtb/pegasos2.dtb
>   create mode 100644 pc-bios/dtb/pegasos2.dts

Please update MAINTAINERS entries.

