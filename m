Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebKs-00089H-1A; Thu, 15 Aug 2024 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sebKl-0007fl-KD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:20:13 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sebKi-0003nh-RU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:20:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f035ae0fd1so11245011fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723731606; x=1724336406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SFuSrwMBstTqOta4hVA8b8IOSdqyLaYQbqnp28bJ/aE=;
 b=Py8RPv+rzkK+Hy2v6y2v4ZchVHQBwoKg+iohsIEcyMWQOMFQCuhvYqSO48SEnedMp0
 6ONd+Qvwy19v9GwI1K+87C0VZZh8mv7Y/Qp77NRwvU7SJUAhCzUzhP2xf9MV3LbSlgtH
 pjGixpzzYNKa/NB2RiyOpUM2n4yywA0Fd6zmO4lCzv9Gs4U4xKT9hJy7VdGRoT+ewEZe
 cV2wp7RksA0ID4cuVO0aXNuR5LLjWF5xv/+0fR86O+3umNLkzPctQmxPnRZYl6ZiyjwL
 vDS3ivw5cvnb5F1ELgvd71zS2rLPNMtFr6wcp7RqlDyvMr9q7V2kH1VJBOMQOrzOCaXP
 MRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723731606; x=1724336406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SFuSrwMBstTqOta4hVA8b8IOSdqyLaYQbqnp28bJ/aE=;
 b=WSXFxv4XN38pox2j/teE5gKr/fExCoJsYR5+1OBX33K+d5Mp8pSu3Hfp8FW04sIaQk
 tUZxDkKTdAjbx+yi8EDXqk950o28vrTu/kDkHCIEXl+PwiEChqi50OhvfKwyIXDaL2Pa
 6xoY6EByiST+ibK5kmw3Dmqn1/s5e43b1mWIp6f/q1TpHBZhOYjIXAuQPc+LPk2nvIG+
 LtOgh6mlzr+8vvOiJIjgn/SRoRI4lAa4XEdBucnEzjkmH0tyXr1V52MogSfEspemStPk
 5M/nPXtZvBitWTVWbavZB5/WFAPNou6YGfWFNmYgSg4UrwSrMs6jKilzMu3wRpN5441Y
 H9jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm38s3+tFvDMCCf2XKt9/QlQGuY+jZdoy1dfNkcUem50pddPXB1yUBk6uFLwQPkkkc0PgaPh8i9SB5FHOq1/2b9iz/ITA=
X-Gm-Message-State: AOJu0YyPqPYLNe5LAU8N1PDAxeHQ78q3qGMWnnNmWnXbGiBnm0rM45Bt
 wJuKdEvG4PoPAEYIIKXT5GOZhSCdOHhPHt+8zIFNhJTB4z84254xpK5+uhgZs8Y=
X-Google-Smtp-Source: AGHT+IEvKfj8S115NLs1rMZukA+EvtR/T6xrtrmM+rsBSdcSaz2w6woDuwyVOJgbEUptqbOYap+Dow==
X-Received: by 2002:a05:651c:19a9:b0:2ef:2525:be90 with SMTP id
 38308e7fff4ca-2f3aa200791mr49906281fa.31.1723731605955; 
 Thu, 15 Aug 2024 07:20:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbe7f17bsm960376a12.59.2024.08.15.07.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 07:20:05 -0700 (PDT)
Message-ID: <4da9c616-4c22-44ad-8c36-c787e920a9b6@linaro.org>
Date: Thu, 15 Aug 2024 16:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/vfio/pci.c: Use correct type in
 trace_vfio_msix_early_setup()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 15/8/24 15:52, Peter Maydell wrote:
> The tracepoint trace_vfio_msix_early_setup() uses "int" for the type
> of the table_bar argument, but we use this to print a uint32_t.
> Coverity warns that this means that we could end up treating it as a
> negative number.
> 
> We only use this in printing the value in the tracepoint, so
> mishandling it as a negative number would be harmless, but it's
> better to use the right type in the tracepoint.  Use uint64_t to
> match how we print the table_offset in the vfio_msix_relo()
> tracepoint.
> 
> Resolves: Coverity CID 1547690
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/vfio/trace-events | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



