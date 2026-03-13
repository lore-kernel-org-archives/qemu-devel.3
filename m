Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A89D107BCCD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Xe-00029q-BK; Fri, 13 Mar 2026 12:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15XM-00025W-6q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15XI-0001qw-V0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:54 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c73a12af63cso1444570a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419931; x=1774024731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5bvPUu6P+W6/LyS0l76jt3lO8ulis5rGmGo/UbrwQg=;
 b=XQgx8djo92NyqktNdkGxyyIInFQCEUEbYIC/IIoYY0JmHn6eXLZXUHJFr7gfJ2vqnd
 +f0tBzFoAt/PnufhtA5ftXH7ZR9NlVJe04J+TUeyYRxdFKF9b9fcbpT9py3dQvSqKVUf
 ZmO2/ozElIV4UDsbmfbU2pmYVshg7iOHJzyMAeZ87rSwg4Zqwa3yTEfWD0fhIgPrXxzI
 k6Hwtlf3i4j8LHX2DDVL9cHFxRRk+hYGsY5Ri9CYfpKqtOUu7QfF2xfbrQjg8M7Gj63M
 aD1e+Nv0InI2jWs/tzLWcf4upOt9cviOM1wIdjyomWNsmqhsJYsloN5A9RutwOOWLQFU
 kKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419931; x=1774024731;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e5bvPUu6P+W6/LyS0l76jt3lO8ulis5rGmGo/UbrwQg=;
 b=Avv1JFBUVXqphBcVbQpMq4+iNSZ/RX66O05VutZWsw1i+Hr36T3kIGy+7KGclFK7+4
 yl+dhMFe0FsRbxSWGnDWMjNic50RLQ4pIUkEQc4xZIqhYx0swbux3Zx8pFq+p4U3eY0u
 oTWgPGS8/ISq0VIj5XineSuIZei4++Rz86yGYKKshBHI4M59TBfcHUjCxWG4W5/G1pGQ
 0otl1R6ruoOZqiONTDQg0+rId3NgkWVl9UfxMoLp9VSKF0MnpFK8MqGJakTh+1Jv0HAD
 E/dW+e/VmDTIqBgsNBzKILmxRtYGxZwWlG2jnJCGv+Ji4FR0uX5H+1mYQbu3uKGbqpiq
 jnOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZDLIZbKjhvoI2IX7/F2id5/n/BqruNySzJ25nNzheQCJSAKk53aaU6nqSGeUJbDdj+EoAY9+y2Adb@nongnu.org
X-Gm-Message-State: AOJu0YwQzlD2yay9log9REKOAfcQZY+2GDj7xVKB1o166HwK4aWQFEjL
 9/7bB9l4RfPlxqdgjLZ5YsDV4XYGG/Rd2RvLJtqXibyvXetEwlU1JOljQfoughyqjMA=
X-Gm-Gg: ATEYQzyUW4TZYk+07obK+oXxPtHcEjAxv5GhtsT8P5+sfrzm0mfgChtxzpM1F5ZwUx8
 7by+WrEHikbcErw4+/Sfs2yRhlukebS2+nB4FzAXlwEL39nd1YFcs4xIB/FdTM8A2uj9mhcn/LZ
 xDHGSDQeeQ7HlEf8T32BM7EESC42wWK9SYS/vSZfv+MNXbDsDoml2KxwfGPdtjJLTAgvpMt4sEh
 rlX4TQiHAty6RGyTgCkOYDWfQmFYi2fzAZrirs+AtczDDj5XxCcn1Mk6qfiDE2BN/kZFvZr4SZp
 ZdkWJW6ErJHcnDxUyUdZCEUrwgA7jiYAfQJdzXfcC4irYb7b2LxqSuSS5QlNNbyHYBOm/pdSDMO
 Evfl8UXVbs9eOmEb8kWacTQsXcXPJ5SYnNv8g03N99LKEG8nNNCCisOfh9fK5p/2IQtNf72z3Bb
 lbYGmawYT7kd1ZFnaItfhXH3TBAeVd/mawvkJOc5nnLW0ioeC1Si9txMMA/5FQEug0+DVv
X-Received: by 2002:a17:903:2f8c:b0:2ae:4c9f:4a63 with SMTP id
 d9443c01a7336-2aecaa382ffmr39689735ad.18.1773419931277; 
 Fri, 13 Mar 2026 09:38:51 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece62c581sm37155345ad.33.2026.03.13.09.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:38:50 -0700 (PDT)
Message-ID: <56d6f102-fa55-4008-9b15-01c05e0f8859@linaro.org>
Date: Fri, 13 Mar 2026 09:38:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/38] target/cpu: Do not include 'exec/cpu-defs.h'
 anymore
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Nothing in all our target "cpu.h" directly uses definitions
> from "exec/cpu-defs.h": no need to include it there. This
> remove a lot of target-specificities, simplifying inclusion
> of target "cpu.h" by common code.
> 
> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/cpu.h      | 1 -
>   target/arm/cpu.h        | 1 -
>   target/avr/cpu.h        | 1 -
>   target/hexagon/cpu.h    | 1 -
>   target/hppa/cpu.h       | 1 -
>   target/i386/cpu.h       | 1 -
>   target/loongarch/cpu.h  | 1 -
>   target/m68k/cpu.h       | 1 -
>   target/microblaze/cpu.h | 1 -
>   target/mips/cpu.h       | 1 -
>   target/or1k/cpu.h       | 1 -
>   target/ppc/cpu.h        | 1 -
>   target/riscv/cpu.h      | 1 -
>   target/rx/cpu.h         | 1 -
>   target/s390x/cpu.h      | 1 -
>   target/sh4/cpu.h        | 1 -
>   target/sparc/cpu.h      | 1 -
>   target/tricore/cpu.h    | 1 -
>   18 files changed, 18 deletions(-)
> 

Great!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

