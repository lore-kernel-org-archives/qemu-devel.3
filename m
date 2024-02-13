Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D840CC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvAn-0007WQ-Og; Tue, 13 Feb 2024 10:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvAm-0007W1-2i
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:58:16 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvAg-000742-O9
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:58:15 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e2e44aad03so1346545a34.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839889; x=1708444689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h5cn83n6hhOkfB8NQH82kSPPQ8n+nyW8nkCPXbCqoW4=;
 b=BMCjikWtqDyHTxu/iewgQpzO2lwe7Spn9DC0zAQup8OmjWTh/4/eSW5OE4sFn5UPca
 wY9nf9IZyODKYVt/AiQ1/H9plAKVT13icMUvwfWUb4r+mHW5YRRyxjqCC1AuJ2ctX4Zf
 vysykxqKgbclYj5awHizZBX1doqCqf9xwHcVN75gy1hZrmHBGcK5SIeTWVf6ZgBS26wS
 J5duNgbcwqzSebOrb+eWFtbOqLg2hq3Novo5uM7Mlpsfnvh0SZ5oX/wgpTA1wE4WJT3O
 aSJear0/FnJoy8kg1n224/wVmXtZkbbuvDpvgvxNy4e3dmkm25Juw+2hEBOAh9gQF1Nc
 vSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839889; x=1708444689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5cn83n6hhOkfB8NQH82kSPPQ8n+nyW8nkCPXbCqoW4=;
 b=JXpCms0yBC/aKs3Ke+wVesfhLK4wyWvUML6zOzdLGGpeR8iW9Gq0c2WmwUVWJdV8/g
 ORhtY8ZwTrSGhFI055xX1XrKiMdJ2qNbVSpQ/d8bjNlc4aNjJRzxNX80zWr2a4GDn67+
 IqEw4lWdPTYS5IpTlefl9jhetIm0VcSYc7t8Arhr5UEZYOe3VkOmUucX6wGyxlGUg8tm
 85HzskvZF7Jb15a5NVW65MZVoVUXyPv4aQhIlvt+J9j3iEwB2GqQHC4swfTP9+eFEkTR
 0sMMLJTkLzW38MgoxNTTf+o4Z2sW5iGhhjnj4xDqi1REq18cUNSeSJHpWds0NOqGZqpa
 b78w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkv2K8Zzp8rRTyEgRMKdiLLo3nh/EzUjV3pMxxr78zPgxVCQBMXSzvJ3ovVhnD/8RiBN57xfxzIC5NrQh+uzn6BYHx5Ag=
X-Gm-Message-State: AOJu0YyGWu9bzc5sQebhbbJir74mlBrLTaOBb01M8rwyT4v68YL+Iv3I
 CWiZBgTKYUMN2OLQq1epvsFdTbptzNCDOh2wkq9zV3T1SPIKDOVPEADi13Zbml4=
X-Google-Smtp-Source: AGHT+IG3TXXF/mU1wA9gmi4B1LjLedCeEzQm1OxKDgj+/+duqwgekQUGX7EThy4W+di1DlX96ALHmw==
X-Received: by 2002:a05:6358:e4aa:b0:17a:fa59:bb82 with SMTP id
 by42-20020a056358e4aa00b0017afa59bb82mr1157607rwb.14.1707839888758; 
 Tue, 13 Feb 2024 07:58:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXBWFwAmNPA9hVC7tQcdfPu2TQ5j1keTGBhKDuL3VW2s3bxJbuJHswOwWFSeSAkqZc4Ubv4GC1L8Wwz92BiEgG5iDcYA1V7MfIGstSqFrfpM3d0ZGXcXU1Q35dyDQr8ytGFy/lQ7sTIOrUnZPWMwWKtsnezfGI1Q2TzVqhE2CA/vyJR/Bdjit1NFJYtPeoeZ0uP4cjw50dREzDHAGkm4TCX2nVs9yjWUlXC6C6yQwnIrGzlzXBii3+4L+wq3F4pdho8V74y2kVbRgUrRaNh6RrwFLVPenW/zW8HdAJjc9NWoG6nWBTdOYpCszVmqpwFRpgfc+6v1nQ+macWAeIuf6xlhoDcujZUL37+TXHXJz/TYKM0WvC2psxKthd9HM5YmZKdVurz4/4dNlP8uFA=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x186-20020a6263c3000000b006e0521c2156sm8185390pfb.173.2024.02.13.07.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 07:58:08 -0800 (PST)
Message-ID: <0307584c-80c4-42dd-8bf9-fde62cf15544@linaro.org>
Date: Tue, 13 Feb 2024 05:58:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma: Pass parent object to i8257_dma_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240213114426.87836-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213114426.87836-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/13/24 01:44, Philippe Mathieu-Daudé wrote:
> Set I8257 instances parent (migration isn't affected).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/dma/i8257.h | 2 +-
>   hw/dma/i82374.c        | 2 +-
>   hw/dma/i8257.c         | 4 +++-
>   hw/i386/pc_piix.c      | 2 +-
>   hw/isa/lpc_ich9.c      | 2 +-
>   hw/isa/piix.c          | 2 +-
>   hw/isa/vt82c686.c      | 2 +-
>   hw/mips/jazz.c         | 2 +-
>   8 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

