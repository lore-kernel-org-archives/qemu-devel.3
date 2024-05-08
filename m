Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A694C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4odi-0003hT-Mx; Wed, 08 May 2024 17:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4odZ-0003fK-RM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:15:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4odY-0007MI-4s
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:15:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso1218185e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715202938; x=1715807738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h81ThyKzsMj5wiSCI8oYLFnxNShHFv5LGKSuf+enptU=;
 b=HD+w1vobUZ+BGYn9vpnq6LaW1BvgRdzlFa/yP4BNb9XE7SqokW5P8d8GKskJuErIt/
 YHQ3X2VPsrdK9lk0qCEEu0KupC09i/ZomNcAJjge6Rck8uEImctwl5lco9R1I0QAwo3I
 1wqAquRJ/1VVWZE3K+bQPthDxy6GYhpPQCLd/jwBtL1iuT8tiNNyNNYWRHs/iokasq8d
 eMHR3OLiPRZEyBAEldBV1rzRjgR5Sk2HNINP0hfrx+LDnZ95GDHYS3PDZm2BZhAeu4JU
 moNJ/YepGBU1+sqUI3yjcCJOJ0G6BWfUZado28yIQfvjImLQrhTq5z30rmAogh2JLals
 4Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715202938; x=1715807738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h81ThyKzsMj5wiSCI8oYLFnxNShHFv5LGKSuf+enptU=;
 b=BKS4N3aY0UbjoSMPXEWsy7N7NUsvOilvI7rISN1/CXO6VYm+iMh1fCaOjWo3HuaFjV
 IaY8P1MRiKkudj50XQEKaOhWt8eIMmugwAQz/dWR3fKzg35ezRFMDEKV+SVYmbZwByCC
 89rsA7gvNv64sKjhr1p8gz5VbEfl7Hs8BnYrQWJjll305qDeRvZ0g3JAqmTItIzul62G
 Xiqn/+c0FZJbbHU7tN5rwkiul0F6Ulm8kmbfJre/H9w3U/qbtwAx8k0rWs90UDkZ+JLG
 czx7fywr4EtQIRg5KxXBvzzM3Qhh7kFtkihdW8jnSyveT1yXu04b0rQgUrpYHJ7Iw3dv
 kKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxPGMPkPtKU904Bq8/xY9nDVV2WZQg6guNn49bVXavnxVWn8TiWfq2DHY02BQ5I+9lH0/PCRls3jb1nis+H0R9PxtwQjU=
X-Gm-Message-State: AOJu0YwkMGqe5Dl2JTw2qEynStpJ5cxZLU4jPZba85r4UmYQ+xP8GO0h
 WnHHYXuwvd8HIOXkG7yROJxznAByfUBVveDluSqsF+bz9UmZAkPiskjlTRsebs4=
X-Google-Smtp-Source: AGHT+IEm1lTj2KjBxtLQK08SkhJ73iDSIJNWHzXRrz58YE0RX0k+ffAPxGn4U8E+BzO3MlKo8SgyCg==
X-Received: by 2002:a05:600c:45cb:b0:419:f533:ef88 with SMTP id
 5b1f17b1804b1-41fbcc619b1mr5989475e9.11.1715202937794; 
 Wed, 08 May 2024 14:15:37 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41faedf5dcesm5957485e9.0.2024.05.08.14.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:15:37 -0700 (PDT)
Message-ID: <e656e115-e29d-474b-a58d-65e741058ed8@linaro.org>
Date: Wed, 8 May 2024 23:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch64: move memory map to boot.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507145135.270803-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507145135.270803-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/5/24 16:51, Paolo Bonzini wrote:
> Ensure that it can be used even if virt.c is not included in the build, as
> is the case for --without-default-devices.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/loongarch/boot.h | 10 ++++++++++
>   include/hw/loongarch/virt.h | 10 ----------
>   hw/loongarch/boot.c         |  3 +++
>   hw/loongarch/virt.c         |  3 ---
>   .gitlab-ci.d/buildtest.yml  |  2 +-
>   5 files changed, 14 insertions(+), 14 deletions(-)

Thanks, patch queued to hw-misc tree.

