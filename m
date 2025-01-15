Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432ABC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvg6-0000F8-RN; Wed, 15 Jan 2025 00:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvfy-00007u-99
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:10:47 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvfw-0005wE-MP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:10:46 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso10411048a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736917842; x=1737522642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//VrB4zJd9aUiRW+vUicw7ZWZY0yMB533KMoj8ozztM=;
 b=G6i3/J5rURNDXT7vmdxvONHHt3hd1tv9FBoTqQv4vK5FnrXDL8Nto9680YAU96kxer
 YknSiqv6nrxHqTIo0okWep3CCDgmNEHXfuJnm+2VJqShJvDFn+q/+F4WUTBW6Fbsjps+
 yYN7FDFnOnVay9fasWsl0VFMQsEDQQiM/3p3a8WgqQQb877UOB0gIY3a9dPrSaq9RxKS
 NhVSzZBxeNvoYAST5fBy5kejZhtxQ/B/hjM9/wun4JVqCcZqEQJnHOoFtixNSLVmi71f
 P9vZrsjBIdaKlrA4gkRs6YfF3zrsDpl0xiNVuYq4gSdj6NH2BdEKShzYezwYz2aLE87T
 UDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736917842; x=1737522642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//VrB4zJd9aUiRW+vUicw7ZWZY0yMB533KMoj8ozztM=;
 b=pncK7VTj0Ted3daDJxMtzuiVY6/cp0mF+d4njSQ0xGRqhqYmr6LBeLMPm9F8oc2y7E
 kzn6EM00wX2k35NEBH7lRUM/GGEMc8vE+JXQy2Ljx9v3F7I7oOAqEIr6V7PCj0xfPv0n
 DVSosBEWAheo5RXi+BoY0Umj+QDSROb3jzalmPldYWV19jtc15hSNhr7cJIuJxuN/UB3
 2AlEJNS1P7yPXXMAVQwYmRa1AJJPCuE+L2tQd014PtkP+NVtde9Knbraud0fX3ezEiRS
 7/Yfr8pgkp5hM0zl4NBQRDJyNU2S8vuhwO2TuqQWSaXxFPcjYlOG44zDZGPEGEjglMKg
 G/Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBA7Lk1M+P/unXnqQ/6exFbQXOwwPevXgLHCP3QNBqhUaq5vxnRiZPEtX9RGk+qwiGuQ0H5VyQsWs9@nongnu.org
X-Gm-Message-State: AOJu0Yzlj8Bq6tT+8xegpTabptMF4NkjaFJztl56OLJkifjxJf72/xJ3
 +0/ozGieKqb2VHcp9GmF6w8b/wRe9frbXcpz1cRi5/u6RYPkA1Ihv+JMuhLDltb/t4nHUINdfGX
 Z
X-Gm-Gg: ASbGncvnhrNnrku/QoRXply2CFQ6LpP0pSOyov4BHzcRnPEtKsCadE1blxTJHDtSOsn
 L5sRMPz3HUVHHmLCTrglwX5vnFE8zKU4qOKAMuihXAfHc6T8BE4epFGng9S63g16LppceRctefS
 P+g5i4zjF18Ge4UhfsLUMnBt9nXX0CVTGd8vGeE44E0IYGae2rLxLZj7tnQIgsmQE+rt23CPo/d
 B8mZas0tHIxeLoqSYirjYYkWtdDaQa8JXCFPgFd9Ru/FdLM+wAqHiumAH58pA8iuo77ZxjUIZpJ
 Hd3iRuuPZfZkRq+GcVEexks=
X-Google-Smtp-Source: AGHT+IH9WldblqlzqQE9FUX5zaclyJgHnhphQsqAlb2yqgo4d1EyfukvRlXiwWerwDBWli2AUCXQnA==
X-Received: by 2002:a17:90b:4c88:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-2f548f2a01emr42154066a91.9.1736917842581; 
 Tue, 14 Jan 2025 21:10:42 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10f860sm74768605ad.46.2025.01.14.21.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:10:42 -0800 (PST)
Message-ID: <1a408a70-5b8b-436f-8baf-1638ead8a34e@linaro.org>
Date: Tue, 14 Jan 2025 21:10:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] hw/mips/loongson3_bootp: Include missing headers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> MemMapEntry is declared in "exec/hwaddr.h", cpu_to_le32() in
> "qemu/bswap.h". These headers are indirectly included via "cpu.h".
> Include them explicitly in order to avoid when removing "cpu.h":
> 
>    In file included from ../../hw/mips/loongson3_bootp.c:27:
>    hw/mips/loongson3_bootp.h:234:14: error: unknown type name 'MemMapEntry'
>      234 | extern const MemMapEntry virt_memmap[];
>          |              ^
>    hw/mips/loongson3_bootp.c:33:18: error: call to undeclared function 'cpu_to_le32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       33 |     c->cputype = cpu_to_le32(Loongson_3A);
>          |                  ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_bootp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
> index b97b81903b7..712439c2575 100644
> --- a/hw/mips/loongson3_bootp.c
> +++ b/hw/mips/loongson3_bootp.c
> @@ -21,6 +21,8 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qemu/cutils.h"
> +#include "qemu/bswap.h"
> +#include "exec/hwaddr.h"
>   #include "cpu.h"
>   #include "hw/boards.h"
>   #include "hw/mips/loongson3_bootp.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

