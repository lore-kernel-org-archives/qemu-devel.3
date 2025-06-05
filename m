Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17136C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBsE-0005Za-Le; Thu, 05 Jun 2025 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uNBsD-0005ZQ-Gl
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uNBsC-0000dr-24
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749134835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPYCLM8pAN7C74E4v3iESVSdHeZjLAEBg/qIHEQDtBc=;
 b=Z2lw6QHeM86sfDS6l0o6STrkvGTD+owUEV6JHiTVIhas4YKeGH0tMwXz7G/HB+hQf/o+9t
 NunGGb8s/I3JqxkNkn5PxCHQWZIjFG3OPewkZ8UVopQx8RImWZ1SeOksmdJ6ONLQlKXrAp
 ml4azB+rpK4wf0fn7o3kNeBRqVOmi6s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-7gfE6tftNQORITftCxn7QA-1; Thu, 05 Jun 2025 10:47:11 -0400
X-MC-Unique: 7gfE6tftNQORITftCxn7QA-1
X-Mimecast-MFC-AGG-ID: 7gfE6tftNQORITftCxn7QA_1749134829
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so519762f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749134829; x=1749739629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yPYCLM8pAN7C74E4v3iESVSdHeZjLAEBg/qIHEQDtBc=;
 b=SWEmGYiFh4zauiwpu1YrLv1lxhE0IFOMOB5gO+qm86TZ2u6M0tzyagghFlguB9b+aB
 KaEhVM1/bnCuC1vwOLxJzQPlH0NurTRmpGDf+YZbU3b8ZRm0bIE16h7cUZxVBGx78QtS
 ovqgu32G45thMu1AEXzcrf3slfyI8jGZuWY6lT/Ij0nL9IjtJdLCFYo1P4G28LEELPak
 q40qc9oJHZEEGMh9jgLow8PNxtWbrJqBWB0siyt6k/Qv8JHcLb44qfiNr+kt8f8ca6B9
 iNIq2nBnOiF76WocOpH/4UfyXDDqaPZ11csxPdTt10UUkmHVSmJrO2Blo04zIL1duEuR
 o9MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOZc3llSZFcNDyOy5TnQX88gTQjGWhBTs7ZFsQlJ4gf3UOlsQSOyNADnXEl0ENlTT3QWYeWjnY+Fi0@nongnu.org
X-Gm-Message-State: AOJu0YzW61tcNH7GiPMpmOJS0f/s4PjHTe88XrmnNp3ulXIvRXDqHvQv
 sF4nmR9F7JJLo+VFjXDiHVxkAK2uBkQExmacaqrkadooHOFCXOgXo6Xnt9SWCmYxyUHNGFqrd3O
 ceSUYN2vREr4MBhleC+4ySXlrNZu23lLzfTPzpAq2QzhwutP4xLibCNP6
X-Gm-Gg: ASbGncu0xGRzR5GK/WhOs3tTtcPVa46tP86yDG/tCJkA0FXR3UaD6g/nWg0xkAKRrlp
 xLrTQCEia89YOg2r+ZPHn4hGb0ijVnB4CwZM6SoXQdFxNS0yr+6bJ8e7d4U0pMlJT6qfrzG2mPa
 B/xPs4y8aE9l5gBdOVMTHKKJMTTfX+kJF4e4z284BvqgUDp5EX8ywuCvGAVro39guU2IoL5wZif
 JQf0UeK816EiKKwlpqT2aR8n9hT3fdjRjje9+q+m/xWLFW9Tq1UzuiyLvJNlyBHZ2QW85TkHlJg
 xHoKadwBJaXHeapt5P4f0g3cCb98AFhAQiGhxBmfqrKhhpN1eLI6C+8rZRI=
X-Received: by 2002:a5d:5f85:0:b0:3a4:f90c:31e3 with SMTP id
 ffacd0b85a97d-3a51d961747mr5500374f8f.31.1749134828726; 
 Thu, 05 Jun 2025 07:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBbwXFluF8WwdHVbSwmvHPTI6CB1kWdsFS7cDZMhGowlafZMazZUkZTIpuJ6yEug3A72WpAQ==
X-Received: by 2002:a5d:5f85:0:b0:3a4:f90c:31e3 with SMTP id
 ffacd0b85a97d-3a51d961747mr5500348f8f.31.1749134828334; 
 Thu, 05 Jun 2025 07:47:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f99196efsm27015635e9.28.2025.06.05.07.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 07:47:07 -0700 (PDT)
Message-ID: <ac3db5f0-d3e9-4c8a-ba8c-1c691d99ec99@redhat.com>
Date: Thu, 5 Jun 2025 16:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0
 register
Content-Language: en-US
To: taotang2025@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20250605022640.598308-1-taotang2025@gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250605022640.598308-1-taotang2025@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 6/5/25 4:26 AM, taotang2025@gmail.com wrote:
> From: Tao Tang <taotang2025@gmail.com>
>
> The current definition of the SMMU_CR0_RESERVED mask is incorrect.
> It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit while
> treating bit 9 (RES0) as an implemented bit.
>
> According to the SMMU architecture specification, the layout for CR0 is:
> | 31:11| RES0           |
> | 10   | DPT_WALK_EN    |
> | 9    | RES0           |
> | 8:6  | VMW            |
> | 5    | RES0           |
> | 4    | ATSCHK         |
> | 3    | CMDQEN         |
> | 2    | EVENTQEN       |
> | 1    | PRIQEN         |
> | 0    | SMMUEN         |
>
> Signed-off-by: Tao Tang <taotang2025@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric

> ---
>  hw/arm/smmuv3-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..42ac77e654 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -120,7 +120,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, EVENTQEN,      2, 1)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
> -#define SMMU_CR0_RESERVED 0xFFFFFC20
> +#define SMMU_CR0_RESERVED 0xFFFFFA20
>  
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)


