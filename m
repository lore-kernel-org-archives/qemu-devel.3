Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7062C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWly-0006Wk-3p; Mon, 10 Feb 2025 11:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWlw-0006Ol-Gq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:36:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWlu-0005K0-5X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:36:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso52714655ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205392; x=1739810192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sA34eSYtb2hei5cnm5DD6ciUagJHPxNVHOb6EHf0cBM=;
 b=pbw3CXzDzKerOzz4Jxyfk9VR8yfRQe2ME0a0puDyHKkpauIGZMtq/g2/w3GmyOSWJW
 CKdx/LbGlADtoRkGNpG7TPmR/GdI2RSmsuT2rOtTr2cbWWKYHTpMSi5Ja3CO2tRSRCEI
 X0A70IYNDeBYQFFraeCetcp0+V4hu6SnIHbTqO9LA+0srtCD2top/ZEI2mx7iWcjzi9I
 uJHIpql/FvbzcbwJ1SaOAzznfHPrRpq645bjaDyOROBrDWxuUflWeDSYVGJWWj+QvTwh
 16xtfJXwUFdfaL0oRMX+KOI5491bFgCmxaeBnk/J3VehILqMINNgrDbiCZA2psHYJ9N1
 dIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205392; x=1739810192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sA34eSYtb2hei5cnm5DD6ciUagJHPxNVHOb6EHf0cBM=;
 b=WaqH2Jf6SJ+noj1MfQBGLa6akKQDk4b2fyZDMbXW8i6jm3rONzt4UNE5oOeNH887uu
 vB+vuhtmeryHizUcBD5o7mkhQFpQghQkItblNQTDZX9iPJzgvipACng7QYDFoPm6wYAa
 MqtZlYrIArr2Yw2+uysPdjPHSswd5Emt2djYHSPUBYA7qclRbyd5ifheGXV6yzbVHOi0
 Ry8W4nJMYTqIorIA60DaiHRUBeu1bvC0VTc/QT03NcmGCIDt+djCHj7CkFIJWoLkVyrU
 zwmOUOv+rtOhA7jHvvifxzQsjzlhHT+klxXoqw7MaMQi+BsqIe87CRZ3lUk7KVYslqlt
 nGpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuth40mm7Nc1YesZNwFuqVp/mGlBjP3DHOM4+Ph1Cj18rCZkcufekaBz45tt0W6vXOn0DrYkEUdhww@nongnu.org
X-Gm-Message-State: AOJu0YxqYx49Q5EMPt1ZD4okMPOTIcwWdTG5umIiRodyy5ouLvKfytOy
 OFY73gBHJe5T71FkoUZcuKVXG1N7zk+fXkeYv0rEDQwHrZdNoxVYO6y5RAothSr6edmB3wjC5NR
 x
X-Gm-Gg: ASbGncsWJ4zIfYBmitxL41ZSWHedYHZvsp7QiP6ou6N52N7JYUMgUTxm70VOxMFqUfH
 InatdldWnOzzAURv5/BUfoET7nGN/1u7w5GshnBaxoTrPYrl2WSC1axQF+CaFdFZd7x8AqJIViS
 OBI2yPSj8xEMZtdmmJf48yEo4se/ELcyEAXsz7i1N2mAb2YJVf2bXtN5SDE0Dc/lbjFwqxkZlB6
 GKIFVAU6AhLRlShsdkvdq7JDurvmXNyfCGsHwychgk+g0zEEBONSBuboT3ADg0VxbbsGjZva/dn
 jMsU3CFOgPcvkV7moSfkBQuTpeQAOq59BBGPz6ht4V4vdwL//4AuPzo=
X-Google-Smtp-Source: AGHT+IGKxMW+ufN7kk6wUWZvKpj2j8JBgKMRPwGbs4t/DXF9j1FwsYTc6w2qVWIR7jk0ltmVOSu5bg==
X-Received: by 2002:a05:6a20:9f8f:b0:1eb:4f1c:96b6 with SMTP id
 adf61e73a8af0-1ee03b06269mr27480531637.29.1739205392610; 
 Mon, 10 Feb 2025 08:36:32 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad54ff55b46sm2500774a12.64.2025.02.10.08.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:36:32 -0800 (PST)
Message-ID: <961b1262-6044-4021-82af-5af83cc1ce30@linaro.org>
Date: Mon, 10 Feb 2025 08:36:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] qom: Have class_base_init() take a const data
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qom/object.h     | 2 +-
>   hw/core/machine.c        | 2 +-
>   hw/core/qdev.c           | 2 +-
>   hw/pci/pci.c             | 2 +-
>   qom/object.c             | 2 +-
>   rust/qemu-api/src/qom.rs | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

