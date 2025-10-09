Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1321ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tqX-0003VU-B7; Thu, 09 Oct 2025 12:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tqT-0003T6-RX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tqP-0005Jm-4E
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-793021f348fso1121141b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028617; x=1760633417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5qY8ajv3HEH8Vsg1klMI+O3dfzQOSkTVp4xxu2G3fgs=;
 b=KVE7KbhJvLbtB9jbwj6n87dERyR9DHpWxYzfa09xInpMV2gjX1gQDHLXScIvPnK3tB
 R0g/Yyw3DQh9h8PCS4ICIvyWnXyvaavBwk+YJZ8ZfLQaDTfiEjpqA6Vxv/lYUy+zqJcp
 7ItPNfeQUtR78SAiKCx/L0SdLM3qmBUMpatw0+JJyHEgFuTnIimI6O6id7FQYShwgdMU
 FOFpS8ZvjMXLt/unH4bZqEs6e/wSYDhTgrLO1B05jd1FsUi/KJk756h+VrhBp5e6Xjr5
 drqpQuor711GsLYf8AuxsW+p/PEeI8Tz+/fZStE8AyfqmsCuTCx4KeaC+xKkLWqi+DEQ
 LFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028617; x=1760633417;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qY8ajv3HEH8Vsg1klMI+O3dfzQOSkTVp4xxu2G3fgs=;
 b=YCCUX+caBzC09RJIDO1tOlCHp+8gBo+u24R7cnctWLQ/QmmvpO6nqefUauMMK44WEt
 aFRthUkPHsk4jjA8LPEVnOYrDDbBW4u0gI7dbMo5X7+pLmUPTuiVUmOWnmphFwPORsQX
 pA4hBd6mMs0Ym/WGIpl7VXmQSf1l2lckSrs43upgC+T6tcYlEkZD0lHRAIfYWz/fK5MG
 EXm8NBfun9GuLjY4ueweFI8OfoPByzqelueIlH27bqscE+7rXVJBfpanZ7m39kQwq2wQ
 uxxxw9JXQLytlCnfJr/2zqOhBayD2AfEuOFs+gAPIydxx+aSA2tu8GllHZNeMl0TWkn+
 Fytg==
X-Gm-Message-State: AOJu0YxG1p8KMtHa9vuDmt1aRMTB/q4naR9Rqp6nhOJgSz2a9IqW44HD
 hCNlmdtpJ7I+aVYfJjyDz3zGNqvBacTsSOhHVqKXLFUy4PLSZQuQZbBZOjsU/DnPTaEqDZ6/6Hs
 T10ZW+4U=
X-Gm-Gg: ASbGncuyCWhzkM1LMtlwg8be/k6C5yVbfTZ5hAeo/C2w/Wxtpnpbtf0oQDK//NzY7+Z
 CRxIQnbggTji4iVGzgM9YciavOImC5QZ5uf7A0QyI1/HRsy2S4903zokPuEkuwmH7MB1ec/QtuR
 XDNoBsqAw3Mo1rrCCC2QfwaoiwxsdeP+LR1+onBJp3T9pjAHZMTiAJ+FgEJDIF8xMkvviA1D5AJ
 GOk5OoFNPfvcsYc5Cp/Lmz+X1VMK5W5KMLW7/mHwxB+9oayn09sETbroo5VwUo1qULTStlcDqXf
 HtdNphwNcTZQgxlRMrajFtpBd03TjUOqJZvG11+ibup/lx9LbhKIFt60U+NIRAHjk55VE9ZEREb
 fJIrSZ5h2jlHvpvYse38EPWX1CwLEKGUHlvKg5iNFkRBL43nEmx6x8GJaaK8P/Qck
X-Google-Smtp-Source: AGHT+IEVsDh7c8te65IYZhBsIi+WRyB0zF5eVbKnc1lhCUM8ltjnkmQEvRBuXQv5jbJUkiXpaoDn3A==
X-Received: by 2002:a05:6a20:3d19:b0:32d:7f48:4aa7 with SMTP id
 adf61e73a8af0-32da850e806mr10355951637.60.1760028616838; 
 Thu, 09 Oct 2025 09:50:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e2774sm198300b3a.63.2025.10.09.09.50.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:50:16 -0700 (PDT)
Message-ID: <44c5909e-8c88-460b-a51d-54b3420106b4@linaro.org>
Date: Thu, 9 Oct 2025 09:50:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/openrisc: Remove 'TARGET_LONG_BITS != 32'
 dead code
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 10/9/25 01:19, Philippe Mathieu-Daudé wrote:
> The OpenRISC targets are only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Remove the dead code guarded within TARGET_LONG_BITS != 32.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 33 ++++-----------------------------
>   1 file changed, 4 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

