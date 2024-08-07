Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A88C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbeKU-0000Lj-5t; Wed, 07 Aug 2024 06:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeKS-0000JG-0k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:55:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeKQ-0004Ji-CW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:55:39 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7b80afeb099so1059233a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723028137; x=1723632937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzhLL0C7UkKoznZcTBg2xY600c8bfA8tZHpDsh0U4D8=;
 b=tRDpwKyb/oEFrb7oGwV/9xAbA9GQl85iDObPjLR5nQWzRKsmcl55I7YAKMtnpS6fae
 SPWNaHgeJPaEE0yUVEN5kTmNWBwt9rF5aPj5lIdgPGNzBrJAKmiDwhhmYDtfs7JiUj87
 C/N8Y44KEdjkFil8FpKwwmjTNuZcdoXzFBiMcN3IMxUnG0aV+DAvwTdAP0elfqFspFqp
 brx2S7NA434ZzPPJwJbiS72L6u4glJk9d/EbJ48trPUV/4HwNhVcc3WlDg92qQBEsOCf
 KIVhV+47rrq5Cfw+S3Jxi2iDqV2LQnbi0GcGAA6994wiai8SjLb8VSlx8/TcEH0BOrtw
 Ecpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723028137; x=1723632937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzhLL0C7UkKoznZcTBg2xY600c8bfA8tZHpDsh0U4D8=;
 b=W01mP6sYKDrghQm5Fw+r8B+NJlC4twcPGWkZw9Ub52t3Z4/sYVom02j+s8G0c0VnFn
 tzWfqUN6Ty+KZ49et0GjWovDdxOhGimGUvgjo7OlIkH0D7cGy/tfGGorfzZlYu6DrCYI
 EpTXxG7EkQOy2+hvHYNd6GgjE7t+yWXFCAe485O4Rxf8A18+hUFYdMvZsQ3avwZp/kuf
 DoA03EYzS/V8PWwPwHyQbeAzJOanES89EKCvsDAc8L4rUDqRZdZPCOildo9xgK+cQUSH
 9inzzqgd+wIQRvEv+sfzIoIZa1lcJ7fdK1GmFBwZk7sWh3Jz07109aH1pPiFDIE6YJ6R
 qnVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1XErZBfX4oqntU3aQO0JWqUljof3ZOv/HA1SBpRcKXp1VmZvQNwCZbfdf5sXtwcUxbBxOnnFVhAegvcWhF5ndlmXucvM=
X-Gm-Message-State: AOJu0YxWAa9UGOZWqXNFhrVwevpfhdF9LYJQobg5GykM2EmBRAuRBYWG
 sYTluAlYTML6RPvOIhv0BMgaVZWqwOK50M1etAX0V1xwIAhp2IryakPXq2tjCPM=
X-Google-Smtp-Source: AGHT+IE4z6PPKXnxwOlKWIJ8A74LaX/kXFSZPZYzVjM+gIjZhKxzd18ajA5kmVMUe9BibvmiM9NUGw==
X-Received: by 2002:a17:90b:19d0:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2cff9544afamr17561722a91.38.1723028136470; 
 Wed, 07 Aug 2024 03:55:36 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:eb61:b5f7:86fb:b626?
 (2403-580a-f89b-0-eb61-b5f7-86fb-b626.ip6.aussiebb.net.
 [2403:580a:f89b:0:eb61:b5f7:86fb:b626])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b374b3c3sm1239920a91.53.2024.08.07.03.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 03:55:36 -0700 (PDT)
Message-ID: <47d9b786-870c-4a0b-bc8c-1fa09d3c2113@linaro.org>
Date: Wed, 7 Aug 2024 20:55:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user: Add strace for sendto()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>
References: <20240807083508.28134-1-philmd@linaro.org>
 <20240807083508.28134-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807083508.28134-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/7/24 18:35, Philippe Mathieu-Daudé wrote:
> +#ifdef TARGET_NR_sendto
> +static void
> +print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_sockfd(arg0, 0);
> +    print_buf(arg1, arg2, 0);

You still need to log arg2.


r~

