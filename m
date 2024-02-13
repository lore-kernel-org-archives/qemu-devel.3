Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C021C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvzP-0004Kg-VD; Tue, 13 Feb 2024 11:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvzO-0004IK-MK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:50:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvzN-0000Qo-7t
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:50:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so3354782b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707843031; x=1708447831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEUOzXNt/9o+PtLAhI44l1ZDjCFzHk9JXDaGXPPe/u8=;
 b=WBqpOqgWOtfRRnIuTqWgLZO+gNqVycefWLA0zape/Tl8a1r5RnxXDw6oL9GuI3TfTT
 QhUnwPTWFbOLhpd6yKI9/sQ1u7PHPChAgPpPMK57jABxahp0AsMqjC2drFKbq8h+CENJ
 koLvG/n4ADrFRN1DRscGptrP65vu1pzFY7pbFpmgpXnQ7GSP7gmm/mDTfma8Ri01yixx
 5WUCVaEGD5KYGHTSPW3aMS3r60O+8SamNMQmUuZ2gRxNnAWqsS3KjDB86NJX4sQdH/Bj
 H6gLiNdKzPsGSHnZ0//DlXVQYetM/Sy03fpnCzpLLGrHSklsUqgxJTLoEpN3ugv5Ig6z
 cAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707843031; x=1708447831;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEUOzXNt/9o+PtLAhI44l1ZDjCFzHk9JXDaGXPPe/u8=;
 b=AgAmLVpsVehvtsH9KvahvAHMUVCsU1FIZcKZxiJ5DvUQUjXTo5grQo6JE6JO2Ir9tZ
 3kCwN723DBssQEpSfPRuW0hdtgVKk+S3Hf+UpvdemU9GHg54mrt7diMhAdNimgRaTGUG
 3dI5WnQDiPELubTn/j/MNbMLpc8Pq24fDgzLeet+S1W8R439FQYMSzAgZyMqpYG6R2yj
 t1ZXEjunLwq1NfRQJolQP31YOrS3u2+u0MfPkoM47UvZC2PItorUHitT6jYuHjGc0Dsg
 RfTdT1wxLbDednSMIJWbvCkRQBepFV32vkQXaKRGS3vlssTEW9GVQNIMnQcGot4cvpqT
 nt9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB54RX0y7TskRJgectXwCiWCRObsEVs41eCkjqWZa9E0JsBSTLbVQ7UqARVxmj0huipTbLS7J+ETk4jAigGLFruOrW7rU=
X-Gm-Message-State: AOJu0YznbNeZhsZ191G8q78QrsHamUPW2IsqeD6COAdl1C9UvPBhr3R1
 4mhj2sUQxOIknRu4xRFuFAQxXRcldlhzn7QlzzPzTURda6gYBXSxttv+1rJYK2VzENEMBLtOeIp
 I
X-Google-Smtp-Source: AGHT+IGfhXM1znaRE8Hb+wMENX3ZfIdEnx/LjUsHHoI/x6d6MKvVWZFtuSP2XXVHDMLYaDmX1UVIiA==
X-Received: by 2002:a05:6a00:986:b0:6e0:6140:5e1 with SMTP id
 u6-20020a056a00098600b006e0614005e1mr10920866pfg.25.1707843031100; 
 Tue, 13 Feb 2024 08:50:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXc9xXu7QSvfNKXxOjRWUbcDWLKEJcxJp8gm6GGkn8RIShAahGIQZYo8snxmf4ld9qBiVMde5788yR1hJazuQ7Q37zVFEs=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k1-20020a628401000000b006dfff453f8esm8010823pfd.75.2024.02.13.08.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:50:30 -0800 (PST)
Message-ID: <2abbbd2f-2b55-49c3-abf6-244f6d57e4d1@linaro.org>
Date: Tue, 13 Feb 2024 06:50:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/ide/ahci: Remove SysbusAHCIState::num_ports field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> No need to duplicate AHCIState::ports, directly access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ide/ahci.h | 1 -
>   hw/ide/ahci.c         | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

