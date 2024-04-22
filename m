Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4BBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rysYx-000884-RQ; Mon, 22 Apr 2024 08:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rysYu-00087m-37
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:14:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rysYq-0007yJ-S2
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:14:18 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34b1e35155aso736487f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713788055; x=1714392855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d3DPCf9GTqCWcyTatfAVWhXEDXCBNwuWi+9pWHCgMtg=;
 b=LEFYRmK9oPpcysBatcEarh78ZUx63lQjH5/cCz2avK1JDXbkd8xC2WHbRgbyUrjVH3
 96qQYepzH0bildUs1M7iecnDQ3A5xzWV2Jd6Hx/ZWOZTt8ncYVLU//uIXXilLac0CSPJ
 aR3rvlrcTnXVmU3IOfR2unPHG9Gqm46lJwnPBdUvlxSOhWyq01AHU4qNIPIJ/tK78VUy
 xDTCU/NzTxnZXOGECPXVGvFhMykJ3WWJ3UrNPe2o9eAXszvdeRY5c/SsRvjRzLUfEwOs
 wI6WbZOugKXcJwkd5KiRSJANNmP6CRtgrrU9IslYEU/bVbqRTe1MTstLZJgK+TJZCjQq
 4k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713788055; x=1714392855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3DPCf9GTqCWcyTatfAVWhXEDXCBNwuWi+9pWHCgMtg=;
 b=sirav8vo/PTlyk+sJRDVsjSnUsSHinjySmEHyMicUppeTBIwX8yZmNmbsFJoEIJKKu
 zswMInAkl9JHEd1lQupEpy8NZujOUZklbqSB5g1bJk2LJ2DEnR6ISwvWiXIpK7XEFJgc
 9feqdGbvNRX8vJ1JYUpUysvD1gTnh30fzTg4/Taf6tZ/x5SqFALHYbjO/j1E+tZt1iPj
 qK9925wfsrE74KRn2mgnkSc8DZUpWoslY15ysqQp8yNZ3sMwZZEeE1ogcdW9mYyBTysA
 GC5wwZqSroCziqTzQkwFjQFUOAdLVftMq8H1WPX2YnhHvkMU9QXEdkLD+dBDJULKs6cS
 sYOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6zU2zIc8PzXtqOYlUlnOVk7n21xbm7m1UWxjKAjFm8TfZ96dI0oV3ngjpj92Y8FzfkMAv5/hAq0WId8fMAVYj+uEUjlA=
X-Gm-Message-State: AOJu0Yy4Q6WAyhEwbXM2R2bAtk/wcnulNgL9DPFK6ul32kw3vkeRVSn6
 B703811T4kesAi7tbnS0ikCx/QvVj7FQytGjH+dCBPchoiqdrm0XVsdtb/mZ9cE=
X-Google-Smtp-Source: AGHT+IE7oJhn0pCLXeH42OGaQl21MDmYErNJAzJ8qlBfOdqyqFQyCMUKI04ifLqv5oCxRTv5EPtd/g==
X-Received: by 2002:adf:e542:0:b0:349:fa94:ef18 with SMTP id
 z2-20020adfe542000000b00349fa94ef18mr8251565wrm.50.1713788054198; 
 Mon, 22 Apr 2024 05:14:14 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 h1-20020a5d6881000000b0034615862c64sm11866444wru.110.2024.04.22.05.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 05:14:13 -0700 (PDT)
Message-ID: <472fcf10-c624-4077-9f2f-5490604bceb2@linaro.org>
Date: Mon, 22 Apr 2024 14:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pythondeps.toml: warn about updates needed to
 docs/requirements.txt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240418091654.16878-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418091654.16878-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 18/4/24 11:16, Paolo Bonzini wrote:
> docs/requirements.txt is expected by readthedocs and should be in sync
> with pythondeps.toml.  Add a comment to both.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/requirements.txt | 3 +++
>   pythondeps.toml       | 1 +
>   2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



