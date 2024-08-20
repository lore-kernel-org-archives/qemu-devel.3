Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D938C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgM8a-00057e-NJ; Tue, 20 Aug 2024 06:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgM8Y-00052i-7R
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:30:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgM8W-0004ZS-5m
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:30:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a83869373b6so547072766b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724149846; x=1724754646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=narlSIdKmGpeZ0AyQoG0UCj7d1FUnWnKXro6JQ3CEBI=;
 b=kyfLiZjFKnzyJIm2biwe07V3CCOYfS1M7/CSCfdXrlz1Ck166G/8cv4njdBVUfHA56
 aIfwTPd5pdP4gRhZ98svQnSR6BG/LEQlorGq8SBQbO6rSLH/49TZ4PUr//SqROKOVcWJ
 86fQyCv94/06XQ7dRDpVNep4hXRheSShNPCdqhC2DMUP7au7BR4f3P6YM953HOnZKN+6
 IDO9TSVfXGR3qPvpyx8by+bfuYrpK/tqYNjg9GufJIwAP94M4sHDkN1NEEv6eKd3tlup
 rzmtAi2DWL3FQSPhS5yTfpB5lB2SwwJa6r+VOXg5McOIxU/LQigPjyyAlsTZUouPfULY
 BkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724149846; x=1724754646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=narlSIdKmGpeZ0AyQoG0UCj7d1FUnWnKXro6JQ3CEBI=;
 b=UQUrQpX+VNsQZgWjP9qg9olqehzjsjDBOmMr5uNlhS27Kiq0VC7nXTZSvOzZJWKsZg
 7dfMn01buvd6Egp/W/jAQ9ENDYf2X1aWwrbx1rOBipDQRg5SxIytZ2Fb+JilqRuHE+RM
 htgaAooDPqQ889rWA1NH7TQhTNNeJpn9ZZY8lzl5wos8+jyjamEtN+huU8Ft5Q8IGewm
 sOj9j5Mju2vDKV0cLsgwTR+1eZl7KRmYqLv9UwTnp9in/L3b3YXAosAfMw2ZE/JLomMb
 mP7ISm/28tgMP+aimhETRKjWxBnC9qQ4WA1gn69PnwMuBnr/I92jXEx1oLNUJvcv6VXB
 QIvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8SQJFiL1c+VOrc0B/ILXvUY6usAugTqunlryKjbVUWtSyXB9b3qjK2bZw7gRyJMGLHnCxRm9B/gQW9iFak84pY6/J3g=
X-Gm-Message-State: AOJu0YxTFlhEO0Gs5uTi0o8ZImXhIdD3ZjC9sp1ZzaRZ26khcTsMkJvY
 8pq35rV3HP/5GUKc3ai/SmAgWnLDoP144JiZh+sf6joJDmfl2p2JG31stU92mjA=
X-Google-Smtp-Source: AGHT+IHLov+tZBmhGIW+SJui9/VN5ZOkbyqzkCI/kcR9QEUpxr5VzK4YvqxCMRP83CekEGjl8J8WEg==
X-Received: by 2002:a17:907:f7a4:b0:a72:4320:19f3 with SMTP id
 a640c23a62f3a-a8392954065mr1020171666b.39.1724149845895; 
 Tue, 20 Aug 2024 03:30:45 -0700 (PDT)
Received: from [192.168.223.175] (84.21.205.77.rev.sfr.net. [77.205.21.84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396d013sm741172466b.223.2024.08.20.03.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 03:30:45 -0700 (PDT)
Message-ID: <65bac872-f461-4e2b-b959-7bf020139fd5@linaro.org>
Date: Tue, 20 Aug 2024 12:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-9.1 1/1] hw/nvme: fix leak of uninitialized memory in
 io_mgmt_recv
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, qemu-security@nongnu.org,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Yutaro Shimizu <shimizu@cyberdefense.jp>
References: <20240820044505.84005-3-its@irrelevant.dk>
 <20240820044505.84005-4-its@irrelevant.dk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820044505.84005-4-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Klaus,

On 20/8/24 06:45, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Yutaro Shimizu from the Cyber Defense Institute discovered a bug in the
> NVMe emulation that leaks contents of an uninitialized heap buffer if
> subsystem and FDP emulation are enabled.

Was this patch posted on the list for review?

Usually we log here backtrace, reproducers.

Which fields are leaked?

Let's avoid the proven unsafe security by obscurity.

> Cc: qemu-stable@nongnu.org
> Reported-by: Yutaro Shimizu <shimizu@cyberdefense.jp>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c6d4f61a47f9..9f277b81d83c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4474,7 +4474,7 @@ static uint16_t nvme_io_mgmt_recv_ruhs(NvmeCtrl *n, NvmeRequest *req,
>   
>       nruhsd = ns->fdp.nphs * endgrp->fdp.nrg;
>       trans_len = sizeof(NvmeRuhStatus) + nruhsd * sizeof(NvmeRuhStatusDescr);
> -    buf = g_malloc(trans_len);
> +    buf = g_malloc0(trans_len);
>   
>       trans_len = MIN(trans_len, len);

The malloc could be done after finding the min length.

Shouldn't we check len is big enough?

Thanks,

Phil.

