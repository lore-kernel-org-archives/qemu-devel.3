Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricu7-000120-4y; Fri, 08 Mar 2024 11:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rictx-0000zr-9D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:16:56 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rictv-0000aC-Mv
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:16:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5683247fd0fso853843a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709914610; x=1710519410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VP2eBKDwKx+gPLsEVplNclfeo0f6GzdgsS4MMibtc0M=;
 b=q16D5hmVX9FaBR9ogEGtQnXrzIX7Q2NUj+5zJlLssjZ8mM4w4L67luC4R7HPNtp6jk
 +unF32tqmXdG6WWOHe6CMDV3eD6L1JvW3Rfpd+474EILydANrAeqYUBw1tnvDVCOynmp
 eVcXO8AmraKe6EdKJZsqW/ZKESuZduFbJaZhHDE46Y1aVZCqUSr7xCIcrg11JtpweMMh
 sJGakcJiwhOa5VV83MD9FyaP8Ukak1nhuQqw6+Y8F0P2kADyJrAwM1CdN2n1XqTUdu/e
 qEH/SkfVOAnjQeW7HE+8eT+6pelsYDjuq+wQTvOOvSTxPB7lO0jUp2dUzH3mb65JdP0f
 HgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709914610; x=1710519410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VP2eBKDwKx+gPLsEVplNclfeo0f6GzdgsS4MMibtc0M=;
 b=UZ9MV6O846quW7HZ5FqkVJ6GwfpNPoaPrz+HcICFpmv5jU7SWbOpCzht0IVpad2pwf
 lIXH6tVmR/n9LBjuHEdeVJqqDLvNki7BHSes8fZEXJ8V2m7tMOQileYnOnml6fGaVsCv
 AGThCFSPLp35TTw1iwNoHHeNWeBqkgO8r8sKr2Er1iv2yRuHzrovoMmW1eKzGdsAFH3/
 tY2KjaOi3I7Q8+/mFzluQD2x+vvdM+/u1eHFx9Kc8piQFu2TWQlmIfl3ox6tq6ttlDVf
 kzQ4SpJYa1kEqxWAjwiSgrbwHnNNsr4L+sDpext+2DOcCdnAPQGc7ydBHm+AN8sd+K1z
 3A0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvL4DM3IW6DoNGltdptG2YtrWJHd0N170XXvm24sxT6/VkPIfgQKsMzMk8Z5jDS1D5gbdzGjJkcvdPkTHA4CrO4r+/mDQ=
X-Gm-Message-State: AOJu0YwWZYfrGfYC3V7zzkr/Ex5Ggzfp+xjIBphPOMIxSUwrleq2uGLF
 kcJHEeYlDuDi08vHbvLnqammNTSSpsLqSUkBwGoYUwdA9ctJHQr05VET+XgIQ68=
X-Google-Smtp-Source: AGHT+IEQcnyaJVu8R1Mh3SfFrKmPoltWVr5cbfmKQNyL4NaB2w8n1vxa44YEBKd85xNM92lrIDp5YA==
X-Received: by 2002:a17:906:57d4:b0:a45:a2cc:eb8b with SMTP id
 u20-20020a17090657d400b00a45a2cceb8bmr8318465ejr.13.1709914609719; 
 Fri, 08 Mar 2024 08:16:49 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 a14-20020a1709065f8e00b00a449756f727sm8255508eju.147.2024.03.08.08.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:16:48 -0800 (PST)
Message-ID: <6ea1d103-d6fe-4ca6-b522-d9a4cf4ef1d6@linaro.org>
Date: Fri, 8 Mar 2024 17:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] physmem: Fix MemoryRegion for second access to
 cached MMIO Address Space
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 linuxarm@huawei.com
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
 <ZerADmIeh6XnbOkG@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZerADmIeh6XnbOkG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 8/3/24 08:36, Peter Xu wrote:

> I queued it in my migration tree (with my "memory API" hat..).
> 
> I won't send a pull until next Monday.  Please shoot if there's any objections!

Thanks!


