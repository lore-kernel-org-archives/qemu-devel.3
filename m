Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4794CE7AE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTo2-0006Wk-V6; Fri, 06 Sep 2024 03:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTo0-0006OS-KY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:54:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTnz-0002NY-3b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:54:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bb885f97eso15401875e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725609291; x=1726214091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KCgIxjhAzS/8fVclyI0j42g3a/wD1pY2eNjLsYPd8pE=;
 b=geHXhUrO3Zx574zu9aBpffMcws4c20UPWPAKVUJV5vOtLxFsMWEMgQWTSKB1oDxPy8
 SSeXBkAtuo9jvqOiMqms67wdq7fMshZcruRe749vpiGE3FhO1KjxhOtlMigCTVMBhspw
 MR4DIIl/wMG/6Qho334ILSnZxK68NGi/hzn5soSMGfiE9QIswYowL7si7rknCtCCu1F8
 Hvu0wEU4FNs1AIlI72lUP5MrsO6pRaShDzuPfVyTzh6noodKJjVZCRyybAxS7rVud0bK
 ABdUccj5/bNVv5tEKkvTTUNfbDPuUL2TfRw6KuEXROml14ic51/UAfeUoMEmb8g+mdWg
 MX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609292; x=1726214092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KCgIxjhAzS/8fVclyI0j42g3a/wD1pY2eNjLsYPd8pE=;
 b=PHhU4qUWbddBIlK0i22cH14koOxNuFZSn8wrcf9Nj5YTpeTfqrO1PeEWll/5UvnCCo
 vYItM61mfbEwSH2f+HpdzQ+u+hpaqL9yXFPtBpCwgBvnYKPzPEHgVRDbW9vojbrIj03q
 CkagiV+Z7TSBGAQHUGtV3Ovvovhhm+gpfZG8TY6RPtwlNN4GWKgEk4LODQ9rtzHTxcLY
 T1kdj7BiONyNwNjIIzvh+nsnNpAd8ZyqpTMewEEvSNgw430JvJoZbQOyWXrvYOQHLyQX
 gozsjvGFUs5hgjvJOW6IVJkRP2OLz+aTz4cioIOke/nwDVEvwDseLRzixufLmIcL3BoS
 eUYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrMEfjgIGXyTHI9IuIWX6jhLxdbOU10x7B0LhwpIPwlgJg/iTA1/0DQBMI5/Z7RMbYmRpOJrNW/qF5@nongnu.org
X-Gm-Message-State: AOJu0YxQ7VNhcq+5SGPtsTsFj0lbSBa5TEAWaQbX8nSV/5Q0Rp9LeTnT
 ab31xfnPIzbJMrl3/c+WhyEym9DjQdIdYqiYlQuGAcJ5/R32VegOZgiS/McRsyg=
X-Google-Smtp-Source: AGHT+IFq6bvcJqDrmFtDpifWQiGzOi7DPCSItdIGgLxNKkdjrF8FfJS5Q16wum2au4p8TA5nBq/59g==
X-Received: by 2002:a05:600c:1d19:b0:42a:a749:e6 with SMTP id
 5b1f17b1804b1-42c9f4cb3f3mr10639765e9.10.1725609291496; 
 Fri, 06 Sep 2024 00:54:51 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05f9ac2sm11598965e9.47.2024.09.06.00.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 00:54:51 -0700 (PDT)
Message-ID: <36e626bb-d685-4580-a287-337945434f18@linaro.org>
Date: Fri, 6 Sep 2024 09:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: define _AS_LATEST() macros for machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20240905182106.3663665-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905182106.3663665-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/9/24 20:21, Daniel P. Berrangé wrote:
> Follow the other architecture targets by adding extra macros for
> defining a versioned machine type as the latest. This reduces the
> size of the changes when introducing new machine types at the start
> of each release cycle.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc_piix.c    | 11 +++++------
>   hw/i386/pc_q35.c     | 11 ++++++-----
>   include/hw/i386/pc.h |  4 +++-
>   3 files changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


