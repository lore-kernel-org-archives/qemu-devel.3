Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE8FC3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 00:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZgM8-0006VT-Us; Thu, 01 Aug 2024 20:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZgM8-0006V0-4W
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 20:41:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZgM6-0007Gu-EA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 20:41:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so56309755ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 17:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722559273; x=1723164073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T7wAUaMp/ucYXleqI+9l13fRaFch+BLy98S4UCEMtls=;
 b=ZvtzMivBl18ufj2iNme0zNdlE/3ZBvDPl15QjgZ38nOkPYOsIX4PrWQMhGtV4WZH1m
 c0qgrMtBAJvOfaRI4iPDqf9C3yWo2N1LkisdPBqZrVOkczYn5XeN/o2jr4mjQ+Ua5UpD
 jg1dLM4tuJb9xj+Nk/7zcT5xITxS4Q4EA0aD4ndzivF0L8p7XmwhBfHzbEQrUM4TqWOT
 bzRU8JY5SUTGVbZOlYT80wNFgk8QUeUS7Fm+0Wx3HeJGvZ3RDuB16RRNrYkl7qMETGwe
 HuXsZL06rVGws7zCjwZ45Ykgqi87+U0W5+NhNPBJAXnljUaamY24rS5lwm8N9Jenn19T
 k0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722559273; x=1723164073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7wAUaMp/ucYXleqI+9l13fRaFch+BLy98S4UCEMtls=;
 b=RnSJV0YzGJKE9wgMASGjcpX+IAAh0PhpeMoVXyyKRMJi+oz6Mo9u+y7nG0yTak6UVj
 S7s5agORFXfuBVwKHKewvr/eTWWkEj5LAwAug6huRG1KNy/yhemTosV0mpCKm2KpT8+/
 h/d7ZIVKR2el8+5zL8xP3WsDfRduCXLO33lBfyEyiWnYnD3IeiuV8Nk3dhrckjQAsuxu
 43LG7YtFCrIMP5FxmfKNKh4Va/xQxzii4JchwIEBkKCb0i7AEvVbYxeR3jrc7Sb+SnY/
 iOKB3i0EzDm8S0n/6dLXorYx984ILWvmuYcNc4xEdC5nDzOoCUvkhk9s4I0J7GPxHHaL
 FUkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq5c66qpv8NZiY2zNiy7EM+y0q7ezwEr8tUg0rxxLb5OTeU9h3/8C8v3Ccx07+ZYlUQ5LIQnqn+DjmzPEoJPzYpDTynnU=
X-Gm-Message-State: AOJu0YyMMR17kARrG16n5cLhuaoVxXshZcpvvu60+eZr6QKQjRTgGSHd
 miR6pinKKsDj/Rj4zuylwe8OckW7ieWp6+l8VXkZCHCtRJbi/sCs/UnZsud4DnexCapNPAgbNpS
 pfcjncw==
X-Google-Smtp-Source: AGHT+IE02e91XPi/Co62+rqz0jFnBbppEd1uJImGm2wThcfj0zA5UDyfLwua9QbrVb4+mbtV2GBqDQ==
X-Received: by 2002:a17:903:41c8:b0:1fd:cda0:2f4c with SMTP id
 d9443c01a7336-1ff572a35e0mr22749475ad.18.1722559272458; 
 Thu, 01 Aug 2024 17:41:12 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5928ff1esm4944085ad.237.2024.08.01.17.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 17:41:11 -0700 (PDT)
Message-ID: <ecedb1a4-919c-492a-a775-f2c74d1d82c3@linaro.org>
Date: Fri, 2 Aug 2024 10:41:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240801142322.3948866-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/2/24 00:23, Peter Maydell wrote:
> Just 4 bug fixes here...
> 
> thanks
> -- PMM
> 
> The following changes since commit e9d2db818ff934afb366aea566d0b33acf7bced1:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2024-08-01 07:31:49 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240801
> 
> for you to fetch changes up to 5e8e4f098d872818aa9a138a171200068b81c8d1:
> 
>    target/xtensa: Correct assert condition in handle_interrupt() (2024-08-01 10:59:01 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/arm/mps2-tz.c: fix RX/TX interrupts order
>   * accel/kvm/kvm-all: Fixes the missing break in vCPU unpark logic
>   * target/arm: Handle denormals correctly for FMOPA (widening)
>   * target/xtensa: Correct assert condition in handle_interrupt()

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

