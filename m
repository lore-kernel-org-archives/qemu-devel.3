Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE51C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 23:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmiwU-0007Zy-2x; Tue, 19 Mar 2024 19:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmiwK-0007ZM-VI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 19:32:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmiwJ-0002F5-GJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 19:32:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1def3340682so39646835ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710891133; x=1711495933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bNxUHF1e16qod2GhTFZlB6cQuWrS4eO940/YtcLJmaI=;
 b=sGh4ClH4gtTgT2ZhuTzZyxbECABpZM86Y4DM14VSibzp2iyoz4cpzrcWljWG6mUd66
 qC/wI6AVtSQd8XamBnbAytjzn04TKm/T5Y/DwlopghhUObo6vJuJd35j2EhjAG2H9K7K
 bCDYCZEI1stWliI2JyWqKvJQPvPd0qRG/3khfnk7hoSRm4l6sajQRH2WuPOCElqhlOhj
 glrAhtz/nifnX3daf2p299oXLedYymy7aMsCRP1KW7EEcZxuT+Q8+ySTb1OWletEM0H7
 ZpDis/cNGlC8GzXdVut6xyR6VUgOR4PPs3PTL2H7UbSRdH+PwyMFux9I3S6SotFUE0Wm
 uyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710891133; x=1711495933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNxUHF1e16qod2GhTFZlB6cQuWrS4eO940/YtcLJmaI=;
 b=q3oxUe3giBhrRRRn0RwEO5VqD+eqiZMcUsXKBg2g7Bx28J2AsCm7osh7T2oyWBtlqO
 2+bybQFDVIwWeUSUqcw0uS/Dcmy59ozaAvAIQA6JQe1RlZN5AcuHNkFN9rN6vIpe9SB+
 x5f/O6oNC0iS+CVQ8tUwpFMNSO8sWTTklsY6TeL3MA63Uad6l7nLGGT27iW1K7aWbXQY
 CHJKUFOneyb73JeAIj8fvxpkpIgwCG3PZce8Otpmpq48GgsZMibONznKIcxMXotgvvQT
 jcJPSMfIAJfnvT16Sd0itnGbDNg1NsUqUyvJX4bq9eDpbZD9Z0T2hdVDL6QLDkbgeMm7
 EFdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTwNYb8tKljSgpr7wMn/83zNZIRtoKENuK++gNYwANnzVfE4N0W/AOgHD1dgmqieWqRxtpj3NSWC7cXc2XU3m2AZ7t3u4=
X-Gm-Message-State: AOJu0YyJ+SsagZBUP3HkeehuD53mQAaYFMDeW8e0KqmpfkHd5susvQV6
 JAyO52RvT680BHcZ8BERclYZiykYe390Yf7jrOCusApBqAK/cg3anPw+mhSheKg=
X-Google-Smtp-Source: AGHT+IEd8Mfd93qgpOIZ+LhU9ySYLq7VjnFID9Ze900W37pbR4MGOGhgXa1trhv3Qtl0+Muk9KjxIw==
X-Received: by 2002:a17:903:2686:b0:1e0:3b86:34ca with SMTP id
 jf6-20020a170903268600b001e03b8634camr3570898plb.38.1710891132766; 
 Tue, 19 Mar 2024 16:32:12 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a170902ea0e00b001dbac604e4dsm12048816plg.146.2024.03.19.16.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 16:32:12 -0700 (PDT)
Message-ID: <675f13e6-4030-4099-a97b-f5bd38d030e9@linaro.org>
Date: Tue, 19 Mar 2024 13:32:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Add right functions to set agnostic
 elements
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
 <20240306092013.21231-3-eric.huang@linux.alibaba.com>
 <c765adcb-2702-45d3-b875-6eaa6b6d7d0c@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c765adcb-2702-45d3-b875-6eaa6b6d7d0c@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/19/24 11:57, Daniel Henrique Barboza wrote:
> This seems correct but a bit over complicated at first glance. I wonder if we have
> something simpler already done somewhere.
> 
> Richard, does ARM (or any other arch) do anything of the sort? Aside from more trivial
> byte swaps using bswap64() I didn't find anything similar.

No, nothing quite like.

> We recently posted a big endian related fix here:
> 
> [PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
> 
> But not sure how to apply it here.

It's almost exactly the same, only with memset instead of memcpy.

     if (HOST_BIG_ENDIAN && idx % 8 != 0) {
         uint32_t j = ROUND_UP(idx, 8);
         memset(vd + H(j - 1), -1, j - idx);
         idx = j;
     }
     memset(vd + idx, -1, tot - idx);


I'll note that you don't need to change the api of vext_set_elems_1s -- so most of these 
patches are not required.


r~

