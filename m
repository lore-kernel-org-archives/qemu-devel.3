Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74415C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3viS-0007UT-3E; Mon, 06 May 2024 06:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3viN-0007TG-Nr
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:36:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3viL-00053g-JU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:36:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so18692945e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714991814; x=1715596614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gbERU2EUKio/9VYC15pBdiRr5aTSNsOVieOtetEPnM=;
 b=zrC7qdHyuX9EIF9SSxXhywyufU/OERx3zMJV2u2CGZYurzqZj/8NCIvxDVigbWCseW
 IfbAlGBG+LrKYjEn4gFtA6VvE/5hR2HcD/6M+2E5RC8ToJdgLP2nx5ah+2WHpqLAZ4HC
 4NO7+Qs/1hBUEPzngQfAGbXlw8+HaYJKD1qUEWYfTuhB9OMmVj5q+I/ujbl6fXnLqoic
 ug/V/Nx148Y++kl6abBCGeOb8AsPGnxw31Q9zKeylZkBDxNbIbKsds7OY0hC9vFjcsVa
 Cty+yyfh1Qn7xx0enG9TESwMxksDM1uKHqL9eC90sRfIoxCVuRwKGkJUDT+kkUq1+EXJ
 /Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714991814; x=1715596614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gbERU2EUKio/9VYC15pBdiRr5aTSNsOVieOtetEPnM=;
 b=p5Io0+o8sc9ZQg0pkGt/CvjeaphzdBZOFFOhtZMd7cX/QqH4yVUxt8519ySeyCQFA7
 Y3APTQ9aP63nXFq5WqIdGWraa0zWuoVC3FJi3FeqzQuZeGIrBvBcoki0/35VzjwNG+pS
 6Okdgh17Iv5xR3Cj1E1UO+RZQjT53u4tfAJRjyS8iYQiIM8h5ZmI/3KjDq2cBKsuWk3J
 EUa7IAYjdCXY7Hk+2Kao5Bn8c8Ys6ywuk9KG07Dxwtvh1AyRWyilOxnH+ft3jYdRlU7C
 zVFh/ipkAQT2N/8ce5pxM9OFPk+Y96GKDfRLd+vbEfiXau1y23K69iWWjes58GwqBkF2
 lHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdD1QmwTqWH4cUOkBS7RUss/H+AyyC/eI+nTR2IiY/uZZVKo5PSBftgtroYrni5A1ah5dIO1coTiqcQmsseEoD5LfaCYQ=
X-Gm-Message-State: AOJu0YzjEtTugQQX6a9itbJrW1TvZ7V+Unlu2VlqjZqAKQLPEJoEFkhs
 oOcsAfhUKCQc+IV5o/XD+vAB+kcJDcRO64AP+QqSHUIxn5wtSWsAA+1xvaH83nQ=
X-Google-Smtp-Source: AGHT+IFxIduS/Hi9V3WeJpIXZex9Yo3NMa3nESwpuMTu8S6sUkGShHfIRM9QuBAXU9esyV9csEiG4g==
X-Received: by 2002:a05:600c:8507:b0:41b:f577:373 with SMTP id
 gw7-20020a05600c850700b0041bf5770373mr10391181wmb.15.1714991814342; 
 Mon, 06 May 2024 03:36:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 o27-20020a05600c511b00b00418a386c17bsm19248674wms.12.2024.05.06.03.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:36:53 -0700 (PDT)
Message-ID: <b4ac59e8-c9bd-4ed4-b252-b4dbdf0a842b@linaro.org>
Date: Mon, 6 May 2024 12:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] xen: Support grant mappings
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:

 > Juergen Gross (2):
 >    softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
 >    xen: let xen_ram_addr_from_mapcache() return -1 if not found entry

> Edgar E. Iglesias (15):
>    xen: mapcache: Refactor lock functions for multi-instance
>    xen: mapcache: Refactor xen_map_cache for multi-instance
>    xen: mapcache: Refactor xen_remap_bucket for multi-instance
>    xen: mapcache: Break out xen_ram_addr_from_mapcache_single
>    xen: mapcache: Refactor xen_replace_cache_entry_unlocked
>    xen: mapcache: Refactor xen_invalidate_map_cache_entry_unlocked
>    xen: mapcache: Break out xen_invalidate_map_cache_single()
>    xen: mapcache: Break out xen_map_cache_init_single()

>    softmmu: Pass RAM MemoryRegion and is_write xen_map_cache()

I'm queuing 1-10 & 13 to alleviate the respin, thanks.


