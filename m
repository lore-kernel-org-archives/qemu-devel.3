Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B12C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radmM-000696-G6; Thu, 15 Feb 2024 10:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radmL-00068T-8U
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:36:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radmJ-0002mu-MR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:36:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso608249f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708011358; x=1708616158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmJegsZZbC62SRmjMFtg6AwsWREQyOdJx3WRnV4HBfk=;
 b=pJnglQ3AqCvjo7nzdczYSK3c98aY5e50RBDEEJqsaVU+13dH9pEC7cEZJHPW9DEy2k
 4FJ0J4wBBlx9ZyBFssLxLmxA5ylBFtJLDJNQfe6Rgno3vu3DnKLlzFNjNVHpa3PpY7Yw
 /mj6LuC+q8t4zssGue61R4udD1B6iUsFgB+hvVIt6s6bxnvvE65wbdN4IUWHasmUcM+S
 lqgMZ9MZtZ9u9AxdTHnQKpwGNh4WRqXw5OemNSScZuY1kZdRKQb0xCQmExE89KFrqdJo
 HgYgjZ7I4b+rfZpSq3mOqkDf4PNIK0pFpZ+2APAmP9Zhu3bbZzH5xJgXAw5ensMBpoA0
 8SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708011358; x=1708616158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmJegsZZbC62SRmjMFtg6AwsWREQyOdJx3WRnV4HBfk=;
 b=sEQJ1EaiMx4JLP+goawPzhD2HO222DhpZFw0nmv8s08Hr01WbsuZqluK9z6TlunWCM
 lVjmkI+Br6LXs+V8ZRCgmWpRc5qCgKllYX00+GXPimIosuS31oG1GPSEdVgZTzS6W1Vd
 HVXbL1qJyybfkDBXyEu86sbathV6keo2hAiqxgg/tOw89MMasgdvjbFug2JCF/ukP38Q
 SX20HAueDZMhEfF5Ajpz+L2eJke7cxMPl/Dxnqv9fhZVL++9yTswRAvtXpdgMZ5JR9LO
 7QhMvVMeh9QzyJfPcVCsxaB8mIffUqeUOqzv/gHJzUBEsY1fZcEIWsPJs24SFTpKkm6+
 xSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuwBnXxMARHPozCd/ptdz4KrBhOGA9KT/YstPhPDscsF8RReBH7ek7VmcNv3NXZytl2QqUosM9PzJMSFfX5xNznij2RLo=
X-Gm-Message-State: AOJu0Yzxme7oF441NVg/iLCd16YCsV76W4DChiUo6Legx2wdHaoGYJQV
 a9vaTreXffzDdLYiVT+c1Vwwfei0VEeWZJtf0uhGnc0Qh3l+V6EIDExNCE+0zHM=
X-Google-Smtp-Source: AGHT+IEvxrrDOcJUEPsJjczTFwCAHcoFJzYym5fKT30yUx+Q+wKhdyNHztlxYfm6mB3bihdEe+V3cA==
X-Received: by 2002:a5d:4fc1:0:b0:33b:d225:3640 with SMTP id
 h1-20020a5d4fc1000000b0033bd2253640mr1688604wrw.59.1708011357968; 
 Thu, 15 Feb 2024 07:35:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 co16-20020a0560000a1000b0033d0fbaf5d2sm1394986wrb.27.2024.02.15.07.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:35:57 -0800 (PST)
Message-ID: <3cd6e296-80eb-4466-9cce-a01b8db9c189@linaro.org>
Date: Thu, 15 Feb 2024 16:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Simplify init since PCIe is always
 enabled
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
References: <20240215153311.186772-1-marcin.juszkiewicz@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215153311.186772-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/2/24 16:33, Marcin Juszkiewicz wrote:
> There is no point in checking do we have PCIe if first thing after check
> is adding PCIe card without checking.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


