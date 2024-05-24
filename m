Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7DC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWQx-0003OU-UX; Fri, 24 May 2024 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWQq-0003N5-H4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWQo-0001ZK-D9
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so19812455ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716562925; x=1717167725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ukw6QuZOzysoST7ygut7RNMdKgHMxzWY++fEYL+FqVw=;
 b=Y3athVAM9JzsEUqUODfotqMzeEDofTL9FIlO/CI/Pu1ckXfQiwfGWTRpXBLR5V/X+5
 RYF4gSiWp0UxJ/lFhi0pD73X71VdAu7FUkVD5xfAUfuQGIufZUD/yaNZHaxKZ47l6smp
 +JSm7Qf0yI7th9GPHEqpf5fgf7ubw2/vofJIMvFBxPsQHLYUZ1UPJ/fjLg7kNd5iZLZI
 mqib1s3q3AcvGRy1NDW6qtsOAxNgpEFckTfDiSk+AoqSA75sG3my0ADdaVGNTtodvui7
 zHT6Y9Gyr6jpUb5Urpd6CuCIhQ7/Lsz2yZkSG/bTFTicvGDKaP7XV62qxNl/jHjkNbHK
 YkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562925; x=1717167725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ukw6QuZOzysoST7ygut7RNMdKgHMxzWY++fEYL+FqVw=;
 b=IrfqEU6UxBYBW1y15HfgIFMBZUq073JTNj3AY7JpGdwBGbDkI8u5q4P+MyCnjY37G+
 HgrgsEyAmvz83js9/aki2DTH6f+nvdCeVvMZU3Y/vnMsoAVUQUx7OjWVgx1JIe+Ghbi4
 YXhD0UBugtYZKzTgpuwmIVjD1MYJ8rXaoS7240uxxsjWi5AHWyQn8ZJrQhd64l1nM7tv
 tqlqpSKnZFuJxBK85PkFckHguQThpZscJGIZ7r+vvZvR7KVmJe4DBtDdbT7Nimr/2PB6
 EufSdqkDfK8/78D3C80BNiUxpUKacO3fdEkFmZfsoTRa/BsFLSovJcppd8dBF9XvKgtk
 2gxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQLuOqLXllwo6c4RAiAzBbRsQ0SYsX00euTKXGSWo/H0AV/5rP08Mc0m9myvN5G7gvjAK6BvAuViI9a/nfs6Axz20k2pk=
X-Gm-Message-State: AOJu0YwucVVWpjjwhNc5qsbQVt+ENC1zViJICqBbVvb20ND3h59Ib+ZT
 712847U4FUK1o/BHQMfa75/4f/O2z8ul1XY/fVIvWEFILR1DITrvDn9Qz5XMty0Z90PMtymWvV1
 q
X-Google-Smtp-Source: AGHT+IH1lfU31hJTxy4bRouEAgDmzuTgXNs2hdDU3y5GTOKcsHO5m2+fBhHjANX9B5VhxWaNTfpVFg==
X-Received: by 2002:a17:902:f549:b0:1f0:98f2:7cc6 with SMTP id
 d9443c01a7336-1f4497df612mr35281995ad.45.1716562924918; 
 Fri, 24 May 2024 08:02:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a4fadsm14891655ad.224.2024.05.24.08.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:02:04 -0700 (PDT)
Message-ID: <7554ffb3-bf59-4baf-bc46-503cc696ec16@linaro.org>
Date: Fri, 24 May 2024 08:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] target/i386: cpu_load_eflags already sets cc_op
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> No need to set it again at the end of the translation block, cc_op_dirty
> can be set to false.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 37 ++++++++++++++++++++++++-------------
>   target/i386/tcg/emit.c.inc  |  2 +-
>   2 files changed, 25 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

